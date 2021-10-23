Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA16E438570
	for <lists+bpf@lfdr.de>; Sat, 23 Oct 2021 22:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbhJWUya (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 23 Oct 2021 16:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbhJWUy1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Oct 2021 16:54:27 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C5BC061229
        for <bpf@vger.kernel.org>; Sat, 23 Oct 2021 13:52:06 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so5749915wmz.2
        for <bpf@vger.kernel.org>; Sat, 23 Oct 2021 13:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V75jyjYdnsS07mbviL23NDsfFATkmATGP+SmihVgCnc=;
        b=DJom9nNiqcagruhi2MeS37eTM40tr0+0XVvXdeibkuOp5ukBiUc2tM18tg95jGr5kq
         0wV9O771pci7gQTVRJAVLuIojm8myBNNdJAtwAh5TpT/yj6HfUi/fqdnKEqxIIVcTq8D
         VKg/nDniritOPObV1x5Cy6ulVwXyhWigJPXs0LhgBZI64Z3HR13CAoIroXD//pIYouG1
         NeyxqT8XaRDXKreDUj5ub7TbXxK978AzKipSGaymz5JPI9qOAo8p/m/bm9lWVObBf70q
         uoRcs/KuqvIE5WC89JhD05y6KG1er6df12fyUR2NJ7V2p9NVR7aXywWEbIo9bf+yDVWK
         7oFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V75jyjYdnsS07mbviL23NDsfFATkmATGP+SmihVgCnc=;
        b=dlynbS56O2LW/j9hOnnzz8lG6IN3JK4N4cghM81itD4sozHVFiNu5dWOBgzidirmfF
         iQgXBHwAHWFzEKhlHaZgPg/7mTrQafiNtZV+kx6z+wxdOTUw6bvgvByscLpaORUBIwMC
         g4YVUeyggY9ioBYxU3VWfbC0mavS0D+NIPgOBgEsERrGtz8giYRlxncf8ABGMfPLXzu6
         zW5lRPzFONjRFar0ToQPUd3HsJ8BGgFdyNGyNTgEFEX7kFDPbm+K4nXNPOVPjQJY17uy
         rlL3A7NyHDfey9sFY3j0u9mCVNYQEdSh5pGTQAZNpvBq3978ItO6G1VAqammxHITnz0E
         /Cig==
X-Gm-Message-State: AOAM530HiG0Ce6vkGMm5RFz6AKrrBvgMdHHP93U8G0lsrL1Ycfzqlbis
        IsaFKO5DWx6jq/Bv9aBcNQ8fZg==
X-Google-Smtp-Source: ABdhPJzeObqQN5rRkuOn4D8ImXTgx9DiSKQAKO1voiymQblIg3tyOfyR3HekHOLuDNVQp1EIzny9wA==
X-Received: by 2002:a7b:c303:: with SMTP id k3mr9048853wmj.44.1635022325405;
        Sat, 23 Oct 2021 13:52:05 -0700 (PDT)
Received: from localhost.localdomain ([149.86.74.50])
        by smtp.gmail.com with ESMTPSA id u16sm13555398wmc.21.2021.10.23.13.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 13:52:04 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2 5/5] bpftool: Switch to libbpf's hashmap for PIDs/names references
Date:   Sat, 23 Oct 2021 21:51:54 +0100
Message-Id: <20211023205154.6710-6-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211023205154.6710-1-quentin@isovalent.com>
References: <20211023205154.6710-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In order to show PIDs and names for processes holding references to BPF
programs, maps, links, or BTF objects, bpftool creates hash maps to
store all relevant information. This commit is part of a set that
transitions from the kernel's hash map implementation to the one coming
with libbpf.

The motivation is to make bpftool less dependent of kernel headers, to
ease the path to a potential out-of-tree mirror, like libbpf has.

This is the third and final step of the transition, in which we convert
the hash maps used for storing the information about the processes
holding references to BPF objects (programs, maps, links, BTF), and at
last we drop the inclusion of tools/include/linux/hashtable.h.

