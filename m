Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6153616186
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 12:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiKBLNN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 07:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiKBLNI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 07:13:08 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175502934C
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 04:12:53 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id o12so27630702lfq.9
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 04:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgLxzjNAsv6/UyHJ6cTDbrrxfh7kUUvLVEu5NQM31yM=;
        b=YhQCdZmiYtDOliCjKIF3s/XBcpwN58qpNE4k1AtpURHLY4KajsEr6n0J2c6F93XOer
         WNMbIg9S2remPHhrr1zZxQNpH1102DCCqu13H+ZOgN8Zbked6pLbVxaVKjdxNIbXYf1x
         2nX8+S0pgrQ+S0aJTzEewC1xTEQQe0F+Ypu/uiqh7EWw/2GlPVqhW73Dmp2fLdlOePYo
         VbPPRv0437GcEx9DTAJrv7Yhb5vPywzcm0tZSMKOUF58G2iswOM4PoSGc/QxhjxZ0yL8
         8keFeyKH45YWcGC/8gX53B0r7HxT+SgBfpOthFp5e+yWjy0nJlALJp8Gfql4nWqY77l/
         kmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgLxzjNAsv6/UyHJ6cTDbrrxfh7kUUvLVEu5NQM31yM=;
        b=HyTzffPMKhOHiUXDeWLRmTWEGmCtANMn14wJv06zxjHWBvtq+lX0RNDo5jEvpwrwqg
         hfs4mxvUb4fYW5XsE01agkOpM6bokH6u8GBufqetkAtTm+RcDTsz7F7s+z5nSAm1H/PH
         acsE1wO16hLJZ47i7Eob6zXOgec+LYU+VtWCNf1B5ghHXKt+pZjc0BJql+zk9wnsPt9T
         cZTS080OT93f1IYCBCUtaAMDSqZurFGgutXW/6N3p3J5NjJY4gz9ByNpZ6IjqQeK42Z3
         rsudBsf2PYuLjwpIm/8wzvJZ59r7j2wHPtoO9MZ1DM7biSXJhsPiUeCDWfnf7mCDO8MK
         mjnQ==
X-Gm-Message-State: ACrzQf12cLs3zJF/+skMbrH8hZzCO5+bh/Ri3itOzF9cgMbGrGzwiBTj
        NY644i9L0rGpd7tdsK0I/umr5ASOS4RXa8Hr
X-Google-Smtp-Source: AMsMyM7mCf0Upyxp5fQtze3HhwkFbL2GRgQANCtJwlK/j6yG/IVp0bYKK/mQZNDBwoccEpmiIPrZHw==
X-Received: by 2002:a05:6512:218c:b0:4ab:c834:fa30 with SMTP id b12-20020a056512218c00b004abc834fa30mr8537859lft.621.1667387391409;
        Wed, 02 Nov 2022 04:09:51 -0700 (PDT)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id a6-20020a05651c010600b0026dcac60624sm2039781ljb.108.2022.11.02.04.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 04:09:50 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, alan.maguire@oracle.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 1/4] libbpf: hashmap interface update to uintptr_t -> uintptr_t
Date:   Wed,  2 Nov 2022 13:09:02 +0200
Message-Id: <20221102110905.2433622-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221102110905.2433622-1-eddyz87@gmail.com>
References: <20221102110905.2433622-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

An update for libbpf's hashmap interface from void* -> void* to
uintptr_t -> uintptr_t. Removes / simplifies some type casts when
hashmap keys or values are 32-bit integers. In libbpf hashmap is more
often used with integral keys / values rather than with pointer keys /
values.

This is a follow up for [1].

