Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D505661E5E7
	for <lists+bpf@lfdr.de>; Sun,  6 Nov 2022 21:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiKFU3w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Nov 2022 15:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiKFU3v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Nov 2022 15:29:51 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D1DBC2C
        for <bpf@vger.kernel.org>; Sun,  6 Nov 2022 12:29:47 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so8478911wmb.2
        for <bpf@vger.kernel.org>; Sun, 06 Nov 2022 12:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3WtPoqc0IPVBExYUWEYt9eS1zE4r2yoAWt+00Xtsv4=;
        b=F2GRsvhRCnQvJJBe9TcBjBpKiAWIDuZ+ItJdffAfbNg8pxf0wC5M1t5F5lk6IBijV2
         wBfi89f4N8g8oPZY5c7VoauHZqVesUTsQFuwzJhcWo1hCdvMYBBLZ3dfPlZXmsTdzujJ
         cswdBeWqwls6RZaM3gOETpeiyd7B/wpAzlfoOAT3mB9Gpw3ojX4J+sZktYQl/nIwAamW
         +76XL+1ZGu6NOdFBiI1pKdMHr8vgZ+daaeodKEZEuE42AUB6XRZ2IkGhHj4sjabcnDD8
         gsTb5mDhctjr1PMal7ANJTSQvwwIv3ffbTl/mGtFTYSYpUVsWeV68yaCAuwMmoEDeqgl
         dcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3WtPoqc0IPVBExYUWEYt9eS1zE4r2yoAWt+00Xtsv4=;
        b=OZj/12Nj4SICSl31jdeta86tsly+WMbjaOEiVfA8TTBcL919x9qp0d7/uHM0NSZ4Zv
         1BABWbXctcUsS99Gk5kmGDz8nGETRcFHg8280bPe0k32dwflD4Y8Y8crPWuYQaHeC1m/
         9EJilHU+Ypwpqn3zpd1WdDwg6qB29eDVGcvmd/mYldZHT+SPtiV9JTyhcA0U7oAJ8SCD
         Hk1cHoktDrWe60YhV8nfpIZJ0+/KVyo9yt5krnrnf1WdDz9qQKbzuR8YAO74J1qwVsAr
         jYgtzEBFTwsObuCCe8nrBKWBzdGLq/q8E76D7fat6rNz+tz/HSi7WG2JXkiIpg9O+EIq
         cgzw==
X-Gm-Message-State: ACrzQf13BTFaIuGjIkrzKQLCiGrXZ9uVGRf/RppodBURsjZtTmzw7pgQ
        GW+k7u8FDIhBL7RNmDc2nipnO8oV6QB7y0yT
X-Google-Smtp-Source: AMsMyM5OTboFXgdo2i3yDRkkRw05aQvSUkGEvMhKFR2QciEPGUg2d9oF3pQj/hSlvdS1KGvnC1v9PA==
X-Received: by 2002:a05:600c:4f14:b0:3a8:3e30:8436 with SMTP id l20-20020a05600c4f1400b003a83e308436mr507865wmq.182.1667766585196;
        Sun, 06 Nov 2022 12:29:45 -0800 (PST)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id q188-20020a1c43c5000000b003cf894c05e4sm9358636wma.22.2022.11.06.12.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 12:29:44 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, alan.maguire@oracle.com, acme@kernel.org,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 1/3] libbpf: hashmap interface update to long -> long
Date:   Sun,  6 Nov 2022 22:29:08 +0200
Message-Id: <20221106202910.4193104-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221106202910.4193104-1-eddyz87@gmail.com>
References: <20221106202910.4193104-1-eddyz87@gmail.com>
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
long -> long. Removes / simplifies some type casts when hashmap
keys or values are 32-bit integers.

In libbpf hashmap is more often used with integral keys / values
rather than with pointer keys / values.

Perf copies hashmap implementation from libbpf and has to be
updated as well.

Changes to libbpf, selftests/bpf and perf are packed as a single
commit to avoid compilation issues with any future bisect.

The net number of casts is decreased after this refactoring. Although
perf mostly uses ptr to ptr maps, thus a lot of casts have to be
added there:

             Casts    Casts
             removed  added
libbpf       ~50      ~20
libbpf tests ~55      ~0
perf         ~0       ~33
perf tests   ~0       ~13

This is a follow up for [1].

