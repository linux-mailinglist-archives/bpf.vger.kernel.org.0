Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D214767AF
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 03:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbhLPCE4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 21:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbhLPCEv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Dec 2021 21:04:51 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E14DC06173E
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 18:04:51 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id b15-20020a170902d50f00b00148ba062739so667331plg.4
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 18:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GzqM2Pf0GVu2BjeMt9xL/QOJ5vyR5g48GeIwW8tZ/Y8=;
        b=hAM2QkKBNxae3JMGSO9TrKg0p1tptyvQVitwfIntxxdthfQ3jZpzcSsjYy8TNLjqhq
         hFbnoR0KY/lV3pgRmY7PGBWfh8n+wQ7Yo1wqq9L+Lq9C+nEbycBYKyNcHhGI7Aof8Vka
         m0GHdNAW9L91vvKCn8j4IFcsPX8ZN5hqk7LiqTsaI/TnwUdeT2GHmf/p9gnBT5NL+YTc
         FM40uaKMeWsVAEO/PKvGmcekQwdsX1UYVwE6HVswFQp0jxkjDshECtUM/bqLqmYcf3UJ
         RdodB1vm8sRU9CJIss4718Pbpo9MZT3hKLgupBX5e+Vb1+0acf+dE3NrT78rOT2e+k99
         95cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GzqM2Pf0GVu2BjeMt9xL/QOJ5vyR5g48GeIwW8tZ/Y8=;
        b=cPmG2wXhZytx2RgfD2qLujiT/gZYM6RvHbx0Oq7g5Q7zVU2eTh9fnclgLJ2U+QPcPd
         emYSvopmTqxJg6oluiGB2KVP8CV7HM3+uZfu5Djgl5PRA92GBFUAPkJICD4eJPSs1aUh
         IDRtawXOg5vGFOp69iBesaZnVQuSL6HJ9U2Ef5SIoxOcoYyRe/Gj3plHM9ei5D7RKJWV
         /RRBvjyns9020l988d4ZpirZXOoF83/9gfAiLrM+ngNb5aeNMyH/TsaLNZQR2xdgoAXB
         7vPpGVaFNvzZxxcQ5eGXCVpxKJxQ4nqsSp13yy1K98TBo8lS52W23qEwP4Hq99cvvA2p
         klqw==
X-Gm-Message-State: AOAM532qiAQrAit5ueKirdn3rMKbkgmnShmD8Ehh1iBpZbNVE0Ku6GEm
        H1AaWT8oASg+5DYY+YWg982MBFwbQ9xiK/PUOifj4F8+Qs/l3Y2SAP8orLotMhkSgFytwCnag9Q
        8a4tXhw3Y/gy3tqQ60JaWVMEIXF5cBveuQSVDtvX8cAZ502dh64EHLEgCHZhayA4=
X-Google-Smtp-Source: ABdhPJy8BfOJ7wN2CFBI8yg2BLQqiND4EfB2pPJG5XwArqjpJuyp323VXhnDrUfuENNxJ5+h2n25X0/0Zb7o0w==
X-Received: from zhuyifei-kvm.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2edc])
 (user=zhuyifei job=sendgmr) by 2002:a17:90a:5883:: with SMTP id
 j3mr3210605pji.13.1639620290851; Wed, 15 Dec 2021 18:04:50 -0800 (PST)
Date:   Thu, 16 Dec 2021 02:04:27 +0000
In-Reply-To: <cover.1639619851.git.zhuyifei@google.com>
Message-Id: <b4013fd5d16bed0b01977c1fafdeae12e1de61fb.1639619851.git.zhuyifei@google.com>
Mime-Version: 1.0
References: <cover.1639619851.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v2 bpf-next 3/5] bpf: Add cgroup helpers bpf_{get,set}_retval
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

For BPF_PROG_CGROUP_INET_EGRESS_RUN_ARRAY, the prior behavior is
that, if the return value is NET_XMIT_DROP, the packet is silently
dropped. We preserve this behavior for backward compatibility
reasons, so even if an errno is set, the errno does not return to
caller. However, setting a non-err to retval cannot propagate so
this is not allowed and we return a -EFAULT in that case.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Reviewed-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf.h            | 10 +++++----
 include/uapi/linux/bpf.h       | 18 ++++++++++++++++
 kernel/bpf/cgroup.c            | 38 +++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h | 18 ++++++++++++++++
 4 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ef52b4f73cad..9925d1473cd4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1247,7 +1247,7 @@ BPF_PROG_RUN_ARRAY_CG_FLAGS(const struct bpf_prog_array __rcu *array_rcu,
 	while ((prog = READ_ONCE(item->prog))) {
 		run_ctx.prog_item = item;
 		func_ret = run_prog(prog, ctx);
-		if (!(func_ret & 1))
+		if (!(func_ret & 1) && !IS_ERR_VALUE((long)run_ctx.retval))
 			run_ctx.retval = -EPERM;
 		*(ret_flags) |= (func_ret >> 1);
 		item++;
@@ -1277,7 +1277,7 @@ BPF_PROG_RUN_ARRAY_CG(const struct bpf_prog_array __rcu *array_rcu,
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 	while ((prog = READ_ONCE(item->prog))) {
 		run_ctx.prog_item = item;
-		if (!run_prog(prog, ctx))
+		if (!run_prog(prog, ctx) && !IS_ERR_VALUE((long)run_ctx.retval))
 			run_ctx.retval = -EPERM;
 		item++;
 	}
@@ -1337,7 +1337,7 @@ BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
  *   0: NET_XMIT_SUCCESS  skb should be transmitted
  *   1: NET_XMIT_DROP     skb should be dropped and cn
  *   2: NET_XMIT_CN       skb should be transmitted and cn
- *   3: -EPERM            skb should be dropped
+ *   3: -err              skb should be dropped
  */
 #define BPF_PROG_CGROUP_INET_EGRESS_RUN_ARRAY(array, ctx, func)		\
 	({						\
@@ -1346,10 +1346,12 @@ BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
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
index 63e9a43c1018..f0a1e219b310 100644
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
-- 
2.34.1.173.g76aa8bc2d0-goog

