import 'dart:io';
import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/status.dart' as status;

class WebsocketClient {
  final _webSocketUrl;

  // late WebSocket _webSocket;
  late IOWebSocketChannel _channel;

  String get webSocketUrl => _webSocketUrl;

  WebsocketClient(String webSocketUrl) : _webSocketUrl = webSocketUrl {
    run();
  }

  void run() async {
    stdout
        .writeln('${DateTime.now()}: Соединяемся с сервером $webSocketUrl ...');

    _channel = IOWebSocketChannel.connect(Uri.parse(webSocketUrl));

    _channel.stream.listen((message) {
      stdout.writeln(message);
      // channel.sink.close(status.goingAway);
    }, onDone: _done, onError: _error);
  }

  void _error(err) async {
    stdout.writeln('${DateTime.now()}: ОШИБКА СОЕДИНЕНИЯ: $err');
  }

  void _done() async {
    stdout.writeln('${DateTime.now()}: СОЕДИНЕНИЕ ЗАВЕРШЕНО! \n');
  }

  void sendws(String msg) {
    _channel.sink.add(msg);
  }
}
