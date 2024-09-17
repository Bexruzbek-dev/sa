import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sa/data/blocs/daromadlar/daromad_bloc.dart';
import 'package:sa/data/blocs/daromadlar/daromad_event.dart';
import 'package:sa/models/daromad.dart';

class AddDaromadScreen extends StatefulWidget {
  @override
  _AddDaromadScreenState createState() => _AddDaromadScreenState();
}

class _AddDaromadScreenState extends State<AddDaromadScreen> {
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
      'Oylik',
      'Qarz',
      'Deposit',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Daromad'),
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
                    labelText: 'Daromad Description',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the daromad name';
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
                    labelText: 'Daromad Summasi',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the daromad summasi';
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
                        final newDaromad = Daromad(
                          date: DateTime.now(),
                          id: UniqueKey().toString(),
                          description: _descriptionController.text,
                          summa: double.parse(_summaController.text),
                          category: _selectedValue!,
                        );
                        context.read<DaromadBloc>().add(AddDaromadEvent(
                              newDaromad.id,
                              newDaromad.summa,
                              newDaromad.category,
                              newDaromad.date,
                              newDaromad.description,
                            ));

                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Save Daromad',
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
