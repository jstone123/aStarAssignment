
#include <sstream>
#include <string>
#include <iostream>
#include <fstream>
#include <algorithm>
#include <stdexcept>
using namespace std;

//Exception class that will be thrown when the user inputs an invalid key when trying to pop an element by its key.
class keyInvalidException : public runtime_error
{


public:
	keyInvalidException::keyInvalidException() : runtime_error("Invalid key entered. Please enter a valid key: ") {}
};

//Exception class that will be thrown when the user inputs an invalid index when trying to pop an element by its index.
class indexInvalidException : public runtime_error
{


public:
	indexInvalidException::indexInvalidException() : runtime_error("Invalid index entered. Please enter a valid index. Between 0 and ") {}
};

class valueInvalidException : public invalid_argument
{


public:
	valueInvalidException::valueInvalidException() : invalid_argument("Invalid value/value type entered.") {}
};


class customClass
{



};



//template <class TKeyType, class TValueType>


typedef unsigned char    TUInt8;

typedef unsigned int     TUInt32;



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
	testClass()
	{

		m_array = new TKeyValuePair[m_arraySize];//Allocate memory for array.


		for (int i = 0; i < m_arraySize; ++i)
		{
			m_array[i].value =  NULL;//Every value variable is set to NULL to allow 
		}
	}
	//Destructor
	~testClass()
	{
		delete[] m_array;
	}

	void getValueType()
	{
		cout <<  typeid(TValueType).name();
	}

	void displayArray()
	{
		for (int i = 0; i < m_arraySize; ++i)
		{
			cout <<"index = " << i << " key = " << m_array[i].key << " value = " << m_array[i].value << endl;
		}
	}

	void newAray()
	{
		delete [] m_array;
		m_array = new T[m_arraySize];

		for (int i = 0; i < m_arraySize; ++i)
		{
			m_array[i] =  NULL;
			cout << i << endl;
		}
	}
	//For the hash function being used we need the length of the key. 
	//An easy way to get the length of anything is put it into a string and use .length() . 
	string convertToString(TKeyType data)
	{

		string convertedString;
		ostringstream convert;
		convert << data;
		convertedString = convert.str();
		return convertedString;

	/*	return to_string(data);*/
	}

	int TestHash1(string str)
	{
		int number = 0;
		int stringLength = str.length();
		for (int i = 0; i < stringLength; i++)
		{

			number += static_cast<int>(str[i]);

		}
		//cout << "1. " << number << endl;

		//number += (str[stringLength - 1] - str[0]);
	//	cout << "1. " << number << endl;

	//	number *= (rand() % 100 + 1 * rand() % 100 + 1);
		if (m_arraySize == m_initialArraySize)
		{
			number %= m_initialArraySize;
		}

		if (m_arraySize == m_newArraySize)
		{
			number %= m_newArraySize;
		}
		
		if (number >= m_arraySize)
		{

			number /= 2;
		}

		//cout << "hash =  " << number << endl;
		//cout << "hash = " << number << " key =  " << str << endl;
		return number;
	}

	int generateKey(TKeyType key)
	{
		string keyString = convertToString(key);
		return TestHash1(keyString);
	}

	void AddKey(TKeyType key,TValueType value)
	{
		bool temp;
		checkArrayFill(temp);

		int hashedKey = generateKey(key);
		//int counter = 0;
		//int hashedKeyCopy = hashedKey;
		while (m_array[hashedKey].value != NULL)
		{
			hashedKey += 1;
		}
		m_array[hashedKey].key = key;
		m_array[hashedKey].value = value;

		checkArrayFill(temp);//Check the fill % of array before and after we insert a new set of data.

		//cout << m_array[hashedKey].value << endl;
	}

	void updateData(TKeyType key, TValueType newValue)
	{
		int index = findData(key);
		m_array[index].value = newValue;
	}

	void displayData(TKeyType key)
	{
		int index = findData(key);
		cout << "key = " << m_array[index].key << ", value = " << m_array[index].value << endl;
	}


	//Pop function. Moves through array from last element and removes the first valid entry it finds.
	void popBack()
	{
		cout << m_array[m_arraySize - 1].value << " in array" << endl;
		cout << "Last element = " << m_array[m_arraySize - 1].key << " " << m_array[m_arraySize - 1].value << endl;
				m_array[m_arraySize - 1].key = '\0';
				m_array[m_arraySize - 1].value = 123;
				return;		
	}
	//Remove first element.
	void popFront()
	{	
		/*cout << "in pop front" << endl;*/
		cout << "Element you removed: " << m_array[0].key << " " << m_array[0].value << endl;
		m_array[0].key = '\0';
		m_array[0].value = 123;
		//cout << "deleted" << endl;
		//cout << "in pop front" << endl;
	}

	int getArraySize()
	{
		return m_arraySize;
	}
	//Remove element by providing an array index.
	void popAtIndex(int index)
	{	
			if (index < 0 || index >= m_arraySize)
			{
				throw indexInvalidException();
			}	
		cout << "Element you removed: " << m_array[index].key << " " << m_array[index].value << endl;
		m_array[index].key = '\0';
		m_array[index].value = 123;
		cout << "deleted" << endl;
	}

	//Remove an element by providing its key.
	void popUsingKey(TKeyType key)
	{
		int hashedKey = generateKey(key);
		int hashKeyCopy = hashedKey;
			while (m_array[hashedKey].key != key)
			{	
				hashedKey++;
				if (hashedKey == m_arraySize - 1)
				{
					hashedKey = 0;
				}	
				if (hashKeyCopy == hashedKey)
				{
					throw keyInvalidException();
				}
			}	

			cout << "inside pop key" << endl;
		cout << "element you removed: " << m_array[hashedKey].key << " " << m_array[hashedKey].value << endl;
		m_array[hashedKey].key = '\0';
		m_array[hashedKey].value = 123;
		cout << "deleted" << endl;

	}



	int findData(TKeyType key)
	{
		int hashedKey = generateKey(key);
		int hashKeyCopy = hashedKey;//Keep a copy of the original key so we know when every element of the array has been checked. 
		cout << "hashed key = " << hashedKey << endl;
		while (m_array[hashedKey].key != key)
		{
			hashedKey++;
			if (hashedKey == m_arraySize - 1)
			{
				hashedKey = 0;
			}	
			if (hashKeyCopy == hashedKey)
			{
				cout << "in execetpion throw" << endl;
				throw keyInvalidException();
			}
		}
		//cout << "Data at key provided = " << m_array[hashedKey].value << endl;
		//Return the index where the data is. This may be different than the value created when we first generate the key.
		//Due to linear probing being used to deal with collisions. 
		return hashedKey;
	}

	void thing(int number)
	{
		cout << m_array[number].value << " = value " << endl;
	}

	//This function checks how much of the array is filled. When hash tables become ~70%+ full the potential for a collission increase drastically. 
	//This will be used to determine when to create a new array.
	void checkArrayFill(bool &arrayFilled)
	{

		float counter = 0;
		for (int i = 0; i < m_arraySize; ++i)
		{

			if (m_array[i].value != NULL)
			{
				counter++;
			}
		}
		float fill = (counter /= m_arraySize) * 100;
		if (fill >= 70.0f)
		{
			createNewArray();
			arrayFilled = true;
		}
		//cout << "% fill = " << fill  << endl;
	}

	void createNewArray()
	{

		TKeyValuePair* m_TempArray = new TKeyValuePair[m_arraySize];

		for (int i = 0; i < m_arraySize; ++i)
		{
			m_TempArray[i].key = m_array[i].key;
			m_TempArray[i].value = m_array[i].value;
		}


		TUInt32 oldArraySize = m_arraySize;
		m_arraySize = m_newArraySize;//Double size of array.

		delete[] m_array;//delete old array before creating new one.




		m_array = new TKeyValuePair[m_arraySize];

		for (int i = 0; i < m_arraySize; ++i)
		{
			m_array[i].value = NULL;
		}


		for (int i = 0; i < oldArraySize; ++i)
		{
			m_array[i].key = m_TempArray[i].key;
			m_array[i].value = m_TempArray[i].value;
		}

		delete[] m_TempArray;//Delete temp array because its no longer needed.


		cout << "NEW ARRAY CREATED " << endl;
	}

	void emptyArray()
	{
		for (int i = 0; i < m_arraySize; ++i)
		{
			m_array[i].key = NULL;
			m_array[i].value = NULL;
		}
	}

	void testArrayFill()
	{
		bool arrayFilled = false;
		for (int i = 0; i < m_arraySize; i++)
		{
			m_array[i].value = i;
			checkArrayFill(arrayFilled);
			if (arrayFilled)
			{
				break;
			}
		}
	
		displayArray();
	}

	bool isEmpty()
	{

		for (int i = 0; i < m_arraySize; i++)
		{
			if (m_array[i].value == NULL)
			{
				return true;
			}
		}
		return false;
	}

	void saveToFile(ofstream &outfile)
	{
		outfile.open("Output File.txt");

		for (int i = 0; i < m_arraySize; i++)
		{

			outfile << "key: " << m_array[i].key << ", value: " << m_array[i].value << endl;
		}
	}

	

};

