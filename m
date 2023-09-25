Return-Path: <bpf+bounces-10745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25957AD676
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 12:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 82B6B2815B7
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 10:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A996C15EB9;
	Mon, 25 Sep 2023 10:56:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B3A15EA0
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 10:56:08 +0000 (UTC)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B547D3
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 03:56:06 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-2769920fa24so4618578a91.1
        for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 03:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695639365; x=1696244165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQlSq1TwvEGm1QiqG8EIEkE42Pc+GwwgcNtMrnq+QE0=;
        b=jgi/LDz3p6lAihiRW0ABIPhW3QJgNP1jwUq0X9OFwnroxZ3iOW/mJ630m4ECtasIZd
         oeBJgYpE468yQWL/VPfvPZNBOHyQ9uU3L4W9jdj0lpiJS0lDBXEwFtnIDPBLcsGcO4j4
         DdItoiBjErd3ulD0y2guSYmaDCETXAVTVbUFkPSPThR8knq2S63tjn/TNiN/hbnZo5Fo
         aUsflRBJ4zbZ1hDrQ5eyVwcdSxGXEKAuH3wVvk4Jr2ZfKoeA3o6Rtpy01Fzyb+ZLeXqw
         f/dwPXgG0KYNbF/djX7c24yXUhZQqjt1Xaf/k0mWek+dQ+OucCj5WdKdWSYMKQEJ+nrJ
         w/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695639365; x=1696244165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQlSq1TwvEGm1QiqG8EIEkE42Pc+GwwgcNtMrnq+QE0=;
        b=NHMlz1SutG8HtqswIWv81JvhyXhqJdzEoF7cVg+mWp0Qp/FZDsslkzz6N6yM1BviUB
         KmVMw2urW1Q7ENMA0XvSyH2fpP25UDTNTCIl6BrOxIqTIOFQ//8FznjoLJxNhJIIbYQD
         S6s2k9H/r/KizKE8hYwVRbSxHF8V4qshY9wsPQ4YPGIClLp5iiB4CUyr4ME45uFz82aq
         XVvk/zD174EWtWCGUclWb1v+oOwM/94Wb0calNwPngURGzmZfqE89/HFRQfsiyy93exj
         kS/JPhQyrXxAXAGwZ51IXPP84673YjCvhXd1mkVfnYVZtyVTRGEDqy4T+qQ+qQC0A0xH
         cd5w==
X-Gm-Message-State: AOJu0YxCDbImmLklrndEYzXOtTQcBO2vraMFJmSLvWXx16dIr+Z+qv75
	fIq5Jwc0FbI7Q1tuge5plJ4C3V4HZJVQ4UtRmIo=
X-Google-Smtp-Source: AGHT+IHwKKSEXG0fZrqr8+yfqSqQMCoJNn47XcfxKsV4WTqzSBIXul9upxZLV8l1yOFtOSt+1QixDw==
X-Received: by 2002:a17:90a:a095:b0:26b:e27:8bc2 with SMTP id r21-20020a17090aa09500b0026b0e278bc2mr5663466pjp.45.1695639365579;
        Mon, 25 Sep 2023 03:56:05 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090a16c900b002772faee740sm2297842pje.5.2023.09.25.03.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 03:56:05 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	tj@kernel.org,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v3 2/7] bpf: Introduce css_task open-coded iterator kfuncs
Date: Mon, 25 Sep 2023 18:55:47 +0800
Message-Id: <20230925105552.817513-3-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230925105552.817513-1-zhouchuyi@bytedance.com>
References: <20230925105552.817513-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
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
---
 kernel/bpf/helpers.c                          |  3 ++
 kernel/bpf/task_iter.c                        | 53 +++++++++++++++++++
 kernel/bpf/verifier.c                         | 23 ++++++++
 .../testing/selftests/bpf/bpf_experimental.h  |  7 +++
 4 files changed, 86 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b0a9834f1051..189d158c9b7f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2504,6 +2504,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NULL)
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
index dbba2b806017..2367483bf4c2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10332,6 +10332,7 @@ enum special_kfunc_type {
 	KF_bpf_dynptr_clone,
 	KF_bpf_percpu_obj_new_impl,
 	KF_bpf_percpu_obj_drop_impl,
+	KF_bpf_iter_css_task_new,
 };
 
 BTF_SET_START(special_kfunc_set)
@@ -10354,6 +10355,7 @@ BTF_ID(func, bpf_dynptr_slice_rdwr)
 BTF_ID(func, bpf_dynptr_clone)
 BTF_ID(func, bpf_percpu_obj_new_impl)
 BTF_ID(func, bpf_percpu_obj_drop_impl)
+BTF_ID(func, bpf_iter_css_task_new)
 BTF_SET_END(special_kfunc_set)
 
 BTF_ID_LIST(special_kfunc_list)
@@ -10378,6 +10380,7 @@ BTF_ID(func, bpf_dynptr_slice_rdwr)
 BTF_ID(func, bpf_dynptr_clone)
 BTF_ID(func, bpf_percpu_obj_new_impl)
 BTF_ID(func, bpf_percpu_obj_drop_impl)
+BTF_ID(func, bpf_iter_css_task_new)
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -10902,6 +10905,20 @@ static int process_kf_arg_ptr_to_rbtree_node(struct bpf_verifier_env *env,
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
@@ -11152,6 +11169,12 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
index 4494eaa9937e..d3ea90f0e142 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -162,4 +162,11 @@ extern void bpf_percpu_obj_drop_impl(void *kptr, void *meta) __ksym;
 /* Convenience macro to wrap over bpf_obj_drop_impl */
 #define bpf_percpu_obj_drop(kptr) bpf_percpu_obj_drop_impl(kptr, NULL)
 
+struct bpf_iter_css_task;
+struct cgroup_subsys_state;
+extern int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
+		struct cgroup_subsys_state *css, unsigned int flags) __weak __ksym;
+extern struct task_struct *bpf_iter_css_task_next(struct bpf_iter_css_task *it) __weak __ksym;
+extern void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it) __weak __ksym;
+
 #endif
-- 
2.20.1


