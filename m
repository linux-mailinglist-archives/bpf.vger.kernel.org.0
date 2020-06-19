Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90173201E91
	for <lists+bpf@lfdr.de>; Sat, 20 Jun 2020 01:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbgFSXUf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jun 2020 19:20:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31578 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730379AbgFSXUe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Jun 2020 19:20:34 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05JNGSkF025808
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 16:20:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=ddut+Y7XhFVX4fc9Pg6f4h797bFljT4X23VtM2gJNhc=;
 b=D9qdmdb0FHWhiYr1uPePbib26sIGQATYaFZmU2ta09POskO/LUpdWHJNu/3SkncmzXoI
 /A9Q4ZJjQcDvmCgfIOoycT9yCC7qHeNmYT0tCvXuaZ0fjrP5hYAAdhyPWvgBqCwL3CVx
 xXmvmKszK71ltS6gMxIn461TEaRBefE3raI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31q661763h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 16:20:32 -0700
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 19 Jun 2020 16:20:31 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 5D28F2EC37CE; Fri, 19 Jun 2020 16:17:24 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Quentin Monnet <quentin@isovalent.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf-next 8/9] tools/bpftool: show info for processes holding BPF map/prog/link/btf FDs
Date:   Fri, 19 Jun 2020 16:17:02 -0700
Message-ID: <20200619231703.738941-9-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200619231703.738941-1-andriin@fb.com>
References: <20200619231703.738941-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_22:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=29
 clxscore=1015 mlxscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 impostorscore=0 malwarescore=0
 cotscore=-2147483648 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006190163
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add bpf_iter-based way to find all the processes that hold open FDs again=
st
BPF object (map, prog, link, btf). bpftool always attempts to discover th=
is,
but will silently give up if kernel doesn't yet support bpf_iter BPF prog=
rams.
Process name and PID are emitted for each process (task group).

Sample output for each of 4 BPF objects:

$ sudo ./bpftool prog show
2694: cgroup_device  tag 8c42dee26e8cd4c2  gpl
        loaded_at 2020-06-16T15:34:32-0700  uid 0
        xlated 648B  jited 409B  memlock 4096B
        pids systemd(1)
2907: cgroup_skb  name egress  tag 9ad187367cf2b9e8  gpl
        loaded_at 2020-06-16T18:06:54-0700  uid 0
        xlated 48B  jited 59B  memlock 4096B  map_ids 2436
        btf_id 1202
        pids test_progs(2238417), test_progs(2238445)

$ sudo ./bpftool map show
2436: array  name test_cgr.bss  flags 0x400
        key 4B  value 8B  max_entries 1  memlock 8192B
        btf_id 1202
        pids test_progs(2238417), test_progs(2238445)
2445: array  name pid_iter.rodata  flags 0x480
        key 4B  value 4B  max_entries 1  memlock 8192B
        btf_id 1214  frozen
        pids bpftool(2239612)

$ sudo ./bpftool link show
61: cgroup  prog 2908
        cgroup_id 375301  attach_type egress
        pids test_progs(2238417), test_progs(2238445)
62: cgroup  prog 2908
        cgroup_id 375344  attach_type egress
        pids test_progs(2238417), test_progs(2238445)

$ sudo ./bpftool btf show
1202: size 1527B  prog_ids 2908,2907  map_ids 2436
        pids test_progs(2238417), test_progs(2238445)
