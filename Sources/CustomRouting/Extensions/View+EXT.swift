//
//  View+EXT.swift
//  ArchitectureBootcamp
//
//  Created by Александр Раевский on 16/2/26.
//
import SwiftUI

extension View {
    func any() -> AnyView {
        AnyView(self)
    }
}
