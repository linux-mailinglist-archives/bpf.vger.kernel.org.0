Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E129A492FDD
	for <lists+bpf@lfdr.de>; Tue, 18 Jan 2022 22:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349467AbiARVC5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Jan 2022 16:02:57 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33902 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1349481AbiARVCy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 18 Jan 2022 16:02:54 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 20IILQsg029632
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 13:02:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=5MwLwTI8GSBK+rtjls4FZ30bKQDm8Z66t9v3QREQ7Xs=;
 b=AssWL2BSXUSA4gvsCRuFx1GvRm30V2UexshrLGzEm5hyzCVH5cxI2YWPNi67SrFqwyAm
 hfSSplz8WTitR+E7QZoe3mQFJveEQo0FdhEm8EjCM463yoC1l+oNaifMfa5EQoPLcnLf
 aZy7xiLhlUnW08TVFvfbHC1IMH7po2G10uY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3dnh93xg34-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 18 Jan 2022 13:02:52 -0800
Received: from twshared3115.02.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 18 Jan 2022 13:02:51 -0800
Received: by devvm1709.lla0.facebook.com (Postfix, from userid 398628)
        id 7D59846A2265; Tue, 18 Jan 2022 13:02:40 -0800 (PST)
From:   Raman Shukhau <ramasha@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Raman Shukhau <ramasha@fb.com>
Subject: [PATCH bpf-next v1] bpftool: adding support for BTF program names
Date:   Tue, 18 Jan 2022 13:02:06 -0800
Message-ID: <20220118210206.4166763-1-ramasha@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: xlRceh3kTScEWMElJLzvO26zWAPuPl6G
X-Proofpoint-ORIG-GUID: xlRceh3kTScEWMElJLzvO26zWAPuPl6G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-18_05,2022-01-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1011
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

`bpftool prog list` and other bpftool subcommands that show
BPF program names currently get them from bpf_prog_info.name.
That field is limited by 16 (BPF_OBJ_NAME_LEN) chars what leads
to truncated names since many progs have much longer names.

The idea of this change is to improve all bpftool commands that
output prog name so that bpftool uses info from BTF to print
program names if available.

It tries bpf_prog_info.name first and fall back to btf only if
the name is suspected to be truncated (has 15 chars length).

Right now `bpftool p show id <id>` returns capped prog name

<id>: kprobe  name example_cap_cap  tag 712e...
...

With this change it would return

<id>: kprobe  name example_cap_capable  tag 712e...
...