[1] https://lore.kernel.org/bpf/af1facf9-7bc8-8a3d-0db4-7b3f333589a2@meta.com/T/#m65b28f1d6d969fcd318b556db6a3ad499a42607d

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/bpf/bpftool/btf.c                       |  25 ++---
 tools/bpf/bpftool/common.c                    |  10 +-
 tools/bpf/bpftool/gen.c                       |  19 ++--
 tools/bpf/bpftool/link.c                      |   8 +-
 tools/bpf/bpftool/main.h                      |  14 +--
 tools/bpf/bpftool/map.c                       |   8 +-
 tools/bpf/bpftool/pids.c                      |  16 +--
 tools/bpf/bpftool/prog.c                      |   8 +-
 tools/lib/bpf/btf.c                           |  41 ++++---
 tools/lib/bpf/btf_dump.c                      |  16 +--
 tools/lib/bpf/hashmap.c                       |  16 +--
 tools/lib/bpf/hashmap.h                       |  34 +++---
 tools/lib/bpf/libbpf.c                        |  18 ++--
 tools/lib/bpf/strset.c                        |  18 ++--
 tools/lib/bpf/usdt.c                          |  31 +++---
 tools/perf/tests/expr.c                       |  40 +++----
 tools/perf/tests/pmu-events.c                 |   6 +-
 tools/perf/util/bpf-loader.c                  |  23 ++--
 tools/perf/util/expr.c                        |  32 +++---
 tools/perf/util/hashmap.c                     |  16 +--
 tools/perf/util/hashmap.h                     |  34 +++---
 tools/perf/util/metricgroup.c                 |  12 +--
 tools/perf/util/stat.c                        |   9 +-
 .../selftests/bpf/prog_tests/hashmap.c        | 102 +++++++++---------
 .../bpf/prog_tests/kprobe_multi_test.c        |   6 +-
 25 files changed, 257 insertions(+), 305 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 68a70ac03c80..b87e4a7fd689 100644
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
@@ -875,17 +874,13 @@ show_btf_plain(struct bpf_btf_info *info, int fd,
 	printf("size %uB", info->btf_size);
 
 	n = 0;
-	hashmap__for_each_key_entry(btf_prog_table, entry,
-				    u32_as_hash_field(info->id)) {
-		printf("%s%u", n++ == 0 ? "  prog_ids " : ",",
-		       hash_field_as_u32(entry->value));
+	hashmap__for_each_key_entry(btf_prog_table, entry, info->id) {
+		printf("%s%lu", n++ == 0 ? "  prog_ids " : ",", entry->value);
 	}
 
 	n = 0;
-	hashmap__for_each_key_entry(btf_map_table, entry,
-				    u32_as_hash_field(info->id)) {
-		printf("%s%u", n++ == 0 ? "  map_ids " : ",",
-		       hash_field_as_u32(entry->value));
+	hashmap__for_each_key_entry(btf_map_table, entry, info->id) {
+		printf("%s%lu", n++ == 0 ? "  map_ids " : ",", entry->value);
 	}
 
 	emit_obj_refs_plain(refs_table, info->id, "\n\tpids ");
@@ -907,17 +902,15 @@ show_btf_json(struct bpf_btf_info *info, int fd,
 
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
index e4d33bc8bbbf..9f8104fd71d5 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -494,7 +494,7 @@ static int do_build_table_cb(const char *fpath, const struct stat *sb,
 		goto out_close;
 	}
 
-	err = hashmap__append(build_fn_table, u32_as_hash_field(pinned_info.id), path);
+	err = hashmap__append(build_fn_table, pinned_info.id, (long)path);
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
+size_t hash_fn_for_key_as_id(long key, void *ctx)
 {
-	return (size_t)key;
+	return key;
 }
 
-bool equal_fn_for_key_as_id(const void *k1, const void *k2, void *ctx)
+bool equal_fn_for_key_as_id(long k1, long k2, void *ctx)
 {
 	return k1 == k2;
 }
diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index cf8b4e525c88..cf5b83a31b01 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1660,21 +1660,16 @@ struct btfgen_info {
 	struct btf *marked_btf; /* btf structure used to mark used types */
 };
 
-static size_t btfgen_hash_fn(const void *key, void *ctx)
+static size_t btfgen_hash_fn(long key, void *ctx)
 {
-	return (size_t)key;
+	return key;
 }
 
-static bool btfgen_equal_fn(const void *k1, const void *k2, void *ctx)
+static bool btfgen_equal_fn(long k1, long k2, void *ctx)
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
+			    !hashmap__find(cand_cache, relo->type_id, (long *)&cands)) {
 				cands = btfgen_find_cands(btf, info->src_btf, relo->type_id);
 				if (!cands) {
 					err = -errno;
 					goto out;
 				}
 
-				err = hashmap__set(cand_cache, type_key, cands, NULL, NULL);
+				err = hashmap__set(cand_cache, relo->type_id, (long)cands,
+						   NULL, NULL);
 				if (err)
 					goto out;
 			}
@@ -2120,7 +2115,7 @@ static int btfgen_record_obj(struct btfgen_info *info, const char *obj_path)
 
 	if (!IS_ERR_OR_NULL(cand_cache)) {
 		hashmap__for_each_entry(cand_cache, entry, i) {
-			bpf_core_free_cands(entry->value);
+			bpf_core_free_cands((void *)entry->value);
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
index 467d8472df0c..d4e8a1aef787 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -240,8 +240,8 @@ int do_filter_dump(struct tcmsg *ifinfo, struct nlattr **tb, const char *kind,
 int print_all_levels(__maybe_unused enum libbpf_print_level level,
 		     const char *format, va_list args);
 
-size_t hash_fn_for_key_as_id(const void *key, void *ctx);
-bool equal_fn_for_key_as_id(const void *k1, const void *k2, void *ctx);
+size_t hash_fn_for_key_as_id(long key, void *ctx);
+bool equal_fn_for_key_as_id(long k1, long k2, void *ctx);
 
 /* bpf_attach_type_input_str - convert the provided attach type value into a
  * textual representation that we accept for input purposes.
@@ -257,16 +257,6 @@ bool equal_fn_for_key_as_id(const void *k1, const void *k2, void *ctx);
  */
 const char *bpf_attach_type_input_str(enum bpf_attach_type t);
 
-static inline void *u32_as_hash_field(__u32 x)
-{
-	return (void *)(uintptr_t)x;
-}
-
-static inline __u32 hash_field_as_u32(const void *x)
-{
-	return (__u32)(uintptr_t)x;
-}
-
 static inline bool hashmap__empty(struct hashmap *map)
 {
 	return map ? hashmap__size(map) == 0 : true;
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
index bb6c969a114a..4f510392d87f 100644
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
+	err = hashmap__append(map, e->id, (long)refs);
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
index 71d68bf7788c..442d4d0f98b8 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1559,15 +1559,15 @@ struct btf_pipe {
 static int btf_rewrite_str(__u32 *str_off, void *ctx)
 {
 	struct btf_pipe *p = ctx;
-	void *mapped_off;
+	long mapped_off;
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
+static size_t btf_dedup_identity_hash_fn(long key, void *ctx);
+static bool btf_dedup_equal_fn(long k1, long k2, void *ctx);
 
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
+static size_t btf_dedup_identity_hash_fn(long key, void *ctx)
 {
-	return (size_t)key;
+	return key;
 }
 
-static size_t btf_dedup_collision_hash_fn(const void *key, void *ctx)
+static size_t btf_dedup_collision_hash_fn(long key, void *ctx)
 {
 	return 0;
 }
 
-static bool btf_dedup_equal_fn(const void *k1, const void *k2, void *ctx)
+static bool btf_dedup_equal_fn(long k1, long k2, void *ctx)
 {
 	return k1 == k2;
 }
@@ -3750,7 +3749,7 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
 	case BTF_KIND_INT:
 		h = btf_hash_int_decl_tag(t);
 		for_each_dedup_cand(d, hash_entry, h) {
-			cand_id = (__u32)(long)hash_entry->value;
+			cand_id = hash_entry->value;
 			cand = btf_type_by_id(d->btf, cand_id);
 			if (btf_equal_int_tag(t, cand)) {
 				new_id = cand_id;
@@ -3763,7 +3762,7 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
 	case BTF_KIND_ENUM64:
 		h = btf_hash_enum(t);
 		for_each_dedup_cand(d, hash_entry, h) {
-			cand_id = (__u32)(long)hash_entry->value;
+			cand_id = hash_entry->value;
 			cand = btf_type_by_id(d->btf, cand_id);
 			if (btf_equal_enum(t, cand)) {
 				new_id = cand_id;
@@ -3785,7 +3784,7 @@ static int btf_dedup_prim_type(struct btf_dedup *d, __u32 type_id)
 	case BTF_KIND_FLOAT:
 		h = btf_hash_common(t);
 		for_each_dedup_cand(d, hash_entry, h) {
-			cand_id = (__u32)(long)hash_entry->value;
+			cand_id = hash_entry->value;
 			cand = btf_type_by_id(d->btf, cand_id);
 			if (btf_equal_common(t, cand)) {
 				new_id = cand_id;
@@ -4288,7 +4287,7 @@ static int btf_dedup_struct_type(struct btf_dedup *d, __u32 type_id)
 
 	h = btf_hash_struct(t);
 	for_each_dedup_cand(d, hash_entry, h) {
-		__u32 cand_id = (__u32)(long)hash_entry->value;
+		__u32 cand_id = hash_entry->value;
 		int eq;
 
 		/*
@@ -4393,7 +4392,7 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
 
 		h = btf_hash_common(t);
 		for_each_dedup_cand(d, hash_entry, h) {
-			cand_id = (__u32)(long)hash_entry->value;
+			cand_id = hash_entry->value;
 			cand = btf_type_by_id(d->btf, cand_id);
 			if (btf_equal_common(t, cand)) {
 				new_id = cand_id;
@@ -4410,7 +4409,7 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
 
 		h = btf_hash_int_decl_tag(t);
 		for_each_dedup_cand(d, hash_entry, h) {
-			cand_id = (__u32)(long)hash_entry->value;
+			cand_id = hash_entry->value;
 			cand = btf_type_by_id(d->btf, cand_id);
 			if (btf_equal_int_tag(t, cand)) {
 				new_id = cand_id;
@@ -4434,7 +4433,7 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
 
 		h = btf_hash_array(t);
 		for_each_dedup_cand(d, hash_entry, h) {
-			cand_id = (__u32)(long)hash_entry->value;
+			cand_id = hash_entry->value;
 			cand = btf_type_by_id(d->btf, cand_id);
 			if (btf_equal_array(t, cand)) {
 				new_id = cand_id;
@@ -4466,7 +4465,7 @@ static int btf_dedup_ref_type(struct btf_dedup *d, __u32 type_id)
 
 		h = btf_hash_fnproto(t);
 		for_each_dedup_cand(d, hash_entry, h) {
-			cand_id = (__u32)(long)hash_entry->value;
+			cand_id = hash_entry->value;
 			cand = btf_type_by_id(d->btf, cand_id);
 			if (btf_equal_fnproto(t, cand)) {
 				new_id = cand_id;
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index bf0cc0e986dd..35f524671587 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -117,14 +117,14 @@ struct btf_dump {
 	struct btf_dump_data *typed_dump;
 };
 
-static size_t str_hash_fn(const void *key, void *ctx)
+static size_t str_hash_fn(long key, void *ctx)
 {
-	return str_hash(key);
+	return str_hash((void *)key);
 }
 
-static bool str_equal_fn(const void *a, const void *b, void *ctx)
+static bool str_equal_fn(long a, long b, void *ctx)
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
+	long dup_cnt = 0;
 	int err;
 
 	new_name = strdup(orig_name);
 	if (!new_name)
 		return 1;
 
-	hashmap__find(name_map, orig_name, (void **)&dup_cnt);
+	hashmap__find(name_map, (long)orig_name, &dup_cnt);
 	dup_cnt++;
 
-	err = hashmap__set(name_map, new_name, (void *)dup_cnt,
-			   (const void **)&old_name, NULL);
+	err = hashmap__set(name_map, (long)new_name, dup_cnt,
+			   (long *)&old_name, NULL);
 	if (err)
 		free(new_name);
 
diff --git a/tools/lib/bpf/hashmap.c b/tools/lib/bpf/hashmap.c
index aeb09c288716..dfe99e766f30 100644
--- a/tools/lib/bpf/hashmap.c
+++ b/tools/lib/bpf/hashmap.c
@@ -128,7 +128,7 @@ static int hashmap_grow(struct hashmap *map)
 }
 
 static bool hashmap_find_entry(const struct hashmap *map,
-			       const void *key, size_t hash,
+			       const long key, size_t hash,
 			       struct hashmap_entry ***pprev,
 			       struct hashmap_entry **entry)
 {
@@ -151,18 +151,18 @@ static bool hashmap_find_entry(const struct hashmap *map,
 	return false;
 }
 
-int hashmap__insert(struct hashmap *map, const void *key, void *value,
+int hashmap__insert(struct hashmap *map, long key, long value,
 		    enum hashmap_insert_strategy strategy,
-		    const void **old_key, void **old_value)
+		    long *old_key, long *old_value)
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
+bool hashmap__find(const struct hashmap *map, long key, long *value)
 {
 	struct hashmap_entry *entry;
 	size_t h;
@@ -217,8 +217,8 @@ bool hashmap__find(const struct hashmap *map, const void *key, void **value)
 	return true;
 }
 
-bool hashmap__delete(struct hashmap *map, const void *key,
-		     const void **old_key, void **old_value)
+bool hashmap__delete(struct hashmap *map, long key,
+		     long *old_key, long *old_value)
 {
 	struct hashmap_entry **pprev, *entry;
 	size_t h;
diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
index 10a4c4cd13cf..7393ef616920 100644
--- a/tools/lib/bpf/hashmap.h
+++ b/tools/lib/bpf/hashmap.h
@@ -40,12 +40,15 @@ static inline size_t str_hash(const char *s)
 	return h;
 }
 
-typedef size_t (*hashmap_hash_fn)(const void *key, void *ctx);
-typedef bool (*hashmap_equal_fn)(const void *key1, const void *key2, void *ctx);
+/* keys and values are represented as long to allow pointers and
+ * 32-bit integers as keys or values.
+ */
+typedef size_t (*hashmap_hash_fn)(long key, void *ctx);
+typedef bool (*hashmap_equal_fn)(long key1, long key2, void *ctx);
 
 struct hashmap_entry {
-	const void *key;
-	void *value;
+	long key;
+	long value;
 	struct hashmap_entry *next;
 };
 
@@ -109,42 +112,39 @@ enum hashmap_insert_strategy {
  * through old_key and old_value to allow calling code do proper memory
  * management.
  */
-int hashmap__insert(struct hashmap *map, const void *key, void *value,
+int hashmap__insert(struct hashmap *map, long key, long value,
 		    enum hashmap_insert_strategy strategy,
-		    const void **old_key, void **old_value);
+		    long *old_key, long *old_value);
 
-static inline int hashmap__add(struct hashmap *map,
-			       const void *key, void *value)
+static inline int hashmap__add(struct hashmap *map, long key, long value)
 {
 	return hashmap__insert(map, key, value, HASHMAP_ADD, NULL, NULL);
 }
 
 static inline int hashmap__set(struct hashmap *map,
-			       const void *key, void *value,
-			       const void **old_key, void **old_value)
+			       long key, long value,
+			       long *old_key, long *old_value)
 {
 	return hashmap__insert(map, key, value, HASHMAP_SET,
 			       old_key, old_value);
 }
 
 static inline int hashmap__update(struct hashmap *map,
-				  const void *key, void *value,
-				  const void **old_key, void **old_value)
+				  long key, long value,
+				  long *old_key, long *old_value)
 {
 	return hashmap__insert(map, key, value, HASHMAP_UPDATE,
 			       old_key, old_value);
 }
 
-static inline int hashmap__append(struct hashmap *map,
-				  const void *key, void *value)
+static inline int hashmap__append(struct hashmap *map, long key, long value)
 {
 	return hashmap__insert(map, key, value, HASHMAP_APPEND, NULL, NULL);
 }
 
-bool hashmap__delete(struct hashmap *map, const void *key,
-		     const void **old_key, void **old_value);
+bool hashmap__delete(struct hashmap *map, long key, long *old_key, long *old_value);
 
-bool hashmap__find(const struct hashmap *map, const void *key, void **value);
+bool hashmap__find(const struct hashmap *map, long key, long *value);
 
 /*
  * hashmap__for_each_entry - iterate over all entries in hashmap
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5d7819edf074..96092c9cb34b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5601,21 +5601,16 @@ int bpf_core_types_match(const struct btf *local_btf, __u32 local_id,
 	return __bpf_core_types_match(local_btf, local_id, targ_btf, targ_id, false, 32);
 }
 
-static size_t bpf_core_hash_fn(const void *key, void *ctx)
+static size_t bpf_core_hash_fn(const long key, void *ctx)
 {
-	return (size_t)key;
+	return key;
 }
 
-static bool bpf_core_equal_fn(const void *k1, const void *k2, void *ctx)
+static bool bpf_core_equal_fn(const long k1, const long k2, void *ctx)
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
+	    !hashmap__find(cand_cache, local_id, (long *)&cands)) {
 		cands = bpf_core_find_cands(prog->obj, local_btf, local_id);
 		if (IS_ERR(cands)) {
 			pr_warn("prog '%s': relo #%d: target candidate search failed for [%d] %s %s: %ld\n",
@@ -5683,7 +5677,7 @@ static int bpf_core_resolve_relo(struct bpf_program *prog,
 				local_name, PTR_ERR(cands));
 			return PTR_ERR(cands);
 		}
-		err = hashmap__set(cand_cache, type_key, cands, NULL, NULL);
+		err = hashmap__set(cand_cache, local_id, (long)cands, NULL, NULL);
 		if (err) {
 			bpf_core_free_cands(cands);
 			return err;
@@ -5806,7 +5800,7 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 
 	if (!IS_ERR_OR_NULL(cand_cache)) {
 		hashmap__for_each_entry(cand_cache, entry, i) {
-			bpf_core_free_cands(entry->value);
+			bpf_core_free_cands((void *)entry->value);
 		}
 		hashmap__free(cand_cache);
 	}
diff --git a/tools/lib/bpf/strset.c b/tools/lib/bpf/strset.c
index ea655318153f..2464bcbd04e0 100644
--- a/tools/lib/bpf/strset.c
+++ b/tools/lib/bpf/strset.c
@@ -19,19 +19,19 @@ struct strset {
 	struct hashmap *strs_hash;
 };
 
-static size_t strset_hash_fn(const void *key, void *ctx)
+static size_t strset_hash_fn(long key, void *ctx)
 {
 	const struct strset *s = ctx;
-	const char *str = s->strs_data + (long)key;
+	const char *str = s->strs_data + key;
 
 	return str_hash(str);
 }
 
-static bool strset_equal_fn(const void *key1, const void *key2, void *ctx)
+static bool strset_equal_fn(long key1, long key2, void *ctx)
 {
 	const struct strset *s = ctx;
-	const char *str1 = s->strs_data + (long)key1;
-	const char *str2 = s->strs_data + (long)key2;
+	const char *str1 = s->strs_data + key1;
+	const char *str2 = s->strs_data + key2;
 
 	return strcmp(str1, str2) == 0;
 }
@@ -67,7 +67,7 @@ struct strset *strset__new(size_t max_data_sz, const char *init_data, size_t ini
 			/* hashmap__add() returns EEXIST if string with the same
 			 * content already is in the hash map
 			 */
-			err = hashmap__add(hash, (void *)off, (void *)off);
+			err = hashmap__add(hash, off, off);
 			if (err == -EEXIST)
 				continue; /* duplicate */
 			if (err)
@@ -127,7 +127,7 @@ int strset__find_str(struct strset *set, const char *s)
 	new_off = set->strs_data_len;
 	memcpy(p, s, len);
 
-	if (hashmap__find(set->strs_hash, (void *)new_off, (void **)&old_off))
+	if (hashmap__find(set->strs_hash, new_off, &old_off))
 		return old_off;
 
 	return -ENOENT;
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
index 28fa1b2283de..dcfdbf25aea5 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -873,31 +873,27 @@ static void bpf_link_usdt_dealloc(struct bpf_link *link)
 	free(usdt_link);
 }
 
-static size_t specs_hash_fn(const void *key, void *ctx)
+static size_t specs_hash_fn(long key, void *ctx)
 {
-	const char *s = key;
-
-	return str_hash(s);
+	return str_hash((char *)key);
 }
 
-static bool specs_equal_fn(const void *key1, const void *key2, void *ctx)
+static bool specs_equal_fn(long key1, long key2, void *ctx)
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
+	long tmp;
+	void *new_ids;
 	int err;
 
 	/* check if we already allocated spec ID for this spec string */
-	if (hashmap__find(specs_hash, target->spec_str, &tmp)) {
-		*spec_id = (long)tmp;
+	if (hashmap__find(specs_hash, (long)target->spec_str, &tmp)) {
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
+		err = hashmap__add(specs_hash, (long)target->spec_str, *spec_id);
 		if (err)
 			 return err;
 
@@ -928,7 +925,7 @@ static int allocate_spec_id(struct usdt_manager *man, struct hashmap *specs_hash
 		*spec_id = man->next_free_spec_id;
 
 		/* cache spec ID for current spec string for future lookups */
-		err = hashmap__add(specs_hash, target->spec_str, (void *)(long)*spec_id);
+		err = hashmap__add(specs_hash, (long)target->spec_str, *spec_id);
 		if (err)
 			 return err;
 
diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 6512f5e22045..8107ed0428c2 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -130,12 +130,12 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 			expr__find_ids("FOO + BAR + BAZ + BOZO", "FOO",
 					ctx) == 0);
 	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 3);
-	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "BAR",
-						    (void **)&val_ptr));
-	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "BAZ",
-						    (void **)&val_ptr));
-	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "BOZO",
-						    (void **)&val_ptr));
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, (long)"BAR",
+						  (long *)&val_ptr));
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, (long)"BAZ",
+						  (long *)&val_ptr));
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, (long)"BOZO",
+						  (long *)&val_ptr));
 
 	expr__ctx_clear(ctx);
 	ctx->sctx.runtime = 3;
@@ -143,20 +143,20 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 			expr__find_ids("EVENT1\\,param\\=?@ + EVENT2\\,param\\=?@",
 					NULL, ctx) == 0);
 	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 2);
-	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT1,param=3@",
-						    (void **)&val_ptr));
-	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "EVENT2,param=3@",
-						    (void **)&val_ptr));
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, (long)"EVENT1,param=3@",
+						  (long *)&val_ptr));
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, (long)"EVENT2,param=3@",
+						  (long *)&val_ptr));
 
 	expr__ctx_clear(ctx);
 	TEST_ASSERT_VAL("find ids",
 			expr__find_ids("dash\\-event1 - dash\\-event2",
 				       NULL, ctx) == 0);
 	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 2);
