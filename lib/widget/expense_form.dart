import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:task_2/models/expense.dart';
import 'package:task_2/service/database_service.dart';

class AddExpenseForm extends StatefulHookWidget {
  final Expense? expense;
  const AddExpenseForm({super.key, this.expense});

  @override
  State<AddExpenseForm> createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  final formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> get formData => formKey.currentState?.value;

  final AppDatabase db = AppDatabase.instance;

  @override
  Widget build(BuildContext context) {
    final isLoading = useState<bool>(false);

    final expense = useState<Expense?>(widget.expense);

    void onSubmit() async {
      if (formKey.currentState?.saveAndValidate() ?? false) {
        isLoading.value = true;
        final newExpense = Expense.fromJson(formData);
        db.createExpense(newExpense);
        isLoading.value = false;
        Navigator.pop(context);
      }
    }

    return Padding(
      padding: MediaQuery.viewInsetsOf(context), 
    child: FormBuilder(
      key: formKey,
      child: Column(
        children: [
          FormBuilderTextField(
            name: 'name',
            decoration: const InputDecoration(labelText: 'Name'),
            initialValue: expense.value?.name,
            validator: FormBuilderValidators.required(context),
          ),
          FormBuilderTextField(
            name: 'amount',
            decoration: const InputDecoration(labelText: 'Amount'),
            initialValue: expense.value?.amount.toString(),
            validator: FormBuilderValidators.numeric(context),
          ),
          FormBuilderDateTimePicker(
            name: 'date',
            initialValue: expense.value?.date,
            inputType: InputType.date,
            decoration: const InputDecoration(labelText: 'Date'),
          ),
          FormBuilderDropdown<ExpenseCategory>(
            name: 'category',
            decoration: const InputDecoration(labelText: 'Category'),
            initialValue: expense.value?.category,
            items: ExpenseCategory.values
                .map((category) => DropdownMenuItem(
                      value: category,
                      child: Text(category.name),
                    ))
                .toList(),
          ),
          ElevatedButton(
            onPressed: isLoading.value ? null : onSubmit,
            child: isLoading.value
                ? const CircularProgressIndicator()
                : const Text('Save'),
          ),
        ],
      ),
    )

  }
}
