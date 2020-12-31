#include <stdlib.h>
#include <iostream>
#include <thread>
#include <ctime>
#include <chrono>
#include <string>
#include <vector>

void simple_progress(float progress){
    std::cout << int(progress * 100.0) << " %\r";
    std::cout.flush();
}

void stressCore(){
    long long s = 9150000000;
    long long silnia = 1;
    double temp;
    for (long long r = 1; r <= s; r++) {
        silnia *= r;
        if(r%35000000 == 0){
            temp = (double)r / (double)s;
            //std::cout << r << std::endl;
            simple_progress(temp);
        }
    }
    std::cout << "Thread nr. " << std::this_thread::get_id() << " has finished working." << std::endl;
}

int main(){

    int thread_count = std::thread::hardware_concurrency();
    std::vector<std::thread> readerThreads;

    thread_count -= 0;

    std::chrono::steady_clock::time_point begin = std::chrono::steady_clock::now();
    std::cout << "Starting..." << std::endl;

    for (int i=0; i < thread_count; i++){
        std::thread th(stressCore);
        readerThreads.push_back(move(th));
    }

    std::cout << "Waiting for threads to finish..." << std::endl;
    //std::cin.get();

    for(long unsigned int i = 0; i < readerThreads.size(); i++){
        readerThreads[i].join();
    }

    std::cout << "Done!" << std::endl;

    std::chrono::steady_clock::time_point end = std::chrono::steady_clock::now();

    std::cout << "Time difference = " << std::chrono::duration_cast<std::chrono::seconds>(end - begin).count() << "[s]" << std::endl;


    return 0;
}


