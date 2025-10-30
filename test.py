with open("disposable_email_blocklist.conf") as blocklist:
    blocklist_content = {line.rstrip() for line in blocklist.readlines()}


def is_permanent_email(email):
    domain_parts = email.partition("@")[2].split(".")
    for i in range(len(domain_parts) - 1):
        if ".".join(domain_parts[i:]) in blocklist_content:
            message = "Please enter your permanent email address."
            print("Not permanent")
            return (False, message)
    print("Permanent")
    return True


is_permanent_email("test@test.omega.alpha.10dk.email")
