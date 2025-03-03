part of './crypto_list_bloc.dart';

abstract class CryptoListState extends Equatable {
  final int page;
  final List<CryptoCoin> coinsList;

  const CryptoListState({required this.page, required this.coinsList});

  @override
  List<Object?> get props => [page, coinsList];
}

class CryptoListInitial extends CryptoListState {
  CryptoListInitial() : super(page: 1, coinsList: []);
}

class CryptoListLoading extends CryptoListState {
  CryptoListLoading() : super(page: 1, coinsList: []);

  @override
  List<Object?> get props => [];
}

class CryptoListLoadingMore extends CryptoListState {
  const CryptoListLoadingMore({required super.coinsList, required super.page});

  @override
  List<Object?> get props => [];
}

class CryptoListLoaded extends CryptoListState {
  const CryptoListLoaded({required super.coinsList, required super.page});
}

class CryptoListLoadingFailure extends CryptoListState {
  final Object? exception;

  CryptoListLoadingFailure({required this.exception})
    : super(page: 1, coinsList: []);

  @override
  List<Object?> get props => [exception];
}
