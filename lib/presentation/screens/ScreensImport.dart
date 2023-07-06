import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

// Import Library
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:timeago/timeago.dart' as tago;
import 'package:video_player/video_player.dart';

// Import Controller
import '../../data/controllers/UploadVideoController.dart';
import '../../data/controllers/ProfileController.dart';
import '../../data/controllers/CommentController.dart';
import '../../data/controllers/SearchController.dart';
import '../../data/controllers/VideoController.dart';

// Import Widgets
import '../widgets/WidgetsImport.dart';

// Import Models
import 'package:vidscroll_app/data/models/user.dart';

// Import Constant
import '../../core/constant/Constant.dart';
import '../../core/constant/TextService.dart';

part 'AddVideoScreen.dart';
part 'CommentScreen.dart';
part 'ConfirmScreen.dart';
part 'HomeScreen.dart';
part 'ProfileScreen.dart';
part 'SearchScreen.dart';
part 'VideoScreen.dart';
