//
//  Memory.swift
//  Memories
//
//  Created by Jonathan T. Miles on 8/1/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import Foundation

struct Memory: Codable, Equatable {
    
    var title: String
    var bodyText: String
    var imageData: Data
    
}
