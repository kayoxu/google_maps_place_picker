import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_maps_webservice/places.dart';

class PickResult {
  PickResult({
    this.placeId,
    this.geometry,
    this.formattedAddress,
    this.types,
    this.addressComponents,
    this.adrAddress,
    this.formattedPhoneNumber,
    this.id,
    this.reference,
    this.icon,
    this.name,
    this.openingHours,
    this.photos,
    this.internationalPhoneNumber,
    this.priceLevel,
    this.rating,
    this.scope,
    this.url,
    this.vicinity,
    this.utcOffset,
    this.website,
    this.reviews,
  });

  final String? placeId;
  final Geometry? geometry;
  final String? formattedAddress;
  final List<String>? types;
  final List<AddressComponent>? addressComponents;

  // Below results will not be fetched if 'usePlaceDetailSearch' is set to false (Defaults to false).
  final String? adrAddress;
  final String? formattedPhoneNumber;
  final String? id;
  final String? reference;
  final String? icon;
  final String? name;
  final OpeningHoursDetail? openingHours;
  final List<Photo>? photos;
  final String? internationalPhoneNumber;
  final PriceLevel? priceLevel;
  final num? rating;
  final String? scope;
  final String? url;
  final String? vicinity;
  final num? utcOffset;
  final String? website;
  final List<Review>? reviews;

  // Get Address Line 1, which includes street number and route (street name)
  String get addressLine1 {
    final streetNumber = _findComponent('street_number')?.longName ?? '';
    final route = _findComponent('route')?.longName ?? '';
    return '$streetNumber $route'.trim();
  }

  // Get Address Line 2, which includes additional information such as suite or apartment number
  String get addressLine2 => _findComponent('subpremise')?.longName ?? '';

  // Get Suburb, which is the locality or neighborhood within a city
  String get suburbOlny => _findComponent('locality')?.longName ?? '';

  // Get Suburb, which is the locality or neighborhood within a city
  String get suburb {
    final locality = _findComponent('locality')?.longName ?? '';
    if (locality.isNotEmpty) {
      return locality;
    }
    // If 'locality' is empty, try to get 'sublocality'
    return _findComponent('sublocality')?.longName ?? '';
  }

  // Get State, which is the administrative area level 1 (usually the state or province)
  String get state =>
      _findComponent('administrative_area_level_1')?.shortName ?? '';

  // Get Postcode, which is the postal code for the address
  String get postcode => _findComponent('postal_code')?.longName ?? '';

  // Helper method to find an address component by type
  AddressComponent? _findComponent(String type) {
    return addressComponents?.firstWhere(
      (component) => component.types.contains(type),
      orElse: () => AddressComponent(
          longName: '',
          shortName: '',
          types: []),
    );
  }

  factory PickResult.fromGeocodingResult(GeocodingResult result) {
    return PickResult(
      placeId: result.placeId,
      geometry: result.geometry,
      formattedAddress: result.formattedAddress,
      types: result.types,
      addressComponents: result.addressComponents,
    );
  }

  factory PickResult.fromPlaceDetailResult(PlaceDetails result) {
    return PickResult(
      placeId: result.placeId,
      geometry: result.geometry,
      formattedAddress: result.formattedAddress,
      types: result.types,
      addressComponents: result.addressComponents,
      adrAddress: result.adrAddress,
      formattedPhoneNumber: result.formattedPhoneNumber,
      id: result.id,
      reference: result.reference,
      icon: result.icon,
      name: result.name,
      openingHours: result.openingHours,
      photos: result.photos,
      internationalPhoneNumber: result.internationalPhoneNumber,
      priceLevel: result.priceLevel,
      rating: result.rating,
      scope: result.scope,
      url: result.url,
      vicinity: result.vicinity,
      utcOffset: result.utcOffset,
      website: result.website,
      reviews: result.reviews,
    );
  }
}
