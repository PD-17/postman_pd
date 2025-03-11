import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'https://letscountapi.com';

  Future<int> createCounter(String namespace, int key) async {
    final response = await http.post(Uri.parse('$baseUrl/$namespace/$key'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['value'];
    } else {
      throw Exception('Failed to create counter');
    }
  }

  Future<int> getCounterValue(String namespace, int key) async {
    final response = await http.get(Uri.parse('$baseUrl/$namespace/$key'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['value'];
    } else {
      throw Exception('Failed to get counter value');
    }
  }
  Future<int> incrementCounter(String namespace, int key) async {
    final response = await http.get(Uri.parse('$baseUrl/$namespace/increment'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['value'];
    } else {
      throw Exception('Failed to get counter value');
    }
  }
  Future<int> decrementCounter(String namespace, int key) async {
    final response = await http.get(Uri.parse('$baseUrl/$namespace/decrement'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['value'];
    } else {
      throw Exception('Failed to get counter value');
    }
  }
  Future<int> updateCounter(String namespace, int key, int newValue) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$namespace/$key/update'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'value': newValue}),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)['value'];
    } else {
      throw Exception('Failed to update counter');
    }
  }
}