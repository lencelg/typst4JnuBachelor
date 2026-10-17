// ============================================================================
//  暨南大学本科毕业论文 Typst 模板
//  Jinan University Undergraduate Thesis Template for Typst
//
//  用法：见 main.typ。所有可调参数集中在下方“版式参数”区域。
//  说明：
//    - 版式依据 jnuthesis.pdf 与《暨南大学本科毕业论文（设计）撰写规范》。
//    - 标题字号按写作规范统一为小三号（15pt）加粗。
//    - 正文字号四号（14pt），1.5 倍行距，首行缩进 2 字。
//    - 页边距：左 3cm、右 2cm、上/下 2.5cm。
// ============================================================================

// ---------------------------------------------------------------------------
//  版式参数
// ---------------------------------------------------------------------------

// 字体栈：Windows 优先使用宋体 / 黑体 / 楷体 / Times New Roman，
// Linux / macOS 自动回退到思源、Noto、LXGW 等字体。
// 若本机缺少某个字体，Typst 只会在编译时给出 warning，不影响输出。
#let jnu-serif = (
  "Times New Roman",
  "Liberation Serif",
  "SimSun",
  "Songti SC",
  "Noto Serif CJK SC",
  "Source Han Serif SC",
)
#let jnu-sans = (
  "SimHei",
  "Heiti SC",
  "Noto Sans CJK SC",
  "Source Han Sans CN",
)
#let jnu-kai = (
  "KaiTi",
  "STKaiti",
  "LXGW WenKai",
  "Noto Serif CJK SC",
)

#let jnu-body-size = 14pt        // 四号
#let jnu-heading-size = 15pt     // 小三
#let jnu-caption-size = 10.5pt   // 五号
#let jnu-note-size = 9pt         // 小五
#let jnu-leading = 0.83em        // 约等于 1.5 倍行距

#let jnu-margin = (
  left: 3cm,
  right: 2cm,
  top: 2.5cm,
  bottom: 2.5cm,
)

// 章标题在页首额外留出的空白（设为 0cm 可让标题紧贴版心顶部）。
#let jnu-chapter-drop = 0.9cm

// ---------------------------------------------------------------------------
//  内部工具
// ---------------------------------------------------------------------------

// 封面信息栏的下划线输入框。
#let _field-box(value, width: 154pt) = box(
  width: width,
  stroke: (bottom: 0.5pt),
  inset: (bottom: 4pt),
  align(center, value),
)

// 页眉：论文题目居中，下方一条 0.5pt 细线。
#let _running-header(title) = {
  set text(font: jnu-serif, size: 10.5pt)
  align(center, title)
  v(1.5pt)
  line(length: 100%, stroke: 0.5pt)
}

// 页脚：居中页码。
#let _page-footer = context {
  set text(font: jnu-serif, size: 10.5pt)
  align(center, counter(page).display())
}

// 居中标题（用于摘要页、目录页等非正文标题）。
#let _display-title(body, size: 18pt, font: jnu-sans, tracking: 0em) = align(
  center,
  text(size: size, font: font, tracking: tracking, body),
)

// 关键词拼接。
#let _keywords(items, sep: "；") = items.join(sep)

// ---------------------------------------------------------------------------
//  封面
// ---------------------------------------------------------------------------

#let _cover(
  title: "",
  college: "",
  major: "",
  author: "",
  student-id: "",
  supervisor: "",
  date: "",
  logo: "res/jnulogo.png",
) = {
  set page(
    header: none,
    footer: none,
    numbering: none,
    margin: (left: 2.5cm, right: 2.5cm, top: 2.5cm, bottom: 2.5cm),
  )
  set text(font: jnu-serif, size: jnu-body-size)
  set par(first-line-indent: 0pt, justify: false, spacing: 0pt)

  align(center, block(image(logo, width: 4cm)))
  v(1.53cm)
  align(center, block[
    #set par(leading: 30pt)
    #text(font: jnu-sans, size: 36pt, tracking: 0.30em)[暨南大学]#linebreak()
    #text(font: jnu-sans, size: 36pt, tracking: 0.30em)[本科生毕业论文]
  ])

  v(4.44cm)

  grid(
    columns: (70pt, 349.2pt),
    align: (left + horizon, center + horizon),
    [论文题目：],
    _field-box(title, width: 349.2pt),
  )

  v(4.40cm)

  align(
    center,
    grid(
      columns: (70pt, 154pt),
      row-gutter: 16pt,
      align: (left + horizon, center + horizon),
      [学　　院：],
      _field-box(college),
      [专　　业：],
      _field-box(major),
      [姓　　名：],
      _field-box(author),
      [学　　号：],
      _field-box(student-id),
      [指导教师：],
      _field-box(supervisor),
    ),
  )

  v(1.82cm)
  align(center, text(size: jnu-body-size, date))
}

