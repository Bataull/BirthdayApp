import UIKit
import UserNotifications

class BirthdayNotificationManager {
    
    static let shared = BirthdayNotificationManager()
    
    private init() {}
    
    func scheduleBirthdayNotification(for friend: Friend) {
        let content = UNMutableNotificationContent()
        content.title = "День рождения"
        content.body = "Сегодня \(friend.name ?? ""), \(friend.surname ?? "") отмечает день рождения!"
        
        var dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: friend.date ?? Date())
        dateComponents.hour = 1
        dateComponents.minute = 50
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Ошибка при планировании уведомления: \(error.localizedDescription)")
            } else {
                print("Уведомление успешно запланировано для \(friend.name ?? ""), \(friend.surname ?? "") в \(dateComponents.hour ?? 0):\(dateComponents.minute ?? 0)")
            }
        }
    }
}
