Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77E74846D2
	for <lists+bpf@lfdr.de>; Tue,  4 Jan 2022 18:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbiADRPa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jan 2022 12:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbiADRPX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Jan 2022 12:15:23 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04559C061761
        for <bpf@vger.kernel.org>; Tue,  4 Jan 2022 09:15:23 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id m14-20020a633f0e000000b0033fc903c6a4so20019162pga.12
        for <bpf@vger.kernel.org>; Tue, 04 Jan 2022 09:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QbEyPwCWeHNh9Fom2O9Ha326TN9JZK3EjaAhufWNppI=;
        b=YcBZZoalSiBDjKM8v4hevAX47cgtV6MCFruqkz3HO+CA3o1lNOjleAQX6d8R+QFihg
         tdTBeKY27JfNajdoE8/v1Zgh+a0wMlCqNTc7aJvj5LN8+kxEBox5d2wz5n2F3BXXp5Su
         MwSeeMUxJxejNCfqI7iikQNwBvxc8+WN+dGNaOs4qEIzEEOnSbRvFy/xa5iLAGjxNwO/
         3x72ISq7te/icr9fJYyQNrb7e9kbAuXbtadA1nUOjL3LcJhPJR7mrKKXaG0BVBDEx00l
         X+dvD9e6G8a/G8nDbpYtdQtYohiyn7xCoG5Y+uX3XyXHMF2AdBKPIseg7qUrr1zKg9Gs
         A9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QbEyPwCWeHNh9Fom2O9Ha326TN9JZK3EjaAhufWNppI=;
        b=ytDVfmYt2QJ+DxGYIr23dI/yyGqpjRZgYHYaZ6hc+Bo43NsAwYO1JHuTeQjjOhv+sq
         OtvQsaI8Dob+1XvzZEMsG9PtI597JllvnMAGo5iJiQjRc6TWpWyGUuOLgazEvpCuKgUC
         i3pRBtEJs8v9I5I/4dCuKBEKQF8Srxgh3z5b3hAObCrtGJHVJBB521Vm+cfK3+MRRi7Y
         OhynVNAkGNDNYRuUUZmgo7YfshtMfJv3iPwfUTMadI31nvr+h3Zwjl5S1VJPWZSahnzR
         qeLu4uzRiACpMJLIukBHpU7TvUwMyQzZhBdO7PShCspwMiU3mLrf1UF8LEOp4jBhjfgr
         mTYg==
X-Gm-Message-State: AOAM531V+lhr6EzVN9kcJb9rXBKgjA2He+O/p2mXgl0IUPqcZYRAluGo
        aGLVzZmPBmIjovs+nnIvfi75AdTkkRyUY5RdMdAWO0ETO7gTm9rdPDQKTUgw0YuYeJfA9ydXmtm
        Nx/EdEefFC90BX1jMwe+MXAZW4jBJkYyHpKx8el71z8MRreYD+T2uv10HBXMBaFA=
X-Google-Smtp-Source: ABdhPJy0GMao7vUMJMGAlTDXpCwMhbA5Az0m5NkfkE07mIcyzJPmWYnkRl6Msql8yBlIwADg46zsX3g5td0lXQ==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a17:90b:1a88:: with SMTP id
 ng8mr61561712pjb.180.1641316522367; Tue, 04 Jan 2022 09:15:22 -0800 (PST)
Date:   Tue,  4 Jan 2022 17:15:03 +0000
In-Reply-To: <cover.1641316155.git.zhuyifei@google.com>
Message-Id: <13f9e3d27bb0a1b159920f843fa52f9448180f23.1641316155.git.zhuyifei@google.com>
Mime-Version: 1.0
References: <cover.1641316155.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 bpf-next 2/4] bpf: Move getsockopt retval to struct bpf_cg_run_ctx
From:   YiFei Zhu <zhuyifei@google.com>
To:     bpf@vger.kernel.org
Cc:     Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The retval value is moved to struct bpf_cg_run_ctx for ease of access
in different prog types with different context structs layouts. The
helper implementation (to be added in a later patch in the series) can
simply perform a container_of from current->bpf_ctx to retrieve
bpf_cg_run_ctx.

