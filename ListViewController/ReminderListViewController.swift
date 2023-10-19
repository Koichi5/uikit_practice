import UIKit

class ReminderListViewController: UICollectionViewController {
    var dataSource: DataSource!
    var reminders: [Reminder] = Reminder.sampleData
        
//    func reminderCellRegistration() -> UICollectionView.CellRegistration<UICollectionViewListCell, Reminder> {
//        return .int { cell, _, item, in
//            guard reminder = item.reminder else { return }
//            var configration = cell.defaultContentConfiguration()
//            configration.text = reminder.title
//            configration.textProperties.color = .darkGray
//            cell.contentConfiguration = configration
//
//            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
//            backgroundConfig.cornerRadius = 8
//            cell.backgroundConfiguration = backgroundConfig
//        }
//    }
    
//    func makeDataSource() -> DataSource {
//        let reminderCellRegistration = self.reminderCellRegistration()
//        return DataSource(collectionView: collectionView) {
//            collectionView, indexPath, item -> UICollectionViewCell? in
//            return collectionView.dequeueConfiguredReusableCell(using: reminderCellRegistration, for: indexPath, item: item)
//        }
//    }
    
//    func applyInitialSnapshots() {
//        var initialSnapshot = NSDiffableDataSourceSnapshot<Int, Reminder> ()
//        let reminderItems = reminderStore.reminder.map { reminder in
//            return ReminderItem(reminder: reminder)
//        }
//        
//        initialSnapshot.appendSections([0])
//        initialSnapshot.appendItems(reminderItems, toSection: 0)
//        dataSource.apply(initialSnapshot, animatingDifferences: false)
//    }
    
//    lazy var dataSource = makeDataSource()
    
    // init state, use effect ?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        
//        let cellRegistration = UICollectionView.CellRegistration{
//            (cell: UICollectionViewListCell, indexPath: IndexPath,
//             itemIdentifier: String) in
//            let reminder = Reminder.sampleData[indexPath.item]
//            var contentConfiguration = cell.defaultContentConfiguration()
//            contentConfiguration.text = reminder.title
//            cell.contentConfiguration = contentConfiguration
//        }
        
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Reminder.ID) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(reminders.map { $0.title })
//        var reminderTitles = [String]()
//        for reminder in Reminder.sampleData {
//            reminderTitles.append(reminder.title)
//        }
//        // this method define reminder title as identifier so duplecate title may cause problem ... ?
//        snapshot.appendItems(reminderTitles)
        dataSource.apply(snapshot)
        updateSnapshot()
        
        collectionView.dataSource = dataSource
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let id = reminders[indexPath.item].id
        pushDetailViewForReminder(withId: id)
        return false
    }
    
    func pushDetailViewForReminder(withId id: Reminder.ID) {
        let reminder = reminder(withId: id)
        let viewController = ReminderViewController(reminder: reminder)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // add list configuration to define list layout
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}