1242: size 34684B
        pids bpftool(2258892)

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/bpf/bpftool/Makefile                |   2 +
 tools/bpf/bpftool/btf.c                   |   6 +
 tools/bpf/bpftool/link.c                  |   7 +
 tools/bpf/bpftool/main.c                  |   1 +
 tools/bpf/bpftool/main.h                  |  27 +++
 tools/bpf/bpftool/map.c                   |   7 +
 tools/bpf/bpftool/pids.c                  | 229 ++++++++++++++++++++++
 tools/bpf/bpftool/prog.c                  |   7 +
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c |  80 ++++++++
 tools/bpf/bpftool/skeleton/pid_iter.h     |  12 ++
 10 files changed, 378 insertions(+)
 create mode 100644 tools/bpf/bpftool/pids.c
 create mode 100644 tools/bpf/bpftool/skeleton/pid_iter.bpf.c
 create mode 100644 tools/bpf/bpftool/skeleton/pid_iter.h

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index bdb6e38c6c5c..06f436e8191a 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -150,6 +150,8 @@ $(OUTPUT)%.skel.h: $(OUTPUT)%.bpf.o $(BPFTOOL_BOOTSTR=
AP)
=20
 $(OUTPUT)prog.o: $(OUTPUT)profiler.skel.h
=20
+$(OUTPUT)pids.o: $(OUTPUT)pid_iter.skel.h
+
 endif
 endif
=20
diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index faac8189b285..fc9bc7a23db6 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -809,6 +809,7 @@ show_btf_plain(struct bpf_btf_info *info, int fd,
 			printf("%s%u", n++ =3D=3D 0 ? "  map_ids " : ",",
 			       obj->obj_id);
 	}
+	emit_obj_refs_plain(&refs_table, info->id, "\n\tpids ");
=20
 	printf("\n");
 }
@@ -841,6 +842,9 @@ show_btf_json(struct bpf_btf_info *info, int fd,
 			jsonw_uint(json_wtr, obj->obj_id);
 	}
 	jsonw_end_array(json_wtr);	/* map_ids */
+
+	emit_obj_refs_json(&refs_table, info->id, json_wtr); /* pids */
+
 	jsonw_end_object(json_wtr);	/* btf object */
 }
=20
@@ -893,6 +897,7 @@ static int do_show(int argc, char **argv)
 			close(fd);
 		return err;
 	}
+	build_obj_refs_table(&refs_table, BPF_OBJ_BTF);
=20
 	if (fd >=3D 0) {
 		err =3D show_btf(fd, &btf_prog_table, &btf_map_table);
@@ -939,6 +944,7 @@ static int do_show(int argc, char **argv)
 exit_free:
 	delete_btf_table(&btf_prog_table);
 	delete_btf_table(&btf_map_table);
+	delete_obj_refs_table(&refs_table);
=20
 	return err;
 }
diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index fca57ee8fafe..7329f3134283 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -143,6 +143,9 @@ static int show_link_close_json(int fd, struct bpf_li=
nk_info *info)
 		}
 		jsonw_end_array(json_wtr);
 	}
+
+	emit_obj_refs_json(&refs_table, info->id, json_wtr);
+
 	jsonw_end_object(json_wtr);
=20
 	return 0;
@@ -212,6 +215,7 @@ static int show_link_close_plain(int fd, struct bpf_l=
ink_info *info)
 				printf("\n\tpinned %s", obj->path);
 		}
 	}
+	emit_obj_refs_plain(&refs_table, info->id, "\n\tpids ");
=20
 	printf("\n");
=20
@@ -257,6 +261,7 @@ static int do_show(int argc, char **argv)
=20
 	if (show_pinned)
 		build_pinned_obj_table(&link_table, BPF_OBJ_LINK);
+	build_obj_refs_table(&refs_table, BPF_OBJ_LINK);
=20
 	if (argc =3D=3D 2) {
 		fd =3D link_parse_fd(&argc, &argv);
@@ -296,6 +301,8 @@ static int do_show(int argc, char **argv)
 	if (json_output)
 		jsonw_end_array(json_wtr);
=20
+	delete_obj_refs_table(&refs_table);
+
 	return errno =3D=3D ENOENT ? 0 : -1;
 }
=20
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index bf4d7487552a..4a191fcbeb82 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -31,6 +31,7 @@ bool relaxed_maps;
 struct pinned_obj_table prog_table;
 struct pinned_obj_table map_table;
 struct pinned_obj_table link_table;
