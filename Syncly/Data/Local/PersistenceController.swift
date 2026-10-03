//
//  PersistenceController.swift
//  Syncly
//
//  Created by Punam Nandi on 03/10/26.
//

import Foundation
import SwiftData

//@MainActor --> why this is happening in MainActor?
final class PersistenceController {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: TaskEntity.self)
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }
}
