[#ftl/]
[@b.head /]

[@b.toolbar title="<b>学生考试签名表</b>"]
  bar.addItem("打印", "print()");
  bar.addClose();
[/@]
<style>
.printTableStyle {
  border-collapse: collapse; border:solid; border-width:2px; border-color:#006CB2; vertical-align: middle; font-style: normal; font-size: 10pt;
}
table.printTableStyle td {
  border:solid; border-width:0px; border-right-width:2; border-bottom-width:2; border-color:#006CB2; height:26px;
}

.formTable { font-size:${fontSize?default(13)}px; }
</style>

[#assign tableNum=0]
[#list examRooms as examRoom]
     [#if examRoom.activities?size != 1]
      [#assign courseStds = examRoom.courseStds/]
      [#list courseStds?keys as c]
      [@displayTable examRoom,c,courseStds.get(c)/]
      [/#list]
    [#else]
      [@displayTable examRoom,examRoom.activities?first.clazz.course,examRoom.examTakers /]
    [/#if]
[/#list]

[#macro displayTable(examRoom,course,ess)]
[#assign examTakers=ess?sort_by('seatNo')/]
[#if tableNum!=0]<div style='PAGE-BREAK-BEFORE: always'></div>[/#if]

  <table width="100%" align="center">
    <tr>
      [#assign teachers = []/]
      [#assign crns = []/]
      [#if examRoom.activities?size>0]
        [#list examRoom.activities as activity][#if activity.clazz.course=course][#list activity.clazz.teachers as teacher][#if !teachers?seq_contains(teacher)][#assign teachers=teachers+[teacher]][/#if][/#list][/#if][/#list]
        [#list examRoom.activities as activity][#if activity.clazz.course=course][#if !crns?seq_contains(activity.clazz.crn)][#assign crns=crns+[activity.clazz.crn]][/#if][/#if][/#list]
      [#else]
        [#list examRoom.examTakers as es][#if es.clazz.course=course][#list es.clazz.teachers as teacher][#if !teachers?seq_contains(teacher)][#assign teachers=teachers+[teacher]][/#if][/#list][/#if][/#list]
        [#list examRoom.examTakers as es][#if es.clazz.course=course][#if !crns?seq_contains(es.clazz.crn)][#assign crns=crns+[es.clazz.crn]][/#if][/#if][/#list]
      [/#if]
      <td align="center" colspan="4" style="font-size:12pt;height:45px" >
        <B>
          ${examRoom.semester.schoolYear}-${examRoom.semester.name} &nbsp;&nbsp;国教院${(examRoom.examType.name)!}签到单及成绩单<br>
          ${course.name}&nbsp;&nbsp;${course.enName!}<br>
          请将登好分数的此成绩单，签字盖章后，交到7A119办公室，谢谢！<br>
        </B>
      </td>
    </tr>
  </table>

  <table class="formTable" width="100%">
    <tr bgcolor="#C7DBFF" align="center">
        <td style="width:5%"><B>NO</B></td>
        <td style="width:12%"><B>年级专业Major</B></td>
        <td style="width:13%"><B>${b.text("attr.stdNo")}ID</B></td>
        <td style="width:25%"><B>英文名Name</B></td>
        <td style="width:25%"><B>signature</B></td>
        <td style="width:10%"><B>总评成绩</B></td>
        <td style="width:10%"><B>备注</B></td>
    </tr>

    [#list examTakers as es]
    <tr class="brightStyle" align="center">
      <td>${es_index+1}</td>
      <td>${es.std.state.grade}${(es.std.state.major.enName)?default(es.std.state.major.name)}</td>
      <td>${es.std.user.code}</td>
      <td><span [#if es.std.user.name?length>16]style="font-size:0.6em"[/#if]>${es.std.user.name}</span></td>
      [#if es.examStatus.id=1]
        <td> </td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      [#else ]
        <td colspan="3">${es.examStatus.name} </td>
      [/#if]
    </tr>
    [/#list]
  </table>

  [#assign tableNum=tableNum+1 /]
[/#macro]
[@b.foot/]
