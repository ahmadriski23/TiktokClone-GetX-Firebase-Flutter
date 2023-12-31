import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:vidscroll_app/data/models/video.dart';

import '../../core/constant/Constant.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);

  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    super.onInit();
    _videoList.bindStream(
        firestore.collection('videos').snapshots().map((QuerySnapshot query) {
      List<Video> retVal = [];
      for (var element in query.docs) {
        retVal.add(Video.fromSnap(element));
      }
      return retVal;
    }));
  }

  likeVideo(String id) async {
    DocumentSnapshot doc = await firestore.collection('videos').doc(id).get();
    var uid = authController.user.uid;
    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await firestore.collection('videos').doc(id).update(
        {
          'likes': FieldValue.arrayRemove([uid]),
        },
      );
    } else {
      await firestore.collection('videos').doc(id).update(
        {
          'likes': FieldValue.arrayUnion([uid]),
        },
      );
    }
  }

  // deleteVideo(String id, String videoFile) {
  //   firebaseStorage.ref().child(videoFile).delete();
  //   firestore.collection('videos').doc(id).delete().then((_) {
  //     Get.snackbar("Success", "Video has been deleted");
  //   }).catchError((e) {
  //     Get.snackbar(
  //       'Error Uploading Video',
  //       e.toString(),
  //     );
  //   });
  // }
}
