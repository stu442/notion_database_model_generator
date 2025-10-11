import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:ndmg/command/base_command.dart';

class GenerateCommand extends BaseCommand {
  @override
  ArgParser buildParser() {
    return ArgParser()
      ..addFlag('help', abbr: 'h', help: 'Show help information');
  }

  @override
  FutureOr execute(ArgResults results) {
    if (results['help'] as bool) {
      stdout.writeln('Generate command');
      return null;
    }
  }

  @override
  String get name => 'generate';
}
