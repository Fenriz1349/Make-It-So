//
//  Repositories+Injection.swift
//  Make It So
//
//  Created by Julien Cotte on 13/03/2026.
//

import Foundation
import Factory

extension Container {

    public var remindersRepository: Factory<RemindersRepository> {
        self {
            RemindersRepository()
        }.singleton
    }
}
