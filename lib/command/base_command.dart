import 'dart:async';

import 'package:args/args.dart';

abstract class BaseCommand {
  FutureOr execute(ArgResults results);
  String get name;
  ArgParser buildParser();
}
