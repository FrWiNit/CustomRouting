//
//  RouterView.swift
//  ArchitectureBootcamp
//
//  Created by Александр Раевский on 16/2/26.
//
import SwiftUI

@MainActor
public struct RouterView<Content: View>: View, @MainActor Router {
    @Environment(\.dismiss) var dismiss
    @State private var path: [AnyDestination] = []
    @State private var showSheet: AnyDestination? = nil
    @State private var showFullScreenCover: AnyDestination? = nil
    @State private var alert: AnyAppAlert? = nil
    @State private var alertOption: AlertType = .alert
    @State private var modalBackgroundColor: Color = Color.black.opacity(0.6)
    @State private var modalTransition: AnyTransition = AnyTransition.opacity
    @State private var modal: AnyDestination? = nil
    
    @Binding var screenStack: [AnyDestination]
    
    var addNavigationView: Bool = true
    @ViewBuilder var content: (Router) -> Content
    
    init(
        screenStack: (Binding<[AnyDestination]>)? = nil,
        addNavigationView: Bool = true,
        content: @escaping (Router) -> Content
    ) {
        self._screenStack = screenStack ?? .constant([])
        self.addNavigationView = addNavigationView
        self.content = content
    }
    
    public var body: some View {
        NavigationstackIfNeeded(path: $path, addNavigationView: addNavigationView) {
            content(self)
                .sheetViewModifier(screen: $showSheet)
                .fullScreenCoverViewModifier(screen: $showFullScreenCover)
                .showCustomAlert(type: alertOption, alert: $alert)
        }
        .modalViewModifier(backgroundColor: modalBackgroundColor, transition: modalTransition, screen: $modal)
        .environment(\.router, self)
    }
    
    public func showScreen<T: View>(_ option: SegueOption, @ViewBuilder destination: @escaping (Router) -> T) {
        let screen = RouterView<T>(
            screenStack: option.shouldAddNewNavigationView ? nil : (screenStack.isEmpty ? $path : $screenStack),
            addNavigationView: option.shouldAddNewNavigationView
        ) { newRouter in
            destination(newRouter)
        }
        
        let destination = AnyDestination(destination: screen)
        
        switch option {
        case .push:
            if screenStack.isEmpty {
                path.append(destination)
            } else {
                screenStack.append(destination)
            }
        case .sheet:
            showSheet = destination
        case .fullScreenCover:
            showFullScreenCover = destination
        }
    }
    
    public func dismissScreen() {
        dismiss()
    }
    
    public func showAlert(_ option: AlertType, title: String, subtitle: String? = nil, buttons: (@Sendable () -> AnyView)? = nil) {
        self.alertOption = option
        self.alert = AnyAppAlert(title: title, subtitle: subtitle, buttons: buttons)
    }
    
    public func dismissAlert() {
        alert = nil
    }
    
    public func showModal<T: View>(backgroundColor: Color, transition: AnyTransition, @ViewBuilder destination: @escaping () -> T) {
        self.modalBackgroundColor = backgroundColor
        self.modalTransition = transition
        let destination = AnyDestination(destination: destination())
        self.modal = destination
    }
    
    public func dismissModal() {
        modal = nil
    }
}

