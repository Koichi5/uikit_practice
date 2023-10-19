//
//  ReminderListViewController+Actions.swift
//  uikit_practice
//
//  Created by Koichi Kishimoto on 2023/10/19.
//

import UIKit

extension ReminderListViewController {
    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        guard let id = sender.id else { return }
        completeReminder(withId: id)
    }
}
