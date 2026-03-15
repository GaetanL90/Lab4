import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/post.dart';

class PostService {
  static const _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> fetchPosts() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: const {
          'Accept': 'application/json',
          // Help some servers treat us like a normal browser client.
          'User-Agent': 'PostsManagerFlutter/1.0',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        return data.map((json) => Post.fromJson(json as Map<String, dynamic>)).toList();
      }

      if (response.statusCode == 403) {
        // Fallback sample data so the UI still works when the API is blocked.
        return [
          Post(
            userId: 1,
            id: 1,
            title: 'Sample post (API returned 403)',
            body:
                'The device received HTTP 403 (Forbidden) from jsonplaceholder.typicode.com. This sample post is shown as a graceful fallback.',
          ),
          Post(
            userId: 2,
            id: 2,
            title: 'Local fallback data',
            body:
                'In the lab report you can explain that the app handles HTTP errors by catching them and optionally providing local sample data.',
          ),
        ];
      }

      throw Exception('Failed to load posts. Status code: ${response.statusCode}');
    } on SocketException {
      throw Exception('No Internet connection');
    } on FormatException {
      throw Exception('Bad response format');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<Post> createPost(Post post) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(post.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to create post');
    }
  }

  Future<Post> updatePost(Post post) async {
    final url = '$_baseUrl/${post.id}';
    final response = await http.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(post.toJson()),
    );
    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to update post');
    }
  }

  Future<void> deletePost(int id) async {
    final url = '$_baseUrl/$id';
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete post');
    }
  }
}
