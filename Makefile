VENDOR       = vendor
BINDATA      = sqlfiles.go
SRCS         = *.go
TARGET       = migr
SQL          = migrations/*.sql
BINDATAFLAGS = -pkg main -o $(BINDATA)

default: build

run: TARGET = migr-debug
run: debug
	./$(TARGET)

debug: BINDATAFLAGS += -debug
debug: TARGET = migr-debug
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
