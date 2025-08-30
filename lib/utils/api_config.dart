class ApiConfig {
  static const String baseUrl = 'https://api.unsplash.com';
  
  // TODO: Replace with your actual Unsplash API key
  // Get your API key from: https://unsplash.com/developers
  static const String apiKey = 'hSPEeXY6Jr6KCFHSGvZEJM-OROHovMbPI_05p2JSjiw';
  
  static const int perPage = 30;
  
  static const Map<String, String> headers = {
    'Authorization': 'Client-ID $apiKey',
    'Accept-Version': 'v1',
  };
}