void convertToUpper(string &word)
{
	for (int i = 0; i < word.size(); ++i)
	{
		word[i] = toupper(word[i]);
	}
}


int main()
{
	
	const string phonebook = "phonebook1.txt";
	const string numberList = "Numbers.txt";
	 
	enum activeTypes { strings, integer, floating, doubles };
	
	bool successfulOperation = false;


	activeTypes activeType;

	int testNumber;
	bool exceptionOccured = false;
	int index, key1;


	cout << "What type do you want to test: " << endl;
	cout << "1. string" << endl;
	cout << "2. int" << endl;
	cout << "3. float" << endl;
	cout << "4. double" << endl;
	//cin >> testNumber;


	string thing = "SHARLA AARON";
	for (int i = 0; i < thing.length(); i++)
	{
		cout << thing[i] << endl;

	}



	string sFirstName, sSecondName, sName, sPhone;
	ifstream infile;
	ofstream outfile;
	
	
	
	//STRING TEST
	//key type, data type,
	//infile.open("phonebook1.txt");
	testClass <string, int> *stringTest;
	//try
	//{
	//	stringTest = new testClass<string, int>();
	//}
	//catch (const std::bad_alloc& e)
	//{
	//	cout << e.what() << endl;
	//	cout << "Fatal memory error. Program will now exit. " << endl;
	//	exit(0);
	//}
	//	//stringTest->testArrayFill();

	//	while (!infile.eof())
	//	{

	//		memset(&sName, 0, sizeof(int));
	//		// Read and combine name and surname
	//		infile >> sFirstName >> sSecondName;
	//		sName = sFirstName + " " + sSecondName;

	//		infile >> sPhone;
	//		stringTest->AddKey(sName, std::stoi(sPhone));

	//	}
	//	infile.close();

	//	
	//	string name, name2;


	//	stringTest->popBack();
	//	stringTest->popAtIndex(57);
	//	stringTest->popFront();
	//	stringTest->displayArray();

	//	string sKey;
	//	string sValue;
	//	string indexString;
	//		while (!successfulOperation)
	//		{
	//			exceptionOccured = false;
	//			cout << "Enter the index that you want to remove: " << endl;
	//			cin >> indexString;
	//			try
	//			{
	//				stringTest->popAtIndex(std::stoi(indexString));
	//			}
	//			catch (indexInvalidException &exception)
	//			{
	//				cout << "Exception occured: " << exception.what() << stringTest->getArraySize() << endl;
	//				exceptionOccured = true;
	//			}
	//			catch (std::invalid_argument)
	//			{
	//				cout << "Exception occured: " << valueInvalidException().what() << endl;
	//				cout << "Value type = "; 
	//				stringTest->getValueType();
	//				//stringTest->getValueType();//output the type of value.
	//					cout << endl;
	//				exceptionOccured = true;
	//			}
	//			if (!exceptionOccured)
	//			{
	//				successfulOperation = true;
	//			}
	//		}

	//		exceptionOccured = false;
	//		successfulOperation = false;
	//		cout << "pop key test" << endl;
	//		while (!successfulOperation)
	//		{
	//			exceptionOccured = false;
	//			try
	//			{
	//				cout << "Enter the key that you want to remove: " << endl;
	//				cin >> sFirstName >> sSecondName;

	//				//combine name into 1 variable.
	//				sKey = sFirstName + " " + sSecondName;
	//				convertToUpper(sKey);
	//				stringTest->popUsingKey(sKey);
	//			}
	//			catch (keyInvalidException &exception)
	//			{
	//				cout << "Exception occured: " << exception.what() << endl;
	//				exceptionOccured = true;
	//			}
	//			if (!exceptionOccured)
	//			{
	//				successfulOperation = true;
	//			}
	//		}

	//		successfulOperation = false;
	//		cout << "display data using key test" << endl;
	//		while (!successfulOperation)
	//		{
	//			exceptionOccured = false;
	//			try
	//			{
	//				cout << "Enter the key that you want to display data for: " << endl;
	//				cin >> sFirstName >> sSecondName;

	//				//		//combine name into 1 variable.
	//				sKey = sFirstName + " " + sSecondName;
	//				convertToUpper(sKey);
	//				stringTest->displayData(sKey);
	//			}
	//			catch (keyInvalidException &exception)
	//			{
	//				cout << "Exception occured: " << exception.what() << endl;
	//				exceptionOccured = true;
	//			}
	//			if (!exceptionOccured)
	//			{
	//				successfulOperation = true;
	//			}
	//		}

	//		successfulOperation = false;
	//		while (!successfulOperation)
	//		{
	//			exceptionOccured = false;
	//			try
	//			{
	//				cout << "enter name: " << endl;
	//				cin >> sFirstName >> sSecondName;

	//				//combine name into 1 variable.
	//				sName = sFirstName + " " + sSecondName;
	//				cout << "sname = " << sName << endl;
	//				convertToUpper(sName);
	//				cout << "Enter the new value: " << endl;
	//				cin >> sValue;
	//				stringTest->updateData(sName, std::stoi(sValue));
	//			}
	//			catch (keyInvalidException &exception)
	//			{
	//				cout << "Exception occured: " << exception.what() << endl;
	//				exceptionOccured = true;
	//			}
	//			catch (std::invalid_argument)
	//			{
	//				cout << "Exception occured: " << valueInvalidException().what() << endl;
	//				cout << "Value type = ";
	//				stringTest->getValueType();//output the type of value.
	//					cout << endl;
	//				exceptionOccured = true;
	//			}
	//			if (!exceptionOccured)
	//			{
	//				successfulOperation = true;
	//			}
	//		}





	//	cout << "DISPLAY DATA" << endl;
	//	cout << "enter name: " << endl;
	//	cin >> sFirstName >> sSecondName;

	//	//combine name into 1 variable.
	//	sName = sFirstName + " " + sSecondName;
	//	convertToUpper(sName);//Allows user to enter name in lower case.
	//	stringTest->updateData(sName, std::stoi(sValue));
	//	
	//	cout << "updated data" << endl;
	//	stringTest->displayData(sName);
	//
	//

	//cout << endl;
	//cout << endl;
	//cout << endl;
	//try
	//{
	//	stringTest->createNewArray();
	//}
	//catch (const std::bad_alloc& e)
	//{
	//	cout << e.what() << endl;
	//	cout << "Fatal memory error. Program will now exit. " << endl;
	//	stringTest->~testClass();
	//	exit(0);
	//}
	//cout << "END OF STRING TEST" << endl;



	//INT TEST
	testClass <int,int> *intTest = new testClass<int,int>();
	int numberKey, numberValue;
	string test1, test2;
	infile.open(numberList);

		while (!infile.eof())
		{
			// Read and combine name and surname
			infile >> test1 >> test2;
			intTest->AddKey(std::stoi(test1), std::stoi(test2));
		}
		infile.close();
		string index1;
		intTest->popBack();
		cout << "POP INDEX TEST" << endl;
		while (!successfulOperation)
		{
			index1.clear();
			exceptionOccured = false;
			cout << "Enter the index that you want to remove: " << endl;
			cin >> index1;
			try
			{
				intTest->popAtIndex(std::stoi(index1));////////////////////FIXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
			}
			catch (indexInvalidException &exception)
			{
				cout << "Exception occured: " << exception.what() << intTest->getArraySize() << endl;
				exceptionOccured = true;
			}
			catch (std::invalid_argument)
							{
								cout << "Exception occured: " << valueInvalidException().what() << endl;
								cout << "Value type = ";
								//stringTest->getValueType();//output the type of value.
									cout << endl;
								exceptionOccured = true;
							}
			if (!exceptionOccured)
			{
				successfulOperation = true;
			}
		}
		exceptionOccured = false;
		successfulOperation = false;
		cout << "POP KEY TEST" << endl;

		while (!successfulOperation)
		{
			exceptionOccured = false;
			try
			{
				cout << "Enter the key that you want to remove: " << endl;
				cin >> test1;
				intTest->popUsingKey(std::stoi(test1));

			}
			catch (keyInvalidException &exception)
			{
				cout << "Exception occured: " << exception.what() << endl;
				exceptionOccured = true;
			}
			catch (std::invalid_argument)
			{
				cout << "Exception occured: " << valueInvalidException().what() << endl;
				cout << "Value type = ";
				//stringTest->getValueType();//output the type of value.
				cout << endl;
				exceptionOccured = true;
			}
			if (!exceptionOccured)
			{
				successfulOperation = true;
			}
		}
		successfulOperation = false;
		cout << "DISPLAY DATA USING KEY TEST" << endl;
		while (!successfulOperation)
		{
			exceptionOccured = false;
			try
			{
				cout << "Enter the key that you want to find data for: " << endl;
				cin >> test1;
				intTest->displayData(std::stoi(test1));
			}
			catch (keyInvalidException &exception)
			{
				cout << "Exception occured: " << exception.what() << endl;
				exceptionOccured = true;
			}
			catch (std::invalid_argument)
			{
				cout << "Exception occured: " << valueInvalidException().what() << endl;
				cout << "Value type = ";
				//stringTest->getValueType();//output the type of value.
				cout << endl;
				exceptionOccured = true;
			}
			if (!exceptionOccured)
			{
				successfulOperation = true;
			}
		}
		//.intTest->thing(0);
		intTest->popFront();

//
//
//		intTest->saveToFile(outfile);
//



	//test->emptyArray();

	//FLOAT TEST
	//testClass <float> *test = new testClass<float>();

	//DOUBLE TEST
	//testClass <double> *test = new testClass<double>();


	cout << endl;
	cout << endl;
	cout << endl;
	//cout << sizeof(thing);
	cout << endl; cout << endl; cout << endl;

	//int number = test->TestHash1(pKeyData, 6);
	//cout << "NUMBER =   " << number << endl;
	//cout << int('4') << endl;


	cout << endl;
	cout << endl;
	

	cout << endl;
	cout << endl;
	cout << endl;


	system("pause");
	//delete stringTest;
	delete intTest;
	return 0;
}


//
//
//template <class T>
//class testClass {
//	T values[2];
//public:
//	testClass(T x, T y)
//	{
//		values[0] = x;
//		values[1] = y;
//	}
//
//};