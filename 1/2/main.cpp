#include <map>
#include <iostream>
#include <fstream>
#include <string>

using namespace std;

int main() {
  map<int, bool> freqs;

  ifstream input;
  input.open("input");
  string line;

  int total = 0;
  int number;

  if (input.is_open()) {
    while (true) {
      input.clear();
      input.seekg(0, ios::beg);

      while (getline(input, line)) {
        auto found = freqs.find(total);
        if (found == freqs.end()) {
          // Insert new value
          freqs.insert(pair<int,bool>(total, true));
        } else {
          // Value was found. Exit.
          cout << found->first << endl;
          input.close();
          return 0;
        }

        number = stoi(line);
        total += number;
      }
    }
  } else {
    cout << "Could not open file." << endl;
  }

  return 1;
}