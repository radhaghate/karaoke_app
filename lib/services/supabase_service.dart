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
    // Fixing this line to await the result properly
    final response = await supabase
        .from('songs')
        .select()
        .eq('title', title)
        .single() // .single() to fetch a single row or throw an error if none is found
        .execute();

    // Check if the result is empty
    if (response.error != null) {
      print("Error fetching song data: ${response.error!.message}");
      return null;
    }

    return response.data as Map<String, dynamic>?; // Return the data as a Map
  }

}