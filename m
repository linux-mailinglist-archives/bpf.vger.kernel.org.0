Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDDD037B7F
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 19:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfFFRvx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 13:51:53 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:34961 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbfFFRvw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jun 2019 13:51:52 -0400
Received: by mail-qk1-f201.google.com with SMTP id u128so2646085qka.2
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2019 10:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QJ1TZ2EMrCTetrs18FS0fhzWo9RHV41vte7GbhJuOko=;
        b=nyZWcMbpZj6tuNDEmXNGP/rdSXP0W/04DPCFdWQ3TjjG7nM0BqV71vpMsAywJvmJqn
         F6IoLVxUzciR00IZUP81r7EKvAIYwywMBs9mJTV4pPgXhBOPry91Z5W1kUffDaQyDayr
         ZJQpj80pF/u/pHXG46Ap7Q9GPJsqIb1ybSrEz5K32Rt2yRqBXulQukYtvUa0I0Q2mApV
         TVtMJ1w3jcH7vzx8vPZDaY8ZFQTEmRWlaNd8Hg2VJb4HJd0XoRhcUyH2tDzOQHW0GR7G
         plqu6mK3sORN/vWXvwYn/2Sy5ZfjjNLB5QDrEkfxGIuQ8tVyJPYJO7V0ihzL3mTUF3bC
         JFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QJ1TZ2EMrCTetrs18FS0fhzWo9RHV41vte7GbhJuOko=;
        b=HpYosTk2RvHpHwkWIBaKumywGepN+ThZz9iAOZ9L5MBJiDRrPPdKko9gmlUv1nlEPf
         2ybtHeGymVIe1wgFPPwiBbIHhCWle9Z6LdmfvQ4Z5oCPuoTkdHDK1bv8a09C338oIX4i
         fuz+zOvQmbAgnRSkgFug+WAiGwtUzUsPMCAR1x4EcEp7NSfcYdYmWqlZeUSZjTutvzEe
         Eol3e14Yk67BXHpt6YSSILbYWtEgpbV54xAUP9Lj0Lrq6zNKc+Pr/yeHcZlcjP2gskU0
         C2dVCMM/1Wqx+jmNQRFREj4LWpZiMaMBqnhU7T/iqisUxeQ3rc8fLVnkDNFF+DAZOCkw
         n5tA==
X-Gm-Message-State: APjAAAUvK7Z+OMpF+5znKef2+r2gtcDFWPoFYpTCK/m62WtC+W0CnHBw
        rQHV/ENCCh2gpW42IhTf7M4RdKg=
X-Google-Smtp-Source: APXvYqx/EiwD7xDhn3HXwBz1GooKJQbtHwXSbCNf+s0ohq0hZmT18rxAepXQkFqY9oH8CzUH6bz/YD8=
X-Received: by 2002:a05:620a:5b1:: with SMTP id q17mr38944161qkq.174.1559843511005;
 Thu, 06 Jun 2019 10:51:51 -0700 (PDT)
Date:   Thu,  6 Jun 2019 10:51:39 -0700
In-Reply-To: <20190606175146.205269-1-sdf@google.com>
Message-Id: <20190606175146.205269-2-sdf@google.com>
Mime-Version: 1.0
References: <20190606175146.205269-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH bpf-next v2 1/8] bpf: implement getsockopt and setsockopt hooks
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
__cgroup_bpf_prog_array_is_empty that exits early if there is nothing
attached to a cgroup. Note, however, that there is a race between
__cgroup_bpf_prog_array_is_empty and BPF_PROG_RUN_ARRAY where cgroup
program layout might have changed; this should not be a problem
because in general there is a race between multiple calls to
{s,g}etsocktop and user adding/removing bpf progs from a cgroup.

The return code of the BPF program is handled as follows:
* 0: EPERM
* 1: success, execute kernel {s,g}etsockopt path after BPF prog exits
* 2: success, do _not_ execute kernel {s,g}etsockopt path after BPF
     prog exits

