//
//  FighterTableViewController.swift
//  MMApplication
//
//  Created by Kevin Stone on 10/01/2017.
//  Copyright © 2017 Kevin Stone. All rights reserved.
//

import UIKit
import Firebase
//Fighter class
class Fighter: NSObject{
    //Class variables. These have the same name as the variables stored for each fighter in the database. This allows the values to be easily stored when downloading from the database.
    var Forename: String = ""
    var Surname: String = ""
    var Champion: String = ""
    var Country: String = ""
    var Nickname: String = ""
    var Ranking: String = ""
    var Reach: String = ""
    var Record: String = ""
    var Height: String = ""
    var Weight: String = ""
    var ListPic: String = ""
    var PagePic: String = ""
    //var NextFight: String = ""
    //var LastFight: String = ""
    //var Summary: String = ""
    
    //Function that is used when a pinned fighter is saved to user defaults.
    //This is better to use than just accessing the variables individually not using a class function.
    //The pinned fighter data is stored as a string array.
    func saveUserDefaults( myArray: inout [String]) -> Void
    {
        myArray[0] = Forename
        myArray[1] = Surname
        myArray[2] = Champion
        myArray[3] = Country
        myArray[4] = Ranking
        myArray[5] = Nickname
        myArray[6] = Reach
        myArray[7] = Record
        myArray[8] = Height
        myArray[9] = Weight
        myArray[10] = ListPic
        myArray[11] = PagePic
//        myArray[12] = NextFight
//        myArray[13] = LastFight
//        myArray[14] = Summary
    }
    //Function that is used when we want to extract the saved data from the string array.
    func getSavedData(savedArray: [String]) -> Void
    {
        
        Forename = savedArray[0]
        Surname = savedArray[1]
        Champion = savedArray[2]
        Country = savedArray[3]
        Nickname = savedArray[4]
        Ranking = savedArray[5]
        Reach = savedArray[6]
        Record = savedArray[7]
        Height = savedArray[8]
        Weight = savedArray[9]
        ListPic = savedArray[10]
        PagePic = savedArray[11]
        
//        NextFight = savedArray[12]
//        LastFight = savedArray[13]
//        Summary = savedArray[14]
        
    }
    //Function used when the user clicks on one of the pinned fighters on the home screen.
    //The data needs to be extracted from the pinnedFighter.fighter variable into the selected fighter variable.
    func copyPinData(pinnedFighterFunction: Fighter) -> Void
    {
        Forename = pinnedFighterFunction.Forename
        Surname = pinnedFighterFunction.Surname
        Champion = pinnedFighterFunction.Champion
        Country = pinnedFighterFunction.Country
        Nickname = pinnedFighterFunction.Nickname
        Ranking = pinnedFighterFunction.Ranking
        Reach = pinnedFighterFunction.Reach
        Record = pinnedFighterFunction.Record
        Height = pinnedFighterFunction.Height
        Weight = pinnedFighterFunction.Weight
        ListPic = pinnedFighterFunction.ListPic
        PagePic = pinnedFighterFunction.PagePic
        
        //LastFight = pinnedFighterFunction.LastFight
        //NextFight = pinnedFighterFunction.NextFight
        //Summary = pinnedFighterFunction.Summary
    }
}
//Class for pinned fighter.
class PinnedFighter: NSObject{
    
    var fighter = Fighter()
    var pinned: Bool = false
}
//Filters for table view. Allows user to filter the table based on different filters
enum TableFilters {
    case AZ
    case Weight
    case Champions
}

var tableFilter = TableFilters.AZ//Set default value
//This table uses sections to split up the fighters. This means each section will have its own name AND list of fighters. This struct allows the name and fighters for each section to be stored together.
struct Objects{
    var sectionName : String!
    var sectionObjects = [Fighter]()
}


//Need 3 different arrays of objects since there are 3 different filters. This is easier than using one because having only one would mean that it would have to be cleared and repopulated everytime the user swaps filter.
var objectsArray = [Objects]()

