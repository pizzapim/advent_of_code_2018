#include <iostream>
#include <vector>
#include <fstream>
#include <string>

using namespace std;

int main () {
  ifstream input;
  input.open("../input");
  string line;

  vector<string> strings = {};

  while (getline(input, line)) {
    strings.push_back(line);
  }

  // Compare every string with ones that come after it.
  for (vector<string>::const_iterator it = strings.begin(); it != strings.end(); ++it) {
    for (vector<string>::const_iterator it2 = ++it; it2 != strings.end(); ++it2) {
      int differences = 0;
      string::const_iterator str_it = it->begin();

      for (string::const_iterator str_it2 = it2->begin(); str_it2 != it2->end(); ++str_it2) {
        if (*str_it != *str_it2) {
          ++differences;
        }
        ++str_it;
      }
      //cout << differences << endl;
      if (differences == 1) {
        cout << "Found a difference of 1 in strings: " << *it << " and " << *it2 << endl;
      }
    }
  }
}