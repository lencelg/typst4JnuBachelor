# 暨南大学本科毕业论文 / 调研报告 Typst 模板

基于 [Typst](https://typst.app/) 的暨南大学本科毕业论文与调研报告排版模板。模板参照学校本科毕业论文撰写规范与参考模板整理，封装了封面、诚信声明、中英文摘要、目录、正文、图表、公式、参考文献等常用版式。

> 这是非官方模板，最终格式请以学院和教务处的具体要求为准。

## 目录

- [特性](#特性)
- [环境要求](#环境要求)
- [快速开始](#快速开始)
- [项目结构](#项目结构)
- [论文模式](#论文模式)
- [调研报告模式](#调研报告模式)
- [参数说明](#参数说明)
- [字号与行距](#字号与行距)
- [章节分页](#章节分页)
- [参考文献与引用](#参考文献与引用)
- [图表与公式](#图表与公式)
- [字体与跨平台](#字体与跨平台)
- [常见问题](#常见问题)
- [声明](#声明)

## 特性

- 论文 / 调研报告两种模式，通过 `paper-type` 切换；
- 封面、诚信声明、中英文摘要、目录自动生成；
- 调研报告封面、分工表、报告专用字段；
- 正文字号、行距可配置（默认四号、1.5 倍行距、首行缩进 2 字）；
- 标题四级编号 `1 / 1.1 / 1.1.1 / 1.1.1.1`；
- 图、表、公式按章编号；
- GB/T 7714—2015 顺序编码制，正文引用自动上标；
- 页眉、页码、目录页码自动处理；
- 可选显示诚信声明和英文摘要；
- 字号、行距、是否另起章页均可配置。

## 环境要求

- Typst **0.15.1** 或更新版本（开发时使用 0.15.1）；
- 中文字体：Windows 建议安装宋体、黑体、楷体、Times New Roman；
  Linux / macOS 建议安装 Noto Serif/Sans CJK SC、LXGW WenKai 等。

检查版本：

```bash
typst --version
```

## 快速开始

```bash
# 编译论文示例
typst compile main.typ

# 或开启文件监听，保存后自动重新编译
typst watch main.typ
```

编译后生成 `main.pdf`。`main.pdf` 是构建产物，已加入 `.gitignore`。

直接修改 `main.typ` 顶部的 `#show: jnu-thesis.with(...)`：

1. 填写题目、学院、专业、姓名、学号、指导教师、日期；
2. 填写中英文摘要和关键词；
3. 在 `= 绪论` 之后撰写正文；
4. 在 `res/refs.bib` 中维护文献，正文用 `#cite(<key>)` 或 `@key` 引用。

## 项目结构

```text
.
├── lib.typ          # 模板核心：版式、封面、前置页、正文样式
├── main.typ         # 论文示例，可直接修改
├── res/
│   ├── jnulogo.png  # 封面校徽
│   └── refs.bib     # GB/T 7714 示例文献库
├── .gitignore
└── README.md
```

`main.pdf` 由编译生成，不纳入版本库。版式参考的原始 PDF / Word 文件也不在仓库中。

## 论文模式

`main.typ` 默认就是论文模式。最小调用示例：

```typst
#import "lib.typ": jnu-thesis

#show: jnu-thesis.with(
  paper-type: "thesis",
  title: "论文题目",
  title-en: "English Title",
  short-title: "页眉短标题",
  college: "学院",
  major: "专业",
  author: "姓名",
  student-id: "学号",
  supervisor: "指导教师",
  date: "二〇二六年六月",
  abstract: [中文摘要],
  abstract-en: [English abstract],
  keywords: ("关键词1", "关键词2"),
  keywords-en: ("Keyword1", "Keyword2"),
  bib: "res/refs.bib",
)

= 绪论
正文内容……
```

论文模式的页面顺序：

```text
封面 → 诚信声明* → 中文摘要 → 英文摘要* → 目录 → 正文
```

`*` 为可选页，默认显示，可通过 `include-statement`、`include-abstract-en` 关闭。

> `main.typ` 当前在 `sizes` 中把 `body` 覆盖成了 `11pt`。如果不需要，删除 `sizes` 里的 `body: 11pt` 即可恢复模板默认的 14pt 正文。

## 调研报告模式

把 `paper-type` 改为 `"report"`，并填写报告封面与分工表字段：

```typst
#show: jnu-thesis.with(
  paper-type: "report",
  title: ("调查题目第一行", "第二行"),
  short-title: "学生实践调查报告",
  course: ("课程名称第一行", "第二行"),
  class-name: "2024 级金融工程",
  supervisor: "许文芳",
  score: "",
  date: "2026 年 5 月",
  abstract: [中文摘要],
  keywords: ("关键词1", "关键词2"),
  team: (
    (name: "张三", student-id: "2024xxxxxx", work: "资料收集"),
    (name: "李四", student-id: "2024xxxxxx", work: "问卷设计与数据分析"),
  ),
  bib: none,
)
```

调研报告模式的页面顺序：

```text
封面 → 分工表 → 诚信声明* → 中文摘要 → 英文摘要* → 目录 → 正文
```

- 报告模式默认**不显示**诚信声明和英文摘要；如需显示，加入 `include-statement: true`、`include-abstract-en: true`，并填写 `abstract-en`、`keywords-en`、`title-en`；
- 分工表固定放在封面下一页，单独一页，无页眉、页脚和页码；
- `team` 为空时会生成 4 行空白行，方便打印后手填；
- 报告封面的 logo 在标题上方居中；
- `title`、`course` 传字符串数组时用于封面换行，模板内部会拼成完整标题供页眉和摘要使用。

## 参数说明

### 通用参数

| 参数 | 默认值 | 说明 |
|---|---|---|
| `paper-type` | `"thesis"` | `"thesis"` 论文 / `"report"` 调研报告 |
| `title` | `""` | 论文题目；报告模式下可传字符串数组指定封面换行 |
| `title-en` | `""` | 英文题目 |
| `short-title` | `none` | 页眉短标题，缺省使用 `title` |
| `college` | `""` | 学院（论文封面） |
| `major` | `""` | 专业（论文封面） |
| `author` | `""` | 姓名（论文封面 / PDF 元数据） |
| `student-id` | `""` | 学号（论文封面） |
| `supervisor` | `""` | 指导教师；报告封面显示为“指导老师” |
| `date` | `""` | 日期，例如 `"二〇二六年六月"` / `"2026 年 5 月"` |
| `abstract` | `[]` | 中文摘要内容 |
| `abstract-en` | `[]` | 英文摘要内容 |
| `keywords` | `()` | 中文关键词数组 |
| `keywords-en` | `()` | 英文关键词数组 |
| `bib` | `none` | `.bib` 文件路径；`none` 表示不生成参考文献 |
| `logo` | `"res/jnulogo.png"` | 封面校徽路径 |
| `sizes` | `(:)` | 字号覆盖字典，见下一节 |
| `chapter-pagebreak` | `false` | 编号章节是否另起一页 |
| `leading` | `0.83em` | 行距，约等于 1.5 倍 |
| `include-statement` | `auto` | `auto`：论文显示、报告隐藏 |
| `include-abstract-en` | `auto` | `auto`：论文显示、报告隐藏 |

### 调研报告专用

| 参数 | 默认值 | 说明 |
|---|---|---|
| `course` | `""` | 课程名称，可传数组换行 |
| `class-name` | `""` | 专业班级 |
| `score` | `""` | 成绩评分，留空则显示空下划线 |
| `team` | `()` | 分工表成员数组，元素为 `(name, student-id, work)` |

## 字号与行距

`jnu-thesis` 的默认字号：

| 键 | 默认值 | 对应 |
|---|---|---|
| `body` | `14pt` | 正文（四号） |
| `heading` | `15pt` | 各级标题（小三） |
| `caption` | `10.5pt` | 图、表标题（五号） |
| `note` | `9pt` | 脚注（小五） |
| `code` | `10.5pt` | 代码块 |
| `cover-title` | `36pt` | 封面校名 / 报告标题 |
| `cover-info` | `auto` | 封面信息栏，跟随 `body` |
| `statement-title` | `22pt` | 诚信声明标题 |
| `statement-body` | `auto` | 诚信声明正文 |
| `abstract-title` | `18pt` | 摘要页标题 |
| `abstract-body` | `auto` | 摘要正文 |
| `reference` | `auto` | 参考文献条目，跟随 `caption` |
| `toc-title` | `24pt` | 目录标题 |
| `toc-entry` | `auto` | 目录条目，跟随 `body` |
| `header` | `10.5pt` | 页眉 |
| `footer` | `10.5pt` | 页码 |

只写需要覆盖的项即可：

```typst
sizes: (
  body: 12pt,
  heading: 14pt,
  caption: 9pt,
),
leading: 0.8em,
```

`auto` 表示跟随正文字号（`reference` 跟随 `caption`）。

## 章节分页

`chapter-pagebreak` 控制**带编号章节**是否另起一页：

- `false`（默认）：`1 绪论`、`2 系统分析` 等连续排版；结论、致谢、附录、参考文献等无编号标题仍自动另起一页；
- `true`：每个一级标题都另起一页。

章标题上方的间距由 `lib.typ` 中的 `jnu-chapter-drop` 控制，默认 `0.9cm`。

## 参考文献与引用

1. 在 `res/refs.bib` 中添加条目；
2. 正文中引用：

```typst
文学化编程的思想可参见#cite(<knuth1984>)。
```

也可以使用 `@key` 语法。模板会：

- 按 GB/T 7714—2015 顺序编码制编号；
- 将正文引用显示为右上角 `[1]`、`[2]`；
- 按正文引用顺序生成参考文献列表。

> Typst 默认**只列出正文引用过的文献**。如果参考文献页只有标题、没有条目，说明正文还没有 `#cite(...)`。`main.typ` 当前引用了 `knuth1984` 和 `lamport1994`，因此列表中有两条；`refs.bib` 中未被引用的条目不会出现。

如果想列出 `.bib` 中的所有条目，可以在 `lib.typ` 的 `bibliography(...)` 调用中加上 `full: true`，或把需要的文献都引用一次。

## 图表与公式

- 图：`#figure(image(...), caption: [...])`，图题在下，按章编号，例如 `图 2-1`；
- 表：`#figure(table(...), caption: [...])`，表题在上，按章编号，例如 `表 2-1`；
- 公式：直接写 `$ ... $`，模板会按章编号为 `(2-1)`；
- 每章开始时自动清零图、表、公式计数器，保证章内连续。

三线表示例：

```typst
#figure(
  table(
    columns: (auto, 1fr, 1fr),
    align: (center + horizon, left + horizon, left + horizon),
    table.hline(stroke: 1pt),
    [*工具*], [*优势*], [*局限*],
    table.hline(stroke: 0.5pt),
    [Word], [操作直观], [长文档样式一致性较弱],
    [Typst], [语法简洁], [生态仍在发展],
    table.hline(stroke: 1pt),
  ),
  caption: [排版工具比较],
)
```

## 字体与跨平台

模板使用字体栈，按顺序回退：

- 宋体 / 西文：Times New Roman → Liberation Serif → SimSun → Songti SC → Noto Serif CJK SC → Source Han Serif SC
- 黑体：SimHei → Heiti SC → Noto Sans CJK SC → Source Han Sans CN
- 楷体：KaiTi → STKaiti → LXGW WenKai → Noto Serif CJK SC

Windows 上通常直接使用宋体、黑体、楷体、Times New Roman；Linux / macOS 会回退到 Noto、思源或 LXGW。

如果编译时出现：

```text
warning: unknown font family: simsun
```

说明本机没有该字体，Typst 会使用后面的回退字体，不影响 PDF 输出。想消除警告，可以安装对应字体，或修改 `lib.typ` 顶部的字体栈。

## 常见问题

### 参考文献页只有标题，没有条目

正文没有 `#cite(...)`。Typst 只列出被引用的文献，补上引用即可，例如：

```typst
相关研究可参见#cite(<knuth1984>)。
```

### 诚信声明 / 英文摘要没有出现

报告模式默认关闭这两页。需要时显式开启：

```typst
include-statement: true,
include-abstract-en: true,
```

论文模式默认开启，也可以用 `false` 关闭。

### 分工表是空白的

`team` 为空时会生成 4 行空白行。填写成员即可：

```typst
team: (
  (name: "张三", student-id: "2024xxxxxx", work: "资料收集"),
),
```

### 正文为什么是 11pt

`main.typ` 当前的 `sizes` 把 `body` 覆盖成了 `11pt`。删除这一项即可恢复默认 `14pt`。

### 如何让每章另起一页

```typst
chapter-pagebreak: true,
```

### 如何更换校徽

替换 `res/jnulogo.png`，或修改 `logo` 参数：

```typst
logo: "res/your-logo.png",
```

### 成绩评定表、封底在哪里

这两页由学校统一印发，模板不生成。模板覆盖封面到参考文献的正文部分。

## 声明

- 本项目为非官方 Typst 模板，最终格式以暨南大学及所在学院要求为准；
- 校徽等学校标识的版权归暨南大学所有，请仅在论文 / 报告排版中使用；
- 仓库未附带开源许可证，二次分发前请自行确认素材与代码的使用权限。
