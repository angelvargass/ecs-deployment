# Stage 1: Build
FROM golang:1.21 AS builder

# Set the Current Working Directory
WORKDIR /app

# Copy go.mod and go.sum to the workspace
COPY go.mod ./

# Download dependencies
RUN go mod download

# Copy the rest of the application code
COPY . .

# Build the Go app
RUN go build -o ecs .

# Stage 2: Run
FROM alpine:latest

# Set the Current Working Directory
WORKDIR /root/

# Copy the built application from the builder stage
COPY --from=builder /app/ecs .

# Expose port 8080 for the application (adjust as needed)
EXPOSE 8080

# Command to run the executable
CMD ["./ecs"]
