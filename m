Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F5559912C
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 01:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242423AbiHRX1f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 19:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241562AbiHRX1e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 19:27:34 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF274D7590
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 16:27:32 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id h12-20020a170902f54c00b0016f8858ce9bso1713933plf.9
        for <bpf@vger.kernel.org>; Thu, 18 Aug 2022 16:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=UCX10EefKjqAMd+MFpU7w3LWdEjJzDIv3P7ocwN0aNE=;
        b=rGEps9J6GENsQgheyNe1nkp50nVuZ8Jy+rpMtuYSEc+y16qPRRXPdI9q8xTh4Dg33X
         pMLJOTw3JINIMlZoxQPACnCpd3M0iRniiea9hbXaopwRkXx2afkbA+IGGUNZMNHOfr+T
         iLROYsid6xgtEA22t+LWG4jfbZ6dlMXt4q8vo+V2Qv0EVFImA3fW1VfG/Ry5/LEoy+V2
         7i4QSqB4JYzx1UxNKg9frsvS8vz3iTU7X0XIV0kGEiWWZM4dCXSXf27zJAEDgz1ps6v5
         BvpZfEQe8uKPHyDZ/S9aCTafCKKxLvcB8dEo4hj3ra6+dofwg+KWLo09qmIIP7kohXJC
         0e8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=UCX10EefKjqAMd+MFpU7w3LWdEjJzDIv3P7ocwN0aNE=;
        b=Fg1HvLkzeFoKxbqyPZrx8xBLysoGeBbSEwvGsiZL4MgVGCqh4IyQ0rCQ6hiHLNtDMG
         1UdIxIm+HTz2IkoGwQXAxSXaH9bnik7EXLGatMd+Av734QEU0Isr87Ex4OXRiISewrkH
         EDnGfSFzpTQ6Yb/AgK01jRxQd4sg6xMr9xHciSOTo98SvyUbNotZJotuPnzh1WH1CGtI
         hue2WQRXCNzP4AWRQYnwOGSXtsu7XMeCVNtyUYYb0lsovQC/nKi90FQ6a/3qYKHjj3z8
         LKqiqwToaUwVUxYKy3caVg6xOKi/fk/E5JaAzzgKDXTCHmTdctUR2rq+PJDuOmvDuAfH
         qxYA==
X-Gm-Message-State: ACgBeo3TsWu7K9LD/9iRGxMkdQS3phjWp8CCGeQlg3/iTMshZ3dYlOkN
        K8Yuv3kUzHnnJdZVOkt3Pn9d0oox5B/buQe1SiksJ40GHcrx1MlBhhFrODopaGDqezwjsqfHRY9
        2x5PnrQVSEcjM8DFJjit3s9EtVRYQVY6lsN2zG1gqKJPplZDMCA==
X-Google-Smtp-Source: AA6agR5aqceZXd53/0g99rCzwh02Q2Qj3tC/CMsJ2S0w44xkxONA3MKOIVbxA2R/3Qm9X0gxQ04Xorc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:1a88:b0:52f:52df:ce1d with SMTP id
 e8-20020a056a001a8800b0052f52dfce1dmr5106510pfv.13.1660865252233; Thu, 18 Aug
 2022 16:27:32 -0700 (PDT)
Date:   Thu, 18 Aug 2022 16:27:25 -0700
In-Reply-To: <20220818232729.2479330-1-sdf@google.com>
Message-Id: <20220818232729.2479330-2-sdf@google.com>
Mime-Version: 1.0
References: <20220818232729.2479330-1-sdf@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf-next v3 1/5] bpf: Introduce cgroup_{common,current}_func_proto
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Split cgroup_base_func_proto into the following:

* cgroup_common_func_proto - common helpers for all cgroup hooks
* cgroup_current_func_proto - common helpers for all cgroup hooks
  running in the process context (== have meaningful 'current').

Move bpf_{g,s}et_retval and other cgroup-related helpers into
kernel/bpf/cgroup.c so they closer to where they are being used.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf-cgroup.h |  17 ++++
 kernel/bpf/cgroup.c        | 172 +++++++++++++++++++++++++++++++++----
 kernel/bpf/helpers.c       |  77 -----------------
 net/core/filter.c          |  14 +--
 4 files changed, 173 insertions(+), 107 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 2bd1b5f8de9b..57e9e109257e 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -414,6 +414,11 @@ int cgroup_bpf_prog_detach(const union bpf_attr *attr,
 int cgroup_bpf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog);
 int cgroup_bpf_prog_query(const union bpf_attr *attr,
 			  union bpf_attr __user *uattr);