Unfortunately, there is no easy way to access the current task_struct
via the verifier BPF bytecode rewrite, aside from possibly calling a
helper, so a pointer to current task is added to struct bpf_sockopt_kern
so that the rewritten BPF bytecode can access struct bpf_cg_run_ctx with
an indirection.

For backward compatibility, if a getsockopt program rejects a syscall
by returning 0, an -EPERM will be generated, by having the
BPF_PROG_RUN_ARRAY_CG family macros automatically set the retval to
-EPERM. Unlike prior to this patch, this -EPERM will be visible to
ctx->retval for any other hooks down the line in the prog array.

Additionally, the restriction that getsockopt filters can only set
the retval to 0 is removed, considering that certain getsockopt
implementations may return optlen. Filters are now able to set the
value arbitrarily.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Reviewed-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf.h    | 20 ++++++-----
 include/linux/filter.h |  5 ++-
 kernel/bpf/cgroup.c    | 82 ++++++++++++++++++++++++------------------
 3 files changed, 63 insertions(+), 44 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 37eebb703923..88f6891e2b53 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1246,6 +1246,7 @@ struct bpf_run_ctx {};
 struct bpf_cg_run_ctx {
 	struct bpf_run_ctx run_ctx;
 	const struct bpf_prog_array_item *prog_item;
+	int retval;
 };
 
 struct bpf_trace_run_ctx {
@@ -1281,16 +1282,16 @@ typedef u32 (*bpf_prog_run_fn)(const struct bpf_prog *prog, const void *ctx);
 static __always_inline int
 BPF_PROG_RUN_ARRAY_CG_FLAGS(const struct bpf_prog_array __rcu *array_rcu,
 			    const void *ctx, bpf_prog_run_fn run_prog,
-			    u32 *ret_flags)
+			    int retval, u32 *ret_flags)
 {
 	const struct bpf_prog_array_item *item;
 	const struct bpf_prog *prog;
 	const struct bpf_prog_array *array;
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_cg_run_ctx run_ctx;
-	int ret = 0;
 	u32 func_ret;
 
+	run_ctx.retval = retval;
 	migrate_disable();
 	rcu_read_lock();
 	array = rcu_dereference(array_rcu);
@@ -1300,27 +1301,28 @@ BPF_PROG_RUN_ARRAY_CG_FLAGS(const struct bpf_prog_array __rcu *array_rcu,
 		run_ctx.prog_item = item;
 		func_ret = run_prog(prog, ctx);
 		if (!(func_ret & 1))
-			ret = -EPERM;
+			run_ctx.retval = -EPERM;
 		*(ret_flags) |= (func_ret >> 1);
 		item++;
 	}
 	bpf_reset_run_ctx(old_run_ctx);
 	rcu_read_unlock();
 	migrate_enable();
-	return ret;
+	return run_ctx.retval;
 }
 
 static __always_inline int
 BPF_PROG_RUN_ARRAY_CG(const struct bpf_prog_array __rcu *array_rcu,
-		      const void *ctx, bpf_prog_run_fn run_prog)
+		      const void *ctx, bpf_prog_run_fn run_prog,
+		      int retval)
 {
 	const struct bpf_prog_array_item *item;
 	const struct bpf_prog *prog;
 	const struct bpf_prog_array *array;
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_cg_run_ctx run_ctx;
-	int ret = 0;
 
+	run_ctx.retval = retval;
 	migrate_disable();
 	rcu_read_lock();
 	array = rcu_dereference(array_rcu);
@@ -1329,13 +1331,13 @@ BPF_PROG_RUN_ARRAY_CG(const struct bpf_prog_array __rcu *array_rcu,
 	while ((prog = READ_ONCE(item->prog))) {
 		run_ctx.prog_item = item;
 		if (!run_prog(prog, ctx))
-			ret = -EPERM;
+			run_ctx.retval = -EPERM;
 		item++;
 	}
 	bpf_reset_run_ctx(old_run_ctx);
 	rcu_read_unlock();
 	migrate_enable();
-	return ret;
+	return run_ctx.retval;
 }
 
 static __always_inline u32
@@ -1395,7 +1397,7 @@ BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
 		u32 _flags = 0;				\
 		bool _cn;				\
 		u32 _ret;				\
-		_ret = BPF_PROG_RUN_ARRAY_CG_FLAGS(array, ctx, func, &_flags); \
+		_ret = BPF_PROG_RUN_ARRAY_CG_FLAGS(array, ctx, func, 0, &_flags); \
 		_cn = _flags & BPF_RET_SET_CN;		\
 		if (!_ret)				\
 			_ret = (_cn ? NET_XMIT_CN : NET_XMIT_SUCCESS);	\
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 60eec80fa1d4..697fadb640ad 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1352,7 +1352,10 @@ struct bpf_sockopt_kern {
 	s32		level;
 	s32		optname;
 	s32		optlen;
-	s32		retval;
+	/* for retval in struct bpf_cg_run_ctx */
+	struct task_struct *current_task;
+	/* Temporary "register" for indirect stores to ppos. */
+	u64		tmp_reg;
 };
 
 int copy_bpf_fprog_from_user(struct sock_fprog *dst, sockptr_t src, int len);
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 386155d279b3..b6fad0bbf5a7 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1079,7 +1079,7 @@ int __cgroup_bpf_run_filter_skb(struct sock *sk,
 			cgrp->bpf.effective[atype], skb, __bpf_prog_run_save_cb);
 	} else {
 		ret = BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[atype], skb,
-					    __bpf_prog_run_save_cb);
+					    __bpf_prog_run_save_cb, 0);
 	}
 	bpf_restore_data_end(skb, saved_data_end);
 	__skb_pull(skb, offset);
