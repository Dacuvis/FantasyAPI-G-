local socket = require("socket")
local json = require("dkjson")

local server = assert(socket.bind("0.0.0.0",8080))
print("Server berjalan di http://0.0.0.0:8080")


local function read_data()
    local file, err = io.open("./data/c.json", "r")
    if not file then
        print("File gagal dibuka:", err)
        return nil
    end

    local reads = file:read("*a")
    file:close()

    local data, decode_err = json.decode(reads)
    if not data then
        print("JSON decode error:", decode_err)
        return nil
    end
    return data
end

while true do
    local client = server:accept()
    client:settimeout(1)

    local request, err = client:receive()
    if request then
        print("Request:", request)
    end

    local data = read_data()
    local body = json.encode(data, { indent = true })

    local response = table.concat({
        "HTTP/1.1 200 OK",
        "Content-Type: application/json",
        "Content-Length: " .. #body,
        "",
        body
    }, "\r\n")

    client:send(response)
    client:close()
end
