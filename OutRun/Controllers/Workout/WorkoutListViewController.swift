//
//  WorkoutListViewController.swift
//
//  OutRun
//  Copyright (C) 2020 Tim Fraedrich <timfraedrich@icloud.com>
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

import UIKit
import CoreData
import CoreStore
import Foundation


class WorkoutListViewController: UITableViewController, ListSectionObserver, TabBarSelectionObserver {
    
    typealias ListEntityType = Workout
    
    var lastKnownDistanceUnit: UnitLength?
    var sortType = WorkoutListSortType.day(true) {
        didSet {
            refetchWithFilters()
        }
    }
    var filterTypes: [WorkoutListFilterType] = [] {
        didSet {
            refetchWithFilters()
        }
    }
    
    private lazy var sortItem = UIBarButtonItem(title: self.sortType.stringWithArrow, style: .plain, target: self, action: #selector(showSortController))
    
    
    private lazy var rewardButton = UIBarButtonItem(title: "Rewards", style: .plain, target: self, action: #selector(showpopup))
    
    
    let noDataLabel = UILabel(
        text: LS["NoData.Message"],
        textColor: .secondaryColor,
        font: .systemFont(ofSize: 16, weight: .bold),
        numberOfLines: 0,
        textAlignment: .center
    )
    
    override func viewDidLoad() {
        DataManager.workoutMonitor.addObserver(self)
        
        super.viewDidLoad()
        self.tableView.backgroundColor = .backgroundColor
        
        self.tableView.separatorStyle = .none
        
        self.navigationItem.title = LS["WorkoutListViewController.Headline"]
        
        self.tableView.addSubview(noDataLabel)
        noDataLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.tableView.safeAreaLayoutGuide)
            make.right.lessThanOrEqualToSuperview().offset(-20)
            make.left.greaterThanOrEqualToSuperview().offset(20)
        }
        self.noDataLabel.isHidden = true
        
        self.lastKnownDistanceUnit = UserPreferences.distanceMeasurementType.safeValue
        
        self.navigationItem.rightBarButtonItem = sortItem
        
        self.navigationItem.leftBarButtonItem = rewardButton
    }
    
    deinit {
        DataManager.workoutMonitor.removeObserver(self)
    }
    
    func willGetSelected() {
        if lastKnownDistanceUnit != UserPreferences.distanceMeasurementType.safeValue {
            self.lastKnownDistanceUnit = UserPreferences.distanceMeasurementType.safeValue
            guard let indexPaths = self.tableView.indexPathsForVisibleRows else {
                self.tableView.reloadData()
                return
            }
            self.tableView.reloadRows(at: indexPaths, with: .none)
        }
    }
    
    // MARK: TableView
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        let sections = DataManager.workoutMonitor.numberOfSections()
        self.noDataLabel.isHidden = DataManager.workoutMonitor.numberOfObjects() != 0
        return sections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionCount = DataManager.workoutMonitor.numberOfObjects(safelyIn: section) else {
            return 0
        }
        return sectionCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let workout = DataManager.workoutMonitor[indexPath.section, indexPath.row]
        let cell = WorkoutListCell(workout: workout)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let workout = DataManager.workoutMonitor[indexPath.section, indexPath.row]
        
        let controller = WorkoutViewController()
        controller.workout = workout
        
