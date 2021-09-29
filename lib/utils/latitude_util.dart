class Utils {
  static double fixLatitude(double old) {
    if (old > 90.0) {
      return 90.0;
    } else if (old < -90.0) {
      return -90.0;
    } else {
      return old;
    }
  }

}
