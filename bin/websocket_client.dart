import 'dart:io';

import 'package:intl/intl.dart';
import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/status.dart' as status;

class WebsocketClient {
  final _webSocketUrl;

  // late WebSocket _webSocket;
  IOWebSocketChannel? _channel;

  int get readyState => _channel?.innerWebSocket?.readyState ?? -1;

  String get webSocketUrl => _webSocketUrl;

  WebsocketClient(String webSocketUrl) : _webSocketUrl = webSocketUrl {
    run();
  }

  void run() {
    stdout.writeln('${_timeStamp()}: Соединяемся с сервером $webSocketUrl ...');

    WebSocket.connect(webSocketUrl).then((webSocket) {
      stdout.writeln(
          '${_timeStamp()}: Соединение установлено');
      _channel = IOWebSocketChannel(webSocket);
      _channel?.stream.listen((message) {
        stdout.writeln(message);
      }, onDone: _done);
    }).catchError((err) {
      stdout.writeln('${_timeStamp()}: ОШИБКА СОЕДИНЕНИЯ: $err');
    });
  }

  void _done() async {
    stdout.writeln('${_timeStamp()}}: СОЕДИНЕНИЕ ЗАВЕРШЕНО! \n');
  }

  void sendws(String msg) {
    _channel?.sink.add(msg);
  }

  String _timeStamp() {
    return DateFormat.yMd('ru_RU').add_jms().format(DateTime.now());
  }
}
