VENDOR       = vendor
BINDATA      = sqlfiles.go
SRCS         = *.go
TARGET       = migr
SQL          = migrations/*.sql
BINDATAFLAGS = -pkg main -o $(BINDATA)

default: build

run: debug
	./$(TARGET)

debug: BINDATAFLAGS += -debug
debug: build

build: $(TARGET)

clean:
	rm -f $(BINDATA) $(TARGET)

.PHONY: build clean debug run

$(BINDATA): $(SQL)
	go-bindata $(BINDATAFLAGS) migrations

$(TARGET): $(VENDOR) $(SRCS) $(BINDATA)
	go build -o $(TARGET) $(SRCS) 

$(VENDOR):
	glide up
