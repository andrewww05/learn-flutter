import 'dart:async';

import 'package:crypto_currencies_app/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part './crypto_list_event.dart';
part './crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  CryptoListBloc(this.coinsRepository) : super(CryptoListInitial()) {
    on<LoadCryptoList>((event, emit) async {
      try {
        if (state is! CryptoListLoaded) {
          emit(CryptoListLoading());
        }

        final coinsList = await coinsRepository.getCoinsList(page: 1);

        emit(CryptoListLoaded(coinsList: coinsList.items, page: 1));
      } catch (e) {
        emit(CryptoListLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });

    on<LoadCryptoListMore>((event, emit) async {
      try {
        emit(
          CryptoListLoadingMore(page: state.page, coinsList: state.coinsList),
        );

        final newCoins = await coinsRepository.getCoinsList(
          page: state.page + 1,
        );

        final List<CryptoCoin> coinsList = List.from(state.coinsList)
          ..addAll(newCoins.items);

        emit(
          CryptoListLoaded(
            coinsList: coinsList,
            page: newCoins.pagination.page,
          ),
        );
      } catch (e) {
        emit(CryptoListLoadingFailure(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }

  final AbstractCoinsRepository coinsRepository;
}
