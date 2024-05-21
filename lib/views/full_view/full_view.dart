import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_xr/utils/app_common.dart';
import 'package:smart_xr/utils/app_textstyle.dart';
import 'package:smart_xr/views/home/cubit/home_cubit.dart';

class FullViewScreen extends StatefulWidget {
  final ContentType type;
  const FullViewScreen({
    super.key,
    required this.type,
  });

  @override
  State<FullViewScreen> createState() => _FullViewScreenState();
}

class _FullViewScreenState extends State<FullViewScreen> {
  @override
  void initState() {
    HomeCubit.get(context).selectedMCQANS = -1;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyboard(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(getAppbarTitle(widget.type)),
        ),
        body: Column(
          children: [
            if (widget.type == ContentType.imageView) _buildImageView(context),
            if (widget.type == ContentType.mcqView ||
                widget.type == ContentType.tfView)
              _buildMCQView(context),
            if (widget.type == ContentType.fibView) _buildFIBView(context),
            if (widget.type == ContentType.owaView)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Card(
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                          child: Text(
                            "${HomeCubit.get(context).owa.question}",
                            style: AppTextStyle.subtitle22(),
                          ),
                        ),
                        subtitle: Column(
                          children: [
                            TextFormField(
                              controller:
                                  HomeCubit.get(context).textEditingController,
                            ),
                            20.height,
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                onPressed: () {
                                  HomeCubit.get(context).onCheckOWAAns(context);
                                },
                                child: Text("Check Ans"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Padding _buildFIBView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Card(
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Text(
                  "${HomeCubit.get(context).fib.questionForm}",
                  style: AppTextStyle.subtitle22(),
                ),
              ),
              subtitle: Column(
                children: [
                  TextFormField(
                    controller: HomeCubit.get(context).textEditingController,
                  ),
                  20.height,
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        HomeCubit.get(context).onCheckAns(context);
                      },
                      child: Text("Check Ans"),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMCQView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Card(
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                child: Text(
                  widget.type == ContentType.mcqView
                      ? "${HomeCubit.get(context).mcq.question}"
                      : "${HomeCubit.get(context).tf.question}",
                  style: AppTextStyle.subtitle22(),
                ),
              ),
              subtitle: Column(
                children: List.generate(
                    widget.type == ContentType.mcqView
                        ? HomeCubit.get(context).mcq.options?.length ?? 0
                        : HomeCubit.get(context).tf.options?.length ?? 0,
                    (index) => BlocConsumer<HomeCubit, HomeState>(
                          builder: (context, state) {
                            return RadioListTile<int>(
                              activeColor: widget.type == ContentType.mcqView
                                  ? (HomeCubit.get(context)
                                              .mcq
                                              .options?[index] ==
                                          HomeCubit.get(context).mcq.answer
                                      ? Colors.green
                                      : Colors.red)
                                  : HomeCubit.get(context).tf.options?[index] ==
                                          HomeCubit.get(context).tf.answer
                                      ? Colors.green
                                      : Colors.red,
                              title: Text(
                                widget.type == ContentType.mcqView
                                    ? '${HomeCubit.get(context).mcq.options?[index]}'
                                    : '${HomeCubit.get(context).tf.options?[index]}',
                                style: AppTextStyle.subtitle(),
                              ),
                              value: index,
                              groupValue: HomeCubit.get(context).selectedMCQANS,
                              onChanged: (int? value) {
                                HomeCubit.get(context).onANSSelecte(value);
                              },
                            );
                          },
                          listener: (context, state) {},
                        )),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildImageView(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: CachedNetworkImage(
          imageUrl: "${HomeCubit.get(context).imageData.imageUrl}",
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
              child: Container(
            height: 130,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(child: CupertinoActivityIndicator()),
          )),
          errorWidget: (context, url, error) => const SizedBox(
              height: 130, child: Center(child: Text("Something went wrong!"))),
        ),
      ),
    );
  }

  String getAppbarTitle(type) {
    switch (type) {
      case ContentType.imageView:
        return "Image View";
      case ContentType.mcqView:
        return "MCQ View";
      case ContentType.fibView:
        return "Fill in the Blank View";
      case ContentType.tfView:
        return "True/False";
      case ContentType.owaView:
        return "One word ans";
      default:
        return "";
    }
  }
}
