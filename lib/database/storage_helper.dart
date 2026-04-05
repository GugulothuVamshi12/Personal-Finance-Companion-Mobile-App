import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction.dart';
import '../models/savings_goal.dart';

class StorageHelper {
  static final StorageHelper instance = StorageHelper._init();
  static const String _transactionsKey = 'transactions';
  static const String _goalsKey = 'savings_goals';
  static const String _transactionIdKey = 'transaction_id_counter';
  static const String _goalIdKey = 'goal_id_counter';

  StorageHelper._init();

  // Transaction CRUD operations
  Future<int> createTransaction(Transaction transaction) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Get current ID counter
    int id = prefs.getInt(_transactionIdKey) ?? 1;
    
    // Get existing transactions
    List<Transaction> transactions = await getAllTransactions();
    
    // Add new transaction with ID
    final newTransaction = transaction.copyWith(id: id);
    transactions.insert(0, newTransaction);
    
    // Save back
    await _saveTransactions(transactions);
    
    // Increment counter
    await prefs.setInt(_transactionIdKey, id + 1);
    
    return id;
  }

  Future<List<Transaction>> getAllTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_transactionsKey);
    
    if (jsonString == null) return [];
    
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Transaction.fromMap(json)).toList();
  }

  Future<Transaction?> getTransaction(int id) async {
    final transactions = await getAllTransactions();
    try {
      return transactions.firstWhere((t) => t.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<int> updateTransaction(Transaction transaction) async {
    final transactions = await getAllTransactions();
    final index = transactions.indexWhere((t) => t.id == transaction.id);
    
    if (index != -1) {
      transactions[index] = transaction;
      await _saveTransactions(transactions);
      return 1;
    }
    return 0;
  }

  Future<int> deleteTransaction(int id) async {
    final transactions = await getAllTransactions();
    transactions.removeWhere((t) => t.id == id);
    await _saveTransactions(transactions);
    return 1;
  }

  Future<List<Transaction>> getTransactionsByDateRange(
      DateTime start, DateTime end) async {
    final transactions = await getAllTransactions();
    return transactions.where((t) {
      return t.date.isAfter(start) && t.date.isBefore(end);
    }).toList();
  }

  Future<List<Transaction>> getTransactionsByType(String type) async {
    final transactions = await getAllTransactions();
    return transactions.where((t) => t.type == type).toList();
  }

  Future<void> _saveTransactions(List<Transaction> transactions) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = transactions.map((t) => t.toMap()).toList();
    await prefs.setString(_transactionsKey, json.encode(jsonList));
  }

  // Savings Goal CRUD operations
  Future<int> createSavingsGoal(SavingsGoal goal) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Get current ID counter
    int id = prefs.getInt(_goalIdKey) ?? 1;
    
    // Get existing goals
    List<SavingsGoal> goals = await getAllSavingsGoals();
    
    // Add new goal with ID
    final newGoal = goal.copyWith(id: id);
    goals.add(newGoal);
    
    // Save back
    await _saveGoals(goals);
    
    // Increment counter
    await prefs.setInt(_goalIdKey, id + 1);
    
    return id;
  }

  Future<List<SavingsGoal>> getAllSavingsGoals() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_goalsKey);
    
    if (jsonString == null) return [];
    
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => SavingsGoal.fromMap(json)).toList();
  }

  Future<SavingsGoal?> getSavingsGoal(int id) async {
    final goals = await getAllSavingsGoals();
    try {
      return goals.firstWhere((g) => g.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<int> updateSavingsGoal(SavingsGoal goal) async {
    final goals = await getAllSavingsGoals();
    final index = goals.indexWhere((g) => g.id == goal.id);
    
    if (index != -1) {
      goals[index] = goal;
      await _saveGoals(goals);
      return 1;
    }
    return 0;
  }

  Future<int> deleteSavingsGoal(int id) async {
    final goals = await getAllSavingsGoals();
    goals.removeWhere((g) => g.id == id);
    await _saveGoals(goals);
    return 1;
  }

  Future<void> _saveGoals(List<SavingsGoal> goals) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = goals.map((g) => g.toMap()).toList();
    await prefs.setString(_goalsKey, json.encode(jsonList));
  }

  Future close() async {
    // No-op for SharedPreferences
  }
}

// Made with Bob
