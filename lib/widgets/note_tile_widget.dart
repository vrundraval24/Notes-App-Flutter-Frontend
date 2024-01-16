import 'package:flutter/material.dart';

Widget noteTileWidget(String title, String content) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.black87,
      borderRadius: BorderRadius.circular(12),
    ),
    padding: const EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 24, color: Colors.white),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          content,
          overflow: TextOverflow.ellipsis,
          maxLines: 4,
          style: const TextStyle(color: Colors.white70),
        )
      ],
    ),
  );
}
