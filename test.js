const { readFileSync } = require("fs");

const blocklistContent = new Set(
  readFileSync("disposable_email_blocklist.conf", "utf-8")
    .split("\n")
    .map((line) => line.trim())
    .slice(0, -1)
);

function isPermanentEmail(email) {
  const domainParts = email.split("@")[1].split(".");
  for (let i = 0; i < domainParts.length - 1; i++) {
    if (blocklistContent.has(domainParts.slice(i).join("."))) {
      const message = "Please enter your permanent email address.";
      console.log("Not permanent");
      return [false, message];
    }
  }

  console.log("Permanent");

  return [true];
}

isPermanentEmail("test@test.100likers.com");
