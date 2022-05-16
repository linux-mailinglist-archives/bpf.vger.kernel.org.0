Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE08528C12
	for <lists+bpf@lfdr.de>; Mon, 16 May 2022 19:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344308AbiEPRgZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 13:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344327AbiEPRgD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 13:36:03 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D3425EB1
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 10:35:59 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 2437A24010A
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 19:35:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1652722558; bh=7r0Oq0Lgw/XlubgoErBgowqVIJumjqgUOQbsuIbEtes=;
        h=From:To:Subject:Date:From;
        b=MyGtB0BG/CjHETFcIeDw70eBqaWG5U8BP2TCMOaPLSNygvU/t3V/LGZ5MseETIPtj
         aijMvOS1g2NremYqeuP0WL0HE8bxGdj5KCU3m6DKaENJMT0hUz8Hz9e/TrdzQNICYo
         7ZTDMGyyPHrXCDZmG6Pg5KSh6I8OmF0JsqGnOJ7y2Z4RCo/AHXW5IGHWNu6ZExam6s
         F1vn9+dkldivWhTeVYn0EOpjBK0qXlwJHT3qo6Y4pckKTSofzfezbZ41we+HccVR/x
         JuCfhJ3TiQDMnTO4XwHgLjKeOnpEgtHCjo0PkifSKDpjjvY4il+j6dkmfWinjyDUZ8
         03WSegWk4NvfA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L25y51j5rz9rxB;
        Mon, 16 May 2022 19:35:57 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, quentin@isovalent.com
Subject: [PATCH bpf-next 06/12] bpftool: Use libbpf_bpf_map_type_str
Date:   Mon, 16 May 2022 17:35:34 +0000
Message-Id: <20220516173540.3520665-7-deso@posteo.net>
In-Reply-To: <20220516173540.3520665-1-deso@posteo.net>
References: <20220516173540.3520665-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This change switches bpftool over to using the recently introduced
libbpf_bpf_map_type_str function instead of maintaining its own string
representation for the bpf_map_type enum.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/bpf/bpftool/feature.c | 30 +++++++++-------
 tools/bpf/bpftool/main.h    |  3 --
 tools/bpf/bpftool/map.c     | 69 ++++++++++++++-----------------------
 3 files changed, 42 insertions(+), 60 deletions(-)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index a093e1..236c53 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -615,8 +615,8 @@ static bool probe_map_type_ifindex(enum bpf_map_type map_type, __u32 ifindex)
 }
 
 static void
