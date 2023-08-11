Return-Path: <bpf+bounces-7515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E649778683
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 06:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13743281F9A
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 04:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5129110E;
	Fri, 11 Aug 2023 04:31:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6733E1109
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 04:31:36 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391BF2696
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 21:31:34 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-583d702129cso18349817b3.3
        for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 21:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691728293; x=1692333093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+KW7pZj+8TGM9IAP0FMozRCT/cdgc6wZuoI+zQm7Yg=;
        b=J4Fl9aGlksR+QFtsAQykRZ3OS+FnlQjho74EfSsJgbTSq5c8yELQImeFdE15lHKcwB
         sTPDTk/vVgSArAJH4NXjjyDC2E9sLnsFYasQrU9Y07fzOTTdET4QEy1aHNSlrPMnMlzu
         vW47ktPuomnTPF/ZamfmZBUAU7MQ2riIE5+BFSBQEXjdX72H+0cu2ZaprADnayujAO01
         qyDDnFDX67KUPpLDlIERIl1OaTWLb8YmS+caQqWWCvVHQGDVDupZCqA5409yrUi0x1la
         GQvSszt0LDb0uRr0E31/RFL9HQ4AP1DaZvjabpPX719eryRszPRMUt/a4CnGCVo/WJ0H
         Tkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691728293; x=1692333093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+KW7pZj+8TGM9IAP0FMozRCT/cdgc6wZuoI+zQm7Yg=;
        b=d4RxfwZh0CrEnGgW6tQhBA0l3FcupEd0Z/tcMG1remA5VbsgCf4wbPkve1QZ76AkJ7
         EzRy/nfIgttRPyrZ6DDkTEhj+avGs8Pdy+GD6JSVIXi2BIlvfsBJKOUoG9ck80WE8QA7
         KrYBnq7KoZP0AzWHpj7R2hSST7brPSxqdimUfPHkUFPV70t4nrZK08/doVyaQWwBrZLL
         sbUECnHV3py2cXCUZBg0FWzITuZVEkpUGlfi6O4oahKB0rurCcqS430vRP0xNqdP/ikF
         I1tu0dZyBl6mdLnyvUSbQ5hrXhX98ukQOqXz800OxRmaV7AFbWQb8Py8uccaRTIQut8W
         qC5A==
X-Gm-Message-State: AOJu0YzJoN52ioUEKi3ZnTNOyYcXqKV2gK3PWOP3/wEiYqSb3xUVQATa
	Y16KWO1cMPrB3xTtB6H/G6i7X+nZ3zQ4+w==
X-Google-Smtp-Source: AGHT+IEHWAGbvFxu2oeJCxHVlH7SMXJLrjVli6QxR9kNdRgxIhRrWdxZxlcPrf642M5Fv3t7ZMUYXA==
X-Received: by 2002:a81:a542:0:b0:583:c917:7ff0 with SMTP id v2-20020a81a542000000b00583c9177ff0mr631932ywg.51.1691728293077;
        Thu, 10 Aug 2023 21:31:33 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:16da:9387:4176:e970])
        by smtp.gmail.com with ESMTPSA id n15-20020a819c4f000000b00583e52232f1sm767961ywa.112.2023.08.10.21.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 21:31:32 -0700 (PDT)
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
Subject: [RFC bpf-next v2 1/6] bpf: enable sleepable BPF programs attached to cgroup/{get,set}sockopt.
Date: Thu, 10 Aug 2023 21:31:22 -0700
Message-Id: <20230811043127.1318152-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811043127.1318152-1-thinker.li@gmail.com>
References: <20230811043127.1318152-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <kuifeng@meta.com>

Enable sleepable cgroup/{get,set}sockopt hooks.

The sleepable BPF programs attached to cgroup/{get,set}sockopt hooks may
received a pointer to the optval in user space instead of a kernel
copy. ctx->user_optval and ctx->user_optval_end are the pointers to the
begin and end of the user space buffer if receiving a user space
buffer. ctx->optval and ctx->optval_end will be a kernel copy if receiving
a kernel space buffer.

