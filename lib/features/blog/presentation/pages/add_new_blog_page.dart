import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itiraf/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:itiraf/core/common/widgets/loader.dart';
import 'package:itiraf/core/constants/constants.dart';
import 'package:itiraf/core/themes/app_pallete.dart';
import 'package:itiraf/core/utils/pick_image.dart';
import 'package:itiraf/core/utils/show_snackbar.dart';
import 'package:itiraf/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:itiraf/features/blog/presentation/pages/blog_page.dart';
import 'package:itiraf/features/blog/presentation/widgets/blog_editor.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const AddNewBlogPage(),
      );
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<String> selectedTopics = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void uploadBlog() {
    final posterId = (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
    if (formKey.currentState!.validate() && selectedTopics.isNotEmpty && image != null) {
      context.read<BlogBloc>().add(BlogUpload(
            posterId: posterId,
            title: titleController.text.trim(),
            content: contentController.text.trim(),
            image: image!,
            topics: selectedTopics,
          ));
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                uploadBlog();
              },
              icon: const Icon(Icons.done_rounded),
            ),
          ],
        ),
        body: BlocConsumer<BlogBloc, BlogState>(
          listener: (context, state) {
            if (state is BlogFailure) {
              showSnackBar(context, state.error);
            } else if (state is BlogUploadSuccess) {
              Navigator.pushAndRemoveUntil(context, BlogPage.route(), (route) => false);
            }
          },
          builder: (context, state) {
            if (state is BlogLoading) {
              return const Loader();
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      image != null
                          ? GestureDetector(
                              onTap: selectImage,
                              child: SizedBox(
                                height: 200,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                selectImage();
                              },
                              child: DottedBorder(
                                color: AppPallete.borderColor,
                                dashPattern: const [
                                  12,
                                  6,
                                ],
                                radius: const Radius.circular(10),
                                borderType: BorderType.RRect,
                                strokeCap: StrokeCap.round,
                                child: Container(
                                  height: 150,
                                  width: double.infinity,
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        child: Icon(Icons.person, size: 40),
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        'Select an image',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: Constants.topics
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (selectedTopics.contains(e)) {
                                        selectedTopics.remove(e);
                                      } else {
                                        selectedTopics.add(e);
                                      }
                                      setState(() {});
                                    },
                                    child: Chip(
                                      color: selectedTopics.contains(e)
                                          ? MaterialStatePropertyAll(AppPallete.gradient2.withOpacity(0.5))
                                          : null,
                                      label: Text(e),
                                      side: selectedTopics.contains(e)
                                          ? null
                                          : const BorderSide(
                                              color: AppPallete.borderColor,
                                            ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      BlogEditor(controller: titleController, hintText: 'Confession title'),
                      const SizedBox(height: 10),
                      BlogEditor(controller: contentController, hintText: 'Confession content'),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
