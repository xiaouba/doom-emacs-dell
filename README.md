# Doom Emacs 配置说明

## 📁 配置文件结构

```
.doom.d/
├── config.el          # 主配置文件
├── init.el           # Doom 模块初始化
├── packages.el       # 额外包定义
├── config.el.backup  # 配置备份（自动生成）
└── README.md         # 本文档
```

## 🎯 快捷键速查

### Org-Agenda 视图
| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `C-c a x` | 10日视图 | 未来10天日程，不含习惯 |
| `C-c a d` | 每日回顾 | 今日任务+习惯追踪+完成情况 |
| `C-c a w` | 每周回顾 | 本周总结，不含习惯 |
| `C-c a m` | 月度回顾 | 月度目标和成就 |

### Org-Capture 快速记录
| 快捷键 | 功能 |
|--------|------|
| `C-c c t` | 添加待办事项 |
| `C-c c h` | 添加习惯 |
| `C-c c w` | 工作任务 |
| `C-c c n` | 快速笔记 |
| `C-c c j` | 日志记录 |
| `C-c c o` | 交易想法 |

### 快速回顾
| 快捷键 | 功能 |
|--------|------|
| `C-c r d` | 创建每日回顾 |
| `C-c r w` | 创建每周回顾 |
| `C-c r m` | 创建月度回顾 |

### Org 基础操作
| 快捷键 | 功能 |
|--------|------|
| `C-c l` | 存储链接 |
| `C-c c` | 打开 Capture |
| `C-c a` | 打开 Agenda |
| `C-c r` | Refile 归档 |

### R 编程（ESS）
| 快捷键 | 功能 |
|--------|------|
| `M-i` | 执行当前行 |
| `M-p` | 执行函数/段落 |
| `M-o` | 执行选中区域 |
| `M-b` | 执行整个缓冲区 |
| `_` | 插入 `<-` |
| `C-%` | 插入 `%>%` |

### 窗口操作
| 快捷键 | 功能 |
|--------|------|
| `C-Tab` | 切换窗口 |
| `C-p/n` | 上/下移动 |
| `C-f/b` | 前/后移动 |
| `C-a/e` | 行首/行尾 |

## 📂 重要文件路径

### GTD 文件
```
D:/Dropbox/git/gtd/
├── gtd.org          # 主任务文件
├── notes.org        # 笔记
├── journal.org      # 日志（含每日/周/月回顾）
├── trading.org      # 交易想法
├── habits.org       # 习惯追踪
├── projects.org     # 项目
├── inbox.org        # 收集箱
├── someday.org      # 未来可能
├── tickler.org      # 提醒事项
├── finished.org     # 已完成归档
└── canceled.org     # 已取消归档
```

### Agenda 数据源
```
D:/Dropbox/git/gtd/              # GTD 主目录
D:/Dropbox/git/notes/topics/forex/  # 外汇笔记
D:/Dropbox/git/notes/topics/rates/  # 利率笔记
D:/Dropbox/git/notes/topics/yen/    # 日元笔记
```

### Org-roam 笔记
```
D:/Dropbox/git/org/roam/         # Org-roam 知识库
```

## 🎨 Agenda 视图详解

### 10日视图（C-c a x）
**用途**：查看未来10天的计划
- 🔴 高优先级未完成任务
- 📅 10日日程
- 💡 外汇交易想法
- 📈 提升相关任务
- 📋 所有常规优先级任务
- ⚠️ **不显示习惯**（保持简洁）

### 每日回顾（C-c a d）
**用途**：每天结束时回顾
1. 🔴 高优先级任务
2. 📅 今日日程（**含习惯追踪图表**）
3. ✅ 今日完成的任务
4. ⏳ 未完成的任务
5. 📝 今日笔记

### 每周回顾（C-c a w）
**用途**：每周五或周日回顾
1. 📅 本周日程（周一-周日）
2. ✅ 本周完成的任务
3. ❌ 本周取消的任务
4. 🔴 待处理高优先级
5. 🎯 目标进展
- ⚠️ **不显示习惯**

### 月度回顾（C-c a m）
**用途**：月末总结
1. 📅 本月日程
2. 🎯 月度目标
3. 🏆 本月成就
4. 📋 待办事项（最多10项）
- ⚠️ **不显示习惯**

## 💡 最佳实践

### 每日工作流
```
早上 → C-c a d (查看每日回顾)
白天 → C-c c t (快速捕获任务)
晚上 → C-c r d (创建每日回顾)
```

### 每周工作流
```
周五下午 → C-c r w (创建每周回顾)
总结本周 → 记录成就和挑战
计划下周 → 设定3个主要目标
```

### 月度工作流
```
月末 → C-c r m (创建月度回顾)
评估目标 → 检查完成情况
财务回顾 → 记录收支
设定计划 → 下月改进方向
```

## 🎨 特色功能

### Org-modern 美化
- ✨ 现代化的 org-mode 界面
- 📊 美化的表格和列表
- 🎯 优化的 TODO 关键字显示
- 📝 增强的代码块样式

### 习惯追踪
- 📊 图形化进度显示
- 🔄 自动重复设置
- 📅 仅在每日回顾中显示

### 中英文混排
- 🇨🇳 优化的中文字体显示
- 🔤 Source Code Pro + 微软雅黑
- 📐 完美的字体对齐

## 🔧 维护和更新

### 同步配置
```bash
doom sync
```

### 更新 Doom
```bash
doom upgrade
```

### 重启 Emacs
```elisp
M-x restart-emacs
```

### 备份配置
配置文件会自动备份为 `config.el.backup`

### 恢复备份
```bash
cp ~/.doom.d/config.el.backup ~/.doom.d/config.el
doom sync
```

## ❓ 常见问题

### Agenda 没有数据
检查 GTD 目录是否存在：
```bash
ls D:/Dropbox/git/gtd/
```

### R 无法启动
检查 R 路径（在 config.el 中）：
```elisp
(setq inferior-ess-r-program "C:/Program Files/R/R-4.4.2/bin/R.exe")
```

### 中文显示乱码
检查文件编码设置（已在 config.el 中配置）：
- 系统编码：UTF-8
- Windows 粘贴：UTF-16LE-DOS

### 习惯在10日/周/月视图中显示
这是正常的，配置已优化为：
- ✅ 每日回顾：显示习惯
- ❌ 10日/周/月视图：不显示习惯

## 📊 配置统计

| 项目 | 数值 |
|------|------|
| 配置文件行数 | 675 行 |
| Org-agenda 视图 | 4 个 |
| Capture 模板 | 11 个 |
| GTD 文件数量 | 12+ 个 |
| Agenda 数据源 | 4 个目录 |

## 🎓 学习资源

- [Doom Emacs 官方文档](https://github.com/doomemacs/doomemacs)
- [Org-mode 官方手册](https://orgmode.org/manual/)
- [GTD 方法论](https://gettingthingsdone.com/)

## 📝 配置历史

- **2024-02-11**: 初始配置
- **2025-10-25**:
  - 优化 agenda 视图
  - 添加每日/周/月回顾
  - 修复习惯显示问题
  - 优化中文显示
  - 添加配置文档

---

*最后更新：2025-10-25*
*作者：杨江伟 <yangjw2011@foxmail.com>*