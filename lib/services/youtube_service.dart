import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YouTubeService {
  final yt = YoutubeExplode();

  Future<String?> fetchInstrumentalUrl(String songTitle) async {
    var searchResults = await yt.search.search("$songTitle karaoke");
    return searchResults.isNotEmpty ? searchResults.first.url : null;
  }

  Future<String?> fetchLyrics(String songTitle) async {
    var searchResults = await yt.search.search("$songTitle lyrics");
    return searchResults.isNotEmpty ? searchResults.first.url : null;
  }
}