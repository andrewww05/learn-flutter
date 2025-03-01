import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({super.key, required this.coinName});

  final theme = Theme.of;

  final String coinName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        'svg/bitcoin_logo.svg',
        semanticsLabel: 'Bitcoin',
        height: 35,
        width: 35,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.pushNamed(context, '/coin', arguments: coinName);
      },
      title: Text(coinName, style: theme(context).textTheme.bodyMedium),
      subtitle: Text('2000\$', style: theme(context).textTheme.bodySmall),
    );
  }
}
