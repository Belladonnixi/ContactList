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
    
    @State private var addViewShown = false
        
    let backgroundGradient = LinearGradient(
        colors: [Color.teal, Color.blue],
        startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        NavigationView {
         
            List {
                ForEach(contacts) { contact in
                    NavigationLink {
                        AddContact(contactId: contact.objectID)
                    } label: {
                        ContactRow(contact: contact)
                    }
                }
                .onDelete { indexSet in
                    withAnimation {
                       deleteItems(offsets: indexSet)
                    }
                }
                .listRowBackground(backgroundGradient)
                
            }
            .toolbar {
                Button {
                    addViewShown = true
                } label: {
                    Image(systemName: "plus.circle")
                }
            }
            .sheet(isPresented: $addViewShown) {
                AddContact()
            }
            .navigationTitle("Contact List")
        }
    }
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { contacts[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
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
