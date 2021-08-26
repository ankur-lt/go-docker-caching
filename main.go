package main

import (
	"fmt"
	"github.com/google/uuid"
)

func main() {
	fmt.Printf("UUID:: %s", uuid.New().String())
}
