import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itiraf/core/themes/app_pallete.dart';
import 'package:itiraf/features/blog/domain/entities/blog.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  const BlogCard({super.key, required this.blog});

  final String fixedOnePic = "https://i.redd.it/x5b1gogihsb61.jpg";

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppPallete.backgroundColor,
      elevation: 0.1,
      child: ListTile(
        subtitle: Text("@${blog.posterName.toString()}",
            textAlign: TextAlign.end, style: Theme.of(context).textTheme.titleMedium),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(blog.imageUrl),
        ),
        title: Wrap(
          runSpacing: 10,
          children: [
            //Text(blog.posterName.toString()),
            Text(blog.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(blog.content),
          ],
        ),
      ),
    );
  }

  Widget _iconLabel(String text) => Wrap(
        spacing: 5,
        children: [
          const Icon(Icons.comment, color: CupertinoColors.inactiveGray),
          Text(text),
        ],
      );

  Widget get _iconLabelButton => InkWell(
        child: _iconLabel("1"),
        onTap: () {},
      );

  Widget get _footerButtonList => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _iconLabelButton,
          _iconLabelButton,
          _iconLabelButton,
          _iconLabelButton,
        ],
      );
}
