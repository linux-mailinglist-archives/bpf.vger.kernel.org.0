Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAE442421C
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 18:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbhJFQEy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 12:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhJFQEy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 12:04:54 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E56C061746
        for <bpf@vger.kernel.org>; Wed,  6 Oct 2021 09:03:01 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id y1so1929534plk.10
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 09:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P04QJ/4Y946HO6LTkPlGTPEfscMIc2EXyiWAONPvzpo=;
        b=ESP7gPDaoBIaUDS6EInNcY0cPoPb3dD5k0rkI11rjbqwlfAfzXAVfF8l+2fO4zk0yD
         1i7EIfwozYAJhe1AC981jOrAC8au1oLkm/7IPqPzIC0oQ/Q/arTEAtn/2AkH6HQhRJLY
         6u6lGWSde3iJB8+Hlspzf9xPu+Z/nMtPE5sJYMeCeBsSOPXmx94KtL4IYC4iRBsaxGnF
         zEM4Bj76bYbEGyn+0/XSQMCDWBpSd2g/V/tTwtOX3e++1OaWXJY1VYbElX1QU65EHtSH
         68UX5vDwm7MDnuv7+Z0rwy1jKMHOiW64VmzS+5SmENpdCDyn+BCY2ItEjTgMTfEO5dg4
         V8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P04QJ/4Y946HO6LTkPlGTPEfscMIc2EXyiWAONPvzpo=;
        b=0Rp+0nTx1Kl7Az9hnxqbFqvmNf+OMkxyFbrYX7TFyFkscJAjC7n/c8q1Kq6j1n5Zb/
         YUKFI/d8RKJNJe40vUitbajgpQ//x3mQaq9YvQLxbXbtB3kACOgARZqp1zNGX8zmgLQm
         SX2HwGODqKrAN9fU/+oj0B93ShQvwTj3kNxR7y9xJ8d7ftox8FCtSRRZawL0Kqg1OQ+4
         JFW1cD+nJ59k1cwPMPAzBsjYjKHlnVmEt93TvabbTmQ+3ueHUdkqWpQ+DKSIrKys933s
         ZRTENSG9Mly778GnRVDZ1wyLFtZM2Zyuitr3MQg71SHan08ZMmVegU3yBUTwoe/kAZ/8
         h8rA==
X-Gm-Message-State: AOAM532kV4y5V8iI7K2VkTXAg0T/Sx39eGpGf/nXJDYhzr7DFmLcLh2D
        1F+UlOBuu9Tz2Uo6+GQCHG2xXWfJgaE=
X-Google-Smtp-Source: ABdhPJxxFB4ysEW29pPcO5bp2WCEzUeSKXdjgcqkvA/dKY+/hq0Dka6ykLdB5lH9bvyX+VpwCqvqpA==
X-Received: by 2002:a17:90a:5895:: with SMTP id j21mr11679165pji.99.1633536181151;
        Wed, 06 Oct 2021 09:03:01 -0700 (PDT)
Received: from localhost.localdomain ([98.47.144.235])
        by smtp.gmail.com with ESMTPSA id x19sm20906098pfn.105.2021.10.06.09.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 09:03:00 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf-next 2/3] bpf: Add cgroup helper bpf_export_errno to get/set exported errno value
Date:   Wed,  6 Oct 2021 09:02:41 -0700
Message-Id: <a2e569ee61e677ee474b7538adcebb0e1462df69.1633535940.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1633535940.git.zhuyifei@google.com>
References: <cover.1633535940.git.zhuyifei@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <zhuyifei@google.com>

When passed in a positive errno, it sets the errno and returns 0.
When passed in 0, it gets the previously set errno. When passed in
an out of bound number, it returns -EINVAL. This is unambiguous:
negative return values are error in invoking the helper itself,
and positive return values are errnos being exported. Errnos once
set cannot be unset, but can be overridden.

The errno value is stored inside bpf_cg_run_ctx for ease of access
different prog types with different context structs layouts. The
helper implementation can simply perform a container_of from
current->bpf_ctx to retrieve bpf_cg_run_ctx.