        self.showDetailViewController(controller, sender: self)
        
    }
    
    // MARK: ListObserver
    
    func listMonitorWillChange(_ monitor: ListMonitor<Workout>) {
        self.tableView.beginUpdates()
    }
    
    func listMonitorDidChange(_ monitor: ListMonitor<Workout>) {
        self.tableView.endUpdates()
    }
    
    func listMonitorWillRefetch(_ monitor: ListMonitor<Workout>) {
        self.setTable(enabled: false)
    }
    
    func listMonitorDidRefetch(_ monitor: ListMonitor<Workout>) {
        self.tableView.reloadData()
        self.setTable(enabled: true)
        
    }
    
    // MARK: ListObjectObserver
    
    func listMonitor(_ monitor: ListMonitor<Workout>, didInsertObject object: Workout, toIndexPath indexPath: IndexPath) {
        self.tableView.insertRows(at: [indexPath], with: .fade)
    }
    
    func listMonitor(_ monitor: ListMonitor<Workout>, didDeleteObject object: Workout, fromIndexPath indexPath: IndexPath) {
        self.tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func listMonitor(_ monitor: ListMonitor<Workout>, didUpdateObject object: Workout, atIndexPath indexPath: IndexPath) {
        if let cell = self.tableView.cellForRow(at: indexPath) as? WorkoutListCell {
            cell.workout = object
            cell.setup()
        }
    }
    
    func listMonitor(_ monitor: ListMonitor<Workout>, didMoveObject object: Workout, fromIndexPath: IndexPath, toIndexPath: IndexPath) {
        self.tableView.deleteRows(at: [fromIndexPath], with: .fade)
        self.tableView.insertRows(at: [toIndexPath], with: .fade)
    }
    
    // MARK: ListSectionObserver
    func listMonitor(_ monitor: ListMonitor<Workout>, didInsertSection sectionInfo: NSFetchedResultsSectionInfo, toSectionIndex sectionIndex: Int) {
        self.tableView.insertSections(IndexSet(arrayLiteral: sectionIndex), with: .fade)
    }
    
    func listMonitor(_ monitor: ListMonitor<Workout>, didDeleteSection sectionInfo: NSFetchedResultsSectionInfo, fromSectionIndex sectionIndex: Int) {
        self.tableView.deleteSections(IndexSet(arrayLiteral: sectionIndex), with: .fade)
    }
    
    // MARK: Private
    
    private func setTable(enabled: Bool) {
        tableView.isUserInteractionEnabled = enabled
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .beginFromCurrentState,
            animations: { () -> Void in
                if let tableView = self.tableView {
                    
                    tableView.alpha = enabled ? 1.0 : 0.5
                }
            },
            completion: nil
        )
    }
    
    // MARK: Sort
    
    /// the type by which the List is supposed to be sorted including if it is supposed to be descending
    enum WorkoutListSortType: Equatable {
        
        case day(Bool)
        case distance(Bool)
        /// NOTE: Not usable because value is transient
        case duration(Bool)
        
        var descending: Bool {
            switch self {
            case .day(let desc), .distance(let desc), .duration(let desc):
                return desc
            }
        }
        
        var string: String {
            switch self {
            case .day(_):
                return LS["WorkoutList.Sort.Date"]
            case .distance(_):
                return LS["WorkoutStats.Distance"]
            case .duration(_):
                return LS["Workout.Duration"]
            }
        }
        
        var stringWithArrow: String {
            return self.string + (self.descending ? " ↓" : " ↑")
        }
        
        var oppositeOrderedType: WorkoutListSortType {
            switch self {
            case .day(let desc):
                return .day(!desc)
            case .distance(let desc):
                return .distance(!desc)
            case .duration(let desc):
                return .duration(!desc)
            }
        }
        
        var fetchClause: FetchClause {
            switch self {
            case .day(let desc):
                return OrderBy<Workout>(desc ? .descending(\.startDate) : .ascending(\.startDate))
            case .distance(let desc):
                return OrderBy<Workout>(desc ? .descending(\.distance) : .ascending(\.distance))
            case .duration(let desc):
                return OrderBy<Workout>(desc ? .descending(\.activeDuration) : .ascending(\.activeDuration))
            }
        }
        
    }
    
    enum WorkoutListFilterType: Equatable {
        case isRace
        case type(Workout.WorkoutType)
        
        var string: String {
            switch self {
            case .isRace:
                return LS["WorkoutList.Filter.IsRace"]
            case .type(_):
                return LS["Workout.Type"]
            }
            
        }
        
        var workoutType: Workout.WorkoutType? {
            switch self {
            case .type(let workoutType):
                return workoutType
            default:
                return nil
            }
        }
        
        var fetchClause: Where<Workout> {
            switch self {
            case .isRace:
                return Where<Workout>(\.isRace == true)
            case .type(let type):
                return Where<Workout>(\.workoutType == type.rawValue)
            }
        }
    }
    
    @objc func showSortController(sourceView: UIBarButtonItem) {
        let sortController = WorkoutListSortViewController()
        let controller = UINavigationController(rootViewController: sortController)
        controller.modalPresentationStyle = .popover
        sortController.listController = self
        controller.preferredContentSize = CGSize(width: 250, height: 250)
        if let presentationController = controller.popoverPresentationController {
            presentationController.delegate = sortController
            presentationController.permittedArrowDirections = [.down, .up]
        }
        controller.popoverPresentationController?.barButtonItem = self.sortItem
        self.present(controller, animated: true)
    }
    
    
    @objc func showpopup(sourceView: UIBarButtonItem){
        
        
        
        let detailVC = DetailViewController()
        detailVC.headline = "Rewards"
        self.present(detailVC, animated: true, completion: nil)
        
        
        // Create a new StatsView with the sample statistics views
        let statsView = StatsView(title: "Today's Workout Stats and metrics", statViews: [])
        
        // Add the StatsView to the current view hierarchy
        detailVC.view.addSubview(statsView)
        
        // Configure the constraints for the StatsView
        statsView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(120)
            //make.left.right.equalToSuperview().inset(20)
            make.left.equalTo(detailVC.view.snp.centerX).offset(-200)
            make.bottom.equalToSuperview().inset(50)
        }
        
        
        let monthCaloriesBurnt = 4000
        let myLabelledDataView = LabelledDataView(title: "Total calories burnt", measurement: NSMeasurement(doubleValue: Double(monthCaloriesBurnt), unit: UnitEnergy.calories))
        
        detailVC.view.addSubview(myLabelledDataView)
        myLabelledDataView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(200)
        }
        let percentageConsistency = 60
        let consistencyLabelledView = LabelledDataViewCustom(title: "Your consistency", measurementAndUnit: String(percentageConsistency) + " %")


        
        
        detailVC.view.addSubview(consistencyLabelledView)
        consistencyLabelledView.snp.makeConstraints { make in
            make.top.equalTo(myLabelledDataView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        let overallWinnings = 9.50
        let overallrewardview = LabelledDataViewCustom(title: "This month's reward", measurementAndUnit: String(overallWinnings) + " AKM (4.75 USDC)")
        
        
        detailVC.view.addSubview(overallrewardview)
        overallrewardview.snp.makeConstraints { make in
            make.top.equalTo(consistencyLabelledView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        let reductionButton = UIButton()
        reductionButton.setTitle("Insurance reduction", for: .normal)
        reductionButton.backgroundColor = .orange
        reductionButton.layer.cornerRadius = 10
        reductionButton.addTarget(self, action: #selector(reductionTapped), for: .touchUpInside)
        detailVC.view.addSubview(reductionButton)


        let rewardButton = UIButton()
        rewardButton.setTitle("AKM crypto reward", for: .normal)
        rewardButton.backgroundColor = .orange
        rewardButton.layer.cornerRadius = 10
        rewardButton.addTarget(self, action: #selector(rewardTapped), for: .touchUpInside)

        //detailVC.view.addSubview(reductionButton)
        detailVC.view.addSubview(rewardButton)
        


//        let hoverStyles = """
//            button:hover {
//                color: grey;
//                background-color: lightgrey;
//            }
//        """
//
//
//        let style = "<style>\n\(hoverStyles)\n</style>"
//        let htmlString = "<html>\n<head>\(style)</head>\n<body></body>\n</html>"
//
//        guard let data = htmlString.data(using: .utf8) else { return }
//        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType: NSAttributedString.DocumentType.html]
//        let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil)
//
//        reductionButton.setAttributedTitle(attributedString, for: .highlighted)
//        rewardButton.setAttributedTitle(attributedString, for: .highlighted)
        
        
        reductionButton.snp.makeConstraints { (make) in
            make.top.equalTo(overallrewardview.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(170)
            make.height.equalTo(40)
         }
        
        rewardButton.snp.makeConstraints { (make) in
            make.top.equalTo(overallrewardview.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(170)
            make.height.equalTo(40)
         }

//
//        reductionButton.addTarget(self, action: #selector(buttonHover(_:)), for: .touchDragEnter)
//        rewardButton.addTarget(self, action: #selector(buttonHover(_:)), for: .touchDragEnter)

        

        self.view.layoutIfNeeded()

        
        
    }
    
    @objc func reductionTapped(_ sender: UIButton) {
//        if sender.isTouchInside {
//            sender.backgroundColor = .red
//        }
//        else {
//            sender.backgroundColor = .orange // set to original color
//        }
    }

    @objc func rewardTapped(_ sender: UIButton) {
        // Handle AKM crypto reward button
        print("User wants to get crypto reward ")
        let myfunctions = APIFunctions()
        myfunctions.makeCryptoReward()
        
//        if sender.isTouchInside {
//            sender.backgroundColor = .red
//        }
//        else {
//            sender.backgroundColor = .orange // set to original color
//        }
    }
    

    func refetchWithFilters() {
        
        let filterClauses = filterTypes.map { (type) -> Where<Workout> in
            return type.fetchClause
        }
        
        sortItem.title = sortType.stringWithArrow
        DataManager.workoutMonitor.refetch([filterClauses.combinedByAnd(), sortType.fetchClause])
    }
    
}

