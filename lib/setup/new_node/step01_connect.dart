import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/utils.dart';
import '../../common/widgets/translated_text.dart';
import 'bloc/setup_bloc.dart';

class ConnectPage extends StatefulWidget {
  final Function(int) onDone;

  const ConnectPage(this.onDone, {Key? key}) : super(key: key);

  @override
  _ConnectPageState createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  final TextEditingController _controller =
      TextEditingController(text: 'http://127.0.0.1:8000/');

  late StreamSubscription<SetupState>? _sub;

  @override
  void dispose() async {
    super.dispose();
    await _sub?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<NewNodeSetupBloc, SetupState>(
      builder: (context, state) {
        if (state is SetupInitial) {
          return _buildBody(theme);
        } else if (state is ConnectingNodeState) {
          return _buildBody(theme, working: true);
        } else if (state is ConnectingNodeError) {
          return _buildBody(
            theme,
            error: state.errorMessage,
          );
        } else if (state is ConnectingNodeSuccess) {
          var buffer = StringBuffer();
          for (var key in state.state.keys) {
            buffer.writeln(key + ': ' + state.state[key].toString());
          }

          return _buildBody(theme, successText: buffer.toString());
        }
        return Center(child: Text('Unknown $state'));
      },
    );
  }

  Widget _buildBody(
    ThemeData theme, {
    String error = '',
    String successText = '',
    bool working = false,
  }) {
    return Column(
      children: [
        const SizedBox(height: 8),
        TrText(
          'setup.header_establish_connection',
          style: theme.textTheme.headline6!,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _controller,
          enabled: !working,
          decoration: InputDecoration(
            labelText: tr('setup.input_label.enter_url'),
          ),
        ),
        const SizedBox(height: 16),
        error.isNotEmpty ? Text(error) : Container(),
        if (successText.isNotEmpty) const Text('Response:'),
        if (successText.isNotEmpty) Text(successText, maxLines: 5),
        if (successText.isNotEmpty)
          ElevatedButton(
            onPressed: () => widget.onDone(1),
            child: const TrText('setup.btn.next_step', isButton: true),
          ),
        const SizedBox(height: 16),
        successText.isEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: working ? null : () => _connect(),
                    child: const TrText('setup.btn.connect_to_api',
                        isButton: true),
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: working ? null : () => _scanQr(),
                    child: const TrText(
                      'setup.btn.scan_qr_with_connection_details',
                      isButton: true,
                    ),
                  )
                ],
              )
            : Container(),
      ],
    );
  }

  void _connect() async {
    BlocProvider.of<NewNodeSetupBloc>(context).add(
      ConnectNodeEvent(_controller.text),
    );
  }

  void _scanQr() {
    _controller.text = 'some_address.onion';
  }
}