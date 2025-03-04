import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HomeScreen extends StatefulWidget {
  final String videoUrl;
  const HomeScreen({Key? key, this.videoUrl = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ'}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late YoutubePlayerController _controller;
  final TextEditingController _urlController = TextEditingController();
  String? _currentVideoUrl;

  @override
  void initState() {
    super.initState();
    // Use initial video URL if provided
    _currentVideoUrl = widget.videoUrl;
    _initializePlayer();
  }

  void _initializePlayer() {
    if (_currentVideoUrl != null) {
      try {
        _controller = YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(_currentVideoUrl!)!,
          flags: YoutubePlayerFlags(autoPlay: true, mute: false),
        );
      } catch (e) {
        // Handle invalid URL
        print('Error initializing player: $e');
        _controller = YoutubePlayerController(
          initialVideoId: '',
          flags: YoutubePlayerFlags(autoPlay: false, mute: false),
        );
      }
    } else {
      _controller = YoutubePlayerController(
        initialVideoId: '',
        flags: YoutubePlayerFlags(autoPlay: false, mute: false),
      );
    }
  }

  void _loadVideo() {
    String? videoUrl = _urlController.text.trim();
    if (videoUrl.isNotEmpty) {
      try {
        String? videoId = YoutubePlayer.convertUrlToId(videoUrl);
        if (videoId != null) {
          setState(() {
            _currentVideoUrl = videoUrl;
            _controller.load(videoId);
          });
          // Clear the input field after loading
          _urlController.clear();
        } else {
          // Show error if URL is invalid
          _showErrorDialog('Invalid YouTube URL');
        }
      } catch (e) {
        _showErrorDialog('Error loading video');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Karaoke App"),
      ),
      body: Column(
        children: [
          // YouTube Player
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
          ),
          
          // URL Input Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Expanded text field for URL input
                Expanded(
                  child: TextField(
                    controller: _urlController,
                    decoration: InputDecoration(
                      hintText: 'Enter YouTube Video URL',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                
                // Load Video Button
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _loadVideo,
                  child: Text('Load'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}