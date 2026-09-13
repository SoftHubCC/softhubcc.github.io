# 创建 SoftHubCC.github.io 主页

## 目标
创建 GitHub Pages 项目，通过 https://softhubcc.github.io 访问官方主页，展示 KeyMouseMate 和 KeyMouseViz 两个项目。

## 方案
1. **仓库名称**：`SoftHubCC.github.io`（GitHub 官方用户主页标准命名）
2. **访问地址**：https://softhubcc.github.io
3. **本地路径**：`E:\MyDev\Projects\SoftHubCC.github.io`
4. **设计风格**：混合风格（深色导航 + Hero + 浅色内容区 + 卡片式布局）

## 实现步骤

### 步骤 1：创建本地仓库
- 创建目录 `E:\MyDev\Projects\SoftHubCC.github.io`
- 初始化 git：`git init`
- 配置用户信息：`git config user.email "flyyhui@qq.com"` 和 `user.name "SoftHubCC"`

### 步骤 2：创建 index.html
文件内容：
- 深色渐变导航栏（品牌名 SoftHubCC）
- 深色渐变 Hero 区域（标题 + 描述 + 徽章）
- 浅色内容区（两个项目卡片并排）
- 每个卡片包含：图标、名称、标签、简介、功能列表、下载/源码按钮
- 深色 Footer

项目卡片信息：
- **KeyMouseMate**：RPA 自动化工具，v2.1，下载链接指向 Releases
- **KeyMouseViz**：键鼠可视化助手，v1.0，下载链接指向 Releases

### 步骤 3：提交并推送
```bash
git add -A
git commit -m "Initial commit: SoftHubCC homepage"
git remote add origin https://github.com/SoftHubCC/SoftHubCC.github.io.git
git push -u origin main
```

### 步骤 4：启用 GitHub Pages
- 在 GitHub 仓库设置中启用 Pages（默认 main 分支 root 目录）
- 访问 https://softhubcc.github.io 验证

## 关键文件
- `index.html` - 主页（唯一必要文件）

## 依赖检查
- [x] GitHub Token 已获取（`Releases/github_token.txt`）
- [x] git 用户配置已知（flyyhui@qq.com / SoftHubCC）
- [x] 本地目录已创建

## 注意事项
- HTML 文件不包含 `data-page-node-id`（非 WorkBuddy 编辑文件）
- 所有外部链接使用绝对路径（HTTPS）
- 样式内联在 `<style>` 标签中，无需外部 CSS 文件
- 响应式设计，支持移动端
