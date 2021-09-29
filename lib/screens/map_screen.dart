import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:hive/hive.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_search/models/search_result.dart';
import 'package:map_search/network/search_api.dart';
import 'package:map_search/utils/error_alert.dart';
import 'package:uiblock/uiblock.dart';

class MapScreen extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MapScreen> {
  late final MapController _mapController;
  late SearchBar searchBar;
  late LatLng markerLocation;

  _MyHomePageState() {
    searchBar = new SearchBar(
        clearOnSubmit: false,
        closeOnSubmit: false,
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted);
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Map search'),
        actions: [searchBar.getSearchAction(context)]);
  }

  Future<void> onSubmitted(String value) async {
    UIBlock.block(context);

    try {
      SearchResult result = await SearchApi().fetchSearchResults(value);

      UIBlock.unblock(context);
      print("=====================");
      print(result.toJson().toString());

      var box = await Hive.openBox<SearchResult>("search");
      box.put("last_search", result);
      box.close();

      setLocation(result);
    } on Exception catch (e) {
      UIBlock.unblock(context);
      searchBar.controller.clear();
      searchBar.isSearching.value = false;
      ErrorAlert(context).show(e.toString());
    }
  }

  setLocation(SearchResult result) {
    setState(() {
      searchBar.controller.text = result.displayName;
      markerLocation = result.getLocation();
    });

    var bounds = LatLngBounds();
    bounds.extend(result.getTopLeft());
    bounds.extend(result.getBottomRight());
    _mapController.fitBounds(bounds);
  }

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    markerLocation = LatLng(51.5, -0.09);

    Hive.openBox("search").then((value) {
      if (value.isNotEmpty) {
        searchBar.isSearching.value = true;
        SearchResult lastSearch = value.get('last_search');

        setLocation(lastSearch);
      }
      value.close();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: LatLng(51.5, -0.09),
          zoom: 13.0,
        ),
        layers: [
          new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          new MarkerLayerOptions(
            markers: [
              new Marker(
                width: 69.0,
                height: 2 * 69.0,
                rotate: true,
                point: markerLocation,
                builder: (ctx) => Container(
                  alignment: Alignment.topCenter,
                  child: Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 69,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
