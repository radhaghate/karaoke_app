import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  Future<void> saveSongData(String title, String instrumentalUrl, String lyricsUrl) async {
    await supabase.from('songs').upsert({
      'title': title,
      'instrumental_url': instrumentalUrl,
      'lyrics_url': lyricsUrl,
    });
  }

  Future<Map<String, dynamic>?> getSongData(String title) async {
    final data = await supabase.from('songs').select().eq('title', title).single();
    return data;
  }
}