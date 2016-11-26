#pragma once
#include <sstream>
#include <string>
#include <iostream>
#include <fstream>
#include <algorithm>
#include <stdexcept>
using namespace std;



template<class TKeyType, class TValueType>
class testClass
{
private:
	//Starting array size is large to reduce chance that a new array needs to be created.
	//In the event that the initial array becomes > 70% full then the array size is doubled. 
	//When an array becomes ~70% full the potential for collisions drastically increases and large clumps can form in the array due to linear probing. 
	TUInt32 m_initialArraySize = 2000;
	TUInt32 m_newArraySize = 4000;

	TUInt32 m_arraySize = m_initialArraySize;

	//This structs holds the key and its associated data. Will be used to allow probing to be implemented.
	struct TKeyValuePair
	{
		TKeyType         key;
		TValueType       value;
	};


	TKeyValuePair* m_array;
public:

	//Constructor
	testClass();

	//Destructor
	~testClass();


	void getValueType();


	void displayArray();


	void newAray();
	
	//For the hash function being used we need the length of the key. 
	//An easy way to get the length of anything is put it into a string and use .length() . 
	string convertToString(TKeyType data);

	int generateKey(TKeyType key);


	void AddKey(TKeyType key, TValueType value);


	void updateData(TKeyType key, TValueType newValue);


	void displayData(TKeyType key);


	//Pop function. Moves through array from last element and removes the first valid entry it finds.
	void popBack();

	//Remove first element.
	void popFront();


	int getArraySize();
	
	//Remove element by providing an array index.
	void popAtIndex(int index);
	

	//Remove an element by providing its key.
	void popUsingKey(TKeyType key);




	int findData(TKeyType key);
	



	//This function checks how much of the array is filled. When hash tables become ~70%+ full the potential for a collission increase drastically. 
	//This will be used to determine when to create a new array.
	void checkArrayFill(bool &arrayFilled);


	void createNewArray();
	

	void emptyArray();

	void testArrayFill();


	bool isEmpty();


	void saveToFile(ofstream &outfile);




};