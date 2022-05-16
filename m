Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E01528C0F
	for <lists+bpf@lfdr.de>; Mon, 16 May 2022 19:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344307AbiEPRf4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 13:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344312AbiEPRfz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 13:35:55 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D4D20D
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 10:35:53 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 8A42324010D
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 19:35:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1652722552; bh=Vm33lnXo4gvTiyik3fxlYpZD/YYxTmOTYcBP4pJkBpc=;
        h=From:To:Subject:Date:From;
        b=QC87VuMXOWjNnXHGKA5VdzhJKTb89nfwOS0xDY/KrSZoPvsEGIdCC6yaIMGVYjuJP
         zPrbkqnybxhlzKIxvpHiE+fBl6mi0yaSuznyM+pUxPyelxEhmQMRiaYpZpd5L+mpID
         eZNLD11BQJAvgCZSudkCfynQSSZQNWyULhYrjUBSFW6q7UFWCujU/Qdf6JJNDIbTXe
         gwq/pLYdvz3PpUhMsaBdw7rXU5HiLm6EDG3GjYOknobfdD5V0jSQMi610grawSgwNS
         sQSkF0w8gsGgQ9DbINAhp1IQrwrFcKrHHzfPJe4D9M7At4x7DFa16DIoIhEbB1Eyms
         JiC2swvDsANvA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L25xz2yFGz6tmV;
        Mon, 16 May 2022 19:35:51 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, quentin@isovalent.com
Subject: [PATCH bpf-next 04/12] libbpf: Introduce libbpf_bpf_map_type_str
Date:   Mon, 16 May 2022 17:35:32 +0000
Message-Id: <20220516173540.3520665-5-deso@posteo.net>
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

This change introduces a new function, libbpf_bpf_map_type_str, to the
public libbpf API. The function allows users to get a string
representation for a bpf_map_type enum variant.

Signed-off-by: Daniel Müller <deso@posteo.net>
---
 tools/lib/bpf/libbpf.c   | 42 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  9 +++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 52 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 236c82..c17f836 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -72,6 +72,40 @@
 static struct bpf_map *bpf_object__add_map(struct bpf_object *obj);
 static bool prog_is_subprog(const struct bpf_object *obj, const struct bpf_program *prog);
 
+static const char * const map_type_name[] = {
+	[BPF_MAP_TYPE_UNSPEC]			= "unspec",
+	[BPF_MAP_TYPE_HASH]			= "hash",
+	[BPF_MAP_TYPE_ARRAY]			= "array",
+	[BPF_MAP_TYPE_PROG_ARRAY]		= "prog_array",
+	[BPF_MAP_TYPE_PERF_EVENT_ARRAY]		= "perf_event_array",
+	[BPF_MAP_TYPE_PERCPU_HASH]		= "percpu_hash",
+	[BPF_MAP_TYPE_PERCPU_ARRAY]		= "percpu_array",
+	[BPF_MAP_TYPE_STACK_TRACE]		= "stack_trace",
+	[BPF_MAP_TYPE_CGROUP_ARRAY]		= "cgroup_array",
+	[BPF_MAP_TYPE_LRU_HASH]			= "lru_hash",
+	[BPF_MAP_TYPE_LRU_PERCPU_HASH]		= "lru_percpu_hash",
+	[BPF_MAP_TYPE_LPM_TRIE]			= "lpm_trie",
+	[BPF_MAP_TYPE_ARRAY_OF_MAPS]		= "array_of_maps",
+	[BPF_MAP_TYPE_HASH_OF_MAPS]		= "hash_of_maps",
+	[BPF_MAP_TYPE_DEVMAP]			= "devmap",
+	[BPF_MAP_TYPE_DEVMAP_HASH]		= "devmap_hash",
+	[BPF_MAP_TYPE_SOCKMAP]			= "sockmap",
+	[BPF_MAP_TYPE_CPUMAP]			= "cpumap",
+	[BPF_MAP_TYPE_XSKMAP]			= "xskmap",
+	[BPF_MAP_TYPE_SOCKHASH]			= "sockhash",
+	[BPF_MAP_TYPE_CGROUP_STORAGE]		= "cgroup_storage",
+	[BPF_MAP_TYPE_REUSEPORT_SOCKARRAY]	= "reuseport_sockarray",
+	[BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE]	= "percpu_cgroup_storage",
+	[BPF_MAP_TYPE_QUEUE]			= "queue",
+	[BPF_MAP_TYPE_STACK]			= "stack",
+	[BPF_MAP_TYPE_SK_STORAGE]		= "sk_storage",
+	[BPF_MAP_TYPE_STRUCT_OPS]		= "struct_ops",
+	[BPF_MAP_TYPE_RINGBUF]			= "ringbuf",
+	[BPF_MAP_TYPE_INODE_STORAGE]		= "inode_storage",
+	[BPF_MAP_TYPE_TASK_STORAGE]		= "task_storage",
+	[BPF_MAP_TYPE_BLOOM_FILTER]		= "bloom_filter",
+};
+
 static const char * const prog_type_name[] = {
 	[BPF_PROG_TYPE_UNSPEC]			= "unspec",
 	[BPF_PROG_TYPE_SOCKET_FILTER]		= "socket_filter",
@@ -9335,6 +9369,14 @@ int libbpf_prog_type_by_name(const char *name, enum bpf_prog_type *prog_type,
 	return libbpf_err(-ESRCH);
 }
 
+const char *libbpf_bpf_map_type_str(enum bpf_map_type t)
+{
+	if (t < 0 || t >= ARRAY_SIZE(map_type_name))
+		return NULL;
+
+	return map_type_name[t];
+}
+
 const char *libbpf_bpf_prog_type_str(enum bpf_prog_type t)
 {
 	if (t < 0 || t >= ARRAY_SIZE(prog_type_name))
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 11b5f8c..6c5b07 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -51,6 +51,15 @@ enum libbpf_errno {
 
 LIBBPF_API int libbpf_strerror(int err, char *buf, size_t size);
 
+/**
+ * @brief **libbpf_bpf_map_type_str()** converts the provided map type value
+ * into a textual representation.
+ * @param t The map type.
+ * @return Pointer to a static string identifying the map type. NULL is
+ * returned for unknown **bpf_map_type** values.
+ */
+LIBBPF_API const char *libbpf_bpf_map_type_str(enum bpf_map_type t);
+
 /**
  * @brief **libbpf_bpf_prog_type_str()** converts the provided program type
  * value into a textual representation.
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 8b93647..c63624 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -456,6 +456,7 @@ LIBBPF_0.8.0 {
 		bpf_program__attach_trace_opts;
 		bpf_program__attach_usdt;
 		bpf_program__set_insns;
+		libbpf_bpf_map_type_str;
 		libbpf_bpf_prog_type_str;
 		libbpf_register_prog_handler;
 		libbpf_unregister_prog_handler;
-- 
2.30.2

