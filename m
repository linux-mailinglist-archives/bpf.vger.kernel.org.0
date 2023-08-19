Return-Path: <bpf+bounces-8113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B317816EB
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 05:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55398281E73
	for <lists+bpf@lfdr.de>; Sat, 19 Aug 2023 03:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170B31103;
	Sat, 19 Aug 2023 03:01:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D5EED6
	for <bpf@vger.kernel.org>; Sat, 19 Aug 2023 03:01:50 +0000 (UTC)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31003C35
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 20:01:48 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso1549681276.2
        for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 20:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692414107; x=1693018907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qve2NxnhLDEtjalANSJ7K16OLZRGc8igwFnCjylq0ck=;
        b=M77ImFcX91lMnuw7r5evrezyP69NwSTIhEjAeCZVlazEWIU7cU1MgYiscx185Q3E0t
         0DQKytB+Hb09czZYpFlIj6bMe7WZQcGir2jmGbRA0xcfUCm7TTIDg0k7trqqha2Pw3gh
         SgPSvQJNiRq+JBiJ+DzWQ2IKb5SrMkpWm/duMlFDzrgaM/0gTE+BrzIAbxBW4RBWnlaY
         TOe9T6/JtkDysYfr4cwffmAJoJzMn5DvLg4qsry7R4ND/+Gj6X3dkQn2ZyOfHR7DcCFK
         yzE+an8A72e+Skenw7IQXGXsPYlDhruggIucB9ZjpzNzCBS+cjhCOVK6OhItABOP9CMJ
         QwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692414107; x=1693018907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qve2NxnhLDEtjalANSJ7K16OLZRGc8igwFnCjylq0ck=;
        b=EI3p7SG75MSMoXi8lodjY7qJ4MB+gBbtNNUhytf2zHxfNYko4hk3oNCkZLpPFMGMm2
         L+ahPClRabB1MNaMJPBJmh6pp+imTH2rEg4/bpZSMnbJAT/HBd7mRPBHitvKgaIFxA0u
         3bRLn8nuUqMRl8lVx+V5vc5hOKNpCTXWU56BAEjH3LWeOKtupVrmzsW7qmVvsZ9IC7ZO
         lFUtMXtS1pud30dwJMdJ8WN5OebA8nuCevjI+uBwfYK6qWpKg86mIdDzeBScTFGxnGA1
         9X9qO7uOt0nnzRg2Uh8mI+AWHq6J1j/uoKkioknAOzq0heT483rqnbTw/wtBlVqQda7p
         PYmw==
X-Gm-Message-State: AOJu0YxaOsvCY+an7K5vAXjfU0Gx+cOIeaJxPgAZvJ/XEAbuByvhSGbk
	i978/yMem0TkHRMws4zStjMJiXkJw/KDFg==
X-Google-Smtp-Source: AGHT+IHICE8Cas9mgu0KXUgOHjK0htJ6gHlH53uxR4Ot/tdHnvOkO0FhogITh8b2O3oIE7c3FryQvw==
X-Received: by 2002:a0d:ce01:0:b0:586:9fb3:33cc with SMTP id q1-20020a0dce01000000b005869fb333ccmr794061ywd.50.1692414107508;
        Fri, 18 Aug 2023 20:01:47 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a059:9262:e315:4c20])
        by smtp.gmail.com with ESMTPSA id o199-20020a0dccd0000000b005704c4d3579sm903897ywd.40.2023.08.18.20.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 20:01:47 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	sdf@google.com,
	yonghong.song@linux.dev
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v4 1/6] bpf: enable sleepable BPF programs attached to cgroup/{get,set}sockopt.
Date: Fri, 18 Aug 2023 20:01:38 -0700
Message-Id: <20230819030143.419729-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819030143.419729-1-thinker.li@gmail.com>
References: <20230819030143.419729-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

Enable sleepable cgroup/{get,set}sockopt hooks.

