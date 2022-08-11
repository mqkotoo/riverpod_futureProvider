import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'data/postal_code.dart';

StateProvider<String> postalCodeProvider = StateProvider((ref)=> "");


FutureProvider<PostalCode> apiProvider = FutureProvider((ref)  async {

  final postalcode = ref.watch(postalCodeProvider.notifier).state;

  if(postalcode.length != 7) {
    throw Exception("postal code must be 7 charactors");
}


  final upper = postalcode.substring(0,3);
  final lower = postalcode.substring(3);

  final apiUrl = 'https://madefor.github.io/postal-code-api/api/v1/$upper/$lower.json';

  final apiUri = Uri.parse(apiUrl);

  http.Response response = await http.get(apiUri);

  if(response.statusCode != 200) {
    throw Exception("No postal code!: $postalcode");
  }
  
  var jsonData = json.decode(response.body);

  return PostalCode.fromJson(jsonData);

});