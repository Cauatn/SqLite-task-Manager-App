import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0,
      leading: IconButton(
          onPressed: () {},
            icon: const Icon(
              Icons.apps,
            color: Colors.black,
            size: 40,
          )),
      actions: const [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
            'https://avatars.githubusercontent.com/u/39890456?v=4',
          ),
        ),
        SizedBox(
          width: 8,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
