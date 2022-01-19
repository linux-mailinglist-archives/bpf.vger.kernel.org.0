Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BB74937E7
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 11:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353426AbiASKDI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 05:03:08 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56684 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353174AbiASKDI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Jan 2022 05:03:08 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20J1dlhT009429
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 02:03:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=UyWfNS/DxHG2D69G7IjYu9983TjqHywHEKGuGZAbQT4=;
 b=gyr09ph0Cl/4MG+M75QMRuR8icQcqYmGUJ8nnLkNVi+vv7H9ufmYxt0kFHbpSfHvWPtB
 P7ssphJn0PhpBp2KM1fhIyfLDOq9pssWv8RQVy+u7vl6MUKu4/U4ss/OzLrXOM9HwIx9
 LzeJYEg/vOWrC1IFYnxs4sWcVcHK1BMPXEc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dnw1gq34x-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 02:03:07 -0800
Received: from twshared7460.02.ash7.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 19 Jan 2022 02:03:04 -0800
Received: by devvm1709.lla0.facebook.com (Postfix, from userid 398628)
        id A09D346F71A6; Wed, 19 Jan 2022 02:03:00 -0800 (PST)
From:   Raman Shukhau <ramasha@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Raman Shukhau <ramasha@fb.com>
Subject: [PATCH bpf-next v2] bpftool: adding support for BTF program names
Date:   Wed, 19 Jan 2022 02:02:55 -0800
Message-ID: <20220119100255.1068997-1-ramasha@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: lBf5PPn6c4cSQrSlEgEoAm4Bjc_QdT1X
X-Proofpoint-ORIG-GUID: lBf5PPn6c4cSQrSlEgEoAm4Bjc_QdT1X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_06,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0 malwarescore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190055
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

`bpftool prog list` and other bpftool subcommands that show
BPF program names currently get them from bpf_prog_info.name.
That field is limited to 16 (BPF_OBJ_NAME_LEN) chars which leads
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

