import 'package:tarefas/services/http_service.dart';

class GetWeatherDatasource {
  final HttpService http;

  GetWeatherDatasource(this.http);

  Future<String> call({required double lat, required double long, })async{
   
      final result = await http.get('v1/forecast?latitude=$lat&longitude=$long&current_weather=true');

      return result.data['current_weather']['temperature'].toString();

  }
}