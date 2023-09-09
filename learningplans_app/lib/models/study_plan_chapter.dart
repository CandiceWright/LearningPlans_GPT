import 'package:learningplans_app/models/study_resource.dart';

class StudyPlanChapter {
  String week;
  String title;
  String description;
  List<String> topics;
  List<StudyResource>? resources;

  StudyPlanChapter(
      {required this.week,
      required this.title,
      required this.description,
      required this.topics,
      this.resources});
}
