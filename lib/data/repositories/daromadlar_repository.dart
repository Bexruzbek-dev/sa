import 'package:sa/data/services/service_manager/daromadlar_service.dart';
import 'package:sa/models/daromad.dart';

class DaromadlarRepository {



  final daromadlarService = DaromadlarService();

  Future getDaromadlar() async{
    final daromadlar =await daromadlarService.getDaromadlar();
    return daromadlar;
  }


  Future addDaromad(Daromad daromad) async{
     await daromadlarService.addDaromad(daromad);
  }


  Future delete(String id)async{
    await daromadlarService.delete(id);
  }

}