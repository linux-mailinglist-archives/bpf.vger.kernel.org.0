Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBE3697198
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 00:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjBNXM4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 18:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbjBNXMx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 18:12:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6368130F4
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 15:12:50 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EMiEug028183;
        Tue, 14 Feb 2023 23:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Z1vwq9xyomRMupCJJ4wVUTjfUj1eR9Ypp3M3RwxV4aQ=;
 b=tE6vOqwX7VmO0RKcYc0fLIuCha2jw0QnFXsLzLqOj2JWay+ebjMicEU930TmZgtgfUjT
 m9E8g846iB5OesfrBdUfktUxmtPEC2BUUaIg8UXQlAAFA5tCghJIZ1X+1ZFNDTsgn6tn
 YuQ/az5X5bZnjqJ+A1ERgqDuUJlbu8Hbrz6tWFnHM5vYp9DiEHt5rP+NF0cdm68Zh59p
 QqAsExfcIrYkMA5rcFIYok959hignhoxsnZv+x+lufTmAM9Mx5MOaI6X32ee3UGLeDql
 tUhKGAgueOXSxedKYYDAWVUmAfw4KwbH8hkny1z0hzAGm+FONMuWTIOAqC8AjOcEoGMJ LQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nrkbprjbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 23:12:34 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31EK2O7q010915;
        Tue, 14 Feb 2023 23:12:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6vnj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 23:12:31 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31ENCReH20316624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 23:12:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B1352004B;
        Tue, 14 Feb 2023 23:12:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 056A220040;
        Tue, 14 Feb 2023 23:12:27 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.53.135])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Feb 2023 23:12:26 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 3/8] bpftool: Use bpf_{btf,link,map,prog}_get_info_by_fd()
Date:   Wed, 15 Feb 2023 00:12:16 +0100
Message-Id: <20230214231221.249277-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214231221.249277-1-iii@linux.ibm.com>
References: <20230214231221.249277-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L_WRIgYIxkZLSFvk5K3RKDVAhRfWYUBx
X-Proofpoint-ORIG-GUID: L_WRIgYIxkZLSFvk5K3RKDVAhRfWYUBx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 impostorscore=0 spamscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140198
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use the new type-safe wrappers around bpf_obj_get_info_by_fd().

Split the bpf_obj_get_info_by_fd() call in build_btf_type_table() in
two, since knowing the type helps with the Memory Sanitizer.

Improve map_parse_fd_and_info() type safety by using
struct bpf_map_info * instead of void * for info.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/bpf/bpftool/btf.c        | 13 ++++++++-----
 tools/bpf/bpftool/btf_dumper.c |  4 ++--
 tools/bpf/bpftool/cgroup.c     |  4 ++--
 tools/bpf/bpftool/common.c     | 13 +++++++------
 tools/bpf/bpftool/link.c       |  4 ++--
 tools/bpf/bpftool/main.h       |  3 ++-
 tools/bpf/bpftool/map.c        |  8 ++++----
 tools/bpf/bpftool/prog.c       | 22 +++++++++++-----------
 tools/bpf/bpftool/struct_ops.c |  6 +++---
 9 files changed, 41 insertions(+), 36 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 352290ba7b29..91fcb75babe3 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -537,7 +537,7 @@ static bool btf_is_kernel_module(__u32 btf_id)
 	len = sizeof(btf_info);
 	btf_info.name = ptr_to_u64(btf_name);
 	btf_info.name_len = sizeof(btf_name);