Note: Checkpatch complains about the use of __weak declarations, and the
missing empty lines after the bunch of empty function declarations when
compiling without the BPF skeletons (none of these were introduced in
this patch). We want to keep things as they are, and the reports should
be safe to ignore.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/btf.c  |  7 ++--
 tools/bpf/bpftool/link.c |  6 +--
 tools/bpf/bpftool/main.c |  5 ++-
 tools/bpf/bpftool/main.h | 17 +++-----
 tools/bpf/bpftool/map.c  |  6 +--
 tools/bpf/bpftool/pids.c | 90 +++++++++++++++++++++++-----------------
 tools/bpf/bpftool/prog.c |  6 +--
 7 files changed, 72 insertions(+), 65 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 11dd31b6e730..015d2758f826 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -9,7 +9,6 @@
 #include <string.h>
 #include <unistd.h>
 #include <linux/btf.h>
-#include <linux/hashtable.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 
@@ -797,7 +796,7 @@ show_btf_plain(struct bpf_btf_info *info, int fd,
 		       hash_field_as_u32(entry->value));
 	}
 
-	emit_obj_refs_plain(&refs_table, info->id, "\n\tpids ");
+	emit_obj_refs_plain(refs_table, info->id, "\n\tpids ");
 
 	printf("\n");
 }
@@ -830,7 +829,7 @@ show_btf_json(struct bpf_btf_info *info, int fd,
 	}
 	jsonw_end_array(json_wtr);	/* map_ids */
 
-	emit_obj_refs_json(&refs_table, info->id, json_wtr); /* pids */
+	emit_obj_refs_json(refs_table, info->id, json_wtr); /* pids */
 
 	jsonw_bool_field(json_wtr, "kernel", info->kernel_btf);
 
@@ -961,7 +960,7 @@ static int do_show(int argc, char **argv)
 exit_free:
 	hashmap__free(btf_prog_table);
 	hashmap__free(btf_map_table);
-	delete_obj_refs_table(&refs_table);
+	delete_obj_refs_table(refs_table);
 
 	return err;
 }
diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 404cc5459c6b..2c258db0d352 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -170,7 +170,7 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 		jsonw_end_array(json_wtr);
 	}
 
-	emit_obj_refs_json(&refs_table, info->id, json_wtr);
+	emit_obj_refs_json(refs_table, info->id, json_wtr);
 
 	jsonw_end_object(json_wtr);
 
@@ -253,7 +253,7 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 					    u32_as_hash_field(info->id))
 			printf("\n\tpinned %s", (char *)entry->value);
 	}
-	emit_obj_refs_plain(&refs_table, info->id, "\n\tpids ");
+	emit_obj_refs_plain(refs_table, info->id, "\n\tpids ");
 
 	printf("\n");
 
@@ -352,7 +352,7 @@ static int do_show(int argc, char **argv)
 	if (json_output)
 		jsonw_end_array(json_wtr);
 
-	delete_obj_refs_table(&refs_table);
+	delete_obj_refs_table(refs_table);
 
 	if (show_pinned)
 		delete_pinned_obj_table(link_table);
diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 7a33f0e6da28..28237d7cef67 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -10,8 +10,9 @@
 #include <string.h>
 
 #include <bpf/bpf.h>
-#include <bpf/libbpf.h>
 #include <bpf/btf.h>
+#include <bpf/hashmap.h>
+#include <bpf/libbpf.h>
 
 #include "main.h"
 
@@ -31,7 +32,7 @@ bool verifier_logs;
 bool relaxed_maps;
 bool use_loader;
 struct btf *base_btf;
