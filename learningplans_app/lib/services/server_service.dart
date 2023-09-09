import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/study_plan_chapter.dart';
import '../models/study_resource.dart';

class ServerService {
  static ServerService sharedInstance = ServerService();
  //final baseUrl = "api.coveo.app";
  String serverUrl = "http://localhost:7342";

  Future<List<StudyPlanChapter>> getLearningPlan(String prompt) async {
    // var url = Uri.parse('$serverUrl/plan/$prompt');
    var url = Uri.parse('$serverUrl/plan');
    var body = {'prompt': prompt};
    String bodyF = jsonEncode(body);
    //print(bodyF);

    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
        body: bodyF);
    // var response =
    //     await http.get(url, headers: {"Access-Control-Allow-Origin": "*"});
    if (response.statusCode == 200) {
      var decodedBody = json.decode(response.body);
      List<StudyPlanChapter> weeklyStudyPlan = <StudyPlanChapter>[];
      //print(decodedBody);
      for (int i = 0; i < decodedBody.length; i++) {
        String week = (decodedBody[i]["week"]);
        String title = decodedBody[i]["title"];
        String description = decodedBody[i]["description"];
        List<String> topics = <String>[];
        List<StudyResource> resources = <StudyResource>[];
        for (int j = 0; j < decodedBody[i]["topics"].length; j++) {
          topics.add(decodedBody[i]["topics"][j]);
        }
        for (int j = 0; j < decodedBody[i]["resources"].length; j++) {
          StudyResource resource = StudyResource(
              title: decodedBody[i]["resources"][j]["title"],
              url: decodedBody[i]["resources"][j]["url"]);
          resources.add(resource);
        }
        StudyPlanChapter chapter = StudyPlanChapter(
            week: week,
            title: title,
            description: description,
            topics: topics,
            resources: resources);
        weeklyStudyPlan.add(chapter);
      }

      return weeklyStudyPlan;
    } else {
      debugPrint(response.body);
      throw Exception("failed to fetch published videos");
    }
  }
}
