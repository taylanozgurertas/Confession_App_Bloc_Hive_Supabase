import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:itiraf/core/constants/constants.dart';
import 'package:itiraf/core/error/exceptions.dart';
import 'package:itiraf/core/error/failures.dart';
import 'package:itiraf/core/network/connection_checker.dart';
import 'package:itiraf/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:itiraf/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:itiraf/features/blog/data/models/blog_model.dart';
import 'package:itiraf/features/blog/domain/entities/blog.dart';
import 'package:itiraf/features/blog/domain/repositories/blog_repository.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final BlogLocalDataSource blogLocalDataSource;
  final ConnectionChecker connectionChecker;

  BlogRepositoryImpl(this.blogRemoteDataSource, this.blogLocalDataSource, this.connectionChecker);

  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    if (!await (connectionChecker.isConnected)) {
      return left(Failure(Constants.noConnectionErrorMessage));
    }
    try {
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(image: image, blog: blogModel);
      blogModel = blogModel.copyWith(
        imageUrl: imageUrl,
      );

      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final blogs = blogLocalDataSource.loadBlogs();
        return right(blogs);
      }
      final blogs = await blogRemoteDataSource.getAllBlogs();
      blogLocalDataSource.uploadLocalBlogs(blogs: blogs);
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
