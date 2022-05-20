import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uni/view/Pages/general_page_view.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart' show rootBundle;


class ErasmusMapView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ErasmusMapViewState();
}

/// Manages the 'about' section of the app.
class ErasmusMapViewState extends GeneralPageViewState {
  // late
  GoogleMapController mapController;
  final Set<Marker> markers = Set();
  static LatLng showLocation = const LatLng(27.7089427, 85.3086209);
  Location currentLocation = Location();
  static LatLng curLocation = const LatLng(27.7089427, 85.3086209);
  String _mapStyle;

  @override
  void initState(){
    super.initState();
    setState(() {
      getLocation();
    });
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }
  Set<Marker> getmarkers() { //markers to place on map
    setState(() {
      markers.add(Marker( //add first marker
        markerId: MarkerId(showLocation.toString()),
        position: showLocation, //position of marker
        infoWindow: InfoWindow( //popup info
          title: 'Marker Title First ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(Marker( //add second marker
        markerId: MarkerId(showLocation.toString()),
        position: LatLng(29.7099116, 89.3132343), //position of marker
        infoWindow: InfoWindow( //popup info
          title: 'Marker Title Second ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(Marker( //add third marker
        markerId: MarkerId(showLocation.toString()),
        position: LatLng(27.7137735, 85.315626), //position of marker
        infoWindow: InfoWindow( //popup info
          title: 'Marker Title Third ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      //add more markers here
    });

    return markers;
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  LatLng _center;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle(_mapStyle);
  }


  @override
  Widget getBody(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: _center == null? Center(child:CircularProgressIndicator()):
        GoogleMap(
          onMapCreated: _onMapCreated,
          markers: getmarkers(),
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      );
  }

  void getLocation() async{
    var loc= await currentLocation.getLocation();
    mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(loc.latitude ?? 0.0,loc.longitude?? 0.0),
          zoom: 12.0,
        )));
    _center  = LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0);
    showLocation = LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0);
    setState(() {
      markers.add(Marker(markerId: MarkerId('Home'),
          position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)
      ));
    });
  }
}
