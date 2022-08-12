Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E295F5915BE
	for <lists+bpf@lfdr.de>; Fri, 12 Aug 2022 21:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbiHLTCs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Aug 2022 15:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbiHLTCq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Aug 2022 15:02:46 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6E6E6C
        for <bpf@vger.kernel.org>; Fri, 12 Aug 2022 12:02:45 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id h12-20020a170902f54c00b0016f8858ce9bso910014plf.9
        for <bpf@vger.kernel.org>; Fri, 12 Aug 2022 12:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=+65bsMqtc2bMgViG5JzUSpbVgns8flTgXlCZcP2zOYE=;
        b=BgQAkh6QbLVmrGxls+PeFC03ccbwWjsii9sQM6Z46Fp81yhzKqwJSTppcGUhP0rP0m
         AvjaeKudiaXV8CP+4WXT1rMeojU/yw+R5CyXGB1kKm3Q0ZRzlZ/8HamysltfzbsFWiKu
         8URokGrepcgdKJnvceZXhIh72JE8Sr/ga8E8cX6UtTHBSXJAm1PNIuylJDButcyJxhSb
         k90b49oQ/MqsIa2tEDsXOvTqfAl96R892swEnGe8KySIqKnoODrq6d1ZeQH8bGTS7rAd
         s7wkwQ8KUjuJ0cVTuTcxTxYAfLp3+6dZFhneDoFVMK6P9D2x3tOLYdzK/d/LHzjZVV/+
         X1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=+65bsMqtc2bMgViG5JzUSpbVgns8flTgXlCZcP2zOYE=;
        b=LUZz6LWuipXpKcMn2G8/iRGW2qKsEHGVJR0UOvafenTE05+L7b6o1q6XkDkLzF66Ay
         Nhs+r8Mb64PC9/BuEuTXv+lx14ukTSIZNh45qs3eYp9SEF6bNfVUWMzhnaZy4wiKHCaF
         N4jKKNgh5GbT6yOUfcdOWnjUZ3/BwLYpwZ0ISXx4BqDgreEShXXuynj6sptmHe+r8+z1
         2oYCd5rk8zXveQp7wqfRL5+QCrYU67VANYaI32oWJf1IZRKe6w6MJQ3dQCVbaNBlCP2p
         wz9g5MBnGKgMR3NJJ+RjGTzeLrP2fBjeRXd/dD/TkC4O00lDZjwEFrD0l3vHj3l7zekJ
         D+xQ==
X-Gm-Message-State: ACgBeo3AqOqvW6Dp5hEEH/cLV+zUln8NQa3UxMOIrd1rF4A31BsUBd1P
        ugwapxFwBWCOiwMkg3QwQuuoO8b90SRR2LP7XTwwspYf+1QYxGP25sP8umQrAZS56UgQfL7MAGu
        GRdE57TYj3N5NRdp+nmx4OiBXwG/mV3kOFjDr7YrKhhAPKjBGng==
X-Google-Smtp-Source: AA6agR5sY//vHFFRDjqgxUDI+meqvLxMUQ86ASAK8HhJ92J75VmysDPMMpl55qwRsNvHVLzKrkLxaTU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:f711:b0:170:9e3c:1540 with SMTP id
 h17-20020a170902f71100b001709e3c1540mr5160741plo.22.1660330964733; Fri, 12
 Aug 2022 12:02:44 -0700 (PDT)
Date:   Fri, 12 Aug 2022 12:02:39 -0700
In-Reply-To: <20220812190241.3544528-1-sdf@google.com>
Message-Id: <20220812190241.3544528-2-sdf@google.com>
Mime-Version: 1.0
References: <20220812190241.3544528-1-sdf@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf-next 1/3] bpf: introduce cgroup_{common,current}_func_proto
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

Move bpf_{g,s}et_retval into kernel/bpf/helpers.c so they are more
usable from the core parts.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf.h  | 16 +++++++++
 kernel/bpf/cgroup.c  | 82 +++++++++++++++++++-------------------------
 kernel/bpf/helpers.c | 67 ++++++++++++++++++++++++++++++++++--
 3 files changed, 116 insertions(+), 49 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a627a02cf8ab..cdb295c6c728 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1948,6 +1948,10 @@ struct bpf_prog *bpf_prog_by_id(u32 id);
 struct bpf_link *bpf_link_by_id(u32 id);
 
 const struct bpf_func_proto *bpf_base_func_proto(enum bpf_func_id func_id);