-struct obj_refs_table refs_table;
+struct hashmap *refs_table;
 
 static void __noreturn clean_and_exit(int i)
 {
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index f6f2f951b193..383835c2604d 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -11,7 +11,6 @@
 #include <linux/bpf.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
-#include <linux/hashtable.h>
 #include <tools/libc_compat.h>
 
 #include <bpf/hashmap.h>
@@ -92,7 +91,7 @@ extern bool verifier_logs;
 extern bool relaxed_maps;
 extern bool use_loader;
 extern struct btf *base_btf;
-extern struct obj_refs_table refs_table;
+extern struct hashmap *refs_table;
 
 void __printf(1, 2) p_err(const char *fmt, ...);
 void __printf(1, 2) p_info(const char *fmt, ...);
@@ -106,18 +105,12 @@ void set_max_rlimit(void);
 
 int mount_tracefs(const char *target);
 
-struct obj_refs_table {
-	DECLARE_HASHTABLE(table, 16);
-};
-
 struct obj_ref {
 	int pid;
 	char comm[16];
 };
 
 struct obj_refs {
-	struct hlist_node node;
-	__u32 id;
 	int ref_cnt;
 	struct obj_ref *refs;
 };
@@ -128,12 +121,12 @@ struct bpf_line_info;
 int build_pinned_obj_table(struct hashmap *table,
 			   enum bpf_obj_type type);
 void delete_pinned_obj_table(struct hashmap *table);
-__weak int build_obj_refs_table(struct obj_refs_table *table,
+__weak int build_obj_refs_table(struct hashmap **table,
 				enum bpf_obj_type type);
-__weak void delete_obj_refs_table(struct obj_refs_table *table);
-__weak void emit_obj_refs_json(struct obj_refs_table *table, __u32 id,
+__weak void delete_obj_refs_table(struct hashmap *table);
+__weak void emit_obj_refs_json(struct hashmap *table, __u32 id,
 			       json_writer_t *json_wtr);
-__weak void emit_obj_refs_plain(struct obj_refs_table *table, __u32 id,
+__weak void emit_obj_refs_plain(struct hashmap *table, __u32 id,
 				const char *prefix);
 void print_dev_plain(__u32 ifindex, __u64 ns_dev, __u64 ns_inode);
 void print_dev_json(__u32 ifindex, __u64 ns_dev, __u64 ns_inode);
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 2647603c5e5d..cae1f1119296 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -549,7 +549,7 @@ static int show_map_close_json(int fd, struct bpf_map_info *info)
 		jsonw_end_array(json_wtr);
 	}
 
-	emit_obj_refs_json(&refs_table, info->id, json_wtr);
+	emit_obj_refs_json(refs_table, info->id, json_wtr);
 
 	jsonw_end_object(json_wtr);
 
@@ -637,7 +637,7 @@ static int show_map_close_plain(int fd, struct bpf_map_info *info)
 	if (frozen)
 		printf("%sfrozen", info->btf_id ? "  " : "");
 
-	emit_obj_refs_plain(&refs_table, info->id, "\n\tpids ");
+	emit_obj_refs_plain(refs_table, info->id, "\n\tpids ");
 
 	printf("\n");
 	return 0;
@@ -748,7 +748,7 @@ static int do_show(int argc, char **argv)
 	if (json_output)
 		jsonw_end_array(json_wtr);
 
-	delete_obj_refs_table(&refs_table);
+	delete_obj_refs_table(refs_table);
 
 	if (show_pinned)
 		delete_pinned_obj_table(map_table);
diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
index 477e55d59c34..56b598eee043 100644
--- a/tools/bpf/bpftool/pids.c
+++ b/tools/bpf/bpftool/pids.c
@@ -6,35 +6,37 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+
 #include <bpf/bpf.h>
+#include <bpf/hashmap.h>
 
 #include "main.h"
 #include "skeleton/pid_iter.h"
 
 #ifdef BPFTOOL_WITHOUT_SKELETONS
 
-int build_obj_refs_table(struct obj_refs_table *table, enum bpf_obj_type type)
+int build_obj_refs_table(struct hashmap **map, enum bpf_obj_type type)
 {
 	return -ENOTSUP;
 }
-void delete_obj_refs_table(struct obj_refs_table *table) {}
-void emit_obj_refs_plain(struct obj_refs_table *table, __u32 id, const char *prefix) {}
-void emit_obj_refs_json(struct obj_refs_table *table, __u32 id, json_writer_t *json_writer) {}
+void delete_obj_refs_table(struct hashmap *map) {}
+void emit_obj_refs_plain(struct hashmap *map, __u32 id, const char *prefix) {}
+void emit_obj_refs_json(struct hashmap *map, __u32 id, json_writer_t *json_writer) {}
 
 #else /* BPFTOOL_WITHOUT_SKELETONS */
 
 #include "pid_iter.skel.h"
 
-static void add_ref(struct obj_refs_table *table, struct pid_iter_entry *e)
+static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
 {
+	struct hashmap_entry *entry;
 	struct obj_refs *refs;
 	struct obj_ref *ref;
+	int err, i;
 	void *tmp;
-	int i;
 
-	hash_for_each_possible(table->table, refs, node, e->id) {
-		if (refs->id != e->id)
-			continue;
+	hashmap__for_each_key_entry(map, entry, u32_as_hash_field(e->id)) {
+		refs = entry->value;
 
 		for (i = 0; i < refs->ref_cnt; i++) {
 			if (refs->refs[i].pid == e->pid)
@@ -64,7 +66,6 @@ static void add_ref(struct obj_refs_table *table, struct pid_iter_entry *e)
 		return;
 	}
 
-	refs->id = e->id;
 	refs->refs = malloc(sizeof(*refs->refs));
 	if (!refs->refs) {
 		free(refs);
@@ -76,7 +77,11 @@ static void add_ref(struct obj_refs_table *table, struct pid_iter_entry *e)
 	ref->pid = e->pid;
 	memcpy(ref->comm, e->comm, sizeof(ref->comm));
 	refs->ref_cnt = 1;
-	hash_add(table->table, &refs->node, e->id);
+
+	err = hashmap__append(map, u32_as_hash_field(e->id), refs);
+	if (err)
+		p_err("failed to append entry to hashmap for ID %u: %s",
+		      e->id, strerror(errno));
 }
 
 static int __printf(2, 0)
@@ -87,7 +92,7 @@ libbpf_print_none(__maybe_unused enum libbpf_print_level level,
 	return 0;
 }
 
-int build_obj_refs_table(struct obj_refs_table *table, enum bpf_obj_type type)
+int build_obj_refs_table(struct hashmap **map, enum bpf_obj_type type)
 {
 	struct pid_iter_entry *e;
 	char buf[4096 / sizeof(*e) * sizeof(*e)];
@@ -95,7 +100,11 @@ int build_obj_refs_table(struct obj_refs_table *table, enum bpf_obj_type type)
 	int err, ret, fd = -1, i;
 	libbpf_print_fn_t default_print;
 
-	hash_init(table->table);
+	*map = hashmap__new(hash_fn_for_key_as_id, equal_fn_for_key_as_id, NULL);
+	if (!*map) {
+		p_err("failed to create hashmap for PID references");
+		return -1;
+	}
 	set_max_rlimit();
 
 	skel = pid_iter_bpf__open();
@@ -151,7 +160,7 @@ int build_obj_refs_table(struct obj_refs_table *table, enum bpf_obj_type type)
 
 		e = (void *)buf;
 		for (i = 0; i < ret; i++, e++) {
-			add_ref(table, e);
+			add_ref(*map, e);
 		}
 	}
 	err = 0;
@@ -162,39 +171,44 @@ int build_obj_refs_table(struct obj_refs_table *table, enum bpf_obj_type type)
 	return err;
 }
 
-void delete_obj_refs_table(struct obj_refs_table *table)
+void delete_obj_refs_table(struct hashmap *map)
 {
-	struct obj_refs *refs;
-	struct hlist_node *tmp;
-	unsigned int bkt;
+	struct hashmap_entry *entry;
+	size_t bkt;
+
+	if (!map)
+		return;
+
+	hashmap__for_each_entry(map, entry, bkt) {
+		struct obj_refs *refs = entry->value;
 
-	hash_for_each_safe(table->table, bkt, tmp, refs, node) {
-		hash_del(&refs->node);
 		free(refs->refs);
 		free(refs);
 	}
+
+	hashmap__free(map);
 }
 
-void emit_obj_refs_json(struct obj_refs_table *table, __u32 id,
+void emit_obj_refs_json(struct hashmap *map, __u32 id,
 			json_writer_t *json_writer)
 {
-	struct obj_refs *refs;
-	struct obj_ref *ref;
-	int i;
+	struct hashmap_entry *entry;
 
-	if (hash_empty(table->table))
+	if (hashmap__empty(map))
 		return;
 
-	hash_for_each_possible(table->table, refs, node, id) {
-		if (refs->id != id)
-			continue;
+	hashmap__for_each_key_entry(map, entry, u32_as_hash_field(id)) {
+		struct obj_refs *refs = entry->value;
+		int i;
+
 		if (refs->ref_cnt == 0)
 			break;
 
 		jsonw_name(json_writer, "pids");
 		jsonw_start_array(json_writer);
 		for (i = 0; i < refs->ref_cnt; i++) {
-			ref = &refs->refs[i];
+			struct obj_ref *ref = &refs->refs[i];
+
 			jsonw_start_object(json_writer);
 			jsonw_int_field(json_writer, "pid", ref->pid);
 			jsonw_string_field(json_writer, "comm", ref->comm);
@@ -205,24 +219,24 @@ void emit_obj_refs_json(struct obj_refs_table *table, __u32 id,
 	}
 }
 
-void emit_obj_refs_plain(struct obj_refs_table *table, __u32 id, const char *prefix)
+void emit_obj_refs_plain(struct hashmap *map, __u32 id, const char *prefix)
 {
-	struct obj_refs *refs;
-	struct obj_ref *ref;
-	int i;
+	struct hashmap_entry *entry;
 
-	if (hash_empty(table->table))
+	if (hashmap__empty(map))
 		return;
 
-	hash_for_each_possible(table->table, refs, node, id) {
-		if (refs->id != id)
-			continue;
+	hashmap__for_each_key_entry(map, entry, u32_as_hash_field(id)) {
+		struct obj_refs *refs = entry->value;
+		int i;
+
 		if (refs->ref_cnt == 0)
 			break;
 
 		printf("%s", prefix);
 		for (i = 0; i < refs->ref_cnt; i++) {
-			ref = &refs->refs[i];
+			struct obj_ref *ref = &refs->refs[i];
+
 			printf("%s%s(%d)", i == 0 ? "" : ", ", ref->comm, ref->pid);
 		}
 		break;
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 8fce78ce6f8b..515d22952602 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -430,7 +430,7 @@ static void print_prog_json(struct bpf_prog_info *info, int fd)
 		jsonw_end_array(json_wtr);
 	}
 
-	emit_obj_refs_json(&refs_table, info->id, json_wtr);
+	emit_obj_refs_json(refs_table, info->id, json_wtr);
 
 	show_prog_metadata(fd, info->nr_map_ids);
 
@@ -501,7 +501,7 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd)
 	if (info->btf_id)
 		printf("\n\tbtf_id %d", info->btf_id);
 
-	emit_obj_refs_plain(&refs_table, info->id, "\n\tpids ");
+	emit_obj_refs_plain(refs_table, info->id, "\n\tpids ");
 
 	printf("\n");
 
@@ -619,7 +619,7 @@ static int do_show(int argc, char **argv)
 	if (json_output)
 		jsonw_end_array(json_wtr);
 
-	delete_obj_refs_table(&refs_table);
+	delete_obj_refs_table(refs_table);
 
 	if (show_pinned)
 		delete_pinned_obj_table(prog_table);
-- 
2.30.2

