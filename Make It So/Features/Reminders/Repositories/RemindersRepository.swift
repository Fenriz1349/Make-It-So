//
//  RemindersRepository.swift
//  Make It So
//
//  Created by Julien Cotte on 13/03/2026.
//

import Combine
import Factory
import FirebaseFirestore

public class RemindersRepository: ObservableObject {

    // MARK: - Dependencies
      @Injected(\.firestore) var firestore

    private var listenerRegistration: ListenerRegistration?

    @Published var reminders = [Reminder]()

    init() {
        subscribe()
    }

    deinit {
        unsubscribe()
    }

    func subscribe() {
        if listenerRegistration == nil {
            let query = firestore.collection(Reminder.collectionName)

            listenerRegistration = query.addSnapshotListener { [weak self] (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }

                print("Mapping \(documents.count) documents")
                self?.reminders = documents.compactMap { queryDocumentSnapshot in
                    do {
                        return try queryDocumentSnapshot.data(as: Reminder.self)
                    }
                    catch {
                        print("Error while trying to map document \(queryDocumentSnapshot.documentID): \(error.localizedDescription)")
                        return nil
                    }
                }
            }
        }
    }
    
    private func unsubscribe() {
       if listenerRegistration != nil {
         listenerRegistration?.remove()
         listenerRegistration = nil
       }
     }

    func addReminder(_ reminder: Reminder) throws {
        try firestore
        // Path vers la collection firestore qui va stocker les reminders
            .collection("reminders")
        // Methode pour ajouter un document dans la collection
            .addDocument(from: reminder)
    }
    
    func updateReminder(_ reminder: Reminder) throws {
        guard let documentId = reminder.id else {
            throw ReminderError.missingDocumentId(reminder.title)
        }
        try firestore
            .collection(Reminder.collectionName)
            .document(documentId)
            .setData(from: reminder, merge: true)
    }
    
    func removeReminder(_ reminder: Reminder) throws {
        guard let documentId = reminder.id else {
            throw ReminderError.missingDocumentId(reminder.title)
        }
        firestore
            .collection(Reminder.collectionName)
            .document(documentId)
            .delete()
    }
}
