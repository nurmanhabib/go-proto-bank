# Proto-Bank

Proto-Bank is a simple project to manage and generate Protocol Buffers (`.proto`) files for a banking-related application. This repository provides a `Makefile` to simplify the generation of Go code from Protocol Buffers using `protoc` and the necessary plugins.

## Features

- Easily generate Go code for Protocol Buffers (`pb.go`).
- Supports gRPC and standard Protocol Buffers.
- Includes a clean command to remove generated files while keeping necessary files intact.

## Requirements

Before running the commands, make sure the following tools are installed on your system:

1. [Golang](https://golang.org/) (at least version 1.16)
2. [Protocol Buffers Compiler (`protoc`)](https://grpc.io/docs/protoc-installation/)
3. `protoc-gen-go` and `protoc-gen-go-grpc` plugins for Go:
   ```bash
   go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
   ```
   ```bash
   go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
   ```
   

Make sure the installed binaries (protoc-gen-go and protoc-gen-go-grpc) are in your $PATH.

## Setup

Clone the repository and navigate to its directory:

```
git clone https://github.com/your-username/proto-bank.git
```
```
cd proto-bank
```

## Makefile Commands

The following Makefile commands are available to simplify your workflow:

### 1. Generate Protobuf Files
   Run the following command to generate Go code from your .proto files:

```bash
make all
```

This will:

- Compile all .proto files located in the proto/ directory.
- Output the generated Go files to the pb/ directory.

### 2. Clean Generated Files
   To remove all generated files while keeping the .gitkeep file intact, run:

```bash
make clean
```

This will:

Remove all files and directories inside `pb/`, except for `.gitkeep`.

### 3. Regenerate Changed .proto Files Only
   If you want to regenerate only the .proto files that have been modified (or staged in Git), run:

```bash
make update
```

This will:

- Identify .proto files that have been changed or staged for commit.
- Regenerate Go files for only those files.

## Repository Structure

The repository structure is as follows:

```
proto-bank/
├── Makefile        # Automates protobuf generation and cleaning
├── proto/          # Contains all .proto files
│   ├── account.proto
│   ├── transaction.proto
│   └── ...
├── pb/             # Output directory for generated Go files
│   └── .gitkeep    # Ensures pb/ is tracked even if empty
└── README.md       # Documentation for the project
```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any changes or improvements.
