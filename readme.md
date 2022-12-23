# ADE ICal Client
An ICal Client for ADE Lyon 1

![test result](https://github.com/onyx-lyon1/lyon1-agendaclient/actions/workflows/dart.yml/badge.svg)

# Adding it to your project
```bash
dart pub get https://github.com/clementherve/lyon1-agendaclient
```

# Example
```dart
final Lyon1Agenda agendaClient = Lyon1Agenda();
final Agenda? agendaOpt =
    await agendaClient.getAgenda(url: "http://<url>");
if (agendaOpt.isNone()) {
    // handle gracefully
}
final Agenda agenda = agendaOpt ?? Agenda.empty();

for (final Event e in agenda.events) {
    print(e.name);
    print("\t${e.location} | ${e.teacher}");
    print("\t${e.start.toString()} -> ${e.end.toString()}");
}
```
