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

# Get changed .proto files from Git (both staged and unstaged)
CHANGED_PROTO_FILES = $(shell git diff --name-only --diff-filter=ACM HEAD | grep '\.proto$$')
STAGED_PROTO_FILES = $(shell git diff --cached --name-only --diff-filter=ACM | grep '\.proto$$')

# Combine both changed and staged files, and ensure uniqueness
ALL_CHANGED_PROTO_FILES = $(shell echo "$(CHANGED_PROTO_FILES) $(STAGED_PROTO_FILES)" | tr ' ' '\n' | sort -u | tr '\n' ' ')

# Rules
.PHONY: all clean

all:
	@echo "Generating Go code from .proto files..."
	@protoc \
		--proto_path=$(PROTO_DIR) \
		--go_out=$(OUT_DIR) \
		--go-grpc_out=$(OUT_DIR) \
		--go_opt=paths=source_relative \
		--go-grpc_opt=paths=source_relative \
		$(PROTO_FILES)

update:
	@echo "Regenerating changed or staged .proto files..."
	@if [ -n "$(ALL_CHANGED_PROTO_FILES)" ]; then \
		for file in $(ALL_CHANGED_PROTO_FILES); do \
			echo "Processing $$file..."; \
			$(PROTOC) \
				--proto_path=$(PROTO_DIR) \
				--go_out=$(OUT_DIR) \
				--go-grpc_out=$(OUT_DIR) \
				--go_opt=paths=source_relative \
				--go-grpc_opt=paths=source_relative \
				$$file; \
		done \
	else \
		echo "No .proto changes detected."; \
	fi

debug:
	@echo "Changed or staged .proto files:"
	@echo $(ALL_CHANGED_PROTO_FILES)

clean:
	@echo "Cleaning up all files and directories in $(OUT_DIR), except .gitkeep..."
	@echo "Files to delete:"
	@find $(OUT_DIR) -mindepth 1 -type f ! -name '.gitkeep' 2>/dev/null
	@echo "Directories to delete:"
	@find $(OUT_DIR) -mindepth 1 -type d 2>/dev/null
	@find $(OUT_DIR) -mindepth 1 -type f ! -name '.gitkeep' -exec rm -f {} \; 2>/dev/null
	@find $(OUT_DIR) -mindepth 1 -type d -exec rm -rf {} \; 2>/dev/null
