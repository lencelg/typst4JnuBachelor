//  jnu-thesis 参数速查（完整说明见 lib.typ 中 jnu-thesis 的文档注释）

//  paper-type: "thesis" / "report"           论文 / 调研报告
//  include-statement: auto / true / false    诚信声明（auto：论文显示，报告隐藏）
//  include-abstract-en: auto / true / false  英文摘要（auto 同上）
//
//  title: "题目" / ("第一行", "第二行")      报告模式下数组用于封面换行
//  title-en: "英文题目"
//  short-title: "页眉短标题"                 缺省使用 title
//  college / major / author / student-id     论文封面字段
//  supervisor: "指导教师"                    报告封面显示为“指导老师”
//  date: "二〇二六年六月"
//
//  ---- 摘要与关键词 ----
//  abstract / abstract-en: [ ... ]
//  keywords / keywords-en: ("关键词1", "关键词2")
//
//  ---- 调研报告专用 ----
//  course: "课程名" / ("第一行", "第二行")
//  class-name: "2024 级金融工程"
//  score: ""
//  team: ((name: "张三", student-id: "2024...", work: "资料收集"), ...)
//        为空时生成 4 行空白行
//
//  ---- 参考文献与排版 ----
//  bib: "res/refs.bib" / none
//  logo: "res/jnulogo.png"
//  chapter-pagebreak: false / true           编号章节是否另起一页
//  leading: 0.83em                           行距（约 1.5 倍）
//  sizes: (body: 14pt, heading: 15pt, ...)   字号覆盖
//
//  报告模式最小改动：
//    paper-type: "report",
//    title: ("调查题目第一行", "第二行"),
//    course: ("课程名称第一行", "第二行"),
//    class-name: "2024 级金融工程",
//    supervisor: "指导老师",
//    date: "2026 年 5 月",
//    team: (...)
// ============================================================================

#import "lib.typ": jnu-thesis

#let title = "暨南大学本科毕业论文 Typst 模板"
#let title-en = "A Typst Template for Jinan University Undergraduate Theses"

#show: jnu-thesis.with(
  paper-type: "thesis",          // 改成 "report" 即切换调研报告

  title: title,
  title-en: title-en,
  short-title: title,
  college: "Steam",
  major: "Gaming",
  author: "布置倒",
  student-id: "114514",
  supervisor: "暨大大",
  date: "二〇二六年六月",

  abstract: [
    针对暨南大学本科毕业论文的排版需求，设计并实现了一套基于 Typst 的论文模板。模板依据学校本科毕业论文撰写规范，对页面尺寸、页边距、字体字号、行距、标题层级、页眉页码以及图表公式编号等要素进行了统一设置。模板将封面、诚信声明、中英文摘要、目录等前置部分与正文样式封装为可复用函数，使用者只需填写论文信息并撰写正文，即可自动生成符合规范的版面。
  ],
  abstract-en: [
    To meet the typesetting requirements of undergraduate theses at Jinan University, this paper designs and implements a thesis template based on Typst. Following the university's writing standards, the template unifies page size, margins, fonts, line spacing, heading hierarchy, running headers, page numbers, and the numbering of figures, tables, and equations. The cover, integrity statement, Chinese and English abstracts, table of contents, and body styles are encapsulated as reusable functions.
  ],
  keywords: ("毕业论文", "Typst", "排版模板", "暨南大学", "自动化排版"),
  keywords-en: ("Thesis", "Typst", "Typesetting template", "Jinan University", "Automated typesetting"),

  // 调研报告专用
  // course: ("课程名第一行", "课程名第二行"),
  // class-name: "2024 级金融工程",
  // score: "",
  // team: (
  //   (name: "张三", student-id: "2024xxxxxx", work: "资料收集"),
  //   (name: "李四", student-id: "2024xxxxxx", work: "问卷设计与数据分析"),
  // ),

  // 参考文献与排版
  bib: "res/refs.bib",
  chapter-pagebreak: false,      // 编号章节是否另起一页
  leading: 0.83em,               // 行距，约 1.5 倍
  // logo: "res/jnulogo.png",    // 默认使用 res/jnulogo.png

  // 字号设置
  sizes: (
    body: 11pt,          // 正文（四号）
    heading: 15pt,       // 各级标题（小三）
    caption: 10.5pt,     // 图、表标题（五号）
    note: 9pt,           // 脚注（小五）
    code: 10.5pt,        // 代码块
    cover-title: 36pt,   // 封面标题
    cover-info: auto,    // 封面信息栏（跟随 body）
    statement-title: 22pt, // 诚信声明标题
    statement-body: auto,  // 诚信声明正文
    abstract-title: 18pt,  // 摘要页标题
    abstract-body: auto,   // 摘要正文
    reference: auto,       // 参考文献条目
    toc-title: 24pt,       // 目录标题
    toc-entry: auto,       // 目录条目
    header: 10.5pt,        // 页眉
    footer: 10.5pt,        // 页码
  ),
)

