//
//  MemoryController.swift
//  Memories
//
//  Created by Jonathan T. Miles on 8/1/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import Foundation

class MemoryController {
    
    // Create ... with saveToPersistentStore()
    func createMemory(withTitle title: String, bodyText: String, imageData: Data) {
        let memory = Memory(title: title, bodyText: bodyText, imageData: imageData)
        memories.append(memory)
        saveToPersistentStore()
    }
    
    // Update ... with saveToPersistentStore()
    func updateMemory(memory: Memory, withTitle title: String, bodyText: String, imageData: Data) {
        var scratch = memory
        scratch.title = title
        scratch.bodyText = bodyText
        scratch.imageData = imageData
        guard let index = memories.index(of: memory) else { return }
        memories.remove(at: index)
        memories.insert(scratch, at: index)
        saveToPersistentStore()
    }
    
    // Delete ... with saveToPersistentStore()
    func deleteMemory(memory: Memory) {
        guard let index = memories.index(of: memory) else { return }
        memories.remove(at: index)
        saveToPersistentStore()
    }
    
    // Read
    var memories: [Memory] = []
    
    // Persistence
    func saveToPersistentStore() {
        guard let url = persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(memories)
            try data.write(to: url)
        } catch {
            NSLog("Error saving memories data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fm = FileManager.default
        guard let url = persistentFileURL, fm.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data (contentsOf: url)
            let decoder = PropertyListDecoder()
            memories = try decoder.decode([Memory].self, from: data)
        } catch {
            NSLog("Error loading memories data: \(error)")
        }
    }
    
    private var persistentFileURL: URL? {
        let fm = FileManager.default
        guard let documentsDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentsDir.appendingPathComponent("memories.plist")
    }
}
