import 'package:flutter/material.dart';

class TextFragment {
  final String text;
  final TextStyle style;

  TextFragment(this.text, this.style);

  Widget toTextWidget() => Text(text, style: style);
}

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final double spacing = 4.0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          children: [
            SizedBox(height: spacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Raspiblitz v1.7'),
                Text(
                  'RecklessBlitz',
                  style: theme.textTheme.bodyText1.copyWith(
                    color: Colors.green[600],
                  ),
                )
              ],
            ),
            SizedBox(height: spacing),
            Text('Bitcoin Fullnode + Lightning Network + TOR'),
            Divider(),
            SizedBox(height: spacing),
            _buildRow(
              [
                _buildTextFragment('CPU load: ', theme),
                _buildTextFragment('0.59/0.71/0.38', theme, Colors.green),
              ],
              [
                _buildTextFragment('temp: ', theme),
                _buildTextFragment('44°C / 111°F', theme, Colors.green),
              ],
            ),
            _buildRow(
              [
                _buildTextFragment('Free Mem: ', theme),
                _buildTextFragment('3363M / 1906M', theme, Colors.green),
              ],
              [
                _buildTextFragment('HDDuse: ', theme),
                _buildTextFragment('286G (66%)', theme, Colors.green),
              ],
            ),
            _buildRow(
              [
                _buildTextFragment('ssh admin@', theme),
                _buildTextFragment('192.168.178.114', theme, Colors.green),
              ],
              [
                _buildTextFragment('d', theme),
                _buildTextFragment('3.3MiB', theme, Colors.green),
                _buildTextFragment('u', theme),
                _buildTextFragment('3.0MiB', theme, Colors.green),
              ],
            ),
            Divider(),
            _buildRow(
              [
                _buildTextFragment('Bitcoin ', theme),
                _buildTextFragment('v0.21.1', theme, Colors.green),
              ],
              [
                _buildTextFragment('Sync: ', theme),
                _buildTextFragment('OK 100.0%', theme, Colors.green),
              ],
            ),
            _buildRow(
              [
                _buildTextFragment('Public ', theme),
                _buildTextFragment(
                  '91.64.156.143:8333',
                  theme,
                  Colors.red[400],
                ),
              ],
              [
                _buildTextFragment('11 ', theme, Colors.purple[200]),
                _buildTextFragment('connections', theme),
              ],
            ),
            Divider(),
            _buildRow(
              [
                _buildTextFragment('LND ', theme),
                _buildTextFragment('v0.12.0-beta', theme, Colors.green),
              ],
              [
                _buildTextFragment('wallet ', theme),
                _buildTextFragment('68892 sat', theme, Colors.orange),
              ],
            ),
            _buildRow(
              [
                _buildTextFragment('4/0 Channels with ', theme),
                _buildTextFragment('1140252 sat', theme, Colors.orange),
              ],
              [
                _buildTextFragment('6 ', theme, Colors.purple[200]),
                _buildTextFragment('peers', theme),
              ],
            ),
            _buildRow(
              [
                _buildTextFragment('Fee Report in sat: ', theme),
                _buildTextFragment('11-124-497', theme, Colors.orange),
                _buildTextFragment(' (Day-Week-Month)', theme),
              ],
              [],
            ),
          ],
        ),
      ),
    );
  }

  TextFragment _buildTextFragment(String text, ThemeData theme, [Color color]) {
    return TextFragment(
      text,
      color == null
          ? theme.textTheme.bodyText1
          : theme.textTheme.bodyText1.copyWith(color: color),
    );
  }

  Widget _buildRow(List<TextFragment> left, List<TextFragment> right) {
    return Row(
      children: [
        for (var i in left) i.toTextWidget(),
        Spacer(),
        for (var i in right) i.toTextWidget(),
      ],
    );
  }
}