var objectsArray2 = [Objects]()

var objectsArray3 = [Objects]()


//These are the arrays that are used at the start of the program to store all the data about the fighters/events.
var fighterArray =  [Fighter]()
var eventArray =  [Event]()

//Each sections store its section objects in an array so we need an array for each letter. Each array will store all the fighters that have a surname beginning with A,B,C etc.
    var fighterArrayA = [Fighter]()
    var fighterArrayB = [Fighter]()
    var fighterArrayC = [Fighter]()
    var fighterArrayD = [Fighter]()
    var fighterArrayE = [Fighter]()
    var fighterArrayF = [Fighter]()
    var fighterArrayG = [Fighter]()
    var fighterArrayH = [Fighter]()
    var fighterArrayI = [Fighter]()
    var fighterArrayJ = [Fighter]()
    var fighterArrayK = [Fighter]()
    var fighterArrayL = [Fighter]()
    var fighterArrayM = [Fighter]()
    var fighterArrayN = [Fighter]()
    var fighterArrayO = [Fighter]()
    var fighterArrayP = [Fighter]()
    var fighterArrayQ = [Fighter]()
    var fighterArrayR = [Fighter]()
    var fighterArrayS = [Fighter]()
    var fighterArrayT = [Fighter]()
    var fighterArrayU = [Fighter]()
    var fighterArrayV = [Fighter]()
    var fighterArrayW = [Fighter]()
    var fighterArrayX = [Fighter]()
    var fighterArrayY = [Fighter]()
    var fighterArrayZ = [Fighter]()
    //Need an array for each weight class.
    var fighterArray125Men = [Fighter]()
    var fighterArray135Men = [Fighter]()
    var fighterArray145Men = [Fighter]()
    var fighterArray155Men = [Fighter]()
    var fighterArray170Men = [Fighter]()
    var fighterArray185Men = [Fighter]()
    var fighterArray205Men = [Fighter]()
    var fighterArray265Men = [Fighter]()
    var fighterArray115Women = [Fighter]()
    var fighterArray135Women = [Fighter]()
    //Only need one array to store the champions.
    var fighterArrayChampions = [Fighter]()
    //This array is used by the search bar and secondary table view. This stores the fighters that satisfy the search criteria.
    var filteredFighters = [Fighter]()

class FighterTableViewController: UITableViewController, UISearchResultsUpdating{
    
    //This referes to the segment picker at the top of the screen allowing different filters to be applied to the table.
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBAction func changeSegmentControl(_ sender: Any) {
        print(segmentControl.selectedSegmentIndex)
        if(segmentControl.selectedSegmentIndex == 0)
        {
            tableFilter = .AZ
        }
        else if (segmentControl.selectedSegmentIndex == 1)
        {
            tableFilter = .Weight
        }
        else
        {
            tableFilter = .Champions
        }
        DispatchQueue.main.async
            {
                self.tableView.reloadData()
        }
    }

