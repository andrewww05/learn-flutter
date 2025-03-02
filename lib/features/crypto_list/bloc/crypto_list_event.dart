part of './crypto_list_bloc.dart';

class CryptoListEvent {}

class LoadCryptoList extends CryptoListEvent {
  final Completer? completer;

  LoadCryptoList(this.completer);
}