+const struct bpf_func_proto *
+cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog);
+const struct bpf_func_proto *
+cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog);
 void bpf_task_storage_free(struct task_struct *task);
 bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
 const struct btf_func_model *
@@ -2154,6 +2158,18 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 	return NULL;
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
 static inline void bpf_task_storage_free(struct task_struct *task)
 {
 }
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 59b7eb60d5b4..cc0b33b7d4cc 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1527,63 +1527,27 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 	return ret;
 }
 
-BPF_CALL_0(bpf_get_retval)
-{
-	struct bpf_cg_run_ctx *ctx =
-		container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
-
-	return ctx->retval;
-}
-
-const struct bpf_func_proto bpf_get_retval_proto = {
-	.func		= bpf_get_retval,
-	.gpl_only	= false,
-	.ret_type	= RET_INTEGER,
-};
-
-BPF_CALL_1(bpf_set_retval, int, retval)
+static const struct bpf_func_proto *
+cgroup_dev_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
-	struct bpf_cg_run_ctx *ctx =
-		container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
+	const struct bpf_func_proto *func_proto;
 
-	ctx->retval = retval;
-	return 0;
-}
+	func_proto = cgroup_common_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
 
-const struct bpf_func_proto bpf_set_retval_proto = {
-	.func		= bpf_set_retval,
-	.gpl_only	= false,
-	.ret_type	= RET_INTEGER,
-	.arg1_type	= ARG_ANYTHING,
-};
+	func_proto = cgroup_current_func_proto(func_id, prog);
+	if (func_proto)
+		return func_proto;
 
-static const struct bpf_func_proto *
-cgroup_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
-{
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
@@ -2096,6 +2060,16 @@ static const struct bpf_func_proto bpf_sysctl_set_new_value_proto = {
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
@@ -2111,8 +2085,10 @@ sysctl_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
 
@@ -2233,6 +2209,16 @@ static const struct bpf_func_proto bpf_get_netns_cookie_sockopt_proto = {
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
@@ -2254,8 +2240,10 @@ cg_sockopt_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 3c1b9bbcf971..de7d2fabb06d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -429,7 +429,6 @@ const struct bpf_func_proto bpf_get_current_ancestor_cgroup_id_proto = {
 };
 
 #ifdef CONFIG_CGROUP_BPF
-
 BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
 {
 	/* flags argument is not used now,
@@ -460,7 +459,37 @@ const struct bpf_func_proto bpf_get_local_storage_proto = {
 	.arg1_type	= ARG_CONST_MAP_PTR,
 	.arg2_type	= ARG_ANYTHING,
 };
-#endif
+
+BPF_CALL_0(bpf_get_retval)
+{
+	struct bpf_cg_run_ctx *ctx =
+		container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
+
+	return ctx->retval;
+}
+
+const struct bpf_func_proto bpf_get_retval_proto = {
+	.func		= bpf_get_retval,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+};
+
+BPF_CALL_1(bpf_set_retval, int, retval)
+{
+	struct bpf_cg_run_ctx *ctx =
+		container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
+
+	ctx->retval = retval;
+	return 0;
+}
+
+const struct bpf_func_proto bpf_set_retval_proto = {
+	.func		= bpf_set_retval,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_ANYTHING,
+};
+#endif /* CONFIG_CGROUP_BPF */
 
 #define BPF_STRTOX_BASE_MASK 0x1F
 
@@ -1726,6 +1755,40 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 	}
 }
 
+/* Common helpers for cgroup hooks. */
+const struct bpf_func_proto *
+cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	switch (func_id) {
+#ifdef CONFIG_CGROUP_BPF
+	case BPF_FUNC_get_local_storage:
+		return &bpf_get_local_storage_proto;
+	case BPF_FUNC_get_retval:
+		return &bpf_get_retval_proto;
+	case BPF_FUNC_set_retval:
+		return &bpf_set_retval_proto;
+#endif
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
+#ifdef CONFIG_CGROUPS
+	case BPF_FUNC_get_current_uid_gid:
+		return &bpf_get_current_uid_gid_proto;
+	case BPF_FUNC_get_current_cgroup_id:
+		return &bpf_get_current_cgroup_id_proto;
+#endif
+	default:
+		return NULL;
+	}
+}
+
 BTF_SET8_START(tracing_btf_ids)
 #ifdef CONFIG_KEXEC_CORE
 BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
-- 
2.37.1.595.g718a3a8f04-goog

