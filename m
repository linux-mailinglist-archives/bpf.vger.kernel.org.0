Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4D959EF2F
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 00:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbiHWW0e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 18:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiHWW0F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 18:26:05 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68103876A5
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 15:25:59 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id q193-20020a632aca000000b0041d95d7ee81so6629516pgq.3
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 15:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=BiYGKJWfGdUkfpE8/MMO+kNDk9V1EgOsi+nCIdn6qds=;
        b=REFeHWie8+WmfDccGiymO+rpA6e8ZgKwEXtfolU+ESjUG/nIxqzrpj0cqJYe84XjvF
         +QOP/lGXwJlu7nFK+t+AY1deI/vISp6vP2ji3Z9TebXbA+wbCJafB/uvYaSZ/+Oq46CB
         3vQ8g5EYn1gBiA82iOkYlLPwNJFM+luldQf8H1RPOTyZF1QdFcxYDQQYqQ/P3mFRggqf
         FH0/nCyDxkfee8JxfFJpXeEzIOiEg0DnkNsWSS5cRWKYj/0nOzzG+1nONAIJF69ukWKI
         Gj5jgI+CInuscmLtXB6fmKsvNVe/ZDggjfynuRvBhFdmnP+pzTDedN/XaHbpNhgTUuMm
         6+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=BiYGKJWfGdUkfpE8/MMO+kNDk9V1EgOsi+nCIdn6qds=;
        b=zgE2G3YkeJ/GC8xzsAx2OszV3k8wAjX1LBMjIi3Nzi2CS8UwEs03T1MtxalacyN2iN
         fnSrtLkae5TdeSJmSqTcsXltnovyHiqoGmstFdJTeEzOxRS2rkd8MgWruL4HIpfDfQL0
         mlUsce86Fj/UFIeFdlxdfxQ98V6+YnQTixfbCbTR0zJetjH/QwIQmISN7vgdhCRQf5A3
         q3B7CvWkEeT07PLjGrXhRnGeXvF9/UV2XLG95XuHI/oYWmSExOe4JB3IxHS73jy8L0X0
         aMPO0snqPpQxDdwUBCuvM4CIPONZrtXchsIoluvmpF0HHxsJHw9hTlSn9QKY5i5FnLjN
         WTFg==
X-Gm-Message-State: ACgBeo0w8qtq+shSDrSddLAC9wVe2bfg/H3IbdSw65iOqokE3n9VUwIx
        FC0fsO2YqNH7oLW46/OUOHbA3qMtC1+VMB3SGml67P1dwStLGAvxa6BsgC6U5zbeC+M/Asj+cKS
        tq2qPhOk9w+ViJbH5UNPZewEyBeATrj9P8eTok1ZzyeGS3l3b3A==
X-Google-Smtp-Source: AA6agR49aTB0TQpKYtjVo1r1D/KMM5QfogFWlYGGA7+xAH/1isFRuh6p3hvm8PYHP1isMvTcYE+Hb7E=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:16c4:b0:535:890:d4a with SMTP id
 l4-20020a056a0016c400b0053508900d4amr27052541pfc.0.1661293558806; Tue, 23 Aug
 2022 15:25:58 -0700 (PDT)
Date:   Tue, 23 Aug 2022 15:25:51 -0700
In-Reply-To: <20220823222555.523590-1-sdf@google.com>
Message-Id: <20220823222555.523590-2-sdf@google.com>
Mime-Version: 1.0
References: <20220823222555.523590-1-sdf@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf-next v5 1/5] bpf: Introduce cgroup_{common,current}_func_proto
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
 kernel/bpf/cgroup.c        | 117 +++++++++++++++++++++++++++++++------
 kernel/bpf/helpers.c       |  34 -----------
 3 files changed, 115 insertions(+), 53 deletions(-)

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
index 59b7eb60d5b4..189380ec452f 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1527,6 +1527,37 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
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
@@ -1558,32 +1589,26 @@ const struct bpf_func_proto bpf_set_retval_proto = {
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
@@ -2096,6 +2121,16 @@ static const struct bpf_func_proto bpf_sysctl_set_new_value_proto = {
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
@@ -2111,8 +2146,10 @@ sysctl_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
 
@@ -2233,6 +2270,16 @@ static const struct bpf_func_proto bpf_get_netns_cookie_sockopt_proto = {
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
@@ -2254,8 +2301,10 @@ cg_sockopt_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
 
@@ -2420,3 +2469,33 @@ const struct bpf_verifier_ops cg_sockopt_verifier_ops = {
 
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
index 3c1b9bbcf971..6439a877c18b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -428,40 +428,6 @@ const struct bpf_func_proto bpf_get_current_ancestor_cgroup_id_proto = {
 	.arg1_type	= ARG_ANYTHING,
 };
 
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
-- 
2.37.1.595.g718a3a8f04-goog

