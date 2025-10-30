package main

import ("log"; "bufio"; "os"; "strings";)
var disposableList = make(map[string]struct{}, 3500)
func init() {
	f, _ := os.Open("disposable_email_blocklist.conf")
	for scanner := bufio.NewScanner(f); scanner.Scan(); {
		disposableList[scanner.Text()] = struct{}{}
	}
	f.Close()
}

func isDisposableEmail(email string) (disposable bool) {
	domain_parts := strings.Split(strings.Split(email, "@")[1], ".")
	for i := 0; i < len(domain_parts)-1; i++ {
		if _, ok := disposableList[strings.Join(domain_parts[i:], ".")]; ok {
			return true
		}
	}
	return false
}

func main() {
	ok := isDisposableEmail("test@one.two.three.1000rebates.stream")
	log.Println(ok)
}
