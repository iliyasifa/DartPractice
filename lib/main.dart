import 'dart:async';

class MyClass {
  final List<int> _list = [];

  void addToList(int value) {
    _list.add(value);
  }

  void dispose() {
    _list.clear();
  }
}

void main() {
  final completer = Completer<void>();
  final myClass = MyClass();

  for (int i = 0; i < 100000; i++) {
    myClass.addToList(i);
  }


  /// new account added

  // We no longer need the MyClass instance, but it is not garbage collected
  // because the _list instance variable is still referenced by the MyClass instance.

  myClass.dispose(); // Clear the list to free up memory
  print(myClass._list);

  // Release the reference to myClass to allow it to be garbage collected
  Future(
    () => completer.complete(),
  ).then(
    (_) => myClass.dispose(),
  );

  completer.future.then((_) {
    // The MyClass instance and its _list instance variable are now eligible
    // for garbage collection.
    print('Memory leak avoided');
  });
}
