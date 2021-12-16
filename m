Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316F34767AD
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 03:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhLPCEs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 21:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbhLPCEs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Dec 2021 21:04:48 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BD4C061574
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 18:04:48 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id j3-20020a634a43000000b00325af3ab5f0so13266173pgl.11
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 18:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hpajZC+Iken1a6jZ5x/tLt1mGvLz36389UVAEdpIc/M=;
        b=aBSUnXoduizyACxR4bDMPXBwPHsAF/FRjlml11Q3w6cVMgIeVFSZ46mCqLB/lOixXf
         80lX9DLt+uRpDoCZaXEqRcx3rTR508nMJrbP8XLvvB9Vr5WKolovNy9GShOZEu4hR09O
         n2KcLnSV/5r4Y0j8yspEoZQ8pwcZRjhSWlZZQHXiZ58z7lMkVP30zJFrV+rDFe1ileZY
         LGNqTL9GyeJZCw2aoGN7AS/NPPDpxyb7Bnca8yTmzebw+H9d5g0eJdL6Vwr6Q29z2RSN
         0+3fGiO2nis/OHhDaSQJ7HO0FFNo4K8g+QdpFZIPkHyuLyG/dvr769keT2HVA0cnUQHX
         IGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hpajZC+Iken1a6jZ5x/tLt1mGvLz36389UVAEdpIc/M=;
        b=16P9G14/N7b2psyq7XNF7OgqDDllAAi/aaJAYSBYT6KKSkmyiRZpaU0XC3ypxmqiKV
         5Ge+vGSkEGcr5oluUTowVvzbKYbeeUJC+fMFMR0dQoCvJqI7WBT5Cxj1FRxBTEq4u8H6
         73EHmqsWO42f9d3wn7t3vsre3NLMEzcqhdevsPoSfja+677CdBuc36tdZtOxxfNgTQLd
         kYRCfUdhNvdYduuU4+QtuO6v1wFhPsphgdy3DDMmudZnwH1kYTdmtwYinkp3xm3GBsSI
         +Dea7ru8NT5+bsQfUcjrXyAcRdP5Ybiu9Qgj+Xh3WGZ9ZyUir85SknH1BnyXBaj2O3D6
         cjmA==
X-Gm-Message-State: AOAM530/FG+kSgRPcVG5Lv4NXPtVdA8vRwC6r35JqvGT3axPJewDHBSl
        d7q5GLlEwHFpeK4vdJadvb06Poo/EPRfvlZqTlRAg9V14BbzuLOa6oS71juFpvaqMkVZ7RJOmAg
        k9lGWohI4MZfumdhKqhjyjlVO6UB6opXfqvPQea7ZWjzCG2yjCu9uGnEPmPNyIQQ=
X-Google-Smtp-Source: ABdhPJz/MWGiNE2Nx2ry+Dy1D86YmPLZu/TdZ/9MkgQNPVuTn7cvQWPpbWHoBMeTflPsAYcg7y9dA8EnpeOrAg==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a17:902:bb87:b0:148:a2e8:2798 with SMTP
 id m7-20020a170902bb8700b00148a2e82798mr7172864pls.159.1639620287190; Wed, 15
 Dec 2021 18:04:47 -0800 (PST)
Date:   Thu, 16 Dec 2021 02:04:25 +0000
In-Reply-To: <cover.1639619851.git.zhuyifei@google.com>
Message-Id: <788abcdca55886d1f43274c918eaa9f792a9f33b.1639619851.git.zhuyifei@google.com>
Mime-Version: 1.0
References: <cover.1639619851.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v2 bpf-next 1/5] bpf: Make BPF_PROG_RUN_ARRAY return -err
 instead of allow boolean
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

Right now BPF_PROG_RUN_ARRAY and related macros return 1 or 0
for whether the prog array allows or rejects whatever is being
hooked. The caller of these macros then return -EPERM or continue
processing based on thw macro's return value. Unforunately this is
inflexible, since -EPERM is the only err that can be returned.

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
index 965fffaf0308..0f55f79b85b1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1225,7 +1225,7 @@ static inline void bpf_reset_run_ctx(struct bpf_run_ctx *old_ctx)
 
 typedef u32 (*bpf_prog_run_fn)(const struct bpf_prog *prog, const void *ctx);
 
-static __always_inline u32
+static __always_inline int
 BPF_PROG_RUN_ARRAY_CG_FLAGS(const struct bpf_prog_array __rcu *array_rcu,
 			    const void *ctx, bpf_prog_run_fn run_prog,
 			    u32 *ret_flags)
