//Josh Stone JStone3
#include "PathFindingFunctions.h"
int main()
{
	cout << "A Star Search program" << endl; 
	//Create input and output streams for reading files and outputting generated routes.
	ifstream infile;
	ofstream outfile;
	//File names with map information.
	string dCoordsFile = "dCoords.txt";
	string dMapFile = "dMap.txt";
	string mCoordsFile = "mCoords.txt";
	string mMapFile = "mMap.txt";
	string outputFile = "Output.txt";
	SCoords mMapStart;//Variable used to store start position for mMap. 
	SCoords mMapEnd;//Variable used to store end position for mMap. 
	SCoords dMapStart;//Variable used to store start position for dMap. 
	SCoords dMapEnd;//Variable used to store end position for dMap. 
	SCoords north;//Variable used to store information about north node.
	SCoords east;//Variable used to store information about east node.
	SCoords south;//Variable used to store information about south node.
	SCoords west;//Variable used to store information about west node.
	vector<int> routeX;//Vector used to store the x coordinates of the route.
	vector<int>  routeY;//Vector used to store the y coordinates of the route.
	int mMapArray[10][10];//Array used to store the costs of each square for mMap.
	int dMapArray[10][10];//Array used to store the costs of each square for dMap.
	EMaps map = mMap;//Enum used to indicate which map is being searched.
	int newCost;//Variable used to store the cost of moving to the new node.
	int existingCost;//Variable used to store the cost of moving to the new node if it has already been visited.
	bool goalReached = false;//Variable used to ensure that search doesn't end until the goal is reached.
	ReadFiles(infile, mCoordsFile, mMapStart, mMapEnd, mMapFile, mMapArray);//Read in the files for the mMap.
	ReadFiles(infile, dCoordsFile, dMapStart, dMapEnd, dMapFile, dMapArray);//Read in dMap files.
	deque <unique_ptr < SCoords > > openList;//Open list is a list sorted by score and the new nodes are generated using this list.
	deque <unique_ptr < SCoords > > closedList;//Closed list is an unordered list that stores nodes that have already been visited.
	unique_ptr <SCoords> currentNode;//Current node is used to store the information when each node is popped off the open list.
	InitialiseList(mMapStart, mMapEnd, openList, newCost, existingCost);//We then set up open list and push the start point onto it.
	cout << "mMap Search" << endl;
	system("pause");
	PathFind(goalReached, openList, closedList, mMapEnd, north, east, south, west, mMapArray, newCost, existingCost);//The path is then found using this function which
	//encapsulates all the other functions involved in finding the path.
	//Outputting route information to file. 
	outfile.open(outputFile, std::ofstream::out | std::ofstream::trunc);//Create the output file. We use trunc so that if the file already exists then we overwrite the current data.
	//We then use openfile.app so that we append to the end of the file ensuring dMap route doesn't overwrite mMap route.
	GenerateRoute(openList, routeX, routeY, outfile, map, mMapEnd);//We then generate the route and write it to the output file.
	system("pause");
	//ROUTE 2.
	map = dMap;//Set map enum to dMap the indicate we are searching a new map.
	openList.clear();//Clear open list to ensure that mMap nodes aren't involved in dMap search. 
	closedList.clear();//Clear closed list to ensure that mMap nodes aren't involved in dMap search.
	routeX.clear();//Vector to store x coordinates of route is cleared.
	routeY.clear();//Vector to store y coordinates of route is cleared.
	InitialiseList(dMapStart, dMapEnd, openList, newCost, existingCost);//We then set up open list and push the start point onto it.
	cout << "dMap search. " << endl;
	system("pause");
	//This is where the map is searched and the path is found.
	PathFind(goalReached, openList, closedList, dMapEnd, north, east, south, west, dMapArray, newCost, existingCost);
	outfile.open(outputFile, std::ofstream::out | std::ofstream::app);//Open the output file.
	GenerateRoute(openList, routeX, routeY, outfile, map, dMapEnd);//We then generate the route and write it to the output file.
	system("pause");
	return 0;
}
