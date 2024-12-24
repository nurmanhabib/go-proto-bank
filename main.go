package main

import (
	"fmt"
	"github.com/nurmanhabib/go-proto-bank/pb/user"
)

func main() {
	req := &user.HelloRequest{Name: "World"}
	fmt.Println(req)
}
