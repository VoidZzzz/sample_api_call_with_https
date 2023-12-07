class HeroModel {
  String name = "";
  String heroId = "";
  String image = "";

  HeroModel({required this.image, required this.name, required this.heroId});


  @override
  String toString() {
    return 'HeroModel{name: $name, heroId: $heroId, image: $image}';
  }

  factory HeroModel.fromJson({required Map<String, dynamic> data}) {
    return HeroModel(
        image: data['key'], name: data['name'], heroId: data['heroid']);
  }
}
