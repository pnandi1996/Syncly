//
//  TaskRepository.swift
//  Syncly
//
//  Created by Punam Nandi on 03/10/26.
//

import Foundation

protocol TaskRepository {
    func fetchTasks() async throws -> [Tasks]
    
    func createTask(title: String, description: String) async throws -> Tasks
    
    func updateTask(_ task: Tasks) async throws
    
    func deleteTask(_ task: Tasks) async throws
}
