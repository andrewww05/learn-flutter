import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const CryptoCurrenciesListApp());
}

class CryptoCurrenciesListApp extends StatelessWidget {
  const CryptoCurrenciesListApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Currencies List',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromARGB(255, 31, 31, 31),
          surfaceTintColor: Color.fromARGB(255, 31, 31, 31),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.yellow),
        scaffoldBackgroundColor: const Color.fromARGB(255, 31, 31, 31),
        dividerTheme: DividerThemeData(color: Colors.white24),
        listTileTheme: ListTileThemeData(iconColor: Colors.white),
        textTheme: const TextTheme(
          bodySmall: TextStyle(
            // withValues(alpha: ...) = withOpacity
            color: Color.fromARGB(153, 255, 255, 255),
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
      routes: {
        '/': (context) => CryptoListScreen(),
        '/coin': (context) => CryptoCoinScreen(),
      },
    );
  }
}

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  final String title = 'Crypto Currencies List';

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, i) {
          const coinName = 'RNT';

          return ListTile(
            leading: SvgPicture.asset(
              'svg/bitcoin_logo.svg',
              semanticsLabel: 'BTC Logo',
              height: 30,
              width: 30,
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, '/coin', arguments: coinName);
            },
            title: Text(
              '$coinName $i',
              style: theme(context).textTheme.bodyMedium,
            ),
            subtitle: Text('2000\$', style: theme(context).textTheme.bodySmall),
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key});

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  String? coinName;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;

    assert(args != null && args is String, 'Invalid args');

    coinName = args as String;

    setState(() {});

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(coinName ?? '...')));
  }
}
