import 'dart:io';

class WebsocketClient {
  final _webSocketUrl;

  late WebSocket _webSocket;

  String get webSocketUrl => _webSocketUrl;

  WebsocketClient(String webSocketUrl) : _webSocketUrl = webSocketUrl {
    run();
  }

  void run() async {
    print('${DateTime.now()}: Соединяемся с сервером $webSocketUrl ...');

    var futureWebSocket = WebSocket.connect(webSocketUrl);

    await futureWebSocket.then((WebSocket ws) {
      _webSocket = ws;
      print(
          '${DateTime.now()}: Соединение установлено: ${_webSocket.readyState.toString()}');

      _webSocket.listen((data) {
        print(data);
      }, onError: _error, onDone: _done);
    });
  }

  void _error(err) async {
    print('${DateTime.now()}: ОШИБКА СОЕДИНЕНИЯ: $err');
  }

  void _done() async {
    print('${DateTime.now()}: СОЕДИНЕНИЕ ЗАВЕРШЕНО! \n'
        'readyState=${_webSocket.readyState}\n'
        'closeCode= ${_webSocket.closeCode}\n'
        'closeReason=${_webSocket.closeReason}\n');
  }

  void sendws(String msg) {
    _webSocket.add(msg);
  }
}
