//
//  SegueOption.swift
//  ArchitectureBootcamp
//
//  Created by Александр Раевский on 16/2/26.
//
public enum SegueOption {
    case push, sheet, fullScreenCover
    
    var shouldAddNewNavigationView: Bool {
        switch self {
        case .push:
            return false
        case .sheet, .fullScreenCover:
            return true
        }
    }
}
