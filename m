Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C924B351ED
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2019 23:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfFDVfb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jun 2019 17:35:31 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:45154 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfFDVfb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Jun 2019 17:35:31 -0400
Received: by mail-qk1-f202.google.com with SMTP id u129so4774690qkd.12
        for <bpf@vger.kernel.org>; Tue, 04 Jun 2019 14:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=leHIpZiTtzNd2ta5O8MnYMVJvJXL9lY/JN8jsY2prSo=;
        b=Owydl+T/+V/MRAVa6vXaFTILQZ4KryO3Mq9evKC12QlK8EmUDMazyt5K/Y2n9dnWPh
         b2yPOeOBoYBa03iGMhVphWCnbTV3NqLKlUqPa4q7/GKZP03JW0yu+RzT1Ha3T2dT24fx
         eHG8BPraQWssqUTq7uKGyoxgCeAS/gH+7pfyUjaMCd/ziV9CUNnyIKvcApDE4DX/aEu5
         sPle802eB5Pc5Ff74e6qIs+N71zob2LCvuVINX2/95/5fTlZ7Ex6XOG64L8n61IU97Yd
         xJg8Gg3fxu2HGW4PwE+LaExc6gyaDfViSchFg2BPldafhGUzX+xEVBIRJVPfwZTJQyVP
         xu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=leHIpZiTtzNd2ta5O8MnYMVJvJXL9lY/JN8jsY2prSo=;
        b=CJowtIV6tM9+/K0gsmVcyEoetlVVBgcSzpKn/TCgXJ3J8sWuanPYdj61pgwcoxdtpY
         TGrSqgbXDTW0wxZwT2SacffdiSd9GBYN6CoJKrUQTvkoBiu4m5ozFv1nRmKrdGFYrgC6
         LDmk0W/08QSYKaScKLxJ6oM5QY6puUU4sflv8XIuHlwGv6nJUlRg0fUPw3tHwPhtqiT7
         kQKMW91qP0WJubXJaymmYWm9yXE+LgYzFE6EwopbRtiukiEaqdqC3/ccVy4A85N+/LZQ
         cuMVbu/vIsVRBeCrQI7kjT7BwlyqODTEeznRD6lJkJrUB8M6sDEHGdHUnfSUPV2pUsJY
         7tfw==
X-Gm-Message-State: APjAAAXb3s/V+1j+XiKbt/o0PyM/bpzaAVAJVbtSzvUwwR4TqBaBiexV
        iS4Zj2mc0W05S/UeiIXEg4C5b20=
X-Google-Smtp-Source: APXvYqw9daMy2byqxF1TPDliEHS5cgz385sMhbip39RcIEIGf6adWKhC8iTvUAwTBnkNlpiwdtelpCc=
X-Received: by 2002:a37:ea16:: with SMTP id t22mr29400322qkj.337.1559684129853;
 Tue, 04 Jun 2019 14:35:29 -0700 (PDT)
Date:   Tue,  4 Jun 2019 14:35:18 -0700
In-Reply-To: <20190604213524.76347-1-sdf@google.com>
Message-Id: <20190604213524.76347-2-sdf@google.com>
Mime-Version: 1.0
References: <20190604213524.76347-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH bpf-next 1/7] bpf: implement getsockopt and setsockopt hooks
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Implement new BPF_PROG_TYPE_CGROUP_SOCKOPT program type and
BPF_CGROUP_{G,S}ETSOCKOPT cgroup hooks.

BPF_CGROUP_SETSOCKOPT get a read-only view of the setsockopt arguments.
BPF_CGROUP_GETSOCKOPT can modify the supplied buffer.
Both of them reuse existing PTR_TO_PACKET{,_END} infrastructure.

The buffer memory is pre-allocated (because I don't think there is
a precedent for working with __user memory from bpf). This might be
slow to do for each {s,g}etsockopt call, that's why I've added
__cgroup_bpf_has_prog_array that exits early if there is nothing
attached to a cgroup. Note, however, that there is a race between
__cgroup_bpf_has_prog_array and BPF_PROG_RUN_ARRAY where cgroup
program layout might have changed; this should not be a problem
because in general there is a race between multiple calls to
{s,g}etsocktop and user adding/removing bpf progs from a cgroup.

