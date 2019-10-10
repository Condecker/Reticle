import UIKit

struct Headline {
    var id : Int
    var date : Date
    var title : String
    var text : String
    var image : UIImage
}

struct MonthSection : Comparable {
    var month : Date
    var headlines : [Headline]
    
    static func < (lhs: MonthSection, rhs: MonthSection) -> Bool {
        return lhs.month < rhs.month
    }
    
    static func == (lhs: MonthSection, rhs: MonthSection) -> Bool {
        return lhs.month == rhs.month
    }
    static func group(headlines : [Headline]) -> [MonthSection] {
        let groups = Dictionary(grouping: headlines) { (headline) -> Date in
            return firstDayOfMonth(date: headline.date)
        }
        return groups.map(MonthSection.init(month:headlines:)).sorted()
    }
}

fileprivate func parseDate(_ str : String) -> Date {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "yyyy-MM-dd"
    return dateFormat.date(from: str)!
}

fileprivate func firstDayOfMonth(date : Date) -> Date {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month], from: date)
    return calendar.date(from: components)!
}
fileprivate func firstDayofMonth(date : Date) -> Date {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month], from: date)
    return calendar.date(from: components)!
}


class VideosTableViewController: UITableViewController {

    var headlines = [
        Headline(id: 1, date: parseDate("2018-02-15"), title: "How to Handle Someone not Complying", text: "Video shows what action an officer should take in this situation", image: UIImage(named: "vid1.jpg")!),
        Headline(id: 2, date: parseDate("2018-03-05"), title: "Drunk Driving Pullover Do's and Dont's", text: "Video shows what action an officer should take in this situation", image: UIImage(named: "vid2.jpg")!),
        Headline(id: 3, date: parseDate("2018-02-10"), title: "How to Handle a Rowdy House Party", text: "Video shows what action an officer should take in this situation ", image: UIImage(named: "vid3.jpg")!),
                 Headline(id: 4, date: parseDate("2018-05-15"), title: "Drug Busts 101", text: "Video shows what action an officer should take in this situation", image: UIImage(named: "vid3.jpg")!)
        ]
    
    
    var sections = [MonthSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let groups = Dictionary(grouping: self.headlines) { (headline) in
            return firstDayOfMonth(date: headline.date)
            
        }
        self.sections = groups.map(MonthSection.init(month:headlines:))
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        print(self.sections.count)
        return self.sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = self.sections[section]
        let date = section.month
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = self.sections[section]
        return section.headlines.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        let section = self.sections[indexPath.section]
        let headline = section.headlines[indexPath.row]
        cell.textLabel?.text = headline.title
        cell.detailTextLabel?.text = headline.text
        cell.imageView?.image = headline.image
        
        return cell
    }
    
}
