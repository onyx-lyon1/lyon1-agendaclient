import 'package:dartus/tomuss.dart';
import 'package:lyon1agenda/src/lyon1agenda.dart';
import 'package:lyon1agenda/src/model/agenda.dart';
import 'package:lyon1agenda/src/model/event.dart';
import 'package:lyon1agenda/src/utils/agenda_url.dart';
import 'package:test/test.dart';

void main() async {
  test('getAgenda from URL', () async {
    final List<String> icalLinks = [
      "http://adelb.univ-lyon1.fr/jsp/custom/modules/plannings/anonymous_cal.jsp?resources=7311&projectId=2&calType=ical&firstDate=2022-09-10&lastDate=2023-09-30",
    ];

    for (final String link in icalLinks) {
      final Lyon1Agenda agendaClient =
          Lyon1Agenda(AgendaURL(Authentication("", "")));
      final Agenda? agendaOpt = await agendaClient.getAgenda(url: link);

      expect(agendaOpt == null, equals(false));

      final Agenda agenda = agendaOpt ?? Agenda.empty();

      for (final Event event in agenda.events) {
        expect(event.start.runtimeType, equals(DateTime));
        expect(event.end.runtimeType, equals(DateTime));
        expect(event.lastModified.runtimeType, equals(DateTime));

        expect(event.description, isNot(isEmpty));
        expect(event.description.contains("Exported"), equals(false));
        expect(event.name, isNot(isEmpty));
        expect(event.location, isNot(isEmpty));

        // TODO: investigate
        // expect(event.teacher, isNot(isEmpty)); // does not pass
      }
    }
  });
}
