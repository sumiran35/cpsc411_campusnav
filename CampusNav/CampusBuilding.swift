//
//  CampusBuilding.swift
//  CampusNav
//
//  Created by csuftitan on 11/29/25.
//

import Foundation
import CoreLocation

struct CampusBuilding: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let coordinate: CLLocationCoordinate2D
    let type: BuildingType
    
    enum BuildingType: String {
        case academic = "book.fill"
        case food = "fork.knife"
        case housing = "bed.double.fill"
        case sports = "sportscourt.fill"
        case parking = "park.circle.fill"
        
    }
}

let sampleBuildings = [
    // Academic Buildings
    CampusBuilding(
        name: "Pollak Library",
        description: "Main campus library and study area",
        coordinate: CLLocationCoordinate2D(latitude: 33.881555, longitude: -117.885201),
        type: .academic
    ),
    
    CampusBuilding(
            name: "Steven G. Mihaylo Hall (SGMH)",
            description: "College of Business & Economics",
            coordinate: CLLocationCoordinate2D(latitude: 33.878916, longitude: -117.883656),
            type: .academic
        ),
    
    CampusBuilding(
        name: "McCarthy Hall (MH)",
        description: "College of Natural Sciences & Mathematics",
        coordinate: CLLocationCoordinate2D(latitude: 33.879662, longitude: -117.885496),
        type: .academic
    ),
    
    CampusBuilding(
        name: "Dan Black Hall (DBH)",
        description: "STEM teaching facility",
        coordinate: CLLocationCoordinate2D(latitude: 33.879158, longitude: -117.885570),
        type: .academic
    ),
    
    CampusBuilding(
        name: "Langsdorf Hall (LH)",
        description: "Home to the Office of Admissions",
        coordinate: CLLocationCoordinate2D(latitude: 33.878932, longitude: -117.884650),
        type: .academic
    ),
    
    CampusBuilding(
        name: "Gordon Hall (GH)",
        description: "Humanities & Social Sciences",
        coordinate: CLLocationCoordinate2D(latitude: 33.879757,  longitude: -117.884189),
        type: .academic
    ),
    
    CampusBuilding(
        name: "Humanities(H)",
        description: "Classrooms of the college of Humanities and Social Sciences",
        coordinate: CLLocationCoordinate2D(latitude: 33.880499, longitude: -117.884314),
        type: .academic
    ),
    
    CampusBuilding(
        name: "Education-Classroom (EC)",
        description: "Home of the college of education",
        coordinate: CLLocationCoordinate2D(latitude: 33.881243, longitude: -117.884358),
        type: .academic
    ),
    
    CampusBuilding(
        name: "Engineering (E)",
        description: "Classes for the engineering department",
        coordinate: CLLocationCoordinate2D(latitude: 33.882335, longitude: -117.883212),
        type: .academic
    ),
    
    CampusBuilding(
        name: "Computer Science (CS)",
        description: "Classes for the computer science department",
        coordinate: CLLocationCoordinate2D(latitude: 33.882328, longitude: -117.882643),
        type: .academic
    ),
    
    CampusBuilding(
        name: "Kinesiology & Health Science (KHS)",
        description: "Classes for the Kinesology and Health Science department",
        coordinate: CLLocationCoordinate2D(latitude: 33.882819, longitude: -117.885430),
        type: .academic
    ),
    
    CampusBuilding(
            name: "Ruby Gerontology Center (RG)",
            description: "Home to the Osher Lifelong Learning Institute",
            coordinate: CLLocationCoordinate2D(latitude: 33.883641, longitude: -117.883249),
            type: .academic
        ),
    
    CampusBuilding(
        name: "Clayes Performing Arts Center (CPAC)",
        description: "Home to the preforming arts department",
        coordinate: CLLocationCoordinate2D(latitude: 33.880463, longitude: -117.886648),
        type: .academic
    ),
    
    CampusBuilding(
        name: "Visual Arts Complex (VA)",
        description: "Home to the Visual Arts department and art exibits",
        coordinate: CLLocationCoordinate2D(latitude: 33.880352, longitude: -117.888445),
        type: .academic
    ),
    
    CampusBuilding(
        name: "Collage Park (CP)",
        description: "Off site administrative building",
        coordinate: CLLocationCoordinate2D(latitude: 33.877551, longitude: -117.883413),
        type: .academic
    ),
    
    CampusBuilding(
        name: "Modular Complex (MC)",
        description: "Temporary building for many uses often relocations",
        coordinate: CLLocationCoordinate2D(latitude:  33.878732, longitude: -117.886177),
        type: .academic
    ),
    
    CampusBuilding(
        name: "Titan Hall (THALL)",
        description: "An administrative building housing department and services",
        coordinate: CLLocationCoordinate2D(latitude: 33.880873, longitude: -117.890042),
        type: .academic
    ),
    
    CampusBuilding(
        name: "Titan House",
        description: "Historic building that is home to the athletics department",
        coordinate: CLLocationCoordinate2D(latitude: 33.883837, longitude: -117.884148),
        type: .academic
    ),
    
    CampusBuilding(
        name: "Military Science (MS)",
        description: "Classes for the ROTC program",
        coordinate: CLLocationCoordinate2D(latitude: 33.884151, longitude: -117.884080),
        type: .academic
    ),
    
    // Services and recreation buildings
    
    CampusBuilding(
        name: "Student Recreation Center (SRC)",
        description: "Campus Gym and Other athletic programs",
        coordinate: CLLocationCoordinate2D(latitude: 33.882973, longitude: -117.887792),
        type: .sports
    ),
    
    CampusBuilding(
        name: "Titan Student Union",
        description: "Food court, student resources, meeting rooms, and entertainment",
        coordinate: CLLocationCoordinate2D(latitude:33.881350, longitude:-117.887668),
        type: .food
    ),
    
    CampusBuilding(
            name: "Golleher Alumni House",
            description: "Alumni events and relations",
            coordinate: CLLocationCoordinate2D(latitude: 33.882367, longitude: -117.889352),
            type: .academic
        ),
    
    CampusBuilding(
        name: "Titan Shop",
        description: "The main university store with clothes, books, supplies, technolgy, and food.",
        coordinate: CLLocationCoordinate2D(latitude: 33.881920, longitude: -117.886820),
        type: .food
    ),
    
    CampusBuilding(
        name: "Auxiliary Services Corporation",
        description: "Administrative building",
        coordinate: CLLocationCoordinate2D(latitude: 33.881223, longitude: -117.890537),
        type: .academic
    ),
    
    CampusBuilding(
        name: "University Police",
        description: "Campuse police and safety",
        coordinate: CLLocationCoordinate2D(latitude:33.883140, longitude: -117.889384),
        type: .academic
    ),
    
    CampusBuilding(
        name: "Children's Center",
        description: "On campus daycare and classes for child development",
        coordinate: CLLocationCoordinate2D(latitude:33.885939, longitude: -117.888438),
        type: .academic
    ),
    
    CampusBuilding(
        name: "Corporation Yard",
        description: "Mangeging maintance",
        coordinate: CLLocationCoordinate2D(latitude: 33.884992, longitude: -117.887890),
        type: .academic
    ),
    
    CampusBuilding(
        name: "Reciving",
        description: "Where mail and packeges are recived",
        coordinate: CLLocationCoordinate2D(latitude: 33.884090, longitude: -117.888870),
        type: .academic
    ),
    
    CampusBuilding(
        name: "Becker Amphitheater",
        description: "Outdoor event space",
        coordinate: CLLocationCoordinate2D(latitude: 33.881274, longitude: -117.887054),
        type: .academic
    ),
    
    CampusBuilding(
        name: "Greenhouse Complex",
        description: "A facility for growing plants",
        coordinate: CLLocationCoordinate2D(latitude: 33.879628, longitude: -117.886977),
        type: .academic
    ),
    
    // Dining
    
    CampusBuilding(
        name: "Gastronome",
        description: "The main residentl dining hall",
        coordinate: CLLocationCoordinate2D(latitude: 33.883119, longitude: -117.882486),
        type: .food
    ),
    
    CampusBuilding(
            name: "Carl's Jr",
            description: "An on campus fast food resturant",
            coordinate: CLLocationCoordinate2D(latitude: 33.879408, longitude: -117.883894),
            type: .food
        ),
    
    // Housing
    
    CampusBuilding(
        name: "Titan Shop",
        description: "The main university store with clothes, books, supplies, technolgy, and food.",
        coordinate: CLLocationCoordinate2D(latitude: 33.881920, longitude: -117.886820),
        type: .food
    ),
    
    // Athletics facilites
    
    CampusBuilding(
        name: "Titan Gymnasium",
        description: "Indoor sports arena",
        coordinate: CLLocationCoordinate2D(latitude: 33.883180, longitude: -117.886621),
        type: .sports
    ),
    
    CampusBuilding(
        name: "Titan Stadium",
        description: "A multi purpose outdoor sports stadium.",
        coordinate: CLLocationCoordinate2D(latitude: 33.886743, longitude: -117.887002),
        type: .sports
    ),
    
    CampusBuilding(
        name: "Goodwin Field",
        description: "The campus baseball field",
        coordinate: CLLocationCoordinate2D(latitude: 33.887029, longitude: -117.885451),
        type: .sports
    ),
    
    CampusBuilding(
        name: "Anderson Field",
        description: "The campus softball field",
        coordinate: CLLocationCoordinate2D(latitude: 33.885952, longitude: -117.885010),
        type: .sports
    ),
    
    CampusBuilding(
        name: "Titan softball Field",
        description: "The campus softball field",
        coordinate: CLLocationCoordinate2D(latitude: 33.885308, longitude: -117.884586),
        type: .sports
    ),
    CampusBuilding(
        name: "Titan Track & Field",
        description: "The campus track and field area",
        coordinate: CLLocationCoordinate2D(latitude: 33.885174, longitude: -117.886244),
        type: .sports
    ),
    
    CampusBuilding(
        name: "Titan Tennis Courts",
        description: "The campus tennis courts",
        coordinate: CLLocationCoordinate2D(latitude: 33.884156, longitude: -117.886920),
        type: .sports
    ),
    
    CampusBuilding(
        name: "Intramural Field",
        description: "Gerneral recreational field",
        coordinate: CLLocationCoordinate2D(latitude: 33.884174, longitude: -117.885617),
        type: .sports
    ),
    
    CampusBuilding(
        name: "BaseBall clubhouse",
        description: "The main meeting area of the baseball team",
        coordinate: CLLocationCoordinate2D(latitude: 33.887367, longitude: -117.886178),
        type: .sports
    ),
    
    CampusBuilding(
            name: "Softball clubhouse",
            description: "The main meeting area of the softball team",
            coordinate: CLLocationCoordinate2D(latitude: 33.886489, longitude: -117.884917),
            type: .sports
        ),
    
    // Garden area
    
    CampusBuilding(
        name: "Arboretum botanical garden",
        description: "The entrence to the botanical gardens",
        coordinate: CLLocationCoordinate2D(latitude: 33.888159, longitude: -117.884245),
        type: .academic
    ),
    
    CampusBuilding(
        name: "Arboretum office",
        description: "The administrative office of the arboretum garden",
        coordinate: CLLocationCoordinate2D(latitude: 33.888001, longitude: -117.883480),
        type: .academic
    ),
    
    CampusBuilding(
        name: "Heriatage House",
        description: "A 19th century house that is now a museum",
        coordinate: CLLocationCoordinate2D(latitude: 33.887709, longitude: -117.883970),
        type: .academic
    ),
    
    // Parking and Transportation
    
    CampusBuilding(
        name: "State College Parking Structure",
        description: "A large parking structure on the west side near the student recreation center",
        coordinate: CLLocationCoordinate2D(latitude: 33.883266, longitude: -117.888722),
        type: .parking
    ),
    
    CampusBuilding(
        name: "Nutwood Parking Structure",
        description: "A large parking structure on the south-west near Nutwood Ave",
        coordinate: CLLocationCoordinate2D(latitude: 33.879025, longitude: -117.888520),
        type: .parking
    ),
    
    CampusBuilding(
        name: "Eastside North Parking Structure",
        description: "The northern part of a large parking struture on the east side of campus",
        coordinate: CLLocationCoordinate2D(latitude: 33.881135, longitude: -117.881802),
        type: .parking
    ),
    
    CampusBuilding(
        name: "Eastside South Parking Structure",
        description: "The southern part of a large parking structure on the east side of campus",
        coordinate: CLLocationCoordinate2D(latitude: 33.880322, longitude: -117.881796),
        type: .parking
    ),
    
    CampusBuilding(
        name: "Parking & Transportation Office",
        description: "The main admin office of parking and transportation",
        coordinate: CLLocationCoordinate2D(latitude: 33.884862, longitude: -117.889337),
        type: .parking
    ),
    
    // Housing
    
    CampusBuilding(
        name: "Housing Pine",
        description: "Student on campus housing",
        coordinate: CLLocationCoordinate2D(latitude: 33.883579, longitude: -117.882738),
        type: .housing
    ),
    
    CampusBuilding(
            name: "Housing Holly",
            description: "Student on campus housing",
            coordinate: CLLocationCoordinate2D(latitude: 33.883856, longitude: -117.881682),
            type: .housing
        ),
    
    CampusBuilding(
        name: "Housing Juniper",
        description: "Student on campus housing",
        coordinate: CLLocationCoordinate2D(latitude: 33.884133, longitude: -117.882400),
        type: .housing
    ),
    
    CampusBuilding(
        name: "Housing Acaia",
        description: "Student on campus housing",
        coordinate: CLLocationCoordinate2D(latitude: 33.884552, longitude: -117.882534),
        type: .housing
    ),
    
    CampusBuilding(
        name: "Housing Birch",
        description: "Student on campus housing",
        coordinate: CLLocationCoordinate2D(latitude: 33.884563, longitude: -117.882147),
        type: .housing
    ),
    
    CampusBuilding(
        name: "Housing Fig",
        description: "Student on campus housing",
        coordinate: CLLocationCoordinate2D(latitude: 33.884494, longitude: -117.881714),
        type: .housing
    ),
    
    CampusBuilding(
        name: "Housing Manzanita",
        description: "Student on campus housing",
        coordinate: CLLocationCoordinate2D(latitude: 33.885049, longitude: -117.882639),
        type: .housing
    ),
    
    CampusBuilding(
        name: "Housing Oak",
        description: "Student on campus housing",
        coordinate: CLLocationCoordinate2D(latitude: 33.885062, longitude: -117.882148),
        type: .housing
    ),
    
    CampusBuilding(
        name: "Housing Elm",
        description: "Student on campus housing",
        coordinate: CLLocationCoordinate2D(latitude: 33.885148, longitude: -117.881710),
        type: .housing
    ),
    
    CampusBuilding(
        name: "Housing Willow",
        description: "Student on campus housing",
        coordinate: CLLocationCoordinate2D(latitude: 33.885390, longitude: -117.882440),
        type: .housing
    ),
    
    CampusBuilding(
        name: "Housing Cypress",
        description: "Student on campus housing",
        coordinate: CLLocationCoordinate2D(latitude: 33.885763, longitude: -117.882392),
        type: .housing
    ),
    
    CampusBuilding(
        name: "Housing Sycamore",
        description: "Student on campus housing",
        coordinate: CLLocationCoordinate2D(latitude: 33.886061, longitude: -117.882180),
        type: .housing
    ),
    
    CampusBuilding(
        name: "Housing Valencia",
        description: "Student on campus housing",
        coordinate: CLLocationCoordinate2D(latitude: 33.885967, longitude: -117.881803),
        type: .housing
    )
    //add more from directory idk if we can use ai here to
    //extract from the school directory or what
    //might need some scraping or extra engeering
    //this is how we get pins on the map
]
