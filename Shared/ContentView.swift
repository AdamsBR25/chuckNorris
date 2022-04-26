//
//  ContentView.swift
//  Shared
//
//  Created by Brady Adams on 4/25/22.
//

import Foundation
import SwiftUI
import UserNotifications

struct ContentView: View {
    @State private var joke: String = ""
    private var jokeArray: [String] = []
    
    func wisdom() async -> String {
        
        do {
            let (data, _) = try await URLSession.shared.data(from: URL(string: "https://api.chucknorris.io/jokes/random")!)
            let decodedResponse = try? JSONDecoder().decode(Joke.self, from: data)
            joke = decodedResponse?.value ?? ""
            return joke
            
        } catch {
            print("error in wisdom fetch")
        }
        return ""
    }
    
    func notification() async {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Daily Chuck Norris Wisdom"
        notificationContent.body = await wisdom()
        notificationContent.badge = NSNumber(value: 1)
        notificationContent.sound = .default
        notificationContent.categoryIdentifier = "wisdom.reminder.category"
                        
        var datComp = DateComponents()
        datComp.hour = 7
        datComp.minute = 20
        let trigger = UNCalendarNotificationTrigger(dateMatching: datComp, repeats: true)
        let request = UNNotificationRequest(identifier: "wisdom", content: notificationContent, trigger: trigger)
                        UNUserNotificationCenter.current().add(request) { (error : Error?) in
                            if let theError = error {
                                print(theError.localizedDescription)
                            }
                        }
    }
    
    func stopNotification() async {
        let notifCenter = UNUserNotificationCenter.current()
        notifCenter.removePendingNotificationRequests(withIdentifiers: ["wisdom"])}
    
    func setCategories() {
        let clearRepeatAction = UNNotificationAction(
           identifier: "clear.repeat.action",
           title: "Stop Repeat",
           options: [])
        
        let wisdomCategory = UNNotificationCategory(
            identifier: "wisdom.reminder.category",
            actions: [clearRepeatAction],
            intentIdentifiers: [],
            options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([wisdomCategory])
        }
        
    var body: some View {
        VStack{
            HStack {
                Button {
                    Task {
                        
                    }
                } label: {
                    Text("Enable Notifications")
                }
                .padding()
                
                Spacer()
                
                Button {
                    Task {
                        
                    }
                } label: {
                    Text("Disable Notifications")
                }
                .padding()
            }
            
            Spacer()
            Text(joke)
                .padding(20)
            Spacer()
            Button {
                Task {
                   joke = await wisdom()
                }
            } label: {
                Text("Fetch Joke")
                    .padding(20)
            }
            .contentShape(Rectangle())

            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Joke: Codable {
    let value: String
}
