class Misc {
  static isEmpty(dynamic data) {
    if (data == "" || data == null) {
      return true;
    } else {
      // Helper.showLog(data.runtimeType as String?);
      if (data.runtimeType.toString().toLowerCase().contains("list")) {
        if (data == null) {
          return true;
        } else {
          if (data.length == 0) {
            return true;
          } else {
            return false;
          }
        }
      } else {
        return false;
      }
    }
  }
}
