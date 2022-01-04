Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE854846D3
	for <lists+bpf@lfdr.de>; Tue,  4 Jan 2022 18:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiADRPb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jan 2022 12:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbiADRPY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Jan 2022 12:15:24 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A52C061799
        for <bpf@vger.kernel.org>; Tue,  4 Jan 2022 09:15:24 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id t29-20020aa7947d000000b004bb4bd3dd77so18434893pfq.0
        for <bpf@vger.kernel.org>; Tue, 04 Jan 2022 09:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bSExvyKcUDN4Il5vWcei6QEaGbWqpD9OrKIwdpgjomw=;
        b=DraPTFOFxjGp1+lP5yiiyCYoQxiUVImg7iUGnM78tcMDanr7BiGKcr5jFHmGJ7I30U
         uaUpGj6con/YWK3h1nLIXkr7oioDp4tBHOsBJuGSbHYVxpI9fsD37AqjXkt98dN+zjCw
         s2qNMAo9sFRL2xzEObWz90MPlMTxCTuELp3oQGusaRG9woAR7/DVNhJSY5hvRZttlOLE
         6lV/KO2GG8WBGUFiPIGtbUJHYQi25S1n+RJ+WwUvrv4GlfFOz52EbnkwTSNk8BxqtePF
         Cl1rJnm6oQLSQ5QwOnVOXERED0r3MNVYrUClVQQtFJYkMkmD6ACo4NctdJVKy1yOVpKp
         TXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bSExvyKcUDN4Il5vWcei6QEaGbWqpD9OrKIwdpgjomw=;
        b=oRu6UpvKx6dyXKFXTCRjv15Oz4C3HUh621XCLthNTg8odgOJdfnFF///wdzw4SSk78
         a//tRNEB6Z0CyRmBWbrbNLCF1KyUnCEzeomm9Sagzif8Bke4OyS7yBb8l8ud4JoTwGqv
         7PqbS2ne6QZlW3QXYBIuMF5sKUMTvBwe3UBLbPOmfp7cR5aPJJstL4uxQdd3Bgpw89ck
         vdcFW3PJobuCENA+15xxxuJB1U7kS2EgIeE+zAM9XuPQGRlVM2n0yo37o5vc5YoQT+iU
         cvKoKA3BV4wrbRlL43/TqxWuXSrGC33R1w8BulzLFxNFPdmMHfJxDA9HU116BytMml7i
         Z/CQ==
X-Gm-Message-State: AOAM532MYAsIBHVO9j+NBaHkI0zy8u1BP7cLYhtEA9KW61NoctA1ZbMT
        B1URvNtu3SAQdzlx4LM8jYPFoNg6AF43JmIYBvupbYX/vli7lO8kaoszX6ewZjyZb0mFJGHL2zf
        W2d0ewsWfODUkgozEEuVF/Jhb45zMxbgHzMdq6TVB0JWLCDxdsvN1slL2kYL//mM=
X-Google-Smtp-Source: ABdhPJx/L6wqY3HzALz3xjgtS69Wabn9JEdtQPYiXpM4MXL5hOhoqu3bK99FUz66KEsHKWQvJbEOTO6N9gB1HA==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a62:ea11:0:b0:4bc:9be8:9b2a with SMTP id
 t17-20020a62ea11000000b004bc9be89b2amr12545993pfh.64.1641316524013; Tue, 04
 Jan 2022 09:15:24 -0800 (PST)
Date:   Tue,  4 Jan 2022 17:15:04 +0000
In-Reply-To: <cover.1641316155.git.zhuyifei@google.com>
Message-Id: <833b122afaeaba4485942c563ef16a64fa997fe6.1641316155.git.zhuyifei@google.com>
Mime-Version: 1.0
References: <cover.1641316155.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 bpf-next 3/4] bpf: Add cgroup helpers bpf_{get,set}_retval
 to get/set syscall return value
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

The helpers continue to use int for retval because all the hooks
are int-returning rather than long-returning. The return value of
bpf_set_retval is int for future-proofing, in case in the future
there may be errors trying to set the retval.

After the previous patch, if a program rejects a syscall by
returning 0, an -EPERM will be generated no matter if the retval
is already set to -err. This patch change it being forced only if
retval is not -err. This is because we want to support, for
example, invoking bpf_set_retval(-EINVAL) and return 0, and have
the syscall return value be -EINVAL not -EPERM.

