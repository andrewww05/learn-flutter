import 'dart:async';

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
  // int pageNumber = 1;
  bool showFloatingBtn = false;

  final _cryptoListBloc = CryptoListBloc(GetIt.I<AbstractCoinsRepository>());

  Future<void> fetchCoins() async {
    _cryptoListBloc.add(LoadCryptoList(null));
  }

  Future<void> refreshList() async {
    final completer = Completer();
    _cryptoListBloc.add(LoadCryptoList(completer));
    return completer.future;
  }

  void _scrollListener() {
    if (controller.position.pixels >=
        controller.position.maxScrollExtent - 100) {
      // pageNumber++;
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
    return RefreshIndicator(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      onRefresh: refreshList,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: BlocBuilder<CryptoListBloc, CryptoListState>(
          bloc: _cryptoListBloc,
          builder: (context, state) {
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
                    SizedBox(height: 30),
                    TextButton(
                      onPressed: fetchCoins,
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              );
            }

            if (state is CryptoListLoaded) {
              return ListView.separated(
                controller: controller,
                padding: const EdgeInsets.only(top: 16),
                itemCount: state.coinsList.length,
                // + (isLoading ? 1 : 0),
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, i) {
                  // if (i == state.coinsList.length) {
                  //   return const Center(child: CircularProgressIndicator());
                  // }
                  // For autoloading new data
                  final coin = state.coinsList[i];
                  return CryptoCoinTile(coin: coin);
                },
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
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