-probe_map_type(enum bpf_map_type map_type, const char *define_prefix,
-	       __u32 ifindex)
+probe_map_type(enum bpf_map_type map_type, char const *map_type_str,
+	       const char *define_prefix, __u32 ifindex)
 {
 	char feat_name[128], plain_desc[128], define_name[128];
 	const char *plain_comment = "eBPF map_type ";
@@ -641,20 +641,16 @@ probe_map_type(enum bpf_map_type map_type, const char *define_prefix,
 	 * check required for unprivileged users
 	 */
 
-	if (!map_type_name[map_type]) {
-		p_info("map type name not found (type %d)", map_type);
-		return;
-	}
 	maxlen = sizeof(plain_desc) - strlen(plain_comment) - 1;
-	if (strlen(map_type_name[map_type]) > maxlen) {
+	if (strlen(map_type_str) > maxlen) {
 		p_info("map type name too long");
 		return;
 	}
 
-	sprintf(feat_name, "have_%s_map_type", map_type_name[map_type]);
-	sprintf(define_name, "%s_map_type", map_type_name[map_type]);
+	sprintf(feat_name, "have_%s_map_type", map_type_str);
+	sprintf(define_name, "%s_map_type", map_type_str);
 	uppercase(define_name, sizeof(define_name));
-	sprintf(plain_desc, "%s%s", plain_comment, map_type_name[map_type]);
+	sprintf(plain_desc, "%s%s", plain_comment, map_type_str);
 	print_bool_feature(feat_name, plain_desc, define_name, res,
 			   define_prefix);
 }
@@ -963,15 +959,23 @@ section_program_types(bool *supported_types, const char *define_prefix,
 
 static void section_map_types(const char *define_prefix, __u32 ifindex)
 {
-	unsigned int i;
+	unsigned int map_type = BPF_MAP_TYPE_UNSPEC;
+	const char *map_type_str;
 
 	print_start_section("map_types",
 			    "Scanning eBPF map types...",
 			    "/*** eBPF map types ***/",
 			    define_prefix);
 
-	for (i = BPF_MAP_TYPE_UNSPEC + 1; i < map_type_name_size; i++)
-		probe_map_type(i, define_prefix, ifindex);
+	while (true) {
+		map_type++;
+		map_type_str = libbpf_bpf_map_type_str(map_type);
+		/* libbpf will return NULL for variants unknown to it. */
+		if (!map_type_str)
+			break;
+
+		probe_map_type(map_type, map_type_str, define_prefix, ifindex);
+	}
 
 	print_end_section();
 }
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 74204d..e4fdaa0 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -65,9 +65,6 @@ static inline void *u64_to_ptr(__u64 ptr)
 
 extern const char * const attach_type_name[__MAX_BPF_ATTACH_TYPE];
 
-extern const char * const map_type_name[];
-extern const size_t map_type_name_size;
-
 /* keep in sync with the definition in skeleton/pid_iter.bpf.c */
 enum bpf_obj_type {
 	BPF_OBJ_UNKNOWN,
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 70a1fd5..800834b 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -22,42 +22,6 @@
 #include "json_writer.h"
 #include "main.h"
 
-const char * const map_type_name[] = {
-	[BPF_MAP_TYPE_UNSPEC]			= "unspec",
-	[BPF_MAP_TYPE_HASH]			= "hash",
-	[BPF_MAP_TYPE_ARRAY]			= "array",
-	[BPF_MAP_TYPE_PROG_ARRAY]		= "prog_array",
-	[BPF_MAP_TYPE_PERF_EVENT_ARRAY]		= "perf_event_array",
-	[BPF_MAP_TYPE_PERCPU_HASH]		= "percpu_hash",
-	[BPF_MAP_TYPE_PERCPU_ARRAY]		= "percpu_array",
-	[BPF_MAP_TYPE_STACK_TRACE]		= "stack_trace",
-	[BPF_MAP_TYPE_CGROUP_ARRAY]		= "cgroup_array",
-	[BPF_MAP_TYPE_LRU_HASH]			= "lru_hash",
-	[BPF_MAP_TYPE_LRU_PERCPU_HASH]		= "lru_percpu_hash",
-	[BPF_MAP_TYPE_LPM_TRIE]			= "lpm_trie",
-	[BPF_MAP_TYPE_ARRAY_OF_MAPS]		= "array_of_maps",
-	[BPF_MAP_TYPE_HASH_OF_MAPS]		= "hash_of_maps",
-	[BPF_MAP_TYPE_DEVMAP]			= "devmap",
-	[BPF_MAP_TYPE_DEVMAP_HASH]		= "devmap_hash",
-	[BPF_MAP_TYPE_SOCKMAP]			= "sockmap",
-	[BPF_MAP_TYPE_CPUMAP]			= "cpumap",
-	[BPF_MAP_TYPE_XSKMAP]			= "xskmap",
-	[BPF_MAP_TYPE_SOCKHASH]			= "sockhash",
-	[BPF_MAP_TYPE_CGROUP_STORAGE]		= "cgroup_storage",
-	[BPF_MAP_TYPE_REUSEPORT_SOCKARRAY]	= "reuseport_sockarray",
-	[BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE]	= "percpu_cgroup_storage",
-	[BPF_MAP_TYPE_QUEUE]			= "queue",
-	[BPF_MAP_TYPE_STACK]			= "stack",
-	[BPF_MAP_TYPE_SK_STORAGE]		= "sk_storage",
-	[BPF_MAP_TYPE_STRUCT_OPS]		= "struct_ops",
-	[BPF_MAP_TYPE_RINGBUF]			= "ringbuf",
-	[BPF_MAP_TYPE_INODE_STORAGE]		= "inode_storage",
-	[BPF_MAP_TYPE_TASK_STORAGE]		= "task_storage",
-	[BPF_MAP_TYPE_BLOOM_FILTER]		= "bloom_filter",
-};
-
-const size_t map_type_name_size = ARRAY_SIZE(map_type_name);
-
 static struct hashmap *map_table;
 
 static bool map_is_per_cpu(__u32 type)
@@ -81,12 +45,18 @@ static bool map_is_map_of_progs(__u32 type)
 
 static int map_type_from_str(const char *type)
 {
+	const char *map_type_str;
 	unsigned int i;
 
-	for (i = 0; i < ARRAY_SIZE(map_type_name); i++)
+	for (i = 0; ; i++) {
+		map_type_str = libbpf_bpf_map_type_str(i);
+		if (!map_type_str)
+			break;
+
 		/* Don't allow prefixing in case of possible future shadowing */
-		if (map_type_name[i] && !strcmp(map_type_name[i], type))
+		if (!strcmp(map_type_str, type))
 			return i;
+	}
 	return -1;
 }
 
@@ -472,9 +442,12 @@ static int parse_elem(char **argv, struct bpf_map_info *info,
 
 static void show_map_header_json(struct bpf_map_info *info, json_writer_t *wtr)
 {
+	const char *map_type_str;
+
 	jsonw_uint_field(wtr, "id", info->id);
-	if (info->type < ARRAY_SIZE(map_type_name))
-		jsonw_string_field(wtr, "type", map_type_name[info->type]);
+	map_type_str = libbpf_bpf_map_type_str(info->type);
+	if (map_type_str)
+		jsonw_string_field(wtr, "type", map_type_str);
 	else
 		jsonw_uint_field(wtr, "type", info->type);
 
@@ -561,9 +534,13 @@ static int show_map_close_json(int fd, struct bpf_map_info *info)
 
 static void show_map_header_plain(struct bpf_map_info *info)
 {
+	const char *map_type_str;
+
 	printf("%u: ", info->id);
-	if (info->type < ARRAY_SIZE(map_type_name))
-		printf("%s  ", map_type_name[info->type]);
+
+	map_type_str = libbpf_bpf_map_type_str(info->type);
+	if (map_type_str)
+		printf("%s  ", map_type_str);
 	else
 		printf("type %u  ", info->type);
 
@@ -879,9 +856,13 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
 	}
 
 	if (info->type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY &&
-	    info->value_size != 8)
+	    info->value_size != 8) {
+		const char *map_type_str;
+
+		map_type_str = libbpf_bpf_map_type_str(info->type);
 		p_info("Warning: cannot read values from %s map with value_size != 8",
-		       map_type_name[info->type]);
+		       map_type_str);
+	}
 	while (true) {
 		err = bpf_map_get_next_key(fd, prev_key, key);
 		if (err) {
-- 
2.30.2

