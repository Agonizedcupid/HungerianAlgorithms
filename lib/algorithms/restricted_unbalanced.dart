class RestrictedUnbalanced {
  String getDoneJobs(List<List<int>> costMatrix) {
    int numWorkers = costMatrix.length;
    int numJobs = costMatrix[0].length;
    List<int> allocatedJobs = List.filled(numWorkers, 0);
    List<bool> markedWorkers = List.filled(numWorkers, false);
    List<bool> markedJobs = List.filled(numJobs, false);

// Iteration 1: mark the rows having exactly one unmarked zero
    for (int i = 0; i < numWorkers; i++) {
      int countUnmarkedZeros = 0;
      int unmarkedZeroIndex = -1;
      for (int j = 0; j < numJobs; j++) {
        if (costMatrix[i][j] == 0 && !markedJobs[j]) {
          countUnmarkedZeros++;
          unmarkedZeroIndex = j;
        }
      }
      if (countUnmarkedZeros == 1) {
        allocatedJobs[i] = unmarkedZeroIndex;
        markedWorkers[i] = true;
        markedJobs[unmarkedZeroIndex] = true;
      }
    }

// Iteration 2: mark the rows having minimum unmarked value
    for (int i = 0; i < numWorkers; i++) {
      if (!markedWorkers[i]) {
        int minUnmarkedValue = 2147483647;
        for (int j = 0; j < numJobs; j++) {
          if (costMatrix[i][j] < minUnmarkedValue && !markedJobs[j]) {
            minUnmarkedValue = costMatrix[i][j];
          }
        }
        for (int j = 0; j < numJobs; j++) {
          if (costMatrix[i][j] == minUnmarkedValue) {
            allocatedJobs[i] = j;
            markedJobs[j] = true;
            break;
          }
        }
      }
    }

// Iteration 3: if necessary, mark the columns having exactly one marked zero
    for (int j = 0; j < numJobs; j++) {
      int countMarkedZeros = 0;
      int markedZeroIndex = -1;
      for (int i = 0; i < numWorkers; i++) {
        if (costMatrix[i][j] == 0 && markedWorkers[i]) {
          countMarkedZeros++;
          markedZeroIndex = i;
        }
      }
      if (countMarkedZeros == 1) {
        allocatedJobs[markedZeroIndex] = j;
        markedJobs[j] = true;
      }
    }

// print the allocated jobs and minimum cost
    int minCost = 0;
    String jobDone = "";
    for (int i = 0; i < numWorkers; i++) {
      int jobIndex = allocatedJobs[i];
      minCost += costMatrix[i][jobIndex];
      //print("Worker ${i + 1} is allocated to job ${costMatrix[i][jobIndex]}");
      jobDone += "Worker ${i + 1} is allocated to job ${costMatrix[i][jobIndex]}";
    }
    jobDone += "\n\nMinimum cost = $minCost";
    return jobDone;
  }
}