A program receives a user space buffer if ctx->flags &
BPF_SOCKOPT_FLAG_OPTVAL_USER is true, otherwise it receives a kernel space
buffer.  The BPF programs should not read/write from/to a user space buffer
dirrectly.  It should access the buffer through bpf_copy_from_user() and
bpf_copy_to_user() provided in the following patches.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/filter.h         |   1 +
 include/uapi/linux/bpf.h       |   7 +
 kernel/bpf/cgroup.c            | 229 ++++++++++++++++++++++++++-------
 kernel/bpf/verifier.c          |   7 +-
 tools/include/uapi/linux/bpf.h |   7 +
 tools/lib/bpf/libbpf.c         |   2 +
 6 files changed, 206 insertions(+), 47 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 761af6b3cf2b..54169a641d40 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1337,6 +1337,7 @@ struct bpf_sockopt_kern {
 	s32		level;
 	s32		optname;
 	s32		optlen;
+	u32		flags;
 	/* for retval in struct bpf_cg_run_ctx */
 	struct task_struct *current_task;
 	/* Temporary "register" for indirect stores to ppos. */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 70da85200695..fff6f7dff408 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7138,6 +7138,13 @@ struct bpf_sockopt {
 	__s32	optname;
 	__s32	optlen;
 	__s32	retval;
+
+	__u32	flags;
+};
+
+enum bpf_sockopt_flags {
+	/* optval is a pointer to user space memory */
+	BPF_SOCKOPT_FLAG_OPTVAL_USER	= (1U << 0),
 };
 
 struct bpf_pidns_info {
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 5b2741aa0d9b..59489d9619a3 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -28,25 +28,46 @@ EXPORT_SYMBOL(cgroup_bpf_enabled_key);
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
+			 int (*progs_cb)(void *, const struct bpf_prog_array_item *),
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
+	} else
+		rcu_read_lock();
 	array = rcu_dereference(cgrp->effective[atype]);
 	item = &array->items[0];
+
+	if (progs_cb) {
+		err = progs_cb(progs_cb_arg, item);
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
@@ -56,13 +77,48 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
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
 
+static __always_inline void
+count_sleepable_prog_cg(const struct bpf_prog_array_item *item,
+			int *sleepable, int *non_sleepable)
+{
+	const struct bpf_prog *prog;
+	bool ret = true;
+
+	*sleepable = 0;
+	*non_sleepable = 0;
+
+	while (ret && (prog = READ_ONCE(item->prog))) {
+		if (prog->aux->sleepable)
+			(*sleepable)++;
+		else
+			(*non_sleepable)++;
+		item++;
+	}
+}
+
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
@@ -307,7 +363,7 @@ static void cgroup_bpf_release(struct work_struct *work)
 		old_array = rcu_dereference_protected(
 				cgrp->bpf.effective[atype],
 				lockdep_is_held(&cgroup_mutex));
-		bpf_prog_array_free(old_array);
+		bpf_prog_array_free_sleepable(old_array);
 	}
 
 	list_for_each_entry_safe(storage, stmp, storages, list_cg) {
@@ -451,7 +507,7 @@ static void activate_effective_progs(struct cgroup *cgrp,
 	/* free prog array after grace period, since __cgroup_bpf_run_*()
 	 * might be still walking the array
 	 */
-	bpf_prog_array_free(old_array);
+	bpf_prog_array_free_sleepable(old_array);
 }
 
 /**
@@ -491,7 +547,7 @@ int cgroup_bpf_inherit(struct cgroup *cgrp)
 	return 0;
 cleanup:
 	for (i = 0; i < NR; i++)
-		bpf_prog_array_free(arrays[i]);
+		bpf_prog_array_free_sleepable(arrays[i]);
 
 	for (p = cgroup_parent(cgrp); p; p = cgroup_parent(p))
 		cgroup_bpf_put(p);
@@ -525,7 +581,7 @@ static int update_effective_progs(struct cgroup *cgrp,
 
 		if (percpu_ref_is_zero(&desc->bpf.refcnt)) {
 			if (unlikely(desc->bpf.inactive)) {
-				bpf_prog_array_free(desc->bpf.inactive);
+				bpf_prog_array_free_sleepable(desc->bpf.inactive);
 				desc->bpf.inactive = NULL;
 			}
 			continue;
@@ -544,7 +600,7 @@ static int update_effective_progs(struct cgroup *cgrp,
 	css_for_each_descendant_pre(css, &cgrp->self) {
 		struct cgroup *desc = container_of(css, struct cgroup, self);
 
-		bpf_prog_array_free(desc->bpf.inactive);
+		bpf_prog_array_free_sleepable(desc->bpf.inactive);
 		desc->bpf.inactive = NULL;
 	}
 
@@ -1740,7 +1796,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 
 #ifdef CONFIG_NET
 static int sockopt_alloc_buf(struct bpf_sockopt_kern *ctx, int max_optlen,
-			     struct bpf_sockopt_buf *buf)
+			     struct bpf_sockopt_buf *buf, bool force_alloc)
 {
 	if (unlikely(max_optlen < 0))
 		return -EINVAL;
@@ -1752,7 +1808,7 @@ static int sockopt_alloc_buf(struct bpf_sockopt_kern *ctx, int max_optlen,
 		max_optlen = PAGE_SIZE;
 	}
 
-	if (max_optlen <= sizeof(buf->data)) {
+	if (max_optlen <= sizeof(buf->data) && !force_alloc) {
 		/* When the optval fits into BPF_SOCKOPT_KERN_BUF_SIZE
 		 * bytes avoid the cost of kzalloc.
 		 */
@@ -1773,7 +1829,8 @@ static int sockopt_alloc_buf(struct bpf_sockopt_kern *ctx, int max_optlen,
 static void sockopt_free_buf(struct bpf_sockopt_kern *ctx,
 			     struct bpf_sockopt_buf *buf)
 {
-	if (ctx->optval == buf->data)
+	if (ctx->optval == buf->data ||
+	    ctx->flags & BPF_SOCKOPT_FLAG_OPTVAL_USER)
 		return;
 	kfree(ctx->optval);
 }
@@ -1781,7 +1838,50 @@ static void sockopt_free_buf(struct bpf_sockopt_kern *ctx,
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
+				      const struct bpf_prog_array_item *item)
+{
+	struct filter_sockopt_cb_args *cb_args = arg;
+	struct bpf_sockopt_kern *ctx = cb_args->ctx;
+	char *optval = ctx->optval;
+	int sleepable_cnt, non_sleepable_cnt;
+	int max_optlen;
+
+	count_sleepable_prog_cg(item, &sleepable_cnt, &non_sleepable_cnt);
+
+	if (!non_sleepable_cnt)
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
+				       !!sleepable_cnt);
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
@@ -1795,27 +1895,22 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
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
@@ -1824,7 +1919,8 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 	if (ctx.optlen == -1) {
 		/* optlen set to -1, bypass kernel */
 		ret = 1;
-	} else if (ctx.optlen > max_optlen || ctx.optlen < -1) {
+	} else if (ctx.optlen > (ctx.optval_end - ctx.optval) ||
+		   ctx.optlen < -1) {
 		/* optlen is out of bounds */
 		if (*optlen > PAGE_SIZE && ctx.optlen >= 0) {
 			pr_info_once("bpf setsockopt: ignoring program buffer with optlen=%d (max_optlen=%d)\n",
@@ -1846,6 +1942,8 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 		 */
 		if (ctx.optlen != 0) {
 			*optlen = ctx.optlen;
+			if (ctx.flags & BPF_SOCKOPT_FLAG_OPTVAL_USER)
+				return 0;
 			/* We've used bpf_sockopt_kern->buf as an intermediary
 			 * storage, but the BPF program indicates that we need
 			 * to pass this data to the kernel setsockopt handler.
@@ -1874,6 +1972,36 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 	return ret;
 }
 
+static int filter_getsockopt_progs_cb(void *arg,
+				      const struct bpf_prog_array_item *item)
+{
+	struct filter_sockopt_cb_args *cb_args = arg;
+	struct bpf_sockopt_kern *ctx = cb_args->ctx;
+	int sleepable_cnt, non_sleepable_cnt;
+	int max_optlen;
+	char *optval;
+
+	count_sleepable_prog_cg(item, &sleepable_cnt, &non_sleepable_cnt);
+
+	if (!non_sleepable_cnt)
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
@@ -1887,15 +2015,16 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
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
@@ -1914,18 +2043,19 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
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
+	max_optlen = cb_args.max_optlen;
 
 	if (ret < 0)
 		goto out;
@@ -1942,7 +2072,9 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 	}
 
 	if (ctx.optlen != 0) {
-		if (optval && copy_to_user(optval, ctx.optval, ctx.optlen)) {
+		if (optval &&
+		    !(ctx.flags & BPF_SOCKOPT_FLAG_OPTVAL_USER) &&
+		    copy_to_user(optval, ctx.optval, ctx.optlen)) {
 			ret = -EFAULT;
 			goto out;
 		}
@@ -2388,6 +2520,10 @@ static bool cg_sockopt_is_valid_access(int off, int size,
 		if (size != size_default)
 			return false;
 		return prog->expected_attach_type == BPF_CGROUP_GETSOCKOPT;
+	case offsetof(struct bpf_sockopt, flags):
+		if (size != sizeof(__u32))
+			return false;
+		break;
 	default:
 		if (size != size_default)
 			return false;
@@ -2481,6 +2617,9 @@ static u32 cg_sockopt_convert_ctx_access(enum bpf_access_type type,
 	case offsetof(struct bpf_sockopt, optval_end):
 		*insn++ = CG_SOCKOPT_READ_FIELD(optval_end);
 		break;
+	case offsetof(struct bpf_sockopt, flags):
+		*insn++ = CG_SOCKOPT_READ_FIELD(flags);
+		break;
 	}
 
 	return insn - insn_buf;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 132f25dab931..fbc0096693e7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19538,9 +19538,11 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 			return false;
 		}
 	}
+
 	return prog->type == BPF_PROG_TYPE_LSM ||
 	       prog->type == BPF_PROG_TYPE_KPROBE /* only for uprobes */ ||
-	       prog->type == BPF_PROG_TYPE_STRUCT_OPS;
+	       prog->type == BPF_PROG_TYPE_STRUCT_OPS ||
+	       prog->type == BPF_PROG_TYPE_CGROUP_SOCKOPT;
 }
 
 static int check_attach_btf_id(struct bpf_verifier_env *env)
@@ -19562,7 +19564,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	}
 
 	if (prog->aux->sleepable && !can_be_sleepable(prog)) {
-		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable\n");
+		verbose(env, "Only fentry/fexit/fmod_ret, lsm, iter, uprobe,"
+			"cgroup, and struct_ops programs can be sleepable\n");
 		return -EINVAL;
 	}
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 70da85200695..fff6f7dff408 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7138,6 +7138,13 @@ struct bpf_sockopt {
 	__s32	optname;
 	__s32	optlen;
 	__s32	retval;
+
+	__u32	flags;
+};
+
+enum bpf_sockopt_flags {
+	/* optval is a pointer to user space memory */
+	BPF_SOCKOPT_FLAG_OPTVAL_USER	= (1U << 0),
 };
 
 struct bpf_pidns_info {
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 17883f5a44b9..3be9270bbc33 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8766,7 +8766,9 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("cgroup/getsockname6",	CGROUP_SOCK_ADDR, BPF_CGROUP_INET6_GETSOCKNAME, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/sysctl",	CGROUP_SYSCTL, BPF_CGROUP_SYSCTL, SEC_ATTACHABLE),
 	SEC_DEF("cgroup/getsockopt",	CGROUP_SOCKOPT, BPF_CGROUP_GETSOCKOPT, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/getsockopt.s",	CGROUP_SOCKOPT, BPF_CGROUP_GETSOCKOPT, SEC_ATTACHABLE | SEC_SLEEPABLE),
 	SEC_DEF("cgroup/setsockopt",	CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT, SEC_ATTACHABLE),
+	SEC_DEF("cgroup/setsockopt.s",	CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT, SEC_ATTACHABLE | SEC_SLEEPABLE),
 	SEC_DEF("cgroup/dev",		CGROUP_DEVICE, BPF_CGROUP_DEVICE, SEC_ATTACHABLE_OPT),
 	SEC_DEF("struct_ops+",		STRUCT_OPS, 0, SEC_NONE),
 	SEC_DEF("struct_ops.s+",	STRUCT_OPS, 0, SEC_SLEEPABLE),
-- 
2.34.1


