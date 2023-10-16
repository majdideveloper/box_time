import 'package:box_time/models/boxtime_model.dart';
import 'package:box_time/utils/extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;

    notifyListeners();
  }

  List<BoxTimeModel> _listBoxTime = [];

  List<BoxTimeModel> get listBoxTime => _listBoxTime;

  addBox(BoxTimeModel box) {
    _listBoxTime.add(box);
    notifyListeners();
  }

  deleteBox(BoxTimeModel box) {
    _listBoxTime.remove(box);
    notifyListeners();
  }

  editBox(
    int index, {
    DateTime? newFrom,
    DateTime? newTo,
    String? newGoal,
    Color? newColor,
  }) {
    _listBoxTime[index].color = newColor ?? _listBoxTime[index].color;
    _listBoxTime[index].goal = newGoal ?? _listBoxTime[index].goal;
    _listBoxTime[index].from = newFrom;
    _listBoxTime[index].to = newTo;
    notifyListeners();
  }

  DateTime _date = DateTime.now().add(const Duration(days: 1));

  DateTime get date => _date;

  set setDate(DateTime date) {
    _date = date;
    notifyListeners();
  }

  DateTime _time = DateTime.now().applied(const TimeOfDay(hour: 5, minute: 0));

  DateTime get time => _time;

  set setTime(DateTime time) {
    _time = time;
    notifyListeners();
  }

  DateTime _to = DateTime.now().applied(const TimeOfDay(hour: 5, minute: 0));

  DateTime get to => _to;

  set setTo(DateTime time) {
    _to = time;
    notifyListeners();
  }

  TextEditingController _ideaDayController = TextEditingController();

  TextEditingController get ideaDayController => _ideaDayController;

  void updateIdea(String newText) {
    _ideaDayController.text = newText;
    notifyListeners();
  }

  @override
  void disposeIdeaDay() {
    _ideaDayController.dispose();
    super.dispose();
  }

  TextEditingController _firstGoalController = TextEditingController();

  TextEditingController get firstGoalController => _firstGoalController;

  void updateFirstGoal(String newText) {
    _firstGoalController.text = newText;
    notifyListeners();
  }

  @override
  void disposeFirstGoal() {
    _firstGoalController.dispose();
    super.dispose();
  }

  TextEditingController _secondGoalController = TextEditingController();

  TextEditingController get secondGoalController => _secondGoalController;

  void updateSecondGoal(String newText) {
    _secondGoalController.text = newText;
    notifyListeners();
  }

  @override
  void disposeSecondGoal() {
    _secondGoalController.dispose();
    super.dispose();
  }

  TextEditingController _thirdGoalController = TextEditingController();

  TextEditingController get thirdGoalController => _thirdGoalController;

  void updateThirdGoal(String newText) {
    _thirdGoalController.text = newText;
    notifyListeners();
  }

  @override
  void disposeThirdGoal() {
    _thirdGoalController.dispose();
    super.dispose();
  }

  TextEditingController _goalBoxController = TextEditingController();

  TextEditingController get goalBoxController => _goalBoxController;

  void updateGoalBox(String newText) {
    _goalBoxController.text = newText;
    notifyListeners();
  }

  @override
  void disposeGoalBox() {
    _goalBoxController.dispose();
    super.dispose();
  }

  Color? _colorBox;

  Color? get colorBox => _colorBox;

  set setColor(Color? color) {
    _colorBox = color;
    notifyListeners();
  }

  bool _remark = false;

  bool get remark => _remark;

  set setRemark(bool remark) {
    _remark = remark;
  }
}
