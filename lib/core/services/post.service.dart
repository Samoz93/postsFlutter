import 'package:igor/core/Models/Post.Model.dart';
import 'package:igor/core/services/api.service.dart';

class PostsService {
  final _api = ApiService();
  static final PostsService _service = PostsService._();

  factory PostsService() {
    return _service;
  }
  PostsService._();
  Future<List<PostModel>> getData() async {
    final data = await _api.get<List<dynamic>>(url: "posts");
    return data!.map((e) => PostModel.fromMap(e)).toList();
  }

  Future<void> removePost(id) async {
    await _api.delete(url: "posts/$id");
  }

  Future<void> editPost(PostModel model) async {
    await _api.patch(url: "posts/${model.id}", data: model.toMap());
  }
}