+
+const struct bpf_func_proto *
+cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog);
+const struct bpf_func_proto *
+cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog);
 #else
 
 static inline int cgroup_bpf_inherit(struct cgroup *cgrp) { return 0; }
@@ -444,6 +449,18 @@ static inline int cgroup_bpf_prog_query(const union bpf_attr *attr,
 	return -EINVAL;
 }
 
+static inline const struct bpf_func_proto *
+cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	return NULL;
+}
+
+static inline const struct bpf_func_proto *
+cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	return NULL;
+}
+
 static inline int bpf_cgroup_storage_assign(struct bpf_prog_aux *aux,
 					    struct bpf_map *map) { return 0; }
 static inline struct bpf_cgroup_storage *bpf_cgroup_storage_alloc(
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 59b7eb60d5b4..74b5cc692a36 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -18,6 +18,7 @@
 #include <linux/bpf_verifier.h>
 #include <net/sock.h>
 #include <net/bpf_sk_storage.h>
+#include <net/cls_cgroup.h>
 
 #include "../cgroup/cgroup-internal.h"
 
@@ -1527,6 +1528,78 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 	return ret;
 }
 
+BPF_CALL_0(bpf_get_current_cgroup_id)
+{
+	struct cgroup *cgrp;
+	u64 cgrp_id;
+
+	rcu_read_lock();
+	cgrp = task_dfl_cgroup(current);
+	cgrp_id = cgroup_id(cgrp);
+	rcu_read_unlock();
+
+	return cgrp_id;
+}
+
+const struct bpf_func_proto bpf_get_current_cgroup_id_proto = {
+	.func		= bpf_get_current_cgroup_id,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+};
+
+BPF_CALL_1(bpf_get_current_ancestor_cgroup_id, int, ancestor_level)
+{
+	struct cgroup *cgrp;
+	struct cgroup *ancestor;
+	u64 cgrp_id;
+
+	rcu_read_lock();
+	cgrp = task_dfl_cgroup(current);
+	ancestor = cgroup_ancestor(cgrp, ancestor_level);
+	cgrp_id = ancestor ? cgroup_id(ancestor) : 0;
+	rcu_read_unlock();
+
+	return cgrp_id;
+}
+
+const struct bpf_func_proto bpf_get_current_ancestor_cgroup_id_proto = {
+	.func		= bpf_get_current_ancestor_cgroup_id,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_ANYTHING,
+};
+
+BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
+{
+	/* flags argument is not used now,
+	 * but provides an ability to extend the API.
+	 * verifier checks that its value is correct.
+	 */
+	enum bpf_cgroup_storage_type stype = cgroup_storage_type(map);
+	struct bpf_cgroup_storage *storage;
+	struct bpf_cg_run_ctx *ctx;
+	void *ptr;
+
+	/* get current cgroup storage from BPF run context */
+	ctx = container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
+	storage = ctx->prog_item->cgroup_storage[stype];
+
+	if (stype == BPF_CGROUP_STORAGE_SHARED)
+		ptr = &READ_ONCE(storage->buf)->data[0];
+	else
+		ptr = this_cpu_ptr(storage->percpu_buf);
+
+	return (unsigned long)ptr;
+}
+
+const struct bpf_func_proto bpf_get_local_storage_proto = {
+	.func		= bpf_get_local_storage,
+	.gpl_only	= false,
+	.ret_type	= RET_PTR_TO_MAP_VALUE,
+	.arg1_type	= ARG_CONST_MAP_PTR,
+	.arg2_type	= ARG_ANYTHING,
+};
+
 BPF_CALL_0(bpf_get_retval)
 {
 	struct bpf_cg_run_ctx *ctx =
@@ -1557,33 +1630,40 @@ const struct bpf_func_proto bpf_set_retval_proto = {
 	.arg1_type	= ARG_ANYTHING,
 };
 
+#ifdef CONFIG_CGROUP_NET_CLASSID
+BPF_CALL_0(bpf_get_cgroup_classid_curr)
+{
+	return __task_get_classid(current);
+}
+
+const struct bpf_func_proto bpf_get_cgroup_classid_curr_proto = {
+	.func		= bpf_get_cgroup_classid_curr,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+};
+#endif
+
 static const struct bpf_func_proto *
-cgroup_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+cgroup_dev_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
+	const struct bpf_func_proto *func_proto;
+
+	func_proto = cgroup_common_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
+	func_proto = cgroup_current_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
 	switch (func_id) {
-	case BPF_FUNC_get_current_uid_gid:
-		return &bpf_get_current_uid_gid_proto;
-	case BPF_FUNC_get_local_storage:
-		return &bpf_get_local_storage_proto;
-	case BPF_FUNC_get_current_cgroup_id:
-		return &bpf_get_current_cgroup_id_proto;
 	case BPF_FUNC_perf_event_output:
 		return &bpf_event_output_data_proto;
-	case BPF_FUNC_get_retval:
-		return &bpf_get_retval_proto;
-	case BPF_FUNC_set_retval:
-		return &bpf_set_retval_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
 }
 
-static const struct bpf_func_proto *
-cgroup_dev_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
-{
-	return cgroup_base_func_proto(func_id, prog);
-}
-
 static bool cgroup_dev_is_valid_access(int off, int size,
 				       enum bpf_access_type type,
 				       const struct bpf_prog *prog,
@@ -2096,6 +2176,16 @@ static const struct bpf_func_proto bpf_sysctl_set_new_value_proto = {
 static const struct bpf_func_proto *
 sysctl_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
+	const struct bpf_func_proto *func_proto;
+
+	func_proto = cgroup_common_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
+	func_proto = cgroup_current_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
 	switch (func_id) {
 	case BPF_FUNC_strtol:
 		return &bpf_strtol_proto;
@@ -2111,8 +2201,10 @@ sysctl_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sysctl_set_new_value_proto;
 	case BPF_FUNC_ktime_get_coarse_ns:
 		return &bpf_ktime_get_coarse_ns_proto;
+	case BPF_FUNC_perf_event_output:
+		return &bpf_event_output_data_proto;
 	default:
-		return cgroup_base_func_proto(func_id, prog);
+		return bpf_base_func_proto(func_id);
 	}
 }
 
@@ -2233,6 +2325,16 @@ static const struct bpf_func_proto bpf_get_netns_cookie_sockopt_proto = {
 static const struct bpf_func_proto *
 cg_sockopt_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
+	const struct bpf_func_proto *func_proto;
+
+	func_proto = cgroup_common_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
+	func_proto = cgroup_current_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
+
 	switch (func_id) {
 #ifdef CONFIG_NET
 	case BPF_FUNC_get_netns_cookie:
@@ -2254,8 +2356,10 @@ cg_sockopt_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 	case BPF_FUNC_tcp_sock:
 		return &bpf_tcp_sock_proto;
 #endif
+	case BPF_FUNC_perf_event_output:
+		return &bpf_event_output_data_proto;
 	default:
-		return cgroup_base_func_proto(func_id, prog);
+		return bpf_base_func_proto(func_id);
 	}
 }
 
@@ -2420,3 +2524,33 @@ const struct bpf_verifier_ops cg_sockopt_verifier_ops = {
 
 const struct bpf_prog_ops cg_sockopt_prog_ops = {
 };
+
+/* Common helpers for cgroup hooks. */
+const struct bpf_func_proto *
+cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
+	case BPF_FUNC_get_retval:
+		return &bpf_get_retval_proto;
+	case BPF_FUNC_set_retval:
+		return &bpf_set_retval_proto;
+	default:
+		return NULL;
+	}
+}
+
+/* Common helpers for cgroup hooks with valid process context. */
+const struct bpf_func_proto *
+cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	case BPF_FUNC_get_current_uid_gid:
+		return &bpf_get_current_uid_gid_proto;
+	case BPF_FUNC_get_current_cgroup_id:
+		return &bpf_get_current_cgroup_id_proto;
+	default:
+		return NULL;
+	}
+}
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 3c1b9bbcf971..71979d870646 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -386,82 +386,6 @@ const struct bpf_func_proto bpf_jiffies64_proto = {
 	.ret_type	= RET_INTEGER,
 };
 