Note, other commands that prints prog names (e.g. "bpftool
cgroup tree") are also addressed in this change.

Signed-off-by: Raman Shukhau <ramasha@fb.com>
---
 tools/bpf/bpftool/cgroup.c |  6 ++++--
 tools/bpf/bpftool/common.c | 34 ++++++++++++++++++++++++++++++++++
 tools/bpf/bpftool/main.h   |  2 ++
 tools/bpf/bpftool/prog.c   | 17 +++++++++--------
 4 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index 3571a281c43f..5e098d9772ae 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -73,7 +73,8 @@ static int show_bpf_prog(int id, enum bpf_attach_type a=
ttach_type,
 			jsonw_uint_field(json_wtr, "attach_type", attach_type);
 		jsonw_string_field(json_wtr, "attach_flags",
 				   attach_flags_str);
-		jsonw_string_field(json_wtr, "name", info.name);
+		jsonw_string_field(json_wtr, "name",
+				   get_prog_full_name(&info, prog_fd));
 		jsonw_end_object(json_wtr);
 	} else {
 		printf("%s%-8u ", level ? "    " : "", info.id);
@@ -81,7 +82,8 @@ static int show_bpf_prog(int id, enum bpf_attach_type a=
ttach_type,
 			printf("%-15s", attach_type_name[attach_type]);
 		else
 			printf("type %-10u", attach_type);
-		printf(" %-15s %-15s\n", attach_flags_str, info.name);
+		printf(" %-15s %-15s\n", attach_flags_str,
+		       get_prog_full_name(&info, prog_fd));
 	}
=20
 	close(prog_fd);
diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index fa8eb8134344..b94d0020e4b4 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -24,6 +24,7 @@
 #include <bpf/bpf.h>
 #include <bpf/hashmap.h>
 #include <bpf/libbpf.h> /* libbpf_num_possible_cpus */
+#include <bpf/btf.h>
=20
 #include "main.h"
=20
@@ -304,6 +305,39 @@ const char *get_fd_type_name(enum bpf_obj_type type)
 	return names[type];
 }
=20
+const char *get_prog_full_name(const struct bpf_prog_info *prog_info,
+			       int prog_fd)
+{
+	const struct btf_type *func_type;
+	const struct bpf_func_info finfo;
+	struct bpf_prog_info info =3D {};
+	__u32 info_len =3D sizeof(info);
+	const struct btf *prog_btf;
+
+	if (strlen(prog_info->name) < BPF_OBJ_NAME_LEN - 1)
+		return prog_info->name;
+
+	if (!prog_info->btf_id || prog_info->nr_func_info =3D=3D 0)
+		return prog_info->name;
+
+	info.nr_func_info =3D 1;
+	info.func_info_rec_size =3D prog_info->func_info_rec_size;
+	info.func_info =3D ptr_to_u64(&finfo);
+
+	if (bpf_obj_get_info_by_fd(prog_fd, &info, &info_len))
+		return prog_info->name;
+
+	prog_btf =3D btf__load_from_kernel_by_id(info.btf_id);
+	if (libbpf_get_error(prog_btf))
+		return prog_info->name;
+
+	func_type =3D btf__type_by_id(prog_btf, finfo.type_id);
+	if (!func_type || !btf_is_func(func_type))
+		return prog_info->name;
+
+	return btf__name_by_offset(prog_btf, func_type->name_off);
+}
+
 int get_fd_type(int fd)
 {
 	char path[PATH_MAX];
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 8d76d937a62b..cbd03cc821b7 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -142,6 +142,8 @@ int cmd_select(const struct cmd *cmds, int argc, char=
 **argv,
=20
 int get_fd_type(int fd);
 const char *get_fd_type_name(enum bpf_obj_type type);
+const char *get_prog_full_name(const struct bpf_prog_info *prog_info,
+			       int prog_fd);
 char *get_fdinfo(int fd, const char *key);
 int open_obj_pinned(const char *path, bool quiet);
 int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type);
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 33ca834d5f51..e54d97ee998c 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -424,7 +424,7 @@ static void show_prog_metadata(int fd, __u32 num_maps=
)
 	free(value);
 }
=20
-static void print_prog_header_json(struct bpf_prog_info *info)
+static void print_prog_header_json(struct bpf_prog_info *info, int fd)
 {
 	jsonw_uint_field(json_wtr, "id", info->id);
 	if (info->type < ARRAY_SIZE(prog_type_name))
@@ -434,7 +434,8 @@ static void print_prog_header_json(struct bpf_prog_in=
fo *info)
 		jsonw_uint_field(json_wtr, "type", info->type);
=20
 	if (*info->name)
-		jsonw_string_field(json_wtr, "name", info->name);
+		jsonw_string_field(json_wtr, "name",
+				   get_prog_full_name(info, fd));
=20
 	jsonw_name(json_wtr, "tag");
 	jsonw_printf(json_wtr, "\"" BPF_TAG_FMT "\"",
@@ -455,7 +456,7 @@ static void print_prog_json(struct bpf_prog_info *inf=
o, int fd)
 	char *memlock;
=20
 	jsonw_start_object(json_wtr);
-	print_prog_header_json(info);
+	print_prog_header_json(info, fd);
 	print_dev_json(info->ifindex, info->netns_dev, info->netns_ino);
=20
 	if (info->load_time) {
@@ -507,7 +508,7 @@ static void print_prog_json(struct bpf_prog_info *inf=
o, int fd)
 	jsonw_end_object(json_wtr);
 }
=20
-static void print_prog_header_plain(struct bpf_prog_info *info)
+static void print_prog_header_plain(struct bpf_prog_info *info, int fd)
 {
 	printf("%u: ", info->id);
 	if (info->type < ARRAY_SIZE(prog_type_name))
@@ -516,7 +517,7 @@ static void print_prog_header_plain(struct bpf_prog_i=
nfo *info)
 		printf("type %u  ", info->type);
=20
 	if (*info->name)
-		printf("name %s  ", info->name);
+		printf("name %s  ", get_prog_full_name(info, fd));
=20
 	printf("tag ");
 	fprint_hex(stdout, info->tag, BPF_TAG_SIZE, "");
@@ -534,7 +535,7 @@ static void print_prog_plain(struct bpf_prog_info *in=
fo, int fd)
 {
 	char *memlock;
=20
-	print_prog_header_plain(info);
+	print_prog_header_plain(info, fd);
=20
 	if (info->load_time) {
 		char buf[32];
@@ -972,10 +973,10 @@ static int do_dump(int argc, char **argv)
=20
 		if (json_output && nb_fds > 1) {
 			jsonw_start_object(json_wtr);	/* prog object */
-			print_prog_header_json(&info);
+			print_prog_header_json(&info, fds[i]);
 			jsonw_name(json_wtr, "insns");
 		} else if (nb_fds > 1) {
-			print_prog_header_plain(&info);
+			print_prog_header_plain(&info, fds[i]);
 		}
=20
 		err =3D prog_dump(&info, mode, filepath, opcodes, visual, linum);
--=20
2.30.2