For backward compatibility, if a program rejects without calling
the helper, and the errno has not been set by any prior progs, the
BPF_PROG_RUN_ARRAY_CG family macros automatically set the errno to
EPERM. If a prog sets an errno but returns 1 (allow), the outcome
is considered implementation-defined. This patch treat it the same
way as if 0 (reject) is returned.

For BPF_PROG_CGROUP_INET_EGRESS_RUN_ARRAY, the prior behavior is
that, if the return value is NET_XMIT_DROP, the packet is silently
dropped. We preserve this behavior for backward compatibility
reasons, so even if an errno is set, the errno does not return to
caller.

For getsockopt hooks, they are different in that bpf progs runs
after kernel processes the getsockopt syscall instead of before.
There is also a retval in its context struct in which bpf progs
can unset the retval, and can force an -EPERM by returning 0.
We preseve the same semantics. Even though there is retval,
that value can only be unset, while progs can set (and not unset)
additional errno by using the helper, and that will override
whatever is in retval.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Reviewed-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/bpf.h            | 23 +++++++++++------------
 include/uapi/linux/bpf.h       | 14 ++++++++++++++
 kernel/bpf/cgroup.c            | 24 ++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 14 ++++++++++++++
 4 files changed, 63 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 938885562d68..5e3f3d2f5871 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1155,6 +1155,7 @@ struct bpf_run_ctx {};
 struct bpf_cg_run_ctx {
 	struct bpf_run_ctx run_ctx;
 	const struct bpf_prog_array_item *prog_item;
+	int errno_val;
 };
 
 struct bpf_trace_run_ctx {
@@ -1196,8 +1197,7 @@ BPF_PROG_RUN_ARRAY_CG_FLAGS(const struct bpf_prog_array __rcu *array_rcu,
 	const struct bpf_prog *prog;
 	const struct bpf_prog_array *array;
 	struct bpf_run_ctx *old_run_ctx;
-	struct bpf_cg_run_ctx run_ctx;
-	int ret = 0;
+	struct bpf_cg_run_ctx run_ctx = {};
 	u32 func_ret;
 
 	migrate_disable();
@@ -1208,15 +1208,15 @@ BPF_PROG_RUN_ARRAY_CG_FLAGS(const struct bpf_prog_array __rcu *array_rcu,
 	while ((prog = READ_ONCE(item->prog))) {
 		run_ctx.prog_item = item;
 		func_ret = run_prog(prog, ctx);
-		if (!(func_ret & 1))
-			ret = -EPERM;
+		if (!(func_ret & 1) && !run_ctx.errno_val)
+			run_ctx.errno_val = EPERM;
 		*(ret_flags) |= (func_ret >> 1);
 		item++;
 	}
 	bpf_reset_run_ctx(old_run_ctx);
 	rcu_read_unlock();
 	migrate_enable();
-	return ret;
+	return -run_ctx.errno_val;
 }
 
 static __always_inline int
@@ -1227,8 +1227,7 @@ BPF_PROG_RUN_ARRAY_CG(const struct bpf_prog_array __rcu *array_rcu,
 	const struct bpf_prog *prog;
 	const struct bpf_prog_array *array;
 	struct bpf_run_ctx *old_run_ctx;
-	struct bpf_cg_run_ctx run_ctx;
-	int ret = 0;
+	struct bpf_cg_run_ctx run_ctx = {};
 
 	migrate_disable();
 	rcu_read_lock();
@@ -1237,14 +1236,14 @@ BPF_PROG_RUN_ARRAY_CG(const struct bpf_prog_array __rcu *array_rcu,
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
 	while ((prog = READ_ONCE(item->prog))) {
 		run_ctx.prog_item = item;
-		if (!run_prog(prog, ctx))
-			ret = -EPERM;
+		if (!run_prog(prog, ctx) && !run_ctx.errno_val)
+			run_ctx.errno_val = EPERM;
 		item++;
 	}
 	bpf_reset_run_ctx(old_run_ctx);
 	rcu_read_unlock();
 	migrate_enable();
-	return ret;
+	return -run_ctx.errno_val;
 }
 
 static __always_inline u32
@@ -1297,7 +1296,7 @@ BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
  *   0: NET_XMIT_SUCCESS  skb should be transmitted
  *   1: NET_XMIT_DROP     skb should be dropped and cn
  *   2: NET_XMIT_CN       skb should be transmitted and cn
- *   3: -EPERM            skb should be dropped
+ *   3: -errno            skb should be dropped
  */
 #define BPF_PROG_CGROUP_INET_EGRESS_RUN_ARRAY(array, ctx, func)		\
 	({						\
@@ -1309,7 +1308,7 @@ BPF_PROG_RUN_ARRAY(const struct bpf_prog_array __rcu *array_rcu,
 		if (!_ret)				\
 			_ret = (_cn ? NET_XMIT_CN : NET_XMIT_SUCCESS);	\
 		else					\
-			_ret = (_cn ? NET_XMIT_DROP : -EPERM);		\
+			_ret = (_cn ? NET_XMIT_DROP : _ret);		\
 		_ret;					\
 	})
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6fc59d61937a..d8126f8c0541 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4909,6 +4909,19 @@ union bpf_attr {
  *	Return
  *		The number of bytes written to the buffer, or a negative error
  *		in case of failure.
+ *
+ * int bpf_export_errno(int errno_val)
+ *	Description
+ *		If *errno_val* is positive, set the syscall's return error code;
+ *		if *errno_val* is zero, retrieve the previously set code.
+ *
+ *		This helper is currently supported by cgroup programs only.
+ *	Return
+ *		Zero if set is successful, or the previously set error code on
+ *		retrieval. Previously set code may be zero if it was never set.
+ *		On error, a negative value.
+ *
+ *		**-EINVAL** if *errno_val* not between zero and MAX_ERRNO inclusive.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5089,6 +5102,7 @@ union bpf_attr {
 	FN(task_pt_regs),		\
 	FN(get_branch_snapshot),	\
 	FN(trace_vprintk),		\
+	FN(export_errno),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 5efe2588575e..5b5051eb43e6 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1169,6 +1169,28 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 	return ret;
 }
 
+BPF_CALL_1(bpf_export_errno, int, errno_val)
+{
+	struct bpf_cg_run_ctx *ctx =
+		container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
+
+	if (errno_val < 0 || errno_val > MAX_ERRNO)
+		return -EINVAL;
+
+	if (!errno_val)
+		return ctx->errno_val;
+
+	ctx->errno_val = errno_val;
+	return 0;
+}
+
+static const struct bpf_func_proto bpf_export_errno_proto = {
+	.func		= bpf_export_errno,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_ANYTHING,
+};
+
 static const struct bpf_func_proto *
 cgroup_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1181,6 +1203,8 @@ cgroup_base_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_current_cgroup_id_proto;
 	case BPF_FUNC_perf_event_output:
 		return &bpf_event_output_data_proto;
+	case BPF_FUNC_export_errno:
+		return &bpf_export_errno_proto;
 	default:
 		return bpf_base_func_proto(func_id);
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6fc59d61937a..d8126f8c0541 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4909,6 +4909,19 @@ union bpf_attr {
  *	Return
  *		The number of bytes written to the buffer, or a negative error
  *		in case of failure.
+ *
+ * int bpf_export_errno(int errno_val)
+ *	Description
+ *		If *errno_val* is positive, set the syscall's return error code;
+ *		if *errno_val* is zero, retrieve the previously set code.
+ *
+ *		This helper is currently supported by cgroup programs only.
+ *	Return
+ *		Zero if set is successful, or the previously set error code on
+ *		retrieval. Previously set code may be zero if it was never set.
+ *		On error, a negative value.
+ *
+ *		**-EINVAL** if *errno_val* not between zero and MAX_ERRNO inclusive.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -5089,6 +5102,7 @@ union bpf_attr {
 	FN(task_pt_regs),		\
 	FN(get_branch_snapshot),	\
 	FN(trace_vprintk),		\
+	FN(export_errno),		\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.33.0

