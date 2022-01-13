import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String todo;
  final String description;
  final bool isActive;

  const TodoItem(
      {Key? key,
      required this.isActive,
      required this.todo,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 64,
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    description,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            ),
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: isActive
                    ? const Color.fromRGBO(14, 204, 87, 1)
                    : const Color.fromRGBO(150, 152, 151, 1),
                shape: BoxShape.circle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
