import 'package:args/args.dart';
import 'package:ndmg/command/base_command.dart';
import 'package:ndmg/command/global_options.dart';

class CommandRegistry {
  static final CommandRegistry _instance = CommandRegistry._();
  CommandRegistry._();

  static CommandRegistry get instance => _instance;

  final Map<String, BaseCommand> _commands = {};

  ArgParser buildParser() {
    final parser = ArgParser();
    GlobalOptions.instance.buildParser(parser);

    for (var command in _commands.values) {
      parser.addCommand(command.name, command.buildParser());
    }

    return parser;
  }

  void registerCommand(BaseCommand command) {
    _commands[command.name] = command;
  }

  BaseCommand? getCommand(String name) {
    return _commands[name];
  }
}
