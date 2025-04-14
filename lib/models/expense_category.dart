enum ExpenseCategory { food, drink, transport, entertainment, health, clothes, other }

extension ExpenseCategoryExtension on ExpenseCategory {
  String get name {
    switch (this) {
      case ExpenseCategory.food:
        return 'Food';
      case ExpenseCategory.drink:
        return 'Drink';
      case ExpenseCategory.transport:
        return 'Transport';
      case ExpenseCategory.entertainment:
        return 'Entertainment';
      case ExpenseCategory.health:
        return 'Health';
      case ExpenseCategory.clothes:
        return 'Clothes';
      case ExpenseCategory.other:
        return 'Other';
    }
  }
}

extension ExpenseCategoryString on String {
  ExpenseCategory toExpenseCategory() {
    switch (this) {
      case 'Food':
        return ExpenseCategory.food;
      case 'Drink':
        return ExpenseCategory.drink;
      case 'Transport':
        return ExpenseCategory.transport;
      case 'Entertainment':
        return ExpenseCategory.entertainment;
      case 'Health':
        return ExpenseCategory.health;
      case 'Clothes':
        return ExpenseCategory.clothes;
      default:
        return ExpenseCategory.other;
    }
  }
}
