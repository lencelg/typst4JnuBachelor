#import "lib.typ": jnu-thesis

#let title = "暨南大学本科毕业论文 Typst 模板"
#let title-en = "A Typst Template for Jinan University Undergraduate Theses"

#show: jnu-thesis.with(
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
    针对暨南大学本科毕业论文的排版需求，设计并实现了一套基于 Typst 的论文模板。模板依据学校本科毕业论文撰写规范，对页面尺寸、页边距、字体字号、行距、标题层级、页眉页码以及图表公式编号等要素进行了统一设置。模板将封面、诚信声明、中英文摘要、目录等前置部分与正文样式封装为可复用函数，使用者只需填写论文信息并撰写正文，即可自动生成符合规范的版面。测试结果表明，该模板能够稳定完成中英文混排、图表按章编号、参考文献顺序编码与上标引用等任务，在保证排版质量的同时显著提高了写作效率。
  ],
  abstract-en: [
    To meet the typesetting requirements of undergraduate theses at Jinan University, this paper designs and implements a thesis template based on Typst. Following the university's writing standards, the template unifies page size, margins, fonts, line spacing, heading hierarchy, running headers, page numbers, and the numbering of figures, tables, and equations. The cover, integrity statement, Chinese and English abstracts, table of contents, and body styles are encapsulated as reusable functions, so that users only need to fill in the thesis information and write the main text. Tests show that the template handles mixed Chinese and English typesetting, chapter-based numbering, and GB/T 7714 numeric citations reliably, improving both typesetting quality and writing efficiency.
  ],
  keywords: ("毕业论文", "Typst", "排版模板", "暨南大学", "自动化排版"),
  keywords-en: ("Thesis", "Typst", "Typesetting template", "Jinan University", "Automated typesetting"),
  bib: "res/refs.bib",

  // 字号可按需覆盖（未写的项使用 lib.typ 中的默认值；auto 表示跟随 body）：
  // sizes: (
  //   body: 14pt,          // 正文（四号）
  //   heading: 15pt,       // 各级标题（小三）
  //   caption: 10.5pt,     // 图、表标题（五号）
  //   note: 9pt,           // 脚注（小五）
  //   code: 10.5pt,        // 代码块
  //   cover-title: 36pt,   // 封面“暨南大学 / 本科生毕业论文”
  //   cover-info: auto,    // 封面信息栏与日期
  //   statement-title: 22pt, // 诚信声明标题
  //   statement-body: auto,  // 诚信声明正文
  //   abstract-title: 18pt,  // 摘要页论文题目
  //   abstract-body: auto,   // 摘要正文
  //   reference: auto,       // 参考文献条目
  //   toc-title: 24pt,       // 目录标题
  //   toc-entry: auto,       // 目录条目
  //   header: 10.5pt,        // 页眉
  //   footer: 10.5pt,        // 页码
  // ),
  // leading: 0.83em,  // 行距，约 1.5 倍
  // chapter-pagebreak: true,  // 编号章节另起一页（默认 false）
)

= 绪论

== 文献综述

学位论文是本科阶段学习成果的集中体现，其版面质量直接影响阅读体验与学术规范。长期以来，国内高校论文排版主要依赖 Microsoft Word 或 LaTeX。Word 上手简单，但在长文档的样式一致性、图表编号和参考文献管理方面容易出现疏漏；LaTeX 排版质量高，却存在学习曲线陡峭、中文配置繁琐等问题#cite(<lamport1994>)。

近年来，基于标记语言的排版工具不断涌现。Typst 采用增量编译与现代化的脚本语法，在保持排版质量的同时显著降低了使用门槛#cite(<knuth1984>)。目前已有若干高校模板基于 Typst 实现，但针对暨南大学本科毕业论文规范的完整模板仍较为缺乏。本文即在梳理学校撰写规范的基础上，设计一套结构清晰、易于维护的 Typst 模板。

== 研究框架

本文的工作主要包括以下三个方面：

+ *规范梳理*：从页边距、字体字号、行距、标题层级、页码、图表与参考文献等方面整理排版要求；
+ *模板实现*：将前置部分与正文样式封装为函数，实现图表和公式的按章编号；
+ *示例验证*：以一篇完整的示例论文检验模板的稳定性与易用性。

在研究方法上，本文采用实测对照的方式：先对学校提供的 Word 与 LaTeX 模板进行版面测量，再在 Typst 中复现关键参数，最后通过编译输出逐页比对。

== 术语说明

为避免歧义，对文中出现的若干术语作如下说明。

*Typst* 是一种基于标记语言的现代排版系统，源文件以 @ 和 = 等符号描述结构，由编译器生成 PDF。*版心* 指页面中除去页边距后的正文区域。*前置部分* 包括封面、诚信声明、摘要与目录等位于正文之前的页面。*顺序编码制* 是 GB/T 7714—2015 规定的参考文献标注方法，按正文引用先后连续编号。

