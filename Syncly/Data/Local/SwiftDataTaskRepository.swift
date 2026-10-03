//
//  SwiftDataTaskRepository.swift
//  Syncly
//
//  Created by Punam Nandi on 03/10/26.
//

import Foundation
import SwiftData

@MainActor
final class SwiftDataTaskRepository: TaskRepository {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchTasks() async throws -> [Tasks] {
        let descriptor = FetchDescriptor<TaskEntity>(
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
        
        let entities = try modelContext.fetch(descriptor)
        
        return entities.map { $0.toDomain() }
    }
    
    func createTask(title: String, description: String) async throws -> Tasks {
        let task = Tasks(
            id: UUID(),
            title: title,
            description: description,
            isCompleted: false,
            createdAt: Date(),
            updatedAt: Date()
        )
        
        let entity = TaskEntity(task: task)
        modelContext.insert(entity)
        
        try modelContext.save()
        return task
    }
    
    func updateTask(_ task: Tasks) async throws {
        let taskId = task.id
        let descriptor = FetchDescriptor<TaskEntity>(
            predicate: #Predicate {
                $0.id == taskId
            }
        )
        
        guard let entity = try modelContext.fetch(descriptor).first else {
            throw RepositoryError.notFound
        }
        
        entity.title = task.title
        entity.taskDescription = task.description
        entity.isCompleted = task.isCompleted
        entity.updatedAt = task.updatedAt
        
        try modelContext.save()
    }
    
    func deleteTask(_ task: Tasks) async throws {
        let taskId = task.id
        let descriptor = FetchDescriptor<TaskEntity>(
            predicate: #Predicate {
                $0.id == taskId
            }
        )
        
        guard let entity = try modelContext.fetch(descriptor).first else {
            throw RepositoryError.notFound
        }
        
        modelContext.delete(entity)
        
        try modelContext.save()
    }
}