@@ -1108,7 +1108,7 @@ int __cgroup_bpf_run_filter_sk(struct sock *sk,
 	struct cgroup *cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
 
 	return BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[atype], sk,
-				     bpf_prog_run);
+				     bpf_prog_run, 0);
 }
 EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
 
@@ -1154,7 +1154,7 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 
 	cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
 	return BPF_PROG_RUN_ARRAY_CG_FLAGS(cgrp->bpf.effective[atype], &ctx,
-					   bpf_prog_run, flags);
+					   bpf_prog_run, 0, flags);
 }
 EXPORT_SYMBOL(__cgroup_bpf_run_filter_sock_addr);
 
@@ -1181,7 +1181,7 @@ int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
 	struct cgroup *cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
 
 	return BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[atype], sock_ops,
-				     bpf_prog_run);
+				     bpf_prog_run, 0);
 }
 EXPORT_SYMBOL(__cgroup_bpf_run_filter_sock_ops);
 
@@ -1199,7 +1199,7 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 	rcu_read_lock();
 	cgrp = task_dfl_cgroup(current);
 	ret = BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[atype], &ctx,
-				    bpf_prog_run);
+				    bpf_prog_run, 0);
 	rcu_read_unlock();
 
 	return ret;
@@ -1330,7 +1330,8 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 
 	rcu_read_lock();
 	cgrp = task_dfl_cgroup(current);
-	ret = BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[atype], &ctx, bpf_prog_run);
+	ret = BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[atype], &ctx,
+				    bpf_prog_run, 0);
 	rcu_read_unlock();
 
 	kfree(ctx.cur_val);
@@ -1445,7 +1446,7 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 
 	lock_sock(sk);
 	ret = BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[CGROUP_SETSOCKOPT],
-				    &ctx, bpf_prog_run);
+				    &ctx, bpf_prog_run, 0);
 	release_sock(sk);
 
 	if (ret)
@@ -1509,7 +1510,7 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 		.sk = sk,
 		.level = level,
 		.optname = optname,
-		.retval = retval,
+		.current_task = current,
 	};
 	int ret;
 
@@ -1553,10 +1554,10 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 
 	lock_sock(sk);
 	ret = BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[CGROUP_GETSOCKOPT],
-				    &ctx, bpf_prog_run);
+				    &ctx, bpf_prog_run, retval);
 	release_sock(sk);
 
-	if (ret)
+	if (ret < 0)
 		goto out;
 
 	if (ctx.optlen > max_optlen || ctx.optlen < 0) {
@@ -1564,14 +1565,6 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 		goto out;
 	}
 
-	/* BPF programs only allowed to set retval to 0, not some
-	 * arbitrary value.
-	 */
-	if (ctx.retval != 0 && ctx.retval != retval) {
-		ret = -EFAULT;
-		goto out;
-	}
-
 	if (ctx.optlen != 0) {
 		if (copy_to_user(optval, ctx.optval, ctx.optlen) ||
 		    put_user(ctx.optlen, optlen)) {
@@ -1580,8 +1573,6 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 		}
 	}
 
