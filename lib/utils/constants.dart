import 'package:flutter/material.dart';

// App Colors
class AppColors {
  static const Color primary = Color(0xFF6C63FF);
  static const Color secondary = Color(0xFF4CAF50);
  static const Color accent = Color(0xFFFF6B6B);
  static const Color background = Color(0xFFF5F7FA);
  static const Color cardBackground = Colors.white;
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);
  static const Color income = Color(0xFF4CAF50);
  static const Color expense = Color(0xFFFF6B6B);
  static const Color border = Color(0xFFE0E0E0);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFA726);
  static const Color error = Color(0xFFEF5350);
}

// Transaction Categories
class TransactionCategories {
  static const List<String> expenseCategories = [
    'Food & Dining',
    'Shopping',
    'Transportation',
    'Entertainment',
    'Bills & Utilities',
    'Healthcare',
    'Education',
    'Travel',
    'Groceries',
    'Other',
  ];

  static const List<String> incomeCategories = [
    'Salary',
    'Freelance',
    'Business',
    'Investment',
    'Gift',
    'Bonus',
    'Other',
  ];

  static IconData getCategoryIcon(String category) {
    switch (category) {
      case 'Food & Dining':
        return Icons.restaurant;
      case 'Shopping':
        return Icons.shopping_bag;
      case 'Transportation':
        return Icons.directions_car;
      case 'Entertainment':
        return Icons.movie;
      case 'Bills & Utilities':
        return Icons.receipt;
      case 'Healthcare':
        return Icons.local_hospital;
      case 'Education':
        return Icons.school;
      case 'Travel':
        return Icons.flight;
      case 'Groceries':
        return Icons.shopping_cart;
      case 'Salary':
        return Icons.account_balance_wallet;
      case 'Freelance':
        return Icons.work;
      case 'Business':
        return Icons.business;
      case 'Investment':
        return Icons.trending_up;
      case 'Gift':
        return Icons.card_giftcard;
      case 'Bonus':
        return Icons.star;
      default:
        return Icons.category;
    }
  }

  static Color getCategoryColor(String category) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
      Colors.amber,
      Colors.cyan,
    ];
    return colors[category.hashCode % colors.length];
  }
}

// App Strings
class AppStrings {
  static const String appName = 'Finance Tracker';
  static const String home = 'Home';
  static const String transactions = 'Transactions';
  static const String goals = 'Goals';
  static const String insights = 'Insights';
  static const String addTransaction = 'Add Transaction';
  static const String editTransaction = 'Edit Transaction';
  static const String deleteTransaction = 'Delete Transaction';
  static const String income = 'Income';
  static const String expense = 'Expense';
  static const String amount = 'Amount';
  static const String category = 'Category';
  static const String date = 'Date';
  static const String notes = 'Notes';
  static const String save = 'Save';
  static const String cancel = 'Cancel';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String noTransactions = 'No transactions yet';
  static const String noGoals = 'No savings goals yet';
  static const String addGoal = 'Add Goal';
  static const String goalName = 'Goal Name';
  static const String targetAmount = 'Target Amount';
  static const String currentAmount = 'Current Amount';
  static const String startDate = 'Start Date';
  static const String targetDate = 'Target Date';
  static const String description = 'Description';
}

// Date Formats
class DateFormats {
  static const String displayDate = 'MMM dd, yyyy';
  static const String displayDateTime = 'MMM dd, yyyy hh:mm a';
  static const String monthYear = 'MMMM yyyy';
  static const String shortDate = 'dd/MM/yyyy';
}

// Made with Bob
