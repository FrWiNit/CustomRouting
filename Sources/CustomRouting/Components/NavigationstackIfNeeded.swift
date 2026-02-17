//
//  NavigationstackIfNeeded.swift
//  ArchitectureBootcamp
//
//  Created by Александр Раевский on 16/2/26.
//
import SwiftUI

struct NavigationstackIfNeeded<Content: View>: View {
    @Binding var path: [AnyDestination]
    var addNavigationView: Bool = true
    @ViewBuilder var content: Content
    
    var body: some View {
        if addNavigationView {
            NavigationStack(path: $path) {
                content
                    .navigationDestination(for: AnyDestination.self) { value in
                        value.destination
                    }
            }
        } else {
            content
        }
    }
}