-	ret = ctx.retval;
-
 out:
 	sockopt_free_buf(&ctx, &buf);
 	return ret;
@@ -1596,10 +1587,10 @@ int __cgroup_bpf_run_filter_getsockopt_kern(struct sock *sk, int level,
 		.sk = sk,
 		.level = level,
 		.optname = optname,
-		.retval = retval,
 		.optlen = *optlen,
 		.optval = optval,
 		.optval_end = optval + *optlen,
+		.current_task = current,
 	};
 	int ret;
 
@@ -1612,25 +1603,19 @@ int __cgroup_bpf_run_filter_getsockopt_kern(struct sock *sk, int level,
 	 */
 
 	ret = BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[CGROUP_GETSOCKOPT],
-				    &ctx, bpf_prog_run);
-	if (ret)
+				    &ctx, bpf_prog_run, retval);
+	if (ret < 0)
 		return ret;
 
 	if (ctx.optlen > *optlen)
 		return -EFAULT;
 
-	/* BPF programs only allowed to set retval to 0, not some
-	 * arbitrary value.
-	 */
-	if (ctx.retval != 0 && ctx.retval != retval)
-		return -EFAULT;
-
 	/* BPF programs can shrink the buffer, export the modifications.
 	 */
 	if (ctx.optlen != 0)
 		*optlen = ctx.optlen;
 
-	return ctx.retval;
+	return ret;
 }
 #endif
 
@@ -2046,10 +2031,39 @@ static u32 cg_sockopt_convert_ctx_access(enum bpf_access_type type,
 			*insn++ = CG_SOCKOPT_ACCESS_FIELD(BPF_LDX_MEM, optlen);
 		break;
 	case offsetof(struct bpf_sockopt, retval):
-		if (type == BPF_WRITE)
-			*insn++ = CG_SOCKOPT_ACCESS_FIELD(BPF_STX_MEM, retval);
-		else
-			*insn++ = CG_SOCKOPT_ACCESS_FIELD(BPF_LDX_MEM, retval);
+		BUILD_BUG_ON(offsetof(struct bpf_cg_run_ctx, run_ctx) != 0);
+
+		if (type == BPF_WRITE) {
+			int treg = BPF_REG_9;
+
+			if (si->src_reg == treg || si->dst_reg == treg)
+				--treg;
+			if (si->src_reg == treg || si->dst_reg == treg)
+				--treg;
+			*insn++ = BPF_STX_MEM(BPF_DW, si->dst_reg, treg,
+					      offsetof(struct bpf_sockopt_kern, tmp_reg));
+			*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_sockopt_kern, current_task),
+					      treg, si->dst_reg,
+					      offsetof(struct bpf_sockopt_kern, current_task));
+			*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct task_struct, bpf_ctx),
+					      treg, treg,
+					      offsetof(struct task_struct, bpf_ctx));
+			*insn++ = BPF_STX_MEM(BPF_FIELD_SIZEOF(struct bpf_cg_run_ctx, retval),
+					      treg, si->src_reg,
+					      offsetof(struct bpf_cg_run_ctx, retval));
+			*insn++ = BPF_LDX_MEM(BPF_DW, treg, si->dst_reg,
+					      offsetof(struct bpf_sockopt_kern, tmp_reg));
+		} else {
+			*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_sockopt_kern, current_task),
+					      si->dst_reg, si->src_reg,
+					      offsetof(struct bpf_sockopt_kern, current_task));
+			*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct task_struct, bpf_ctx),
+					      si->dst_reg, si->dst_reg,
+					      offsetof(struct task_struct, bpf_ctx));
+			*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_cg_run_ctx, retval),
+					      si->dst_reg, si->dst_reg,
+					      offsetof(struct bpf_cg_run_ctx, retval));
+		}
 		break;
 	case offsetof(struct bpf_sockopt, optval):
 		*insn++ = CG_SOCKOPT_ACCESS_FIELD(BPF_LDX_MEM, optval);
-- 
2.34.1.448.ga2b2bfdf31-goog

