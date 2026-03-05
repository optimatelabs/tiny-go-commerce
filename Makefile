.PHONY: init proto

export PATH := $(shell go env GOPATH)/bin:$(PATH)

init:
	mkdir -p vendor.protogen/validate vendor.protogen/google/api vendor.protogen/protoc-gen-openapiv2/options
	curl -sLo vendor.protogen/validate/validate.proto https://raw.githubusercontent.com/envoyproxy/protoc-gen-validate/main/validate/validate.proto
	curl -sLo vendor.protogen/google/api/annotations.proto https://raw.githubusercontent.com/googleapis/googleapis/master/google/api/annotations.proto
	curl -sLo vendor.protogen/google/api/http.proto https://raw.githubusercontent.com/googleapis/googleapis/master/google/api/http.proto
	curl -sLo vendor.protogen/google/api/field_behavior.proto https://raw.githubusercontent.com/googleapis/googleapis/master/google/api/field_behavior.proto
	curl -sLo vendor.protogen/protoc-gen-openapiv2/options/annotations.proto https://raw.githubusercontent.com/grpc-ecosystem/grpc-gateway/main/protoc-gen-openapiv2/options/annotations.proto
	curl -sLo vendor.protogen/protoc-gen-openapiv2/options/openapiv2.proto https://raw.githubusercontent.com/grpc-ecosystem/grpc-gateway/main/protoc-gen-openapiv2/options/openapiv2.proto

proto:
	mkdir -p pkg/product/v1 pkg/user/v1 pkg/cart/v1 pkg/order/v1 pkg/common/v1 pkg/payment/v1 pkg/fulfillment/v1 pkg/notification/v1 swagger
	protoc -I api -I vendor.protogen \
	    --go_out=./pkg --go_opt=paths=source_relative \
	    --go-grpc_out=./pkg --go-grpc_opt=paths=source_relative \
	    --grpc-gateway_out=./pkg --grpc-gateway_opt=paths=source_relative \
	    --openapiv2_out=./swagger --openapiv2_opt=allow_merge=true,merge_file_name=product \
	    --validate_out="lang=go,paths=source_relative:./pkg" \
	    api/product/v1/product.proto
	protoc -I api -I vendor.protogen \
	    --go_out=./pkg --go_opt=paths=source_relative \
	    --go-grpc_out=./pkg --go-grpc_opt=paths=source_relative \
	    --grpc-gateway_out=./pkg --grpc-gateway_opt=paths=source_relative \
	    --openapiv2_out=./swagger --openapiv2_opt=allow_merge=true,merge_file_name=user \
	    --validate_out="lang=go,paths=source_relative:./pkg" \
	    api/user/v1/user.proto
	protoc -I api -I vendor.protogen \
	    --go_out=./pkg --go_opt=paths=source_relative \
	    --go-grpc_out=./pkg --go-grpc_opt=paths=source_relative \
	    --grpc-gateway_out=./pkg --grpc-gateway_opt=paths=source_relative \
	    --openapiv2_out=./swagger --openapiv2_opt=allow_merge=true,merge_file_name=cart \
	    --validate_out="lang=go,paths=source_relative:./pkg" \
	    api/cart/v1/cart.proto
	protoc -I api -I vendor.protogen \
	    --go_out=./pkg --go_opt=paths=source_relative \
	    --go-grpc_out=./pkg --go-grpc_opt=paths=source_relative \
	    --grpc-gateway_out=./pkg --grpc-gateway_opt=paths=source_relative \
	    --openapiv2_out=./swagger --openapiv2_opt=allow_merge=true,merge_file_name=order \
	    --validate_out="lang=go,paths=source_relative:./pkg" \
	    api/order/v1/order.proto
	protoc -I api -I vendor.protogen \
	    --go_out=./pkg --go_opt=paths=source_relative \
	    --go-grpc_out=./pkg --go-grpc_opt=paths=source_relative \
	    --grpc-gateway_out=./pkg --grpc-gateway_opt=paths=source_relative \
	    --openapiv2_out=./swagger --openapiv2_opt=allow_merge=true,merge_file_name=payment \
	    --validate_out="lang=go,paths=source_relative:./pkg" \
	    api/payment/v1/payment.proto
	protoc -I api -I vendor.protogen \
	    --go_out=./pkg --go_opt=paths=source_relative \
	    --go-grpc_out=./pkg --go-grpc_opt=paths=source_relative \
	    --grpc-gateway_out=./pkg --grpc-gateway_opt=paths=source_relative \
	    --openapiv2_out=./swagger --openapiv2_opt=allow_merge=true,merge_file_name=fulfillment \
	    --validate_out="lang=go,paths=source_relative:./pkg" \
	    api/fulfillment/v1/fulfillment.proto
	protoc -I api -I vendor.protogen \
	    --go_out=./pkg --go_opt=paths=source_relative \
	    --go-grpc_out=./pkg --go-grpc_opt=paths=source_relative \
	    --grpc-gateway_out=./pkg --grpc-gateway_opt=paths=source_relative \
	    --openapiv2_out=./swagger --openapiv2_opt=allow_merge=true,merge_file_name=notification \
	    --validate_out="lang=go,paths=source_relative:./pkg" \
	    api/notification/v1/notification.proto
	protoc -I api -I vendor.protogen \
	    --go_out=./pkg --go_opt=paths=source_relative \
	    --validate_out="lang=go,paths=source_relative:./pkg" \
	    api/common/v1/error.proto api/common/v1/pagination.proto