Note, other commands that print prog names (e.g. "bpftool
cgroup tree") are also addressed in this change.

Signed-off-by: Raman Shukhau <ramasha@fb.com>
---
 tools/bpf/bpftool/cgroup.c |  6 ++++--
 tools/bpf/bpftool/common.c | 44 ++++++++++++++++++++++++++++++++++++++
 tools/bpf/bpftool/main.h   |  4 ++++
 tools/bpf/bpftool/prog.c   | 28 +++++++++++++++---------
 4 files changed, 70 insertions(+), 12 deletions(-)

diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index 3571a281c43f..effe136119d7 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -50,6 +50,7 @@ static int show_bpf_prog(int id, enum bpf_attach_type a=
ttach_type,
 			 const char *attach_flags_str,
 			 int level)
 {
+	char prog_name[MAX_PROG_FULL_NAME];
 	struct bpf_prog_info info =3D {};
 	__u32 info_len =3D sizeof(info);
 	int prog_fd;
@@ -63,6 +64,7 @@ static int show_bpf_prog(int id, enum bpf_attach_type a=
ttach_type,
 		return -1;
 	}
=20
+	get_prog_full_name(&info, prog_fd, prog_name, sizeof(prog_name));
 	if (json_output) {
 		jsonw_start_object(json_wtr);
 		jsonw_uint_field(json_wtr, "id", info.id);
@@ -73,7 +75,7 @@ static int show_bpf_prog(int id, enum bpf_attach_type a=
ttach_type,
 			jsonw_uint_field(json_wtr, "attach_type", attach_type);
 		jsonw_string_field(json_wtr, "attach_flags",
 				   attach_flags_str);
-		jsonw_string_field(json_wtr, "name", info.name);
+		jsonw_string_field(json_wtr, "name", prog_name);
 		jsonw_end_object(json_wtr);
 	} else {
 		printf("%s%-8u ", level ? "    " : "", info.id);
@@ -81,7 +83,7 @@ static int show_bpf_prog(int id, enum bpf_attach_type a=
ttach_type,
 			printf("%-15s", attach_type_name[attach_type]);
 		else
 			printf("type %-10u", attach_type);
-		printf(" %-15s %-15s\n", attach_flags_str, info.name);
+		printf(" %-15s %-15s\n", attach_flags_str, prog_name);
 	}
=20
 	close(prog_fd);
diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index fa8eb8134344..111dff809c7b 100644
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
@@ -304,6 +305,49 @@ const char *get_fd_type_name(enum bpf_obj_type type)
 	return names[type];
 }
=20
+void get_prog_full_name(const struct bpf_prog_info *prog_info, int prog_=
fd,
+			char *name_buff, size_t buff_len)
+{
+	const char *prog_name =3D prog_info->name;
+	const struct btf_type *func_type;
+	const struct bpf_func_info finfo;
+	struct bpf_prog_info info =3D {};
+	__u32 info_len =3D sizeof(info);
+	struct btf *prog_btf =3D NULL;
+
+	if (buff_len <=3D BPF_OBJ_NAME_LEN ||
+	    strlen(prog_info->name) < BPF_OBJ_NAME_LEN - 1)
+		goto copy_name;
+
+	if (!prog_info->btf_id || prog_info->nr_func_info =3D=3D 0)
+		goto copy_name;
+
+	info.nr_func_info =3D 1;
+	info.func_info_rec_size =3D prog_info->func_info_rec_size;
+	if (info.func_info_rec_size > sizeof(finfo))
+		info.func_info_rec_size =3D sizeof(finfo);
+	info.func_info =3D ptr_to_u64(&finfo);
+
+	if (bpf_obj_get_info_by_fd(prog_fd, &info, &info_len))
+		goto copy_name;
+
+	prog_btf =3D btf__load_from_kernel_by_id(info.btf_id);
+	if (!prog_btf)
+		goto copy_name;
+
+	func_type =3D btf__type_by_id(prog_btf, finfo.type_id);
+	if (!func_type || !btf_is_func(func_type))
+		goto copy_name;
+
+	prog_name =3D btf__name_by_offset(prog_btf, func_type->name_off);
+
+copy_name:
+	snprintf(name_buff, buff_len, "%s", prog_name);
+
+	if (prog_btf)
+		btf__free(prog_btf);
+}
+
 int get_fd_type(int fd)
 {
 	char path[PATH_MAX];
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 8d76d937a62b..0c3840596b5a 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -140,6 +140,10 @@ struct cmd {
 int cmd_select(const struct cmd *cmds, int argc, char **argv,
 	       int (*help)(int argc, char **argv));
=20
+#define MAX_PROG_FULL_NAME 128
+void get_prog_full_name(const struct bpf_prog_info *prog_info, int prog_=
fd,
+			char *name_buff, size_t buff_len);
+
 int get_fd_type(int fd);
 const char *get_fd_type_name(enum bpf_obj_type type);
 char *get_fdinfo(int fd, const char *key);
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 33ca834d5f51..cf935c63e6f5 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -424,8 +424,10 @@ static void show_prog_metadata(int fd, __u32 num_map=
s)
 	free(value);
 }
=20
-static void print_prog_header_json(struct bpf_prog_info *info)
+static void print_prog_header_json(struct bpf_prog_info *info, int fd)
 {
+	char prog_name[MAX_PROG_FULL_NAME];
+
 	jsonw_uint_field(json_wtr, "id", info->id);
 	if (info->type < ARRAY_SIZE(prog_type_name))
 		jsonw_string_field(json_wtr, "type",
@@ -433,8 +435,10 @@ static void print_prog_header_json(struct bpf_prog_i=
nfo *info)
 	else
 		jsonw_uint_field(json_wtr, "type", info->type);
=20
-	if (*info->name)
-		jsonw_string_field(json_wtr, "name", info->name);
+	if (*info->name) {
+		get_prog_full_name(info, fd, prog_name, sizeof(prog_name));
+		jsonw_string_field(json_wtr, "name", prog_name);
+	}
=20
 	jsonw_name(json_wtr, "tag");
 	jsonw_printf(json_wtr, "\"" BPF_TAG_FMT "\"",
@@ -455,7 +459,7 @@ static void print_prog_json(struct bpf_prog_info *inf=
o, int fd)
 	char *memlock;
=20
 	jsonw_start_object(json_wtr);
-	print_prog_header_json(info);
+	print_prog_header_json(info, fd);
 	print_dev_json(info->ifindex, info->netns_dev, info->netns_ino);
=20
 	if (info->load_time) {
@@ -507,16 +511,20 @@ static void print_prog_json(struct bpf_prog_info *i=
nfo, int fd)
 	jsonw_end_object(json_wtr);
 }
=20
-static void print_prog_header_plain(struct bpf_prog_info *info)
+static void print_prog_header_plain(struct bpf_prog_info *info, int fd)
 {
+	char prog_name[MAX_PROG_FULL_NAME];
+
 	printf("%u: ", info->id);
 	if (info->type < ARRAY_SIZE(prog_type_name))
 		printf("%s  ", prog_type_name[info->type]);
 	else
 		printf("type %u  ", info->type);
=20
-	if (*info->name)
-		printf("name %s  ", info->name);
+	if (*info->name) {
+		get_prog_full_name(info, fd, prog_name, sizeof(prog_name));
+		printf("name %s  ", prog_name);
+	}
=20
 	printf("tag ");
 	fprint_hex(stdout, info->tag, BPF_TAG_SIZE, "");
@@ -534,7 +542,7 @@ static void print_prog_plain(struct bpf_prog_info *in=
fo, int fd)
 {
 	char *memlock;
=20
-	print_prog_header_plain(info);
+	print_prog_header_plain(info, fd);
=20
 	if (info->load_time) {
 		char buf[32];
@@ -972,10 +980,10 @@ static int do_dump(int argc, char **argv)
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

