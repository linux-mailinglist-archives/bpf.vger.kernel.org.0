Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9599642421B
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 18:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhJFQEx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 12:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhJFQEx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 12:04:53 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029F9C061746
        for <bpf@vger.kernel.org>; Wed,  6 Oct 2021 09:03:01 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id on6so2538644pjb.5
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 09:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yZdv+mAmPSmvLYFkjWi3ag6HXOBraTEgeD8AmWgufz8=;
        b=cjZg8t+KNGlm5j44cencvNt7dD9oLDy0oMtQARmsvq1a91oZDE/U/wmrvP71zPXg02
         DH5mbfKn7dQAuJuQkltmHbNIuXvxGKU1brLkExF/uCnxLe2qp0xCt0GFfdpW7pEADtpD
         Tk4pbVs/Rg3t+w6Wr8hspTYFOSjHRbRDd8b2odH26uwBruh5YMGAKqgEeiOGW5M7Gun6
         YkOVGIaGFaLAENp2NdYa97x02I4fp2SijWzjK/cJ16tPTY+3m5ct24suTBbrtVVql1I+
         vHwrkq6G5Wkk0tcN7z2c4i0ew7c0i7AB0cgHga9jS4prbT44+Rpy8Ujn+DpU+5S5ZxLN
         QvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yZdv+mAmPSmvLYFkjWi3ag6HXOBraTEgeD8AmWgufz8=;
        b=HqfJgB9sqkbiOAjTZTCw+gEJcPXioxeUc1VeMESgM6ct2mW9apdhbDynb0McK7AuWC
         uwlD701uFGxzgrJJMTowQt+nLyTpVGimKpinb4rI0J7cc0O8TZEDvi/o7Ncio1g/tcip
         rz7Mius+z65AME9D5RXtvlbdTfGYZ+kiKGDb+pHqeGWZpIcBc2F4/L+Sc+lsFktMhvvO
         z9dFZ+lMLqLA3ctFQeUN+6XHYc83ONJmu4mrDk7rTDQf+KGbuOX8m/rwl7XMvvwKKZRx
         uPtc4Stw7OTVROdw1nuglZ3vqqjt9foLF1qfnxe478p8sgk1kiVsbblYTuNUKmkaQCgP
         mXTw==
X-Gm-Message-State: AOAM532jlO6+k9LRf8KkbexhzvjnJIuz+mFHJDxRKe+ROCzvkl8WY8UT
        zt6WerwlIlCzsQvI/8AbxH1A8Sk55Dw=
X-Google-Smtp-Source: ABdhPJyBZJYpECdhZcQ48SzWGnJOqQL2kf8ELvyDR5VgFPfNzBZcThteDehBvbuL69de+qujKrOe0A==
X-Received: by 2002:a17:90a:9f95:: with SMTP id o21mr11693272pjp.21.1633536180235;
        Wed, 06 Oct 2021 09:03:00 -0700 (PDT)
Received: from localhost.localdomain ([98.47.144.235])
        by smtp.gmail.com with ESMTPSA id x19sm20906098pfn.105.2021.10.06.09.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:02:59 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf-next 1/3] bpf: Make BPF_PROG_RUN_ARRAY return -errno instead of allow boolean
Date:   Wed,  6 Oct 2021 09:02:40 -0700
Message-Id: <f90f33fb1eacfaf69874e3c769f0cd81ada61e8a.1633535940.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1633535940.git.zhuyifei@google.com>
References: <cover.1633535940.git.zhuyifei@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <zhuyifei@google.com>

Right now BPF_PROG_RUN_ARRAY and related macros return 1 or 0
for whether the prog array allows or rejects whatever is being
hooked. The caller of these macros then return -EPERM or continue
processing based on thw macro's return value. Unforunately this is
inflexible, since -EPERM is the only errno that can be returned.

