import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../common/models/lightning_info_lite.dart';
import '../../../common/models/wallet_balance.dart';
import '../../../common/subscription_repository.dart';

part 'lightning_info_lite_event.dart';
part 'lightning_info_lite_state.dart';

class LightningInfoLiteBloc
    extends Bloc<LightningInfoLiteEvent, LightningInfoLiteBaseState> {
  SubscriptionRepository repo;

  StreamSubscription<Map<String, dynamic>>? _sub;

  LightningInfoLiteBloc(this.repo) : super(LightningInfoLiteInitial());

  @override
  Stream<LightningInfoLiteBaseState> mapEventToState(
    LightningInfoLiteEvent event,
  ) async* {
    if (event is StartListenLightningInfoLite) {
      _startListenLnEvents();
    } else if (event is StopListenLightningInfoLite) {
      await _sub?.cancel();
    } else if (event is _LightningInfoLiteUpdate) {
      LightningInfoLiteState _curr;
      try {
        _curr = state as LightningInfoLiteState;
      } catch (e) {
        _curr = const LightningInfoLiteState();
      }

      yield _curr.copyWith(lnInfo: event.lnInfo);
    }
  }

  void _startListenLnEvents() {
    _sub = repo.filteredStream([SseEventTypes.lnInfoLite])?.listen((event) {
      final i = LightningInfoLite.fromJson(event['data']);
      add(_LightningInfoLiteUpdate(lnInfo: i));
    });
  }
}