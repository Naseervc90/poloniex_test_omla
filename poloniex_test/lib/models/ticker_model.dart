class Ticker {
  String subject;
  String topic;
  Data data;

  Ticker({
    required this.subject,
    required this.topic,
    required this.data,
  });

  factory Ticker.fromJson(Map<String, dynamic> json) => Ticker(
        subject: json["subject"],
        topic: json["topic"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "subject": subject,
        "topic": topic,
        "data": data.toJson(),
      };
}

class Data {
  String symbol;
  int sequence;
  String side;
  int price;
  int size;
  String tradeId;
  int bestBidSize;
  int bestBidPrice;
  int bestAskPrice;
  int bestAskSize;
  double ts;

  Data({
    required this.symbol,
    required this.sequence,
    required this.side,
    required this.price,
    required this.size,
    required this.tradeId,
    required this.bestBidSize,
    required this.bestBidPrice,
    required this.bestAskPrice,
    required this.bestAskSize,
    required this.ts,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        symbol: json["symbol"],
        sequence: json["sequence"],
        side: json["side"],
        price: json["price"],
        size: json["size"],
        tradeId: json["tradeId"],
        bestBidSize: json["bestBidSize"],
        bestBidPrice: json["bestBidPrice"],
        bestAskPrice: json["bestAskPrice"],
        bestAskSize: json["bestAskSize"],
        ts: json["ts"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "symbol": symbol,
        "sequence": sequence,
        "side": side,
        "price": price,
        "size": size,
        "tradeId": tradeId,
        "bestBidSize": bestBidSize,
        "bestBidPrice": bestBidPrice,
        "bestAskPrice": bestAskPrice,
        "bestAskSize": bestAskSize,
        "ts": ts,
      };
}
