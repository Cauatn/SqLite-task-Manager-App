import 'package:flutter/material.dart';

class UserMessage extends StatelessWidget {
  const UserMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Olá, Cauã!',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 23,
              color: Colors.grey.shade500,
            ),
          ),
          const Text(
            'Seus Projetos (X)',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
