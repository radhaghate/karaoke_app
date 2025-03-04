import 'lib/services/youtube_service.dart';
import 'lib/services/supabase_service.dart';

class SongRepository {
  final YouTubeService youtubeService = YouTubeService();
  final SupabaseService supabaseService = SupabaseService();

  Future<String?> fetchInstrumentalUrl(String songTitle) async {
    final songData = await supabaseService.getSongData(songTitle);
    if (songData != null) {
      return songData['instrumental_url'];
    }

    final url = await youtubeService.fetchInstrumentalUrl(songTitle);
    if (url != null) {
      await supabaseService.saveSongData(songTitle, url, '');
    }
    return url;
  }

  Future<String?> fetchLyrics(String songTitle) async {
    final songData = await supabaseService.getSongData(songTitle);
    if (songData != null) {
      return songData['lyrics_url'];
    }

    final url = await youtubeService.fetchLyrics(songTitle);
    if (url != null) {
      await supabaseService.saveSongData(songTitle, '', url);
    }
    return url;
  }
}