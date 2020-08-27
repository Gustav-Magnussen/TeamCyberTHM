import base64

infile = open("[path/to/file]", 'r')
outfile = open("decodedflag.txt", 'w')

flag = infile.read()
res = ''

for i in range(0,50):
    re = base64.b64decode(flag)
    flag = res

test = flag

print(res)

infile.close()
outfile.close()
