Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA124846D1
	for <lists+bpf@lfdr.de>; Tue,  4 Jan 2022 18:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbiADRP3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jan 2022 12:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbiADRPV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Jan 2022 12:15:21 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F33C0617A0
        for <bpf@vger.kernel.org>; Tue,  4 Jan 2022 09:15:21 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id k1-20020a63d841000000b003417384b156so13806877pgj.13
        for <bpf@vger.kernel.org>; Tue, 04 Jan 2022 09:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uW+yViWLPTyhjKX9mlEToYSquWG+HWI30DcEkWU8jCI=;
        b=NeBfoD62SipXW9VOJW4XTND/styiBFz+9k0+tKp5Ci82DPf61yR5qLJMH2eOZvPsZB
         +6dD6EnFQ+3Uhlbf94xNzUj7dLDbru50Lmyyit1wtUhfmiSLWhF8hMeuS71x01oaNOMY
         nUOLDD0e0K2kOzk9BOpAekANl9SUnKSPvXasLJmg2mTd97nnnpeh4b+p+K0Ik1B8kmV4
         EmJVSxJqoUKAqNnvHkb08W58yRErK8bpPhOCSSm0YR7i5S+fKeiNGKFXxBjk58hNYuB2
         EXREznwgFVcFsFQpRX0msocw1b9EtMCFb1CMqmUmNlTqomaK1qUm+XvqKH5Fr218vYlq
         UbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uW+yViWLPTyhjKX9mlEToYSquWG+HWI30DcEkWU8jCI=;
        b=PJ2m3i3y/Mr5BPY0FUTMH5wZMyvEQlV9u/chWUQexVG/Nwsmf+z0cJiNpoMC0BseQf
         gBD7h0aVxojWUP65pVraJsRxyh1CXHdkh7l567AFz4JLgklU/J8I5ORDws7JkHLHdOeg
         d48Wt15yn9DTPvFy56g1lGkS/N+yQSg/OXIhNCGISxdubUjh6YIuSEQ4oYIEZFeO17c0
         5qVxgifhZrzBpk/DIrIDBpERz2kD8ymybeRUr4Mi1TeT6guRCfM8cZLW6WO75GeUNUMZ
         54T47DAwhAAxCNnzE2nRF4cpY2BDXvXuAbYrCEBPl0ZYioZ74Yd6PKkMZXn4j43ol2qr
         vKUA==
X-Gm-Message-State: AOAM530VUKIlalYMk1S+grwQYVyu6vRa9iwMLv8aX/8jgPiwFGvbfs++
        cXVb8tzoVD8SKO6CbUJAcrtlXm2TdmoKa4pGRW9t2zlFkQIEDQjIfpIDtnMg2wvZMOHlpzEWL9l
        4CQi981wNWGPgUR3nqX0+uMoZl52jrP2890ln4LS6il0JpwCXFAYCKQFtascJXEc=
X-Google-Smtp-Source: ABdhPJzGX4Fb/jywoT0SxeNDhwXRrutUxKMYnDiMHOyIjHnSllQHUG/i0gJ/FAxhHoFCsLIyJUJs9nXRwaESHg==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a17:902:ea02:b0:149:927:7e66 with SMTP id
 s2-20020a170902ea0200b0014909277e66mr49105068plg.70.1641316520806; Tue, 04
 Jan 2022 09:15:20 -0800 (PST)
Date:   Tue,  4 Jan 2022 17:15:02 +0000
In-Reply-To: <cover.1641316155.git.zhuyifei@google.com>
Message-Id: <eaf15a07ca592ad799b51cee4fc51ae8f41ca429.1641316155.git.zhuyifei@google.com>
Mime-Version: 1.0
References: <cover.1641316155.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 bpf-next 1/4] bpf: Make BPF_PROG_RUN_ARRAY return -err
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
index 26753139d5b4..37eebb703923 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1278,7 +1278,7 @@ static inline void bpf_reset_run_ctx(struct bpf_run_ctx *old_ctx)
 
 typedef u32 (*bpf_prog_run_fn)(const struct bpf_prog *prog, const void *ctx);
 
