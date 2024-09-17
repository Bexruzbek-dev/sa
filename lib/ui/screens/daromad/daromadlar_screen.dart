import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sa/data/blocs/daromadlar/daromad_bloc.dart';
import 'package:sa/data/blocs/daromadlar/daromad_event.dart';
import 'package:sa/data/blocs/daromadlar/daromad_state.dart';
import 'package:sa/data/repositories/daromadlar_repository.dart';
import 'package:sa/ui/screens/daromad/add_daromad.dart';
import 'package:sa/ui/screens/xarajat/xarajatlar_screen.dart';

class DaromadScreen extends StatefulWidget {
  const DaromadScreen({super.key});

  @override
  State<DaromadScreen> createState() => _DaromadScreenState();
}

List daromadlar = [];

class _DaromadScreenState extends State<DaromadScreen> {
  bool isloading = false;

  final daromadlarRepository = DaromadlarRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                  return HomeScreen();
                }));
              },
              icon: Text('To Xarajatlar'))
        ],
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Daromadlar"),
      ),
      body: BlocBuilder<DaromadBloc, DaromadState>(
        builder: (context, state) {
          if (state is DaromadLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DaromadLoaded) {
            return ListView.builder(
              itemCount: state.daromadlar.length,
              itemBuilder: (context, index) {
                final daromad = state.daromadlar[index];
                return ListTile(
                  title: Text(daromad.category),
                  subtitle: Text('${daromad.summa} '),
                  onTap: () {
                    context.read<DaromadBloc>().add(
                          DeleteDaromadEvent(id: daromad.id),
                        );
                  },
                );
              },
            );
          } else if (state is DaromadError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No recipes available'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
            return AddDaromadScreen();
          }));
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
