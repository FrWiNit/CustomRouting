//
//  AnyDestination.swift
//  ArchitectureBootcamp
//
//  Created by Александр Раевский on 16/2/26.
//
import SwiftUI

// NOTE: Marked as @unchecked Sendable because it wraps UI types (AnyView) and is only passed across boundaries on the main actor for presentation.
struct AnyDestination: Hashable, @unchecked Sendable {
    let id = UUID().uuidString
    var destination: AnyView
    
    init<T: View>(destination: T) {
        self.destination = AnyView(destination)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: AnyDestination, rhs: AnyDestination) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

