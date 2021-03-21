import json

from bs4 import BeautifulSoup
import requests
import boto3

from helpers import commits_parse, sort_commits

def get_commits(event, context):
    response = requests.get("https://www.github.com/SoftwrDev")
    soup = BeautifulSoup(response.text, "html.parser")
    g = soup.find_all("g")

    commits = commits_parse(g[52])
    commits = [*commits, *commits_parse(g[53])]

    commits_desc = sort_commits(commits, reverse=True)
    commits = sort_commits(commits_desc[0:7])

    s3 = boto3.resource("s3")
    bucket = s3.Bucket("www.softwrdev.com") 
    bucket.put_object(Body=str.encode(json.dumps(commits)), ContentType="application/json",  Key="js/commits.json", ACL="public-read")
