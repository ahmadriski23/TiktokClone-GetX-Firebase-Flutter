part of 'ScreensImport.dart';

class VideoScreen extends StatelessWidget {
  VideoScreen({super.key});

  final VideoController videoController = Get.put(VideoController());
  final SearchController searchController = Get.put(SearchController());

  buildProfile(BuildContext context, String uid, String profilePhoto) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(uid: uid),
          ),
        );
      },
      child: SizedBox(
        width: 60,
        height: 60,
        child: Stack(
          children: [
            Positioned(
                left: 5,
                child: Container(
                  width: 50,
                  height: 50,
                  padding: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image(
                      image: NetworkImage(profilePhoto),
                      fit: BoxFit.cover,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      height: 60,
      width: 60,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(11),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                colors: [Colors.grey, whiteColor],
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(
                image: NetworkImage(profilePhoto),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(() {
        return SafeArea(
          child: PageView.builder(
              itemCount: videoController.videoList.length,
              controller: PageController(initialPage: 0, viewportFraction: 1),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final data = videoController.videoList[index];
                return Stack(
                  children: [
                    VideoPlayerItems(
                      videoUrl: data.videoUrl,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Expanded(
                            child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(left: 20, bottom: 15),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data.username,
                                        style: TextService.boldText.copyWith()),
                                    SizedBox(height: 8),
                                    Text(data.caption,
                                        style:
                                            TextService.mediumText.copyWith()),
                                    SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Icon(Icons.music_note,
                                            size: 20, color: whiteColor),
                                        Text(
                                          data.songName,
                                          style:
                                              TextService.mediumText.copyWith(),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              margin: EdgeInsets.only(top: size.height / 5),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    buildProfile(
                                        context, data.uid, data.profilePhoto),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () => videoController
                                              .likeVideo(data.id),
                                          child: Icon(Icons.favorite,
                                              size: 40,
                                              color: data.likes.contains(
                                                      authController.user.uid)
                                                  ? Colors.red
                                                  : whiteColor),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(data.likes.length.toString(),
                                            style: TextService.mediumText
                                                .copyWith(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CommentScreen(
                                                          id: data.id,
                                                        )));
                                          },
                                          child: Icon(Icons.comment,
                                              size: 40, color: whiteColor),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(data.commentCount.toString(),
                                            style: TextService.mediumText
                                                .copyWith(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Icon(Icons.reply,
                                              size: 40, color: whiteColor),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(data.shareCount.toString(),
                                            style: TextService.mediumText
                                                .copyWith(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CircleAnimation(
                                      child: buildMusicAlbum(data.profilePhoto),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ))
                      ],
                    )
                  ],
                );
              }),
        );
      }),
    );
  }
}
