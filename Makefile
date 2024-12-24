# Paths
PROTO_DIR = ./proto         # Directory containing .proto files
OUT_DIR = ./pb              # Directory to output generated code

# Plugins
PROTOC_GEN_GO = protoc-gen-go
PROTOC_GEN_GO_GRPC = protoc-gen-go-grpc

# Commands
PROTOC = protoc

# Files
PROTO_FILES := $(shell find $(PROTO_DIR) -name '*.proto')

# Rules
.PHONY: all clean

all: generate

generate:
	$(PROTOC) \
		--proto_path=$(PROTO_DIR) \
		--go_out=$(OUT_DIR) \
		--go-grpc_out=$(OUT_DIR) \
		--go_opt=paths=source_relative \
		--go-grpc_opt=paths=source_relative \
		$(PROTO_FILES)

clean:
	rm -rf $(OUT_DIR)
