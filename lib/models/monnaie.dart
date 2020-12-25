
enum Devise{
  EUR, USD, JPY, GBP
}

class Monnaie {
  //Character({this.name, this.role});
  Monnaie(this.devise);

  //final String name;
  final Devise devise;

  getDevise() {
    return this.devise;
  }
}