-	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "dash-event1",
-						    (void **)&val_ptr));
-	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, "dash-event2",
-						    (void **)&val_ptr));
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, (long)"dash-event1",
+						  (long *)&val_ptr));
+	TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids, (long)"dash-event2",
+						  (long *)&val_ptr));
 
 	/* Only EVENT1 or EVENT2 need be measured depending on the value of smt_on. */
 	{
@@ -173,8 +173,8 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 					NULL, ctx) == 0);
 		TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
 		TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
-							  smton ? "EVENT1" : "EVENT2",
-							  (void **)&val_ptr));
+							  (long)(smton ? "EVENT1" : "EVENT2"),
+							  (long *)&val_ptr));
 
 		expr__ctx_clear(ctx);
 		TEST_ASSERT_VAL("find ids",
@@ -182,8 +182,8 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 					NULL, ctx) == 0);
 		TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
 		TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
-							  corewide ? "EVENT1" : "EVENT2",
-							  (void **)&val_ptr));
+							  (long)(corewide ? "EVENT1" : "EVENT2"),
+							  (long *)&val_ptr));
 
 	}
 	/* The expression is a constant 1.0 without needing to evaluate EVENT1. */
@@ -220,8 +220,8 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 			expr__find_ids("source_count(EVENT1)",
 			NULL, ctx) == 0);
 	TEST_ASSERT_VAL("source count", hashmap__size(ctx->ids) == 1);
