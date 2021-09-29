import 'package:hive/hive.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_search/utils/latitude_util.dart';
part 'search_result.g.dart';

@HiveType(typeId: 0)
class SearchResult {
  @HiveField(0)
  late int placeId;
  @HiveField(1)
  late String licence;
  @HiveField(2)
  late String osmType;
  @HiveField(3)
  late int osmId;
  @HiveField(4)
  late List<String> boundingBox;
  @HiveField(5)
  late String lat;
  @HiveField(6)
  late String lon;
  @HiveField(7)
  late String displayName;
  @HiveField(8)
  late String placeClass;
  @HiveField(9)
  late String type;
  @HiveField(10)
  late double importance;
  @HiveField(11)
  late String icon;

  SearchResult(
      {required this.placeId,
      required this.licence,
      required this.osmType,
      required this.osmId,
      required this.boundingBox,
      required this.lat,
      required this.lon,
      required this.displayName,
      required this.placeClass,
      required this.type,
      required this.importance,
      required this.icon});

  SearchResult.fromJson(Map<String, dynamic> json) {
    placeId = json['place_id'];
    licence = json['licence'];
    osmType = json['osm_type'];
    osmId = json['osm_id'];
    boundingBox = json['boundingbox'].cast<String>();
    lat = json['lat'];
    lon = json['lon'];
    displayName = json['display_name'];
    placeClass = json['class'];
    type = json['type'];
    importance = json['importance'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['place_id'] = this.placeId;
    data['licence'] = this.licence;
    data['osm_type'] = this.osmType;
    data['osm_id'] = this.osmId;
    data['boundingbox'] = this.boundingBox;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['display_name'] = this.displayName;
    data['class'] = this.placeClass;
    data['type'] = this.type;
    data['importance'] = this.importance;
    data['icon'] = this.icon;
    return data;
  }

  getLocation() => LatLng(
      Utils.fixLatitude(double.parse(this.lat)),
      double.parse(this.lon));

  getTopLeft() => LatLng(
      Utils.fixLatitude(double.parse(this.boundingBox[0])),
      double.parse(this.boundingBox[2]));

  getBottomRight() => LatLng(
      Utils.fixLatitude(double.parse(this.boundingBox[1])),
      double.parse(this.boundingBox[3]));

}
