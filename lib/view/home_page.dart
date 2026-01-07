import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:task_2/models/expense.dart';
import 'package:task_2/service/database_service.dart';
import 'package:task_2/widget/empty.dart';
import 'package:task_2/widget/loading.dart';
import 'package:task_2/widget/overview.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final db = AppDatabase.instance;

    final expenses = useState<List<Expense>>([]);
    final isLoading = useState<bool>(false);

    late Widget body;

    Future refresh() async {
      isLoading.value = true;
      expenses.value = await db.getAllExpenses();
      isLoading.value = false;
    }

    useEffect(() {
      refresh();
      return () => db.close();
    }, []);

    if (isLoading.value) {
      body = const LoadingWidget(isFullScreen: true);
    }

    if (expenses.value.isEmpty) {
      body = const EmptyWidget();
    }

    // if (expenses.value.isNotEmpty && !isLoading.value) {
    //   body = ListView.separated(
    //     padding: const EdgeInsets.all(16),
    //     itemCount: expenses.value.length,
    //     separatorBuilder: (context, index) => SizedBox(height: 16),
    //     itemBuilder: (context, index) {
    //       final expense = expenses.value[index];
    //       return ExpenseTileWidget(expense: expense);
    //     },
    //   );
    // }

    return Scaffold(
      body: OverviewExpenses(800.001, 2500.00),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
        ],

      ),
    );
  }
}