-#ifdef CONFIG_CGROUPS
-BPF_CALL_0(bpf_get_current_cgroup_id)
-{
-	struct cgroup *cgrp;
-	u64 cgrp_id;
-
-	rcu_read_lock();
-	cgrp = task_dfl_cgroup(current);
-	cgrp_id = cgroup_id(cgrp);
-	rcu_read_unlock();
-
-	return cgrp_id;
-}
-
-const struct bpf_func_proto bpf_get_current_cgroup_id_proto = {
-	.func		= bpf_get_current_cgroup_id,
-	.gpl_only	= false,
-	.ret_type	= RET_INTEGER,
-};
-
-BPF_CALL_1(bpf_get_current_ancestor_cgroup_id, int, ancestor_level)
-{
-	struct cgroup *cgrp;
-	struct cgroup *ancestor;
-	u64 cgrp_id;
-
-	rcu_read_lock();
-	cgrp = task_dfl_cgroup(current);
-	ancestor = cgroup_ancestor(cgrp, ancestor_level);
-	cgrp_id = ancestor ? cgroup_id(ancestor) : 0;
-	rcu_read_unlock();
-
-	return cgrp_id;
-}
-
-const struct bpf_func_proto bpf_get_current_ancestor_cgroup_id_proto = {
-	.func		= bpf_get_current_ancestor_cgroup_id,
-	.gpl_only	= false,
-	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_ANYTHING,
-};
-
-#ifdef CONFIG_CGROUP_BPF
-
-BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
-{
-	/* flags argument is not used now,
-	 * but provides an ability to extend the API.
-	 * verifier checks that its value is correct.
-	 */
-	enum bpf_cgroup_storage_type stype = cgroup_storage_type(map);
-	struct bpf_cgroup_storage *storage;
-	struct bpf_cg_run_ctx *ctx;
-	void *ptr;
-
-	/* get current cgroup storage from BPF run context */
-	ctx = container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
-	storage = ctx->prog_item->cgroup_storage[stype];
-
-	if (stype == BPF_CGROUP_STORAGE_SHARED)
-		ptr = &READ_ONCE(storage->buf)->data[0];
-	else
-		ptr = this_cpu_ptr(storage->percpu_buf);
-
-	return (unsigned long)ptr;
-}
-
-const struct bpf_func_proto bpf_get_local_storage_proto = {
-	.func		= bpf_get_local_storage,
-	.gpl_only	= false,
-	.ret_type	= RET_PTR_TO_MAP_VALUE,
-	.arg1_type	= ARG_CONST_MAP_PTR,
-	.arg2_type	= ARG_ANYTHING,
-};
-#endif
-
 #define BPF_STRTOX_BASE_MASK 0x1F
 
 static int __bpf_strtoull(const char *buf, size_t buf_len, u64 flags,
@@ -589,7 +513,6 @@ const struct bpf_func_proto bpf_strtoul_proto = {
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_LONG,
 };
-#endif
 
 BPF_CALL_3(bpf_strncmp, const char *, s1, u32, s1_sz, const char *, s2)
 {
diff --git a/net/core/filter.c b/net/core/filter.c
index e8508aaafd27..df6bae0f98a7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3004,17 +3004,6 @@ static const struct bpf_func_proto bpf_msg_pop_data_proto = {
 };
 
 #ifdef CONFIG_CGROUP_NET_CLASSID
-BPF_CALL_0(bpf_get_cgroup_classid_curr)
-{
-	return __task_get_classid(current);
-}
-
-static const struct bpf_func_proto bpf_get_cgroup_classid_curr_proto = {
-	.func		= bpf_get_cgroup_classid_curr,
-	.gpl_only	= false,
-	.ret_type	= RET_INTEGER,
-};
-
 BPF_CALL_1(bpf_skb_cgroup_classid, const struct sk_buff *, skb)
 {
 	struct sock *sk = skb_to_full_sk(skb);
@@ -8104,6 +8093,9 @@ sock_ops_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 
 const struct bpf_func_proto bpf_msg_redirect_map_proto __weak;
 const struct bpf_func_proto bpf_msg_redirect_hash_proto __weak;
+const struct bpf_func_proto bpf_get_cgroup_classid_curr_proto __weak;
+const struct bpf_func_proto bpf_get_current_cgroup_id_proto __weak;
+const struct bpf_func_proto bpf_get_current_ancestor_cgroup_id_proto __weak;
 
 static const struct bpf_func_proto *
 sk_msg_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
-- 
2.37.1.595.g718a3a8f04-goog

