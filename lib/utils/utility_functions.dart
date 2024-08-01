String maskString(String input, String maskChar) {
  if (input.length <= 2) {
    return input;
  }

  String maskedPart = maskChar * (input.length - 2);
  String lastTwoChars = input.substring(input.length - 2);
  return maskedPart + lastTwoChars;
}
