#import "@preview/modern-jnu-thesis:0.1.0": jnu-thesis

// 论文题目
#let title = "论文题目"
#let title-en = "English Title"

#show: jnu-thesis.with(
  paper-type: "thesis",

  title: title,
  title-en: title-en,
  short-title: title,
  college: "学院",
  major: "专业",
  author: "姓名",
  student-id: "学号",
  supervisor: "指导教师",
  date: "二〇二六年六月",

  abstract: [在此填写中文摘要。],
  abstract-en: [Write your English abstract here.],
  keywords: ("关键词一", "关键词二", "关键词三"),
  keywords-en: ("keyword one", "keyword two", "keyword three"),

  bib: bibliography(
    "res/refs.bib",
    style: "gb-7714-2015-numeric",
    title: none,
  ),
  // chapter-pagebreak: true,
  // logo: "res/jnulogo.png",

  // 调研报告模式：将 paper-type 改为 "report"，并填写以下字段。
  // paper-type: "report",
  // title: ("调查题目第一行", "第二行"),
  // short-title: "学生实践调查报告",
  // course: ("课程名称第一行", "第二行"),
  // class-name: "专业班级",
  // supervisor: "指导老师",
  // score: "",
  // team: (
  //   (name: "姓名", student-id: "学号", work: "分工"),
  // ),
)

= 引言

在此撰写正文。

== 插图

图 @fig-logo 展示了插图的使用方式。

#figure(
  image("res/jnulogo.png", width: 3cm),
  caption: [插图示例],
) <fig-logo>

== 表格

表 @tab-example 是一个三线表示例。

#figure(
  table(
    columns: (auto, 1fr, 1fr),
    align: (center + horizon, left + horizon, left + horizon),
    table.hline(stroke: 1pt),
    [*项目*], [*说明*], [*备注*],
    table.hline(stroke: 0.5pt),
    [示例], [在此填写内容], [可删除],
    table.hline(stroke: 1pt),
  ),
  caption: [三线表示例],
) <tab-example>

== 公式

公式 @eq-example 按章编号：

$ integral_0^1 x^2 dif x = 1/3 $ <eq-example>

== 引用

文献引用示例：#cite(<knuth1984>)。

= 结论

在此撰写结论。
