//
//  ContactList.swift
//  ContactList
//
//  Created by Jessica Ernst on 29.09.22.
//

import SwiftUI

struct ContactList: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var contacts: FetchedResults<Contact>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(contacts) { contact in
                    Text("\(contact.name ?? "") \(contact.lastName ?? "")")
                }
                .navigationTitle("Contact List")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { contacts[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}




struct ContactList_Previews: PreviewProvider {
    static var previews: some View {
        ContactList().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
