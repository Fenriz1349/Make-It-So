//
//  RemindersRepository.swift
//  Make It So
//
//  Created by Julien Cotte on 13/03/2026.
//

import Combine
import FirebaseFirestore

public class RemindersRepository: ObservableObject {

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
            let query = Firestore.firestore().collection(Reminder.collectionName)

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
        try Firestore.firestore()
        // Path vers la collection firestore qui va stocker les reminders
            .collection("reminders")
        // Methode pour ajouter un document dans la collection
            .addDocument(from: reminder)
    }
}
