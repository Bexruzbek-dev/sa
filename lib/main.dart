import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sa/data/blocs/daromadlar/daromad_bloc.dart';
import 'package:sa/data/blocs/xarajatlar/xarajat_bloc.dart';
import 'package:sa/data/repositories/daromadlar_repository.dart';
import 'package:sa/data/repositories/xarajatlar_repository.dart';
import 'package:sa/data/services/sql/daromadlar_sql.dart';
import 'package:sa/data/services/sql/xarajat_sql.dart';
import 'package:sa/ui/screens/xarajat/xarajatlar_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await XarajatSql.initDatabase();
  await DaromadSql.initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<XarajatBloc>(
            create: (context) =>
                XarajatBloc(xarajatRepository: XarajatlarRepository()),
          ),
          BlocProvider<DaromadBloc>(
            create: (context) =>
                DaromadBloc(daromadRepository: DaromadlarRepository()),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ));
  }
}




















// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//          BlocProvider<AuthBloc>(
//           create: (context) => AuthBloc(
//               authRepository: AuthRepository(authService: AuthService())),
//         ),
//       ],
//       child: MaterialApp(
//         home: WelcomePage(),
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           brightness: Brightness.light,
//           textTheme: GoogleFonts.dmSansTextTheme(),
//         ),
//         darkTheme: ThemeData(
//           brightness: Brightness.dark,
//           textTheme: GoogleFonts.dmSansTextTheme(),
//         ),
//         themeMode: ThemeMode.system,
//       ),
//     );
//   }
// }
