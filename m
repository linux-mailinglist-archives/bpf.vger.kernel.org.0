Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9267C59C92D
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 21:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbiHVTpW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 15:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238207AbiHVTpU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 15:45:20 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C840C5280A
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 12:45:17 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id b5-20020a17090a12c500b001faa33a11dbso6572678pjg.1
        for <bpf@vger.kernel.org>; Mon, 22 Aug 2022 12:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=eOKSsQiaLmV0h5ZvglNLF7HMlgBi+J9D8xuEs5O+hG0=;
        b=OD8VTLaXz3afanpzbWfMEsLjZk5GrzSitqxPldgjfRgqsVAimFloE5Vmeu4YeG02Am
         xMbUxEvu+qMkV/KqIXpD+fx/TRZ2y8lop2XvkqWIVQu0RN0bbccV2NDlDZBj5ys04qdF
         nbfWNQeDF1kaqWagUDjns8i+DKkF9xvW7U3O9WA21Tt1QEauhuGSbSAJT6b/eBU+y6zT
         2h0py+jXCfDuwAzSs8TZcqrBbpVL4A6R0S3b0fUGENbCRxCTxeJA1ZntYUf4SPj9DjAC
         b4MwzCOvXLbqQWt8FW36NT8Kr6cexItAq9Gg7nPEpcKvAMvGnjilziN7pZ7UT9UxHlW9
         HjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=eOKSsQiaLmV0h5ZvglNLF7HMlgBi+J9D8xuEs5O+hG0=;
        b=bJBtfM4ultpcHJ+sShrhi3QHiHSqVxIF8nM3Q3WCI9A86hlfgmtQTNQr8Lu/sKiz2u
         J6vQr6ZQtj5uPt6ZZ5Tuq2ULXMswOyf8bslo1zixWrrZl7WB1KwlmWei2L0iNYFHXeoM
         UeWDhhLv2U26zKsV5n/29rA7JPTPlE6VtkB6vNRkRX5AJ4JtbKe+RepEW07PIC+o0hi9
         lIprcfdVLANOUZpJAXxr4Nq1nG/kelIB4dm1KZjFJrrMbv0QOnXf+653qFiofWoT0TCv
         n7346IHkEpx8mmPVVb+2zNjtwBB81S8gG/ffyjeSgWua0STjBd+Hca5r1K+mIcozpIOl
         blzg==
X-Gm-Message-State: ACgBeo3aAknVUMWAte2jHpDDwi2+He4XEwal8UM2w9gpd2WPyCI5Zk3B
        rU4qhMOu7hjLJKwmHXouiUoEWB/ffvSTkUbLoFlfT7D6g9Gvu7mUa8glemsxLJbhTHyQa838fkr
        CKEiO+gMxYbLql1sbbus24K3qQMhtKfKO+lGnUFRST4ST0N2pGw==
X-Google-Smtp-Source: AA6agR6+N/RYqXqNQggWGVxZbG5mu68PG2yGj8kfyu6/L6kDqENTjEqgGE5w1wyImUMtfqSNM7vI3sU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP id
 t9-20020a17090a024900b001e0a8a33c6cmr36050pje.0.1661197516637; Mon, 22 Aug
 2022 12:45:16 -0700 (PDT)
Date:   Mon, 22 Aug 2022 12:45:09 -0700
In-Reply-To: <20220822194513.2655481-1-sdf@google.com>
Message-Id: <20220822194513.2655481-2-sdf@google.com>
Mime-Version: 1.0
References: <20220822194513.2655481-1-sdf@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf-next v4 1/5] bpf: Introduce cgroup_{common,current}_func_proto
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
 include/linux/bpf-cgroup.h |  17 ++++++
 kernel/bpf/cgroup.c        | 120 +++++++++++++++++++++++++++++++------
 kernel/bpf/helpers.c       |  36 +----------
 3 files changed, 119 insertions(+), 54 deletions(-)

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
index 59b7eb60d5b4..1c8ac13fe208 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -18,6 +18,7 @@
 #include <linux/bpf_verifier.h>
 #include <net/sock.h>
 #include <net/bpf_sk_storage.h>
+#include <net/cls_cgroup.h>
 
 #include "../cgroup/cgroup-internal.h"
 
@@ -1527,6 +1528,37 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 	return ret;
 }
 
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
@@ -1558,32 +1590,26 @@ const struct bpf_func_proto bpf_set_retval_proto = {
 };
 
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
@@ -2096,6 +2122,16 @@ static const struct bpf_func_proto bpf_sysctl_set_new_value_proto = {
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
@@ -2111,8 +2147,10 @@ sysctl_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
 
@@ -2233,6 +2271,16 @@ static const struct bpf_func_proto bpf_get_netns_cookie_sockopt_proto = {
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
@@ -2254,8 +2302,10 @@ cg_sockopt_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
 
@@ -2420,3 +2470,35 @@ const struct bpf_verifier_ops cg_sockopt_verifier_ops = {
 
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
+const struct bpf_func_proto bpf_get_current_cgroup_id_proto __weak;
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
index 3c1b9bbcf971..dd20e2dc6ea6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -427,40 +427,7 @@ const struct bpf_func_proto bpf_get_current_ancestor_cgroup_id_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_ANYTHING,
 };
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
+#endif /* CONFIG_CGROUPS */
 
 #define BPF_STRTOX_BASE_MASK 0x1F
 
@@ -589,7 +556,6 @@ const struct bpf_func_proto bpf_strtoul_proto = {
 	.arg3_type	= ARG_ANYTHING,
 	.arg4_type	= ARG_PTR_TO_LONG,
 };
-#endif
 
 BPF_CALL_3(bpf_strncmp, const char *, s1, u32, s1_sz, const char *, s2)
 {
-- 
2.37.1.595.g718a3a8f04-goog

