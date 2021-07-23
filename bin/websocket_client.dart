import 'dart:io';

import 'colorer.dart';

class WebsocketClient {
  final _webSocketUrl;

  late WebSocket _webSocket;

  String get webSocketUrl => _webSocketUrl;

  WebsocketClient(String webSocketUrl) : _webSocketUrl = webSocketUrl {
    run();
  }

  void run() async {
    stdout
        .writeln('${DateTime.now()}: Соединяемся с сервером $webSocketUrl ...');

    var futureWebSocket = WebSocket.connect(webSocketUrl);

    await futureWebSocket.then((WebSocket ws) {
      _webSocket = ws;
      stdout.writeln(
          '${DateTime.now()}: Соединение установлено: ${_webSocket.readyState.toString()}');

      _webSocket.listen((data) {
        stdout.writeln(colorParser(data));
      }, onError: _error, onDone: _done);
    });
  }

  void _error(err) async {
    stdout.writeln('${DateTime.now()}: ОШИБКА СОЕДИНЕНИЯ: $err');
  }

  void _done() async {
    stdout.writeln('${DateTime.now()}: СОЕДИНЕНИЕ ЗАВЕРШЕНО! \n'
        'readyState=${_webSocket.readyState}\n'
        'closeCode= ${_webSocket.closeCode}\n'
        'closeReason=${_webSocket.closeReason}\n');
  }

  void sendws(String msg) {
    _webSocket.add(msg);
  }
}
