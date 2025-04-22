import socket

s = socket.socket()
s.bind(('127.0.0.1', 12345))
s.listen()
conn, _ = s.accept()
data = conn.recv(1024)
conn.sendall(data)
conn.close()
