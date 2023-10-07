Return-Path: <bpf+bounces-11607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A297BC7C1
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 14:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC8628090A
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 12:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBAB1F5FF;
	Sat,  7 Oct 2023 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jv5bS7L1"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BFD171B7
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 12:45:42 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392A6BC
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 05:45:39 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c77449a6daso26160775ad.0
        for <bpf@vger.kernel.org>; Sat, 07 Oct 2023 05:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696682738; x=1697287538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pqt9rxBYFVk6LPMpguDAaCxjiKD3M4+wIrVG+QA1dBo=;
        b=jv5bS7L1xhj0ecPKl2hSCuhblCMAzhJYN1Ldst2QL4iuzTpYhvgtYA67IKayt2IF5B
         M0L+t/NmHNZOaxHhqmbZe7VccWS96qG/H69AHBbZMPU7UIIxNm8Jwn0+QMMI5qccwky5
         4hkM9RT/qtoDWeBjEdefjvv4uL4doqrYTxJhoNRKjvUZSHlQivsARigQ2ig0xEr6B48N
         RFEItJDiCZavUnBqlHsa8qCMFMJyXUD0pkky0vUK7OTmlmVk6rx/WMG81vHCRoF+dGj+
         /Qdb2Jgt3a+eDONoofwkGXfICs5H2G9MOjh1o24G3LDfBHmMoZk71RqSwnzaiuCwBRG9
         m6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696682738; x=1697287538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pqt9rxBYFVk6LPMpguDAaCxjiKD3M4+wIrVG+QA1dBo=;
        b=Iw3FIhNG5aIbmUSgWr68TS6QegEQfuz9aAIvQbaYvkSooyrMklniStbyUXa809Hdet
         k2ytbuSL35myGFZeob+5Glc5NOnN308ZzHxCKf5F6D1RCU2Igd+wmKQxWsuRPCNxfZWF
         tR6P6r6hzmA+eswLOFzkaAuYTVQYJ3WKpBETpQtjka4vWgU7njuMM5Az0PCmpBCiUzQ/
         0Rex4K9m9tpEh4ZUzev7CQBXJx7asIfDjiU3iHqKhQAK1aF86BPyELbtmmyPDzYamOMG
         RWMHkq2hnFn1Kw59n01wxjBFxddUc5jnY+4TOH0z5BblgsAdC9X3kMzConBNnRMyNwoT
         a7Mw==
X-Gm-Message-State: AOJu0YwrOHwybigB46gT2FfeI8gcdIRRbZnDf4Zfy2Ad4LVYvJkJCRbG
	MdiemzgenySHMn01fjyYLC/DZUYaigfv8bb9zqA=
X-Google-Smtp-Source: AGHT+IGDQQmMNuBwndP/Ck8RDANAu8Yl1MuQMi2aOih/IehWZnrNoXdzRmGKwKKPCBPASZvXzvynow==
X-Received: by 2002:a17:90b:701:b0:26b:280b:d24c with SMTP id s1-20020a17090b070100b0026b280bd24cmr10072775pjz.42.1696682738440;
        Sat, 07 Oct 2023 05:45:38 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id d6-20020a17090ad3c600b00256799877ffsm5095388pjw.47.2023.10.07.05.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 05:45:38 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	tj@kernel.org,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v4 2/8] bpf: Introduce css_task open-coded iterator kfuncs
Date: Sat,  7 Oct 2023 20:45:16 +0800
Message-Id: <20231007124522.34834-3-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231007124522.34834-1-zhouchuyi@bytedance.com>
References: <20231007124522.34834-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds kfuncs bpf_iter_css_task_{new,next,destroy} which allow
creation and manipulation of struct bpf_iter_css_task in open-coded
iterator style. These kfuncs actually wrapps css_task_iter_{start,next,
end}. BPF programs can use these kfuncs through bpf_for_each macro for
iteration of all tasks under a css.

css_task_iter_*() would try to get the global spin-lock *css_set_lock*, so
the bpf side has to be careful in where it allows to use this iter.
Currently we only allow it in bpf_lsm and bpf iter-s.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 kernel/bpf/helpers.c                          |  3 ++
 kernel/bpf/task_iter.c                        | 53 +++++++++++++++++++
 kernel/bpf/verifier.c                         | 23 ++++++++
 .../testing/selftests/bpf/bpf_experimental.h  |  8 +++
 4 files changed, 87 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index dd1c69ee3375..8699cabb52b2 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2549,6 +2549,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_dynptr_adjust)
 BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 7473068ed313..2cfcb4dd8a37 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -7,6 +7,7 @@
 #include <linux/fs.h>
 #include <linux/fdtable.h>
 #include <linux/filter.h>
+#include <linux/bpf_mem_alloc.h>
 #include <linux/btf_ids.h>
 #include "mmap_unlock_work.h"
 
