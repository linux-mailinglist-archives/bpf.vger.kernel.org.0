Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6F852C883
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 02:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbiESAS3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 20:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbiESAS2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 20:18:28 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD26163F62
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 17:18:27 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 6D35D24010A
        for <bpf@vger.kernel.org>; Thu, 19 May 2022 02:18:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1652919506; bh=m+JrSNQ9zmiVSlZ4fG1fyamE9ZLkunHHKrFiTu62gd4=;
        h=From:To:Cc:Subject:Date:From;
        b=jlgUsgnslMz0R7hDrcG16bgRSdsZUTQB6mK9zaXd4vDtCk3oijqUgi6rUayaPKs2u
         z1GOocF42SP6lpin3gvb8KB34yaX0pqlLOIsEw9noLvD9fbb9p9UQYlYwjN2fhLlJy
         Jf8eMWMlr6jg8bdRvNO/TXWZKV3cRdtDBCY08BgOUCbsx4JAGZ8YmzbQEDQrD+3Ja4
         /ahqSYNbE2k046F80P80X+UxJq7EGkhHY+RhqaiCRxhJY4I3Sbvqoc+sqxhfY+d6cq
         7q7xEkvMOj1CX6SmaAlWQn2vSLOwtL4ysnaYjsABhBsf2jHJmh0mVwW2LER6uXXnsc
         NGOFhnB0WkhJw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L3VnY41tQz9rxF;
        Thu, 19 May 2022 02:18:25 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     yhs@fb.com, quentin@isovalent.com
Subject: [PATCH bpf-next v2 04/12] libbpf: Introduce libbpf_bpf_map_type_str
Date:   Thu, 19 May 2022 00:18:07 +0000
Message-Id: <20220519001815.1944959-5-deso@posteo.net>
In-Reply-To: <20220519001815.1944959-1-deso@posteo.net>
References: <20220519001815.1944959-1-deso@posteo.net>
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
index 6b9c0f..1cbe90 100644
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

