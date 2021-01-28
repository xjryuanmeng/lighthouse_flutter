

import 'dart:async';

import 'package:library_base/mvvm/view_state.dart';
import 'package:library_base/mvvm/view_state_model.dart';
import 'package:lighthouse/net/constant.dart';
import 'package:lighthouse/net/dio_util.dart';
import 'package:lighthouse/net/model/spot_address_assets_distribution.dart';
import 'package:lighthouse/net/model/spot_data_basic.dart';
import 'package:library_base/utils/object_util.dart';

class SpotDataModel extends ViewStateModel {

  SpotDataBasic dataBasic;
  List<SpotAddressAssetsDistribution> dataList = [];

  SpotDataModel() : super(viewState: ViewState.first);

  Future getData(String chain) {
    Map<String, dynamic> params = {
      'chain': chain,
    };

    return DioUtil.getInstance().requestNetwork(Constant.URL_GET_CHAIN_DATA, 'get', params: params,
        cancelToken: cancelToken,
        onSuccess: (data) {

          dataBasic = SpotDataBasic.fromJson(data);
          dataList = dataBasic?.address_balance_list ?? [];

          if (ObjectUtil.isEmptyList(dataList)) {
            setEmpty();
          } else {
            setSuccess();
          }
        },
        onError: (errno, msg) {
          setError(errno, message: msg);
        });
  }

}
