import 'package:flutter/foundation.dart';
import '../models/savings_goal.dart';
import '../database/storage_helper.dart';

class SavingsGoalProvider with ChangeNotifier {
  List<SavingsGoal> _goals = [];
  bool _isLoading = false;
  String? _error;

  List<SavingsGoal> get goals => _goals;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Get active goals
  List<SavingsGoal> get activeGoals =>
      _goals.where((g) => !g.isCompleted).toList();

  // Get completed goals
  List<SavingsGoal> get completedGoals =>
      _goals.where((g) => g.isCompleted).toList();

  // Get total saved amount
  double get totalSaved =>
      _goals.fold(0.0, (sum, goal) => sum + goal.currentAmount);

  // Get total target amount
  double get totalTarget =>
      _goals.fold(0.0, (sum, goal) => sum + goal.targetAmount);

  // Get overall progress
  double get overallProgress {
    if (totalTarget == 0) return 0;
    return totalSaved / totalTarget;
  }

  // Load all goals
  Future<void> loadGoals() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _goals = await StorageHelper.instance.getAllSavingsGoals();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add goal
  Future<void> addGoal(SavingsGoal goal) async {
    try {
      final id = await StorageHelper.instance.createSavingsGoal(goal);
      final newGoal = goal.copyWith(id: id);
      _goals.add(newGoal);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // Update goal
  Future<void> updateGoal(SavingsGoal goal) async {
    try {
      await StorageHelper.instance.updateSavingsGoal(goal);
      final index = _goals.indexWhere((g) => g.id == goal.id);
      if (index != -1) {
        _goals[index] = goal;
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // Delete goal
  Future<void> deleteGoal(int id) async {
    try {
      await StorageHelper.instance.deleteSavingsGoal(id);
      _goals.removeWhere((g) => g.id == id);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // Add amount to goal
  Future<void> addAmountToGoal(int goalId, double amount) async {
    try {
      final goal = _goals.firstWhere((g) => g.id == goalId);
      final updatedGoal = goal.copyWith(
        currentAmount: goal.currentAmount + amount,
      );
      await updateGoal(updatedGoal);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }
}

// Made with Bob
