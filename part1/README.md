# Bounce - Data Engineer Challenge

## Part 1: Python Script for Data Extraction from REST API
Your first task is to write a Python script to extract data from the GitHub API. The API returns paginated responses for repository data. Your script should be able to handle paging, cursors, and authentication and should store the extracted data in a suitable format for further analysis.
Here's the API endpoint you need to extract data from: `https://api.github.com/users/bounceapp/repos`
____

To run this part of the challenge you need to execute the following steps:

1) Make sure that you have installed a Python 3 version on your computer. If not, you can easily install it following the instructions using this [link](https://realpython.com/installing-python/).
2) Create a virtual environment. If you don't know how to create a virtual environment, find the instructions in this [link](https://docs.python.org/3/library/venv.html).
3) Clone this repo into your machine. (`git clone https://github.com/felipetancredo/bounce_challenge.git`)
4) Assuming that you are in the root folder of this cloned repo, execute a `pip install -r ./part1/requirements.txt` in order to install all the requirements needed for this project.
5) After that, you can run the `main.py` file using `python3` with the following parameters:

   -u or --user: Set the GitHub repos user. Default value = bounceapp.

   -r or --records_per_page: Set the number of records per page. Default value = 20.

   -f or --file = Filepath to save the results. Default value = output.csv.

   -s or --separator: Defines the separator used to split the columns in the file. Default value = ;

   Example: `python3 main.py -u bounceapp -r 10 -f /usr/bounce_challenge/output.csv -s |`

DONE. You should be able to collect a CSV file with the repos for a specific user.
