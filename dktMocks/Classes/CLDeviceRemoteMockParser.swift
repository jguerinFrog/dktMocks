//
//  File.swift
//  
//
//  Created by Julien GUERIN on 18/04/2023.
//

import Foundation

class CLDeviceRemoteMockParser{
    private var mockData: [CLDeviceRemoteMockData] = []
    private var indexData = 0
    private static var jsonFileName = "CLDeviceRemoteMockFile"

    func getNextData() -> CLDeviceRemoteMockData {
        if indexData == mockData.count {
            indexData = 0
        }
        let mock = mockData[indexData]
        indexData = indexData + 1
        return mock
    }

    func resetIndex() {
        self.indexData = 0
    }

    func updateFile() {
        self.downloadFile()
        self.indexData = 0
    }

    func loadJSON() {
           let fm = FileManager.default
           let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
           if let url = urls.first {
               var fileURL = url.appendingPathComponent(CLDeviceRemoteMockParser.jsonFileName)
               fileURL = fileURL.appendingPathExtension("json")
               if let data = try? Data(contentsOf: fileURL) {
                   let decoder = JSONDecoder()
                   if let jsonData = try? decoder.decode([CLDeviceRemoteMockData].self, from: data) {
                       self.mockData = jsonData
                   }
               }
           }
       }

    private func save(jsonObject: [CLDeviceRemoteMockData]) throws -> Bool{
           let fm = FileManager.default
           let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
           if let url = urls.first {
               var fileURL = url.appendingPathComponent(CLDeviceRemoteMockParser.jsonFileName)
               fileURL = fileURL.appendingPathExtension("json")
               let jsonData = try JSONEncoder().encode(jsonObject)
               try jsonData.write(to: fileURL)
               return true
           }

           return false
    }

    private func downloadFile() {
        if let url = URL(string: "https://www.googleapis.com/drive/v3/files/1swL5KH4cMQPDLAur6VVTiYdOJpjoP_1-?alt=media&key=AIzaSyA_FNS8aWCWvn7sAO48EF95BOdjH9NifnM") {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                    let decoder = JSONDecoder()
                    if let jsonData = try? decoder.decode([CLDeviceRemoteMockData].self, from: data) {
                        self.mockData = jsonData
                        try? self.save(jsonObject: jsonData)
                    }
                    else {
                        print("pas ok")
                    }
               }
           }.resume()
        }
    }
}
