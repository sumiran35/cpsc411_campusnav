//
//  CampusSearchViewModel.swift
//  CampusNav
//
//  Created by csuftitan on 12/11/25.
//

import Foundation
import Combine
@MainActor
class CampusSearchViewModel: ObservableObject {
    @Published var query = ""
    @Published var results: [CampusBuilding] = []

    func search(_ buildings: [CampusBuilding]) {
        if query.isEmpty {
            results = []
            return
        }
        results = buildings.filter {
            $0.name.lowercased().contains(query.lowercased())
        }
    }
}