+struct obj_refs_table refs_table;
=20
 static void __noreturn clean_and_exit(int i)
 {
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index aad7be74e8a7..ce26271e5f0c 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -127,11 +127,13 @@ static const char * const attach_type_name[__MAX_BP=
F_ATTACH_TYPE] =3D {
 extern const char * const map_type_name[];
 extern const size_t map_type_name_size;
=20
+/* keep in sync with the definition in skeleton/pid_iter.bpf.c */
 enum bpf_obj_type {
 	BPF_OBJ_UNKNOWN,
 	BPF_OBJ_PROG,
 	BPF_OBJ_MAP,
 	BPF_OBJ_LINK,
+	BPF_OBJ_BTF,
 };
=20
 extern const char *bin_name;
@@ -139,12 +141,14 @@ extern const char *bin_name;
 extern json_writer_t *json_wtr;
 extern bool json_output;
 extern bool show_pinned;
+extern bool show_pids;
 extern bool block_mount;
 extern bool verifier_logs;
 extern bool relaxed_maps;
 extern struct pinned_obj_table prog_table;
 extern struct pinned_obj_table map_table;
 extern struct pinned_obj_table link_table;
+extern struct obj_refs_table refs_table;
=20
 void __printf(1, 2) p_err(const char *fmt, ...);
 void __printf(1, 2) p_info(const char *fmt, ...);
@@ -168,12 +172,35 @@ struct pinned_obj {
 	struct hlist_node hash;
 };
=20
+struct obj_refs_table {
+	DECLARE_HASHTABLE(table, 16);
+};
+
+struct obj_ref {
+	int pid;
+	char comm[16];
+};
+
+struct obj_refs {
+	struct hlist_node node;
+	__u32 id;
+	int ref_cnt;
+	struct obj_ref *refs;
+};
+
 struct btf;
 struct bpf_line_info;
=20
 int build_pinned_obj_table(struct pinned_obj_table *table,
 			   enum bpf_obj_type type);
 void delete_pinned_obj_table(struct pinned_obj_table *tab);
+__weak int build_obj_refs_table(struct obj_refs_table *table,
+				enum bpf_obj_type type);
+__weak void delete_obj_refs_table(struct obj_refs_table *table);
+__weak void emit_obj_refs_json(struct obj_refs_table *table, __u32 id,
+			       json_writer_t *json_wtr);
+__weak void emit_obj_refs_plain(struct obj_refs_table *table, __u32 id,
+				const char *prefix);
 void print_dev_plain(__u32 ifindex, __u64 ns_dev, __u64 ns_inode);
 void print_dev_json(__u32 ifindex, __u64 ns_dev, __u64 ns_inode);
=20
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index b9eee19b094c..0a6a5d82d380 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -509,6 +509,8 @@ static int show_map_close_json(int fd, struct bpf_map=
_info *info)
 		jsonw_end_array(json_wtr);
 	}
=20
+	emit_obj_refs_json(&refs_table, info->id, json_wtr);
+
 	jsonw_end_object(json_wtr);
=20
 	return 0;
@@ -596,6 +598,8 @@ static int show_map_close_plain(int fd, struct bpf_ma=
p_info *info)
 	if (frozen)
 		printf("%sfrozen", info->btf_id ? "  " : "");
=20
+	emit_obj_refs_plain(&refs_table, info->id, "\n\tpids ");
+
 	printf("\n");
 	return 0;
 }
@@ -654,6 +658,7 @@ static int do_show(int argc, char **argv)
=20
 	if (show_pinned)
 		build_pinned_obj_table(&map_table, BPF_OBJ_MAP);
+	build_obj_refs_table(&refs_table, BPF_OBJ_MAP);
=20
 	if (argc =3D=3D 2)
 		return do_show_subset(argc, argv);
@@ -697,6 +702,8 @@ static int do_show(int argc, char **argv)
 	if (json_output)
 		jsonw_end_array(json_wtr);
=20
+	delete_obj_refs_table(&refs_table);
+
 	return errno =3D=3D ENOENT ? 0 : -1;
 }
