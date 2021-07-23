import 'package:ansicolor/ansicolor.dart';

String colorParser(String data) {
  var pen = AnsiPen()..blue();
  data = data.replaceAll('*', pen('*'));
  pen.yellow();
  data = data.replaceAll('#', pen('#'));
  pen.red();
  data = data.replaceAll('x', pen('x'));
  return data;
}
