import 'package:conduit/features/hermes/widgets/hermes_read_only_session_notice.dart';
import 'package:conduit_core/models/chat_message.dart';
import 'package:flutter_test/flutter_test.dart';

ChatMessage _message(
  String id,
  String role,
  String content, {
  bool error = false,
}) => ChatMessage(
  id: id,
  role: role,
  content: content,
  timestamp: DateTime.utc(2026, 11, 9),
  error: error ? const ChatMessageError(content: 'refused') : null,
);

void main() {
  test('a send Hermes refused is handed to the continued chat', () {
    expect(
      hermesRefusedMessageText([
        _message('1', 'user', 'earlier'),
        _message('2', 'assistant', 'answer'),
        _message('3', 'user', '  keep this  '),
        _message('4', 'assistant', '', error: true),
      ]),
      'keep this',
    );
  });

  test('nothing is handed over when the last turn did not fail', () {
    expect(
      hermesRefusedMessageText([
        _message('1', 'user', 'hi'),
        _message('2', 'assistant', 'hello'),
      ]),
      isNull,
    );
    expect(hermesRefusedMessageText(const []), isNull);
  });
}
