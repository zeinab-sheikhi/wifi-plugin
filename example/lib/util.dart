class Util {

  List<int> makeList(List<int> rssiList, int numOfItems) {

    List<int> modifiedList = [];
    //sort list in ascending order
    rssiList.sort((b, a) => a.compareTo(b));
    //make sublist which has numOfListItems items
    modifiedList = rssiList.sublist(0, numOfItems + 1);
    return modifiedList;
  }

  int calculateMean(List<int> list) {
    var mean = list.reduce((a,b) => a + b) ~/ list.length;
    return mean;
  }
}