-	TEST_ASSERT_VAL("source count", hashmap__find(ctx->ids, "EVENT1",
-							(void **)&val_ptr));
+	TEST_ASSERT_VAL("source count", hashmap__find(ctx->ids, (long)"EVENT1",
+						      (long *)&val_ptr));
 
 	expr__ctx_free(ctx);
 
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 097e05c796ab..db0445585cda 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -986,10 +986,10 @@ static int metric_parse_fake(const char *str)
 	 */
 	i = 1;
 	hashmap__for_each_entry(ctx->ids, cur, bkt)
-		expr__add_id_val(ctx, strdup(cur->key), i++);
+		expr__add_id_val(ctx, strdup((char *)cur->key), i++);
 
 	hashmap__for_each_entry(ctx->ids, cur, bkt) {
-		if (check_parse_fake(cur->key)) {
+		if (check_parse_fake((char *)cur->key)) {
 			pr_err("check_parse_fake failed\n");
 			goto out;
 		}
@@ -1003,7 +1003,7 @@ static int metric_parse_fake(const char *str)
 		 */
 		i = 1024;
 		hashmap__for_each_entry(ctx->ids, cur, bkt)
-			expr__add_id_val(ctx, strdup(cur->key), i--);
+			expr__add_id_val(ctx, strdup((char *)cur->key), i--);
 		if (expr__parse(&result, ctx, str)) {
 			pr_err("expr__parse failed\n");
 			ret = -1;
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index f4adeccdbbcb..55f114450316 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -131,7 +131,7 @@ static void *program_priv(const struct bpf_program *prog)
 
 	if (IS_ERR_OR_NULL(bpf_program_hash))
 		return NULL;
-	if (!hashmap__find(bpf_program_hash, prog, &priv))
+	if (!hashmap__find(bpf_program_hash, (long)prog, (long *)&priv))
 		return NULL;
 	return priv;
 }
@@ -318,7 +318,7 @@ static void bpf_program_hash_free(void)
 		return;
 
 	hashmap__for_each_entry(bpf_program_hash, cur, bkt)
-		clear_prog_priv(cur->key, cur->value);
+		clear_prog_priv((struct bpf_program *)cur->key, (void *)cur->value);
 
 	hashmap__free(bpf_program_hash);
 	bpf_program_hash = NULL;
@@ -339,13 +339,12 @@ void bpf__clear(void)
 	bpf_map_hash_free();
 }
 
-static size_t ptr_hash(const void *__key, void *ctx __maybe_unused)
+static size_t ptr_hash(const long __key, void *ctx __maybe_unused)
 {
-	return (size_t) __key;
+	return __key;
 }
 
-static bool ptr_equal(const void *key1, const void *key2,
-			  void *ctx __maybe_unused)
+static bool ptr_equal(long key1, long key2, void *ctx __maybe_unused)
 {
 	return key1 == key2;
 }
@@ -370,9 +369,9 @@ static int program_set_priv(struct bpf_program *prog, void *priv)
 	old_priv = program_priv(prog);
 	if (old_priv) {
 		clear_prog_priv(prog, old_priv);
-		return hashmap__set(bpf_program_hash, prog, priv, NULL, NULL);
+		return hashmap__set(bpf_program_hash, (long)prog, (long)priv, NULL, NULL);
 	}
-	return hashmap__add(bpf_program_hash, prog, priv);
+	return hashmap__add(bpf_program_hash, (long)prog, (long)priv);
 }
 
 static int
