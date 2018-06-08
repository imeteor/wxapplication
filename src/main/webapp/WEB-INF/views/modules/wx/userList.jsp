<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>人员管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {

        });

        function page(n, s) {
            if (n) $("#pageNo").val(n);
            if (s) $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctx}/wx/personnel/list");
            $("#searchForm").submit();
            return false;
        }
    </script>
</head>
<body>
    <ul class="nav nav-tabs">
        <li class="active"><a href="${ctx}/wx/personnel/list">人员列表</a></li>
        <li>
            <a href="${ctx}/wx/personnel/form?id=${user.id}">人员
                <shiro:hasPermission name="wx:personnel:edit">${not empty user.id?'修改':'添加'}</shiro:hasPermission>
                <shiro:lacksPermission name="wx:personnel:edit">查看</shiro:lacksPermission>
            </a>
        </li>
    </ul>
    <form:form id="searchForm" modelAttribute="user" action="${ctx}/wx/personnel/list" method="post" class="breadcrumb form-search ">
        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
        <sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
        <ul class="ul-form">
            <li><label>登录名：</label><form:input path="loginName" htmlEscape="false" maxlength="50" class="input-medium"/></li>
            <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
            <li class="clearfix"></li>
        </ul>
    </form:form>
    <sys:message content="${message}"/>
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <thead>
        <tr>
            <th class="sort-column login_name">登录名</th>
            <th class="sort-column name">姓名</th>
            <shiro:hasPermission name="wx:personnel:edit">
                <th>操作</th>
            </shiro:hasPermission></tr>
        </thead>
        <tbody>
        <c:forEach items="${page.list}" var="user">
            <tr>
                <td><a href="${ctx}/wx/personnel/form?id=${user.id}">${user.loginName}</a></td>
                <td>${user.name}</td>
                <shiro:hasPermission name="sys:user:edit">
                    <td>
                        <a href="${ctx}/wx/personnel/form?id=${user.id}">修改</a>
                        <a href="${ctx}/wx/personnel/delete?id=${user.id}" onclick="return confirmx('确认要删除该用户吗？', this.href)">删除</a>
                    </td>
                </shiro:hasPermission>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="pagination">${page}</div>
</body>
</html>