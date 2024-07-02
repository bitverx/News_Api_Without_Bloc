class Validation {
  static bool emailValidator(String email) {
    bool emailValid = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email);
    return emailValid;
  }
}