= 绪论

#pagebreak()

= 系统分析

== 插图
插图示例：@fig-logo 给出了示例。

#figure(
  image("res/jnulogo.png", width: 3cm),
  caption: [jnu logo],
) <fig-logo>

== 表格

表格采用三线表，表题置于表格上方，按章编号。@tab-tools 比较了三种常见排版工具的特点。

#figure(
  table(
    columns: (auto, 1fr, 1fr),
    align: (center + horizon, left + horizon, left + horizon),
    table.hline(stroke: 1pt),
    [*工具*], [*优势*], [*局限*],
    table.hline(stroke: 0.5pt),
    [Word], [操作直观，普及率高], [长文档样式一致性较弱],
    [LaTeX], [排版质量高，生态成熟], [学习成本高，中文配置复杂],
    [Typst], [语法简洁，编译速度快], [生态仍在发展],
    table.hline(stroke: 1pt),
  ),
  caption: [三种排版工具的比较],
) <tab-tools>

== 公式

公式另起一行居中书写，编号按章排列。以@eq-demo 为例：

$ integral_0^1 x^2 dif x = 1/3 $ <eq-demo>


= 系统设计

== 样式实现

标题层级通过编号格式 `1.1.1.1` 控制，最多支持四级。

参考文献使用 GB/T 7714—2015 顺序编码制，正文引用由 `cite` 的样式规则转换为上标#footnote[具体要求见《信息与文献　参考文献著录规则》（GB/T 7714—2015）。]。

#heading(numbering: none)[结论]

没有结论

#heading(numbering: none)[致谢]

  LOL。

感谢我的导师暨大大老师，谢谢他在论文写作过程中给予的悉心指导。他严谨的治学态度和无私的关爱，将激励我不断进取。其次，还要感谢四年中教过我的所有老师，谢谢他们对于逃课的态度很好，让我在Steam上贡献了大量时间研究并不断在社区里面提升自我实力。
我的同学暨小小在Steam上的Gaming项目也给予了我很多的帮助，在此一并致谢！

#heading(numbering: none)[附录 A]

以下分别给出论文与调研报告两种模式的基本调用方式。未写出的参数使用默认值；字号、行距等排版参数可通过 `sizes` 和 `leading` 覆盖，完整清单见 `main.typ` 顶部的参数速查。

论文模式：

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
  // include-statement: true,      // 默认：论文显示、报告隐藏
  // include-abstract-en: true,
  // chapter-pagebreak: false,     // 编号章节连续排版
)
```

调研报告模式：

```typst
#show: jnu-thesis.with(
  paper-type: "report",
  title: ("调查题目第一行", "第二行"),
  short-title: "学生实践调查报告",
  course: ("课程名称第一行", "第二行"),
  class-name: "2024 级金融工程",
  supervisor: "指导老师",
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

报告模式默认不显示诚信声明和英文摘要；如需显示，加入 `include-statement: true`、`include-abstract-en: true`，并同时填写 `abstract-en`、`keywords-en` 和 `title-en`。

#heading(numbering: none)[附录 B]

nothing here