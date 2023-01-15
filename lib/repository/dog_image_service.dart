import 'dart:convert';

import 'package:dog_app/api_key.dart';
import 'package:http/http.dart' as http;

/// Makes actual API call.
class DogImageService {
  final url = Uri.parse('https://api.openai.com/v1/images/generations');

  final headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $apiKey"};

  fetchRandomDogImage() async {
    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({
        "prompt": "cute frog illustration drinking boba tea in the style of japanese cartoon with a white background",
        "n": 1,
        "size": "512x512",
      },),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data['data'][0]['url'];
    } else {
      print("Failed to fetch image");
    }
  }
}