Return-Path: <bpf+bounces-11907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D28AB7C5309
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 14:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7D51C20EC5
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 12:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2401F167;
	Wed, 11 Oct 2023 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lDgLyfF8"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DCF1EA98
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 12:09:30 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DD9F0
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 05:09:22 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690f7bf73ddso4826491b3a.2
        for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 05:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697026161; x=1697630961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7iVnDvjE1E7HEpdBixICufOsht21DeND3qHD2AP2FY=;
        b=lDgLyfF8h2WKiMS/wqp25b4uqWaSOiTI7J03qOEzdt5h7wk46AGDGPASNHI3c0auXh
         2xT8QLqUtmGM3KhvtHUJ/lLtFZyVKtYu8AfYnRckn5D4AquyEHIKCgH5Pwqz3zjLr/Oo
         BcqQgFqykZ4eQg8DEIpiKQA6WbmnOF/NnIafdboHFxlndZZOsAkoqw2e/9h7HRa/6yk3
         too9s644/G3dTOe7S3oFs/sz/FAKk1+coT4bp6ZTIXoeqeLeN9B5mfMybjMbI9EVJBdU
         RLG3yX/8eMWnBXIq+TAA6+O87ysMtpQEgeB4GATjPGwUoOMdCJYSEeA3ySe/Kw7Dj42+
         VCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026161; x=1697630961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7iVnDvjE1E7HEpdBixICufOsht21DeND3qHD2AP2FY=;
        b=HZFghcs7/cVwjdKL2nDFRPhUMkTX0UzwfNH/FMQvuoMH/L9kEDhdoVFj24VAQaSniV
         sh9IjHoRdaqP1CCYiulmM/znTDHXQ/v23hUBwUFCHxF2cs8vaUGzu8ZyB4MYib6mOUVo
         U1JsbUvpCg5E9ulqcdEuWYwOSj7CgZki5oVG4jgg7vm9Bet9nMIX54H3igBiUM8mAo4U
         erJwhiJn6SzQntw7vK1FD2/sN7v3ZBLnc7HUFtdKrGvodGmJNVM9hKxdlVD1FAc3DogQ
         pNUYNWRBGThowkmBGoWTmTQcrBgwJun8Ojr56Ii6rQDc18Nr+gXo+3/C+FF11MF2oGfq
         rmeQ==
X-Gm-Message-State: AOJu0YzNiMy74jzBQ/ZgbhZhMXbvkKBMcdGMMVWTgIIt0pqjAwQiVu30
	s4ccxlxvxJ2azER/K+i2XSXlkHbJXYktdMHFSlc=
X-Google-Smtp-Source: AGHT+IG7PZQ6gwsJmqGR0WMAg5niA2oSWFbG2CL17cM35uAvL0TZlUsjDzKZaIG6SRvzXiQ53B3ufA==
X-Received: by 2002:a05:6a00:1825:b0:690:f6a1:ae62 with SMTP id y37-20020a056a00182500b00690f6a1ae62mr22054883pfa.23.1697026161464;
        Wed, 11 Oct 2023 05:09:21 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.142])
        by smtp.gmail.com with ESMTPSA id u13-20020a62ed0d000000b006930db1e6cfsm9962769pfh.62.2023.10.11.05.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:21 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	tj@kernel.org,
	linux-kernel@vger.kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v5 2/8] bpf: Introduce css_task open-coded iterator kfuncs
Date: Wed, 11 Oct 2023 20:08:51 +0800
Message-Id: <20231011120857.251943-3-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231011120857.251943-1-zhouchuyi@bytedance.com>
References: <20231011120857.251943-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
index d2840dd5b00d..cb24c4a916df 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2552,6 +2552,9 @@ BTF_ID_FLAGS(func, bpf_dynptr_slice_rdwr, KF_RET_NULL)
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