This change is reflected in the sockopt_sk test which has been
updated to assert the errno is EINVAL instead of the EPERM.
The eBPF prog has to explicitly bpf_set_retval(-EPERM) if EPERM
is wanted. I also removed the explicit mentions of EPERM in the
comments in the prog.

For BPF_PROG_CGROUP_INET_EGRESS_RUN_ARRAY, the prior behavior is
that, if the return value is NET_XMIT_DROP, the packet is silently
dropped. We preserve this behavior for backward compatibility
reasons, so even if an errno is set, the errno does not return to
caller. However, setting a non-err to retval cannot propagate so
this is not allowed and we return a -EFAULT in that case.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Reviewed-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf.h                           | 10 +++--
 include/uapi/linux/bpf.h                      | 18 +++++++++
 kernel/bpf/cgroup.c                           | 38 ++++++++++++++++++-
 tools/include/uapi/linux/bpf.h                | 18 +++++++++
 .../selftests/bpf/prog_tests/sockopt_sk.c     |  2 +-
 .../testing/selftests/bpf/progs/sockopt_sk.c  | 32 ++++++++--------
 6 files changed, 96 insertions(+), 22 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 88f6891e2b53..300df48fa0e0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1300,7 +1300,7 @@ BPF_PROG_RUN_ARRAY_CG_FLAGS(const struct bpf_prog_array __rcu *array_rcu,
 	while ((prog = READ_ONCE(item->prog))) {
 		run_ctx.prog_item = item;
 		func_ret = run_prog(prog, ctx);
-		if (!(func_ret & 1))
+		if (!(func_ret & 1) && !IS_ERR_VALUE((long)run_ctx.retval))
 			run_ctx.retval = -EPERM;
 		*(ret_flags) |= (func_ret >> 1);
 		item++;
@@ -1330,7 +1330,7 @@ BPF_PROG_RUN_ARRAY_CG(const struct bpf_prog_array __rcu *array_rcu,
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 	while ((prog = READ_ONCE(item->prog))) {
 		run_ctx.prog_item = item;
-		if (!run_prog(prog, ctx))
+		if (!run_prog(prog, ctx) && !IS_ERR_VALUE((long)run_ctx.retval))
 			run_ctx.retval = -EPERM;
 		item++;
 	}
@@ -1390,7 +1390,7 @@ BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
  *   0: NET_XMIT_SUCCESS  skb should be transmitted
  *   1: NET_XMIT_DROP     skb should be dropped and cn
  *   2: NET_XMIT_CN       skb should be transmitted and cn
- *   3: -EPERM            skb should be dropped
+ *   3: -err              skb should be dropped
  */
 #define BPF_PROG_CGROUP_INET_EGRESS_RUN_ARRAY(array, ctx, func)		\
 	({						\
@@ -1399,10 +1399,12 @@ BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
 		u32 _ret;				\
 		_ret = BPF_PROG_RUN_ARRAY_CG_FLAGS(array, ctx, func, 0, &_flags); \
 		_cn = _flags & BPF_RET_SET_CN;		\
+		if (_ret && !IS_ERR_VALUE((long)_ret))	\
+			_ret = -EFAULT;			\
 		if (!_ret)				\
 			_ret = (_cn ? NET_XMIT_CN : NET_XMIT_SUCCESS);	\
 		else					\
-			_ret = (_cn ? NET_XMIT_DROP : -EPERM);		\
+			_ret = (_cn ? NET_XMIT_DROP : _ret);		\
 		_ret;					\
 	})
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b0383d371b9a..140702c56938 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5018,6 +5018,22 @@ union bpf_attr {
  *
  *	Return
  *		The number of arguments of the traced function.
+ *
+ * int bpf_get_retval(void)
+ *	Description
+ *		Get the syscall's return value that will be returned to userspace.
+ *
+ *		This helper is currently supported by cgroup programs only.
+ *	Return
+ *		The syscall's return value.
+ *
+ * int bpf_set_retval(int retval)
+ *	Description
+ *		Set the syscall's return value that will be returned to userspace.
+ *
+ *		This helper is currently supported by cgroup programs only.
+ *	Return
+ *		0 on success, or a negative error in case of failure.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5206,6 +5222,8 @@ union bpf_attr {
 	FN(get_func_arg),		\
 	FN(get_func_ret),		\
 	FN(get_func_arg_cnt),		\
+	FN(get_retval),			\
+	FN(set_retval),			\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index b6fad0bbf5a7..279ebbed75a5 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1044,7 +1044,7 @@ int cgroup_bpf_prog_query(const union bpf_attr *attr,
  *   NET_XMIT_DROP       (1)	- drop packet and notify TCP to call cwr
  *   NET_XMIT_CN         (2)	- continue with packet output and notify TCP
  *				  to call cwr
- *   -EPERM			- drop packet
+ *   -err			- drop packet
  *
  * For ingress packets, this function will return -EPERM if any
  * attached program was found and if it returned != 1 during execution.
@@ -1080,6 +1080,8 @@ int __cgroup_bpf_run_filter_skb(struct sock *sk,
 	} else {
 		ret = BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[atype], skb,
 					    __bpf_prog_run_save_cb, 0);
+		if (ret && !IS_ERR_VALUE((long)ret))
+			ret = -EFAULT;
 	}
 	bpf_restore_data_end(skb, saved_data_end);
 	__skb_pull(skb, offset);
@@ -1205,6 +1207,36 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 	return ret;
 }
 
+BPF_CALL_0(bpf_get_retval)
+{
+	struct bpf_cg_run_ctx *ctx =
+		container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
+
+	return ctx->retval;
+}
+
+static const struct bpf_func_proto bpf_get_retval_proto = {
+	.func		= bpf_get_retval,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+};
+
+BPF_CALL_1(bpf_set_retval, int, retval)
+{
+	struct bpf_cg_run_ctx *ctx =
+		container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
+
+	ctx->retval = retval;
+	return 0;
+}
+
+static const struct bpf_func_proto bpf_set_retval_proto = {
+	.func		= bpf_set_retval,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_ANYTHING,
+};
+
 static const struct bpf_func_proto *
 cgroup_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1217,6 +1249,10 @@ cgroup_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_current_cgroup_id_proto;
 	case BPF_FUNC_perf_event_output:
 		return &bpf_event_output_data_proto;
+	case BPF_FUNC_get_retval:
+		return &bpf_get_retval_proto;
+	case BPF_FUNC_set_retval:
+		return &bpf_set_retval_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index b0383d371b9a..140702c56938 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5018,6 +5018,22 @@ union bpf_attr {
  *
  *	Return
  *		The number of arguments of the traced function.
+ *
+ * int bpf_get_retval(void)
+ *	Description
+ *		Get the syscall's return value that will be returned to userspace.
+ *
+ *		This helper is currently supported by cgroup programs only.
+ *	Return
+ *		The syscall's return value.
+ *
+ * int bpf_set_retval(int retval)
+ *	Description
+ *		Set the syscall's return value that will be returned to userspace.
+ *
+ *		This helper is currently supported by cgroup programs only.
+ *	Return
+ *		0 on success, or a negative error in case of failure.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5206,6 +5222,8 @@ union bpf_attr {
 	FN(get_func_arg),		\
 	FN(get_func_ret),		\
 	FN(get_func_arg_cnt),		\
+	FN(get_retval),			\
+	FN(set_retval),			\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
index 4b937e5dbaca..164aa5020bf1 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
@@ -177,7 +177,7 @@ static int getsetsockopt(void)
 	optlen = sizeof(buf.zc);
 	errno = 0;
 	err = getsockopt(fd, SOL_TCP, TCP_ZEROCOPY_RECEIVE, &buf, &optlen);
-	if (errno != EPERM) {
+	if (errno != EINVAL) {
 		log_err("Unexpected getsockopt(TCP_ZEROCOPY_RECEIVE) err=%d errno=%d",
 			err, errno);
 		goto err;
diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testing/selftests/bpf/progs/sockopt_sk.c
index 79c8139b63b8..d0298dccedcd 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
@@ -73,17 +73,17 @@ int _getsockopt(struct bpf_sockopt *ctx)
 		 */
 
 		if (optval + sizeof(struct tcp_zerocopy_receive) > optval_end)
-			return 0; /* EPERM, bounds check */
+			return 0; /* bounds check */
 
 		if (((struct tcp_zerocopy_receive *)optval)->address != 0)
-			return 0; /* EPERM, unexpected data */
+			return 0; /* unexpected data */
 
 		return 1;
 	}
 
 	if (ctx->level == SOL_IP && ctx->optname == IP_FREEBIND) {
 		if (optval + 1 > optval_end)
-			return 0; /* EPERM, bounds check */
+			return 0; /* bounds check */
 
 		ctx->retval = 0; /* Reset system call return value to zero */
 
@@ -96,24 +96,24 @@ int _getsockopt(struct bpf_sockopt *ctx)
 		 * bytes of data.
 		 */
 		if (optval_end - optval != page_size)
-			return 0; /* EPERM, unexpected data size */
+			return 0; /* unexpected data size */
 
 		return 1;
 	}
 
 	if (ctx->level != SOL_CUSTOM)
-		return 0; /* EPERM, deny everything except custom level */
+		return 0; /* deny everything except custom level */
 
 	if (optval + 1 > optval_end)
-		return 0; /* EPERM, bounds check */
+		return 0; /* bounds check */
 
 	storage = bpf_sk_storage_get(&socket_storage_map, ctx->sk, 0,
 				     BPF_SK_STORAGE_GET_F_CREATE);
 	if (!storage)
-		return 0; /* EPERM, couldn't get sk storage */
+		return 0; /* couldn't get sk storage */
 
 	if (!ctx->retval)
-		return 0; /* EPERM, kernel should not have handled
+		return 0; /* kernel should not have handled
 			   * SOL_CUSTOM, something is wrong!
 			   */
 	ctx->retval = 0; /* Reset system call return value to zero */
@@ -152,7 +152,7 @@ int _setsockopt(struct bpf_sockopt *ctx)
 		/* Overwrite SO_SNDBUF value */
 
 		if (optval + sizeof(__u32) > optval_end)
-			return 0; /* EPERM, bounds check */
+			return 0; /* bounds check */
 
 		*(__u32 *)optval = 0x55AA;
 		ctx->optlen = 4;
@@ -164,7 +164,7 @@ int _setsockopt(struct bpf_sockopt *ctx)
 		/* Always use cubic */
 
 		if (optval + 5 > optval_end)
-			return 0; /* EPERM, bounds check */
+			return 0; /* bounds check */
 
 		memcpy(optval, "cubic", 5);
 		ctx->optlen = 5;
@@ -175,10 +175,10 @@ int _setsockopt(struct bpf_sockopt *ctx)
 	if (ctx->level == SOL_IP && ctx->optname == IP_FREEBIND) {
 		/* Original optlen is larger than PAGE_SIZE. */
 		if (ctx->optlen != page_size * 2)
-			return 0; /* EPERM, unexpected data size */
+			return 0; /* unexpected data size */
 
 		if (optval + 1 > optval_end)
-			return 0; /* EPERM, bounds check */
+			return 0; /* bounds check */
 
 		/* Make sure we can trim the buffer. */
 		optval[0] = 0;
@@ -189,21 +189,21 @@ int _setsockopt(struct bpf_sockopt *ctx)
 		 * bytes of data.
 		 */
 		if (optval_end - optval != page_size)
-			return 0; /* EPERM, unexpected data size */
+			return 0; /* unexpected data size */
 
 		return 1;
 	}
 
 	if (ctx->level != SOL_CUSTOM)
-		return 0; /* EPERM, deny everything except custom level */
+		return 0; /* deny everything except custom level */
 
 	if (optval + 1 > optval_end)
-		return 0; /* EPERM, bounds check */
+		return 0; /* bounds check */
 
 	storage = bpf_sk_storage_get(&socket_storage_map, ctx->sk, 0,
 				     BPF_SK_STORAGE_GET_F_CREATE);
 	if (!storage)
-		return 0; /* EPERM, couldn't get sk storage */
+		return 0; /* couldn't get sk storage */
 
 	storage->val = optval[0];
 	ctx->optlen = -1; /* BPF has consumed this option, don't call kernel
-- 
2.34.1.448.ga2b2bfdf31-goog