= 系统分析

== 需求分析

=== 版式需求

==== 页面参数

论文统一使用 A4 纸，页边距为左 3cm、右 2cm、上 2.5cm、下 2.5cm。正文采用四号宋体，行距约为 1.5 倍，每段首行缩进 2 字。各级标题使用小三号字加粗，英文字体采用 Times New Roman。

=== 功能需求

除基本版面外，模板还需满足以下功能要求：

+ 封面信息可按字段填写，下划线长度与对齐方式保持一致；
+ 中英文摘要、关键词分别成页；
+ 目录自动生成，包含四级标题并右对齐页码；
+ 图、表、公式按章编号，章内连续；
+ 参考文献按引用顺序自动编号，正文中以上标形式标注。

== 图表与公式

=== 插图

插图应居中排列，图题置于图下方，按章编号。@fig-logo 给出了示例。

#figure(
  image("res/jnulogo.png", width: 3cm),
  caption: [暨南大学校徽],
) <fig-logo>

=== 表格

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

=== 公式

公式另起一行居中书写，编号按章排列。以定积分为例：

$ integral_0^1 x^2 dif x = 1/3 $ <eq-demo>

@eq-demo 表明，模板可以在不打断段落节奏的前提下完成公式编号。

= 系统设计

== 模板结构

模板由 @ 与样式函数两部分组成。前者集中定义页面、字体、标题、图表等全局样式，后者负责生成封面、诚信声明、摘要和目录。正文文件只需引入模板并填写元数据，即可获得统一的版面。

== 样式实现

标题层级通过编号格式 `1.1.1.1` 控制，最多支持四级。每章开始时，模板自动清零图、表、公式计数器，从而保证编号在章内连续。参考文献使用 GB/T 7714—2015 顺序编码制，正文引用由 `cite` 的样式规则转换为上标#footnote[具体要求见《信息与文献　参考文献著录规则》（GB/T 7714—2015）。]。

#heading(numbering: none)[结论]

本文围绕暨南大学本科毕业论文的排版规范，完成了一套基于 Typst 的模板设计与实现。模板覆盖了封面、诚信声明、中英文摘要、目录、正文、图表、公式、参考文献与附录等主要环节，并通过统一的样式函数保证了版面的一致性。

实际使用表明，Typst 的自动编号与增量编译机制能够有效减少重复劳动，其脚本能力也为模板的扩展提供了便利。后续可进一步完善的内容包括：增加更多学院的特殊格式选项、补充图表目录，以及提供与学校成绩评定表的对接方案。

#heading(numbering: none)[致谢]

  LOL。

感谢我的导师暨大大老师，谢谢他在论文写作过程中给予的悉心指导。他严谨的治学态度和无私的关爱，将激励我不断进取。其次，还要感谢四年中教过我的所有老师，谢谢他们对于逃课的态度很好，让我在Steam上贡献了大量时间研究并不断在社区里面提升自我实力。
我的同学暨小小在Steam上的Gaming项目也给予了我很多的帮助，在此一并致谢！

#heading(numbering: none)[附录 A]

以下为模板的基本调用方式，供参考。

```typst
      #import "lib.typ": jnu-thesis

      #show: jnu-thesis.with(
        title: "论文题目",
        title-en: "英文题目",
        author: "姓名",
        college: "学院",
        major: "专业",
        student-id: "学号",
        supervisor: "指导教师",
        date: "二〇二六年六月",
        abstract: [中文摘要],
        keywords: ("关键词1", "关键词2"),
        bib: "res/refs.bib",

        // 字号可按需覆盖（未写的项使用 lib.typ 中的默认值；auto 表示跟随 body）：
        sizes: (
          body: 14pt,          // 正文（四号）
          heading: 15pt,       // 各级标题（小三）
          caption: 10.5pt,     // 图、表标题（五号）
          note: 9pt,           // 脚注（小五）
          code: 10.5pt,        // 代码块
          cover-title: 36pt,   // 封面“暨南大学 / 本科生毕业论文”
          cover-info: auto,    // 封面信息栏与日期
          statement-title: 22pt, // 诚信声明标题
          statement-body: auto,  // 诚信声明正文
          abstract-title: 18pt,  // 摘要页论文题目
          abstract-body: auto,   // 摘要正文
          reference: auto,       // 参考文献条目
          toc-title: 24pt,       // 目录标题
          toc-entry: auto,       // 目录条目
          header: 10.5pt,        // 页眉
          footer: 10.5pt,        // 页码
        ),
        leading: 0.83em,  // 行距，约 1.5 倍
      )
```

#heading(numbering: none)[附录 B]

nothing here