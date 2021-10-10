import 'package:flutter/material.dart';
import 'package:igor/core/Models/Post.Model.dart';
import 'package:igor/core/services/post.service.dart';
import 'package:stacked/stacked.dart';

import 'Ui/pages/Details/details.page.dart';

class MainViewModel extends BaseViewModel {
  //Services and main data
  final _ser = PostsService();
  List<PostModel> _data = [];
  List<PostModel> get data {
    if (_filterKeyWord.isEmpty) return this._data;
    return this
        ._data
        .where((element) =>
            element.title.toLowerCase().contains(_filterKeyWord) ||
            element.body.toLowerCase().contains(_filterKeyWord))
        .toList();
  }

  String _filterKeyWord = "";

  String get filterKeyWord => this._filterKeyWord;
  bool get hasData => data.isNotEmpty;

  set filterKeyWord(String value) {
    this._filterKeyWord = value.toLowerCase();
    notifyListeners();
  }

  init() async {
    if (_data.isNotEmpty) return;
    _wrapper(() async {
      _data.addAll(await _ser.getData());
    });
  }

  delteItem(dynamic id) async {
    _data.removeWhere((element) => element.id == id);
    notifyListeners();
    await _ser.removePost(id);
  }

  editPost(dynamic id) async {
    final x = _data.firstWhere((element) => element.id == id);
    final newPost = PostModel(
        userId: x.userId,
        id: x.id,
        title: _titleCtrl.text,
        body: _bodyCtrl.text);
    x.body = newPost.body;
    x.title = newPost.title;
    notifyListeners();
    await _ser.editPost(newPost);
  }

  _wrapper(Function toDo) async {
    try {
      setBusy(true);
      await toDo();
    } catch (e) {
      setError(e);
    } finally {
      notifyListeners();
      setBusy(false);
    }
  }

  //Details Controller
  bool _isEdited = false;

  get isEdited => this._isEdited;

  set isEdited(value) {
    if (_isEdited == value) return;
    this._isEdited = value;
    notifyListeners();
  }

  final _titleCtrl = TextEditingController();
  final _bodyCtrl = TextEditingController();

  get titleCtrl => this._titleCtrl;
  get bodyCtrl => this._bodyCtrl;

  PostModel? _currentModel;
  initControllers() {
    _bodyCtrl.value = TextEditingValue(text: _currentModel?.body ?? "");
    _titleCtrl.value = TextEditingValue(text: _currentModel?.title ?? "");
    _titleCtrl.addListener(_checkChangedValue);
    _bodyCtrl.addListener(_checkChangedValue);
  }

  @override
  void dispose() {
    _titleCtrl.removeListener(_checkChangedValue);
    _bodyCtrl.removeListener(_checkChangedValue);
    // _titleCtrl.dispose();
    // _bodyCtrl.dispose();

    super.dispose();
  }

  _checkChangedValue() {
    if (_titleCtrl.value.text != _currentModel?.title ||
        _bodyCtrl.value.text != _currentModel?.body) {
      isEdited = true;
    } else {
      isEdited = false;
    }
  }

  //Helper

  navigate(BuildContext ctx, dynamic id) async {
    _currentModel =
        _data.firstWhere((element) => element.id.toString() == id.toString());
    if (_currentModel == null) return;
    initControllers();
    await Navigator.of(ctx).push(MaterialPageRoute(
      builder: (context) => DetailsPage(model: _currentModel!),
    ));

    // remove the current model when closing the details page
    _currentModel = null;
  }

  closePage(BuildContext ctx) {
    Navigator.of(ctx).pop();
  }
}
