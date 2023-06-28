import 'package:logger/logger.dart';

class CLog {
  static void info(dynamic message) {
    final Logger logger = Logger();
    logger.i(message);
  }

  static void warn(dynamic message) {
    final Logger logger = Logger();
    logger.w(message);
  }

  static void error(dynamic message) {
    final Logger logger = Logger();
    logger.e(message);
  }

  static void debug(dynamic message) {
    final Logger logger = Logger();
    logger.d(message);
  }
}
