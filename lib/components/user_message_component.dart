import 'package:flutter/material.dart';

class UserMessage extends StatelessWidget {
  final int tamanho;
  const UserMessage({required this.tamanho, super.key});

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
          Text(
            'Seus Projetos ($tamanho)',
            style: const TextStyle(
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
