//
//  GP6_Ivanova_TodolistApp.swift
//  GP6_Ivanova_Todolist
//
//  Created by Юлия Иванова on 09.03.2024.
//

import SwiftUI
import SwiftData

@main
struct GP6_Ivanova_TodolistApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: ReminderList.self)
    }
}
