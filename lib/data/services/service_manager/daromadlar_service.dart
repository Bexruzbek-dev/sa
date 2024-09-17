import 'package:sa/data/services/sql/daromadlar_sql.dart';
import 'package:sa/models/daromad.dart';

class DaromadlarService {
  final daromadSql = DaromadSql();

  Future getDaromadlar() async {
    final daromadlar = await daromadSql.fetchDaromadlar();
    return daromadlar;
  }

  Future addDaromad(Daromad daromad) async {
    await daromadSql.insertDaromad(daromad);
  }

  Future delete(String id) async {
    await daromadSql.deleteTodo(id);
  }
}
