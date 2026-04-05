import 'package:flutter/foundation.dart';
import '../models/transaction.dart';
import '../database/storage_helper.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> _transactions = [];
  bool _isLoading = false;
  String? _error;

  List<Transaction> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Financial summary getters
  double get totalIncome {
    return _transactions
        .where((t) => t.type == 'income')
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get totalExpense {
    return _transactions
        .where((t) => t.type == 'expense')
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get balance => totalIncome - totalExpense;

  // Get transactions by type
  List<Transaction> get incomeTransactions =>
      _transactions.where((t) => t.type == 'income').toList();

  List<Transaction> get expenseTransactions =>
      _transactions.where((t) => t.type == 'expense').toList();

  // Get transactions for current month
  List<Transaction> get currentMonthTransactions {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
    
    return _transactions.where((t) {
      return t.date.isAfter(startOfMonth) && t.date.isBefore(endOfMonth);
    }).toList();
  }

  // Get spending by category
  Map<String, double> get spendingByCategory {
    final Map<String, double> categoryTotals = {};
    
    for (var transaction in expenseTransactions) {
      categoryTotals[transaction.category] = 
          (categoryTotals[transaction.category] ?? 0) + transaction.amount;
    }
    
    return categoryTotals;
  }

  // Get top spending category
  String? get topSpendingCategory {
    if (spendingByCategory.isEmpty) return null;
    
    return spendingByCategory.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  // Load all transactions
  Future<void> loadTransactions() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _transactions = await StorageHelper.instance.getAllTransactions();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add transaction
  Future<void> addTransaction(Transaction transaction) async {
    try {
      final id = await StorageHelper.instance.createTransaction(transaction);
      final newTransaction = transaction.copyWith(id: id);
      _transactions.insert(0, newTransaction);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // Update transaction
  Future<void> updateTransaction(Transaction transaction) async {
    try {
      await StorageHelper.instance.updateTransaction(transaction);
      final index = _transactions.indexWhere((t) => t.id == transaction.id);
      if (index != -1) {
        _transactions[index] = transaction;
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // Delete transaction
  Future<void> deleteTransaction(int id) async {
    try {
      await StorageHelper.instance.deleteTransaction(id);
      _transactions.removeWhere((t) => t.id == id);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // Get transactions by date range
  Future<List<Transaction>> getTransactionsByDateRange(
      DateTime start, DateTime end) async {
    try {
      return await StorageHelper.instance
          .getTransactionsByDateRange(start, end);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return [];
    }
  }

  // Get weekly comparison
  Map<String, double> getWeeklyComparison() {
    final now = DateTime.now();
    final thisWeekStart = now.subtract(Duration(days: now.weekday - 1));
    final lastWeekStart = thisWeekStart.subtract(const Duration(days: 7));
    final lastWeekEnd = thisWeekStart.subtract(const Duration(days: 1));

    double thisWeekExpense = 0;
    double lastWeekExpense = 0;

    for (var transaction in expenseTransactions) {
      if (transaction.date.isAfter(thisWeekStart)) {
        thisWeekExpense += transaction.amount;
      } else if (transaction.date.isAfter(lastWeekStart) &&
          transaction.date.isBefore(lastWeekEnd)) {
        lastWeekExpense += transaction.amount;
      }
    }

    return {
      'thisWeek': thisWeekExpense,
      'lastWeek': lastWeekExpense,
    };
  }
}

// Made with Bob