[1] https://lore.kernel.org/bpf/af1facf9-7bc8-8a3d-0db4-7b3f333589a2@meta.com/T/#m65b28f1d6d969fcd318b556db6a3ad499a42607d

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/bpf/bpftool/btf.c    | 23 ++++++++------------
 tools/bpf/bpftool/common.c | 10 ++++-----
 tools/bpf/bpftool/gen.c    | 19 +++++++----------
 tools/bpf/bpftool/link.c   |  8 +++----
 tools/bpf/bpftool/main.h   |  4 ++--
 tools/bpf/bpftool/map.c    |  8 +++----
 tools/bpf/bpftool/pids.c   | 16 +++++++-------
 tools/bpf/bpftool/prog.c   |  8 +++----
 tools/lib/bpf/btf.c        | 43 +++++++++++++++++++-------------------
 tools/lib/bpf/btf_dump.c   | 16 +++++++-------
 tools/lib/bpf/hashmap.c    | 16 +++++++-------
 tools/lib/bpf/hashmap.h    | 35 ++++++++++++++++---------------
 tools/lib/bpf/libbpf.c     | 18 ++++++----------
 tools/lib/bpf/strset.c     | 24 ++++++++++-----------
 tools/lib/bpf/usdt.c       | 31 +++++++++++++--------------
 15 files changed, 127 insertions(+), 152 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 68a70ac03c80..ccb3b8b0378b 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -815,8 +815,7 @@ build_btf_type_table(struct hashmap *tab, enum bpf_obj_type type,
 		if (!btf_id)
 			continue;
 
-		err = hashmap__append(tab, u32_as_hash_field(btf_id),
-				      u32_as_hash_field(id));
+		err = hashmap__append(tab, btf_id, id);
 		if (err) {
 			p_err("failed to append entry to hashmap for BTF ID %u, object ID %u: %s",
 			      btf_id, id, strerror(-err));
@@ -875,17 +874,15 @@ show_btf_plain(struct bpf_btf_info *info, int fd,
 	printf("size %uB", info->btf_size);
 
 	n = 0;
-	hashmap__for_each_key_entry(btf_prog_table, entry,
-				    u32_as_hash_field(info->id)) {
+	hashmap__for_each_key_entry(btf_prog_table, entry, info->id) {
 		printf("%s%u", n++ == 0 ? "  prog_ids " : ",",
-		       hash_field_as_u32(entry->value));
+		       (__u32)entry->value);
 	}
 
 	n = 0;
-	hashmap__for_each_key_entry(btf_map_table, entry,
-				    u32_as_hash_field(info->id)) {
+	hashmap__for_each_key_entry(btf_map_table, entry, info->id) {
 		printf("%s%u", n++ == 0 ? "  map_ids " : ",",
-		       hash_field_as_u32(entry->value));
+		       (__u32)entry->value);
 	}
 
 	emit_obj_refs_plain(refs_table, info->id, "\n\tpids ");
@@ -907,17 +904,15 @@ show_btf_json(struct bpf_btf_info *info, int fd,
 
 	jsonw_name(json_wtr, "prog_ids");
 	jsonw_start_array(json_wtr);	/* prog_ids */
-	hashmap__for_each_key_entry(btf_prog_table, entry,
-				    u32_as_hash_field(info->id)) {
-		jsonw_uint(json_wtr, hash_field_as_u32(entry->value));
+	hashmap__for_each_key_entry(btf_prog_table, entry, info->id) {
+		jsonw_uint(json_wtr, entry->value);
 	}
 	jsonw_end_array(json_wtr);	/* prog_ids */
 
 	jsonw_name(json_wtr, "map_ids");
 	jsonw_start_array(json_wtr);	/* map_ids */
-	hashmap__for_each_key_entry(btf_map_table, entry,
-				    u32_as_hash_field(info->id)) {
-		jsonw_uint(json_wtr, hash_field_as_u32(entry->value));
+	hashmap__for_each_key_entry(btf_map_table, entry, info->id) {
+		jsonw_uint(json_wtr, entry->value);
 	}
 	jsonw_end_array(json_wtr);	/* map_ids */
 
diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index e4d33bc8bbbf..7bfb9ea1dc66 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -494,7 +494,7 @@ static int do_build_table_cb(const char *fpath, const struct stat *sb,
 		goto out_close;
 	}
 
-	err = hashmap__append(build_fn_table, u32_as_hash_field(pinned_info.id), path);
+	err = hashmap__append(build_fn_table, pinned_info.id, (uintptr_t)path);
 	if (err) {
 		p_err("failed to append entry to hashmap for ID %u, path '%s': %s",
 		      pinned_info.id, path, strerror(errno));
@@ -545,7 +545,7 @@ void delete_pinned_obj_table(struct hashmap *map)
 		return;
 
 	hashmap__for_each_entry(map, entry, bkt)
-		free(entry->value);
+		free((char *)entry->value);
 
 	hashmap__free(map);
 }
@@ -1041,12 +1041,12 @@ int map_parse_fd_and_info(int *argc, char ***argv, void *info, __u32 *info_len)
 	return fd;
 }
 
-size_t hash_fn_for_key_as_id(const void *key, void *ctx)
+size_t hash_fn_for_key_as_id(uintptr_t key, void *ctx)
 {
-	return (size_t)key;
+	return key;
 }
 
-bool equal_fn_for_key_as_id(const void *k1, const void *k2, void *ctx)
+bool equal_fn_for_key_as_id(uintptr_t k1, uintptr_t k2, void *ctx)
 {
 	return k1 == k2;
 }
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index cf8b4e525c88..756327fcab98 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1660,21 +1660,16 @@ struct btfgen_info {
 	struct btf *marked_btf; /* btf structure used to mark used types */
 };
 
-static size_t btfgen_hash_fn(const void *key, void *ctx)
+static size_t btfgen_hash_fn(uintptr_t key, void *ctx)
 {
-	return (size_t)key;
+	return key;
 }
 
-static bool btfgen_equal_fn(const void *k1, const void *k2, void *ctx)
+static bool btfgen_equal_fn(uintptr_t k1, uintptr_t k2, void *ctx)
 {
 	return k1 == k2;
 }
 
-static void *u32_as_hash_key(__u32 x)
-{
-	return (void *)(uintptr_t)x;
-}
-
 static void btfgen_free_info(struct btfgen_info *info)
 {
 	if (!info)
@@ -2086,18 +2081,18 @@ static int btfgen_record_obj(struct btfgen_info *info, const char *obj_path)
 			struct bpf_core_spec specs_scratch[3] = {};
 			struct bpf_core_relo_res targ_res = {};
 			struct bpf_core_cand_list *cands = NULL;
-			const void *type_key = u32_as_hash_key(relo->type_id);
 			const char *sec_name = btf__name_by_offset(btf, sec->sec_name_off);
 
 			if (relo->kind != BPF_CORE_TYPE_ID_LOCAL &&
-			    !hashmap__find(cand_cache, type_key, (void **)&cands)) {
+			    !hashmap__find(cand_cache, relo->type_id, (uintptr_t *)&cands)) {
 				cands = btfgen_find_cands(btf, info->src_btf, relo->type_id);
 				if (!cands) {
 					err = -errno;
 					goto out;
 				}
 
-				err = hashmap__set(cand_cache, type_key, cands, NULL, NULL);
+				err = hashmap__set(cand_cache, relo->type_id, (uintptr_t)cands,
+						   NULL, NULL);
 				if (err)
 					goto out;
 			}
@@ -2120,7 +2115,7 @@ static int btfgen_record_obj(struct btfgen_info *info, const char *obj_path)
 
 	if (!IS_ERR_OR_NULL(cand_cache)) {
 		hashmap__for_each_entry(cand_cache, entry, i) {
-			bpf_core_free_cands(entry->value);
+			bpf_core_free_cands((struct bpf_core_cand_list *)entry->value);
 		}
 		hashmap__free(cand_cache);
 	}
diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 2863639706dd..54c7eccff8e1 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -204,9 +204,8 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 
 		jsonw_name(json_wtr, "pinned");
 		jsonw_start_array(json_wtr);
-		hashmap__for_each_key_entry(link_table, entry,
-					    u32_as_hash_field(info->id))
-			jsonw_string(json_wtr, entry->value);
+		hashmap__for_each_key_entry(link_table, entry, info->id)
+			jsonw_string(json_wtr, (char *)entry->value);
 		jsonw_end_array(json_wtr);
 	}
 
@@ -309,8 +308,7 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 	if (!hashmap__empty(link_table)) {
 		struct hashmap_entry *entry;
 
-		hashmap__for_each_key_entry(link_table, entry,
-					    u32_as_hash_field(info->id))
+		hashmap__for_each_key_entry(link_table, entry, info->id)
 			printf("\n\tpinned %s", (char *)entry->value);
 	}
 	emit_obj_refs_plain(refs_table, info->id, "\n\tpids ");
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 467d8472df0c..e0be216da944 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -240,8 +240,8 @@ int do_filter_dump(struct tcmsg *ifinfo, struct nlattr **tb, const char *kind,
 int print_all_levels(__maybe_unused enum libbpf_print_level level,
 		     const char *format, va_list args);
 
-size_t hash_fn_for_key_as_id(const void *key, void *ctx);
-bool equal_fn_for_key_as_id(const void *k1, const void *k2, void *ctx);
+size_t hash_fn_for_key_as_id(uintptr_t key, void *ctx);
+bool equal_fn_for_key_as_id(uintptr_t k1, uintptr_t k2, void *ctx);
 
 /* bpf_attach_type_input_str - convert the provided attach type value into a
  * textual representation that we accept for input purposes.
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index f941ac5c7b73..dbee1bbd6a0c 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -518,9 +518,8 @@ static int show_map_close_json(int fd, struct bpf_map_info *info)
 
 		jsonw_name(json_wtr, "pinned");
 		jsonw_start_array(json_wtr);
-		hashmap__for_each_key_entry(map_table, entry,
-					    u32_as_hash_field(info->id))
-			jsonw_string(json_wtr, entry->value);
+		hashmap__for_each_key_entry(map_table, entry, info->id)
+			jsonw_string(json_wtr, (char *)entry->value);
 		jsonw_end_array(json_wtr);
 	}
 
@@ -595,8 +594,7 @@ static int show_map_close_plain(int fd, struct bpf_map_info *info)
 	if (!hashmap__empty(map_table)) {
 		struct hashmap_entry *entry;
 
-		hashmap__for_each_key_entry(map_table, entry,
-					    u32_as_hash_field(info->id))
+		hashmap__for_each_key_entry(map_table, entry, info->id)
 			printf("\n\tpinned %s", (char *)entry->value);
 	}
 
diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
index bb6c969a114a..e01ff78610cf 100644
--- a/tools/bpf/bpftool/pids.c
+++ b/tools/bpf/bpftool/pids.c
@@ -36,8 +36,8 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
 	int err, i;
 	void *tmp;
 
-	hashmap__for_each_key_entry(map, entry, u32_as_hash_field(e->id)) {
-		refs = entry->value;
+	hashmap__for_each_key_entry(map, entry, e->id) {
+		refs = (struct obj_refs *)entry->value;
 
 		for (i = 0; i < refs->ref_cnt; i++) {
 			if (refs->refs[i].pid == e->pid)
@@ -81,7 +81,7 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
 	refs->has_bpf_cookie = e->has_bpf_cookie;
 	refs->bpf_cookie = e->bpf_cookie;
 
-	err = hashmap__append(map, u32_as_hash_field(e->id), refs);
+	err = hashmap__append(map, e->id, (uintptr_t)refs);
 	if (err)
 		p_err("failed to append entry to hashmap for ID %u: %s",
 		      e->id, strerror(errno));
@@ -183,7 +183,7 @@ void delete_obj_refs_table(struct hashmap *map)
 		return;
 
 	hashmap__for_each_entry(map, entry, bkt) {
-		struct obj_refs *refs = entry->value;
+		struct obj_refs *refs = (struct obj_refs *)entry->value;
 
 		free(refs->refs);
 		free(refs);
@@ -200,8 +200,8 @@ void emit_obj_refs_json(struct hashmap *map, __u32 id,
 	if (hashmap__empty(map))
 		return;
 
-	hashmap__for_each_key_entry(map, entry, u32_as_hash_field(id)) {
-		struct obj_refs *refs = entry->value;
+	hashmap__for_each_key_entry(map, entry, id) {
+		struct obj_refs *refs = (struct obj_refs *)entry->value;
 		int i;
 
 		if (refs->ref_cnt == 0)
@@ -232,8 +232,8 @@ void emit_obj_refs_plain(struct hashmap *map, __u32 id, const char *prefix)
 	if (hashmap__empty(map))
 		return;
 
-	hashmap__for_each_key_entry(map, entry, u32_as_hash_field(id)) {
-		struct obj_refs *refs = entry->value;
+	hashmap__for_each_key_entry(map, entry, id) {
+		struct obj_refs *refs = (struct obj_refs *)entry->value;
 		int i;
 
 		if (refs->ref_cnt == 0)
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index a858b907da16..18d8da67c7e8 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -486,9 +486,8 @@ static void print_prog_json(struct bpf_prog_info *info, int fd)
 
 		jsonw_name(json_wtr, "pinned");
 		jsonw_start_array(json_wtr);
-		hashmap__for_each_key_entry(prog_table, entry,
-					    u32_as_hash_field(info->id))
-			jsonw_string(json_wtr, entry->value);
+		hashmap__for_each_key_entry(prog_table, entry, info->id)
+			jsonw_string(json_wtr, (char *)entry->value);
 		jsonw_end_array(json_wtr);
 	}
 
@@ -561,8 +560,7 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd)
 	if (!hashmap__empty(prog_table)) {
 		struct hashmap_entry *entry;
 
-		hashmap__for_each_key_entry(prog_table, entry,
-					    u32_as_hash_field(info->id))
+		hashmap__for_each_key_entry(prog_table, entry, info->id)
 			printf("\n\tpinned %s", (char *)entry->value);
 	}
 
diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 675a0df5c840..04db202aac3d 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1559,15 +1559,15 @@ struct btf_pipe {
 static int btf_rewrite_str(__u32 *str_off, void *ctx)
 {
 	struct btf_pipe *p = ctx;
-	void *mapped_off;
+	uintptr_t mapped_off;
 	int off, err;
 
 	if (!*str_off) /* nothing to do for empty strings */
 		return 0;
 
 	if (p->str_off_map &&
-	    hashmap__find(p->str_off_map, (void *)(long)*str_off, &mapped_off)) {
-		*str_off = (__u32)(long)mapped_off;
+	    hashmap__find(p->str_off_map, *str_off, &mapped_off)) {
+		*str_off = mapped_off;
 		return 0;
 	}
 
@@ -1579,7 +1579,7 @@ static int btf_rewrite_str(__u32 *str_off, void *ctx)
 	 * performing expensive string comparisons.
 	 */
 	if (p->str_off_map) {
-		err = hashmap__append(p->str_off_map, (void *)(long)*str_off, (void *)(long)off);
+		err = hashmap__append(p->str_off_map, *str_off, off);
 		if (err)
 			return err;
 	}
@@ -1630,8 +1630,8 @@ static int btf_rewrite_type_ids(__u32 *type_id, void *ctx)
 	return 0;
 }
 
-static size_t btf_dedup_identity_hash_fn(const void *key, void *ctx);
-static bool btf_dedup_equal_fn(const void *k1, const void *k2, void *ctx);
+static size_t btf_dedup_identity_hash_fn(uintptr_t key, void *ctx);
+static bool btf_dedup_equal_fn(uintptr_t k1, uintptr_t k2, void *ctx);
 
 int btf__add_btf(struct btf *btf, const struct btf *src_btf)
 {
@@ -3126,12 +3126,11 @@ static long hash_combine(long h, long value)
 }
 
 #define for_each_dedup_cand(d, node, hash) \
-	hashmap__for_each_key_entry(d->dedup_table, node, (void *)hash)
+	hashmap__for_each_key_entry(d->dedup_table, node, hash)
 
 static int btf_dedup_table_add(struct btf_dedup *d, long hash, __u32 type_id)
 {
-	return hashmap__append(d->dedup_table,
-			       (void *)hash, (void *)(long)type_id);
+	return hashmap__append(d->dedup_table, hash, type_id);
 }
 
 static int btf_dedup_hypot_map_add(struct btf_dedup *d,
@@ -3178,17 +3177,17 @@ static void btf_dedup_free(struct btf_dedup *d)
 	free(d);
 }
 
-static size_t btf_dedup_identity_hash_fn(const void *key, void *ctx)
+static size_t btf_dedup_identity_hash_fn(uintptr_t key, void *ctx)
 {
-	return (size_t)key;
+	return key;
 }
 
-static size_t btf_dedup_collision_hash_fn(const void *key, void *ctx)
+static size_t btf_dedup_collision_hash_fn(uintptr_t key, void *ctx)
 {
 	return 0;
 }
 
-static bool btf_dedup_equal_fn(const void *k1, const void *k2, void *ctx)
+static bool btf_dedup_equal_fn(uintptr_t k1, uintptr_t k2, void *ctx)
 {
 	return k1 == k2;
 }
@@ -3753,7 +3752,7 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
 	case BTF_KIND_INT:
 		h = btf_hash_int_decl_tag(t);
 		for_each_dedup_cand(d, hash_entry, h) {
-			cand_id = (__u32)(long)hash_entry->value;
+			cand_id = hash_entry->value;
 			cand = btf_type_by_id(d->btf, cand_id);
 			if (btf_equal_int_tag(t, cand)) {
 				new_id = cand_id;
@@ -3765,7 +3764,7 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
 	case BTF_KIND_ENUM:
 		h = btf_hash_enum(t);
 		for_each_dedup_cand(d, hash_entry, h) {
-			cand_id = (__u32)(long)hash_entry->value;
+			cand_id = hash_entry->value;
 			cand = btf_type_by_id(d->btf, cand_id);
 			if (btf_equal_enum(t, cand)) {
 				new_id = cand_id;
@@ -3786,7 +3785,7 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
 	case BTF_KIND_ENUM64:
 		h = btf_hash_enum(t);
 		for_each_dedup_cand(d, hash_entry, h) {
-			cand_id = (__u32)(long)hash_entry->value;
+			cand_id = hash_entry->value;
 			cand = btf_type_by_id(d->btf, cand_id);
 			if (btf_equal_enum64(t, cand)) {
 				new_id = cand_id;
@@ -3808,7 +3807,7 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
 	case BTF_KIND_FLOAT:
 		h = btf_hash_common(t);
 		for_each_dedup_cand(d, hash_entry, h) {
-			cand_id = (__u32)(long)hash_entry->value;
+			cand_id = hash_entry->value;
 			cand = btf_type_by_id(d->btf, cand_id);
 			if (btf_equal_common(t, cand)) {
 				new_id = cand_id;
@@ -4313,7 +4312,7 @@ static int btf_dedup_struct_type(struct btf_dedup *d, __u32 type_id)
 
 	h = btf_hash_struct(t);
 	for_each_dedup_cand(d, hash_entry, h) {
-		__u32 cand_id = (__u32)(long)hash_entry->value;
+		__u32 cand_id = hash_entry->value;
 		int eq;
 
 		/*
@@ -4418,7 +4417,7 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
 
 		h = btf_hash_common(t);
 		for_each_dedup_cand(d, hash_entry, h) {
-			cand_id = (__u32)(long)hash_entry->value;
+			cand_id = hash_entry->value;
 			cand = btf_type_by_id(d->btf, cand_id);
 			if (btf_equal_common(t, cand)) {
 				new_id = cand_id;
@@ -4435,7 +4434,7 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
 
 		h = btf_hash_int_decl_tag(t);
 		for_each_dedup_cand(d, hash_entry, h) {
-			cand_id = (__u32)(long)hash_entry->value;
+			cand_id = hash_entry->value;
 			cand = btf_type_by_id(d->btf, cand_id);
 			if (btf_equal_int_tag(t, cand)) {
 				new_id = cand_id;
@@ -4459,7 +4458,7 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
 
 		h = btf_hash_array(t);
 		for_each_dedup_cand(d, hash_entry, h) {
-			cand_id = (__u32)(long)hash_entry->value;
+			cand_id = hash_entry->value;
 			cand = btf_type_by_id(d->btf, cand_id);
 			if (btf_equal_array(t, cand)) {
 				new_id = cand_id;
@@ -4491,7 +4490,7 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
 
 		h = btf_hash_fnproto(t);
 		for_each_dedup_cand(d, hash_entry, h) {
-			cand_id = (__u32)(long)hash_entry->value;
+			cand_id = hash_entry->value;
 			cand = btf_type_by_id(d->btf, cand_id);
 			if (btf_equal_fnproto(t, cand)) {
 				new_id = cand_id;
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index bf0cc0e986dd..ad0585410e51 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -117,14 +117,14 @@ struct btf_dump {
 	struct btf_dump_data *typed_dump;
 };
 
-static size_t str_hash_fn(const void *key, void *ctx)
+static size_t str_hash_fn(uintptr_t key, void *ctx)
 {
-	return str_hash(key);
+	return str_hash((void *)key);
 }
 
-static bool str_equal_fn(const void *a, const void *b, void *ctx)
+static bool str_equal_fn(uintptr_t a, uintptr_t b, void *ctx)
 {
-	return strcmp(a, b) == 0;
+	return strcmp((void *)a, (void *)b) == 0;
 }
 
 static const char *btf_name_of(const struct btf_dump *d, __u32 name_off)
@@ -1536,18 +1536,18 @@ static size_t btf_dump_name_dups(struct btf_dump *d, struct hashmap *name_map,
 				 const char *orig_name)
 {
 	char *old_name, *new_name;
-	size_t dup_cnt = 0;
+	uintptr_t dup_cnt = 0;
 	int err;
 
 	new_name = strdup(orig_name);
 	if (!new_name)
 		return 1;
 
-	hashmap__find(name_map, orig_name, (void **)&dup_cnt);
+	hashmap__find(name_map, (uintptr_t)orig_name, &dup_cnt);
 	dup_cnt++;
 
-	err = hashmap__set(name_map, new_name, (void *)dup_cnt,
-			   (const void **)&old_name, NULL);
+	err = hashmap__set(name_map, (uintptr_t)new_name, dup_cnt,
+			   (uintptr_t *)&old_name, NULL);
 	if (err)
 		free(new_name);
 
diff --git a/tools/lib/bpf/hashmap.c b/tools/lib/bpf/hashmap.c
index aeb09c288716..0d880e6367d5 100644
--- a/tools/lib/bpf/hashmap.c
+++ b/tools/lib/bpf/hashmap.c
@@ -128,7 +128,7 @@ static int hashmap_grow(struct hashmap *map)
 }
 
 static bool hashmap_find_entry(const struct hashmap *map,
-			       const void *key, size_t hash,
+			       const uintptr_t key, size_t hash,
 			       struct hashmap_entry ***pprev,
 			       struct hashmap_entry **entry)
 {
@@ -151,18 +151,18 @@ static bool hashmap_find_entry(const struct hashmap *map,
 	return false;
 }
 
-int hashmap__insert(struct hashmap *map, const void *key, void *value,
+int hashmap__insert(struct hashmap *map, uintptr_t key, uintptr_t value,
 		    enum hashmap_insert_strategy strategy,
-		    const void **old_key, void **old_value)
+		    uintptr_t *old_key, uintptr_t *old_value)
 {
 	struct hashmap_entry *entry;
 	size_t h;
 	int err;
 
 	if (old_key)
-		*old_key = NULL;
+		*old_key = 0;
 	if (old_value)
-		*old_value = NULL;
+		*old_value = 0;
 
 	h = hash_bits(map->hash_fn(key, map->ctx), map->cap_bits);
 	if (strategy != HASHMAP_APPEND &&
@@ -203,7 +203,7 @@ int hashmap__insert(struct hashmap *map, const void *key, void *value,
 	return 0;
 }
 
-bool hashmap__find(const struct hashmap *map, const void *key, void **value)
+bool hashmap__find(const struct hashmap *map, uintptr_t key, uintptr_t *value)
 {
 	struct hashmap_entry *entry;
 	size_t h;
@@ -217,8 +217,8 @@ bool hashmap__find(const struct hashmap *map, const void *key, void **value)
 	return true;
 }
 
-bool hashmap__delete(struct hashmap *map, const void *key,
-		     const void **old_key, void **old_value)
+bool hashmap__delete(struct hashmap *map, uintptr_t key,
+		     uintptr_t *old_key, uintptr_t *old_value)
 {
 	struct hashmap_entry **pprev, *entry;
 	size_t h;
diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
index 10a4c4cd13cf..8e72a238caa2 100644
--- a/tools/lib/bpf/hashmap.h
+++ b/tools/lib/bpf/hashmap.h
@@ -40,12 +40,15 @@ static inline size_t str_hash(const char *s)
 	return h;
 }
 
-typedef size_t (*hashmap_hash_fn)(const void *key, void *ctx);
-typedef bool (*hashmap_equal_fn)(const void *key1, const void *key2, void *ctx);
+/* keys and values are represented by uintptr_t to allow usage of both
+ * pointers and 32-bit unsigned integers as keys or values.
+ */
+typedef size_t (*hashmap_hash_fn)(uintptr_t key, void *ctx);
+typedef bool (*hashmap_equal_fn)(uintptr_t key1, uintptr_t key2, void *ctx);
 
 struct hashmap_entry {
-	const void *key;
-	void *value;
+	uintptr_t key;
+	uintptr_t value;
 	struct hashmap_entry *next;
 };
 
@@ -109,42 +112,40 @@ enum hashmap_insert_strategy {
  * through old_key and old_value to allow calling code do proper memory
  * management.
  */
-int hashmap__insert(struct hashmap *map, const void *key, void *value,
+int hashmap__insert(struct hashmap *map, uintptr_t key, uintptr_t value,
 		    enum hashmap_insert_strategy strategy,
-		    const void **old_key, void **old_value);
+		    uintptr_t *old_key, uintptr_t *old_value);
 
-static inline int hashmap__add(struct hashmap *map,
-			       const void *key, void *value)
+static inline int hashmap__add(struct hashmap *map, uintptr_t key, uintptr_t value)
 {
 	return hashmap__insert(map, key, value, HASHMAP_ADD, NULL, NULL);
 }
 
 static inline int hashmap__set(struct hashmap *map,
-			       const void *key, void *value,
-			       const void **old_key, void **old_value)
+			       uintptr_t key, uintptr_t value,
+			       uintptr_t *old_key, uintptr_t *old_value)
 {
 	return hashmap__insert(map, key, value, HASHMAP_SET,
 			       old_key, old_value);
 }
 
 static inline int hashmap__update(struct hashmap *map,
-				  const void *key, void *value,
-				  const void **old_key, void **old_value)
+				  uintptr_t key, uintptr_t value,
+				  uintptr_t *old_key, uintptr_t *old_value)
 {
 	return hashmap__insert(map, key, value, HASHMAP_UPDATE,
 			       old_key, old_value);
 }
 
-static inline int hashmap__append(struct hashmap *map,
-				  const void *key, void *value)
+static inline int hashmap__append(struct hashmap *map, uintptr_t key, uintptr_t value)
 {
 	return hashmap__insert(map, key, value, HASHMAP_APPEND, NULL, NULL);
 }
 
-bool hashmap__delete(struct hashmap *map, const void *key,
-		     const void **old_key, void **old_value);
+bool hashmap__delete(struct hashmap *map, uintptr_t key,
+		     uintptr_t *old_key, uintptr_t *old_value);
 
-bool hashmap__find(const struct hashmap *map, const void *key, void **value);
+bool hashmap__find(const struct hashmap *map, uintptr_t key, uintptr_t *value);
 
 /*
  * hashmap__for_each_entry - iterate over all entries in hashmap
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5d7819edf074..7c9c1770db13 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5601,21 +5601,16 @@ int bpf_core_types_match(const struct btf *local_btf, __u32 local_id,
 	return __bpf_core_types_match(local_btf, local_id, targ_btf, targ_id, false, 32);
 }
 
-static size_t bpf_core_hash_fn(const void *key, void *ctx)
+static size_t bpf_core_hash_fn(const uintptr_t key, void *ctx)
 {
-	return (size_t)key;
+	return key;
 }
 
-static bool bpf_core_equal_fn(const void *k1, const void *k2, void *ctx)
+static bool bpf_core_equal_fn(const uintptr_t k1, const uintptr_t k2, void *ctx)
 {
 	return k1 == k2;
 }
 
-static void *u32_as_hash_key(__u32 x)
-{
-	return (void *)(uintptr_t)x;
-}
-
 static int record_relo_core(struct bpf_program *prog,
 			    const struct bpf_core_relo *core_relo, int insn_idx)
 {
@@ -5658,7 +5653,6 @@ static int bpf_core_resolve_relo(struct bpf_program *prog,
 				 struct bpf_core_relo_res *targ_res)
 {
 	struct bpf_core_spec specs_scratch[3] = {};
-	const void *type_key = u32_as_hash_key(relo->type_id);
 	struct bpf_core_cand_list *cands = NULL;
 	const char *prog_name = prog->name;
 	const struct btf_type *local_type;
@@ -5675,7 +5669,7 @@ static int bpf_core_resolve_relo(struct bpf_program *prog,
 		return -EINVAL;
 
 	if (relo->kind != BPF_CORE_TYPE_ID_LOCAL &&
-	    !hashmap__find(cand_cache, type_key, (void **)&cands)) {
+	    !hashmap__find(cand_cache, local_id, (uintptr_t *)&cands)) {
 		cands = bpf_core_find_cands(prog->obj, local_btf, local_id);
 		if (IS_ERR(cands)) {
 			pr_warn("prog '%s': relo #%d: target candidate search failed for [%d] %s %s: %ld\n",
@@ -5683,7 +5677,7 @@ static int bpf_core_resolve_relo(struct bpf_program *prog,
 				local_name, PTR_ERR(cands));
 			return PTR_ERR(cands);
 		}
-		err = hashmap__set(cand_cache, type_key, cands, NULL, NULL);
+		err = hashmap__set(cand_cache, local_id, (uintptr_t)cands, NULL, NULL);
 		if (err) {
 			bpf_core_free_cands(cands);
 			return err;
@@ -5806,7 +5800,7 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 
 	if (!IS_ERR_OR_NULL(cand_cache)) {
 		hashmap__for_each_entry(cand_cache, entry, i) {
-			bpf_core_free_cands(entry->value);
+			bpf_core_free_cands((struct bpf_core_cand_list *)entry->value);
 		}
 		hashmap__free(cand_cache);
 	}
diff --git a/tools/lib/bpf/strset.c b/tools/lib/bpf/strset.c
index ea655318153f..e467d0c0ab1a 100644
--- a/tools/lib/bpf/strset.c
+++ b/tools/lib/bpf/strset.c
@@ -19,19 +19,19 @@ struct strset {
 	struct hashmap *strs_hash;
 };
 
-static size_t strset_hash_fn(const void *key, void *ctx)
+static size_t strset_hash_fn(uintptr_t key, void *ctx)
 {
 	const struct strset *s = ctx;
-	const char *str = s->strs_data + (long)key;
+	const char *str = s->strs_data + key;
 
 	return str_hash(str);
 }
 
-static bool strset_equal_fn(const void *key1, const void *key2, void *ctx)
+static bool strset_equal_fn(uintptr_t key1, uintptr_t key2, void *ctx)
 {
 	const struct strset *s = ctx;
-	const char *str1 = s->strs_data + (long)key1;
-	const char *str2 = s->strs_data + (long)key2;
+	const char *str1 = s->strs_data + key1;
+	const char *str2 = s->strs_data + key2;
 
 	return strcmp(str1, str2) == 0;
 }
@@ -53,7 +53,7 @@ struct strset *strset__new(size_t max_data_sz, const char *init_data, size_t ini
 	set->strs_hash = hash;
 
 	if (init_data) {
-		long off;
+		uintptr_t off;
 
 		set->strs_data = malloc(init_data_sz);
 		if (!set->strs_data)
@@ -67,7 +67,7 @@ struct strset *strset__new(size_t max_data_sz, const char *init_data, size_t ini
 			/* hashmap__add() returns EEXIST if string with the same
 			 * content already is in the hash map
 			 */
-			err = hashmap__add(hash, (void *)off, (void *)off);
+			err = hashmap__add(hash, off, off);
 			if (err == -EEXIST)
 				continue; /* duplicate */
 			if (err)
@@ -115,7 +115,7 @@ static void *strset_add_str_mem(struct strset *set, size_t add_sz)
  */
 int strset__find_str(struct strset *set, const char *s)
 {
-	long old_off, new_off, len;
+	uintptr_t old_off, new_off, len;
 	void *p;
 
 	/* see strset__add_str() for why we do this */
@@ -127,7 +127,7 @@ int strset__find_str(struct strset *set, const char *s)
 	new_off = set->strs_data_len;
 	memcpy(p, s, len);
 
-	if (hashmap__find(set->strs_hash, (void *)new_off, (void **)&old_off))
+	if (hashmap__find(set->strs_hash, new_off, &old_off))
 		return old_off;
 
 	return -ENOENT;
@@ -141,7 +141,7 @@ int strset__find_str(struct strset *set, const char *s)
  */
 int strset__add_str(struct strset *set, const char *s)
 {
-	long old_off, new_off, len;
+	uintptr_t old_off, new_off, len;
 	void *p;
 	int err;
 
@@ -165,8 +165,8 @@ int strset__add_str(struct strset *set, const char *s)
 	 * contents doesn't exist already (HASHMAP_ADD strategy). If such
 	 * string exists, we'll get its offset in old_off (that's old_key).
 	 */
-	err = hashmap__insert(set->strs_hash, (void *)new_off, (void *)new_off,
-			      HASHMAP_ADD, (const void **)&old_off, NULL);
+	err = hashmap__insert(set->strs_hash, new_off, new_off,
+			      HASHMAP_ADD, &old_off, NULL);
 	if (err == -EEXIST)
 		return old_off; /* duplicated string, return existing offset */
 	if (err)
diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 28fa1b2283de..aa7ca3652db8 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -873,31 +873,27 @@ static void bpf_link_usdt_dealloc(struct bpf_link *link)
 	free(usdt_link);
 }
 
-static size_t specs_hash_fn(const void *key, void *ctx)
+static size_t specs_hash_fn(uintptr_t key, void *ctx)
 {
-	const char *s = key;
-
-	return str_hash(s);
+	return str_hash((char *)key);
 }
 
-static bool specs_equal_fn(const void *key1, const void *key2, void *ctx)
+static bool specs_equal_fn(uintptr_t key1, uintptr_t key2, void *ctx)
 {
-	const char *s1 = key1;
-	const char *s2 = key2;
-
-	return strcmp(s1, s2) == 0;
+	return strcmp((char *)key1, (char *)key2) == 0;
 }
 
 static int allocate_spec_id(struct usdt_manager *man, struct hashmap *specs_hash,
 			    struct bpf_link_usdt *link, struct usdt_target *target,
 			    int *spec_id, bool *is_new)
 {
-	void *tmp;
+	uintptr_t tmp;
+	void *new_ids;
 	int err;
 
 	/* check if we already allocated spec ID for this spec string */
-	if (hashmap__find(specs_hash, target->spec_str, &tmp)) {
-		*spec_id = (long)tmp;
+	if (hashmap__find(specs_hash, (uintptr_t)target->spec_str, &tmp)) {
+		*spec_id = tmp;
 		*is_new = false;
 		return 0;
 	}
@@ -905,17 +901,18 @@ static int allocate_spec_id(struct usdt_manager *man, struct hashmap *specs_hash
 	/* otherwise it's a new ID that needs to be set up in specs map and
 	 * returned back to usdt_manager when USDT link is detached
 	 */
-	tmp = libbpf_reallocarray(link->spec_ids, link->spec_cnt + 1, sizeof(*link->spec_ids));
-	if (!tmp)
+	new_ids = libbpf_reallocarray(link->spec_ids, link->spec_cnt + 1,
+				      sizeof(*link->spec_ids));
+	if (!new_ids)
 		return -ENOMEM;
-	link->spec_ids = tmp;
+	link->spec_ids = new_ids;
 
 	/* get next free spec ID, giving preference to free list, if not empty */
 	if (man->free_spec_cnt) {
 		*spec_id = man->free_spec_ids[man->free_spec_cnt - 1];
 
 		/* cache spec ID for current spec string for future lookups */
-		err = hashmap__add(specs_hash, target->spec_str, (void *)(long)*spec_id);
+		err = hashmap__add(specs_hash, (uintptr_t)target->spec_str, *spec_id);
 		if (err)
 			 return err;
 
@@ -928,7 +925,7 @@ static int allocate_spec_id(struct usdt_manager *man, struct hashmap *specs_hash
 		*spec_id = man->next_free_spec_id;
 
 		/* cache spec ID for current spec string for future lookups */
-		err = hashmap__add(specs_hash, target->spec_str, (void *)(long)*spec_id);
+		err = hashmap__add(specs_hash, (uintptr_t)target->spec_str, *spec_id);
 		if (err)
 			 return err;
 
-- 
2.34.1

