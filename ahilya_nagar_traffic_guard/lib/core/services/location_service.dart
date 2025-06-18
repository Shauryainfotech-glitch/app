import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService extends ChangeNotifier {
  Position? _currentPosition;
  String? _currentAddress;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isLocationServiceEnabled = false;
  LocationPermission _locationPermission = LocationPermission.denied;

  // Getters
  Position? get currentPosition => _currentPosition;
  String? get currentAddress => _currentAddress;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLocationServiceEnabled => _isLocationServiceEnabled;
  LocationPermission get locationPermission => _locationPermission;

  LocationService() {
    _init();
  }

  Future<void> _init() async {
    await _checkLocationService();
    await _checkLocationPermission();
  }

  // Check if location service is enabled
  Future<bool> _checkLocationService() async {
    _isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_isLocationServiceEnabled) {
      _setError('Location services are disabled. Please enable location services.');
      return false;
    }
    return true;
  }

  // Check and request location permission
  Future<bool> _checkLocationPermission() async {
    _locationPermission = await Geolocator.checkPermission();
    
    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
      if (_locationPermission == LocationPermission.denied) {
        _setError('Location permissions are denied.');
        return false;
      }
    }

    if (_locationPermission == LocationPermission.deniedForever) {
      _setError('Location permissions are permanently denied. Please enable them in settings.');
      return false;
    }

    return true;
  }

  // Get current location
  Future<Position?> getCurrentLocation() async {
    try {
      _setLoading(true);
      _clearError();

      // Check location service and permissions
      if (!await _checkLocationService() || !await _checkLocationPermission()) {
        _setLoading(false);
        return null;
      }

      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      if (_currentPosition != null) {
        await _getAddressFromCoordinates(_currentPosition!);
      }

      _setLoading(false);
      return _currentPosition;
    } catch (e) {
      _setError('Failed to get current location: ${e.toString()}');
      _setLoading(false);
      return null;
    }
  }

  // Get address from coordinates
  Future<String?> _getAddressFromCoordinates(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        _currentAddress = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
        notifyListeners();
        return _currentAddress;
      }
    } catch (e) {
      debugPrint('Error getting address: ${e.toString()}');
    }
    return null;
  }

  // Get coordinates from address
  Future<Position?> getCoordinatesFromAddress(String address) async {
    try {
      _setLoading(true);
      _clearError();

      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location location = locations[0];
        Position position = Position(
          latitude: location.latitude,
          longitude: location.longitude,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 0,
          headingAccuracy: 0,
        );
        
        _setLoading(false);
        return position;
      }

      _setLoading(false);
      return null;
    } catch (e) {
      _setError('Failed to get coordinates from address: ${e.toString()}');
      _setLoading(false);
      return null;
    }
  }

  // Calculate distance between two positions
  double calculateDistance(Position start, Position end) {
    return Geolocator.distanceBetween(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );
  }

  // Start location tracking
  Stream<Position> startLocationTracking() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // Update every 10 meters
    );

    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }

  // Open location settings
  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  // Open app settings
  Future<void> openAppSettings() async {
    await openAppSettings();
  }

  // Private helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    _clearError();
  }

  // Check if location is within a specific radius
  bool isWithinRadius(Position center, Position target, double radiusInMeters) {
    double distance = calculateDistance(center, target);
    return distance <= radiusInMeters;
  }

  // Get formatted address
  String getFormattedAddress() {
    return _currentAddress ?? 'Address not available';
  }

  // Get location accuracy description
  String getAccuracyDescription(double accuracy) {
    if (accuracy <= 5) return 'Very High';
    if (accuracy <= 10) return 'High';
    if (accuracy <= 20) return 'Medium';
    if (accuracy <= 50) return 'Low';
    return 'Very Low';
  }
}
