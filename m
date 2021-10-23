Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1905F43856E
	for <lists+bpf@lfdr.de>; Sat, 23 Oct 2021 22:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhJWUy3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 23 Oct 2021 16:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhJWUy1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Oct 2021 16:54:27 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BCBC061227
        for <bpf@vger.kernel.org>; Sat, 23 Oct 2021 13:52:05 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id j205so5819836wmj.3
        for <bpf@vger.kernel.org>; Sat, 23 Oct 2021 13:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gh1KmHecNhkMjMGwCdkMHK2Zl6nIhGiYjkV1WWdBFHg=;
        b=F7WrId1oogJWRwY/u07zvKSmmdXj9qjFc8O0kpijptrkqQN0XpXtOqNruF08fN7Hd9
         LQ1sIA6ygw0fEiq6MDEU/iXTqugLFMAFwTE7W7RCZ3R+HPIKR+y11FsDsp1uQXRuLQ4I
         lDYs+RsD2SVyNNXUnJdOVHSTre5BxkB5/t823jMJ91fmu2pooUOsvESJ/pJ7Okk/dI5Y
         +Zjo99c33nrTFrbIiG/fDz1swULsYBZTE8sZeZxelp4IwFejB9WtaFFQLbi1yQaEo+Tk
         JU9gHOmm6oVUWJQy9yt54GzzqmfQCyqOLIzfe+iisH3mkO2duGDlIn3gg4jtVeRmRwpr
         naeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gh1KmHecNhkMjMGwCdkMHK2Zl6nIhGiYjkV1WWdBFHg=;
        b=qWd8JkehhnnAQqRbnbs3JgW1EHhzd1BYgWruLKoRKdhpKhPKbKTWC6FGdWTU9MJGGY
         Q2H0PVj85wjcbSWx64n46hrtTonH9A9kVWavPz5b3GXcSPoQ0YwUjyKdsZmZ4eVlRCpK
         UX3P4840L0TtM5Znhn61eYMoWwWW49b+F6dqtnaxJ2QP0WvCIjoR8EwxDQ7TMq9u/+vq
         l3AsvcdDh5u7rnnNA42MjJV7Qn6R1rtO77Dlx9v96y/43sxMQ6IRERfFNKTnUR/yah0x
         kuzs0cQj6pi2BWjNNM/aCaovyWHqAdwMj2xDcXeSqpP9yGcXHsP7ctNRa5CyannzSk5V
         sN9Q==
X-Gm-Message-State: AOAM532h1ci5VbmZzZHXltefOWmwIBYu+1/WmGVbIsWbI0P7VuEuN1ga
        YYMrhRmP7qtFd+1i9/hNGy0P1Q==
X-Google-Smtp-Source: ABdhPJwoxmAz7SO8PouYUh2EChJNsZbcDb+Nv5fyEBNC/jlmVNcxKEnHsK+044ces20C9QghVhVM6A==
X-Received: by 2002:a1c:7e87:: with SMTP id z129mr8967749wmc.75.1635022324447;
        Sat, 23 Oct 2021 13:52:04 -0700 (PDT)
Received: from localhost.localdomain ([149.86.74.50])
        by smtp.gmail.com with ESMTPSA id u16sm13555398wmc.21.2021.10.23.13.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 13:52:03 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2 4/5] bpftool: Switch to libbpf's hashmap for programs/maps in BTF listing
Date:   Sat, 23 Oct 2021 21:51:53 +0100
Message-Id: <20211023205154.6710-5-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211023205154.6710-1-quentin@isovalent.com>
References: <20211023205154.6710-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In order to show BPF programs and maps using BTF objects when the latter
are being listed, bpftool creates hash maps to store all relevant items.
This commit is part of a set that transitions from the kernel's hash map
implementation to the one coming with libbpf.

The motivation is to make bpftool less dependent of kernel headers, to
ease the path to a potential out-of-tree mirror, like libbpf has.

This commit focuses on the two hash maps used by bpftool when listing
BTF objects to store references to programs and maps, and convert them
to the libbpf's implementation.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/btf.c  | 125 ++++++++++++++++++---------------------
 tools/bpf/bpftool/main.h |   5 ++
 2 files changed, 62 insertions(+), 68 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 0cd769adac66..11dd31b6e730 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -8,14 +8,16 @@
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
-#include <bpf/bpf.h>
-#include <bpf/btf.h>
-#include <bpf/libbpf.h>
 #include <linux/btf.h>
 #include <linux/hashtable.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 
+#include <bpf/bpf.h>
+#include <bpf/btf.h>
+#include <bpf/hashmap.h>
+#include <bpf/libbpf.h>
+
 #include "json_writer.h"
 #include "main.h"
 
@@ -40,14 +42,9 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
 	[BTF_KIND_DECL_TAG]	= "DECL_TAG",
 };
 
-struct btf_attach_table {
-	DECLARE_HASHTABLE(table, 16);
-};
-
 struct btf_attach_point {
 	__u32 obj_id;
 	__u32 btf_id;
-	struct hlist_node hash;
 };
 
 static const char *btf_int_enc_str(__u8 encoding)