@@ -1235,7 +1235,7 @@ BPF_PROG_RUN_ARRAY_CG_FLAGS(const struct bpf_prog_array __rcu *array_rcu,
 	const struct bpf_prog_array *array;
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_cg_run_ctx run_ctx;
-	u32 ret = 1;
+	int ret = 0;
 	u32 func_ret;
 
 	migrate_disable();
@@ -1246,7 +1246,8 @@ BPF_PROG_RUN_ARRAY_CG_FLAGS(const struct bpf_prog_array __rcu *array_rcu,
 	while ((prog = READ_ONCE(item->prog))) {
 		run_ctx.prog_item = item;
 		func_ret = run_prog(prog, ctx);
-		ret &= (func_ret & 1);
+		if (!(func_ret & 1))
+			ret = -EPERM;
 		*(ret_flags) |= (func_ret >> 1);
 		item++;
 	}
@@ -1256,7 +1257,7 @@ BPF_PROG_RUN_ARRAY_CG_FLAGS(const struct bpf_prog_array __rcu *array_rcu,
 	return ret;
 }
 
-static __always_inline u32
+static __always_inline int
 BPF_PROG_RUN_ARRAY_CG(const struct bpf_prog_array __rcu *array_rcu,
 		      const void *ctx, bpf_prog_run_fn run_prog)
 {
@@ -1265,7 +1266,7 @@ BPF_PROG_RUN_ARRAY_CG(const struct bpf_prog_array __rcu *array_rcu,
 	const struct bpf_prog_array *array;
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_cg_run_ctx run_ctx;
-	u32 ret = 1;
+	int ret = 0;
 
 	migrate_disable();
 	rcu_read_lock();
@@ -1274,7 +1275,8 @@ BPF_PROG_RUN_ARRAY_CG(const struct bpf_prog_array __rcu *array_rcu,
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 	while ((prog = READ_ONCE(item->prog))) {
 		run_ctx.prog_item = item;
-		ret &= run_prog(prog, ctx);
+		if (!run_prog(prog, ctx))
+			ret = -EPERM;
 		item++;
 	}
 	bpf_reset_run_ctx(old_run_ctx);
@@ -1342,7 +1344,7 @@ BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
 		u32 _ret;				\
 		_ret = BPF_PROG_RUN_ARRAY_CG_FLAGS(array, ctx, func, &_flags); \
 		_cn = _flags & BPF_RET_SET_CN;		\
-		if (_ret)				\
+		if (!_ret)				\
 			_ret = (_cn ? NET_XMIT_CN : NET_XMIT_SUCCESS);	\
 		else					\
 			_ret = (_cn ? NET_XMIT_DROP : -EPERM);		\
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 43eb3501721b..53ce23c00204 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1080,7 +1080,6 @@ int __cgroup_bpf_run_filter_skb(struct sock *sk,
 	} else {
 		ret = BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[atype], skb,
 					    __bpf_prog_run_save_cb);
-		ret = (ret == 1 ? 0 : -EPERM);
 	}
 	bpf_restore_data_end(skb, saved_data_end);
 	__skb_pull(skb, offset);
@@ -1107,10 +1106,9 @@ int __cgroup_bpf_run_filter_sk(struct sock *sk,
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
 
@@ -1142,7 +1140,6 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
 	};
 	struct sockaddr_storage unspec;
 	struct cgroup *cgrp;
-	int ret;
 
 	/* Check socket family since not all sockets represent network
 	 * endpoint (e.g. AF_UNIX).
@@ -1156,10 +1153,8 @@ int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
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
 
@@ -1184,11 +1179,9 @@ int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
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
 
@@ -1201,15 +1194,15 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
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
@@ -1350,7 +1343,7 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 		kfree(ctx.new_val);
 	}
 
-	return ret == 1 ? 0 : -EPERM;
+	return ret;
 }
 
 #ifdef CONFIG_NET
@@ -1455,10 +1448,8 @@ int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int *level,
 				    &ctx, bpf_prog_run);
 	release_sock(sk);
 
-	if (!ret) {
-		ret = -EPERM;
+	if (ret)
 		goto out;
-	}
 
 	if (ctx.optlen == -1) {
 		/* optlen set to -1, bypass kernel */
@@ -1565,10 +1556,8 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
 				    &ctx, bpf_prog_run);
 	release_sock(sk);
 
-	if (!ret) {
-		ret = -EPERM;
+	if (ret)
 		goto out;
-	}
 
 	if (ctx.optlen > max_optlen || ctx.optlen < 0) {
 		ret = -EFAULT;
@@ -1624,8 +1613,8 @@ int __cgroup_bpf_run_filter_getsockopt_kern(struct sock *sk, int level,
 
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
2.34.1.173.g76aa8bc2d0-goog

