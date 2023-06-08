//
//  SearchPageView.swift
//  Tugan Zher
//
//  Created by Beket Muratbek on 08.06.2023.
//

import SwiftUI

struct SearchPageView: View {
    @State var server_text = ""
    @State var countries: [Country] = []
    @State var cities: [City] = []
    @State var selectedCountry: Country?
    @State var selectedCity: City?
    @State var selected_check_in_date = Date.now
    @State var selected_check_out_date = Date.now
    var body: some View {
        List {
            Picker("Country", selection: $selectedCountry) {
                ForEach(countries, id: \.id) { country in
                    Text(country.name).tag(country.name)
                }
            }
            Picker("City", selection: $selectedCity) {
                ForEach(cities, id: \.id) { city in
                    Text(city.name)
                }
            }
            DatePicker(selection: $selected_check_in_date, in: ...Date.now, displayedComponents: .date) {
                Text("Check-in date")
            }
            DatePicker(selection: $selected_check_out_date, in: ...Date.now, displayedComponents: .date) {
                Text("Check-out date")
            }
    //        Text(countries)
                .onAppear {
                    fetchCountryFromServer()
                    fetchCityFromServer()
            }
        }
    }
    
    func fetchCountryFromServer() {
            guard let url = URL(string: "http://127.0.0.1:8000/api/country") else {
                return
            }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error fetching text: \(error.localizedDescription)")
                    return
                }
                
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let contries = try decoder.decode([Country].self, from: data)
                        DispatchQueue.main.async {
                            print("rating: \(contries)")
                            self.countries = contries
                            //                            String(country?.name ?? "")
                            print(countries)
                        }
                    } catch {
                        print("Error \(error.localizedDescription)")
                    }
                }
            }.resume()
        }
    
    func fetchCityFromServer() {
            guard let url = URL(string: "http://127.0.0.1:8000/api/city") else {
                return
            }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error fetching text: \(error.localizedDescription)")
                    return
                }
                
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let cityes = try decoder.decode([City].self, from: data)
                        DispatchQueue.main.async {
                            print("rating: \(cityes)")
                            self.cities = cityes
                            //                            String(country?.name ?? "")
                            print(cities)
                        }
                    } catch {
                        print("Error \(error.localizedDescription)")
                    }
                }
            }.resume()
        }
}

struct SearchPageView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPageView()
    }
}
