package main

import (
	"fmt"
	"github.com/nurmanhabib/proto-bank/pb/user"
)

func main() {
	req := &user.SaveUserRequest{Name: "World"}
	fmt.Println(req)
}
