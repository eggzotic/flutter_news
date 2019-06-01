//
// Define the API endpoint
//  and provide helper to construct full URL for a search
//
import 'package:flutter/foundation.dart';

//
class Constants {
  // private constructor
  Constants._private();
  // Singleton for constant name-space
  static Constants shared = Constants._private();
  // e.g. https://newsapi.org/v2/everything?q=bitcoin&apiKey=39091e1dd90647539f36069aae526e54
  final String _newsUrl = 'https://newsapi.org/v2/everything';
  final String _apiKey = '39091e1dd90647539f36069aae526e54';
  //
  String apiUrl({
    @required String searchFor,
  }) {
    return _newsUrl + '?q=' + searchFor + '&apiKey=' + _apiKey;
  }
}

class Helper {
  static final bool debugOn = true;
  static void debug(String message) {
    if (!debugOn) return;
    print('DEBUG: $message');
  }
}
