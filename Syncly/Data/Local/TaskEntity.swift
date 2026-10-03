//
//  TaskEntity.swift
//  Syncly
//
//  Created by Punam Nandi on 03/10/26.
//

import Foundation
import SwiftData

@Model
final class TaskEntity {
    @Attribute(.unique)
    var id: UUID
    
    var title: String
    var taskDescription: String
    var isCompleted: Bool
    
    var createdAt: Date
    var updatedAt: Date

    init(
        id: UUID,
        title: String,
        taskDescription: String,
        isCompleted: Bool,
        createdAt: Date,
        updatedAt: Date
    ) {
        self.id = id
        self.title = title
        self.taskDescription = taskDescription
        self.isCompleted = isCompleted
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

extension TaskEntity {
    convenience init(task: Tasks) {
        self.init(
            id: task.id,
            title: task.title,
            taskDescription: task.description,
            isCompleted: task.isCompleted,
            createdAt: task.createdAt,
            updatedAt: task.updatedAt
        )
    }
    
    func toDomain() -> Tasks {
        Tasks(
            id: id,
            title: title,
            description: taskDescription,
            isCompleted: isCompleted,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
}
