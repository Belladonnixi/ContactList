//
//  ContactListApp.swift
//  ContactList
//
//  Created by Jessica Ernst on 29.09.22.
//

import SwiftUI

@main
struct ContactListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
