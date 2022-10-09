///
///  ContactListApp.swift
///  ContactList
///
///  Created by Jessica Ernst on 29.09.22.
///  Copyright © 2022 Jessica Ernst. All rights reserved.
///

import SwiftUI

@main
struct ContactListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContactList()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//            AddContact()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
