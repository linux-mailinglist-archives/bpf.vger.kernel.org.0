Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADC71F7EF2
	for <lists+bpf@lfdr.de>; Sat, 13 Jun 2020 00:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgFLWfM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Jun 2020 18:35:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59650 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726304AbgFLWfL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Jun 2020 18:35:11 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05CMZ4hJ027860
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2020 15:35:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=X/mMEP7BPGwrF3dvZHctk/tsnPNAs0K4ninU3SJ7C68=;
 b=PQYYMPAvgakd4PEChGTwlAUGM7kRDLbzpryDJ/3fY5ilcmiZhsmZanrHQmX5mpzxTZga
 70jRaOQ6jH7kNncU4a9uBnKStnQaI+M9hOIUvRg2XIXtnsUCmOslL3FgvH2smZCqKnL9
 +Mob3Mhukrt99bnBaCyTYgaQqer6xY+00QE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31je2vthv1-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2020 15:35:09 -0700
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 12 Jun 2020 15:34:43 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id B9A412EC1E0C; Fri, 12 Jun 2020 15:32:15 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 8/8] tools/bpftool: show PIDs with FDs open against BPF map/prog/link/btf
Date:   Fri, 12 Jun 2020 15:31:50 -0700
Message-ID: <20200612223150.1177182-9-andriin@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200612223150.1177182-1-andriin@fb.com>
References: <20200612223150.1177182-1-andriin@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-12_17:2020-06-12,2020-06-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=25 mlxscore=0 adultscore=0
 cotscore=-2147483648 phishscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006120169
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add bpf_iter-based way to find all the processes that hold open FDs again=
st
BPF object (map, prog, link, btf). Add new flag (-o, for "ownership", giv=
en
-p is already taken) to trigger collection and output of these PIDs.

Sample output for each of 4 BPF objects:

$ sudo ./bpftool -o prog show
1992: cgroup_skb  name egress_alt  tag 9ad187367cf2b9e8  gpl
        loaded_at 2020-06-12T14:18:10-0700  uid 0
        xlated 48B  jited 59B  memlock 4096B  map_ids 2074
        btf_id 460
        pids: 913709,913732,913733,913734
2062: cgroup_device  tag 8c42dee26e8cd4c2  gpl
        loaded_at 2020-06-12T14:37:52-0700  uid 0
        xlated 648B  jited 409B  memlock 4096B
        pids: 1

$ sudo ./bpftool -o map show
2074: array  name test_cgr.bss  flags 0x400
        key 4B  value 8B  max_entries 1  memlock 8192B
        btf_id 460
        pids: 913709,913732,913733,913734

$ sudo ./bpftool -o link show
82: cgroup  prog 1992
        cgroup_id 0  attach_type egress
        pids: 913709,913732,913733,913734
86: cgroup  prog 1992
        cgroup_id 0  attach_type egress
        pids: 913709,913732,913733,913734

$ sudo ./bpftool -o btf show
460: size 1527B  prog_ids 1992,1991  map_ids 2074  pids 913709,913732,913=
733,913734

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/bpf/bpftool/Makefile                |   2 +
 tools/bpf/bpftool/btf.c                   |  39 ++++++
 tools/bpf/bpftool/link.c                  |  40 ++++++
 tools/bpf/bpftool/main.c                  |   8 +-
 tools/bpf/bpftool/main.h                  |  18 +++
 tools/bpf/bpftool/map.c                   |  39 ++++++
 tools/bpf/bpftool/pids.c                  | 150 ++++++++++++++++++++++
 tools/bpf/bpftool/prog.c                  |  40 ++++++
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c |  77 +++++++++++
 9 files changed, 412 insertions(+), 1 deletion(-)
 create mode 100644 tools/bpf/bpftool/pids.c
 create mode 100644 tools/bpf/bpftool/skeleton/pid_iter.bpf.c

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
index faac8189b285..448c89d1faee 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -809,6 +809,22 @@ show_btf_plain(struct bpf_btf_info *info, int fd,
 			printf("%s%u", n++ =3D=3D 0 ? "  map_ids " : ",",
 			       obj->obj_id);
 	}
