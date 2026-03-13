//
//  Reminder.swift
//  Make It So
//
//  Created by Julien Cotte on 13/03/2026.
//

import Foundation

struct Reminder: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted = false
}

extension Reminder {
  static let samples = [
    Reminder(title: "Build sample app", isCompleted: true),
    Reminder(title: "Create tutorial"),
    Reminder(title: "???"),
    Reminder(title: "PROFIT!"),
  ]
}
