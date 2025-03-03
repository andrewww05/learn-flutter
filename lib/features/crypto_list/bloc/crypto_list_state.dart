part of './crypto_list_bloc.dart';

class CryptoListState {
  final int page;
  final List<CryptoCoin> coinsList;

  CryptoListState({required this.page, required this.coinsList});
}

class CryptoListInitial extends CryptoListState {
  CryptoListInitial() : super(page: 1, coinsList: []);
}

class CryptoListLoading extends CryptoListState {
  CryptoListLoading() : super(page: 1, coinsList: []);
}

class CryptoListLoadingMore extends CryptoListState {
  CryptoListLoadingMore({required super.coinsList, required super.page});
}

class CryptoListLoaded extends CryptoListState {
  CryptoListLoaded({required super.coinsList, required super.page});
}

class CryptoListLoadingFailure extends CryptoListState {
  final Object? exception;

  CryptoListLoadingFailure({required this.exception})
    : super(page: 1, coinsList: []);
}
