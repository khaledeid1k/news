

const String sports="sports";
const String science="science";
const String business="business";
const String settings="settings";
const String news="News";

String? checkEmpty(String field , String nameField  ){
  if (field.isEmpty == true) {
    return "$nameField shouldn't be empty ";
  }
  return null;
}
