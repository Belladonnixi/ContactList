//
//  ContactListViewModel.swift
//  ContactList
//
//  Created by Jessica Ernst on 06.10.22.
//  Copyright © 2022 Jessica Ernst. All rights reserved.
//

import CoreData
import SwiftUI

struct ContactListViewModel {
    
    func deleteItems(
        for offsets: IndexSet,
        contacts: FetchedResults<Contact>,
        viewContext: NSManagedObjectContext
    ) {
        
        offsets.map { contacts[$0] }.forEach(viewContext.delete)
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