@@ -645,21 +642,8 @@ static int btf_parse_fd(int *argc, char ***argv)
 	return fd;
 }
 
-static void delete_btf_table(struct btf_attach_table *tab)
-{
-	struct btf_attach_point *obj;
-	struct hlist_node *tmp;
-
-	unsigned int bkt;
-
-	hash_for_each_safe(tab->table, bkt, tmp, obj, hash) {
-		hash_del(&obj->hash);
-		free(obj);
-	}
-}
-
 static int
-build_btf_type_table(struct btf_attach_table *tab, enum bpf_obj_type type,
+build_btf_type_table(struct hashmap *tab, enum bpf_obj_type type,
 		     void *info, __u32 *len)
 {
 	static const char * const names[] = {
@@ -667,7 +651,6 @@ build_btf_type_table(struct btf_attach_table *tab, enum bpf_obj_type type,
 		[BPF_OBJ_PROG]		= "prog",
 		[BPF_OBJ_MAP]		= "map",
 	};
-	struct btf_attach_point *obj_node;
 	__u32 btf_id, id = 0;
 	int err;
 	int fd;
@@ -741,28 +724,25 @@ build_btf_type_table(struct btf_attach_table *tab, enum bpf_obj_type type,
 		if (!btf_id)
 			continue;
 
-		obj_node = calloc(1, sizeof(*obj_node));
-		if (!obj_node) {
-			p_err("failed to allocate memory: %s", strerror(errno));
-			err = -ENOMEM;
+		err = hashmap__append(tab, u32_as_hash_field(btf_id),
+				      u32_as_hash_field(id));
+		if (err) {
+			p_err("failed to append entry to hashmap for BTF ID %u, object ID %u: %s",
+			      btf_id, id, strerror(errno));
 			goto err_free;
 		}
-
-		obj_node->obj_id = id;
-		obj_node->btf_id = btf_id;
-		hash_add(tab->table, &obj_node->hash, obj_node->btf_id);
 	}
 
 	return 0;
 
 err_free:
-	delete_btf_table(tab);
+	hashmap__free(tab);
 	return err;
 }
 
 static int
-build_btf_tables(struct btf_attach_table *btf_prog_table,
-		 struct btf_attach_table *btf_map_table)
+build_btf_tables(struct hashmap *btf_prog_table,
+		 struct hashmap *btf_map_table)
 {
 	struct bpf_prog_info prog_info;
 	__u32 prog_len = sizeof(prog_info);
@@ -778,7 +758,7 @@ build_btf_tables(struct btf_attach_table *btf_prog_table,
 	err = build_btf_type_table(btf_map_table, BPF_OBJ_MAP, &map_info,
 				   &map_len);
 	if (err) {
-		delete_btf_table(btf_prog_table);
+		hashmap__free(btf_prog_table);
 		return err;
 	}
 
@@ -787,10 +767,10 @@ build_btf_tables(struct btf_attach_table *btf_prog_table,
 
 static void
 show_btf_plain(struct bpf_btf_info *info, int fd,
-	       struct btf_attach_table *btf_prog_table,
-	       struct btf_attach_table *btf_map_table)
+	       struct hashmap *btf_prog_table,
+	       struct hashmap *btf_map_table)
 {
-	struct btf_attach_point *obj;
+	struct hashmap_entry *entry;
 	const char *name = u64_to_ptr(info->name);
 	int n;
 
@@ -804,18 +784,19 @@ show_btf_plain(struct bpf_btf_info *info, int fd,
 	printf("size %uB", info->btf_size);
 
 	n = 0;
-	hash_for_each_possible(btf_prog_table->table, obj, hash, info->id) {
-		if (obj->btf_id == info->id)
-			printf("%s%u", n++ == 0 ? "  prog_ids " : ",",
-			       obj->obj_id);
+	hashmap__for_each_key_entry(btf_prog_table, entry,
+				    u32_as_hash_field(info->id)) {
+		printf("%s%u", n++ == 0 ? "  prog_ids " : ",",
+		       hash_field_as_u32(entry->value));
 	}
 
 	n = 0;
-	hash_for_each_possible(btf_map_table->table, obj, hash, info->id) {
-		if (obj->btf_id == info->id)
-			printf("%s%u", n++ == 0 ? "  map_ids " : ",",
-			       obj->obj_id);
+	hashmap__for_each_key_entry(btf_map_table, entry,
+				    u32_as_hash_field(info->id)) {
+		printf("%s%u", n++ == 0 ? "  map_ids " : ",",
+		       hash_field_as_u32(entry->value));
 	}
+
 	emit_obj_refs_plain(&refs_table, info->id, "\n\tpids ");
 
 	printf("\n");
@@ -823,10 +804,10 @@ show_btf_plain(struct bpf_btf_info *info, int fd,
 
 static void
 show_btf_json(struct bpf_btf_info *info, int fd,
-	      struct btf_attach_table *btf_prog_table,
-	      struct btf_attach_table *btf_map_table)
+	      struct hashmap *btf_prog_table,
+	      struct hashmap *btf_map_table)
 {
-	struct btf_attach_point *obj;
+	struct hashmap_entry *entry;
 	const char *name = u64_to_ptr(info->name);
 
 	jsonw_start_object(json_wtr);	/* btf object */
@@ -835,19 +816,17 @@ show_btf_json(struct bpf_btf_info *info, int fd,
 
 	jsonw_name(json_wtr, "prog_ids");
 	jsonw_start_array(json_wtr);	/* prog_ids */
-	hash_for_each_possible(btf_prog_table->table, obj, hash,
-			       info->id) {
-		if (obj->btf_id == info->id)
-			jsonw_uint(json_wtr, obj->obj_id);
+	hashmap__for_each_key_entry(btf_prog_table, entry,
+				    u32_as_hash_field(info->id)) {
+		jsonw_uint(json_wtr, hash_field_as_u32(entry->value));
 	}
 	jsonw_end_array(json_wtr);	/* prog_ids */
 
 	jsonw_name(json_wtr, "map_ids");
 	jsonw_start_array(json_wtr);	/* map_ids */
-	hash_for_each_possible(btf_map_table->table, obj, hash,
-			       info->id) {
-		if (obj->btf_id == info->id)
-			jsonw_uint(json_wtr, obj->obj_id);
+	hashmap__for_each_key_entry(btf_map_table, entry,
+				    u32_as_hash_field(info->id)) {
+		jsonw_uint(json_wtr, hash_field_as_u32(entry->value));
 	}
 	jsonw_end_array(json_wtr);	/* map_ids */
 
@@ -862,8 +841,8 @@ show_btf_json(struct bpf_btf_info *info, int fd,
 }
 
 static int
-show_btf(int fd, struct btf_attach_table *btf_prog_table,
-	 struct btf_attach_table *btf_map_table)
+show_btf(int fd, struct hashmap *btf_prog_table,
+	 struct hashmap *btf_map_table)
 {
 	struct bpf_btf_info info;
 	__u32 len = sizeof(info);
@@ -900,8 +879,8 @@ show_btf(int fd, struct btf_attach_table *btf_prog_table,
 
 static int do_show(int argc, char **argv)
 {
-	struct btf_attach_table btf_prog_table;
-	struct btf_attach_table btf_map_table;
+	struct hashmap *btf_prog_table;
+	struct hashmap *btf_map_table;
 	int err, fd = -1;
 	__u32 id = 0;
 
@@ -917,9 +896,19 @@ static int do_show(int argc, char **argv)
 		return BAD_ARG();
 	}
 
-	hash_init(btf_prog_table.table);
-	hash_init(btf_map_table.table);
-	err = build_btf_tables(&btf_prog_table, &btf_map_table);
+	btf_prog_table = hashmap__new(hash_fn_for_key_as_id,
+				      equal_fn_for_key_as_id, NULL);
+	btf_map_table = hashmap__new(hash_fn_for_key_as_id,
+				     equal_fn_for_key_as_id, NULL);
+	if (!btf_prog_table || !btf_map_table) {
+		hashmap__free(btf_prog_table);
+		hashmap__free(btf_map_table);
+		if (fd >= 0)
+			close(fd);
+		p_err("failed to create hashmap for object references");
+		return -1;
+	}
+	err = build_btf_tables(btf_prog_table, btf_map_table);
 	if (err) {
 		if (fd >= 0)
 			close(fd);
@@ -928,7 +917,7 @@ static int do_show(int argc, char **argv)
 	build_obj_refs_table(&refs_table, BPF_OBJ_BTF);
 
 	if (fd >= 0) {
-		err = show_btf(fd, &btf_prog_table, &btf_map_table);
+		err = show_btf(fd, btf_prog_table, btf_map_table);
 		close(fd);
 		goto exit_free;
 	}
@@ -960,7 +949,7 @@ static int do_show(int argc, char **argv)
 			break;
 		}
 
-		err = show_btf(fd, &btf_prog_table, &btf_map_table);
+		err = show_btf(fd, btf_prog_table, btf_map_table);
 		close(fd);
 		if (err)
 			break;
@@ -970,8 +959,8 @@ static int do_show(int argc, char **argv)
 		jsonw_end_array(json_wtr);	/* root array */
 
 exit_free:
-	delete_btf_table(&btf_prog_table);
-	delete_btf_table(&btf_map_table);
+	hashmap__free(btf_prog_table);
+	hashmap__free(btf_map_table);
 	delete_obj_refs_table(&refs_table);
 
 	return err;
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 0d64e39573f2..f6f2f951b193 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -256,6 +256,11 @@ static inline void *u32_as_hash_field(__u32 x)
 	return (void *)(uintptr_t)x;
 }
 
+static inline __u32 hash_field_as_u32(const void *x)
+{
+	return (__u32)(uintptr_t)x;
+}
+
 static inline bool hashmap__empty(struct hashmap *map)
 {
 	return map ? hashmap__size(map) == 0 : true;
-- 
2.30.2

