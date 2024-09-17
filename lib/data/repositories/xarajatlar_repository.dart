import 'package:sa/data/services/service_manager/xarajatlar_service.dart';
import 'package:sa/models/xarajat.dart';

class XarajatlarRepository {



  final xarajatlarService = XarajatlarService();

  Future getXarajatlar() async{
    final xarajatlar =await xarajatlarService.getXarajatlar();
    return xarajatlar;
  }


  Future addXarajat(Xarajat xarajat) async{
     await xarajatlarService.addXarajat(xarajat);
  }


  Future delete(String id)async{
    await xarajatlarService.delete(id);
  }

}