// ---------------------------------------------------------------------------
//  诚信声明
// ---------------------------------------------------------------------------

#let _statement() = {
  set text(font: jnu-serif, size: jnu-body-size)
  set par(
    first-line-indent: (amount: 2em, all: true),
    leading: jnu-leading,
    spacing: jnu-leading,
    justify: true,
  )

  align(center, text(font: jnu-kai, size: 22pt, tracking: 0.45em)[诚信声明])

  v(2.11cm)

  [我声明，所呈交的毕业论文是本人在老师指导下进行的研究工作及取得的研究成果。据我查证，除了文中特别加以标注和致谢的地方外，论文中不包含其他人已经发表或撰写过的研究成果，也不包含为获得其他教育机构的学位或证书而使用过的材料。我承诺，论文中的所有内容均真实、可信。]

  v(6.37cm)

  grid(
    columns: (1fr, auto),
    align: (left + horizon, right + horizon),
    [毕业论文作者签名：],
    [签名日期：#h(1.8em)年#h(1.8em)月#h(1.8em)日],
  )
}

// ---------------------------------------------------------------------------
//  中文摘要
// ---------------------------------------------------------------------------

#let _abstract-cn(title: "", abstract: [], keywords: ()) = {
  set text(font: jnu-serif, size: jnu-body-size)
  set par(
    first-line-indent: (amount: 2em, all: true),
    leading: jnu-leading,
    spacing: jnu-leading,
    justify: true,
  )

  _display-title(title, size: 18pt, font: jnu-sans)

  v(1.1cm)

  grid(
    columns: (4em, 1fr),
    align: (left + top, left + top),
    strong("[摘要]"),
    {
      set par(first-line-indent: 0pt)
      abstract
    },
  )

  v(1.2cm)

  grid(
    columns: (5em, 1fr),
    align: (left + top, left + top),
    strong("[关键词]"),
    {
      set par(first-line-indent: 0pt)
      _keywords(keywords)
    },
  )
}

// ---------------------------------------------------------------------------
//  英文摘要
// ---------------------------------------------------------------------------

#let _abstract-en(title: "", abstract: [], keywords: ()) = {
  set text(font: jnu-serif, size: jnu-body-size, lang: "en")
  set par(
    first-line-indent: (amount: 2em, all: true),
    leading: jnu-leading,
    spacing: jnu-leading,
    justify: false,
  )

  _display-title(title, size: 18pt, font: jnu-sans)

  v(1.1cm)

  grid(
    columns: (5em, 1fr),
    align: (left + top, left + top),
    strong[Abstract],
    {
      set par(first-line-indent: 0pt)
      abstract
    },
  )

  v(1.2cm)

  grid(
    columns: (5em, 1fr),
    align: (left + top, left + top),
    strong[Keywords],
    {
      set par(first-line-indent: 0pt)
      _keywords(keywords, sep: "; ")
    },
  )
}

// ---------------------------------------------------------------------------
//  目录
// ---------------------------------------------------------------------------

#let _toc() = {
  set text(font: jnu-serif, size: jnu-body-size)
  set par(first-line-indent: 0pt, leading: 0.9em, justify: false)

  v(2.9cm)
  _display-title([目　录], size: 24pt, font: jnu-sans)
  v(1.8cm)

  show outline.entry: set outline.entry(fill: repeat[·])
  show outline.entry: it => block(above: 0.42em, below: 0.42em, it)

  outline(title: none, depth: 4, indent: it => it * 1em)
}

// ---------------------------------------------------------------------------
//  正文样式
// ---------------------------------------------------------------------------