=20
diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
new file mode 100644
index 000000000000..3474a91743ff
--- /dev/null
+++ b/tools/bpf/bpftool/pids.c
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/* Copyright (C) 2020 Facebook */
+#include <errno.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <bpf/bpf.h>
+
+#include "main.h"
+#include "skeleton/pid_iter.h"
+
+#ifdef BPFTOOL_WITHOUT_SKELETONS
+
+int build_obj_refs_table(struct obj_refs_table *table, enum bpf_obj_type=
 type)
+{
+	p_err("bpftool built without PID iterator support");
+	return -ENOTSUP;
+}
+void delete_obj_refs_table(struct obj_refs_table *table) {}
+
+#else /* BPFTOOL_WITHOUT_SKELETONS */
+
+#include "pid_iter.skel.h"
+
+static void add_ref(struct obj_refs_table *table, struct pid_iter_entry =
*e)
+{
+	struct obj_refs *refs;
+	struct obj_ref *ref;
+	void *tmp;
+	int i;
+
+	hash_for_each_possible(table->table, refs, node, e->id) {
+		if (refs->id !=3D e->id)
+			continue;
+
+		for (i =3D 0; i < refs->ref_cnt; i++) {
+			if (refs->refs[i].pid =3D=3D e->pid)
+				return;
+		}
+
+		tmp =3D realloc(refs->refs, (refs->ref_cnt + 1) * sizeof(*ref));
+		if (!tmp) {
+			p_err("failed to re-alloc memory for ID %u, PID %d, COMM %s...",
+			      e->id, e->pid, e->comm);
+			return;
+		}
+		refs->refs =3D tmp;
+		ref =3D &refs->refs[refs->ref_cnt];
+		ref->pid =3D e->pid;
+		memcpy(ref->comm, e->comm, sizeof(ref->comm));
+		refs->ref_cnt++;
+
+		return;
+	}
+
+	/* new ref */
+	refs =3D calloc(1, sizeof(*refs));
+	if (!refs) {
+		p_err("failed to alloc memory for ID %u, PID %d, COMM %s...",
+		      e->id, e->pid, e->comm);
+		return;
+	}
+
+	refs->id =3D e->id;
+	refs->refs =3D malloc(sizeof(*refs->refs));
+	if (!refs->refs) {
+		free(refs);
+		p_err("failed to alloc memory for ID %u, PID %d, COMM %s...",
+		      e->id, e->pid, e->comm);
+		return;
+	}
+	ref =3D &refs->refs[0];
+	ref->pid =3D e->pid;
+	memcpy(ref->comm, e->comm, sizeof(ref->comm));
+	refs->ref_cnt =3D 1;
+	hash_add(table->table, &refs->node, e->id);
+}
+
+static int __printf(2, 0)
+libbpf_print_none(__maybe_unused enum libbpf_print_level level,
+		  __maybe_unused const char *format,
+		  __maybe_unused va_list args)
+{
+	return 0;
+}
+
+int build_obj_refs_table(struct obj_refs_table *table, enum bpf_obj_type=
 type)
