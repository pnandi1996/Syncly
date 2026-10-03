//
//  Task.swift
//  Syncly
//
//  Created by Punam Nandi on 03/10/26.
//

import Foundation

struct Tasks: Identifiable {
    let id: UUID
    var title: String
    var description: String
    var isCompleted: Bool
    let createdAt: Date
    var updatedAt: Date
}
