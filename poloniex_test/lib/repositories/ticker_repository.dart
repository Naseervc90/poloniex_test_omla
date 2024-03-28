import '../models/ticker.dart';
import '../services/web_socket_service.dart';

class TickerRepository {
  final WebSocketService webSocketService;

  TickerRepository({required this.webSocketService});

  Stream<Ticker?> getTickerStream() {
    return webSocketService.tickerStream;
  }
}
