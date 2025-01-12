class Failure {
  final String errorMessage;
  Failure({required this.errorMessage});
}

class ErrorHandlingApi extends Failure {
  ErrorHandlingApi({required super.errorMessage});
}
