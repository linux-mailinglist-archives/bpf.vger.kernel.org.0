Return-Path: <bpf+bounces-9723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F12B479C783
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 09:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB6528180F
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 07:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D103A171D0;
	Tue, 12 Sep 2023 07:02:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914898F44
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 07:02:07 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBECE78
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 00:02:06 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68fba57030fso1746987b3a.3
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 00:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694502126; x=1695106926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNQpGQe4u79p1mkZVJD58U2KIJEFL4MZuGQeXTwOQ8w=;
        b=Dow5IJyKwkOy28TWDR9DDnjAogp9ctHCGYgTIiopVm61CJBX4KtSrMGSU1tt3U8dZX
         t8jMpD60rg5/hDwiqUJeq9z4WKLQwBXfV7ALggUQeh7PqPCrti/rKseXZU4/2/ivg1/M
         t5mdw24PCiXIwotA7LSzjM5CpbpQpODL/Dn/30HR64J/9e4rJhIpvl9l4hPrgOJbqsfJ
         RkROP7y53WJoqvfKDUMZYjz0QnDf7EWX/eM2mjGuGXMgnfMuOkyDw0Xe/nQTbeKaVznR
         bLX1GuNfRU/ADul/SXbTD7ZuEl25jbAoJdvDAO7ZRl2/CLRyqKPi+dt4vKy/NLOY/Y8K
         a6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694502126; x=1695106926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNQpGQe4u79p1mkZVJD58U2KIJEFL4MZuGQeXTwOQ8w=;
        b=MdJ8P76xkvOQQ6CECkhsihNtgz2m1XIW7DlktwkCEWLDIAEM9GS3yhWZ176iXxuqDP
         vHDhFP7I7I5xsLsNxgFEwKixJeMKQT3eKMY6vAiIx/eRPblTyNzDo4SrUSLsmabrMknu
         HQZitGP0uX/cQoS0KNOCAETaRgJDF2ZaLHS/gv5afU4mpUeFq9wDr7WaJIvisTSwXjAZ
         br6I0aL/+Wk5M9m7zyJBYbbPT3Q3fGYhk1K/UUW2zsX53OnpfxpQUyBDq49OlyTh5dqZ
         oQAQWg4/D8Dw1ASgla1pOP8V8QuZoxQ0JUetZ7xPb98S0ZjgzWV0MifOtzSQMuII6NHl
         TJFw==
X-Gm-Message-State: AOJu0YyjJ2YVDHzAFpHizjJWn1dxBrxUlu2bhrPHQM8k5eLd4GbLPKOt
	HrWV68Trp/wylbkrmnxOh6Nc0LrIKMxdOFRElx4CnQ==
X-Google-Smtp-Source: AGHT+IFrGkPdm7n165iwKopet18YYKmVo1jjoqtm9QF2jj2jLPZw8NkCsAYe/iI/yLg8hGzAh6dENw==
X-Received: by 2002:a05:6a20:ce9f:b0:153:c9fa:4ed6 with SMTP id if31-20020a056a20ce9f00b00153c9fa4ed6mr8870801pzb.10.1694502126142;
        Tue, 12 Sep 2023 00:02:06 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.84.173])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902d50800b001b8953365aesm7635401plg.22.2023.09.12.00.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 00:02:05 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	tj@kernel.org,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v2 2/6] bpf: Introduce css_task open-coded iterator kfuncs
Date: Tue, 12 Sep 2023 15:01:45 +0800
Message-Id: <20230912070149.969939-3-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230912070149.969939-1-zhouchuyi@bytedance.com>
References: <20230912070149.969939-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 include/uapi/linux/bpf.h       |  4 +++
 kernel/bpf/helpers.c           |  3 +++
 kernel/bpf/task_iter.c         | 48 ++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c          | 23 ++++++++++++++++
 tools/include/uapi/linux/bpf.h |  4 +++
 tools/lib/bpf/bpf_helpers.h    |  7 +++++
 6 files changed, 89 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 73b155e52204..de02c0971428 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7318,4 +7318,8 @@ struct bpf_iter_num {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+struct bpf_iter_css_task {
+	__u64 __opaque[1];
+} __attribute__((aligned(8)));
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b0a9834f1051..d6a16becfbb9 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2504,6 +2504,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_num_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_num_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
+BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW)
+BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_dynptr_adjust)
 BTF_ID_FLAGS(func, bpf_dynptr_is_null)
 BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 7473068ed313..d8539cc05ffd 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -803,6 +803,54 @@ const struct bpf_func_proto bpf_find_vma_proto = {
 	.arg5_type	= ARG_ANYTHING,
 };
 
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
+
+	switch (flags) {
+	case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
+	case CSS_TASK_ITER_PROCS:
+	case 0:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	kit->css_it = kzalloc(sizeof(struct css_task_iter), GFP_KERNEL);
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
+	kfree(kit->css_it);
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
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 73b155e52204..de02c0971428 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7318,4 +7318,8 @@ struct bpf_iter_num {
 	__u64 __opaque[1];
 } __attribute__((aligned(8)));
 
+struct bpf_iter_css_task {
+	__u64 __opaque[1];
+} __attribute__((aligned(8)));
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 77ceea575dc7..f48723c6c593 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -303,6 +303,13 @@ extern int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end) __weak
 extern int *bpf_iter_num_next(struct bpf_iter_num *it) __weak __ksym;
 extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __weak __ksym;
 
+struct bpf_iter_css_task;
+struct cgroup_subsys_state;
+extern int bpf_iter_css_task_new(struct bpf_iter_css_task *it,
+		struct cgroup_subsys_state *css, unsigned int flags) __weak __ksym;
+extern struct task_struct *bpf_iter_css_task_next(struct bpf_iter_css_task *it) __weak __ksym;
+extern void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it) __weak __ksym;
+
 #ifndef bpf_for_each
 /* bpf_for_each(iter_type, cur_elem, args...) provides generic construct for
  * using BPF open-coded iterators without having to write mundane explicit
-- 
2.20.1


