//
//  NBEventViewController.swift
//  SwiftDemo
//
//  Created by 陈思行 on 2019/11/24.
//  Copyright © 2019 hanrychen. All rights reserved.
//

import UIKit
import EventKit
import SwiftUI

class NBEventViewController: UIViewController {
    
    var store = EKEventStore()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        view.addSubview(btn1)
        btn1.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(40)
            make.bottom.equalToSuperview().offset(-40)
            make.width.equalTo(100)
            make.height.equalTo(48)
        }
        view.addSubview(btn2)
        btn2.snp.makeConstraints { (make) in
            make.left.equalTo(btn1.snp.right).offset(40)
            make.bottom.equalToSuperview().offset(-40)
            make.width.equalTo(100)
            make.height.equalTo(48)
        }
    }
    
    @objc func didSelect1Action() {
        loadData(EKEntityType.event, completion: { self.requestCalendar($0) })
    }
    
    @objc func didSelect2Action() {
        loadData(EKEntityType.reminder, completion: { self.requestRemind($0) })
    }
    
    func loadData(_ type: EKEntityType, completion:@escaping ((Bool)->())) {
        let status = EKEventStore.authorizationStatus(for: type)
        if status != .authorized {
            store.requestAccess(to: type) { (success, error) in
                if success {
                    print("请求权限成功")
                    self.loadData(type, completion: completion)
                } else {
                    completion(false)
                }
            }
            return
        }
        completion(true)
    }
    
    func requestCalendar(_ success: Bool) {
        if success == false {
            return
        }
        
        let event = EKEvent(eventStore: store)
        event.startDate = Date(timeIntervalSinceNow: 3)
        event.endDate = Date(timeIntervalSinceNow: 1000)
        event.title = "今天是星期天下午4点42分"
        let alarm = EKAlarm(absoluteDate: Date(timeIntervalSinceNow: 3))
        event.addAlarm(alarm)
        let calendar = EKCalendar(for: EKEntityType.event, eventStore: store)
        calendar.title = "日历事件"
        event.calendar = calendar
        
        do {
            try store.save(event, span: EKSpan.thisEvent)
        } catch {
            print(error)
        }
    }
    
    func requestRemind(_ success: Bool) {
        if success == false {
            return
        }
        let reminder = EKReminder(eventStore: store)
        reminder.title = "提醒事件"
        var cal = NSCalendar.current
        cal.timeZone = TimeZone.current
        let components = cal.dateComponents(in: TimeZone.current, from: Date(timeIntervalSinceNow: 30))
        reminder.startDateComponents = components
        reminder.dueDateComponents = components
        reminder.completionDate = Date(timeIntervalSinceNow: 30)
        reminder.calendar = store.defaultCalendarForNewReminders()
        
        reminder.priority = 1;//优先级
        
        do {
            try store.save(reminder, commit: true)
        } catch {
            print(error)
        }
        
    }

    
    lazy var btn1: UIButton = {
        let view = UIButton(type: UIButton.ButtonType.custom)
        view.backgroundColor = UIColor.orange
        view.layer.cornerRadius = 5
        view.setTitle("日历功能", for: UIControl.State.normal)
        view.addTarget(self, action: #selector(didSelect1Action), for: UIControl.Event.touchUpInside)
        return view
    }()
    
    lazy var btn2: UIButton = {
        let view = UIButton(type: UIButton.ButtonType.custom)
        view.backgroundColor = UIColor.orange
        view.layer.cornerRadius = 5
        view.setTitle("提醒功能", for: UIControl.State.normal)
        view.addTarget(self, action: #selector(didSelect2Action), for: UIControl.Event.touchUpInside)
        return view
    }()
}

