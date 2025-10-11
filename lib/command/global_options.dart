import 'dart:io';
import 'dart:io' as rootBundle;

import 'package:args/args.dart';

class GlobalOptions {
  static GlobalOptions? _instance;
  GlobalOptions._();
  static GlobalOptions get instance => _instance ??= GlobalOptions._();

  void buildParser(ArgParser parser) {
    parser.addFlag('help', abbr: 'h', help: 'Show help information');
    parser.addFlag('version', abbr: 'v', help: 'Show version information');
  }

  /// Excute Successfully if any of the options are true
  bool executeOptions(ArgResults results, ArgParser parser) {
    if (results['help'] as bool) {
      showHelp(parser);
      return true;
    } else if (results['version'] as bool) {
      showVersion();
      return true;
    }
    return false;
  }

  void showHelp(ArgParser parser) {
    stdout.writeln('Notion Database Model Generator (ndmg)');
    stdout.writeln('');
    stdout.writeln('Usage: ndmg <command> [arguments]');
    stdout.writeln('');
    stdout.writeln('Global options:');
    stdout.writeln(parser.usage);
    stdout.writeln('');
    stdout.writeln('Commands:');
    stdout.writeln(
        '  generate    Generate Dart models or API clients from Notion databases');
    stdout.writeln('  init        Initialize configuration');
    stdout.writeln('');
    stdout.writeln(
        'Run "ndmg <command> --help" for more information about a command.');
  }

  void showVersion() async {
    try {
      final pubspecFile = File('pubspec.yaml');
      final content = pubspecFile.readAsStringSync();

      // version: 1.0.0 찾기
      final versionMatch =
          RegExp(r'^version:\s*(.+)$', multiLine: true).firstMatch(content);

      stdout.writeln('Notion Database Model Generator (ndmg)');
      stdout.writeln('');
      stdout.writeln('Version: ${versionMatch?.group(1)?.trim() ?? 'unknown'}');
    } catch (e) {
      stdout.writeln('Error: $e');
      exitCode = 1;
    }
  }
}