By default, kernel code path is executed after the hook (to let
BPF handle only a subset of the options). There is new
bpf_sockopt_handled handler that returns control to the userspace
instead (bypassing the kernel handling).

The return code is either 1 (success) or 0 (EPERM).

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf-cgroup.h |  29 ++++
 include/linux/bpf.h        |   2 +
 include/linux/bpf_types.h  |   1 +
 include/linux/filter.h     |  19 +++
 include/uapi/linux/bpf.h   |  17 ++-
 kernel/bpf/cgroup.c        | 288 +++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c       |  19 +++
 kernel/bpf/verifier.c      |  12 ++
 net/core/filter.c          |   4 +-
 net/socket.c               |  18 +++
 10 files changed, 406 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index b631ee75762d..406f1ba82531 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -124,6 +124,13 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 				   loff_t *ppos, void **new_buf,
 				   enum bpf_attach_type type);
 
+int __cgroup_bpf_run_filter_setsockopt(struct sock *sock, int level,
+				       int optname, char __user *optval,
+				       unsigned int optlen);
+int __cgroup_bpf_run_filter_getsockopt(struct sock *sock, int level,
+				       int optname, char __user *optval,
+				       int __user *optlen);
+
 static inline enum bpf_cgroup_storage_type cgroup_storage_type(
 	struct bpf_map *map)
 {
@@ -280,6 +287,26 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
 	__ret;								       \
 })
 
+#define BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock, level, optname, optval, optlen)   \
+({									       \
+	int __ret = 0;							       \
+	if (cgroup_bpf_enabled)						       \
+		__ret = __cgroup_bpf_run_filter_setsockopt(sock, level,	       \
+							   optname, optval,    \
+							   optlen);	       \
+	__ret;								       \
+})
+
+#define BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock, level, optname, optval, optlen)   \
+({									       \
+	int __ret = 0;							       \
+	if (cgroup_bpf_enabled)						       \
+		__ret = __cgroup_bpf_run_filter_getsockopt(sock, level,	       \
+							   optname, optval,    \
+							   optlen);	       \
+	__ret;								       \
+})
+
 int cgroup_bpf_prog_attach(const union bpf_attr *attr,
 			   enum bpf_prog_type ptype, struct bpf_prog *prog);
 int cgroup_bpf_prog_detach(const union bpf_attr *attr,
@@ -349,6 +376,8 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
 #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(type,major,minor,access) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_SYSCTL(head,table,write,buf,count,pos,nbuf) ({ 0; })
+#define BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock, level, optname, optval, optlen) ({ 0; })
+#define BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock, level, optname, optval, optlen) ({ 0; })
 
 #define for_each_cgroup_storage_type(stype) for (; false; )
 
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e5a309e6a400..fb4e6ef5a971 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1054,6 +1054,8 @@ extern const struct bpf_func_proto bpf_spin_unlock_proto;
 extern const struct bpf_func_proto bpf_get_local_storage_proto;
 extern const struct bpf_func_proto bpf_strtol_proto;
 extern const struct bpf_func_proto bpf_strtoul_proto;
+extern const struct bpf_func_proto bpf_sk_fullsock_proto;
+extern const struct bpf_func_proto bpf_tcp_sock_proto;
 
 /* Shared helpers among cBPF and eBPF. */
 void bpf_user_rnd_init_once(void);
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 5a9975678d6f..eec5aeeeaf92 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -30,6 +30,7 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE, raw_tracepoint_writable)
 #ifdef CONFIG_CGROUP_BPF
 BPF_PROG_TYPE(BPF_PROG_TYPE_CGROUP_DEVICE, cg_dev)
 BPF_PROG_TYPE(BPF_PROG_TYPE_CGROUP_SYSCTL, cg_sysctl)
+BPF_PROG_TYPE(BPF_PROG_TYPE_CGROUP_SOCKOPT, cg_sockopt)
 #endif
 #ifdef CONFIG_BPF_LIRC_MODE2
 BPF_PROG_TYPE(BPF_PROG_TYPE_LIRC_MODE2, lirc_mode2)
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 43b45d6db36d..7a07fd2e14d3 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1199,4 +1199,23 @@ struct bpf_sysctl_kern {
 	u64 tmp_reg;
 };
 
