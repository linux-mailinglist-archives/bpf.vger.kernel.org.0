Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049AE531F0D
	for <lists+bpf@lfdr.de>; Tue, 24 May 2022 01:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiEWXEn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 19:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiEWXEm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 19:04:42 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8B8AF1EA
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 16:04:41 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 4B7AC240026
        for <bpf@vger.kernel.org>; Tue, 24 May 2022 01:04:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1653347080; bh=TWL3qly4tVkFp2sycIkM6WhbleoPl7YCVXUySuO322Y=;
        h=From:To:Cc:Subject:Date:From;
        b=pvxf4jmJujXd7IeBlPQtXAD2PO2GXYne0BpJrPH9fdYCF1j30TbKyBLKJXO+5bUEg
         AFfurxgnLooqAjKosq54+WdeLujQnIlEUBaOvQxoISlGx2BlilNxOynS7U/fMqoMVs
         s98jPIE77HCyFBbxjmw8oIjmsstOuK+0mSRnzUzj4Z1lP1ZPm4FB+BMq68eBJbh/IA
         6FOgTx0+WFr9yfdBg3Br4lVHv44dNXbtaJF2R+zFzl9d27Kdtj9vkY4WY1wU2Z6Iig
         /Aon7pb/Xkd226yQ11B9e5YwyAc2B1iVeA7KJ7xRnSH0k2PWhxBHNyXPS1uPNchN7C
         tQUg/T3eZkPjQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4L6Xw746Qmz6tmB;
        Tue, 24 May 2022 01:04:39 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     yhs@fb.com, quentin@isovalent.com
Subject: [PATCH bpf-next v4 04/12] libbpf: Introduce libbpf_bpf_map_type_str
Date:   Mon, 23 May 2022 23:04:20 +0000
Message-Id: <20220523230428.3077108-5-deso@posteo.net>
In-Reply-To: <20220523230428.3077108-1-deso@posteo.net>
References: <20220523230428.3077108-1-deso@posteo.net>
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
Acked-by: Quentin Monnet <quentin@isovalent.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/libbpf.c   | 42 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  9 +++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 52 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 01421a..a345bc 100644
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
index b12d290..16065ac 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -462,6 +462,7 @@ LIBBPF_0.8.0 {
 
 LIBBPF_1.0.0 {
 	global:
+		libbpf_bpf_map_type_str;
 		libbpf_bpf_prog_type_str;
 
 	local: *;
-- 
2.30.2

