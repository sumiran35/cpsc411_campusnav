import SwiftUI

struct BuildingListView: View {
    var body: some View {
        NavigationView {
            List(sampleBuildings) { building in
                HStack {
                    Image(systemName: building.type.rawValue)
                        .foregroundColor(.blue)
                        .font(.title2)
                        .frame(width: 30)
                    
                    VStack(alignment: .leading) {
                        Text(building.name)
                            .font(.headline)
                        Text(building.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                    }
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("Campus Directory")
        }
    }
}
