import 'package:flutter/cupertino.dart';

class Meal {
  final String? img;
  final String weekDay;
  final String soup;
  final String fish;
  final String meat;
  final String vegetarian;
  final String desert;
  Meal.Empty() : img = '', weekDay = '',soup='',
        fish='',meat='',vegetarian='',desert='';

  Meal(
      this.img,
      this.weekDay,
      this.soup,
      this.fish,
      this.meat,
      this.vegetarian,
      this.desert,);

  String getDia() {
    return weekDay;
  }



  Map<String, dynamic> toJson() => {
    'img': img,
    'weekDay': weekDay,
    'soup': soup,
    'fish': fish,
    'meat': meat,
    'vegetarian': vegetarian,
    'desert': desert,
  };
  Meal.fromJson(Map<String, dynamic> json) :
        img= json['img'],
        weekDay= json['weekDay'],
        soup= json['soup'],
        fish= json['fish'],
        meat= json['meat'],
        vegetarian= json['vegetarian'],
        desert= json['desert'];
}

class Day {
  final Meal original;
  Meal ?update;
  //final Meal update;

  Day.fromJson(Map<String, dynamic> json) :
        original= Meal.fromJson(json['original']),
        update = json['update'] != null ? Meal.fromJson(json['update']) : null;

  Meal getMeal(){
    if(update!=null && update != original){
      return update!;
    }
    return original;
  }

  Meal repor(){
    return original;
  }

  Day.empty() : original = Meal.Empty(),update = Meal.Empty(); //Meal.Empty();

  bool getIguais() {
    if(original.img == update?.img  && original.weekDay == update?.weekDay  && original.soup == update?.soup
        && original.fish == update?.fish && original.meat == update?.meat && original.vegetarian == update?.vegetarian
        && original.desert == update?.desert) {
      return true;
    } else {
      return false;
    }
  }

}

class Week {
  final Day monday;
  final Day tuesday;
  final Day wednesday;
  final Day thursday;
  final Day friday;

  List<Day> days = [];

  List<Day> initializeWeek(){
    int contaDias = 0;
    days = [];
    int dia = DateTime.now().weekday;

    for(int i = dia; contaDias != 5; i++) {
      if((i == 6 || i==7)){ // se for sábado ou domingo
        i = 1;
      }

      print(i);
      Day dia = getDay(i);
      print(dia.original.weekDay);
      //print(dia.getMeal().weekDay);
      days.add(dia);

      contaDias++;
    }

    return days;
  }

  // Generative constructor
  Day getDay(int index){
    switch(index){
      case 1: return monday;
      case 2: return tuesday;
      case 3: return wednesday;
      case 4: return thursday;
      case 5: return friday;

    }
    return monday;
  }

  Week.empty(): monday = Day.empty(), tuesday = Day.empty(),
        wednesday = Day.empty(),thursday = Day.empty(),friday = Day.empty(),days= const[];
  // Json para dart model
  Week.fromJson(Map<String, dynamic> json) :
        monday = Day.fromJson(json['MONDAY']),
        tuesday = Day.fromJson(json['TUESDAY']),
        wednesday = Day.fromJson(json['WEDNESDAY']),
        thursday = Day.fromJson(json['THURSDAY']),
        friday = Day.fromJson(json['FRIDAY']),
        days=const[];

}