+{
+	char buf[4096];
+	struct pid_iter_bpf *skel;
+	struct pid_iter_entry *e;
+	int err, ret, fd =3D -1, i;
+	libbpf_print_fn_t default_print;
+
+	hash_init(table->table);
+	set_max_rlimit();
+
+	skel =3D pid_iter_bpf__open();
+	if (!skel) {
+		p_err("failed to open PID iterator skeleton");
+		return -1;
+	}
+
+	skel->rodata->obj_type =3D type;
+
+	/* we don't want output polluted with libbpf errors if bpf_iter is not
+	 * supported
+	 */
+	default_print =3D libbpf_set_print(libbpf_print_none);
+	err =3D pid_iter_bpf__load(skel);
+	libbpf_set_print(default_print);
+	if (err) {
+		/* too bad, kernel doesn't support BPF iterators yet */
+		err =3D 0;
+		goto out;
+	}
+	err =3D pid_iter_bpf__attach(skel);
+	if (err) {
+		/* if we loaded above successfully, attach has to succeed */
+		p_err("failed to attach PID iterator: %d", err);
+		goto out;
+	}
+
+	fd =3D bpf_iter_create(bpf_link__fd(skel->links.iter));
+	if (fd < 0) {
+		err =3D -errno;
+		p_err("failed to create PID iterator session: %d", err);
+		goto out;
+	}
+
+	while (true) {
+		ret =3D read(fd, buf, sizeof(buf));
+		if (ret < 0) {
+			err =3D -errno;
+			p_err("failed to read PID iterator output: %d", err);
+			goto out;
+		}
+		if (ret =3D=3D 0)
+			break;
+		if (ret % sizeof(*e)) {
+			err =3D -EINVAL;
+			p_err("invalid PID iterator output format");
+			goto out;
+		}
+		ret /=3D sizeof(*e);
+
+		e =3D (void *)buf;
+		for (i =3D 0; i < ret; i++, e++) {
+			add_ref(table, e);
+		}
+	}
+	err =3D 0;
+out:
+	if (fd >=3D 0)
+		close(fd);
+	pid_iter_bpf__destroy(skel);
+	return err;
+}
+
+void delete_obj_refs_table(struct obj_refs_table *table)
+{
+	struct obj_refs *refs;
+	struct hlist_node *tmp;
+	unsigned int bkt;
+
+	hash_for_each_safe(table->table, bkt, tmp, refs, node) {
+		hash_del(&refs->node);
+		free(refs->refs);
+		free(refs);
+	}
+}
+
+void emit_obj_refs_json(struct obj_refs_table *table, __u32 id, json_wri=
ter_t *json_wtr)
+{
+	struct obj_refs *refs;
+	struct obj_ref *ref;
+	int i;
+
+	if (hash_empty(table->table))
+		return;
+
+	hash_for_each_possible(table->table, refs, node, id) {
+		if (refs->id !=3D id)
+			continue;
+		if (refs->ref_cnt =3D=3D 0)
+			break;
+
+		jsonw_name(json_wtr, "pids");
+		jsonw_start_array(json_wtr);
+		for (i =3D 0; i < refs->ref_cnt; i++) {
+			ref =3D &refs->refs[i];
+			jsonw_start_object(json_wtr);
+			jsonw_int_field(json_wtr, "pid", ref->pid);
+			jsonw_string_field(json_wtr, "comm", ref->comm);
+			jsonw_end_object(json_wtr);
+		}
+		jsonw_end_array(json_wtr);
+		break;
+	}
+}
+
+void emit_obj_refs_plain(struct obj_refs_table *table, __u32 id, const c=
har *prefix)
+{
+	struct obj_refs *refs;
+	struct obj_ref *ref;
+	int i;
+
+	if (hash_empty(table->table))
+		return;
+
+	hash_for_each_possible(table->table, refs, node, id) {
+		if (refs->id !=3D id)
+			continue;
+		if (refs->ref_cnt =3D=3D 0)
+			break;
+
+		printf("%s", prefix);
+		for (i =3D 0; i < refs->ref_cnt; i++) {
+			ref =3D &refs->refs[i];
+			printf("%s%s(%d)", i =3D=3D 0 ? "" : ", ", ref->comm, ref->pid);
+		}
+		break;
+	}
+}
+
+
+#endif
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 53d47610ff58..e21fa8ad2efa 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -190,6 +190,8 @@ static void print_prog_json(struct bpf_prog_info *inf=
o, int fd)
 		jsonw_end_array(json_wtr);
 	}
=20
+	emit_obj_refs_json(&refs_table, info->id, json_wtr);
+
 	jsonw_end_object(json_wtr);
 }
=20
@@ -256,6 +258,8 @@ static void print_prog_plain(struct bpf_prog_info *in=
fo, int fd)
 	if (info->btf_id)
 		printf("\n\tbtf_id %d", info->btf_id);
=20
+	emit_obj_refs_plain(&refs_table, info->id, "\n\tpids ");
+
 	printf("\n");
 }
