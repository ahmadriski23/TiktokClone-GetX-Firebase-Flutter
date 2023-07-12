part of 'ScreensImport.dart';

class VideoScreen extends StatefulWidget {
  VideoScreen({super.key, required this.uid});

  final String uid;

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  String? uid;

  // Bottom Sheet Comment
  bottomSheetCommentScreen(BuildContext ctx, String id) {
    final size = MediaQuery.of(ctx).size;
    commentController.updatePostId(id);

    showModalBottomSheet(
      backgroundColor: Colors.grey[850],
      context: ctx,
      builder: (ctx) => Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: commentController.comments.length,
                    itemBuilder: (context, index) {
                      final comment = commentController.comments[index];
                      return commentController.comments.isEmpty
                          ? Center(
                              child: Text(
                              'Be the first to comment',
                              style: TextService.boldText.copyWith(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ))
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: ListTile(
                                leading: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProfileScreen(uid: comment.uid),
                                      ),
                                    );
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    backgroundImage:
                                        NetworkImage(comment.profilePhoto),
                                  ),
                                ),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${comment.username}  ",
                                      style: TextService.boldText.copyWith(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      comment.comment,
                                      style: TextService.mediumText.copyWith(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      child: Row(
                                        children: [
                                          Text(
                                            tago.format(
                                                comment.datePublished.toDate()),
                                            style:
                                                TextService.mediumText.copyWith(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () => commentController
                                          .likeComment(comment.id),
                                      child: Icon(
                                        Icons.favorite,
                                        size: 25,
                                        color: comment.likes.contains(
                                                authController.user.uid)
                                            ? Colors.red
                                            : Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      '${comment.likes.length}',
                                      style: TextService.mediumText.copyWith(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                    },
                  );
                }),
              ),
              Divider(),
              Center(
                child: ListTile(
                  title: TextFormField(
                    controller: _commentController,
                    style: TextService.mediumText.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Comment',
                      hintStyle: TextService.mediumText.copyWith(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  trailing: TextButton(
                      onPressed: () => commentController
                          .postComment(_commentController.text),
                      child: Text(
                        'Send',
                        style: TextService.mediumText.copyWith(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final VideoController videoController = Get.put(VideoController());
  final SearchController searchController = Get.put(SearchController());
  final AuthController authController = Get.put(AuthController());

  final TextEditingController _commentController = TextEditingController();

  CommentController commentController = Get.put(CommentController());

  // Widget photo profile
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
                )),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Container(
            //     height: 25,
            //     width: 25,
            //     decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: Colors.white,
            //     ),
            //     child: Icon(Icons.done_rounded, color: Colors.red, size: 17),
            //   ),
            // ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: Icon(Icons.add, color: Colors.white, size: 17),
              ),
            ),
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
      resizeToAvoidBottomInset: false,
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
                                padding: EdgeInsets.only(left: 15, bottom: 15),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data.username,
                                        style: TextService.boldText
                                            .copyWith(fontSize: 15)),
                                    SizedBox(height: 4),
                                    Text(data.caption,
                                        style: TextService.mediumText
                                            .copyWith(fontSize: 13)),
                                    SizedBox(height: 6),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.music_note,
                                            size: 20, color: whiteColor),
                                        SizedBox(width: 5),
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
                                              size: 35,
                                              color: data.likes.contains(
                                                      authController.user.uid)
                                                  ? Colors.red
                                                  : whiteColor),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(data.likes.length.toString(),
                                            style: TextService.mediumText
                                                .copyWith(
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w700))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () => bottomSheetCommentScreen(
                                              context, data.id),
                                          child: Icon(Icons.comment,
                                              size: 35, color: whiteColor),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(data.commentCount.toString(),
                                            style: TextService.mediumText
                                                .copyWith(
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w700))
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
                                              size: 35, color: whiteColor),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(data.shareCount.toString(),
                                            style: TextService.mediumText
                                                .copyWith(
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w700))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    // uid == authController.user.uid
                                    //     ? InkWell(
                                    //         onTap: () =>
                                    //             videoController.deleteVideo(
                                    //                 data.id, data.videoUrl),
                                    //         child: Icon(Icons.delete,
                                    //             size: 35, color: whiteColor),
                                    //       )
                                    //     : Container(),
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
