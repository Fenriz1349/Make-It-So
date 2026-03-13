//
//  RemindersListViewModel.swift
//  Make It So
//
//  Created by Julien Cotte on 13/03/2026.
//

import Foundation
import Combine

class RemindersListViewModel: ObservableObject {

    private var remindersRepository: RemindersRepository =  RemindersRepository()
    @Published var reminders = [Reminder]()
    @Published var errorMessage: String?

    init() {
        remindersRepository
          .$reminders
          .assign(to: &$reminders)
      }

    func addReminder(_ reminder: Reminder) {
        do {
            try remindersRepository.addReminder(reminder)
            errorMessage = nil
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
        }
    }

    func toggleCompleted(_ reminder: Reminder) {
        if let index = reminders.firstIndex(where: { $0.id == reminder.id} ) {
            reminders[index].isCompleted.toggle()
        }
    }
}