@@ -803,6 +804,58 @@ const struct bpf_func_proto bpf_find_vma_proto = {
 	.arg5_type	= ARG_ANYTHING,
 };
 
+struct bpf_iter_css_task {
+	__u64 __opaque[1];
+} __attribute__((aligned(8)));
+
+struct bpf_iter_css_task_kern {
+	struct css_task_iter *css_it;
+} __attribute__((aligned(8)));
+
+__bpf_kfunc int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
+		struct cgroup_subsys_state *css, unsigned int flags)
+{
+	struct bpf_iter_css_task_kern *kit = (void *)it;
+
+	BUILD_BUG_ON(sizeof(struct bpf_iter_css_task_kern) != sizeof(struct bpf_iter_css_task));
+	BUILD_BUG_ON(__alignof__(struct bpf_iter_css_task_kern) !=
+					__alignof__(struct bpf_iter_css_task));
+	kit->css_it = NULL;
+	switch (flags) {
+	case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
+	case CSS_TASK_ITER_PROCS:
+	case 0:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	kit->css_it = bpf_mem_alloc(&bpf_global_ma, sizeof(struct css_task_iter));
+	if (!kit->css_it)
+		return -ENOMEM;
+	css_task_iter_start(css, flags, kit->css_it);
+	return 0;
+}
+
+__bpf_kfunc struct task_struct *bpf_iter_css_task_next(struct bpf_iter_css_task *it)
+{
+	struct bpf_iter_css_task_kern *kit = (void *)it;
+
+	if (!kit->css_it)
+		return NULL;
+	return css_task_iter_next(kit->css_it);
+}
+
+__bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
+{
+	struct bpf_iter_css_task_kern *kit = (void *)it;
+
+	if (!kit->css_it)
+		return;
+	css_task_iter_end(kit->css_it);
+	bpf_mem_free(&bpf_global_ma, kit->css_it);
+}
+
 DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
 
 static void do_mmap_read_unlock(struct irq_work *entry)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eed7350e15f4..528d375c17ee 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10450,6 +10450,7 @@ enum special_kfunc_type {
 	KF_bpf_percpu_obj_new_impl,
 	KF_bpf_percpu_obj_drop_impl,
 	KF_bpf_throw,
+	KF_bpf_iter_css_task_new,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -10473,6 +10474,7 @@ BTF_ID(func, bpf_dynptr_clone)
 BTF_ID(func, bpf_percpu_obj_new_impl)
 BTF_ID(func, bpf_percpu_obj_drop_impl)
 BTF_ID(func, bpf_throw)
+BTF_ID(func, bpf_iter_css_task_new)
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
@@ -10498,6 +10500,7 @@ BTF_ID(func, bpf_dynptr_clone)
 BTF_ID(func, bpf_percpu_obj_new_impl)
 BTF_ID(func, bpf_percpu_obj_drop_impl)
 BTF_ID(func, bpf_throw)
+BTF_ID(func, bpf_iter_css_task_new)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -11028,6 +11031,20 @@ static int process_kf_arg_ptr_to_rbtree_node(struct bpf_verifier_env *env,
 						  &meta->arg_rbtree_root.field);
 }
 
+static bool check_css_task_iter_allowlist(struct bpf_verifier_env *env)
+{
+	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
+
+	switch (prog_type) {
+	case BPF_PROG_TYPE_LSM:
+		return true;
+	case BPF_TRACE_ITER:
+		return env->prog->aux->sleepable;
+	default:
+		return false;
+	}
+}
+
 static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta,
 			    int insn_idx)
 {
@@ -11278,6 +11295,12 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			break;
 		}
 		case KF_ARG_PTR_TO_ITER:
+			if (meta->func_id == special_kfunc_list[KF_bpf_iter_css_task_new]) {
+				if (!check_css_task_iter_allowlist(env)) {
+					verbose(env, "css_task_iter is only allowed in bpf_lsm and bpf iter-s\n");
+					return -EINVAL;
+				}
+			}
 			ret = process_iter_arg(env, regno, insn_idx, meta);
 			if (ret < 0)
 				return ret;
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 9aa29564bd74..8b53537e0f27 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -450,4 +450,12 @@ extern void bpf_throw(u64 cookie) __ksym;
 		__bpf_assert_op(LHS, <=, END, value, false);		\
 	})
 
+struct bpf_iter_css_task;
+struct cgroup_subsys_state;
+extern int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
+		struct cgroup_subsys_state *css, unsigned int flags) __weak __ksym;
+extern struct task_struct *bpf_iter_css_task_next(struct bpf_iter_css_task *it) __weak __ksym;
+extern void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it) __weak __ksym;
+
+
 #endif
-- 
2.20.1


