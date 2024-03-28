import 'dart:convert';

class Ticker {
  final double price;
  final DateTime timestamp;

  Ticker({
    required this.price,
    required this.timestamp,
  });

  factory Ticker.fromJson(Map<String, dynamic> json) {
    try {
      if (json['data'] != null && json['data'] is Map<String, dynamic>) {
        final data = json['data'] as Map<String, dynamic>;
        return Ticker(
          price: _parseDouble(data['price'], 'price'),
          timestamp:
              DateTime.now(), // Assuming the timestamp is the current time
        );
      } else {
        throw Exception(
            'Invalid Ticker JSON format: "data" field is missing or not an object.\nReceived JSON: $json');
      }
    } catch (e) {
      throw Exception('Error parsing Ticker JSON: $e.\nReceived JSON: $json');
    }
  }

  static double _parseDouble(dynamic value, String propertyName) {
    if (value == null) {
      throw Exception(
          'Invalid Ticker JSON format: "$propertyName" is missing or null.\nReceived JSON: $json');
    }
    if (value is! num) {
      throw Exception(
          'Invalid Ticker JSON format: "$propertyName" is not a number.\nReceived JSON: $json');
    }
    return value.toDouble();
  }
}