#let _body-style(body) = {
  set text(font: jnu-serif, size: jnu-body-size, lang: "zh")
  set par(
    first-line-indent: (amount: 2em, all: true),
    leading: jnu-leading,
    spacing: jnu-leading,
    justify: true,
    justification-limits: (
      tracking: (min: -0.012em, max: 0.012em),
      spacing: (min: 75%, max: 120%),
    ),
  )

  // ---- 标题 ----
  set heading(numbering: "1.1.1.1")
  show heading: set text(
    font: jnu-serif,
    size: jnu-heading-size,
    weight: "bold",
  )
  show heading: set block(above: 1.0em, below: 0.55em)
  show heading.where(level: 1): set block(above: 0em, below: 1.4em)
  show heading.where(level: 2): set block(above: 1.4em, below: 0.6em)

  // 每章另起一页，并清零图、表、公式计数器，实现按章编号。
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(jnu-chapter-drop)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(math.equation).update(0)
    it
  }

  // ---- 图、表 ----
  set figure(supplement: [图])
  set figure(numbering: n => numbering(
    "1-1",
    counter(heading).get().first(),
    n,
  ))
  set figure.caption(separator: [　])
  show figure.caption: set text(size: jnu-caption-size)
  show figure.caption: set par(
    first-line-indent: 0pt,
    justify: false,
    leading: 0.8em,
  )
  show figure.where(kind: table): set figure(supplement: [表])
  show figure.where(kind: table): set figure.caption(position: top)

  // ---- 公式 ----
  set math.equation(numbering: n => numbering(
    "(1-1)",
    counter(heading).get().first(),
    n,
  ))

  // ---- 列表 ----
  set list(indent: 2em, body-indent: 0.6em, spacing: 0.45em)
  set enum(indent: 2em, body-indent: 0.6em, spacing: 0.45em)

  // ---- 表格：默认无线，示例中使用三线表 ----
  set table(
    stroke: none,
    inset: (x: 8pt, y: 5pt),
    align: center + horizon,
  )

  // ---- 代码块 ----
  show raw: set text(size: 10.5pt)
  show raw.where(block: true): set par(leading: 0.55em, justify: false)

  // ---- 脚注 ----
  show footnote.entry: set text(size: jnu-note-size)
  show footnote.entry: set par(
    first-line-indent: 0pt,
    leading: 0.6em,
    justify: false,
  )

  // ---- 引用与链接 ----
  // 顺序编码制：正文引用显示为右上角 [1]。
  show cite: it => super(text(font: jnu-serif, size: 0.85em, it))
  show link: set text(fill: black)

  // ---- 参考文献 ----
  show bibliography: set text(size: jnu-caption-size)
  show bibliography: set par(
    first-line-indent: 0pt,
    leading: 0.75em,
    justify: false,
  )

  body
}

// ---------------------------------------------------------------------------
//  模板总入口
// ---------------------------------------------------------------------------

/// 暨南大学本科毕业论文模板。
///
/// - `title` / `title-en`：中英文论文题目
/// - `short-title`：页眉中的短标题，缺省使用 `title`
/// - `abstract` / `abstract-en`：摘要正文（content）
/// - `keywords` / `keywords-en`：关键词数组
/// - `bib`：参考文献 .bib 文件路径；设为 `none` 则不自动生成参考文献页
///
/// 示例：
/// ```typst
/// #show: jnu-thesis.with(
///   title: "论文题目",
///   author: "张三",
///   ...
/// )
/// ```
#let jnu-thesis(
  title: "",
  title-en: "",
  short-title: none,
  college: "",
  major: "",
  author: "",
  student-id: "",
  supervisor: "",
  date: "",
  abstract: [],
  abstract-en: [],
  keywords: (),
  keywords-en: (),
  bib: none,
  logo: "res/jnulogo.png",
  body,
) = {
  let running-title = if short-title == none { title } else { short-title }

  set document(
    title: title,
    author: author,
    keywords: _keywords(keywords),
  )

  set page(
    paper: "a4",
    margin: jnu-margin,
    header-ascent: 18.9pt,
    numbering: none,
  )

  set text(font: jnu-serif, size: jnu-body-size, lang: "zh")
  set par(
    first-line-indent: (amount: 2em, all: true),
    leading: jnu-leading,
    spacing: jnu-leading,
    justify: true,
  )

  // 封面：无页眉页脚、无页码。
  _cover(
    title: title,
    college: college,
    major: major,
    author: author,
    student-id: student-id,
    supervisor: supervisor,
    date: date,
    logo: logo,
  )

  pagebreak()

  // 从诚信声明开始加页眉；前置部分不编页码。
  set page(
    header: _running-header(running-title),
    footer: none,
    numbering: none,
  )
  _statement()

  pagebreak()
  _abstract-cn(title: title, abstract: abstract, keywords: keywords)

  pagebreak()
  _abstract-en(title: title-en, abstract: abstract-en, keywords: keywords-en)

  pagebreak()
  _toc()

  pagebreak()

  // 正文：页码从 1 开始。
  set page(
    header: _running-header(running-title),
    footer: _page-footer,
    numbering: "1",
  )
  counter(page).update(1)
  _body-style({
    body
    // 参考文献放在最后（与 jnuthesis.pdf 的顺序一致）。
    if bib != none {
      heading(numbering: none, outlined: true)[参考文献]
      bibliography(bib, style: "gb-7714-2015-numeric", title: none)
    }
  })
}
