//
//  ContentView.swift
//  Make It So
//
//  Created by Julien Cotte on 13/03/2026.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isAddReminderDialogPresented = false
    @State private var reminders = Reminder.samples

    private func presentAddReminderView() {
       isAddReminderDialogPresented.toggle()
     }

    var body: some View {
        List($reminders) { $reminder in
            HStack {
                Image(systemName: reminder.isCompleted ? "largecircle.fill.circle" : "circle")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                    .onTapGesture {
                        reminder.isCompleted.toggle()
                    }
                Spacer()
                Text(reminder.title)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button(action: presentAddReminderView) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("New Reminder")
                    }
                }
                Spacer()
            }
        }
        .sheet(isPresented: $isAddReminderDialogPresented) {
            AddReminderView { reminder in
                reminders.append(reminder)
                
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
            .navigationTitle("Reminders")
    }
}
