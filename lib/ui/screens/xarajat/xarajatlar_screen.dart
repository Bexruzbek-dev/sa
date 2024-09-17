import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sa/data/blocs/xarajatlar/xarajat_bloc.dart';
import 'package:sa/data/blocs/xarajatlar/xarajat_event.dart';
import 'package:sa/data/blocs/xarajatlar/xarajat_state.dart';
import 'package:sa/data/repositories/xarajatlar_repository.dart';
import 'package:sa/ui/screens/daromad/daromadlar_screen.dart';
import 'package:sa/ui/screens/xarajat/add_xarajat.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List xarajatlar = [];

class _HomeScreenState extends State<HomeScreen> {
  // @override
  // void initState() {
  //   print('kirdi');
  //   getXarajats();
  //   print(xarajatlar.length);

  //   super.initState();
  // }

  bool isloading = false;

  // void getXarajats() async {
  //   xarajatlar = await xarajatlarRepository.getXarajatlar();
  // }

  final xarajatlarRepository = XarajatlarRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                  return DaromadScreen();
                }));
              },
              icon: Text('To Daromadlar'))
        ],
        centerTitle: true,
        title: const Text("Xarajatlar"),
      ),
      body: BlocBuilder<XarajatBloc, XarajatState>(
        builder: (context, state) {
          if (state is XarajatLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is XarajatLoaded) {
            return ListView.builder(
              itemCount: state.xarajatlar.length,
              itemBuilder: (context, index) {
                final xarajat = state.xarajatlar[index];
                return ListTile(
                  title: Text(xarajat.category),
                  subtitle: Text('${xarajat.summa} '),
                  onTap: () {
                    context.read<XarajatBloc>().add(
                          DeleteXarajatEvent(id: xarajat.id),
                        );
                  },
                );
              },
            );
          } else if (state is XarajatError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No recipes available'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // context.read<XarajatBloc>().add(
          //       AddXarajatEvent(
          //         UniqueKey().toString(),
          //         12223,
          //         'bir',
          //         DateTime.now(),
          //         'xaye',
          //       ),
          //     );

          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
            return AddXarajatScreen();
          }));
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