@@ -1171,7 +1170,7 @@ static void *map_priv(const struct bpf_map *map)
 
 	if (IS_ERR_OR_NULL(bpf_map_hash))
 		return NULL;
-	if (!hashmap__find(bpf_map_hash, map, &priv))
+	if (!hashmap__find(bpf_map_hash, (long)map, (long *)&priv))
 		return NULL;
 	return priv;
 }
@@ -1185,7 +1184,7 @@ static void bpf_map_hash_free(void)
 		return;
 
 	hashmap__for_each_entry(bpf_map_hash, cur, bkt)
-		bpf_map_priv__clear(cur->key, cur->value);
+		bpf_map_priv__clear((struct bpf_map *)cur->key, (void *)cur->value);
 
 	hashmap__free(bpf_map_hash);
 	bpf_map_hash = NULL;
@@ -1207,9 +1206,9 @@ static int map_set_priv(struct bpf_map *map, void *priv)
 	old_priv = map_priv(map);
 	if (old_priv) {
 		bpf_map_priv__clear(map, old_priv);
-		return hashmap__set(bpf_map_hash, map, priv, NULL, NULL);
+		return hashmap__set(bpf_map_hash, (long)map, (long)priv, NULL, NULL);
 	}
-	return hashmap__add(bpf_map_hash, map, priv);
+	return hashmap__add(bpf_map_hash, (long)map, (long)priv);
 }
 
 static int
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index aaacf514dc09..520c6065cd35 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -46,7 +46,7 @@ struct expr_id_data {
 	} kind;
 };
 
-static size_t key_hash(const void *key, void *ctx __maybe_unused)
+static size_t key_hash(long key, void *ctx __maybe_unused)
 {
 	const char *str = (const char *)key;
 	size_t hash = 0;
@@ -59,8 +59,7 @@ static size_t key_hash(const void *key, void *ctx __maybe_unused)
 	return hash;
 }
 
-static bool key_equal(const void *key1, const void *key2,
-		    void *ctx __maybe_unused)
+static bool key_equal(long key1, long key2, void *ctx __maybe_unused)
 {
 	return !strcmp((const char *)key1, (const char *)key2);
 }
@@ -85,7 +84,7 @@ void ids__free(struct hashmap *ids)
 
 	hashmap__for_each_entry(ids, cur, bkt) {
 		free((char *)cur->key);
-		free(cur->value);
+		free((void *)cur->value);
 	}
 
 	hashmap__free(ids);
@@ -97,8 +96,8 @@ int ids__insert(struct hashmap *ids, const char *id)
 	char *old_key = NULL;
 	int ret;
 
-	ret = hashmap__set(ids, id, data_ptr,
-			   (const void **)&old_key, (void **)&old_data);
+	ret = hashmap__set(ids, (long)id, (long)data_ptr,
+			   (long *)&old_key, (long *)&old_data);
 	if (ret)
 		free(data_ptr);
 	free(old_key);
@@ -128,7 +127,7 @@ struct hashmap *ids__union(struct hashmap *ids1, struct hashmap *ids2)
 	}
 	hashmap__for_each_entry(ids2, cur, bkt) {
 		ret = hashmap__set(ids1, cur->key, cur->value,
-				(const void **)&old_key, (void **)&old_data);
+				(long *)&old_key, (long *)&old_data);
 		free(old_key);
 		free(old_data);
 
@@ -169,8 +168,8 @@ int expr__add_id_val_source_count(struct expr_parse_ctx *ctx, const char *id,
 	data_ptr->val.source_count = source_count;
 	data_ptr->kind = EXPR_ID_DATA__VALUE;
 
-	ret = hashmap__set(ctx->ids, id, data_ptr,
-			   (const void **)&old_key, (void **)&old_data);
+	ret = hashmap__set(ctx->ids, (long)id, (long)data_ptr,
+			   (long *)&old_key, (long *)&old_data);
 	if (ret)
 		free(data_ptr);
 	free(old_key);
@@ -205,8 +204,8 @@ int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
 	data_ptr->ref.metric_expr = ref->metric_expr;
 	data_ptr->kind = EXPR_ID_DATA__REF;
 
-	ret = hashmap__set(ctx->ids, name, data_ptr,
-			   (const void **)&old_key, (void **)&old_data);
+	ret = hashmap__set(ctx->ids, (long)name, (long)data_ptr,
+			   (long *)&old_key, (long *)&old_data);
 	if (ret)
 		free(data_ptr);
 
@@ -221,7 +220,7 @@ int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
 int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
 		 struct expr_id_data **data)
 {
-	return hashmap__find(ctx->ids, id, (void **)data) ? 0 : -1;
+	return hashmap__find(ctx->ids, (long)id, (long *)data) ? 0 : -1;
 }
 
 bool expr__subset_of_ids(struct expr_parse_ctx *haystack,
@@ -232,7 +231,7 @@ bool expr__subset_of_ids(struct expr_parse_ctx *haystack,
 	struct expr_id_data *data;
 
 	hashmap__for_each_entry(needles->ids, cur, bkt) {
-		if (expr__get_id(haystack, cur->key, &data))
+		if (expr__get_id(haystack, (char *)cur->key, &data))
 			return false;
 	}
 	return true;
@@ -282,8 +281,7 @@ void expr__del_id(struct expr_parse_ctx *ctx, const char *id)
 	struct expr_id_data *old_val = NULL;
 	char *old_key = NULL;
 
-	hashmap__delete(ctx->ids, id,
-			(const void **)&old_key, (void **)&old_val);
+	hashmap__delete(ctx->ids, (long)id, (long *)&old_key, (long *)&old_val);
 	free(old_key);
 	free(old_val);
 }
@@ -315,7 +313,7 @@ void expr__ctx_clear(struct expr_parse_ctx *ctx)
 
 	hashmap__for_each_entry(ctx->ids, cur, bkt) {
 		free((char *)cur->key);
-		free(cur->value);
+		free((void *)cur->value);
 	}
 	hashmap__clear(ctx->ids);
 }
