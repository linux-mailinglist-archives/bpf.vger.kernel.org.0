Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26A8612854F
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2019 00:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfLTXES (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 18:04:18 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11076 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726129AbfLTXES (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 20 Dec 2019 18:04:18 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBKN4D2O018855
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2019 15:04:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=xlVayruYy6qCIhl6n/6N39OkD1J4j4ihbhzK+dcUxOg=;
 b=PaJNlobiVj1hoh8iFp/hgWWILS25i3vtQt9FFJTYfPnq/tIRd/Npr+Y2tNsY51ZT7XlP
 u/c+ZaZk0IvZwgH6l6mcrEd+sq3Mfn87e2rfbad6a6ILT260FZ51GewADl15tTMa5Qn7
 zp6Ub758p7Du+uRG3C0AvjLjZUeDwWyxSu4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2x0m9yn6ds-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2019 15:04:16 -0800
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 20 Dec 2019 15:03:54 -0800
Received: by devvm3632.prn2.facebook.com (Postfix, from userid 172007)
        id 2BE6A29FFDC0A; Fri, 20 Dec 2019 15:03:53 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Hechao Li <hechaol@fb.com>
Smtp-Origin-Hostname: devvm3632.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     <hechaol@fb.com>, <rdna@fb.com>, <daniel@iogearbox.net>,
        <ast@kernel.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next] bpf: Print error message for bpftool cgroup show
Date:   Fri, 20 Dec 2019 15:03:01 -0800
Message-ID: <20191220230301.888477-1-hechaol@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-20_07:2019-12-17,2019-12-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 mlxlogscore=867 clxscore=1011 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=13 bulkscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912200177
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, when bpftool cgroup show <path> has an error, no error
message is printed. This is confusing because the user may think the
result is empty.

Before the change:

$ bpftool cgroup show /sys/fs/cgroup
ID       AttachType      AttachFlags     Name
$ echo $?
255

After the change:
$ ./bpftool cgroup show /sys/fs/cgroup
Error: can't query bpf programs attached to /sys/fs/cgroup: Operation
not permitted

Signed-off-by: Hechao Li <hechaol@fb.com>
---
 tools/bpf/bpftool/cgroup.c | 60 ++++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 18 deletions(-)

diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index 1ef45e55039e..74b57e2d7524 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -117,6 +117,28 @@ static int count_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type)
 	return prog_cnt;
 }
 
+#define QUERY_CGROUP_ERR (-1)
+#define QUERY_CGROUP_NO_PROG (0)
+#define QUERY_CGROUP_SUCCESS (1)
+static int check_query_cgroup_progs(int cgroup_fd)
+{
+	enum bpf_attach_type type;
+	bool no_prog = true;
+
+	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
+		int count = count_attached_bpf_progs(cgroup_fd, type);
+
+		if (count < 0 && errno != EINVAL)
+			return QUERY_CGROUP_ERR;
+
+		if (count > 0) {
+			no_prog = false;
+			break;
+		}
+	}
+
+	return no_prog ? QUERY_CGROUP_NO_PROG : QUERY_CGROUP_SUCCESS;
+}
 static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
 				   int level)
 {
@@ -162,6 +184,7 @@ static int do_show(int argc, char **argv)
 {
 	enum bpf_attach_type type;
 	const char *path;
+	int query_check;
 	int cgroup_fd;
 	int ret = -1;
 
@@ -192,6 +215,16 @@ static int do_show(int argc, char **argv)
 		goto exit;
 	}
 
+	query_check = check_query_cgroup_progs(cgroup_fd);
+	if (query_check == QUERY_CGROUP_ERR) {
+		p_err("can't query bpf programs attached to %s: %s",
+		      path, strerror(errno));
+		goto exit_cgroup;
+	} else if (query_check == QUERY_CGROUP_NO_PROG) {
+		ret = 0;
+		goto exit_cgroup;
+	}
+
 	if (json_output)
 		jsonw_start_array(json_wtr);
 	else
@@ -212,8 +245,8 @@ static int do_show(int argc, char **argv)
 	if (json_output)
 		jsonw_end_array(json_wtr);
 
+exit_cgroup:
 	close(cgroup_fd);
-exit:
 	return ret;
 }
 
@@ -228,7 +261,7 @@ static int do_show_tree_fn(const char *fpath, const struct stat *sb,
 			   int typeflag, struct FTW *ftw)
 {
 	enum bpf_attach_type type;
-	bool skip = true;
+	int query_check;
 	int cgroup_fd;
 
 	if (typeflag != FTW_D)
@@ -240,22 +273,13 @@ static int do_show_tree_fn(const char *fpath, const struct stat *sb,
 		return SHOW_TREE_FN_ERR;
 	}
 
-	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
-		int count = count_attached_bpf_progs(cgroup_fd, type);
-
-		if (count < 0 && errno != EINVAL) {
-			p_err("can't query bpf programs attached to %s: %s",
-			      fpath, strerror(errno));
-			close(cgroup_fd);
-			return SHOW_TREE_FN_ERR;
-		}
-		if (count > 0) {
-			skip = false;
-			break;
-		}
-	}
-
-	if (skip) {
+	query_check = check_query_cgroup_progs(cgroup_fd);
+	if (query_check == QUERY_CGROUP_ERR) {
+		p_err("can't query bpf programs attached to %s: %s",
+		      fpath, strerror(errno));
+		close(cgroup_fd);
+		return SHOW_TREE_FN_ERR;
+	} else if (query_check == QUERY_CGROUP_NO_PROG) {
 		close(cgroup_fd);
 		return 0;
 	}
-- 
2.17.1

