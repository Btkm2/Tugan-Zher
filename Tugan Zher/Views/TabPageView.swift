//
//  TabPageView.swift
//  Tugan Zher
//
//  Created by Beket Muratbek on 05.06.2023.
//

import SwiftUI

struct TabPageView: View {
    var body: some View {
        TabView {
            ContentView()
                .badge("!")
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            AccountPageView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
            SearchPageView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}

struct TabPageView_Previews: PreviewProvider {
    static var previews: some View {
        TabPageView()
    }
}
