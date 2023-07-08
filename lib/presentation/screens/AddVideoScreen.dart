part of 'ScreensImport.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({super.key});

  addVideoBottomSheet(BuildContext ctx) {
    final size = MediaQuery.of(ctx).size;
    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: ctx,
      builder: (ctx) => Container(
        height: 150,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            ListTile(
              onTap: () {
                pickVideo(ImageSource.gallery, ctx);
              },
              leading: Icon(Icons.image),
              title: Text('Choose from gallery'),
            ),
            ListTile(
              onTap: () {
                pickVideo(ImageSource.camera, ctx);
              },
              leading: Icon(Icons.camera_alt),
              title: Text('Open camera'),
            )
          ],
        ),
      ),
    );
  }

  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConfirmScreen(
                    videoFile: File(video.path),
                    videoPath: video.path,
                  )));
    }
  }

  showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () => pickVideo(ImageSource.gallery, context),
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text(
                          'Gallery',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => pickVideo(ImageSource.camera, context),
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt),
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text(
                          'Camera',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SimpleDialogOption(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Row(
                    children: [
                      Icon(Icons.cancel),
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 1,
        title: Text('New Vids',
            style: TextService.boldText.copyWith(fontSize: 18)),
      ),
      body: Center(
        child: InkWell(
          onTap: () => addVideoBottomSheet(ctx),
          child: Container(
            height: 50,
            width: 190,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: buttonColor,
            ),
            child: Center(
              child: Text(
                'Add Video',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
