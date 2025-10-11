import 'dart:io';

import 'dart:mirrors';

import 'package:ndmg/command/command_registry.dart';
import 'package:ndmg/command/generate_command.dart';
import 'package:ndmg/command/global_options.dart';

void main(List<String> arguments) {
  CommandRegistry.instance.registerCommand(GenerateCommand());
  final parser = CommandRegistry.instance.buildParser();

  try {
    final results = parser.parse(arguments);

    // first Global Options should be executed
    if (GlobalOptions.instance.executeOptions(results, parser)) {
      return;
    }

    // Handle commands
    if (results.command != null) {
      CommandRegistry.instance
          .getCommand(results.command!.name ?? "")!
          .execute(results.command!);
    } else {
      _showInteractiveMenu();
    }
  } catch (e) {
    stderr.writeln('Error: $e');
    GlobalOptions.instance.showHelp(parser);
    exitCode = 1;
  }
}

void _showInteractiveMenu() {
  stdout.writeln('=== Notion Database Model Generator ===');
  stdout.writeln('');
  stdout.writeln('Select an option:');
  stdout.writeln('1. Generate Model');
  stdout.writeln('2. Generate API');
  stdout.writeln('3. Initialize Configuration');
  stdout.writeln('4. Show Help');
  stdout.writeln('5. Exit');
  stdout.writeln('');
  stdout.write('Enter your choice (1-5): ');

  final input = stdin.readLineSync();

  switch (input) {
    case '1':
      _interactiveGenerateModel();
      break;
    case '2':
      _interactiveGenerateApi();
      break;
    case '3':
      _interactiveInit();
      break;
    case '4':
      break;
    case '5':
      stdout.writeln('Goodbye!');
      break;
    default:
      stderr.writeln('Invalid choice. Please enter 1-5.');
      exitCode = 1;
  }
}

void _interactiveGenerateModel() {
  stdout.write('Enter Notion database ID: ');
  final databaseId = stdin.readLineSync();

  if (databaseId == null || databaseId.isEmpty) {
    stderr.writeln('Database ID is required');
    exitCode = 1;
    return;
  }

  stdout.write('Enter output directory (default: ./lib/models): ');
  final output = stdin.readLineSync() ?? './lib/models';

  stdout.writeln('Generating model for database: $databaseId');
  stdout.writeln('Output directory: $output');
  // TODO: Implement model generation
}

void _interactiveGenerateApi() {
  stdout.write('Enter Notion database ID: ');
  final databaseId = stdin.readLineSync();

  if (databaseId == null || databaseId.isEmpty) {
    stderr.writeln('Database ID is required');
    exitCode = 1;
    return;
  }

  stdout.write('Enter output directory (default: ./lib/api): ');
  final output = stdin.readLineSync() ?? './lib/api';

  stdout.writeln('Generating API client for database: $databaseId');
  stdout.writeln('Output directory: $output');
  // TODO: Implement API generation
}

void _interactiveInit() {
  stdout.writeln('Initializing ndmg configuration...');
  // TODO: Implement configuration initialization
}

// Future<void> dcat(List<String> paths, {bool showLineNumbers = false}) async {
//   if (paths.isEmpty) {
//     // No files provided as arguments. Read from stdin and print each line.
//     await stdin.pipe(stdout);
//   } else {
//     for (final path in paths) {
//       var lineNumber = 1;
//       final lines = utf8.decoder
//           .bind(File(path).openRead())
//           .transform(const LineSplitter());
//       try {
//         await for (final line in lines) {
//           if (showLineNumbers) {
//             stdout.write('${lineNumber++} ');
//           }
//           stdout.writeln(line);
//         }
//       } catch (_) {
//         await _handleError(path);
//       }
//     }
//   }
// }

// Future<void> _handleError(String path) async {
//   if (await FileSystemEntity.isDirectory(path)) {
//     stderr.writeln('error: $path is a directory');
//   } else {
//     exitCode = 2;
//   }
// }

T getAnnotation<T>(DeclarationMirror declaration) {
  for (var instance in declaration.metadata) {
    if (instance.hasReflectee) {
      var reflectee = instance.reflectee;
      if (reflectee.runtimeType == T) {
        return reflectee;
      }
    }
  }

  throw Exception('Annotation $T not found');
}