This patch should be a no-op; it prepares for the next patch. The
returning of the -EPERM is moved to inside the macros, so the outer
functions are directly returning what the macros returned if they
are non-zero.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Reviewed-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf.h      | 16 +++++++++-------
 kernel/bpf/cgroup.c      | 41 +++++++++++++++-------------------------
 security/device_cgroup.c |  2 +-
 3 files changed, 25 insertions(+), 34 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1c7fd7c4c6d3..938885562d68 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1187,7 +1187,7 @@ static inline void bpf_reset_run_ctx(struct bpf_run_ctx *old_ctx)
 
 typedef u32 (*bpf_prog_run_fn)(const struct bpf_prog *prog, const void *ctx);
 
-static __always_inline u32
+static __always_inline int
 BPF_PROG_RUN_ARRAY_CG_FLAGS(const struct bpf_prog_array __rcu *array_rcu,
 			    const void *ctx, bpf_prog_run_fn run_prog,
 			    u32 *ret_flags)
@@ -1197,7 +1197,7 @@ BPF_PROG_RUN_ARRAY_CG_FLAGS(const struct bpf_prog_array __rcu *array_rcu,
 	const struct bpf_prog_array *array;
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_cg_run_ctx run_ctx;
-	u32 ret = 1;
+	int ret = 0;
 	u32 func_ret;
 
 	migrate_disable();
@@ -1208,7 +1208,8 @@ BPF_PROG_RUN_ARRAY_CG_FLAGS(const struct bpf_prog_array __rcu *array_rcu,
 	while ((prog = READ_ONCE(item->prog))) {
 		run_ctx.prog_item = item;
 		func_ret = run_prog(prog, ctx);
-		ret &= (func_ret & 1);
+		if (!(func_ret & 1))
+			ret = -EPERM;
 		*(ret_flags) |= (func_ret >> 1);
 		item++;
 	}
@@ -1218,7 +1219,7 @@ BPF_PROG_RUN_ARRAY_CG_FLAGS(const struct bpf_prog_array __rcu *array_rcu,
 	return ret;
 }
 
-static __always_inline u32
+static __always_inline int
 BPF_PROG_RUN_ARRAY_CG(const struct bpf_prog_array __rcu *array_rcu,
 		      const void *ctx, bpf_prog_run_fn run_prog)
 {
@@ -1227,7 +1228,7 @@ BPF_PROG_RUN_ARRAY_CG(const struct bpf_prog_array __rcu *array_rcu,
 	const struct bpf_prog_array *array;
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_cg_run_ctx run_ctx;
-	u32 ret = 1;
+	int ret = 0;
 
 	migrate_disable();
 	rcu_read_lock();
@@ -1236,7 +1237,8 @@ BPF_PROG_RUN_ARRAY_CG(const struct bpf_prog_array __rcu *array_rcu,
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 	while ((prog = READ_ONCE(item->prog))) {
 		run_ctx.prog_item = item;
-		ret &= run_prog(prog, ctx);
+		if (!run_prog(prog, ctx))
+			ret = -EPERM;
 		item++;
 	}
 	bpf_reset_run_ctx(old_run_ctx);
@@ -1304,7 +1306,7 @@ BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
 		u32 _ret;				\
 		_ret = BPF_PROG_RUN_ARRAY_CG_FLAGS(array, ctx, func, &_flags); \
 		_cn = _flags & BPF_RET_SET_CN;		\
-		if (_ret)				\
+		if (!_ret)				\
 			_ret = (_cn ? NET_XMIT_CN : NET_XMIT_SUCCESS);	\
 		else					\
 			_ret = (_cn ? NET_XMIT_DROP : -EPERM);		\
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 03145d45e3d5..5efe2588575e 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1044,7 +1044,6 @@ int __cgroup_bpf_run_filter_skb(struct sock *sk,
 	} else {
 		ret = BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[atype], skb,
 					    __bpf_prog_run_save_cb);
-		ret = (ret == 1 ? 0 : -EPERM);
 	}
 	bpf_restore_data_end(skb, saved_data_end);
 	__skb_pull(skb, offset);
@@ -1071,10 +1070,9 @@ int __cgroup_bpf_run_filter_sk(struct sock *sk,
 			       enum cgroup_bpf_attach_type atype)
 {
 	struct cgroup *cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
-	int ret;
 
-	ret = BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[atype], sk, bpf_prog_run);
-	return ret == 1 ? 0 : -EPERM;
+	return BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[atype], sk,
+				     bpf_prog_run);
 }
 EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
 
@@ -1106,7 +1104,6 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 	};
 	struct sockaddr_storage unspec;
 	struct cgroup *cgrp;
-	int ret;
 
 	/* Check socket family since not all sockets represent network
 	 * endpoint (e.g. AF_UNIX).
@@ -1120,10 +1117,8 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 	}
 
 	cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
-	ret = BPF_PROG_RUN_ARRAY_CG_FLAGS(cgrp->bpf.effective[atype], &ctx,
-				          bpf_prog_run, flags);
-
-	return ret == 1 ? 0 : -EPERM;
+	return BPF_PROG_RUN_ARRAY_CG_FLAGS(cgrp->bpf.effective[atype], &ctx,
+					   bpf_prog_run, flags);
 }
 EXPORT_SYMBOL(__cgroup_bpf_run_filter_sock_addr);
 
@@ -1148,11 +1143,9 @@ int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
 				     enum cgroup_bpf_attach_type atype)
 {
 	struct cgroup *cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
-	int ret;
 
-	ret = BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[atype], sock_ops,
-				    bpf_prog_run);
-	return ret == 1 ? 0 : -EPERM;
+	return BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[atype], sock_ops,
+				     bpf_prog_run);
 }
 EXPORT_SYMBOL(__cgroup_bpf_run_filter_sock_ops);
 
@@ -1165,15 +1158,15 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 		.major = major,
 		.minor = minor,
 	};
-	int allow;
+	int ret;
 
 	rcu_read_lock();
 	cgrp = task_dfl_cgroup(current);
-	allow = BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[atype], &ctx,
-				      bpf_prog_run);
+	ret = BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[atype], &ctx,
+				    bpf_prog_run);
 	rcu_read_unlock();
 
-	return !allow;
+	return ret;
 }
 
 static const struct bpf_func_proto *
@@ -1314,7 +1307,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 		kfree(ctx.new_val);
 	}
 
-	return ret == 1 ? 0 : -EPERM;
+	return ret;
 }
 
 #ifdef CONFIG_NET
@@ -1419,10 +1412,8 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 				    &ctx, bpf_prog_run);
 	release_sock(sk);
 
-	if (!ret) {
-		ret = -EPERM;
+	if (ret)
 		goto out;
-	}
 
 	if (ctx.optlen == -1) {
 		/* optlen set to -1, bypass kernel */
@@ -1529,10 +1520,8 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 				    &ctx, bpf_prog_run);
 	release_sock(sk);
 
-	if (!ret) {
-		ret = -EPERM;
+	if (ret)
 		goto out;
-	}
 
 	if (ctx.optlen > max_optlen || ctx.optlen < 0) {
 		ret = -EFAULT;
@@ -1588,8 +1577,8 @@ int __cgroup_bpf_run_filter_getsockopt_kern(struct sock *sk, int level,
 
 	ret = BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[CGROUP_GETSOCKOPT],
 				    &ctx, bpf_prog_run);
-	if (!ret)
-		return -EPERM;
+	if (ret)
+		return ret;
 
 	if (ctx.optlen > *optlen)
 		return -EFAULT;
diff --git a/security/device_cgroup.c b/security/device_cgroup.c
index 04375df52fc9..cd15c7994d34 100644
--- a/security/device_cgroup.c
+++ b/security/device_cgroup.c
@@ -837,7 +837,7 @@ int devcgroup_check_permission(short type, u32 major, u32 minor, short access)
 	int rc = BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(type, major, minor, access);
 
 	if (rc)
-		return -EPERM;
+		return rc;
 
 	#ifdef CONFIG_CGROUP_DEVICE
 	return devcgroup_legacy_check_permission(type, major, minor, access);
-- 
2.33.0

