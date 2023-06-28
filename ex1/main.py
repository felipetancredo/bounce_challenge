import requests
import pandas as pd
import getopt
import sys


def extract_repos(user: str, records_per_page: int = 50) -> list:
    """
    Loop through all pages to obtain all the repos' information
    :param user: Github user
    :param records_per_page: Number of records per page
    :return: list of repos for this specific user
    """
    # access_token='access token for private repos, if needed'
    # headers = {'Authorization':"Token "+ access_token}
    repos = []
    page_num = 1
    while True:  # to find all the repos' names from each page, until it finishes
        url = f"https://api.github.com/users/{user}/repos?page={page_num}&per_page={records_per_page}"
        repo = requests.get(url).json() # without any auth/header because it's not needed in this case (public api)
        if repo:
            repos.extend(repo)
        else:
            break
        page_num += 1
    return repos


def save_to_csv(repos: list, filepath: str, separator: str = ';', index: bool = False, encoding: str = 'utf-8') -> None:
    """
    Save a repository list into a CSV file
    :param repos: Repository List
    :param filepath: CSV FilePath to save the contents of the repos list
    :param separator: CSV Separator. Default = ;
    :param index: including index. Default = False
    :param encoding: encoding. Default: utf-8
    :return: None
    """
    # using json_normalize just because we are gonna export to CSV, however, in a real world,
    # we usually prefer to keep it in JSON files to upload to our datalike (S3, GCS, Azure BlobStorage, etc),
    # and using any other engine to analyze the results (like Google BigQuery, Amazon Redshift, Azure Databricks, etc)
    pd.json_normalize(repos).to_csv(filepath, index=index, encoding=encoding, sep=separator)


if __name__ == "__main__":
    args_list = sys.argv[1:]
    options = "u:r:f:s:"
    long_options = ["user", "records_per_page", "file"]

    # setting the default values
    user = 'bounceapp'
    records_per_page = 10  # 10 items only to force paging, not needed for few records...
    filepath = 'output.csv'
    separator = ';'
    try:
        arguments, values = getopt.getopt(args_list, options, long_options)
        for curr_arg, curr_value in arguments:
            if curr_arg in ("-u", "--user"):
                user = curr_value
            elif curr_arg in ("-r", "--records_per_page"):
                records_per_page = curr_value
            elif curr_arg in ("-f", "--file"):
                filepath = curr_value
            elif curr_arg in ("-s", "--separator"):
                separator = curr_value

        repos = extract_repos(user=user, records_per_page=records_per_page)
        save_to_csv(repos=repos, filepath=filepath, separator=separator)  # leaving the other params as default
        print('File successfully saved')
    except getopt.error as err:
        print(str(err))
    except Exception as e:
        print('Unexpected Error: {}'.format(e))


# considerations:
# 1. not using any authentication in Github api, because it's not needed in this case. Eventually we could add headers in this request
# 2. to run in a production environment, I would split this code in 2:
#    one for extract the date (in a docker container or in a simple cloud function), and another one only for loading (if needed),
#    isolating the extraction to the load services
#   examples:
#   a) creating an Airbyte connector for only extract Repos dat from Github API. We don't need to develop the Load piece, because it already exists in Airbyte.
#   b) or creating a GitHub hook + GithubToGCSOperator in Airflow (which could contain the logic to connect to Github, extract the data and upload the JSONs to GCS).