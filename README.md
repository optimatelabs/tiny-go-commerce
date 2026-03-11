# Tiny Go Commerce 🛒

A foundational, strictly-typed schema library for building bespoke e-commerce microservices in Go.

## 📖 Motivation

**This is not a fully-fledged e-commerce platform.** 

`tiny-go-commerce` is designed to be a collection of fundamental, plug-and-play architectural building blocks. Modern e-commerce is highly subjective, every business has unique requirements for fulfillment logic, payment providers, and inventory management. 

Instead of forcing you into a rigid monolith, this project provides a set of highly optimized, database-friendly gRPC contracts (`.proto`) and their corresponding Go bindings. It empowers you to build your own distinct microservices faster by importing pre-validated, standardized e-commerce entities.

The philosophy is simple: **We define the contracts, you build the logic.**

## ✨ Features

- **7 Core Microservice Schemas**: Definitions for `product`, `user`, `cart`, `order`, `payment`, `fulfillment` (shipping & local pickup), and `notification` (email/SMS/push).
- **Strong Payload Validation**: Integrated natively with Envoy's `protoc-gen-validate` to enforce UUID checks, numeric thresholds (e.g., `amount > 0`), and string lengths at the schema level before your Go code even executes!
- **Common Utility Library**: A shared `common.v1` package standardizing `ErrorResponse` and `Pagination` logic across all domains.

## 🚀 Getting Started

If you are building a Go application and want to leverage these e-commerce data structures, simply import them:

1. Add the module to your project:
   ```bash
   go get github.com/optimatelabs/tiny-go-commerce
   ```

2. Import the desired packages and bindings in your Go code to utilize the pre-generated structs and validation methods:
   ```go
   import (
       "fmt"
       cart "github.com/optimatelabs/tiny-go-commerce/pkg/cart/v1"
   )

   func AddItemToCart(req *cart.AddItemRequest) error {
       // Incoming payloads can be validated instantly!
       if err := req.Validate(); err != nil {
           return fmt.Errorf("invalid request: %w", err)
       }

       // ... your custom business logic ...
       return nil
   }
   ```

## 🛠️ Modifying the Schemas

If you intend to modify the protobuf definitions locally (e.g., as a contributor or iterating on a fork):

1. **Install Prerequisites**: You need `protoc` and the Go gRPC compiler plugins installed on your machine.
2. **Download Dependencies**: Run the initialization script to fetch the Envoy validation plugins:
   ```bash
   make init
   ```
3. **Compile**: After editing any `.proto` file in the `api/` directory, regenerate the Go bindings:
   ```bash
   make proto
   ```

## 🤝 Contributing

We welcome community contributions, but please keep the core motivation in mind: **we want to govern what features are implemented** to maintain the "tiny" and "generic" philosophy of this repository.

### Contribution Guidelines

- **Open an Issue First**: Before submitting a Pull Request for a new feature or schema change, please open an Issue discussing the proposed modification. This allows the maintainers to approve the architectural direction before you spend time writing code.
- **Keep it Generic**: Proposed additions must be globally applicable to standard e-commerce implementations. Highly bespoke or niche integrations belong in your proprietary consuming services, not here.
- **Maintain Validations**: Any new fields must include appropriate `protovalidate` rules to protect data integrity.

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