    //This array is used to store the letters that are displayed at the right side of the table that act as a picker and lets the user instantly go to a specific section of the table.
    let letters = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]

    
   
    //These variables are used when the user wants to search the table.
    var searchController : UISearchController!
    var resultsController = UITableViewController()
    
    //Reference to the main tableView
    @IBOutlet var tableView1: UITableView!
    
    //When the user clicks the search bar this code is executed.
    func updateSearchResults(for searchController: UISearchController) {
        if(tableFilter == .AZ || tableFilter == .Weight)
        {
            
        filteredFighters = fighterArray.filter { (fighter:Fighter) -> Bool in
            //Check if the name contains what the user has input into the search bar. If it does then return it and store it in the filtered fighters array.
            if(fighter.Forename.lowercased().contains(self.searchController.searchBar.text!.lowercased()) || fighter.Surname.lowercased().contains(self.searchController.searchBar.text!.lowercased()) )
            {
                return true
            }
            else
            {
                    return false
            }
        
        }
        }
        else
        {
            //Need an else statement for when the table is being filtered to only show champions. The program will only check if the fighters in the champion array match the search.
            filteredFighters = fighterArrayChampions.filter({ (fighter:Fighter) -> Bool in
                if(fighter.Forename.lowercased().contains(self.searchController.searchBar.text!.lowercased()) || fighter.Surname.lowercased().contains(self.searchController.searchBar.text!.lowercased()) )
                {
                    return true
                }
                else
                {
                    return false
                }

            })
        }
        
        
        self.resultsController.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        populateArrays()
        populateSections()
        
        //Gives the table view that displays the filtered fighters access to all data of primary table view.
        self.resultsController.tableView.dataSource = self
        self.resultsController.tableView.delegate = self
        
        self.searchController = UISearchController(searchResultsController: self.resultsController)
        self.searchController.dimsBackgroundDuringPresentation = false
        self.tableView1.tableHeaderView = self.searchController.searchBar
        
        self.searchController.searchResultsUpdater = self
        definesPresentationContext = true


    
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //If the primary table view is being used then execute this code
        if(tableView == self.tableView1)
        {
            //The objects array that we used is based upon the current filter applied to the table.
            if(tableFilter == .AZ)
            {
            selectedFighter = objectsArray[indexPath.section].sectionObjects[indexPath.row]
                print(selectedFighter.Forename)
            }
            else if (tableFilter == .Weight)
            {
                selectedFighter = objectsArray2[indexPath.section].sectionObjects[indexPath.row]
            }
            else
            {
                selectedFighter = objectsArray3[indexPath.section].sectionObjects[indexPath.row]
            }
        }
       else//If the user is viewing the search results then execute this code.
        {
            selectedFighter = filteredFighters[indexPath.row]
            DispatchQueue.main.async
            {
            self.performSegue(withIdentifier: "FighterInfoSegue", sender: Any?.self)
            }
        }
    }
    //Function that sets the number of rows in each section. 1 row for each object in that section.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == self.tableView1)
        {
            if(tableFilter == .AZ)
            {
                return objectsArray[section].sectionObjects.count
            }
           else if(tableFilter == .Weight)
            {
                return objectsArray2[section].sectionObjects.count
            }
            else
            {
                return objectsArray3[section].sectionObjects.count
            }
        }
        else
        {
            return filteredFighters.count
        }
    }
    //Function that set the number of sections in the table. This is the number of elements in the objects array.
    override func numberOfSections(in tableView: UITableView) -> Int {
        if(tableView == self.tableView1)
        {
            if(tableFilter == .AZ)
            {
                return objectsArray.count
            }
            else if (tableFilter == .Weight)
            {
                return objectsArray2.count
            }
            else
            {
                return objectsArray3.count
            }
        }
        else//If in search results then we only have 1 section.
        {
        return 1
        }
    }
    //Function that is used to set the properties of each table cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
    
        //Problems with table view. Cells are resused for memory purposes, this means that some images will be resued
        //in cells further down the table view. This will cause some slight flickering as new images are loaded when the
        //user scrolls to a new section. The other issue is that unless a default image is set for the cell image view
        //then the image that is downloaded will only be loaded when the user clicks or scrolls up/down the page. Setting
        //a default image fixes this because it forces the image view to load the new image instantly.
        
      //This grabs a reference to the current cell. This lets us access the cells properties.
      let cell =  tableView.dequeueReusableCell(withIdentifier: "PostCell")

           //   cell?.backgroundColor = backgroundColour
        
        //Check if the image hasnt been set yet i.e. the first time loading the page and set a default image with the same
        //size as downloaded images.
        //assign an image here so that the cell knows it has to display a picture. If this isn't done then a picture will only be displayed when the cell is clicked on.
        if(cell?.imageView?.image?.description == nil)
        {
            cell?.imageView?.image = #imageLiteral(resourceName: "defaultListPic")
            
        }
        //Code used when viewing primary table view.
        if(tableView == self.tableView1)
        {
        //As we move down to each cell of the table we access the corresponding element in the fighter array. This gives us access
        //to the fighters info which is displayed in the text labels of the cell.
        var fighter = Fighter()
            //Get the fighter from the object array based upon current filter.
        if(tableFilter == .AZ)
        {
            fighter = objectsArray[indexPath.section].sectionObjects[indexPath.row]
        }
        else if (tableFilter == .Weight)
        {
            fighter = objectsArray2[indexPath.section].sectionObjects[indexPath.row]
        }
        else if (tableFilter == .Champions)
        {
            fighter = objectsArray3[indexPath.section].sectionObjects[indexPath.row]
        }
        //To get the fighters image we need to download them from firebase.
        //The images are uploaded to firebase storage and then their download URL is added to the entries in the
        //database. This URL is then used by the app to download the image.
        
        //loadFighterUsingImageCache is an extension of the image view class. This will check whether the image has been cached already and if not then it will be downloaded. If it has been cached then simply retrieve it and set the image.
        cell?.imageView?.loadFighterImageUsingCache(urlString: fighter.ListPic)

            
            
        //If fighter has a nickname then display it else just display there first and second name.
        if (fighter.Nickname != "N/A")
        {
                    cell?.textLabel?.text = "\(fighter.Forename) '\(fighter.Nickname)' \(fighter.Surname)"
        }
        else
        {
                    cell?.textLabel?.text = "\(fighter.Forename) \(fighter.Surname)"
        }
        cell?.detailTextLabel?.text = "\(fighter.Ranking)"
        
        cell?.textLabel?.font = cell?.textLabel?.font.withSize(15)
        cell?.detailTextLabel?.font = cell?.textLabel?.font.withSize(10)
        return cell!
        }
        else//Code when viewing the search results
        {
            tableView.backgroundColor = UIColor.lightGray
            let cell =  UITableViewCell()
            cell.backgroundColor = UIColor.lightGray
            var filteredFighter = Fighter()
            filteredFighter = filteredFighters[indexPath.row]

            
            //If fighter has a nickname then display it else just display there first and second name.
            if (filteredFighter.Nickname != "N/A")
            {
                cell.textLabel?.text = "\(filteredFighter.Forename) '\(filteredFighter.Nickname)' \(filteredFighter.Surname)"
            }
            else
            {
                cell.textLabel?.text = "\(filteredFighter.Forename) \(filteredFighter.Surname)"
            }
            
            if(cell.imageView?.image?.description == nil)
            {
                cell.imageView?.image = #imageLiteral(resourceName: "defaultSearchListPic")//The cell colours for the different table views are slightly different shades of grey. Need a different image so that it doesnt stick out
            }
            
          
            DispatchQueue.main.async{
           cell.imageView?.loadFighterImageUsingCache(urlString: filteredFighters[indexPath.row].ListPic)
            }
            return cell
        }
    }
    //Function used to set the title of each section. The title is store by the object array and each section has its own title.
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(tableView == self.tableView1)
        {
            if(tableFilter == .AZ)
            {
                
                return objectsArray[section].sectionName
            }
            else if (tableFilter == .Weight)
            {
                return objectsArray2[section].sectionName
            }
            else
            {
                return objectsArray3[section].sectionName
            }
        }
        else//No title in search results.
        {
            return ""
        }
        
    }
    //Sets the colour of the header text.
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerTitle = view as? UITableViewHeaderFooterView {
            headerTitle.textLabel?.textColor = UIColor.red
        }
    }
    //This sets the text for the right hand bar that allows instant scrolling.
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if(tableView == self.tableView1 && tableFilter == .AZ)//Not used for .weight/.champions filters.
        {
               return letters
        }
        else
        {
        return nil
        }
    }
    //Function used to populate the arrays that are used to define the different sections.
    func populateArrays()
    {
            for j in fighterArray
            {
                 if( j.Surname.characters.first == "A")
                {
                    fighterArrayA.append(j)
                }
                if( j.Surname.characters.first == "B")
                {
                    fighterArrayB.append(j)
                }
                if( j.Surname.characters.first == "C")
                {
                    fighterArrayC.append(j)
                }
                if( j.Surname.characters.first == "D")
                {
                    fighterArrayD.append(j)
                }
                if( j.Surname.characters.first == "E")
                {
                    fighterArrayE.append(j)
                }
                if( j.Surname.characters.first == "F")
                {
                    fighterArrayF.append(j)
                }
                if( j.Surname.characters.first == "G")
                {
                    fighterArrayG.append(j)
                }
                if( j.Surname.characters.first == "H")
                {
                    fighterArrayH.append(j)
                }
                if( j.Surname.characters.first == "I")
                {
                    fighterArrayI.append(j)
                }
                if( j.Surname.characters.first == "J")
                {
                    fighterArrayJ.append(j)
                }
                if( j.Surname.characters.first == "K")
                {
                    fighterArrayK.append(j)
                }
                if( j.Surname.characters.first == "L")
                {
                    fighterArrayL.append(j)
                }
                if( j.Surname.characters.first == "M")
                {
                    fighterArrayM.append(j)
                }
                if( j.Surname.characters.first == "N")
                {
                    fighterArrayN.append(j)
                }
                if( j.Surname.characters.first == "O")
                {
                    fighterArrayO.append(j)
                }
                if( j.Surname.characters.first == "P")
                {
                    fighterArrayP.append(j)
                }
                if( j.Surname.characters.first == "Q")
                {
                    fighterArrayQ.append(j)
                }
                if( j.Surname.characters.first == "R")
                {
                    fighterArrayR.append(j)
                }
                if( j.Surname.characters.first == "S")
                {
                    fighterArrayS.append(j)
                }
                if( j.Surname.characters.first == "T")
                {
                    fighterArrayT.append(j)
                }
                if( j.Surname.characters.first == "U")
                {
                    fighterArrayU.append(j)
                }
                if( j.Surname.characters.first == "V")
                {
                    fighterArrayV.append(j)
                }
                if( j.Surname.characters.first == "W")
                {
                    fighterArrayW.append(j)
                }
                if( j.Surname.characters.first == "X")
                {
                    fighterArrayX.append(j)
                }
                if( j.Surname.characters.first == "Y")
                {
                    fighterArrayY.append(j)
                }
                if( j.Surname.characters.first == "Z")
                {
                    fighterArrayZ.append(j)
                }
                
                //Populate the weight class arrays
                if(j.Weight == "125 lbs")
                {
                    fighterArray125Men.append(j)
                }
                if(j.Weight == "135 lbs")
                {
                    fighterArray135Men.append(j)
                }
                if(j.Weight == "145 lbs")
                {
                    fighterArray145Men.append(j)
                }
                if(j.Weight == "155 lbs")
                {
                    fighterArray155Men.append(j)
                }
                if(j.Weight == "170 lbs")
                {
                    fighterArray170Men.append(j)
                }
                if(j.Weight == "185 lbs")
                {
                    fighterArray185Men.append(j)
                }
                if(j.Weight == "205 lbs")
                {
                    fighterArray205Men.append(j)
                }
                if(j.Weight > "205 lbs")
                {
                    fighterArray265Men.append(j)
                }
                if(j.Weight == "115 lbs Women")
                {
                    fighterArray115Women.append(j)
                }
                if(j.Weight == "135 lbs Women")
                {
                    fighterArray135Women.append(j)
                }
                //Populate the champion array.
                if(j.Champion == "Current")
                {
                    fighterArrayChampions.append(j)
                }
                
            }
        //Then sort the champion array based on weight class.
        fighterArrayChampions.sort { (s1, s2) -> Bool in
            
            return s1.Weight < s2.Weight
        }
        
    }
    //This functions uses the arrays that were populated above to generate the sections foe the table.
    func populateSections()
    {
        var arrayCounter = 0
        //For common letters (anything except X,Y,Z basically) we can just add them to the object array. Dont need to do a check to see if anyting is in fighterArrayA
        objectsArray = [Objects(sectionName: "A", sectionObjects: [fighterArrayA.first!])]
        
        //Need a counter incase their arent any fighters that will be in the section.
        //E.g. if no fighters are present in the fighterArrayA then we dont add it to the section.
        arrayCounter = fighterArrayA.count
        for i in 1...fighterArrayA.count
        {
            //If there is only 1 element in the array then exit out of loop and move to next.
            if(i == arrayCounter)
            {
                break
            }
            //If there is another element append it to the section.
            objectsArray[0].sectionObjects.append(fighterArrayA[i])
        }
        objectsArray.append(Objects(sectionName: "B",sectionObjects:[fighterArrayB.first!]))
        arrayCounter = fighterArrayB.count
        for i in 1...fighterArrayB.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray[1].sectionObjects.append(fighterArrayB[i])
        }
        
   objectsArray.append(Objects(sectionName: "C",sectionObjects:[fighterArrayC.first!]))
    arrayCounter = fighterArrayC.count
        for i in 1...fighterArrayC.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray[2].sectionObjects.append(fighterArrayC[i])
        }
       
        objectsArray.append(Objects(sectionName: "D",sectionObjects:[fighterArrayD.first!]))
        arrayCounter = fighterArrayD.count
        for i in 1...fighterArrayD.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray[3].sectionObjects.append(fighterArrayD[i])
        }
        
         objectsArray.append(Objects(sectionName: "E",sectionObjects:[fighterArrayE.first!]))
        arrayCounter = fighterArrayE.count
        for i in 1...fighterArrayE.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray[4].sectionObjects.append(fighterArrayE[i])
        }
        
         objectsArray.append(Objects(sectionName: "F",sectionObjects:[fighterArrayF.first!]))
        arrayCounter = fighterArrayF.count
        for i in 1...fighterArrayF.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray[5].sectionObjects.append(fighterArrayF[i])
        }
        
      objectsArray.append(Objects(sectionName: "G",sectionObjects:[fighterArrayG.first!]))
        arrayCounter = fighterArrayG.count
        for i in 1...fighterArrayG.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray[6].sectionObjects.append(fighterArrayG[i])
        }
        
         objectsArray.append(Objects(sectionName: "H",sectionObjects:[fighterArrayH.first!]))
        arrayCounter = fighterArrayH.count
        for i in 1...fighterArrayH.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray[7].sectionObjects.append(fighterArrayH[i])
        }
       
            objectsArray.append(Objects(sectionName: "I",sectionObjects:[fighterArrayI.first!]))
            arrayCounter = fighterArrayI.count
            for i in 1...fighterArrayI.count
            {
                if(i == arrayCounter)
                {
                    break
                }
                objectsArray[8].sectionObjects.append(fighterArrayI[i])
            }
        

        objectsArray.append(Objects(sectionName: "J",sectionObjects:[fighterArrayJ.first!]))
        arrayCounter = fighterArrayJ.count
        for i in 1...fighterArrayJ.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray[9].sectionObjects.append(fighterArrayJ[i])
        }
      
        objectsArray.append(Objects(sectionName: "K",sectionObjects:[fighterArrayK.first!]))
        arrayCounter = fighterArrayK.count
        for i in 1...fighterArrayK.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray[5].sectionObjects.append(fighterArrayK[i])
        }
        
        objectsArray.append(Objects(sectionName: "L",sectionObjects:[fighterArrayL.first!]))
        arrayCounter = fighterArrayL.count
        for i in 1...fighterArrayL.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray[11].sectionObjects.append(fighterArrayL[i])
        }
      
       objectsArray.append(Objects(sectionName: "M",sectionObjects:[fighterArrayM.first!]))
        arrayCounter = fighterArrayM.count
        for i in 1...fighterArrayM.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray[12].sectionObjects.append(fighterArrayM[i])
        }
       
         objectsArray.append(Objects(sectionName: "N",sectionObjects:[fighterArrayN.first!]))
        arrayCounter = fighterArrayN.count
        for i in 1...fighterArrayN.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray[13].sectionObjects.append(fighterArrayN[i])
        }
      
         objectsArray.append(Objects(sectionName: "O",sectionObjects:[fighterArrayO.first!]))
        arrayCounter = fighterArrayO.count
        for i in 1...fighterArrayO.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray[14].sectionObjects.append(fighterArrayO[i])
        }
      
         objectsArray.append(Objects(sectionName: "P",sectionObjects:[fighterArrayP.first!]))
        arrayCounter = fighterArrayP.count
        for i in 1...fighterArrayP.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray[15].sectionObjects.append(fighterArrayP[i])
        }
       
        objectsArray.append(Objects(sectionName: "Q",sectionObjects:[fighterArrayQ.first!]))
        arrayCounter = fighterArrayQ.count
        for i in 1...fighterArrayQ.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray[16].sectionObjects.append(fighterArrayQ[i])
        }
       
         objectsArray.append(Objects(sectionName: "R",sectionObjects:[fighterArrayR.first!]))
        arrayCounter = fighterArrayR.count
        for i in 1...fighterArrayR.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray[17].sectionObjects.append(fighterArrayR[i])
        }
        
         objectsArray.append(Objects(sectionName: "S",sectionObjects:[fighterArrayS.first!]))
        arrayCounter = fighterArrayS.count
        for i in 1...fighterArrayS.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray[18].sectionObjects.append(fighterArrayS[i])
        }
      
         objectsArray.append(Objects(sectionName: "T",sectionObjects:[fighterArrayT.first!]))
        arrayCounter = fighterArrayT.count
        for i in 1...fighterArrayT.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray[19].sectionObjects.append(fighterArrayT[i])
        }
       
        if(!fighterArrayU.isEmpty)
        {
        objectsArray.append(Objects(sectionName: "U",sectionObjects:[fighterArrayU.first!]))
        arrayCounter = fighterArrayU.count
       for i in 1...fighterArrayU.count
       {
            if(i == arrayCounter)
           {
            break
            }
                objectsArray[20].sectionObjects.append(fighterArrayU[i])
        }
        }
        objectsArray.append(Objects(sectionName: "V",sectionObjects:[fighterArrayV.first!]))
        arrayCounter = fighterArrayV.count
        for i in 1...fighterArrayV.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray[21].sectionObjects.append(fighterArrayV[i])
        }
       
        
        if(!fighterArrayW.isEmpty)
        {
         objectsArray.append(Objects(sectionName: "W",sectionObjects:[fighterArrayW.first!]))
        arrayCounter = fighterArrayW.count
        for i in 1...fighterArrayW.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray[22].sectionObjects.append(fighterArrayW[i])
        }
        }
        if(!fighterArrayX.isEmpty)
        {
        objectsArray.append(Objects(sectionName: "X",sectionObjects:[fighterArrayW.first!]))
        arrayCounter = fighterArrayX.count
        for i in 1...fighterArrayX.count
            {
                if(i == arrayCounter)
                {
                    break
                }
                objectsArray[23].sectionObjects.append(fighterArrayX[i])
            }
        }
        if(!fighterArrayY.isEmpty)
        {
        objectsArray.append(Objects(sectionName: "Y",sectionObjects:[fighterArrayY.first!]))
        arrayCounter = fighterArrayY.count
        for i in 1...fighterArrayY.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray[24].sectionObjects.append(fighterArrayY[i])
        }
        }
        if(!fighterArrayZ.isEmpty)
        {
        objectsArray.append(Objects(sectionName: "Z",sectionObjects:[fighterArrayZ.first!]))
        arrayCounter = fighterArrayZ.count
        for i in 1...fighterArrayZ.count
            {
                if(i == arrayCounter)
                {
                    break
                }
                objectsArray[25].sectionObjects.append(fighterArrayZ[i])
            }
        }
        
        objectsArray2 = [Objects(sectionName: "Flyweight", sectionObjects: [fighterArray125Men.first!])]
        arrayCounter = fighterArray125Men.count
        for i in 1...fighterArray125Men.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray2[0].sectionObjects.append(fighterArray125Men[i])
        }
         objectsArray2.append(Objects(sectionName: "Bantamweight", sectionObjects: [fighterArray135Men.first!]))
        arrayCounter = fighterArray135Men.count
        for i in 1...fighterArray135Men.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray2[1].sectionObjects.append(fighterArray135Men[i])
        }
         objectsArray2.append(Objects(sectionName: "Featherweight", sectionObjects: [fighterArray145Men.first!]))
        arrayCounter = fighterArray145Men.count
        for i in 1...fighterArray145Men.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray2[2].sectionObjects.append(fighterArray145Men[i])
        }
         objectsArray2.append(Objects(sectionName: "Lightweight", sectionObjects: [fighterArray155Men.first!]))
        arrayCounter = fighterArray155Men.count
        for i in 1...fighterArray155Men.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray2[3].sectionObjects.append(fighterArray155Men[i])
        }
         objectsArray2.append(Objects(sectionName: "Welterweight", sectionObjects: [fighterArray170Men.first!]))
        arrayCounter = fighterArray170Men.count
        for i in 1...fighterArray170Men.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray2[4].sectionObjects.append(fighterArray170Men[i])
        }
         objectsArray2.append(Objects(sectionName: "Middleweight", sectionObjects: [fighterArray185Men.first!]))
        arrayCounter = fighterArray185Men.count
        for i in 1...fighterArray185Men.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray2[5].sectionObjects.append(fighterArray185Men[i])
        }
         objectsArray2.append(Objects(sectionName: "Light Heavyweight", sectionObjects: [fighterArray205Men.first!]))
        arrayCounter = fighterArray205Men.count
        for i in 1...fighterArray205Men.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray2[6].sectionObjects.append(fighterArray205Men[i])
        }
         objectsArray2.append(Objects(sectionName: "Heavyweight", sectionObjects: [fighterArray265Men.first!]))
        arrayCounter = fighterArray265Men.count
        for i in 1...fighterArray265Men.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray2[7].sectionObjects.append(fighterArray265Men[i])
        }
        if(fighterArray115Women.isEmpty == false)
        {
         objectsArray2.append(Objects(sectionName: "Women's Strawweight", sectionObjects: [fighterArray115Women.first!]))
        arrayCounter = fighterArray115Women.count
        for i in 1...fighterArray115Women.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray2[8].sectionObjects.append(fighterArray115Women[i])
        }
        }
        if(fighterArray135Women.isEmpty == false)
        {
         objectsArray2.append(Objects(sectionName: "Women's Bantamweight", sectionObjects: [fighterArray135Women.first!]))
        arrayCounter = fighterArray135Women.count
        for i in 1...fighterArray135Women.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray2[9].sectionObjects.append(fighterArray135Women[i])
        }
        }
        
        objectsArray3 = [Objects(sectionName: "Champions", sectionObjects: [fighterArrayChampions.first!])]
        arrayCounter = fighterArrayChampions.count
        for i in 1...fighterArrayChampions.count
        {
            if(i == arrayCounter)
            {
                break
            }
            objectsArray3[0].sectionObjects.append(fighterArrayChampions[i])
        }

        
        
    }
    
    
  
}

//http://stackoverflow.com/questions/24130026/swift-how-to-sort-array-of-custom-objects-by-property-value
//irst, declare your Array as a typed array so that you can call methods when you iterate:
//
//var images : [imageFile] = []
//Then you can simply do:
//
//images.sort({ $0.fileID > $1.fileID })
//The example above gives desc sort order
