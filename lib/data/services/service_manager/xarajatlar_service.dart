import 'package:sa/data/services/sql/xarajat_sql.dart';
import 'package:sa/models/xarajat.dart';

class XarajatlarService {
  

  final xarajatSql  = XarajatSql();

  Future getXarajatlar() async{
    final xarajatlar =await xarajatSql.fetchXarajatlar();
    return xarajatlar;
  }


  Future addXarajat(Xarajat xarajat) async{
     await xarajatSql.insertXarajat(xarajat);
  }

  Future delete(String id)async{
    await xarajatSql.deleteTodo(id);
  }




}