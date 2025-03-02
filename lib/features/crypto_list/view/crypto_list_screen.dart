import 'package:crypto_currencies_app/features/crypto_list/bloc/bloc.dart';
import 'package:crypto_currencies_app/features/crypto_list/widgets/widgets.dart';
import 'package:crypto_currencies_app/repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  final String title = 'Crypto Currencies List';

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final ScrollController controller = ScrollController();
  CryptoCoinList? _coinsList;
  int pageNumber = 1;
  bool isLoading = false;
  bool showFloatingBtn = false;

  final _cryptoListBloc = CryptoListBloc(GetIt.I<AbstractCoinsRepository>());

  Future<void> fetchCoins() async {
    _cryptoListBloc.add(LoadCryptoList());

    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    // TESTING
    CryptoCoinList newCoins = CryptoCoinList(
      items: [],
      pagination: CryptoCoinListStats(count: 10, page: 1, pageSize: 10),
    );

    try {
      newCoins = await GetIt.I<AbstractCoinsRepository>().getCoinsList(
        page: pageNumber,
      );
    } catch (e) {}

    if (!mounted) return;

    setState(() {
      if (_coinsList == null) {
        _coinsList = newCoins;
      } else {
        _coinsList!.items.addAll(newCoins.items);
      }
      isLoading = false;
    });
  }

  Future<void> refreshList() async {
    setState(() {
      pageNumber = 1;
      _coinsList = null;
    });

    await fetchCoins();
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
    super.initState();
    controller.addListener(_scrollListener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.addListener(() {
        bool shouldShowBtn =
            controller.position.pixels > MediaQuery.of(context).size.height;
        if (showFloatingBtn != shouldShowBtn) {
          setState(() => showFloatingBtn = shouldShowBtn);
        }
      });
    });

    fetchCoins();
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<CryptoCoin> coins = _coinsList?.items ?? [];

    return RefreshIndicator(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      onRefresh: refreshList,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: BlocBuilder<CryptoListBloc, CryptoListState>(
          bloc: _cryptoListBloc,
          builder: (context, state) {
            if (state is CryptoListLoaded) {
              return ListView.separated(
                controller: controller,
                padding: const EdgeInsets.only(top: 16),
                itemCount: coins.length + (isLoading ? 1 : 0),
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, i) {
                  if (i == coins.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final coin = coins[i];
                  return CryptoCoinTile(coin: coin);
                },
              );
            }

            if (state is CryptoListLoadingFailure) {
              final theme = Theme.of(context);

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Something went wrong',
                      style: theme.textTheme.headlineMedium,
                    ),
                    Text(
                      'Please try again later',
                      style: theme.textTheme.labelSmall,
                    ),
                  ],
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
        // ? const Center(child: CircularProgressIndicator())
        // : ListView.separated(
        //   controller: controller,
        //   padding: const EdgeInsets.only(top: 16),
        //   itemCount: coins.length + (isLoading ? 1 : 0),
        //   separatorBuilder: (context, index) => const Divider(),
        //   itemBuilder: (context, i) {
        //     if (i == coins.length) {
        //       return const Center(child: CircularProgressIndicator());
        //     }
        //     final coin = coins[i];
        //     return CryptoCoinTile(coin: coin);
        //   },
        // ),
        floatingActionButton:
            showFloatingBtn
                ? FloatingActionButton(
                  onPressed: () {
                    controller.animateTo(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  },
                  child: const Icon(Icons.arrow_upward),
                )
                : null,
      ),
    );
  }
}
