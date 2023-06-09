//
//  ContentView.swift
//  Tugan Zher
//
//  Created by Beket Muratbek on 31.05.2023.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    @State var image: Image?
    @State var Almaty_image: Image?
    @State var DoubleTree_Hilton_image: Image?
    @State var serverText: String = ""
    @State var hotels: [Hotel] = []
    @State var Almaty_description = ""
    @State var DoubleTree_Hilton_description = ""
    var body: some View {
        Form {
            Section(header: Text("Explore top rated hotels")) {
                TopElements(down_image: $image, fetched_text: $serverText)
            }
            Section {
                VStack(alignment: .leading) {
                    Text(Almaty_description)
                        .font(.system(size: 18, weight: .thin, design: .default))
                    if let image = Almaty_image {
                        image
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    }
                }
            }
            Section {
                VStack {
                    Text(DoubleTree_Hilton_description)
                        .font(.system(size: 18, weight: .thin, design: .default))
                    if let image = DoubleTree_Hilton_image {
                        image
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    }
                }
            }
            Section(header: Text("Tours")) {
                TopTourView()
            }
        }
        .onAppear {
            downloadImage()
            fetchTextFromServer()
            download_second_Image()
            download_third_Image()
            fetchAlmatyTextFromServer()
            fetchDoubleTreeHiltonTextFromServer()
        }
    }
    func downloadImage() {
        //http://127.0.0.1:8000/media/hotel_pictures/2023/04/09/b1n9_ho_00_p_1024x768.jpg.webp
        //http://127.0.0.1:8000/media/tour_pictures/2023/06/04/kolsai.jpg
        guard let url = URL(string: "http://127.0.0.1:8000/media/hotel_pictures/2023/04/09/b1n9_ho_00_p_1024x768.jpg.webp") else {
            return
        }
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let error = error {
                print("Error while dowloading image from server, \(error.localizedDescription)")
                return
            }
            if let data = data, let uiImage = UIImage(data: data) {
                let image = Image(uiImage: uiImage)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
        .resume()
    }
    
    func download_second_Image() {
        //http://127.0.0.1:8000/media/hotel_pictures/2023/04/09/b1n9_ho_00_p_1024x768.jpg.webp
        //http://127.0.0.1:8000/media/tour_pictures/2023/06/04/kolsai.jpg
        guard let url = URL(string: "http://127.0.0.1:8000/media/hotel_pictures/2023/06/08/Almaty.jpeg") else {
            return
        }
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let error = error {
                print("Error while dowloading image from server, \(error.localizedDescription)")
                return
            }
            if let data = data, let uiImage = UIImage(data: data) {
                let image = Image(uiImage: uiImage)
                DispatchQueue.main.async {
                    self.Almaty_image = image
                }
            }
        }
        .resume()
    }
    
    func download_third_Image() {
        //http://127.0.0.1:8000/media/hotel_pictures/2023/04/09/b1n9_ho_00_p_1024x768.jpg.webp
        //http://127.0.0.1:8000/media/tour_pictures/2023/06/04/kolsai.jpg
        guard let url = URL(string: "http://127.0.0.1:8000/media/hotel_pictures/2023/06/08/DoubleTree_By_Hilton_Almaty.jpeg") else {
            return
        }
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let error = error {
                print("Error while dowloading image from server, \(error.localizedDescription)")
                return
            }
            if let data = data, let uiImage = UIImage(data: data) {
                let image = Image(uiImage: uiImage)
                DispatchQueue.main.async {
                    self.DoubleTree_Hilton_image = image
                }
            }
        }
        .resume()
    }
    
    func fetchTextFromServer() {
            guard let url = URL(string: "http://127.0.0.1:8000/api/hotelrating/1/") else {
                return
            }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error fetching text: \(error.localizedDescription)")
                    return
                }
                
                if let data = data, let text = String(data: data, encoding: .utf8) {
                    let decoder = JSONDecoder()
                    if let jsonData = text.data(using: .utf8) {
                        let rating = try? decoder.decode(HotelRating.self, from: jsonData)
                        DispatchQueue.main.async {
                            print("rating: \(rating)")
                            self.serverText = String(rating?.points ?? 0)
                            print(serverText)
                        }
                    }
                }
            }.resume()
        }
    
    func fetchAlmatyTextFromServer() {
        guard let url = URL(string: "http://127.0.0.1:8000/api/hotel/3/") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error fetching text: \(error.localizedDescription)")
                return
            }
            
            if let data = data, let text = String(data: data, encoding: .utf8) {
                let decoder = JSONDecoder()
                if let jsonData = text.data(using: .utf8) {
                    let hotel_almaty = try? decoder.decode(Hotel.self, from: jsonData)
                    DispatchQueue.main.async {
                        print("hotels: \(hotel_almaty)")
                        self.Almaty_description = String(hotel_almaty?.name ?? "")
                        print(Almaty_description)
                    }
                }
            }
        }.resume()
        }
    
    func fetchDoubleTreeHiltonTextFromServer() {
        guard let url = URL(string: "http://127.0.0.1:8000/api/hotel/2/") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error fetching text: \(error.localizedDescription)")
                return
            }
            
            if let data = data, let text = String(data: data, encoding: .utf8) {
                let decoder = JSONDecoder()
                if let jsonData = text.data(using: .utf8) {
                    let hotel_double_tree_hilton = try? decoder.decode(Hotel.self, from: jsonData)
                    DispatchQueue.main.async {
                        print("hotels: \(hotel_double_tree_hilton)")
                        self.DoubleTree_Hilton_description = String(hotel_double_tree_hilton?.name ?? "")
                        print(DoubleTree_Hilton_description)
                    }
                }
            }
        }.resume()
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TopElements: View {
    @Binding var down_image: Image?
    @Binding var fetched_text: String
    @State var hotel_detail_sheet_toggle = false
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                hotel_detail_sheet_toggle = true
            }, label: {
                if let image = down_image {
                    image.resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .overlay {
                            HStack {
                                Text(fetched_text)
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .renderingMode(.original)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.yellow)
                            }
                            .frame(width: 70, height: 30)
                            .background(Color("LightGreen"))
                            .position(x: 35, y: 25)
                        }
                }
            })
            .foregroundColor(Color.black)