@@ -331,7 +329,7 @@ void expr__ctx_free(struct expr_parse_ctx *ctx)
 	free(ctx->sctx.user_requested_cpu_list);
 	hashmap__for_each_entry(ctx->ids, cur, bkt) {
 		free((char *)cur->key);
-		free(cur->value);
+		free((void *)cur->value);
 	}
 	hashmap__free(ctx->ids);
 	free(ctx);
diff --git a/tools/perf/util/hashmap.c b/tools/perf/util/hashmap.c
index aeb09c288716..dfe99e766f30 100644
--- a/tools/perf/util/hashmap.c
+++ b/tools/perf/util/hashmap.c
@@ -128,7 +128,7 @@ static int hashmap_grow(struct hashmap *map)
 }
 
 static bool hashmap_find_entry(const struct hashmap *map,
-			       const void *key, size_t hash,
+			       const long key, size_t hash,
 			       struct hashmap_entry ***pprev,
 			       struct hashmap_entry **entry)
 {
@@ -151,18 +151,18 @@ static bool hashmap_find_entry(const struct hashmap *map,
 	return false;
 }
 
-int hashmap__insert(struct hashmap *map, const void *key, void *value,
+int hashmap__insert(struct hashmap *map, long key, long value,
 		    enum hashmap_insert_strategy strategy,
-		    const void **old_key, void **old_value)
+		    long *old_key, long *old_value)
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
+bool hashmap__find(const struct hashmap *map, long key, long *value)
 {
 	struct hashmap_entry *entry;
 	size_t h;
@@ -217,8 +217,8 @@ bool hashmap__find(const struct hashmap *map, const void *key, void **value)
 	return true;
 }
 
-bool hashmap__delete(struct hashmap *map, const void *key,
-		     const void **old_key, void **old_value)
+bool hashmap__delete(struct hashmap *map, long key,
+		     long *old_key, long *old_value)
 {
 	struct hashmap_entry **pprev, *entry;
 	size_t h;
diff --git a/tools/perf/util/hashmap.h b/tools/perf/util/hashmap.h
index 10a4c4cd13cf..7393ef616920 100644
--- a/tools/perf/util/hashmap.h
+++ b/tools/perf/util/hashmap.h
@@ -40,12 +40,15 @@ static inline size_t str_hash(const char *s)
 	return h;
 }
 
-typedef size_t (*hashmap_hash_fn)(const void *key, void *ctx);
-typedef bool (*hashmap_equal_fn)(const void *key1, const void *key2, void *ctx);
+/* keys and values are represented as long to allow pointers and
+ * 32-bit integers as keys or values.
+ */
+typedef size_t (*hashmap_hash_fn)(long key, void *ctx);
+typedef bool (*hashmap_equal_fn)(long key1, long key2, void *ctx);
 
 struct hashmap_entry {
-	const void *key;
-	void *value;
+	long key;
+	long value;
 	struct hashmap_entry *next;
 };
 
@@ -109,42 +112,39 @@ enum hashmap_insert_strategy {
  * through old_key and old_value to allow calling code do proper memory
  * management.
  */
-int hashmap__insert(struct hashmap *map, const void *key, void *value,
+int hashmap__insert(struct hashmap *map, long key, long value,
 		    enum hashmap_insert_strategy strategy,
-		    const void **old_key, void **old_value);
+		    long *old_key, long *old_value);
 
-static inline int hashmap__add(struct hashmap *map,
-			       const void *key, void *value)
+static inline int hashmap__add(struct hashmap *map, long key, long value)
 {
 	return hashmap__insert(map, key, value, HASHMAP_ADD, NULL, NULL);
 }
 
 static inline int hashmap__set(struct hashmap *map,
-			       const void *key, void *value,
-			       const void **old_key, void **old_value)
+			       long key, long value,
+			       long *old_key, long *old_value)
 {
 	return hashmap__insert(map, key, value, HASHMAP_SET,
 			       old_key, old_value);
 }
 
 static inline int hashmap__update(struct hashmap *map,
-				  const void *key, void *value,
-				  const void **old_key, void **old_value)
+				  long key, long value,
+				  long *old_key, long *old_value)
 {
 	return hashmap__insert(map, key, value, HASHMAP_UPDATE,
 			       old_key, old_value);
 }
 
-static inline int hashmap__append(struct hashmap *map,
-				  const void *key, void *value)
+static inline int hashmap__append(struct hashmap *map, long key, long value)
 {
 	return hashmap__insert(map, key, value, HASHMAP_APPEND, NULL, NULL);
 }
 
-bool hashmap__delete(struct hashmap *map, const void *key,
-		     const void **old_key, void **old_value);
+bool hashmap__delete(struct hashmap *map, long key, long *old_key, long *old_value);
 
-bool hashmap__find(const struct hashmap *map, const void *key, void **value);
+bool hashmap__find(const struct hashmap *map, long key, long *value);
 
 /*
  * hashmap__for_each_entry - iterate over all entries in hashmap
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 4c98ac29ee13..e9bd881c6912 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -288,7 +288,7 @@ static int setup_metric_events(struct hashmap *ids,
 		 * combined or shared groups, this metric may not care
 		 * about this event.
 		 */
