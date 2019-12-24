Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D23D129C5B
	for <lists+bpf@lfdr.de>; Tue, 24 Dec 2019 02:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfLXBRy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Dec 2019 20:17:54 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:4154 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726959AbfLXBRx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Dec 2019 20:17:53 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBO1FZWu013726
        for <bpf@vger.kernel.org>; Mon, 23 Dec 2019 17:17:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=2WEOCTwU62XVTtkRi7ybeVZ8q7u6sH1vuEz8hF/CNyc=;
 b=HR7MXBVkCqQn5eln9t20yeA3X9pzRwssp1VtrRROAkMo8W6n2v1rYjCs1MghauJWHToR
 UZP23coOth5ChFIN5bPInXg84YZPQbEWEp5S9AJnaF0oy1OL66X24t0ISRiGpraV+0zk
 V+3amqPAlZRcGjeGoxhfMheOuLN4ANJPr4U= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2x23tvptxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 23 Dec 2019 17:17:52 -0800
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 23 Dec 2019 17:17:51 -0800
Received: by devvm3632.prn2.facebook.com (Postfix, from userid 172007)
        id 7AFE42A3486B7; Mon, 23 Dec 2019 17:17:49 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Hechao Li <hechaol@fb.com>
Smtp-Origin-Hostname: devvm3632.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     <hechaol@fb.com>, <rdna@fb.com>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 bpf-next] bpf: Print error message for bpftool cgroup show
Date:   Mon, 23 Dec 2019 17:17:42 -0800
Message-ID: <20191224011742.3714301-1-hechaol@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-23_10:2019-12-23,2019-12-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=905 mlxscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 suspectscore=13 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912240008
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

v2: Rename check_query_cgroup_progs to cgroup_has_attached_progs

Signed-off-by: Hechao Li <hechaol@fb.com>
---
 tools/bpf/bpftool/cgroup.c | 56 ++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 17 deletions(-)

diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index 1ef45e55039e..2f017caa678d 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -117,6 +117,25 @@ static int count_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type)
 	return prog_cnt;
 }
 
+static int cgroup_has_attached_progs(int cgroup_fd)
+{
+	enum bpf_attach_type type;
+	bool no_prog = true;
+
+	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++) {
+		int count = count_attached_bpf_progs(cgroup_fd, type);
+
+		if (count < 0 && errno != EINVAL)
+			return -1;
+
+		if (count > 0) {
+			no_prog = false;
+			break;
+		}
+	}
+
+	return no_prog ? 0 : 1;
+}
 static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
 				   int level)
 {
@@ -161,6 +180,7 @@ static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
 static int do_show(int argc, char **argv)
 {
 	enum bpf_attach_type type;
+	int has_attached_progs;
 	const char *path;
 	int cgroup_fd;
 	int ret = -1;
@@ -192,6 +212,16 @@ static int do_show(int argc, char **argv)
 		goto exit;
 	}
 
+	has_attached_progs = cgroup_has_attached_progs(cgroup_fd);
+	if (has_attached_progs < 0) {
+		p_err("can't query bpf programs attached to %s: %s",
+		      path, strerror(errno));
+		goto exit_cgroup;
+	} else if (!has_attached_progs) {
+		ret = 0;
+		goto exit_cgroup;
+	}
+
 	if (json_output)
 		jsonw_start_array(json_wtr);
 	else
@@ -212,6 +242,7 @@ static int do_show(int argc, char **argv)
 	if (json_output)
 		jsonw_end_array(json_wtr);
 
+exit_cgroup:
 	close(cgroup_fd);
 exit:
 	return ret;
@@ -228,7 +259,7 @@ static int do_show_tree_fn(const char *fpath, const struct stat *sb,
 			   int typeflag, struct FTW *ftw)
 {
 	enum bpf_attach_type type;
-	bool skip = true;
+	int has_attached_progs;
 	int cgroup_fd;
 
 	if (typeflag != FTW_D)
@@ -240,22 +271,13 @@ static int do_show_tree_fn(const char *fpath, const struct stat *sb,
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
+	has_attached_progs = cgroup_has_attached_progs(cgroup_fd);
+	if (has_attached_progs < 0) {
+		p_err("can't query bpf programs attached to %s: %s",
+		      fpath, strerror(errno));
+		close(cgroup_fd);
+		return SHOW_TREE_FN_ERR;
+	} else if (!has_attached_progs) {
 		close(cgroup_fd);
 		return 0;
 	}
-- 
2.17.1

