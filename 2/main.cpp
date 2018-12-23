#include <iostream>
#include <map>
#include <fstream>

using namespace std;

int main () {
  int twice = 0;
  int thrice = 0;

  ifstream input;
  input.open("input");
  string line;

  while (getline(input, line)) {
    map<char, int> freqs;

    for (string::const_iterator it = line.begin(); it != line.end(); ++it) {
      auto found = freqs.find(*it);
      if (found == freqs.end()) {
        freqs.insert(pair<char,int>(*it, 1));
      } else {
        found->second++;
      }
    }

    int twice_found = false;
    int thrice_found = false;

    for (map<char, int>::const_iterator it = freqs.begin(); it != freqs.end(); ++it) {
      if (it->second == 2) {
        twice_found = true;
      } else if (it->second == 3) {
        thrice_found = true;
      }
    }

    if (twice_found) {
      ++twice;
    }

    if (thrice_found) {
      ++thrice;
    }
  }

  cout << (twice * thrice) << endl;
}