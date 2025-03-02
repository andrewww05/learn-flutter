import 'package:crypto_currencies_app/features/crypto_list/widgets/widgets.dart';
import 'package:crypto_currencies_app/repositories/crypto_coins_repository.dart';
import 'package:crypto_currencies_app/models/models.dart';
import 'package:flutter/material.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  final String title = 'Crypto Currencies List';

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  ScrollController controller = ScrollController();
  CryptoCoinList? _coinsList;
  int pageNumber = 1;
  bool isLoading = false;

  void fetchCoins() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    final newCoins = await CryptoCoinsRepository().getCoinsList(pageNumber);

    setState(() {
      if (_coinsList == null) {
        _coinsList = newCoins;
      } else {
        _coinsList!.items.addAll(newCoins.items);
      }
      isLoading = false;
    });
  }

  void _scrollListener() {
    if (controller.position.pixels >=
            controller.position.maxScrollExtent - 100 &&
        !isLoading) {
      pageNumber++;
      fetchCoins();
    }
  }

  @override
  void initState() {
    controller.addListener(_scrollListener);
    fetchCoins();
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<CryptoCoin> coins = _coinsList?.items ?? [];

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body:
          coins.isEmpty && isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                controller: controller,
                padding: const EdgeInsets.only(top: 16),
                itemCount: coins.length + (isLoading ? 1 : 0),
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, i) {
                  if (i == coins.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final coin = coins[i];
                  return CryptoCoinTile(coin: coin);
                },
              ),
    );
  }
}
