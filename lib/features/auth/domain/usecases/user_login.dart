import 'package:fpdart/fpdart.dart';
import 'package:itiraf/core/error/failures.dart';
import 'package:itiraf/core/usecase/usecase.dart';
import 'package:itiraf/core/common/entities/user.dart';
import 'package:itiraf/features/auth/domain/repository/auth_repository.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  final AuthRepository authRepository;

  UserLogin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) {
    return authRepository.loginWithEmailPassword(email: params.email, password: params.password);
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({required this.email, required this.password});
}
