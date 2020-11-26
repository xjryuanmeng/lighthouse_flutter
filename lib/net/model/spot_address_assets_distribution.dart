
import 'package:lighthouse/utils/object_util.dart';

class SpotAddressAssetsDistribution {

  String account_name;
  String city;
  String created_at ;
  String avatar_300;

  SpotAddressAssetsDistribution({
    this.account_name,
    this.city,
    this.created_at,
    this.avatar_300,
  });

  SpotAddressAssetsDistribution.fromJson(Map<String, dynamic> jsonMap) {
    account_name = jsonMap['account_name'];
    city = jsonMap['city'];
    created_at = jsonMap['created_at'];
    avatar_300 = jsonMap['avatar_300'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    jsonMap['account_name'] = this.account_name;
    jsonMap['city'] = this.city;
    jsonMap['created_at'] = this.created_at;
    jsonMap['avatar_300'] = this.avatar_300;

    return jsonMap;
  }

  static List<SpotAddressAssetsDistribution> fromJsonList(List<dynamic> mapList) {
    if (ObjectUtil.isEmptyList(mapList)) {
      return null;
    }

    List<SpotAddressAssetsDistribution> items = new List<SpotAddressAssetsDistribution>();
    for(Map<String, dynamic> map in mapList) {
      items.add(SpotAddressAssetsDistribution.fromJson(map));
    }
    return items;
  }
}