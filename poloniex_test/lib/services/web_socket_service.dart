import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

import '../blocs/ticker_bloc/ticker_bloc.dart';

import '../models/ticker.dart';

class WebSocketService {
  late WebSocketChannel _channel;
  late final TickerBloc _tickerBloc;
  late Stream<Ticker?> _tickerStream; // Changed type to Ticker?

  WebSocketService() {
    _tickerBloc = TickerBloc(webSocketService: this);
    connectToWebSocket(); // Initialize TickerBloc
  }

  Future<String> requestToken() async {
    try {
      const url = 'https://futures-api.poloniex.com/api/v1/bullet-public';
      final response = await http.post(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null && data['data']['token'] != null) {
          final token = data['data']['token'];
          log('WebSocket connection token: $token');
          return token;
        } else {
          throw Exception(
              'Invalid response format: "data" or "token" field is missing.\nReceived JSON: $data');
        }
      } else {
        throw Exception('Failed to retrieve token');
      }
    } catch (e) {
      log('Error during token retrieval: $e');
      rethrow; // Propagate the error
    }
  }

  Future<void> connectToWebSocket() async {
    try {
      final token = await requestToken(); // Get the token

      _channel = WebSocketChannel.connect(
        Uri.parse(
          'wss://futures-apiws.poloniex.com/endpoint?token=$token&acceptUserMessage=true',
        ),
      );

      log('WebSocket connected successfully');

      _tickerStream = _channel.stream.map((event) {
        final data = jsonDecode(event);

        // Check for the "welcome" message
        if (data['type'] == 'welcome') {
          log('Received welcome message: $data');
          return null; // Skip processing for welcome messages
        }
        if (data['type'] == 'ack') {
          log('Received ack message: $data');
          return null; // Skip processing for ack messages
        }
        // Parse as Ticker if it's not a welcome message
        try {
          final ticker = Ticker.fromJson(data);
          _tickerBloc.add(TickerUpdated(ticker));
          log('Received ticker data: $ticker');
          return ticker;
        } catch (e) {
          log('Error parsing Ticker JSON: $e.\nReceived JSON: $data');
          return null; // Skip processing for invalid Ticker JSON
        }
      }).where(
          (ticker) => ticker != null); // Use where to filter out null values
    } catch (e) {
      log('Error during WebSocket connection: $e');
      rethrow; // Propagate the error
    }
  }

  Stream<Ticker?> get tickerStream {
    if (_tickerStream == null) {
      throw Exception('Must call connectToWebSocket() first');
    }
    return _tickerStream;
  }

  Future<void> subscribeToTickerData() async {
    final payload = {
      'id': 1545910660740,
      'type': 'subscribe',
      'topic': '/contractMarket/ticker:BTCUSDTPERP',
      'response': true,
    };

    _channel.sink.add(json.encode(payload));
  }

  void dispose() {
    if (_channel != null) {
      _channel.sink.close();
    }
  }
}