+struct bpf_sockopt_kern {
+	struct sock	*sk;
+	s32		level;
+	s32		optname;
+	u32		optlen;
+	u8		*optval;
+	u8		*optval_end;
+
+	/* If true, BPF program had consumed the sockopt request.
+	 * Control is returned to the userspace (i.e. kernel doesn't
+	 * handle this option).
+	 */
+	bool		handled;
+
+	/* Small on-stack optval buffer to avoid small allocations.
+	 */
+	u8 buf[64];
+};
+
 #endif /* __LINUX_FILTER_H__ */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 7c6aef253173..b6c3891241ef 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -170,6 +170,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_FLOW_DISSECTOR,
 	BPF_PROG_TYPE_CGROUP_SYSCTL,
 	BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
+	BPF_PROG_TYPE_CGROUP_SOCKOPT,
 };
 
 enum bpf_attach_type {
@@ -192,6 +193,8 @@ enum bpf_attach_type {
 	BPF_LIRC_MODE2,
 	BPF_FLOW_DISSECTOR,
 	BPF_CGROUP_SYSCTL,
+	BPF_CGROUP_GETSOCKOPT,
+	BPF_CGROUP_SETSOCKOPT,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -2815,7 +2818,8 @@ union bpf_attr {
 	FN(strtoul),			\
 	FN(sk_storage_get),		\
 	FN(sk_storage_delete),		\
-	FN(send_signal),
+	FN(send_signal),		\
+	FN(sockopt_handled),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
@@ -3533,4 +3537,15 @@ struct bpf_sysctl {
 				 */
 };
 
+struct bpf_sockopt {
+	__bpf_md_ptr(struct bpf_sock *, sk);
+
+	__s32	level;
+	__s32	optname;
+
+	__u32	optlen;
+	__u32	optval;
+	__u32	optval_end;
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 1b65ab0df457..4ec99ea97023 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -18,6 +18,7 @@
 #include <linux/bpf.h>
 #include <linux/bpf-cgroup.h>
 #include <net/sock.h>
+#include <net/bpf_sk_storage.h>
 
 DEFINE_STATIC_KEY_FALSE(cgroup_bpf_enabled_key);
 EXPORT_SYMBOL(cgroup_bpf_enabled_key);
@@ -924,6 +925,142 @@ int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
 }
 EXPORT_SYMBOL(__cgroup_bpf_run_filter_sysctl);
 
+static bool __cgroup_bpf_has_prog_array(struct cgroup *cgrp,
+					enum bpf_attach_type attach_type)
+{
+	struct bpf_prog_array *prog_array;
+	int nr;
+
+	rcu_read_lock();
+	prog_array = rcu_dereference(cgrp->bpf.effective[attach_type]);
+	nr = bpf_prog_array_length(prog_array);
+	rcu_read_unlock();
+
+	return nr > 0;
+}
+
+static int sockopt_alloc_buf(struct bpf_sockopt_kern *ctx, int max_optlen)
+{
+	if (unlikely(max_optlen > PAGE_SIZE))
+		return -EINVAL;
+
+	if (likely(max_optlen <= sizeof(ctx->buf))) {
+		ctx->optval = ctx->buf;
+	} else {
+		ctx->optval = kzalloc(max_optlen, GFP_USER);
+		if (!ctx->optval)
+			return -ENOMEM;
+	}
+
+	ctx->optval_end = ctx->optval + max_optlen;
+	ctx->optlen = max_optlen;
+
+	return 0;
+}
+
+static void sockopt_free_buf(struct bpf_sockopt_kern *ctx)
+{
+	if (unlikely(ctx->optval != ctx->buf))
+		kfree(ctx->optval);
+}
+
+int __cgroup_bpf_run_filter_setsockopt(struct sock *sk, int level,
+				       int optname, char __user *optval,
+				       unsigned int optlen)
+{
+	struct cgroup *cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
+	struct bpf_sockopt_kern ctx = {
+		.sk = sk,
+		.level = level,
+		.optname = optname,
+	};
+	int ret;
+
+	/* Opportunistic check to see whether we have any BPF program
+	 * attached to the hook so we don't waste time allocating
+	 * memory and locking the socket.
+	 */
+	if (!__cgroup_bpf_has_prog_array(cgrp, BPF_CGROUP_SETSOCKOPT))
+		return 0;
+
+	ret = sockopt_alloc_buf(&ctx, optlen);
+	if (ret)
+		return ret;
+
+	if (copy_from_user(ctx.optval, optval, optlen) != 0) {
+		sockopt_free_buf(&ctx);
+		return -EFAULT;
+	}
+
+	lock_sock(sk);
+	ret = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[BPF_CGROUP_SETSOCKOPT],
+				 &ctx, BPF_PROG_RUN);
+	release_sock(sk);
+
+	sockopt_free_buf(&ctx);
+
+	if (!ret)
+		return -EPERM;
+
+	return ctx.handled ? 1 : 0;
+}
+EXPORT_SYMBOL(__cgroup_bpf_run_filter_setsockopt);
+
+int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
+				       int optname, char __user *optval,
+				       int __user *optlen)
+{
+	struct cgroup *cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
+	struct bpf_sockopt_kern ctx = {
+		.sk = sk,
+		.level = level,
+		.optname = optname,
+	};
+	int max_optlen;
+	char buf[64];
+	int ret;
+
+	/* Opportunistic check to see whether we have any BPF program
+	 * attached to the hook so we don't waste time allocating
+	 * memory and locking the socket.
+	 */
+	if (!__cgroup_bpf_has_prog_array(cgrp, BPF_CGROUP_GETSOCKOPT))
+		return 0;
+
+	if (get_user(max_optlen, optlen))
+		return -EFAULT;
+
+	ret = sockopt_alloc_buf(&ctx, max_optlen);
+	if (ret)
+		return ret;
+
+	lock_sock(sk);
+	ret = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[BPF_CGROUP_GETSOCKOPT],
+				 &ctx, BPF_PROG_RUN);
+	release_sock(sk);
+
+	if (ctx.optlen > max_optlen) {
+		sockopt_free_buf(&ctx);
+		return -EFAULT;
+	}
+
+	if (copy_to_user(optval, ctx.optval, ctx.optlen) != 0) {
+		sockopt_free_buf(&ctx);
+		return -EFAULT;
+	}
+
+	sockopt_free_buf(&ctx);
+
+	if (put_user(ctx.optlen, optlen))
+		return -EFAULT;
+
+	if (!ret)
+		return -EPERM;
+
+	return ctx.handled ? 1 : 0;
+}
+EXPORT_SYMBOL(__cgroup_bpf_run_filter_getsockopt);
+
 static ssize_t sysctl_cpy_dir(const struct ctl_dir *dir, char **bufp,
 			      size_t *lenp)
 {
@@ -1184,3 +1321,154 @@ const struct bpf_verifier_ops cg_sysctl_verifier_ops = {
 
 const struct bpf_prog_ops cg_sysctl_prog_ops = {
 };
+
+BPF_CALL_1(bpf_sockopt_handled, struct bpf_sockopt_kern *, ctx)
+{
+	ctx->handled = true;
+	return 1;
+}
+
+static const struct bpf_func_proto bpf_sockopt_handled_proto = {
+	.func		= bpf_sockopt_handled,
+	.gpl_only	= false,
+	.arg1_type      = ARG_PTR_TO_CTX,
+	.ret_type	= RET_INTEGER,
+};
+
+static const struct bpf_func_proto *
+cg_sockopt_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	case BPF_FUNC_sockopt_handled:
+		return &bpf_sockopt_handled_proto;
+	case BPF_FUNC_sk_fullsock:
+		return &bpf_sk_fullsock_proto;
+	case BPF_FUNC_sk_storage_get:
+		return &bpf_sk_storage_get_proto;
+	case BPF_FUNC_sk_storage_delete:
+		return &bpf_sk_storage_delete_proto;
+#ifdef CONFIG_INET
+	case BPF_FUNC_tcp_sock:
+		return &bpf_tcp_sock_proto;
+#endif
+	default:
+		return cgroup_base_func_proto(func_id, prog);
+	}
+}
+
+static bool cg_sockopt_is_valid_access(int off, int size,
+				       enum bpf_access_type type,
+				       const struct bpf_prog *prog,
+				       struct bpf_insn_access_aux *info)
+{
+	const int size_default = sizeof(__u32);
+
+	if (off < 0 || off >= sizeof(struct bpf_sockopt))
+		return false;
+
+	if (off % size != 0)
+		return false;
+
+	if (type == BPF_WRITE) {
+		switch (off) {
+		case offsetof(struct bpf_sockopt, optlen):
+			if (size != size_default)
+				return false;
+			return prog->expected_attach_type ==
+				BPF_CGROUP_GETSOCKOPT;
+		default:
+			return false;
+		}
+	}
+
+	switch (off) {
+	case offsetof(struct bpf_sockopt, sk):
+		if (size != sizeof(__u64))
+			return false;
+		info->reg_type = PTR_TO_SOCK_COMMON_OR_NULL;
+		break;
+	case bpf_ctx_range(struct bpf_sockopt, optval):
+		if (size != size_default)
+			return false;
+		info->reg_type = PTR_TO_PACKET;
+		break;
+	case bpf_ctx_range(struct bpf_sockopt, optval_end):
+		if (size != size_default)
+			return false;
+		info->reg_type = PTR_TO_PACKET_END;
+		break;
+	default:
+		if (size != size_default)
+			return false;
+		break;
+	}
+	return true;
+}
+
+static u32 cg_sockopt_convert_ctx_access(enum bpf_access_type type,
+					 const struct bpf_insn *si,
+					 struct bpf_insn *insn_buf,
+					 struct bpf_prog *prog,
+					 u32 *target_size)
+{
+	struct bpf_insn *insn = insn_buf;
+
+	switch (si->off) {
+	case offsetof(struct bpf_sockopt, sk):
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_sockopt_kern, sk),
+				      si->dst_reg, si->src_reg,
+				      offsetof(struct bpf_sockopt_kern, sk));
+		break;
+	case offsetof(struct bpf_sockopt, level):
+		*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
+				      bpf_target_off(struct bpf_sockopt_kern,
+						     level, 4, target_size));
+		break;
+	case offsetof(struct bpf_sockopt, optname):
+		*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
+				      bpf_target_off(struct bpf_sockopt_kern,
+						     optname, 4, target_size));
+		break;
+	case offsetof(struct bpf_sockopt, optlen):
+		if (type == BPF_WRITE)
+			*insn++ = BPF_STX_MEM(BPF_W, si->dst_reg, si->src_reg,
+					      bpf_target_off(struct bpf_sockopt_kern,
+							     optlen, 4, target_size));
+		else
+			*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
+					      bpf_target_off(struct bpf_sockopt_kern,
+							     optlen, 4, target_size));
+		break;
+	case offsetof(struct bpf_sockopt, optval):
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_sockopt_kern, optval),
+				      si->dst_reg, si->src_reg,
+				      offsetof(struct bpf_sockopt_kern, optval));
+		break;
+	case offsetof(struct bpf_sockopt, optval_end):
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_sockopt_kern, optval_end),
+				      si->dst_reg, si->src_reg,
+				      offsetof(struct bpf_sockopt_kern, optval_end));
+		break;
+	}
+
+	return insn - insn_buf;
+}
+
+static int cg_sockopt_get_prologue(struct bpf_insn *insn_buf,
+				   bool direct_write,
+				   const struct bpf_prog *prog)
+{
+	/* Nothing to do for sockopt argument. The data is kzalloc'ated.
+	 */
+	return 0;
+}
+
+const struct bpf_verifier_ops cg_sockopt_verifier_ops = {
+	.get_func_proto		= cg_sockopt_func_proto,
+	.is_valid_access	= cg_sockopt_is_valid_access,
+	.convert_ctx_access	= cg_sockopt_convert_ctx_access,
+	.gen_prologue		= cg_sockopt_get_prologue,
+};
+
+const struct bpf_prog_ops cg_sockopt_prog_ops = {
+};
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4c53cbd3329d..4ad2b5f1905f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1596,6 +1596,14 @@ bpf_prog_load_check_attach_type(enum bpf_prog_type prog_type,
 		default:
 			return -EINVAL;
 		}
