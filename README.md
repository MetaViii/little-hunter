# Little Hunter

> 一款基于 Godot 的 2D 横版闯关小游戏。  
> 制作简单、体量不大，难度略高，是一次偏实验性质的尝试之作。

## 🧩 项目背景

这个项目最初是为了给一次 CTF 比赛（?CTF）设计一题 **Misc Week3 的小游戏题目**，当时的题面名为：

> **《关于我穿越到CTF的异世界这档事：Q》**

整体完成度不算高，更多是一次练手和尝试，希望在 CTF 里加一点轻松的游戏元素。

实现上参考了 B 站的 Godot 教程：

- 参考教程：[Godot 游戏开发教程（BV1fs421N7TD）](https://www.bilibili.com/video/BV1fs421N7TD/?spm_id_from=333.1391.0.0&p=15&vd_source=f1ce65e9f58a85a4dfa42a501ebb9196)

## 👥 协作与致谢

本项目是我和室友一起完成的小练习：

- 仓库所有者 / 主要维护：[@MetaViii](https://github.com/MetaViii)
- 协力者（室友）：[@zx1360](https://github.com/zx1360)

**其实一开始没有冲刺和存档，是在室友的帮助下加上的，也顺便把难度降了一点。**  
整体依然比较粗糙，如果你有建议或发现问题，非常欢迎提 Issue 或 PR。

## 🎮 游戏简介

**Little Hunter**（原题名《关于我穿越到CTF的异世界这档事：Q》）是一个简单的 2D 横版闯关游戏，特点大致是：

- **平台跳跃为主**：基础移动与跳跃，节奏偏紧凑  
- **操作难度略高**：容错率不算高，更适合愿意多尝试几次的玩家  
- **CTF 关联**：作为 CTF 题目时，会在“有 flag 版”中加入与解题相关的内容

适合用来：

- 作为 Godot 初学者的一个小工程参考
- 作为 CTF 出题人尝试“游戏化题目”的简单样例

## 📂 仓库结构

```text
.
├── assets/                        # 游戏资源
├── scenes/                        # 场景文件
├── scripts/                       # GDScript 脚本
├── project.godot                  # Godot 项目配置
├── default_bus_layout.tres
├── export_presets.cfg
├── icon.svg
├── icon.svg.import
├── little hunter(无flag版).zip    # 无嵌入 flag 的版本
└── little hunter(有flag版).zip    # 带 CTF flag 的版本
```

> **有 flag 版** 与 **无 flag 版** 的玩法基本一样，只是是否包含与 CTF 相关的 flag / 线索不同。

## 🕹️ 运行方式

### 直接运行打包版本

1. 前往仓库主页下载：
   - `little hunter(无flag版).zip`
   - `little hunter(有flag版).zip`
2. 解压到任意目录  
3. 运行解压后的可执行文件（如 Windows 下的 `.exe`）

如果只是想体验游戏，这种方式最省事。

### 使用 Godot 打开工程

1. 克隆仓库：

   ```bash
   git clone https://github.com/MetaViii/little-hunter.git
   cd little-hunter
   ```

2. 打开 Godot → **Import / 导入** → 选择 `project.godot`  
3. 导入后点击「▶」运行（或 `F5`）

## 🎯 操作说明（示例）

实际按键请以游戏内为准，如有出入欢迎提醒我更新：

- **方向键 / A、D**：移动  
- **W / 空格**：跳跃  
- **SHIFT**：冲刺

## 📜 简要说明

- 这是一个以学习、实验为主的小项目，很多地方还比较粗糙。  
- 如果你想在此基础上继续扩展、重构或用于出题，欢迎直接 Fork，也非常欢迎在说明中顺手标注一下来源。  
- 如在运行或导出时遇到问题，可以开一个简单的 Issue，我会在能力范围内尽量回复。
