//
//  ReminderError.swift
//  Make It So
//
//  Created by Julien Cotte on 13/03/2026.
//

import Foundation

enum ReminderError: LocalizedError {
    case missingDocumentId(String)
    
    var errorDescription: String? {
        switch self {
        case .missingDocumentId(let title): return "Reminder \(title) has no document ID."
        }
    }
}