+	if (!hash_empty(pids_table.table)) {
+		struct obj_pids *pids;
+		int i;
+
+		hash_for_each_possible(pids_table.table, pids, node, info->id) {
+			if (pids->id !=3D info->id)
+				continue;
+			if (pids->pid_cnt =3D=3D 0)
+				break;
+
+			printf("  pids");
+			for (i =3D 0; i < pids->pid_cnt; i++)
+				printf("%c%d", i =3D=3D 0 ? ' ' : ',', pids->pids[i]);
+			break;
+		}
+	}
=20
 	printf("\n");
 }
@@ -841,6 +857,25 @@ show_btf_json(struct bpf_btf_info *info, int fd,
 			jsonw_uint(json_wtr, obj->obj_id);
 	}
 	jsonw_end_array(json_wtr);	/* map_ids */
+	/* PIDs */
+	if (!hash_empty(pids_table.table)) {
+		struct obj_pids *pids;
+		int i;
+
+		hash_for_each_possible(pids_table.table, pids, node, info->id) {
+			if (pids->id !=3D info->id)
+				continue;
+			if (pids->pid_cnt =3D=3D 0)
+				break;
+
+			jsonw_name(json_wtr, "pids");
+			jsonw_start_array(json_wtr);
+			for (i =3D 0; i < pids->pid_cnt; i++)
+				jsonw_int(json_wtr, pids->pids[i]);
+			jsonw_end_array(json_wtr);
+			break;
+		}
+	}
 	jsonw_end_object(json_wtr);	/* btf object */
 }
=20
@@ -893,6 +928,8 @@ static int do_show(int argc, char **argv)
 			close(fd);
 		return err;
 	}
+	if (show_pids)
+		build_obj_pids_table(&pids_table, BPF_OBJ_BTF);
=20
 	if (fd >=3D 0) {
 		err =3D show_btf(fd, &btf_prog_table, &btf_map_table);
@@ -939,6 +976,8 @@ static int do_show(int argc, char **argv)
 exit_free:
 	delete_btf_table(&btf_prog_table);
 	delete_btf_table(&btf_map_table);
+	if (show_pids)
+		delete_obj_pids_table(&pids_table);
=20
 	return err;
 }
diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index fca57ee8fafe..d959ce838dfb 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -143,6 +143,25 @@ static int show_link_close_json(int fd, struct bpf_l=
ink_info *info)
 		}
 		jsonw_end_array(json_wtr);
 	}
+	if (!hash_empty(pids_table.table)) {
+		struct obj_pids *pids;
+		int i;
+
+		hash_for_each_possible(pids_table.table, pids, node, info->id) {
+			if (pids->id !=3D info->id)
+				continue;
+			if (pids->pid_cnt =3D=3D 0)
+				break;
+
+			jsonw_name(json_wtr, "pids");
+			jsonw_start_array(json_wtr);
+			for (i =3D 0; i < pids->pid_cnt; i++)
+				jsonw_int(json_wtr, pids->pids[i]);
+			jsonw_end_array(json_wtr);
+			break;
+		}
+	}
+
 	jsonw_end_object(json_wtr);
=20
 	return 0;
@@ -212,6 +231,22 @@ static int show_link_close_plain(int fd, struct bpf_=
link_info *info)
 				printf("\n\tpinned %s", obj->path);
 		}
 	}
+	if (!hash_empty(pids_table.table)) {
+		struct obj_pids *pids;
+		int i;
+
+		hash_for_each_possible(pids_table.table, pids, node, info->id) {
+			if (pids->id !=3D info->id)
+				continue;
+			if (pids->pid_cnt =3D=3D 0)
+				break;
+
+			printf("\n\tpids:");
+			for (i =3D 0; i < pids->pid_cnt; i++)
+				printf("%c%d", i =3D=3D 0 ? ' ' : ',', pids->pids[i]);
+			break;
+		}
+	}
=20
 	printf("\n");
=20
@@ -257,6 +292,8 @@ static int do_show(int argc, char **argv)
=20
 	if (show_pinned)
 		build_pinned_obj_table(&link_table, BPF_OBJ_LINK);