=20
@@ -321,6 +325,7 @@ static int do_show(int argc, char **argv)
=20
 	if (show_pinned)
 		build_pinned_obj_table(&prog_table, BPF_OBJ_PROG);
+	build_obj_refs_table(&refs_table, BPF_OBJ_PROG);
=20
 	if (argc =3D=3D 2)
 		return do_show_subset(argc, argv);
@@ -362,6 +367,8 @@ static int do_show(int argc, char **argv)
 	if (json_output)
 		jsonw_end_array(json_wtr);
=20
+	delete_obj_refs_table(&refs_table);
+
 	return err;
 }
=20
diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftoo=
l/skeleton/pid_iter.bpf.c
new file mode 100644
index 000000000000..8468a608911e
--- /dev/null
+++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/* Copyright (c) 2020 Facebook */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_tracing.h>
+#include "pid_iter.h"
+
+/* keep in sync with the definition in main.h */
+enum bpf_obj_type {
+	BPF_OBJ_UNKNOWN,
+	BPF_OBJ_PROG,
+	BPF_OBJ_MAP,
+	BPF_OBJ_LINK,
+	BPF_OBJ_BTF,
+};
+
+extern const void bpf_link_fops __ksym;
+extern const void bpf_map_fops __ksym;
+extern const void bpf_prog_fops __ksym;
+extern const void btf_fops __ksym;
+
+const volatile enum bpf_obj_type obj_type =3D BPF_OBJ_UNKNOWN;
+
+static __always_inline __u32 get_obj_id(void *ent, enum bpf_obj_type typ=
e)
+{
+	switch (type) {
+	case BPF_OBJ_PROG:
+		return BPF_CORE_READ((struct bpf_prog *)ent, aux, id);
+	case BPF_OBJ_MAP:
+		return BPF_CORE_READ((struct bpf_map *)ent, id);
+	case BPF_OBJ_BTF:
+		return BPF_CORE_READ((struct btf *)ent, id);
+	case BPF_OBJ_LINK:
+		return BPF_CORE_READ((struct bpf_link *)ent, id);
+	default:
+		return 0;
+	}
+}
+
+SEC("iter/task_file")
+int iter(struct bpf_iter__task_file *ctx)
+{
+	struct file *file =3D ctx->file;
+	struct task_struct *task =3D ctx->task;
+	struct pid_iter_entry e;
+	const void *fops;
+
+	if (!file || !task)
+		return 0;
+
+	switch (obj_type) {
+	case BPF_OBJ_PROG:
+		fops =3D &bpf_prog_fops;
+		break;
+	case BPF_OBJ_MAP:
+		fops =3D &bpf_map_fops;
+		break;
+	case BPF_OBJ_BTF:
+		fops =3D &btf_fops;
+		break;
+	case BPF_OBJ_LINK:
+		fops =3D &bpf_link_fops;
+		break;
+	default:
+		return 0;
+	}
+
+	if (file->f_op !=3D fops)
+		return 0;
+
+	e.pid =3D task->tgid;
+	e.id =3D get_obj_id(file->private_data, obj_type);
+	bpf_probe_read(&e.comm, sizeof(e.comm), task->group_leader->comm);
+	bpf_seq_write(ctx->meta->seq, &e, sizeof(e));
+
+	return 0;
+}
+
+char LICENSE[] SEC("license") =3D "Dual BSD/GPL";
diff --git a/tools/bpf/bpftool/skeleton/pid_iter.h b/tools/bpf/bpftool/sk=
eleton/pid_iter.h
new file mode 100644
index 000000000000..5692cf257adb
--- /dev/null
+++ b/tools/bpf/bpftool/skeleton/pid_iter.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/* Copyright (c) 2020 Facebook */
+#ifndef __PID_ITER_H
+#define __PID_ITER_H
+
+struct pid_iter_entry {
+	__u32 id;
+	int pid;
+	char comm[16];
+};
+
+#endif
--=20
2.24.1