-		if (hashmap__find(ids, metric_id, (void **)&val_ptr)) {
+		if (hashmap__find(ids, (long)metric_id, (long *)&val_ptr)) {
 			metric_events[matched_events++] = ev;
 
 			if (matched_events >= ids_size)
@@ -764,7 +764,7 @@ static int metricgroup__build_event_string(struct strbuf *events,
 #define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
 
 	hashmap__for_each_entry(ctx->ids, cur, bkt) {
-		const char *sep, *rsep, *id = cur->key;
+		const char *sep, *rsep, *id = (char *)cur->key;
 		enum perf_tool_event ev;
 
 		pr_debug("found event %s\n", id);
@@ -945,21 +945,21 @@ static int resolve_metric(struct list_head *metric_list,
 	hashmap__for_each_entry(root_metric->pctx->ids, cur, bkt) {
 		struct pmu_event pe;
 
-		if (metricgroup__find_metric(cur->key, table, &pe)) {
+		if (metricgroup__find_metric((char *)cur->key, table, &pe)) {
 			pending = realloc(pending,
 					(pending_cnt + 1) * sizeof(struct to_resolve));
 			if (!pending)
 				return -ENOMEM;
 
 			memcpy(&pending[pending_cnt].pe, &pe, sizeof(pe));
-			pending[pending_cnt].key = cur->key;
+			pending[pending_cnt].key = (char *)cur->key;
 			pending_cnt++;
 		}
 	}
 
 	/* Remove the metric IDs from the context. */
 	for (i = 0; i < pending_cnt; i++)
-		expr__del_id(root_metric->pctx, pending[i].key);
+		expr__del_id(root_metric->pctx, (char *)pending[i].key);
 
 	/*
 	 * Recursively add all the metrics, IDs are added to the root metric's
@@ -1433,7 +1433,7 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
 	list_for_each_entry(m, metric_list, nd) {
 		if (m->has_constraint && !m->modifier) {
 			hashmap__for_each_entry(m->pctx->ids, cur, bkt) {
-				dup = strdup(cur->key);
+				dup = strdup((char *)cur->key);
 				if (!dup) {
 					ret = -ENOMEM;
 					goto err_out;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 8ec8bb4a9912..29f0e5d23a89 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -278,15 +278,14 @@ void evlist__save_aggr_prev_raw_counts(struct evlist *evlist)
 	}
 }
 
-static size_t pkg_id_hash(const void *__key, void *ctx __maybe_unused)
+static size_t pkg_id_hash(long __key, void *ctx __maybe_unused)
 {
 	uint64_t *key = (uint64_t *) __key;
 
 	return *key & 0xffffffff;
 }
 
-static bool pkg_id_equal(const void *__key1, const void *__key2,
-			 void *ctx __maybe_unused)
+static bool pkg_id_equal(long __key1, long __key2, void *ctx __maybe_unused)
 {
 	uint64_t *key1 = (uint64_t *) __key1;
 	uint64_t *key2 = (uint64_t *) __key2;
@@ -347,11 +346,11 @@ static int check_per_pkg(struct evsel *counter, struct perf_counts_values *vals,
 		return -ENOMEM;
 
 	*key = (uint64_t)d << 32 | s;
-	if (hashmap__find(mask, (void *)key, NULL)) {
+	if (hashmap__find(mask, (long)key, NULL)) {
 		*skip = true;
 		free(key);
 	} else
-		ret = hashmap__add(mask, (void *)key, (void *)1);
+		ret = hashmap__add(mask, (long)key, 1);
 
 	return ret;
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/hashmap.c b/tools/testing/selftests/bpf/prog_tests/hashmap.c
index 4747ab18f97f..a20ca2c01311 100644
--- a/tools/testing/selftests/bpf/prog_tests/hashmap.c
+++ b/tools/testing/selftests/bpf/prog_tests/hashmap.c
@@ -10,14 +10,14 @@
 
 static int duration = 0;
 
-static size_t hash_fn(const void *k, void *ctx)
+static size_t hash_fn(long k, void *ctx)
 {
-	return (long)k;
+	return k;
 }
 
-static bool equal_fn(const void *a, const void *b, void *ctx)
+static bool equal_fn(long a, long b, void *ctx)
 {
-	return (long)a == (long)b;
+	return a == b;
 }
 
 static inline size_t next_pow_2(size_t n)
@@ -52,8 +52,8 @@ static void test_hashmap_generic(void)
 		return;
 
 	for (i = 0; i < ELEM_CNT; i++) {
-		const void *oldk, *k = (const void *)(long)i;
-		void *oldv, *v = (void *)(long)(1024 + i);
+		long oldk, k = i;
+		long oldv, v = 1024 + i;
 
 		err = hashmap__update(map, k, v, &oldk, &oldv);
 		if (CHECK(err != -ENOENT, "hashmap__update",
@@ -64,20 +64,18 @@ static void test_hashmap_generic(void)
 			err = hashmap__add(map, k, v);
 		} else {
 			err = hashmap__set(map, k, v, &oldk, &oldv);
-			if (CHECK(oldk != NULL || oldv != NULL, "check_kv",
-				  "unexpected k/v: %p=%p\n", oldk, oldv))
+			if (CHECK(oldk != 0 || oldv != 0, "check_kv",
+				  "unexpected k/v: %ld=%ld\n", oldk, oldv))
 				goto cleanup;
 		}
 
-		if (CHECK(err, "elem_add", "failed to add k/v %ld = %ld: %d\n",
-			       (long)k, (long)v, err))
+		if (CHECK(err, "elem_add", "failed to add k/v %ld = %ld: %d\n", k, v, err))
 			goto cleanup;
 
 		if (CHECK(!hashmap__find(map, k, &oldv), "elem_find",
-			  "failed to find key %ld\n", (long)k))
+			  "failed to find key %ld\n", k))
 			goto cleanup;
-		if (CHECK(oldv != v, "elem_val",
-			  "found value is wrong: %ld\n", (long)oldv))
+		if (CHECK(oldv != v, "elem_val", "found value is wrong: %ld\n", oldv))
 			goto cleanup;
 	}
 
@@ -91,8 +89,8 @@ static void test_hashmap_generic(void)
 
 	found_msk = 0;
 	hashmap__for_each_entry(map, entry, bkt) {
-		long k = (long)entry->key;
-		long v = (long)entry->value;
+		long k = entry->key;
+		long v = entry->value;
 
 		found_msk |= 1ULL << k;
 		if (CHECK(v - k != 1024, "check_kv",
@@ -104,8 +102,8 @@ static void test_hashmap_generic(void)
 		goto cleanup;
 
 	for (i = 0; i < ELEM_CNT; i++) {
-		const void *oldk, *k = (const void *)(long)i;
-		void *oldv, *v = (void *)(long)(256 + i);
+		long oldk, k = i;
+		long oldv, v = 256 + i;
 
 		err = hashmap__add(map, k, v);
 		if (CHECK(err != -EEXIST, "hashmap__add",
@@ -119,13 +117,13 @@ static void test_hashmap_generic(void)
 
 		if (CHECK(err, "elem_upd",
 			  "failed to update k/v %ld = %ld: %d\n",
-			  (long)k, (long)v, err))
+			  k, v, err))
 			goto cleanup;
 		if (CHECK(!hashmap__find(map, k, &oldv), "elem_find",
-			  "failed to find key %ld\n", (long)k))
+			  "failed to find key %ld\n", k))
 			goto cleanup;
 		if (CHECK(oldv != v, "elem_val",
-			  "found value is wrong: %ld\n", (long)oldv))
+			  "found value is wrong: %ld\n", oldv))
 			goto cleanup;
 	}
 
@@ -139,8 +137,8 @@ static void test_hashmap_generic(void)
 
 	found_msk = 0;
 	hashmap__for_each_entry_safe(map, entry, tmp, bkt) {
-		long k = (long)entry->key;
-		long v = (long)entry->value;
+		long k = entry->key;
+		long v = entry->value;
 
 		found_msk |= 1ULL << k;
 		if (CHECK(v - k != 256, "elem_check",
@@ -152,7 +150,7 @@ static void test_hashmap_generic(void)
 		goto cleanup;
 
 	found_cnt = 0;
-	hashmap__for_each_key_entry(map, entry, (void *)0) {
+	hashmap__for_each_key_entry(map, entry, 0) {
 		found_cnt++;
 	}
 	if (CHECK(!found_cnt, "found_cnt",
@@ -161,27 +159,25 @@ static void test_hashmap_generic(void)
 
 	found_msk = 0;
 	found_cnt = 0;
-	hashmap__for_each_key_entry_safe(map, entry, tmp, (void *)0) {
-		const void *oldk, *k;
-		void *oldv, *v;
+	hashmap__for_each_key_entry_safe(map, entry, tmp, 0) {
+		long oldk, k;
+		long oldv, v;
 
 		k = entry->key;
 		v = entry->value;
 
 		found_cnt++;
-		found_msk |= 1ULL << (long)k;
+		found_msk |= 1ULL << k;
 
 		if (CHECK(!hashmap__delete(map, k, &oldk, &oldv), "elem_del",
-			  "failed to delete k/v %ld = %ld\n",
-			  (long)k, (long)v))
+			  "failed to delete k/v %ld = %ld\n", k, v))
 			goto cleanup;
 		if (CHECK(oldk != k || oldv != v, "check_old",
 			  "invalid deleted k/v: expected %ld = %ld, got %ld = %ld\n",
-			  (long)k, (long)v, (long)oldk, (long)oldv))
+			  k, v, oldk, oldv))
 			goto cleanup;
 		if (CHECK(hashmap__delete(map, k, &oldk, &oldv), "elem_del",
-			  "unexpectedly deleted k/v %ld = %ld\n",
-			  (long)oldk, (long)oldv))
+			  "unexpectedly deleted k/v %ld = %ld\n", oldk, oldv))
 			goto cleanup;
 	}
 
@@ -198,26 +194,24 @@ static void test_hashmap_generic(void)
 		goto cleanup;
 
 	hashmap__for_each_entry_safe(map, entry, tmp, bkt) {
-		const void *oldk, *k;
-		void *oldv, *v;
+		long oldk, k;
+		long oldv, v;
 
 		k = entry->key;
 		v = entry->value;
 
 		found_cnt++;
-		found_msk |= 1ULL << (long)k;
+		found_msk |= 1ULL << k;
 
 		if (CHECK(!hashmap__delete(map, k, &oldk, &oldv), "elem_del",
-			  "failed to delete k/v %ld = %ld\n",
-			  (long)k, (long)v))
+			  "failed to delete k/v %ld = %ld\n", k, v))
 			goto cleanup;
 		if (CHECK(oldk != k || oldv != v, "elem_check",
 			  "invalid old k/v: expect %ld = %ld, got %ld = %ld\n",
-			  (long)k, (long)v, (long)oldk, (long)oldv))
+			  k, v, oldk, oldv))
 			goto cleanup;
 		if (CHECK(hashmap__delete(map, k, &oldk, &oldv), "elem_del",
-			  "unexpectedly deleted k/v %ld = %ld\n",
-			  (long)k, (long)v))
+			  "unexpectedly deleted k/v %ld = %ld\n", k, v))
 			goto cleanup;
 	}
 
@@ -235,7 +229,7 @@ static void test_hashmap_generic(void)
 	hashmap__for_each_entry(map, entry, bkt) {
 		CHECK(false, "elem_exists",
 		      "unexpected map entries left: %ld = %ld\n",
-		      (long)entry->key, (long)entry->value);
+		      entry->key, entry->value);
 		goto cleanup;
 	}
 
@@ -243,7 +237,7 @@ static void test_hashmap_generic(void)
 	hashmap__for_each_entry(map, entry, bkt) {
 		CHECK(false, "elem_exists",
 		      "unexpected map entries left: %ld = %ld\n",
-		      (long)entry->key, (long)entry->value);
+		      entry->key, entry->value);
 		goto cleanup;
 	}
 
@@ -251,14 +245,14 @@ static void test_hashmap_generic(void)
 	hashmap__free(map);
 }
 
-static size_t collision_hash_fn(const void *k, void *ctx)
+static size_t collision_hash_fn(long k, void *ctx)
 {
 	return 0;
 }
 
 static void test_hashmap_multimap(void)
 {
-	void *k1 = (void *)0, *k2 = (void *)1;
+	long k1 = 0, k2 = 1;
 	struct hashmap_entry *entry;
 	struct hashmap *map;
 	long found_msk;
@@ -273,23 +267,23 @@ static void test_hashmap_multimap(void)
 	 * [0] -> 1, 2, 4;
 	 * [1] -> 8, 16, 32;
 	 */
-	err = hashmap__append(map, k1, (void *)1);
+	err = hashmap__append(map, k1, 1);
 	if (CHECK(err, "elem_add", "failed to add k/v: %d\n", err))
 		goto cleanup;
-	err = hashmap__append(map, k1, (void *)2);
+	err = hashmap__append(map, k1, 2);
 	if (CHECK(err, "elem_add", "failed to add k/v: %d\n", err))
 		goto cleanup;
-	err = hashmap__append(map, k1, (void *)4);
+	err = hashmap__append(map, k1, 4);
 	if (CHECK(err, "elem_add", "failed to add k/v: %d\n", err))
 		goto cleanup;
 
-	err = hashmap__append(map, k2, (void *)8);
+	err = hashmap__append(map, k2, 8);
 	if (CHECK(err, "elem_add", "failed to add k/v: %d\n", err))
 		goto cleanup;
-	err = hashmap__append(map, k2, (void *)16);
+	err = hashmap__append(map, k2, 16);
 	if (CHECK(err, "elem_add", "failed to add k/v: %d\n", err))
 		goto cleanup;
-	err = hashmap__append(map, k2, (void *)32);
+	err = hashmap__append(map, k2, 32);
 	if (CHECK(err, "elem_add", "failed to add k/v: %d\n", err))
 		goto cleanup;
 
@@ -300,7 +294,7 @@ static void test_hashmap_multimap(void)
 	/* verify global iteration still works and sees all values */
 	found_msk = 0;
 	hashmap__for_each_entry(map, entry, bkt) {
-		found_msk |= (long)entry->value;
+		found_msk |= entry->value;
 	}
 	if (CHECK(found_msk != (1 << 6) - 1, "found_msk",
 		  "not all keys iterated: %lx\n", found_msk))
@@ -309,7 +303,7 @@ static void test_hashmap_multimap(void)
 	/* iterate values for key 1 */
 	found_msk = 0;
 	hashmap__for_each_key_entry(map, entry, k1) {
-		found_msk |= (long)entry->value;
+		found_msk |= entry->value;
 	}
 	if (CHECK(found_msk != (1 | 2 | 4), "found_msk",
 		  "invalid k1 values: %lx\n", found_msk))
@@ -318,7 +312,7 @@ static void test_hashmap_multimap(void)
 	/* iterate values for key 2 */
 	found_msk = 0;
 	hashmap__for_each_key_entry(map, entry, k2) {
-		found_msk |= (long)entry->value;
+		found_msk |= entry->value;
 	}
 	if (CHECK(found_msk != (8 | 16 | 32), "found_msk",
 		  "invalid k2 values: %lx\n", found_msk))
@@ -333,7 +327,7 @@ static void test_hashmap_empty()
 	struct hashmap_entry *entry;
 	int bkt;
 	struct hashmap *map;
-	void *k = (void *)0;
+	long k = 0;
 
 	/* force collisions */
 	map = hashmap__new(hash_fn, equal_fn, NULL);
diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 287b3ac40227..11402cfa298c 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -312,12 +312,12 @@ static inline __u64 get_time_ns(void)
 	return (__u64) t.tv_sec * 1000000000 + t.tv_nsec;
 }
 
-static size_t symbol_hash(const void *key, void *ctx __maybe_unused)
+static size_t symbol_hash(long key, void *ctx __maybe_unused)
 {
 	return str_hash((const char *) key);
 }
 
-static bool symbol_equal(const void *key1, const void *key2, void *ctx __maybe_unused)
+static bool symbol_equal(long key1, long key2, void *ctx __maybe_unused)
 {
 	return strcmp((const char *) key1, (const char *) key2) == 0;
 }
@@ -372,7 +372,7 @@ static int get_syms(char ***symsp, size_t *cntp)
 			     sizeof("__ftrace_invalid_address__") - 1))
 			continue;
 
-		err = hashmap__add(map, name, NULL);
+		err = hashmap__add(map, (long)name, 0);
 		if (err == -EEXIST)
 			continue;
 		if (err)
-- 
2.34.1

