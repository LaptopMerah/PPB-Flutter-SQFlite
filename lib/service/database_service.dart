import 'package:sqflite/sqflite.dart';
import 'package:task_2/models/expense.dart';
import 'package:path/path.dart';

const String fileName = 'database.db';

class AppDatabase {
  AppDatabase.init();

  static final AppDatabase instance = AppDatabase.init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initializeDB(fileName);
    return _database!;
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        $idField $idType,
        $nameField $nameType,
        $amountField $amountType,
        $dateField $dateType,
        $categoryField $categoryType,
        $isExpenseField $isExpenseType
      )
      ''');
  }

  Future<Database> _initializeDB(String fileName) async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, fileName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Create
  Future<Expense> createExpense(Expense expense) async {
    final db = await instance.database;
    final id = await db.insert(tableName, expense.toJson());
    return expense.copyWith(id: id);
  }

  // Read
  Future<List<Expense>> getAllExpenses() async {
    final db = await instance.database;
     final result = await db.query(tableName);
    return result.map((json) => Expense.fromJson(json)).toList();

  }

  // Update
  Future<int> updateExpense(Expense expense) async {
    final db = await instance.database;
     return await db.update(
      tableName,
      expense.toJson(),
      where: '$idField = ?',
      whereArgs: [expense.id],
    );
  }

  // Delete
  Future<int> deleteExpense(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableName,
      where: '$idField = ?',
      whereArgs: [id],
    );
  }

  // get Income
  Future<double> getIncome() async {
    final db = await instance.database;
    final result = await db.rawQuery('''
      SELECT SUM($amountField) as total
      FROM $tableName
      WHERE $isExpenseField = 0
    ''');

    return result.isNotEmpty ? result.first['total'] as double : 0.0;
  }

  // get Expense
  Future<double> getExpense() async {
    final db = await instance.database;
    final result = await db.rawQuery('''
      SELECT SUM($amountField) as total
      FROM $tableName
      WHERE $isExpenseField = 1
    ''');

    return result.isNotEmpty ? result.first['total'] as double : 0.0;
  }

  // get Total
  Future<double> getTotal() async {
    final db = await instance.database;
    final result = await db.rawQuery('''
      SELECT 
        (SELECT SUM($amountField) FROM $tableName WHERE $isExpenseField = 0) -
        (SELECT SUM($amountField) FROM $tableName WHERE $isExpenseField = 1) 
        AS total
    ''');

    return result.isNotEmpty ? result.first['total'] as double : 0.0;
  }


  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}