import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/ticker_bloc/ticker_bloc.dart';
import '../../../models/ticker.dart';
import '../../widgets/up_and_down_arrow.dart';

class TradeHighlightPage extends StatefulWidget {
  @override
  _TradeHighlightPageState createState() => _TradeHighlightPageState();
}

class _TradeHighlightPageState extends State<TradeHighlightPage> {
  late TickerBloc _tickerBloc;
  double _threshold = 0;

  @override
  void initState() {
    super.initState();
    _tickerBloc = BlocProvider.of<TickerBloc>(context);
    _tickerBloc.webSocketService.requestToken();
    _tickerBloc.add(FetchTicker());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trade Highlight'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _threshold = double.tryParse(value) ?? 0;
                });
              },
              decoration: InputDecoration(
                labelText: 'Enter a number',
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          BlocBuilder<TickerBloc, TickerState>(
            builder: (context, state) {
              if (state is TickerUpdatedState) {
                final ticker = state.ticker;
                return Column(
                  children: [
                    _buildTickerTile(ticker),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: 270,
                        width: 300,
                        child: PriceChartScreen(tickerList: [ticker]))
                  ],
                );
              } else if (state is TickerInitial) {
                return Center(child: CircularProgressIndicator());
              } else if (state is TickerLoaded) {
                final ticker = state.ticker;
                //return _buildTickerTile(ticker);
              }
              return CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTickerTile(Ticker ticker) {
    final isUp = ticker.price > _threshold;
    return ListTile(
      leading: UpDownArrow(
        isUp: isUp,
        color: isUp ? Colors.green : Colors.red,
      ),
      title: Text('${ticker.price}'),
    );
  }
}

// Import your Ticker model class

class PriceChartScreen extends StatelessWidget {
  final List<Ticker> tickerList; // Populate this list with your Ticker data

  PriceChartScreen({required this.tickerList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: tickerList.map((ticker) {
                  return FlSpot(
                    ticker.timestamp.millisecondsSinceEpoch.toDouble(),
                    ticker.price,
                  );
                }).toList(),
                isCurved: true,
                color: Colors.blue,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
              ),
            ],
            titlesData: FlTitlesData(
                //leftTitles: AxisTitles(),
                //bottomTitles: const AxisTitles(),
                ),
            gridData:
                FlGridData(drawHorizontalLine: true, drawVerticalLine: true),
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                color: const Color(0xff37434d),
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