+	if (show_pids)
+		build_obj_pids_table(&pids_table, BPF_OBJ_LINK);
=20
 	if (argc =3D=3D 2) {
 		fd =3D link_parse_fd(&argc, &argv);
@@ -296,6 +333,9 @@ static int do_show(int argc, char **argv)
 	if (json_output)
 		jsonw_end_array(json_wtr);
=20
+	if (show_pids)
+		delete_obj_pids_table(&pids_table);
+
 	return errno =3D=3D ENOENT ? 0 : -1;
 }
=20
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index bf4d7487552a..53a546e1d9a8 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -25,12 +25,14 @@ json_writer_t *json_wtr;
 bool pretty_output;
 bool json_output;
 bool show_pinned;
+bool show_pids;
 bool block_mount;
 bool verifier_logs;
 bool relaxed_maps;
 struct pinned_obj_table prog_table;
 struct pinned_obj_table map_table;
 struct pinned_obj_table link_table;
+struct obj_pids_table pids_table;
=20
 static void __noreturn clean_and_exit(int i)
 {
@@ -369,6 +371,7 @@ int main(int argc, char **argv)
 	pretty_output =3D false;
 	json_output =3D false;
 	show_pinned =3D false;
+	show_pids =3D false;
 	block_mount =3D false;
 	bin_name =3D argv[0];
=20
@@ -377,7 +380,7 @@ int main(int argc, char **argv)
 	hash_init(link_table.table);
=20
 	opterr =3D 0;
-	while ((opt =3D getopt_long(argc, argv, "Vhpjfmnd",
+	while ((opt =3D getopt_long(argc, argv, "Vhpjfomnd",
 				  options, NULL)) >=3D 0) {
 		switch (opt) {
 		case 'V':
@@ -401,6 +404,9 @@ int main(int argc, char **argv)
 		case 'f':
 			show_pinned =3D true;
 			break;
+		case 'o':
+			show_pids =3D true;
+			break;
 		case 'm':
 			relaxed_maps =3D true;
 			break;
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index aad7be74e8a7..286134b05687 100644
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
+extern struct obj_pids_table pids_table;
=20
 void __printf(1, 2) p_err(const char *fmt, ...);
 void __printf(1, 2) p_info(const char *fmt, ...);
@@ -168,12 +172,26 @@ struct pinned_obj {
 	struct hlist_node hash;
 };
=20
+struct obj_pids_table {
+	DECLARE_HASHTABLE(table, 16);
+};
+
+struct obj_pids {
+	struct hlist_node node;
+	__u32 id;
+	int pid_cnt;
+	int *pids;
+};
+
 struct btf;
 struct bpf_line_info;
=20
 int build_pinned_obj_table(struct pinned_obj_table *table,
 			   enum bpf_obj_type type);
 void delete_pinned_obj_table(struct pinned_obj_table *tab);
+__weak int build_obj_pids_table(struct obj_pids_table *table,
+				enum bpf_obj_type type);
+__weak void delete_obj_pids_table(struct obj_pids_table *table);
 void print_dev_plain(__u32 ifindex, __u64 ns_dev, __u64 ns_inode);
 void print_dev_json(__u32 ifindex, __u64 ns_dev, __u64 ns_inode);
=20
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index b9eee19b094c..1fc8b674049e 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -508,6 +508,24 @@ static int show_map_close_json(int fd, struct bpf_ma=
p_info *info)
 		}
 		jsonw_end_array(json_wtr);
 	}
+	if (!hash_empty(pids_table.table)) {
+		struct obj_pids *pids;
+		int i;
+
+		hash_for_each_possible(pids_table.table, pids, node, info->id) {
+			if (pids->id !=3D info->id)
+				continue;
+			if (pids->pid_cnt =3D=3D 0)
+				break;
+
+			jsonw_name(json_wtr, "pids");
+			jsonw_start_array(json_wtr);
+			for (i =3D 0; i < pids->pid_cnt; i++)
+				jsonw_int(json_wtr, pids->pids[i]);
+			jsonw_end_array(json_wtr);
+			break;
+		}
+	}
=20
 	jsonw_end_object(json_wtr);
=20
@@ -596,6 +614,22 @@ static int show_map_close_plain(int fd, struct bpf_m=
ap_info *info)
 	if (frozen)
 		printf("%sfrozen", info->btf_id ? "  " : "");
=20
+	if (!hash_empty(pids_table.table)) {
+		struct obj_pids *pids;
+		int i;
+
+		hash_for_each_possible(pids_table.table, pids, node, info->id) {
+			if (pids->id !=3D info->id)
+				continue;
+			if (pids->pid_cnt =3D=3D 0)
+				break;
+
+			printf("\n\tpids:");
+			for (i =3D 0; i < pids->pid_cnt; i++)
+				printf("%c%d", i =3D=3D 0 ? ' ' : ',', pids->pids[i]);
+			break;
+		}
+	}
 	printf("\n");
 	return 0;
 }
@@ -654,6 +688,8 @@ static int do_show(int argc, char **argv)
=20
 	if (show_pinned)
 		build_pinned_obj_table(&map_table, BPF_OBJ_MAP);
+	if (show_pids)
+		build_obj_pids_table(&pids_table, BPF_OBJ_MAP);
=20
 	if (argc =3D=3D 2)
 		return do_show_subset(argc, argv);
@@ -697,6 +733,9 @@ static int do_show(int argc, char **argv)
 	if (json_output)
 		jsonw_end_array(json_wtr);
=20
+	if (show_pids)
+		delete_obj_pids_table(&pids_table);
+
 	return errno =3D=3D ENOENT ? 0 : -1;
 }
=20
diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
new file mode 100644
index 000000000000..fb0a2d7213b4
--- /dev/null
+++ b/tools/bpf/bpftool/pids.c
@@ -0,0 +1,150 @@
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
+
+#ifdef BPFTOOL_WITHOUT_SKELETONS
+
+int build_obj_pids_table(struct obj_pids_table *table, enum bpf_obj_type=
 type)
+{
+	p_err("bpftool built without PID iterator support");
+	return -ENOTSUP;
+}
+void delete_obj_pids_table(struct obj_pids_table *table) {}
+
+#else /* BPFTOOL_WITHOUT_SKELETONS */
+
+#include "pid_iter.skel.h"
+
+int build_obj_pids_table(struct obj_pids_table *table, enum bpf_obj_type=
 type)
+{
+	struct obj_pids *pids;
+	struct pid_iter_bpf *skel;
+	FILE *f =3D NULL;
+	int err, ret, fd =3D -1, pid, i;
+	__u32 id;
+	bool found_id, found_pid;
+
+	hash_init(table->table);
+	set_max_rlimit();
+
+	skel =3D pid_iter_bpf__open();
+	if (!skel) {
+		p_err("failed to open PID iterator");
+		return -1;
+	}
+
+	skel->rodata->obj_type =3D type;
+
+	err =3D pid_iter_bpf__load(skel);
+	if (err) {
+		p_err("failed to load PID iterator: %d", err);
+		goto out;
+	}
+	err =3D pid_iter_bpf__attach(skel);
+	if (err) {
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
+	f =3D fdopen(fd, "r");
+	if (!f) {
+		err =3D -errno;
+		goto out;
+	}
+
+	while (true) {
+		ret =3D fscanf(f, "%d %u\n", &pid, &id);
+		if (ret =3D=3D EOF && feof(f))
+			break;
+		if (ret !=3D 2) {
+			err =3D -EINVAL;
+			p_err("invalid PID iterator output format");
+			goto out;
+		}
+
+		found_id =3D false;
+		hash_for_each_possible(table->table, pids, node, id) {
+			if (pids->id !=3D id)
+				continue;
+			found_id =3D true;
+
+			found_pid =3D false;
+			for (i =3D 0; i < pids->pid_cnt; i++) {
+				if (pids->pids[i] =3D=3D pid) {
+					found_pid =3D true;
+					break;
+				}
+			}
+			if (!found_pid) {
+				void *tmp;
+
+				tmp =3D realloc(pids->pids, pids->pid_cnt + 1);
+				if (!tmp) {
+					p_err("failed to re-alloc memory for ID %u, PID %d...",
+					      id, pid);
+					break;
+				}
+				pids->pids =3D tmp;
+				pids->pids[pids->pid_cnt] =3D pid;
+				pids->pid_cnt++;
+			}
+			break;
+		}
+		if (!found_id) {
+			pids =3D calloc(1, sizeof(*pids));
+			if (!pids) {
+				p_err("failed to alloc memory for ID %u, PID %d...", id, pid);
+				continue;
+			}
+
+			pids->id =3D id;
+			pids->pids =3D malloc(sizeof(*pids->pids));
+			if (!pids->pids) {
+				free(pids);
+				p_err("failed to alloc memory for ID %u, PID %d...", id, pid);
+				continue;
+			}
+			pids->pids[0] =3D pid;
+			pids->pid_cnt =3D 1;
+			hash_add(table->table, &pids->node, id);
+		}
+	}
+	err =3D 0;
+out:
+	if (f)
+		fclose(f);
+	else if (fd >=3D 0)
+		close(fd);
+	pid_iter_bpf__destroy(skel);
+	return err;
+}
+
+void delete_obj_pids_table(struct obj_pids_table *table)
+{
+	struct obj_pids *pids;
+	struct hlist_node *tmp;
+	unsigned int bkt;
+
+	hash_for_each_safe(table->table, bkt, tmp, pids, node) {
+		hash_del(&pids->node);
+		free(pids->pids);
+		free(pids);
+	}
+}
+
+#endif
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 53d47610ff58..6b430f9af2af 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -190,6 +190,24 @@ static void print_prog_json(struct bpf_prog_info *in=
fo, int fd)
 		jsonw_end_array(json_wtr);
 	}
=20
+	if (!hash_empty(pids_table.table)) {
+		struct obj_pids *pids;
+		int i;
+
+		hash_for_each_possible(pids_table.table, pids, node, info->id) {
+			if (pids->id !=3D info->id)
+				continue;
+			if (pids->pid_cnt =3D=3D 0)
+				break;
+
+			jsonw_name(json_wtr, "pids");
+			jsonw_start_array(json_wtr);
+			for (i =3D 0; i < pids->pid_cnt; i++)
+				jsonw_int(json_wtr, pids->pids[i]);
+			jsonw_end_array(json_wtr);
+			break;
+		}
+	}
 	jsonw_end_object(json_wtr);
 }
=20
@@ -256,6 +274,23 @@ static void print_prog_plain(struct bpf_prog_info *i=
nfo, int fd)
 	if (info->btf_id)
 		printf("\n\tbtf_id %d", info->btf_id);
=20
+	if (!hash_empty(pids_table.table)) {
+		struct obj_pids *pids;
+		int i;
+
+		hash_for_each_possible(pids_table.table, pids, node, info->id) {
+			if (pids->id !=3D info->id)
+				continue;
+			if (pids->pid_cnt =3D=3D 0)
+				break;
+
+			printf("\n\tpids:");
+			for (i =3D 0; i < pids->pid_cnt; i++)
+				printf("%c%d", i =3D=3D 0 ? ' ' : ',', pids->pids[i]);
+			break;
+		}
+	}
+
 	printf("\n");
 }
=20
@@ -321,6 +356,8 @@ static int do_show(int argc, char **argv)
=20
 	if (show_pinned)
 		build_pinned_obj_table(&prog_table, BPF_OBJ_PROG);
+	if (show_pids)
+		build_obj_pids_table(&pids_table, BPF_OBJ_PROG);
=20
 	if (argc =3D=3D 2)
 		return do_show_subset(argc, argv);
@@ -362,6 +399,9 @@ static int do_show(int argc, char **argv)
 	if (json_output)
 		jsonw_end_array(json_wtr);
=20
+	if (show_pids)
+		delete_obj_pids_table(&pids_table);
+
 	return err;
 }
=20
diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftoo=
l/skeleton/pid_iter.bpf.c
new file mode 100644
index 000000000000..9eedf5e56aa7
--- /dev/null
+++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2020 Facebook
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_tracing.h>
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
+	const void *fops;
+	int id;
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
+	id =3D get_obj_id(file->private_data, obj_type);
+	BPF_SEQ_PRINTF(ctx->meta->seq, "%d %d\n", task->tgid, id);
+
+	return 0;
+}
+
+char LICENSE[] SEC("license") =3D "GPL";
--=20
2.24.1

