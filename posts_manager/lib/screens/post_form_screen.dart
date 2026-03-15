import 'package:flutter/material.dart';

import '../models/post.dart';

class PostFormScreen extends StatefulWidget {
  final Post? existing;
  final int? defaultUserId;

  const PostFormScreen({super.key, this.existing, this.defaultUserId});

  @override
  State<PostFormScreen> createState() => _PostFormScreenState();
}

class _PostFormScreenState extends State<PostFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.existing?.title ?? '');
    _bodyController = TextEditingController(text: widget.existing?.body ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final post = Post(
      userId: widget.existing?.userId ?? widget.defaultUserId ?? 1,
      id: widget.existing?.id,
      title: _titleController.text.trim(),
      body: _bodyController.text.trim(),
    );

    Navigator.of(context).pop(post);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existing != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Post' : 'Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _bodyController,
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(labelText: 'Body'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter body text';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: Text(isEditing ? 'Save changes' : 'Create post'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
