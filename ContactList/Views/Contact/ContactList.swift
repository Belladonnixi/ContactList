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
    
    let viewModel = ContactListViewModel()
        
    let backgroundGradient = LinearGradient(
        colors: [Color.teal, Color.blue],
        startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        NavigationView {
         
            List {
                ForEach(contacts) { contact in
                    NavigationLink {
                        AddContactView(contactId: contact.objectID)
                    } label: {
                        ContactRow(contact: contact)
                    }
                }
                .onDelete { indexSet in
                    withAnimation {
                        viewModel.deleteItems(
                            for: indexSet,
                            contacts: contacts,
                            viewContext: viewContext
                        )
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
                AddContactView()
            }
            .navigationTitle("Contact List")
        }
    }
}




struct ContactList_Previews: PreviewProvider {
    static var previews: some View {
        ContactList().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
