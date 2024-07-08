import 'dart:convert';
import 'dart:developer';
import 'package:dream_ai/model/product_price.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl =
      'https://api.openai.com/v1/chat/completions'; // Replace with your ChatGPT API endpoint
  final String apiKey =
      dotenv.env['OPENAI_API_KEY']??''; // Replace with your OpenAI API key

  void setApiKey(String key){

  }
  Future<List<ProductPrice>> fetchPrices(String productName) async {
    log('url ${apiUrl}');
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
        // 'OpenAI-Organization': 'org-UN5NhyBZbhaPlKXMI8b3P2v6',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {
            'role': 'system',
            'content':
                'You are an AI that provides product prices from various e-commerce platforms in a specified JSON format.'
          },
          {
            'role': 'user',
            'content':
                'Fetch the prices for the $productName from various e-commerce platforms in India and return the results in the following JSON format , {"results":[{"ecommerce": "Amazon India", "originalPrice": "Rs xxx", "discountedPrice": "Rs xxx"}, {"ecommerce": "Flipkart", "originalPrice": "Rs xxx", "discountedPrice":"Rs xxx"}, {"ecommerce": "Apple Store India", "originalPrice": "Rs xxx", "discountedPrice": "Rs xxx"}]}'
          },
        ]
      }),
    );
    log('chatgpt response : ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final content = jsonResponse['choices'][0]['message']['content'];

      // Remove the surrounding code block characters (```)
      final jsonString =
          content.replaceAll('```json\n', '').replaceAll('\n```', '');
      log('json string : ${jsonString}');
      // Parse the cleaned JSON string
      final parsedJson = json.decode(jsonString);

      // Access the 'results' field
      final results = parsedJson['results'];

      log('results parsed : $results');

      // Map the results to the ProductPrice model
      return results
          .map<ProductPrice>((data) => ProductPrice.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load prices');
    }
  }

  Future<String> generateDescription(String productName) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
        // 'OpenAI-Organization': 'org-UN5NhyBZbhaPlKXMI8b3P2v6',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {
            'role': 'system',
            'content': 'You are an AI that provides product desscrition '
          },
          {
            'role': 'user',
            'content':
                'Generate a 300-word catchy and engaging product description for $productName. Highlight its key features, benefits, and unique selling points. Ensure the description is compelling and conveys the products value and appeal.'
          },
        ]
      }),
    );

    log('chatgpt response : ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final content = jsonResponse['choices'][0]['message']['content'];

      log('response string : ${content}');
      

      return content;
    } else {
      throw Exception('Failed to load description');
    }
  }
}
