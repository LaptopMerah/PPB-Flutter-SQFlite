import 'expense_category.dart';

const String tableName = 'expenses';

const String idField = '_id';
const String nameField = 'name';
const String amountField = 'amount';
const String dateField = 'date';
const String categoryField = 'category';
const String isExpenseField = 'isExpense';

const List<String> expenseFields = [
  idField,
  nameField,
  amountField,
  dateField,
  categoryField,
  isExpenseField,
];

// Data type
const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
const String nameType = 'TEXT NOT NULL';
const String amountType = 'AMOUNT NOT NULL';
const String dateType = 'DATE NOT NULL';
const String categoryType = 'CATEGORY NOT NULL';
const String isExpenseType = 'BOOLEAN NOT NULL';


class Expense {
  final int id;
  final String name;
  final double amount;
  final DateTime date;
  final ExpenseCategory category;
  final bool isExpense;

  Expense({
    required this.id,
    required this.name,
    required this.amount,
    required this.date,
    required this.category,
    required this.isExpense,
  });
  


  static Expense fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json[idField] as int,
      name: json[nameField] as String,
      amount: json[amountField] as double,
      date: DateTime.parse(json[dateField] as String),
      category: (json[categoryField] as String).toExpenseCategory(),
      isExpense: json[isExpenseField] as bool,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      idField: id,
      nameField: name,
      amountField: amount,
      dateField: date.toIso8601String(),
      categoryField: category.name,
      isExpenseField: isExpense,
    };
  }

  Expense copyWith({
    int? id,
    String? name,
    double? amount,
    DateTime? date,
    ExpenseCategory? category,
    bool? isExpense,
  }) {
    return Expense(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      category: category ?? this.category,
      isExpense: isExpense ?? this.isExpense,
    );
  }
}

