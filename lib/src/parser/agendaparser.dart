import 'package:icalendar_parser/icalendar_parser.dart';
import 'package:lyon1agenda/src/model/agenda.dart';
import 'package:lyon1agenda/src/model/event.dart';

class AgendaParser {
  Future<Agenda?> parseICS(final String icsString) async {
    if (icsString.isEmpty) return null;

    final ICalendar iCal = ICalendar.fromString(icsString);
    final dynamic icsJSON = iCal.toJson()['data'];
    final List<Event> events = [];
    for (final dynamic eventJSON in icsJSON) {
      events.add(Event.fromJSON(eventJSON));
    }

    return Agenda(events);
  }
}
