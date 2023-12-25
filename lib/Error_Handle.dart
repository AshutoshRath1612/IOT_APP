// error_output_handler.dart
class ErrorOutputHandler {
  String error = "";
  String output = "";

  // Singleton instance for global access
  static final ErrorOutputHandler _instance = ErrorOutputHandler._internal();

  factory ErrorOutputHandler() {
    return _instance;
  }

  ErrorOutputHandler._internal();

  // Function to update error message
  void updateError(String errorMessage) {
    error = errorMessage;
  }

  // Function to update output message
  void updateOutput(String outputMessage) {
    output = outputMessage;
  }
}
