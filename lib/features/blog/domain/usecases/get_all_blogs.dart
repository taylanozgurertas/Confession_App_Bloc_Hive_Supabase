import 'package:fpdart/fpdart.dart';
import 'package:itiraf/core/error/failures.dart';
import 'package:itiraf/core/usecase/usecase.dart';
import 'package:itiraf/features/blog/domain/entities/blog.dart';
import 'package:itiraf/features/blog/domain/repositories/blog_repository.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;
  GetAllBlogs(this.blogRepository);
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }
}
