# DeepSeek Harness Windows Launcher

这是一个用于在 Windows 上快速安装并以桌面应用形式启动 DeepSeek Harness Web UI 的第三方开源启动器。

> [!IMPORTANT]
> 本项目不是 DeepSeek 官方项目，也不是 DeepSeek 官方 Windows 客户端。它只是由社区开发的第三方启动工具，请用户自行判断是否使用。

## 快速安装

普通用户只需按下面的顺序操作：

1. 打开本项目的 [Releases 页面](https://github.com/Zeejayhugh/DeepSeek-Harness-Windows-Launcher/releases)。
2. 下载最新版本中的 `DeepSeek-Harness-Desktop-Setup.exe`。
3. 双击下载的安装文件，按照提示完成安装。
4. 安装完成后，双击桌面上的 **DeepSeek Harness** 快捷方式即可启动。

> [!NOTE]
> 首次使用前，需要安装 **Node.js LTS**，并确保电脑能够正常连接网络。DeepSeek API Key 不包含在本项目中，需要用户自行配置。

## 使用前准备

使用本启动器需要满足以下条件：

- Windows 10 或 Windows 11
- 当前版本的 [Node.js LTS](https://nodejs.org/)，其中包含 npm 和 npx
- Google Chrome 或 Microsoft Edge
- 首次启动时能够正常连接网络，以便 npx 获取官方的 `@deepseek-ai/dsh` 软件包

本启动器不会自动安装 Node.js、Chrome 或 Edge。如果电脑中没有找到 Node.js/npm，启动器会显示清晰的安装提示，不会直接无提示地退出。

## 安装和启动

1. 从 [Releases 页面](https://github.com/Zeejayhugh/DeepSeek-Harness-Windows-Launcher/releases) 下载 `DeepSeek-Harness-Desktop-Setup.exe`。
2. 双击安装文件并按照界面提示操作。程序仅安装到当前 Windows 用户的目录，不需要管理员权限。
3. 安装结束后，可以选择立即启动 DeepSeek Harness。
4. 以后可以通过桌面快捷方式或开始菜单中的 **DeepSeek Harness** 启动。

## 启动时会发生什么

双击快捷方式后，启动器会自动完成以下操作：

1. 在后台运行 `npx --yes @deepseek-ai/dsh web`，不会弹出黑色命令窗口。
2. 等待 DeepSeek Harness 在 `http://127.0.0.1:3080` 准备完成，最长等待 45 秒。
3. 优先使用 Chrome 以独立应用窗口打开页面；如果没有找到 Chrome，则使用 Edge。

如果启动失败，程序会显示错误提示。诊断日志保存在：

```text
%LOCALAPPDATA%\DeepSeekHarness\Logs
```

## DeepSeek API Key 与隐私说明

本仓库和安装程序不包含任何 DeepSeek API Key。每位用户都需要在 DeepSeek Harness 中自行配置自己的 DeepSeek API Key。

启动器不会写死任何用户的个人文件路径。安装位置和日志位置均使用 Windows 为当前用户提供的标准目录。

## 卸载方法

安装程序包含完整的卸载功能：

1. 打开 Windows **设置**。
2. 进入 **应用** → **已安装的应用**。
3. 找到 **DeepSeek Harness**，选择 **卸载**。

## 注意事项

- 首次启动时，npx 可能需要从网络获取官方的 `@deepseek-ai/dsh` 软件包，因此所需时间取决于网络速度。
- 如果 DeepSeek Harness 在 45 秒内没有启动成功，启动器会显示错误提示。可以根据上面的日志位置查看诊断信息。
- 本项目不会替用户安装来源不明的软件，也不会保存或提供任何 DeepSeek API Key。
- 本项目是第三方开源启动器，不代表 DeepSeek 官方立场，也不应被视为官方 Windows 客户端。

## 本地构建（面向开发者）

安装 [Inno Setup 6](https://jrsoftware.org/isinfo.php)，然后编译 `installer\DeepSeekHarness.iss`。

生成的安装程序位于：

```text
dist\DeepSeek-Harness-Desktop-Setup.exe
```

## 开源许可

MIT
