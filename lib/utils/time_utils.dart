class TimeUtils {
  static Map<String, int> yearsToTime(int years) {
    int days = years * 365;
    int hours = days * 24;
    int minutes = hours * 60;
    int seconds = minutes * 60;

    return {
      'years': years,
      'days': days,
      'hours': hours,
      'minutes': minutes,
      'seconds': seconds,
    };
  }
}
