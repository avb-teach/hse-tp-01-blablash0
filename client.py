import socket

s = socket.socket()
s.connect(('127.0.0.1', 12345))
s.sendall(b'Hello!')
print(s.recv(1024).decode())
s.close()
