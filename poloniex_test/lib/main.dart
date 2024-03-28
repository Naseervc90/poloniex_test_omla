// import 'dart:convert';
// import 'dart:developer';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:poloniex_test/firebase_options.dart';
// import 'package:poloniex_test/infrastructure/authentication/firebase_auth_service.dart';
// import 'package:poloniex_test/presentation/features/trade_view/trade_highlites.dart';
// import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:http/http.dart' as http;

// import 'presentation/features/bloc/auth_bloc.dart';
// import 'presentation/features/login/login_page.dart';
// import 'presentation/features/register/register_page.dart';
// import 'presentation/features/web_socket_bloc/bloc/web_socket_bloc.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final tokenData = await requestToken();

//   final channel = await connectToWebSocket(tokenData);
//   await subscribeToTickerData(channel);
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(MyApp(
//     channel: channel,
//   ));
// }

// Future<String> requestToken() async {
//   final url =
//       Uri.parse('https://futures-api.poloniex.com/api/v1/bullet-public');
//   final response = await http.post(url);

//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body);
//     final token = data['data']['token'];
//     log(token);
//     return token;
//   } else {
//     throw Exception('Failed to request token${response.statusCode}');
//   }
// }

// Future<WebSocketChannel> connectToWebSocket(String token) async {
//   final url = Uri.parse(
//       'wss://futures-apiws.poloniex.com/endpoint?token=$token&acceptUserMessage=true');
//   // final channel = IOWebSocketChannel.connect(url, headers: {
//   //   'Authorization': 'Bearer $token',
//   // });
//   final channel = WebSocketChannel.connect(url);
//   return channel;
// }

// Future<void> subscribeToTickerData(WebSocketChannel channel) async {
//   final payload = {
//     'id': 1545910660740,
//     'type': 'subscribe',
//     'topic': '/contractMarket/ticker:BTCUSDTPERP',
//     'response': true,
//   };

//   channel.sink.add(json.encode(payload));
// }

// class MyApp extends StatelessWidget {
//   final WebSocketChannel channel;

//   const MyApp({required this.channel});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Poloniex App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: BlocProvider(
//         create: (context) => WebSocketBloc(),
//         child: TradeHighlightScreen(channel: channel),
//         //create: (context) => AuthBloc(),
//         //child: AuthenticationWrapper(),
//       ),
//     );
//   }
// }

// class AuthenticationWrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final authenticationBloc = context.read<AuthBloc>();

//     return BlocBuilder<AuthBloc, AuthState>(
//       builder: (context, state) {
//         if (state is Authenticated) {
//           // User is authenticated, navigate to home or another authenticated screen
//           // You can replace the below line with your home screen widget.
//           return Container(
//             child: Center(
//               child: Text('Authenticated Screen'),
//             ),
//           );
//         } else if (state is Unauthenticated) {
//           // User is not authenticated, navigate to the login or registration screen
//           return RegisterPage();
//         } else if (state is AuthLoading) {
//           // Loading state, you can show a loading indicator if needed
//           return Container(
//             child: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         } else {
//           // Fallback to the login screen for any other state
//           return LoginPage();
//         }
//       },
//     );
//   }
// }
// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:poloniex_test/services/web_socket_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/ticker_bloc/ticker_bloc.dart';
import 'ui/pages/home/trade_highlights_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poloniex App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => TickerBloc(
          webSocketService: WebSocketService(),
        ),
        child: TradeHighlightPage(),
      ),
    );
  }
}
