package main

import (
	"bitbucket.org/nurmanhabib/proto-bank/pb/user"
	"fmt"
)

func main() {
	req := &user.HelloRequest{Name: "World"}
	fmt.Println(req)
}