+	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
+		switch (expected_attach_type) {
+		case BPF_CGROUP_SETSOCKOPT:
+		case BPF_CGROUP_GETSOCKOPT:
+			return 0;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return 0;
 	}
@@ -1846,6 +1854,7 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
 	switch (prog->type) {
 	case BPF_PROG_TYPE_CGROUP_SOCK:
 	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
+	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
 		return attach_type == prog->expected_attach_type ? 0 : -EINVAL;
 	case BPF_PROG_TYPE_CGROUP_SKB:
 		return prog->enforce_expected_attach_type &&
@@ -1916,6 +1925,10 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 	case BPF_CGROUP_SYSCTL:
 		ptype = BPF_PROG_TYPE_CGROUP_SYSCTL;
 		break;
+	case BPF_CGROUP_GETSOCKOPT:
+	case BPF_CGROUP_SETSOCKOPT:
+		ptype = BPF_PROG_TYPE_CGROUP_SOCKOPT;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1997,6 +2010,10 @@ static int bpf_prog_detach(const union bpf_attr *attr)
 	case BPF_CGROUP_SYSCTL:
 		ptype = BPF_PROG_TYPE_CGROUP_SYSCTL;
 		break;
+	case BPF_CGROUP_GETSOCKOPT:
+	case BPF_CGROUP_SETSOCKOPT:
+		ptype = BPF_PROG_TYPE_CGROUP_SOCKOPT;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -2031,6 +2048,8 @@ static int bpf_prog_query(const union bpf_attr *attr,
 	case BPF_CGROUP_SOCK_OPS:
 	case BPF_CGROUP_DEVICE:
 	case BPF_CGROUP_SYSCTL:
+	case BPF_CGROUP_GETSOCKOPT:
+	case BPF_CGROUP_SETSOCKOPT:
 		break;
 	case BPF_LIRC_MODE2:
 		return lirc_prog_query(attr, uattr);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5c2cb5bd84ce..b91fde10e721 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1717,6 +1717,18 @@ static bool may_access_direct_pkt_data(struct bpf_verifier_env *env,
 
 		env->seen_direct_write = true;
 		return true;
+
+	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
+		if (t == BPF_WRITE) {
+			if (env->prog->expected_attach_type ==
+			    BPF_CGROUP_GETSOCKOPT) {
+				env->seen_direct_write = true;
+				return true;
+			}
+			return false;
+		}
+		return true;
+
 	default:
 		return false;
 	}
diff --git a/net/core/filter.c b/net/core/filter.c
index 55bfc941d17a..4652c0a005ca 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -1835,7 +1835,7 @@ BPF_CALL_1(bpf_sk_fullsock, struct sock *, sk)
 	return sk_fullsock(sk) ? (unsigned long)sk : (unsigned long)NULL;
 }
 
-static const struct bpf_func_proto bpf_sk_fullsock_proto = {
+const struct bpf_func_proto bpf_sk_fullsock_proto = {
 	.func		= bpf_sk_fullsock,
 	.gpl_only	= false,
 	.ret_type	= RET_PTR_TO_SOCKET_OR_NULL,
@@ -5636,7 +5636,7 @@ BPF_CALL_1(bpf_tcp_sock, struct sock *, sk)
 	return (unsigned long)NULL;
 }
 
-static const struct bpf_func_proto bpf_tcp_sock_proto = {
+const struct bpf_func_proto bpf_tcp_sock_proto = {
 	.func		= bpf_tcp_sock,
 	.gpl_only	= false,
 	.ret_type	= RET_PTR_TO_TCP_SOCK_OR_NULL,
diff --git a/net/socket.c b/net/socket.c
index 72372dc5dd70..e8654f1f70e6 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2069,6 +2069,15 @@ static int __sys_setsockopt(int fd, int level, int optname,
 		if (err)
 			goto out_put;
 
+		err = BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock->sk, level, optname,
+						     optval, optlen);
+		if (err < 0) {
+			goto out_put;
+		} else if (err > 0) {
+			err = 0;
+			goto out_put;
+		}
+
 		if (level == SOL_SOCKET)
 			err =
 			    sock_setsockopt(sock, level, optname, optval,
@@ -2106,6 +2115,15 @@ static int __sys_getsockopt(int fd, int level, int optname,
 		if (err)
 			goto out_put;
 
+		err = BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock->sk, level, optname,
+						     optval, optlen);
+		if (err < 0) {
+			goto out_put;
+		} else if (err > 0) {
+			err = 0;
+			goto out_put;
+		}
+
 		if (level == SOL_SOCKET)
 			err =
 			    sock_getsockopt(sock, level, optname, optval,
-- 
2.22.0.rc1.311.g5d7573a151-goog