-	err = bpf_obj_get_info_by_fd(btf_fd, &btf_info, &len);
+	err = bpf_btf_get_info_by_fd(btf_fd, &btf_info, &len);
 	close(btf_fd);
 	if (err) {
 		p_err("can't get BTF (ID %u) object info: %s", btf_id, strerror(errno));
@@ -606,7 +606,7 @@ static int do_dump(int argc, char **argv)
 		if (fd < 0)
 			return -1;
 
-		err = bpf_obj_get_info_by_fd(fd, &info, &len);
+		err = bpf_prog_get_info_by_fd(fd, &info, &len);
 		if (err) {
 			p_err("can't get prog info: %s", strerror(errno));
 			goto done;
@@ -789,7 +789,10 @@ build_btf_type_table(struct hashmap *tab, enum bpf_obj_type type,
 		}
 
 		memset(info, 0, *len);
-		err = bpf_obj_get_info_by_fd(fd, info, len);
+		if (type == BPF_OBJ_PROG)
+			err = bpf_prog_get_info_by_fd(fd, info, len);
+		else
+			err = bpf_map_get_info_by_fd(fd, info, len);
 		close(fd);
 		if (err) {
 			p_err("can't get %s info: %s", names[type],
@@ -931,7 +934,7 @@ show_btf(int fd, struct hashmap *btf_prog_table,
 	int err;
 
 	memset(&info, 0, sizeof(info));
-	err = bpf_obj_get_info_by_fd(fd, &info, &len);
+	err = bpf_btf_get_info_by_fd(fd, &info, &len);
 	if (err) {
 		p_err("can't get BTF object info: %s", strerror(errno));
 		return -1;
@@ -943,7 +946,7 @@ show_btf(int fd, struct hashmap *btf_prog_table,
 		info.name = ptr_to_u64(name);
 		len = sizeof(info);
 
-		err = bpf_obj_get_info_by_fd(fd, &info, &len);
+		err = bpf_btf_get_info_by_fd(fd, &info, &len);
 		if (err) {
 			p_err("can't get BTF object info: %s", strerror(errno));
 			return -1;
diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index eda71fdfe95a..e7f6ec3a8f35 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -57,7 +57,7 @@ static int dump_prog_id_as_func_ptr(const struct btf_dumper *d,
 	if (prog_fd < 0)
 		goto print;
 
-	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
 	if (err)
 		goto print;
 
@@ -70,7 +70,7 @@ static int dump_prog_id_as_func_ptr(const struct btf_dumper *d,
 	info.func_info_rec_size = finfo_rec_size;
 	info.func_info = ptr_to_u64(&finfo);
 
-	err = bpf_obj_get_info_by_fd(prog_fd, &info, &info_len);
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
 	if (err)
 		goto print;
 
diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index b46a998d8f8d..ac846b0805b4 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -82,7 +82,7 @@ static void guess_vmlinux_btf_id(__u32 attach_btf_obj_id)
 	if (fd < 0)
 		return;
 
-	err = bpf_obj_get_info_by_fd(fd, &btf_info, &btf_len);
+	err = bpf_btf_get_info_by_fd(fd, &btf_info, &btf_len);
 	if (err)
 		goto out;
 
@@ -108,7 +108,7 @@ static int show_bpf_prog(int id, enum bpf_attach_type attach_type,
 	if (prog_fd < 0)
 		return -1;
 
-	if (bpf_obj_get_info_by_fd(prog_fd, &info, &info_len)) {
+	if (bpf_prog_get_info_by_fd(prog_fd, &info, &info_len)) {
 		close(prog_fd);
 		return -1;
 	}
diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 620032042576..5a73ccf14332 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -353,7 +353,7 @@ void get_prog_full_name(const struct bpf_prog_info *prog_info, int prog_fd,
 		info.func_info_rec_size = sizeof(finfo);
 	info.func_info = ptr_to_u64(&finfo);
 
-	if (bpf_obj_get_info_by_fd(prog_fd, &info, &info_len))
+	if (bpf_prog_get_info_by_fd(prog_fd, &info, &info_len))
 		goto copy_name;
 
 	prog_btf = btf__load_from_kernel_by_id(info.btf_id);
@@ -488,7 +488,7 @@ static int do_build_table_cb(const char *fpath, const struct stat *sb,
 		goto out_close;
 
 	memset(&pinned_info, 0, sizeof(pinned_info));
-	if (bpf_obj_get_info_by_fd(fd, &pinned_info, &len))
+	if (bpf_prog_get_info_by_fd(fd, &pinned_info, &len))
 		goto out_close;
 
 	path = strdup(fpath);
@@ -756,7 +756,7 @@ static int prog_fd_by_nametag(void *nametag, int **fds, bool tag)
 			goto err_close_fds;
 		}
 
-		err = bpf_obj_get_info_by_fd(fd, &info, &len);
+		err = bpf_prog_get_info_by_fd(fd, &info, &len);
 		if (err) {
 			p_err("can't get prog info (%u): %s",
 			      id, strerror(errno));
@@ -916,7 +916,7 @@ static int map_fd_by_name(char *name, int **fds)
 			goto err_close_fds;
 		}
 
-		err = bpf_obj_get_info_by_fd(fd, &info, &len);
+		err = bpf_map_get_info_by_fd(fd, &info, &len);
 		if (err) {
 			p_err("can't get map info (%u): %s",
 			      id, strerror(errno));
@@ -1026,7 +1026,8 @@ int map_parse_fd(int *argc, char ***argv)
 	return fd;
 }
 
-int map_parse_fd_and_info(int *argc, char ***argv, void *info, __u32 *info_len)
+int map_parse_fd_and_info(int *argc, char ***argv, struct bpf_map_info *info,
+			  __u32 *info_len)
 {
 	int err;
 	int fd;
@@ -1035,7 +1036,7 @@ int map_parse_fd_and_info(int *argc, char ***argv, void *info, __u32 *info_len)
 	if (fd < 0)
 		return -1;
 
-	err = bpf_obj_get_info_by_fd(fd, info, info_len);
+	err = bpf_map_get_info_by_fd(fd, info, info_len);
 	if (err) {
 		p_err("can't get map info: %s", strerror(errno));
 		close(fd);
diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 6f4cfe01cad4..f985b79cca27 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -145,7 +145,7 @@ static int get_prog_info(int prog_id, struct bpf_prog_info *info)
 		return prog_fd;
 
 	memset(info, 0, sizeof(*info));
-	err = bpf_obj_get_info_by_fd(prog_fd, info, &len);
+	err = bpf_prog_get_info_by_fd(prog_fd, info, &len);
 	if (err)
 		p_err("can't get prog info: %s", strerror(errno));
 	close(prog_fd);
@@ -327,7 +327,7 @@ static int do_show_link(int fd)
 
 	memset(&info, 0, sizeof(info));
 again:
-	err = bpf_obj_get_info_by_fd(fd, &info, &len);
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
 	if (err) {
 		p_err("can't get link info: %s",
 		      strerror(errno));
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index a84224b6a604..0ef373cef4c7 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -168,7 +168,8 @@ int prog_parse_fd(int *argc, char ***argv);
 int prog_parse_fds(int *argc, char ***argv, int **fds);
 int map_parse_fd(int *argc, char ***argv);
 int map_parse_fds(int *argc, char ***argv, int **fds);
-int map_parse_fd_and_info(int *argc, char ***argv, void *info, __u32 *info_len);
+int map_parse_fd_and_info(int *argc, char ***argv, struct bpf_map_info *info,
+			  __u32 *info_len);
 
 struct bpf_prog_linfo;
 #if defined(HAVE_LLVM_SUPPORT) || defined(HAVE_LIBBFD_SUPPORT)
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 88911d3aa2d9..aaeb8939e137 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -638,7 +638,7 @@ static int do_show_subset(int argc, char **argv)
 	if (json_output && nb_fds > 1)
 		jsonw_start_array(json_wtr);	/* root array */
 	for (i = 0; i < nb_fds; i++) {
-		err = bpf_obj_get_info_by_fd(fds[i], &info, &len);
+		err = bpf_map_get_info_by_fd(fds[i], &info, &len);
 		if (err) {
 			p_err("can't get map info: %s",
 			      strerror(errno));
@@ -708,7 +708,7 @@ static int do_show(int argc, char **argv)
 			break;
 		}
 
-		err = bpf_obj_get_info_by_fd(fd, &info, &len);
+		err = bpf_map_get_info_by_fd(fd, &info, &len);
 		if (err) {
 			p_err("can't get map info: %s", strerror(errno));
 			close(fd);
@@ -764,7 +764,7 @@ static int maps_have_btf(int *fds, int nb_fds)
 	int err, i;
 
 	for (i = 0; i < nb_fds; i++) {
-		err = bpf_obj_get_info_by_fd(fds[i], &info, &len);
+		err = bpf_map_get_info_by_fd(fds[i], &info, &len);
 		if (err) {
 			p_err("can't get map info: %s", strerror(errno));
 			return -1;
@@ -925,7 +925,7 @@ static int do_dump(int argc, char **argv)
 	if (wtr && nb_fds > 1)
 		jsonw_start_array(wtr);	/* root array */
 	for (i = 0; i < nb_fds; i++) {
-		if (bpf_obj_get_info_by_fd(fds[i], &info, &len)) {
+		if (bpf_map_get_info_by_fd(fds[i], &info, &len)) {
 			p_err("can't get map info: %s", strerror(errno));
 			break;
 		}
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index e87738dbffc1..afbe3ec342c8 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -198,7 +198,7 @@ static void show_prog_maps(int fd, __u32 num_maps)
 	info.nr_map_ids = num_maps;
 	info.map_ids = ptr_to_u64(map_ids);
 
-	err = bpf_obj_get_info_by_fd(fd, &info, &len);
+	err = bpf_prog_get_info_by_fd(fd, &info, &len);
 	if (err || !info.nr_map_ids)
 		return;
 
@@ -231,7 +231,7 @@ static void *find_metadata(int prog_fd, struct bpf_map_info *map_info)
 
 	memset(&prog_info, 0, sizeof(prog_info));
 	prog_info_len = sizeof(prog_info);
-	ret = bpf_obj_get_info_by_fd(prog_fd, &prog_info, &prog_info_len);
+	ret = bpf_prog_get_info_by_fd(prog_fd, &prog_info, &prog_info_len);
 	if (ret)
 		return NULL;
 
@@ -248,7 +248,7 @@ static void *find_metadata(int prog_fd, struct bpf_map_info *map_info)
 	prog_info.map_ids = ptr_to_u64(map_ids);
 	prog_info_len = sizeof(prog_info);
 
-	ret = bpf_obj_get_info_by_fd(prog_fd, &prog_info, &prog_info_len);
+	ret = bpf_prog_get_info_by_fd(prog_fd, &prog_info, &prog_info_len);
 	if (ret)
 		goto free_map_ids;
 
@@ -259,7 +259,7 @@ static void *find_metadata(int prog_fd, struct bpf_map_info *map_info)
 
 		memset(map_info, 0, sizeof(*map_info));
 		map_info_len = sizeof(*map_info);
-		ret = bpf_obj_get_info_by_fd(map_fd, map_info, &map_info_len);
+		ret = bpf_map_get_info_by_fd(map_fd, map_info, &map_info_len);
 		if (ret < 0) {
 			close(map_fd);
 			goto free_map_ids;
@@ -580,7 +580,7 @@ static int show_prog(int fd)
 	__u32 len = sizeof(info);
 	int err;
 
-	err = bpf_obj_get_info_by_fd(fd, &info, &len);
+	err = bpf_prog_get_info_by_fd(fd, &info, &len);
 	if (err) {
 		p_err("can't get prog info: %s", strerror(errno));
 		return -1;
@@ -949,7 +949,7 @@ static int do_dump(int argc, char **argv)
 	for (i = 0; i < nb_fds; i++) {
 		memset(&info, 0, sizeof(info));
 
-		err = bpf_obj_get_info_by_fd(fds[i], &info, &info_len);
+		err = bpf_prog_get_info_by_fd(fds[i], &info, &info_len);
 		if (err) {
 			p_err("can't get prog info: %s", strerror(errno));
 			break;
@@ -961,7 +961,7 @@ static int do_dump(int argc, char **argv)
 			break;
 		}
 
-		err = bpf_obj_get_info_by_fd(fds[i], &info, &info_len);
+		err = bpf_prog_get_info_by_fd(fds[i], &info, &info_len);
 		if (err) {
 			p_err("can't get prog info: %s", strerror(errno));
 			break;
@@ -2170,9 +2170,9 @@ static char *profile_target_name(int tgt_fd)
 	char *name = NULL;
 	int err;
 
-	err = bpf_obj_get_info_by_fd(tgt_fd, &info, &info_len);
+	err = bpf_prog_get_info_by_fd(tgt_fd, &info, &info_len);
 	if (err) {
-		p_err("failed to bpf_obj_get_info_by_fd for prog FD %d", tgt_fd);
+		p_err("failed to get info for prog FD %d", tgt_fd);
 		goto out;
 	}
 
@@ -2183,7 +2183,7 @@ static char *profile_target_name(int tgt_fd)
 
 	func_info_rec_size = info.func_info_rec_size;
 	if (info.nr_func_info == 0) {
-		p_err("bpf_obj_get_info_by_fd for prog FD %d found 0 func_info", tgt_fd);
+		p_err("found 0 func_info for prog FD %d", tgt_fd);
 		goto out;
 	}
 
@@ -2192,7 +2192,7 @@ static char *profile_target_name(int tgt_fd)
 	info.func_info_rec_size = func_info_rec_size;
 	info.func_info = ptr_to_u64(&func_info);
 
-	err = bpf_obj_get_info_by_fd(tgt_fd, &info, &info_len);
+	err = bpf_prog_get_info_by_fd(tgt_fd, &info, &info_len);
 	if (err) {
 		p_err("failed to get func_info for prog FD %d", tgt_fd);
 		goto out;
diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.c
index 903b80ff4e9a..b389f4830e11 100644
--- a/tools/bpf/bpftool/struct_ops.c
+++ b/tools/bpf/bpftool/struct_ops.c
@@ -151,7 +151,7 @@ static int get_next_struct_ops_map(const char *name, int *res_fd,
 			return -1;
 		}
 
-		err = bpf_obj_get_info_by_fd(fd, info, &info_len);
+		err = bpf_map_get_info_by_fd(fd, info, &info_len);
 		if (err) {
 			p_err("can't get map info: %s", strerror(errno));
 			close(fd);
@@ -262,7 +262,7 @@ static struct res do_one_id(const char *id_str, work_func func, void *data,
 		goto done;
 	}
 
-	if (bpf_obj_get_info_by_fd(fd, info, &info_len)) {
+	if (bpf_map_get_info_by_fd(fd, info, &info_len)) {
 		p_err("can't get map info: %s", strerror(errno));
 		res.nr_errs++;
 		goto done;
@@ -522,7 +522,7 @@ static int do_register(int argc, char **argv)
 		bpf_link__disconnect(link);
 		bpf_link__destroy(link);
 
-		if (!bpf_obj_get_info_by_fd(bpf_map__fd(map), &info,
+		if (!bpf_map_get_info_by_fd(bpf_map__fd(map), &info,
 					    &info_len))
 			p_info("Registered %s %s id %u",
 			       get_kern_struct_ops_name(&info),
-- 
2.39.1

