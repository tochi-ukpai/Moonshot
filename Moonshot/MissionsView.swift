//
//  MissionsView.swift
//  Moonshot
//
//  Created by Theós on 04/06/2023.
//

import SwiftUI

struct MissionsView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [GridItem(.adaptive(minimum: 150))]
    
    @State private var isGridView = true
    
    var body: some View {
        NavigationView {
            Group {
                if isGridView {
                    gridView
                } else {
                    listView
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button {
                    isGridView.toggle()
                } label: {
                    Image(systemName: isGridView ? "list.bullet" : "square.grid.2x2")
                }
            }
        }
    }
    
    var gridView: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                missionCards
            }
            .padding([.horizontal, .bottom])
        }
    }
    
    var listView: some View {
        List {
            missionCards
        }
            .scrollContentBackground(.hidden)
    }
    
    var missionCards: some View {
        ForEach(missions) { mission in
            NavigationLink {
                MissionView(mission: mission, astronauts: astronauts)
            } label: {
                if isGridView {
                    gridViewCard(for: mission)
                } else {
                    listViewCard(for: mission)
                }
            }
        }
        .listRowBackground(Color.lightBackground)
    }
    
    func gridViewCard(for mission: Mission) -> some View {
        VStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()
            
            VStack {
                summary(for: mission)
            }
            .foregroundColor(.white)
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(.lightBackground)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(.lightBackground)
        }
    }
    
    func listViewCard(for mission: Mission) -> some View {
        HStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                summary(for: mission)
            }
            .foregroundColor(.white)
        }
    }
    
    @ViewBuilder
    func summary(for mission: Mission) -> some View {
        Text(mission.displayName)
            .font(.headline)
        Text(mission.formattedLaunchDate)
            .font(.caption)
            .opacity(0.5)
    }
}

struct MissionsView_Previews: PreviewProvider {
    static var previews: some View {
        MissionsView()
    }
}
