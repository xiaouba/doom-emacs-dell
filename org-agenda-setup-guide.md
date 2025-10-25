# Doom Emacs Org-Agenda 配置指南

## 已完成的配置优化

### 1. 修正了文件路径
- **原问题**: org-agenda-dir 指向不存在的路径 `D:/Dropbox/git/captures`
- **已修正为**: `D:/Dropbox/git/gtd` （您的实际 GTD 文件位置）

### 2. 更新了 org-agenda-files 设置
现在自动扫描以下目录中的所有 .org 文件：
- `D:/Dropbox/git/gtd/` - 主要 GTD 文件
- `D:/Dropbox/git/notes/` - 笔记文件
- `D:/Dropbox/git/notes/topics/forex/` - 外汇相关
- `D:/Dropbox/git/notes/topics/rates/` - 利率相关
- `D:/Dropbox/git/notes/topics/yen/` - 日元相关

### 3. 增强了 TODO 关键字配置
设置了完整的 GTD 工作流程关键字：
- **TODO**: 待办事项
- **NEXT**: 下一步行动
- **PROJ**: 项目
- **STRT**: 已开始
- **WAIT**: 等待中
- **HOLD**: 暂停
- **DONE**: 已完成
- **KILL**: 已取消

### 4. 添加了实用功能

#### 诊断功能
- **快捷键**: `C-c t`
- **功能**: 检查 org-agenda 配置是否正确，显示找到的文件列表

#### 刷新功能
- **快捷键**: `C-c r`
- **功能**: 刷新 org-agenda 文件列表

### 5. 优化了 Agenda 视图
- 设置了每日视图为默认
- 配置了时间网格（8:00-20:00）
- 添加了自定义视图命令 `C-c a d` 显示：
  - 高优先级任务
  - 今日日程
  - 交易想法（IDEA 标签）
  - 提升相关任务
  - 所有普通任务

## 使用方法

### 重新加载配置
1. 保存并关闭 Emacs
2. 运行命令：`doom sync` （在命令行中）
3. 重新启动 Emacs

### 常用快捷键
- `C-c a` - 打开 Agenda 主菜单
- `C-c a d` - 显示每日议程视图（自定义视图）
- `C-c a a` - 显示标准议程视图
- `C-c a t` - 显示所有 TODO 项
- `C-c c` - 快速捕获新任务
- `C-c r` - 刷新 org-agenda 文件列表
- `C-c t` - 检查 org-agenda 配置状态

### 故障排除

#### 如果 agenda 仍然无法显示数据：
1. 按 `C-c t` 检查配置状态
2. 按 `C-c r` 刷新文件列表
3. 确认您的 .org 文件中有正确的 TODO 项格式

#### TODO 项格式示例：
```org
* TODO 任务标题
SCHEDULED: <2024-10-24 周四>

* TODO [#A] 高优先级任务
DEADLINE: <2024-10-25 周五>

* NEXT 下一步行动
```

## 文件组织建议

### GTD 目录结构（已配置）
```
D:/Dropbox/git/gtd/
├── gtd.org        # 主要任务文件
├── inbox.org      # 收集箱
├── projects.org   # 项目列表
├── someday.org    # 将来可能
├── tickler.org    # 提醒事项
├── notes.org      # 快速笔记
├── journal.org    # 日志
├── trading.org    # 交易相关
├── habits.org     # 习惯追踪
├── finished.org   # 已完成归档
└── canceled.org   # 已取消归档
```

## 注意事项
1. 配置文件位置：`c:\Users\xiaouba-dell\.doom.d\config.el`
2. 修改配置后需要运行 `doom sync` 并重启 Emacs
3. 第一次使用时可能需要按 `C-c r` 刷新文件列表