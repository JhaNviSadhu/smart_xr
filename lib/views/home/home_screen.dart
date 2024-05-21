import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_xr/utils/app_common.dart';
import 'package:smart_xr/utils/app_textstyle.dart';
import 'package:smart_xr/views/full_view/full_view.dart';
import 'package:smart_xr/views/home/cubit/home_cubit.dart';
import 'package:smart_xr/views/home/loading_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    HomeCubit.get(context).downloadAssetsForIOS();
    HomeCubit.get(context).onScrollController();
    HomeCubit.get(context).getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
          ),
          floatingActionButton: AnimatedOpacity(
            duration: const Duration(milliseconds: 1000),
            opacity: state is ShowButton ? 1.0 : 0.0,
            child: FloatingActionButton(
              onPressed: () {
                HomeCubit.get(context).scrollController.animateTo(
                    //go to top of scroll
                    0, //scroll offset to go
                    duration:
                        const Duration(milliseconds: 500), //duration of scroll
                    curve: Curves.fastOutSlowIn //scroll type
                    );
              },
              child: const Icon(Icons.arrow_upward),
            ),
          ),
          body: Center(
            child: state is HomeDataLoading
                ? const LoadingScreen()
                : ListView(
                    controller: HomeCubit.get(context).scrollController,
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 110),
                    children: [
                      if (HomeCubit.get(context).imageData.imageUrl != null)
                        Card(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const FullViewScreen(
                                        type: ContentType.imageView)),
                              );
                            },
                            title: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 10),
                              child: Text(
                                "ImageView",
                                style: AppTextStyle.subtitle22(),
                              ),
                            ),
                          ),
                        ),
                      if (HomeCubit.get(context).youtubeVideo.videoUrl != null)
                        Card(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: ListTile(
                            onTap: () async {
                              HomeCubit.get(context).onLaunchUrl(
                                  HomeCubit.get(context).youtubeVideo.videoUrl);
                            },
                            title: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 10),
                              child: Text(
                                "Youtube Video View",
                                style: AppTextStyle.subtitle22(),
                              ),
                            ),
                            subtitle: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "${HomeCubit.get(context).youtubeVideo.thumbnail}",
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(
                                        child: Container(
                                      height: 130,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Center(
                                          child: CupertinoActivityIndicator()),
                                    )),
                                    errorWidget: (context, url, error) =>
                                        const SizedBox(
                                            height: 130,
                                            child: Center(
                                                child: Text(
                                                    "Something went wrong!"))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (HomeCubit.get(context).link.src != null)
                        Card(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: ListTile(
                            onTap: () async {
                              HomeCubit.get(context)
                                  .onLaunchUrl(HomeCubit.get(context).link.src);
                            },
                            title: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 10),
                              child: Text(
                                "Open Link",
                                style: AppTextStyle.subtitle22(),
                              ),
                            ),
                          ),
                        ),
                      if (HomeCubit.get(context).gDrive.url != null)
                        Card(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: ListTile(
                            onTap: () async {
                              HomeCubit.get(context).onLaunchUrl(
                                  HomeCubit.get(context).gDrive.url);
                            },
                            title: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 10),
                              child: Text(
                                "Document View",
                                style: AppTextStyle.subtitle22(),
                              ),
                            ),
                            subtitle: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "${HomeCubit.get(context).gDrive.thumbnail}",
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Center(
                                    child: Container(
                                  height: 130,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Center(
                                      child: CupertinoActivityIndicator()),
                                )),
                                errorWidget: (context, url, error) =>
                                    const SizedBox(
                                        height: 130,
                                        child: Center(
                                            child:
                                                Text("Something went wrong!"))),
                              ),
                            ),
                          ),
                        ),
                      if (HomeCubit.get(context).threed.isNotEmpty)
                        Card(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: ListTile(
                            onTap: () {
                              // EarthPage
                              HomeCubit.get(context).launchAR(context);
                            },
                            title: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 10),
                              child: Text(
                                "View 3D & VR",
                                style: AppTextStyle.subtitle22(),
                              ),
                            ),
                          ),
                        ),
                      if (HomeCubit.get(context).mcq.question != null)
                        Card(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const FullViewScreen(
                                        type: ContentType.mcqView)),
                              );
                            },
                            title: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 10),
                              child: Text(
                                "MCQ",
                                style: AppTextStyle.subtitle22(),
                              ),
                            ),
                          ),
                        ),
                      if (HomeCubit.get(context).fib.question != null)
                        Card(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FullViewScreen(
                                      type: ContentType.fibView),
                                ),
                              );
                            },
                            title: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 10),
                              child: Text(
                                "Fill In the Blank",
                                style: AppTextStyle.subtitle22(),
                              ),
                            ),
                          ),
                        ),
                      if (HomeCubit.get(context).tf.question != null)
                        Card(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FullViewScreen(
                                      type: ContentType.tfView),
                                ),
                              );
                            },
                            title: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 10),
                              child: Text(
                                "True/False",
                                style: AppTextStyle.subtitle22(),
                              ),
                            ),
                          ),
                        ),
                      if (HomeCubit.get(context).owa.question != null)
                        Card(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FullViewScreen(
                                      type: ContentType.owaView),
                                ),
                              );
                            },
                            title: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 10),
                              child: Text(
                                "One word ans",
                                style: AppTextStyle.subtitle22(),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
