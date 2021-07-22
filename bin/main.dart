import 'dart:convert';
import 'dart:io';
import 'package:args/args.dart';

import 'websocket_client.dart';

const urlParamName = 'url';

void main(List<String> arguments) {
  var _webSocketUrl = 'ws://127.0.0.1:9224/';

  exitCode = 0; // presume success
  final parser = ArgParser()
    ..addOption(urlParamName, defaultsTo: _webSocketUrl);

  var argResults = parser.parse(arguments);

  var wsClient = WebsocketClient(argResults[urlParamName]);

  // get nonblocking input from stdin
  Stream<String> readLine() =>
      stdin.transform(utf8.decoder).transform(const LineSplitter());

  void parseLine(String input) {
    wsClient.sendws(input);
  }

  readLine().listen(parseLine);
}
