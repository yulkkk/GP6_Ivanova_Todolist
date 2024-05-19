//
//  Reminder.swift
//  GP6_Ivanova_Todolist
//
//  Created by Юлия Иванова on 07.05.2024.
//

import Foundation
import SwiftData

@Model
final class Reminder{
    var name: String
    var isCompleted = false
    
    init(name: String, isCompleted: Bool = false) {
        self.name = name
        self.isCompleted = isCompleted
    }
}