v2:
* moved bpf_sockopt_kern fields around to remove a hole (Martin Lau)
* aligned bpf_sockopt_kern->buf to 8 bytes (Martin Lau)
* bpf_prog_array_is_empty instead of bpf_prog_array_length (Martin Lau)
* added [0,2] return code check to verifier (Martin Lau)
* dropped unused buf[64] from the stack (Martin Lau)
* use PTR_TO_SOCKET for bpf_sockopt->sk (Martin Lau)
* dropped bpf_target_off from ctx rewrites (Martin Lau)
* use return code for kernel bypass (Martin Lau & Andrii Nakryiko)

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf-cgroup.h |  29 ++++
 include/linux/bpf.h        |  46 ++++++
 include/linux/bpf_types.h  |   1 +
 include/linux/filter.h     |  13 ++
 include/uapi/linux/bpf.h   |  14 ++
 kernel/bpf/cgroup.c        | 277 +++++++++++++++++++++++++++++++++++++
 kernel/bpf/core.c          |   9 ++
 kernel/bpf/syscall.c       |  19 +++
 kernel/bpf/verifier.c      |  15 ++
 net/core/filter.c          |   4 +-
 net/socket.c               |  18 +++
 11 files changed, 443 insertions(+), 2 deletions(-)

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
index e5a309e6a400..883a190bc0b8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -520,6 +520,7 @@ struct bpf_prog_array {
 struct bpf_prog_array *bpf_prog_array_alloc(u32 prog_cnt, gfp_t flags);
 void bpf_prog_array_free(struct bpf_prog_array *progs);
 int bpf_prog_array_length(struct bpf_prog_array *progs);
+bool bpf_prog_array_is_empty(struct bpf_prog_array *array);
 int bpf_prog_array_copy_to_user(struct bpf_prog_array *progs,
 				__u32 __user *prog_ids, u32 cnt);
 
@@ -606,6 +607,49 @@ _out:							\
 		_ret;					\
 	})
 
+/* To be used by BPF_PROG_TYPE_CGROUP_SOCKOPT program type.
+ *
+ * Expected BPF program return values are:
+ *   0: return -EPERM to the userspace
+ *   1: sockopt was not handled by BPF, kernel should do it
+ *   2: sockopt was handled by BPF, kernel not should do it and return
+ *      to the userspace instead
+ *
+ * Note, that return '0' takes precedence over everything else. In other
+ * words, if any single program in the prog array has returned 0,
+ * the userspace will get -EPERM (regardless of what other programs
+ * return).
+ *
+ * The macro itself returns:
+ *        0: sockopt was not handled by BPF, kernel should do it
+ *        1: sockopt was handled by BPF, kernel snot hould do it
+ *   -EPERM: return error back to userspace
+ */
+#define BPF_PROG_CGROUP_SOCKOPT_RUN_ARRAY(array, ctx, func)		\
+	({								\
+		struct bpf_prog_array_item *_item;			\
+		struct bpf_prog *_prog;					\
+		struct bpf_prog_array *_array;				\
+		u32 ret;						\
+		u32 _success = 1;					\
+		u32 _bypass = 0;					\
+		preempt_disable();					\
+		rcu_read_lock();					\
+		_array = rcu_dereference(array);			\
+		_item = &_array->items[0];				\
+		while ((_prog = READ_ONCE(_item->prog))) {		\
+			bpf_cgroup_storage_set(_item->cgroup_storage);	\
+			ret = func(_prog, ctx);				\
+			_success &= (ret > 0);				\
+			_bypass |= (ret == 2);				\
+			_item++;					\
+		}							\
+		rcu_read_unlock();					\
+		preempt_enable();					\
+		ret = _success ? _bypass : -EPERM;			\
+		ret;							\
+	})
+
 #define BPF_PROG_RUN_ARRAY(array, ctx, func)		\
 	__BPF_PROG_RUN_ARRAY(array, ctx, func, false)
 
@@ -1054,6 +1098,8 @@ extern const struct bpf_func_proto bpf_spin_unlock_proto;
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
index 43b45d6db36d..6e64d01e4e36 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1199,4 +1199,17 @@ struct bpf_sysctl_kern {
 	u64 tmp_reg;
 };
 
+struct bpf_sockopt_kern {
+	struct sock	*sk;
+	u8		*optval;
+	u8		*optval_end;
+	s32		level;
+	s32		optname;
+	u32		optlen;
+
+	/* Small on-stack optval buffer to avoid small allocations.
+	 */
+	u8 buf[64] __aligned(8);
+};
+
 #endif /* __LINUX_FILTER_H__ */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 7c6aef253173..310b6bbfded8 100644
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
 
