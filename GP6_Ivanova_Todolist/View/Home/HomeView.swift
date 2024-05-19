//
//  ContentView.swift
//  GP6_Ivanova_Todolist
//
//  Created by Юлия Иванова on 09.03.2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var reminderList: [ReminderList]
    @State private var path = [ReminderList]()
    
    let coluns = [GridItem(.adaptive(minimum: 150))]
    
    var body: some View {
        NavigationStack(path: $path){
            VStack {
                List {
                    Section{
                        VStack{
                            LazyVGrid(columns: coluns, spacing: 10){
                                ForEach(reminderList.prefix(4)) { reminders in
                                    ListCardView(reminderList: reminders)
                                }
                            }
                        }
                    }
                    .listRowBackground(Color(UIColor.systemGroupedBackground))
                    .listRowInsets(EdgeInsets())
                    
                    Section{
                        ForEach(reminderList){ reminders in
                            NavigationLink{
                                ReminderListView(reminderList: reminders)
                            } label:{
                                ReminderListRowView(reminderList: reminders)
                            }
                            .listRowInsets(EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 15))
                            
                        }
                        .onDelete(perform: delete)
                    } header:{
                        Text("My lists")
                            .font(.system(.title3, design: .rounded,weight: .bold))
                            .foregroundColor(.primary)
                    }
                }
            }
            .navigationTitle("Reminders")
            .navigationDestination(for: ReminderList.self, destination: CreateSectionView.init)
            .toolbar{
                Button("Add section", systemImage: "plus", action: addSection)
            }
            .overlay {
                Group {
                    if reminderList.isEmpty {
                        ContentUnavailableView(label:{
                            Label("No reminders", systemImage: "list.bullet.rectangle.portrait")
                        }, description: {
                            Text("Start adding reminders to see your list")
                        }, actions: {
                            Button("Add Reminder", action: addSection)
                        })
                        .offset(y:-60)
                    }
                }
            }
        }
    }
    func addSection(){
        let section = ReminderList()
        modelContext.insert(section)
        path = [section]
    }
    
    func delete(_ indexSet: IndexSet){
        for index in indexSet{
            let reminderLists = reminderList[index]
            modelContext.delete(reminderLists)
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: ReminderList.self, inMemory: true)
}
