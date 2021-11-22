import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/setup_bloc.dart';
import 'new_node_appbar.dart';
import 'step00_prepare_sd_card_page.dart';
import 'step01_connect.dart';

class NewNodeSetupPage extends StatefulWidget {
  const NewNodeSetupPage({Key? key}) : super(key: key);

  @override
  _NewNodeSetupPageState createState() => _NewNodeSetupPageState();
}

class _NewNodeSetupPageState extends State<NewNodeSetupPage> {
  final _setupBloc = NewNodeSetupBloc();
  int _currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _setupBloc,
      child: Scaffold(
        appBar: NewNodeAppBar(_currentStep),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildPage(),
          ),
        ),
      ),
    );
  }

  void _onStepDone(int step) {
    switch (step) {
      case 0:
        setState(() {
          _currentStep++;
        });
        break;
      default:
    }
  }

  Widget _buildPage() {
    switch (_currentStep) {
      case 0:
        return PrepareSDCardPage(_onStepDone);
      case 1:
        return ConnectPage(_onStepDone);
      default:
        return Center(child: Text('Unknown: $_currentStep'));
    }
  }

  @override
  void dispose() async {
    super.dispose();
    await _setupBloc.dispose();
  }
}
