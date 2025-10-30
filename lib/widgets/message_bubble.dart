import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isCurrentUser;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isCurrentUser ? colorScheme.primaryContainer : colorScheme.surfaceContainerHighest, // surfaceVariant yerine kullanıldı
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (message.type == MessageType.text)
              Text(
                message.message,
                style: textTheme.bodyLarge,
              )
            else if (message.type == MessageType.image)
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
                child: Image.network(message.message),
              )
            else if (message.type == MessageType.gif)
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
                child: Image.network(message.message),
              ),
            const SizedBox(height: 5),
            Text(
              DateFormat('HH:mm').format(message.timestamp.toDate()),
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
