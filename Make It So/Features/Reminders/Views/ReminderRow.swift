//
//  ReminderRow.swift
//  Make It So
//
//  Created by Julien Cotte on 13/03/2026.
//

import SwiftUI

struct ReminderRow: View {
    
    @Binding var reminder: Reminder

    var body: some View {
        HStack {
            Toggle(isOn: $reminder.isCompleted) { /* empty on purpose */ }
                .toggleStyle(.reminder)
            Text(reminder.title)
        }
    }
}

struct RemindersListRowView_Previews: PreviewProvider {
  struct Container: View {
    @State var reminder = Reminder.samples[0]
    var body: some View {
      List {
          ReminderRow(reminder: $reminder)
      }
    }
  }


  static var previews: some View {
    NavigationStack {
      Container()
        .listStyle(.plain)
        .navigationTitle("Reminder")
    }
  }
}