@@ -3533,4 +3536,15 @@ struct bpf_sysctl {
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
index 1b65ab0df457..04bc1a09464e 100644
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
 
+static bool __cgroup_bpf_prog_array_is_empty(struct cgroup *cgrp,
+					     enum bpf_attach_type attach_type)
+{
+	struct bpf_prog_array *prog_array;
+	bool empty;
+
+	rcu_read_lock();
+	prog_array = rcu_dereference(cgrp->bpf.effective[attach_type]);
+	empty = bpf_prog_array_is_empty(prog_array);
+	rcu_read_unlock();
+
+	return empty;
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
+	if (__cgroup_bpf_prog_array_is_empty(cgrp, BPF_CGROUP_SETSOCKOPT))
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
+	ret = BPF_PROG_CGROUP_SOCKOPT_RUN_ARRAY(
+		cgrp->bpf.effective[BPF_CGROUP_SETSOCKOPT],
+		&ctx, BPF_PROG_RUN);
+	release_sock(sk);
+
+	sockopt_free_buf(&ctx);
+
+	return ret;
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
+	int ret;
+
+	/* Opportunistic check to see whether we have any BPF program
+	 * attached to the hook so we don't waste time allocating
+	 * memory and locking the socket.
+	 */
+	if (__cgroup_bpf_prog_array_is_empty(cgrp, BPF_CGROUP_GETSOCKOPT))
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
+	ret = BPF_PROG_CGROUP_SOCKOPT_RUN_ARRAY(
+		cgrp->bpf.effective[BPF_CGROUP_GETSOCKOPT],
+		&ctx, BPF_PROG_RUN);
+	release_sock(sk);
+
+	if (ret < 0) {
+		sockopt_free_buf(&ctx);
+		return ret;
+	}
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
+	return ret;
+}
+EXPORT_SYMBOL(__cgroup_bpf_run_filter_getsockopt);
+
 static ssize_t sysctl_cpy_dir(const struct ctl_dir *dir, char **bufp,
 			      size_t *lenp)
 {
@@ -1184,3 +1321,143 @@ const struct bpf_verifier_ops cg_sysctl_verifier_ops = {
 
 const struct bpf_prog_ops cg_sysctl_prog_ops = {
 };
+
+static const struct bpf_func_proto *
+cg_sockopt_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	switch (func_id) {
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
+		info->reg_type = PTR_TO_SOCKET;
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
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct
+						       bpf_sockopt_kern, sk),
+				      si->dst_reg, si->src_reg,
+				      offsetof(struct bpf_sockopt_kern, sk));
+		break;
+	case offsetof(struct bpf_sockopt, level):
+		*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
+				      offsetof(struct bpf_sockopt_kern, level));
+		break;
+	case offsetof(struct bpf_sockopt, optname):
+		*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
+				      offsetof(struct bpf_sockopt_kern,
+					       optname));
+		break;
+	case offsetof(struct bpf_sockopt, optlen):
+		if (type == BPF_WRITE)
+			*insn++ = BPF_STX_MEM(BPF_W, si->dst_reg, si->src_reg,
+					      offsetof(struct bpf_sockopt_kern,
+						       optlen));
+		else
+			*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
+					      offsetof(struct bpf_sockopt_kern,
+						       optlen));
+		break;
+	case offsetof(struct bpf_sockopt, optval):
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_sockopt_kern,
+						       optval),
+				      si->dst_reg, si->src_reg,
+				      offsetof(struct bpf_sockopt_kern,
+					       optval));
+		break;
+	case offsetof(struct bpf_sockopt, optval_end):
+		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_sockopt_kern,
+						       optval_end),
+				      si->dst_reg, si->src_reg,
+				      offsetof(struct bpf_sockopt_kern,
+					       optval_end));
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
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 33fb292f2e30..e9152ebd66bc 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1813,6 +1813,15 @@ int bpf_prog_array_length(struct bpf_prog_array *array)
 	return cnt;
 }
 
+bool bpf_prog_array_is_empty(struct bpf_prog_array *array)
+{
+	struct bpf_prog_array_item *item;
+
+	for (item = array->items; item->prog; item++)
+		if (item->prog != &dummy_bpf_prog.prog)
+			return false;
+	return true;
+}
 
 static bool bpf_prog_array_copy_core(struct bpf_prog_array *array,
 				     u32 *prog_ids,
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
index 5c2cb5bd84ce..fffc668ef536 100644
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
@@ -5524,6 +5536,9 @@ static int check_return_code(struct bpf_verifier_env *env)
 	case BPF_PROG_TYPE_CGROUP_DEVICE:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
 		break;
+	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
+		range = tnum_range(0, 2);
+		break;
 	default:
 		return 0;
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

