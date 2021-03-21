def sort_commits(commits, reverse=False):
        return sorted(commits, key=lambda c: c["date"], reverse=reverse)

def commits_parse(rect):
    return [{"commits": r.get("data-count"), "date": r.get("data-date")} for r in rect.find_all("rect")]
