# Combined-use-of-Cursor-Docker-and-Claude-code

<p align="left">
  <a href="README.md">English</a> | <b>CN 中文</b>
</p>

---

![Result image](result.png)

## Docker + Cursor + Claude Code 开发环境（开源配置指南）

### 1. 目标

本配置的目标是：

- **把 Claude Code 和 Cursor 放进 Docker 开发容器中运行**，保护本机其他文件不被误改。
- **在一个专门的工程目录中自由工作**，让 Claude Code 和 Cursor 拥有完整读写权限。
- **让整个环境易于复现与迁移**，在不同电脑上都可以快速搭建。

本仓库只开源**安装与配置的过程**。

---

### 2. 文件夹结构

推荐在 `Docker_Cursor_CC` 文件夹中保持如下结构：

- **`README.md`**：本文档（先英文、后中文）。
- **`.devcontainer/devcontainer.json`**：VS Code / Cursor 使用的 Dev Container 配置。
- **`Dockerfile`**：容器内使用的基础镜像和工具。
- **`cursor-settings-example.json`**：Cursor 的示例配置（与安全、行为相关）。
- **`.env.example`**：容器中需要的环境变量示例（只有占位符，不包含任何密钥）。

你可以将整个文件夹复制到任意工程中，根据自己的需要调整路径与名称。

---

### 3. 前置条件

- **操作系统**：Windows / macOS / Linux 均可。
- **Docker**：
  - 官方文档：`https://docs.docker.com/get-docker/`
  - 示例视频教程（B站）：`https://www.bilibili.com/video/BV1xHA3euEcn`
- **Cursor 编辑器**：
  - 官网：`https://www.cursor.com/`
  - 从官网下载安装，并完成登录。
- **Claude 官方 API Key**：
  - 在 Anthropic 官方控制台创建 API Key：`https://console.anthropic.com/`
  - **重要**：不要把真实 Key 写进任何公开文件，用环境变量管理（见 `.env.example`）。

本指南**不使用任何第三方或灰色中转服务**，请根据官方文档和你所在地区的法律法规自行操作。

---

### 4. 配置步骤

#### 4.1 拷贝或克隆本文件夹

1. 将 `Docker_Cursor_CC` 放到你的代码工作目录下（例如 `~/code`，或任意你常用的开发路径）。
2. 用 **Cursor** 打开此文件夹。

> 你应该能在工程根目录看到 `.devcontainer` 文件夹和 `Dockerfile`。

#### 4.2 配置环境变量（本地使用，不提交）

1. 将 `.env.example` 复制为 `.env`：

```bash
cp .env.example .env
```

2. 编辑 `.env`，在自己电脑上填入真实值：

- `ANTHROPIC_API_KEY`：你在 Anthropic 官方生成的 Claude API Key。

> **不要把 `.env` 提交到仓库**。这个文件只在你本地存在，用来存放私密信息。

#### 4.3 构建并启动 Dev Container

Cursor 会自动识别 `.devcontainer/devcontainer.json`。

1. 在 Cursor 里选择 **“Reopen in Container”（在容器中重新打开）** 或类似选项。
2. Cursor 会自动：
   - 使用当前目录下的 `Dockerfile` 构建镜像。
   - 启动对应容器。
   - 将当前工程目录挂载到容器内部（默认只挂载该目录，避免暴露整个个人目录）。

容器启动后，你在 Cursor 内打开的终端，都将默认运行在容器里。

#### 4.4 在容器中安装 Claude Code

在容器内部的终端中执行：

```bash
pipx install claude-code
```

或者：

```bash
pip install --user claude-code
```

Claude Code 的学习资源示例：

- B 站教程：`https://www.bilibili.com/video/BV14rzQB9EJj`
- Anthropic 官方文档：`https://docs.anthropic.com/`

> 本仓库不包含个人的 Claude Code 学习笔记，这些内容大部分可以在官方文档和公开教程中找到。

#### 4.5 调整 Cursor 与 Claude Code 的行为

1. 在 Cursor 中打开 `cursor-settings-example.json`。
2. 将需要的片段复制到你自己的 Cursor 设置中（Cursor 中：**Settings → Advanced → Open settings.json**）。
3. 根据习惯进行修改，例如：
   - 是否允许 Claude 自动应用编辑。
   - 修改文件前是否一定要先询问。
   - 是否限制工作空间范围等。

> 示例配置偏向保守：默认**修改前先询问**，更适合刚开始使用 Claude Code 的阶段。

---

### 5. 安全与风险控制建议

- **尽量只在 Dev Container 中运行 Claude Code**：
  - 在 Cursor 中打开的终端默认在容器内，可在此执行 `claude` 相关命令。
  - 尽量避免在宿主机直接运行，以减少误改系统文件的风险。
- **控制挂载范围**：
  - 示例的 `.devcontainer/devcontainer.json` 只挂载当前工程目录。
  - 不建议把整个用户目录（如 `~`）直接挂载进去，除非你非常清楚自己的操作。
- **谨慎使用“跳过确认类”参数**：
  - 例如 `claude --dangerously-skip-permissions` 会取消很多安全确认，允许更大范围的自动修改。建议只在一次性测试工程或有完善版本管理的仓库中使用。
- **密钥只放在本地环境变量**：
  - 使用 `.env` 或 Docker / Dev Container 的环境配置注入 Key。
  - 不要把真实 Key 写进任何脚本、配置文件或 README 中。

---

### 6. 官方链接汇总

- **Docker**：
  - 文档：`https://docs.docker.com/`
- **Cursor**：
  - 官网：`https://www.cursor.com/`
- **Anthropic Claude API 与 Claude Code**：
  - 控制台：`https://console.anthropic.com/`
  - 文档：`https://docs.anthropic.com/`

你可以在此基础上继续扩展，比如增加 MCP 工具、插件、更多 Dev Container 功能等，形成适合自己工作流的一整套开发环境模板。

