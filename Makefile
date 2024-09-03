PROTOC_GEN_GO := $(shell which protoc-gen-go)
PROTOC_GEN_GO_GRPC := $(shell which protoc-gen-go-grpc)
PROTO_SRC := proto
GO_OUT := gen/go

all: check-tools clean generate

check-tools:
ifndef PROTOC_GEN_GO
	$(error "protoc-gen-go is not installed. Run 'go install google.golang.org/protobuf/cmd/protoc-gen-go@latest'")
endif
ifndef PROTOC_GEN_GO_GRPC
	$(error "protoc-gen-go-grpc is not installed. Run 'go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest'")
endif

generate:
	@echo "Generating Go code..."
	@mkdir -p $(GO_OUT)
	@find $(PROTO_SRC) -name '*.proto' -exec protoc \
		--proto_path=$(PROTO_SRC) \
		--go_out=$(GO_OUT) \
		--go-grpc_out=$(GO_OUT) \
		--go_opt=paths=source_relative \
		{} +

clean:
	@echo "Cleaning generated files..."
	@rm -rf $(GO_OUT)

.PHONY: all check-tools generate clean