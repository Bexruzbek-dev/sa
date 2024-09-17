import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sa/data/blocs/xarajatlar/xarajat_bloc.dart';
import 'package:sa/data/blocs/xarajatlar/xarajat_event.dart';
import 'package:sa/models/xarajat.dart';

class AddXarajatScreen extends StatefulWidget {
  @override
  _AddXarajatScreenState createState() => _AddXarajatScreenState();
}

class _AddXarajatScreenState extends State<AddXarajatScreen> {
  final _descriptionController = TextEditingController();
  final _summaController = TextEditingController();

  String? _selectedValue;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _options = [
      'Oziq-ovqat',
      'Transport',
      'Kommunal',
      'Dam olish'
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Xarajat'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Xarajat Description',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the xarajat name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _summaController,
                  decoration: const InputDecoration(
                    labelText: 'Xarajat Summasi',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the xarajat summasi';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.black54, width: 1),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedValue,
                      hint: Text('Select an option'),
                      icon: Icon(Icons.arrow_drop_down),
                      items: _options.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedValue = newValue;
                        });
                      },
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final newXarajat = Xarajat(
                          date: DateTime.now(),
                          id: UniqueKey().toString(),
                          description: _descriptionController.text,
                          summa: double.parse(_summaController.text),
                          category: _selectedValue!,
                        );
                        context.read<XarajatBloc>().add(AddXarajatEvent(
                              newXarajat.id,
                              newXarajat.summa,
                              newXarajat.category,
                              newXarajat.date,
                              newXarajat.description,
                            ));

                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Save Xarajat',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
