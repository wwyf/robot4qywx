# A robot for groups in WeCom

Send message and files to WeCom easily!

## Dependency

You should install `jq` firstly.

In CentOS, you can install `jq` with this command.

```
sudo yun install jq
```

## Usage

You need to fill `robot_key` in script firstly.

1. You can just send a message.

```
./send_qywx.sh "something you want to send"
```

2. You can send a message with a file.

```
./send_qywx.sh "some message" ./path/to/your/file
```