The sleepable BPF programs attached to cgroup/{get,set}sockopt hooks may
received a pointer to the optval in user space instead of a kernel
copy. ctx->optval and ctx->optval_end are the pointers to the
begin and end of the user space buffer if receiving a user space
buffer. No matter where the buffer is, sleepable programs can not
access the content from the pointers directly. They are supposed
to access the buffer through dynptr functions.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h    |   6 ++
 include/linux/filter.h |   6 ++
 kernel/bpf/cgroup.c    | 208 ++++++++++++++++++++++++++++++++---------
 kernel/bpf/verifier.c  |   5 +-
 4 files changed, 178 insertions(+), 47 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cfabbcf47bdb..edb35bcfa548 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1769,9 +1769,15 @@ struct bpf_prog_array_item {
 
 struct bpf_prog_array {
 	struct rcu_head rcu;
+	u32 flags;
 	struct bpf_prog_array_item items[];
 };
 
+enum bpf_prog_array_flags {
+	BPF_PROG_ARRAY_F_SLEEPABLE = 1 << 0,
+	BPF_PROG_ARRAY_F_NON_SLEEPABLE = 1 << 1,
+};
+
 struct bpf_empty_prog_array {
 	struct bpf_prog_array hdr;
 	struct bpf_prog *null_prog;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 761af6b3cf2b..2aa2a96526de 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1337,12 +1337,18 @@ struct bpf_sockopt_kern {
 	s32		level;
 	s32		optname;
 	s32		optlen;
+	u32		flags;
 	/* for retval in struct bpf_cg_run_ctx */
 	struct task_struct *current_task;
 	/* Temporary "register" for indirect stores to ppos. */
 	u64		tmp_reg;
 };
 
+enum bpf_sockopt_kern_flags {
+	/* optval is a pointer to user space memory */
+	BPF_SOCKOPT_FLAG_OPTVAL_USER    = (1U << 0),
+};
+
 int copy_bpf_fprog_from_user(struct sock_fprog *dst, sockptr_t src, int len);
 
 struct bpf_sk_lookup_kern {
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 5b2741aa0d9b..b4f37960274d 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -28,25 +28,47 @@ EXPORT_SYMBOL(cgroup_bpf_enabled_key);
  * function pointer.
  */
 static __always_inline int
-bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
-		      enum cgroup_bpf_attach_type atype,
-		      const void *ctx, bpf_prog_run_fn run_prog,
-		      int retval, u32 *ret_flags)
+bpf_prog_run_array_cg_cb(const struct cgroup_bpf *cgrp,
+			 enum cgroup_bpf_attach_type atype,
+			 const void *ctx, bpf_prog_run_fn run_prog,
+			 int retval, u32 *ret_flags,
+			 int (*progs_cb)(void *, const struct bpf_prog_array *),
+			 void *progs_cb_arg)
 {
 	const struct bpf_prog_array_item *item;
 	const struct bpf_prog *prog;
 	const struct bpf_prog_array *array;
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_cg_run_ctx run_ctx;
+	bool do_sleepable;
 	u32 func_ret;
+	int err;
+
+	do_sleepable =
+		atype == CGROUP_SETSOCKOPT || atype == CGROUP_GETSOCKOPT;
 
 	run_ctx.retval = retval;
 	migrate_disable();
-	rcu_read_lock();
+	if (do_sleepable) {
+		might_fault();
+		rcu_read_lock_trace();
+	} else {
+		rcu_read_lock();
+	}
 	array = rcu_dereference(cgrp->effective[atype]);
 	item = &array->items[0];
+
+	if (progs_cb) {
+		err = progs_cb(progs_cb_arg, array);
+		if (err)
+			return err;
+	}
+
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 	while ((prog = READ_ONCE(item->prog))) {
+		if (do_sleepable && !prog->aux->sleepable)
+			rcu_read_lock();
+
 		run_ctx.prog_item = item;
 		func_ret = run_prog(prog, ctx);
 		if (ret_flags) {
@@ -56,13 +78,29 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
 		if (!func_ret && !IS_ERR_VALUE((long)run_ctx.retval))
 			run_ctx.retval = -EPERM;
 		item++;
+
+		if (do_sleepable && !prog->aux->sleepable)
+			rcu_read_unlock();
 	}
 	bpf_reset_run_ctx(old_run_ctx);
-	rcu_read_unlock();
+	if (do_sleepable)
+		rcu_read_unlock_trace();
+	else
+		rcu_read_unlock();
 	migrate_enable();
 	return run_ctx.retval;
 }
 
+static __always_inline int
+bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
+		      enum cgroup_bpf_attach_type atype,
+		      const void *ctx, bpf_prog_run_fn run_prog,
+		      int retval, u32 *ret_flags)
+{
+	return bpf_prog_run_array_cg_cb(cgrp, atype, ctx, run_prog, retval,
+					ret_flags, NULL, NULL);
+}
+
 unsigned int __cgroup_bpf_run_lsm_sock(const void *ctx,
 				       const struct bpf_insn *insn)
 {
@@ -307,7 +345,7 @@ static void cgroup_bpf_release(struct work_struct *work)
 		old_array = rcu_dereference_protected(
 				cgrp->bpf.effective[atype],
 				lockdep_is_held(&cgroup_mutex));
-		bpf_prog_array_free(old_array);
+		bpf_prog_array_free_sleepable(old_array);
 	}
 
 	list_for_each_entry_safe(storage, stmp, storages, list_cg) {
@@ -402,6 +440,7 @@ static int compute_effective_progs(struct cgroup *cgrp,
 				   enum cgroup_bpf_attach_type atype,
 				   struct bpf_prog_array **array)
 {
+	bool has_non_sleepable = false, has_sleepable = false;
 	struct bpf_prog_array_item *item;
 	struct bpf_prog_array *progs;
 	struct bpf_prog_list *pl;
@@ -434,10 +473,19 @@ static int compute_effective_progs(struct cgroup *cgrp,
 			item->prog = prog_list_prog(pl);
 			bpf_cgroup_storages_assign(item->cgroup_storage,
 						   pl->storage);
+			if (item->prog->aux->sleepable)
+				has_sleepable = true;
+			else
+				has_non_sleepable = true;
 			cnt++;
 		}
 	} while ((p = cgroup_parent(p)));
 
+	if (has_non_sleepable)
+		progs->flags |= BPF_PROG_ARRAY_F_NON_SLEEPABLE;
+	if (has_sleepable)
+		progs->flags |= BPF_PROG_ARRAY_F_SLEEPABLE;
+
 	*array = progs;
 	return 0;
 }
@@ -451,7 +499,7 @@ static void activate_effective_progs(struct cgroup *cgrp,
 	/* free prog array after grace period, since __cgroup_bpf_run_*()
 	 * might be still walking the array
 	 */
-	bpf_prog_array_free(old_array);
+	bpf_prog_array_free_sleepable(old_array);
 }
 
 /**
@@ -491,7 +539,7 @@ int cgroup_bpf_inherit(struct cgroup *cgrp)
 	return 0;
 cleanup:
 	for (i = 0; i < NR; i++)
-		bpf_prog_array_free(arrays[i]);
+		bpf_prog_array_free_sleepable(arrays[i]);
 
 	for (p = cgroup_parent(cgrp); p; p = cgroup_parent(p))
 		cgroup_bpf_put(p);
@@ -525,7 +573,7 @@ static int update_effective_progs(struct cgroup *cgrp,
 
 		if (percpu_ref_is_zero(&desc->bpf.refcnt)) {
 			if (unlikely(desc->bpf.inactive)) {
-				bpf_prog_array_free(desc->bpf.inactive);
+				bpf_prog_array_free_sleepable(desc->bpf.inactive);
 				desc->bpf.inactive = NULL;
 			}
 			continue;
@@ -544,7 +592,7 @@ static int update_effective_progs(struct cgroup *cgrp,
 	css_for_each_descendant_pre(css, &cgrp->self) {
 		struct cgroup *desc = container_of(css, struct cgroup, self);
 
-		bpf_prog_array_free(desc->bpf.inactive);
+		bpf_prog_array_free_sleepable(desc->bpf.inactive);
 		desc->bpf.inactive = NULL;
 	}
 
@@ -1740,7 +1788,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 
 #ifdef CONFIG_NET
 static int sockopt_alloc_buf(struct bpf_sockopt_kern *ctx, int max_optlen,
-			     struct bpf_sockopt_buf *buf)
+			     struct bpf_sockopt_buf *buf, bool force_alloc)
 {
 	if (unlikely(max_optlen < 0))
 		return -EINVAL;
@@ -1752,7 +1800,7 @@ static int sockopt_alloc_buf(struct bpf_sockopt_kern *ctx, int max_optlen,
 		max_optlen = PAGE_SIZE;
 	}
 
-	if (max_optlen <= sizeof(buf->data)) {
+	if (max_optlen <= sizeof(buf->data) && !force_alloc) {
 		/* When the optval fits into BPF_SOCKOPT_KERN_BUF_SIZE
 		 * bytes avoid the cost of kzalloc.
 		 */
@@ -1773,7 +1821,8 @@ static int sockopt_alloc_buf(struct bpf_sockopt_kern *ctx, int max_optlen,
 static void sockopt_free_buf(struct bpf_sockopt_kern *ctx,
 			     struct bpf_sockopt_buf *buf)
 {
-	if (ctx->optval == buf->data)
+	if (ctx->optval == buf->data ||
+	    ctx->flags & BPF_SOCKOPT_FLAG_OPTVAL_USER)
 		return;
 	kfree(ctx->optval);
 }
@@ -1781,7 +1830,47 @@ static void sockopt_free_buf(struct bpf_sockopt_kern *ctx,
 static bool sockopt_buf_allocated(struct bpf_sockopt_kern *ctx,
 				  struct bpf_sockopt_buf *buf)
 {
-	return ctx->optval != buf->data;
+	return ctx->optval != buf->data &&
+		!(ctx->flags & BPF_SOCKOPT_FLAG_OPTVAL_USER);
+}
+
+struct filter_sockopt_cb_args {
+	struct bpf_sockopt_kern *ctx;
+	struct bpf_sockopt_buf *buf;
+	int max_optlen;
+};
+
+static int filter_setsockopt_progs_cb(void *arg,
+				      const struct bpf_prog_array *progs)
+{
+	struct filter_sockopt_cb_args *cb_args = arg;
+	struct bpf_sockopt_kern *ctx = cb_args->ctx;
+	char *optval = ctx->optval;
+	int max_optlen;
+
+	if (!(progs->flags & BPF_PROG_ARRAY_F_NON_SLEEPABLE))
+		return 0;
+
+	/* Allocate a bit more than the initial user buffer for
+	 * BPF program. The canonical use case is overriding
+	 * TCP_CONGESTION(nv) to TCP_CONGESTION(cubic).
+	 */
+	max_optlen = max_t(int, 16, ctx->optlen);
+	/* We need to force allocating from heap if there are sleepable
+	 * programs since they may created dynptrs from ctx->optval. In
+	 * this case, dynptrs will try to free the buffer that is actually
+	 * on the stack without this flag.
+	 */
+	max_optlen = sockopt_alloc_buf(ctx, max_optlen, cb_args->buf,
+				       progs->flags & BPF_PROG_ARRAY_F_SLEEPABLE);
+	if (max_optlen < 0)
+		return max_optlen;
+
+	if (copy_from_user(ctx->optval, optval,
+			   min(ctx->optlen, max_optlen)) != 0)
+		return -EFAULT;
+
+	return 0;
 }
 
 int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
@@ -1795,27 +1884,22 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 		.level = *level,
 		.optname = *optname,
 	};
+	struct filter_sockopt_cb_args cb_args = {
+		.ctx = &ctx,
+		.buf = &buf,
+	};
 	int ret, max_optlen;
 
-	/* Allocate a bit more than the initial user buffer for
-	 * BPF program. The canonical use case is overriding
-	 * TCP_CONGESTION(nv) to TCP_CONGESTION(cubic).
-	 */
-	max_optlen = max_t(int, 16, *optlen);
-	max_optlen = sockopt_alloc_buf(&ctx, max_optlen, &buf);
-	if (max_optlen < 0)
-		return max_optlen;
-
+	max_optlen = *optlen;
 	ctx.optlen = *optlen;
-
-	if (copy_from_user(ctx.optval, optval, min(*optlen, max_optlen)) != 0) {
-		ret = -EFAULT;
-		goto out;
-	}
+	ctx.optval = optval;
+	ctx.optval_end = optval + *optlen;
+	ctx.flags = BPF_SOCKOPT_FLAG_OPTVAL_USER;
 
 	lock_sock(sk);
-	ret = bpf_prog_run_array_cg(&cgrp->bpf, CGROUP_SETSOCKOPT,
-				    &ctx, bpf_prog_run, 0, NULL);
+	ret = bpf_prog_run_array_cg_cb(&cgrp->bpf, CGROUP_SETSOCKOPT,
+				       &ctx, bpf_prog_run, 0, NULL,
+				       filter_setsockopt_progs_cb, &cb_args);
 	release_sock(sk);
 
 	if (ret)
@@ -1824,7 +1908,8 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 	if (ctx.optlen == -1) {
 		/* optlen set to -1, bypass kernel */
 		ret = 1;
-	} else if (ctx.optlen > max_optlen || ctx.optlen < -1) {
+	} else if (ctx.optlen > (ctx.optval_end - ctx.optval) ||
+		   ctx.optlen < -1) {
 		/* optlen is out of bounds */
 		if (*optlen > PAGE_SIZE && ctx.optlen >= 0) {
 			pr_info_once("bpf setsockopt: ignoring program buffer with optlen=%d (max_optlen=%d)\n",
@@ -1846,6 +1931,8 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 		 */
 		if (ctx.optlen != 0) {
 			*optlen = ctx.optlen;
+			if (ctx.flags & BPF_SOCKOPT_FLAG_OPTVAL_USER)
+				return 0;
 			/* We've used bpf_sockopt_kern->buf as an intermediary
 			 * storage, but the BPF program indicates that we need
 			 * to pass this data to the kernel setsockopt handler.
@@ -1874,6 +1961,33 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 	return ret;
 }
 
+static int filter_getsockopt_progs_cb(void *arg,
+				      const struct bpf_prog_array *progs)
+{
+	struct filter_sockopt_cb_args *cb_args = arg;
+	struct bpf_sockopt_kern *ctx = cb_args->ctx;
+	int max_optlen;
+	char *optval;
+
+	if (!(progs->flags & BPF_PROG_ARRAY_F_NON_SLEEPABLE))
+		return 0;
+
+	optval = ctx->optval;
+	max_optlen = sockopt_alloc_buf(ctx, cb_args->max_optlen,
+				       cb_args->buf, false);
+	if (max_optlen < 0)
+		return max_optlen;
+
+	if (copy_from_user(ctx->optval, optval,
+			   min(ctx->optlen, max_optlen)) != 0)
+		return -EFAULT;
+
+	ctx->flags = 0;
+	cb_args->max_optlen = max_optlen;
+
+	return 0;
+}
+
 int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 				       int optname, char __user *optval,
 				       int __user *optlen, int max_optlen,
@@ -1887,15 +2001,16 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 		.optname = optname,
 		.current_task = current,
 	};
+	struct filter_sockopt_cb_args cb_args = {
+		.ctx = &ctx,
+		.buf = &buf,
+		.max_optlen = max_optlen,
+	};
 	int orig_optlen;
 	int ret;
 
 	orig_optlen = max_optlen;
 	ctx.optlen = max_optlen;
-	max_optlen = sockopt_alloc_buf(&ctx, max_optlen, &buf);
-	if (max_optlen < 0)
-		return max_optlen;
-
 	if (!retval) {
 		/* If kernel getsockopt finished successfully,
 		 * copy whatever was returned to the user back
@@ -1914,18 +2029,19 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 			goto out;
 		}
 		orig_optlen = ctx.optlen;
-
-		if (copy_from_user(ctx.optval, optval,
-				   min(ctx.optlen, max_optlen)) != 0) {
-			ret = -EFAULT;
-			goto out;
-		}
 	}
 
+	ctx.optval = optval;
+	ctx.optval_end = optval + max_optlen;
+	ctx.flags = BPF_SOCKOPT_FLAG_OPTVAL_USER;
+
 	lock_sock(sk);
-	ret = bpf_prog_run_array_cg(&cgrp->bpf, CGROUP_GETSOCKOPT,
-				    &ctx, bpf_prog_run, retval, NULL);
+	ret = bpf_prog_run_array_cg_cb(&cgrp->bpf, CGROUP_GETSOCKOPT,
+				       &ctx, bpf_prog_run, retval, NULL,
+				       filter_getsockopt_progs_cb,
+				       &cb_args);
 	release_sock(sk);
+	max_optlen = ctx.optval_end - ctx.optval;
 
 	if (ret < 0)
 		goto out;
@@ -1942,7 +2058,9 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 	}
 
 	if (ctx.optlen != 0) {
-		if (optval && copy_to_user(optval, ctx.optval, ctx.optlen)) {
+		if (optval &&
+		    !(ctx.flags & BPF_SOCKOPT_FLAG_OPTVAL_USER) &&
+		    copy_to_user(optval, ctx.optval, ctx.optlen)) {
 			ret = -EFAULT;
 			goto out;
 		}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4ccca1f6c998..61be432b9420 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19549,7 +19549,8 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 	}
 	return prog->type == BPF_PROG_TYPE_LSM ||
 	       prog->type == BPF_PROG_TYPE_KPROBE /* only for uprobes */ ||
-	       prog->type == BPF_PROG_TYPE_STRUCT_OPS;
+	       prog->type == BPF_PROG_TYPE_STRUCT_OPS ||
+	       prog->type == BPF_PROG_TYPE_CGROUP_SOCKOPT;
 }
 
 static int check_attach_btf_id(struct bpf_verifier_env *env)
@@ -19571,7 +19572,7 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	}
 
 	if (prog->aux->sleepable && !can_be_sleepable(prog)) {
-		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
+		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, cgroup, and struct_ops programs can be sleepable\n");
 		return -EINVAL;
 	}
 
-- 
2.34.1