//            Rectangle()
//                .frame(width: UIScreen.main.bounds.width*0.9, height: 200)
//                .background(Color.gray)
            Text("Location")
        }
        .sheet(isPresented: $hotel_detail_sheet_toggle) { HotelDetailsPageView()
        }
    }
}

struct TopTourView: View {
    @State var tourImage: Image?
    @State var description: String = ""
    var body: some View {
        VStack(alignment: .leading) {
            if let image = tourImage {
                image.resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
            }
            Text(description)
        }
        .onAppear {
            downloadTourImage()
            fetchTourTextFromServer()
        }
    }
    func downloadTourImage() {
        //http://127.0.0.1:8000/media/tour_pictures/2023/06/04/kolsai.jpg
        guard let url = URL(string: "http://127.0.0.1:8000/media/tour_pictures/2023/06/04/kolsai.jpg") else {
            return
        }
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let error = error {
                print("Error while dowloading image from server, \(error.localizedDescription)")
                return
            }
            if let data = data, let uiImage = UIImage(data: data) {
                let image = Image(uiImage: uiImage)
                DispatchQueue.main.async {
                    self.tourImage = image
                }
            }
        }
        .resume()
    }
    
    func fetchTourTextFromServer() {
            guard let url = URL(string: "http://127.0.0.1:8000/api/tour/2/") else {
                return
            }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error fetching text: \(error.localizedDescription)")
                    return
                }
                
                if let data = data, let text = String(data: data, encoding: .utf8) {
                    let decoder = JSONDecoder()
                    if let jsonData = text.data(using: .utf8) {
                        let descrptn = try? decoder.decode(TourDetails.self, from: jsonData)
                        DispatchQueue.main.async {
                            print("rating: \(descrptn)")
                            self.description = String(descrptn?.description ?? "")
                            print(description)
                        }
                    }
                }
            }.resume()
        }
}