-static __always_inline u32
+static __always_inline int
 BPF_PROG_RUN_ARRAY_CG_FLAGS(const struct bpf_prog_array __rcu *array_rcu,
 			    const void *ctx, bpf_prog_run_fn run_prog,
 			    u32 *ret_flags)
@@ -1288,7 +1288,7 @@ BPF_PROG_RUN_ARRAY_CG_FLAGS(const struct bpf_prog_array __rcu *array_rcu,
 	const struct bpf_prog_array *array;
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_cg_run_ctx run_ctx;
-	u32 ret = 1;
+	int ret = 0;
 	u32 func_ret;
 
 	migrate_disable();
@@ -1299,7 +1299,8 @@ BPF_PROG_RUN_ARRAY_CG_FLAGS(const struct bpf_prog_array __rcu *array_rcu,
 	while ((prog = READ_ONCE(item->prog))) {
 		run_ctx.prog_item = item;
 		func_ret = run_prog(prog, ctx);
-		ret &= (func_ret & 1);
+		if (!(func_ret & 1))
+			ret = -EPERM;
 		*(ret_flags) |= (func_ret >> 1);
 		item++;
 	}
@@ -1309,7 +1310,7 @@ BPF_PROG_RUN_ARRAY_CG_FLAGS(const struct bpf_prog_array __rcu *array_rcu,
 	return ret;
 }
 
-static __always_inline u32
+static __always_inline int
 BPF_PROG_RUN_ARRAY_CG(const struct bpf_prog_array __rcu *array_rcu,
 		      const void *ctx, bpf_prog_run_fn run_prog)
 {
@@ -1318,7 +1319,7 @@ BPF_PROG_RUN_ARRAY_CG(const struct bpf_prog_array __rcu *array_rcu,
 	const struct bpf_prog_array *array;
 	struct bpf_run_ctx *old_run_ctx;
 	struct bpf_cg_run_ctx run_ctx;
-	u32 ret = 1;
+	int ret = 0;
 
 	migrate_disable();
 	rcu_read_lock();
@@ -1327,7 +1328,8 @@ BPF_PROG_RUN_ARRAY_CG(const struct bpf_prog_array __rcu *array_rcu,
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 	while ((prog = READ_ONCE(item->prog))) {
 		run_ctx.prog_item = item;
-		ret &= run_prog(prog, ctx);
+		if (!run_prog(prog, ctx))
+			ret = -EPERM;
 		item++;
 	}
 	bpf_reset_run_ctx(old_run_ctx);
@@ -1395,7 +1397,7 @@ BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
 		u32 _ret;				\
 		_ret = BPF_PROG_RUN_ARRAY_CG_FLAGS(array, ctx, func, &_flags); \
 		_cn = _flags & BPF_RET_SET_CN;		\
-		if (_ret)				\
+		if (!_ret)				\
 			_ret = (_cn ? NET_XMIT_CN : NET_XMIT_SUCCESS);	\
 		else					\
 			_ret = (_cn ? NET_XMIT_DROP : -EPERM);		\
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 514b4681a90a..386155d279b3 100644
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
index 842889f3dcb7..a9f8c63a96d1 100644
--- a/security/device_cgroup.c
+++ b/security/device_cgroup.c
@@ -838,7 +838,7 @@ int devcgroup_check_permission(short type, u32 major, u32 minor, short access)
 	int rc = BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(type, major, minor, access);
 
 	if (rc)
-		return -EPERM;
+		return rc;
 
 	#ifdef CONFIG_CGROUP_DEVICE
 	return devcgroup_legacy_check_permission(type, major, minor, access);
-- 
2.34.1.448.ga2b2bfdf31-goog

