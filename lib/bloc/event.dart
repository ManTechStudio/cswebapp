abstract class CounterEvent {}

class PageChange extends CounterEvent {
  int index = 1;
  PageChange(int i) {
    index = i;
  }
}

class PageNoChange extends CounterEvent {
  int page = 1;
  PageNoChange(int i) {
    page = i;
  }
}
