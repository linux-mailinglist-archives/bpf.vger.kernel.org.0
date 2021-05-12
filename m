Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E4637EF20
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 01:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhELW7Q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 18:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240829AbhELVnE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 17:43:04 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4754C08C5C2
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:02 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id h127so19683535pfe.9
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 14:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NLe9KDnBxAAJmk79x9/dX9MFkp9RAJXzMn5yL+m/jLA=;
        b=rhyADwMGmSnPMNKw8VkChrFdWwnVF45GSrlzRF6mWh+BBMV6RG6yjC3lXKk2bORH7e
         eI+Ynj2su0rVFrwmXfAoPjxy7sC8oVH9j6K2GTVNiTtjWffX1HJrppbqCOQSNkcrq62S
         4LSKV6YyHAPB40dz11YMqL2pLuCeOAcrMOzItCGkC2IsyE4rD74b7SYlnqhILgkB5ojy
         EOSx/mpz5e1cMoKfBGg9LERLGeitmdoN14GNaC9cH+LhVzmtaA4MSVl2Kg19MMEZTs0S
         rQuviUO22BAIOaFM/94GZB1gZq1lpQmBkfplkhZsZHboxlRFztNEwtyd1ys0hE1lA0YA
         Xlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NLe9KDnBxAAJmk79x9/dX9MFkp9RAJXzMn5yL+m/jLA=;
        b=tW5xeEpanq0SJ93j13r+ztqS/lGpEdCH+7Vbdhq9Q6fqFvz7oojctc+DYE7iYL2wsj
         McV1WahJDXN6gm3YLzsQy90G1mngb6zPQ1UREfEyEWdahtwcLUaI/+zQWPoirmWiA3L6
         bBEwipSdkPGUlIZ66F+YqGwhfPJJYtMcMBcWEbxS62B5MYmfZxEUXewjLwZIZ9v5PXmI
         5hlFOgRQjU7yAhkGZbLwk1kBnK8JcORCucCexJuhUDX65WoikVqHQzsO6MDVKTR22agw
         haC9Na0DelaSX+Lm6lGjWBf/a642feSvWrWDY0J01PmNyz3E+UF/VXVJBwF8K4rzbkgd
         u3OA==
X-Gm-Message-State: AOAM532H32lMQGCCXAzZdivz4/pNWDI8FTZRjIXZgtHD5QC4owOCpiOk
        TRVn9fcWE4wtRSHmaWdBngw=
X-Google-Smtp-Source: ABdhPJy/ylJbL9VjDvnCj0gjcvEs0V8kb8VXPUD4gYAeuLF9kGXt/Mw1gycqHbBcj6MTa1yjODpY3w==
X-Received: by 2002:a63:ea50:: with SMTP id l16mr38934538pgk.70.1620855182227;
        Wed, 12 May 2021 14:33:02 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id c128sm609222pfa.189.2021.05.12.14.33.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 May 2021 14:33:01 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 01/21] bpf: Introduce bpf_sys_bpf() helper and program type.
Date:   Wed, 12 May 2021 14:32:36 -0700
Message-Id: <20210512213256.31203-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
References: <20210512213256.31203-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Add placeholders for bpf_sys_bpf() helper and new program type.
Make sure to check that expected_attach_type is zero for future extensibility.
Allow tracing helper functions to be used in this program type, since they will
only execute from user context via bpf_prog_test_run.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h            | 10 +++++++
 include/linux/bpf_types.h      |  2 ++
 include/uapi/linux/bpf.h       |  8 +++++
 kernel/bpf/syscall.c           | 53 ++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c          |  8 +++++
 net/bpf/test_run.c             | 43 +++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  8 +++++
 7 files changed, 132 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 02b02cb29ce2..04a2bf41ae72 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1826,6 +1826,9 @@ static inline bool bpf_map_is_dev_bound(struct bpf_map *map)
 
 struct bpf_map *bpf_map_offload_map_alloc(union bpf_attr *attr);
 void bpf_map_offload_map_free(struct bpf_map *map);
+int bpf_prog_test_run_syscall(struct bpf_prog *prog,
+			      const union bpf_attr *kattr,
+			      union bpf_attr __user *uattr);
 #else
 static inline int bpf_prog_offload_init(struct bpf_prog *prog,
 					union bpf_attr *attr)
@@ -1851,6 +1854,13 @@ static inline struct bpf_map *bpf_map_offload_map_alloc(union bpf_attr *attr)
 static inline void bpf_map_offload_map_free(struct bpf_map *map)
 {
 }
+
+static inline int bpf_prog_test_run_syscall(struct bpf_prog *prog,
+					    const union bpf_attr *kattr,
+					    union bpf_attr __user *uattr)
+{
+	return -ENOTSUPP;
+}
 #endif /* CONFIG_NET && CONFIG_BPF_SYSCALL */
 
 #if defined(CONFIG_INET) && defined(CONFIG_BPF_SYSCALL)
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index f883f01a5061..a9db1eae6796 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -77,6 +77,8 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_LSM, lsm,
 	       void *, void *)
 #endif /* CONFIG_BPF_LSM */
 #endif
+BPF_PROG_TYPE(BPF_PROG_TYPE_SYSCALL, bpf_syscall,
+	      void *, void *)
 
 BPF_MAP_TYPE(BPF_MAP_TYPE_ARRAY, array_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_ARRAY, percpu_array_map_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ec6d85a81744..c92648f38144 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -937,6 +937,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_EXT,
 	BPF_PROG_TYPE_LSM,
 	BPF_PROG_TYPE_SK_LOOKUP,
+	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 };
 
 enum bpf_attach_type {
@@ -4735,6 +4736,12 @@ union bpf_attr {
  *		be zero-terminated except when **str_size** is 0.
  *
  *		Or **-EBUSY** if the per-CPU memory copy buffer is busy.
+ *
+ * long bpf_sys_bpf(u32 cmd, void *attr, u32 attr_size)
+ * 	Description
+ * 		Execute bpf syscall with given arguments.
+ * 	Return
+ * 		A syscall result.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -4903,6 +4910,7 @@ union bpf_attr {
 	FN(check_mtu),			\
 	FN(for_each_map_elem),		\
 	FN(snprintf),			\
+	FN(sys_bpf),			\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 941ca06d9dfa..b1e7352919cb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2014,6 +2014,7 @@ bpf_prog_load_check_attach(enum bpf_prog_type prog_type,
 		if (expected_attach_type == BPF_SK_LOOKUP)
 			return 0;
 		return -EINVAL;
+	case BPF_PROG_TYPE_SYSCALL:
 	case BPF_PROG_TYPE_EXT:
 		if (expected_attach_type)
 			return -EINVAL;
@@ -4508,3 +4509,55 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 
 	return err;
 }
+
+static bool syscall_prog_is_valid_access(int off, int size,
+					 enum bpf_access_type type,
+					 const struct bpf_prog *prog,
+					 struct bpf_insn_access_aux *info)
+{
+	if (off < 0 || off >= U16_MAX)
+		return false;
+	if (off % size != 0)
+		return false;
+	return true;
+}
+
+BPF_CALL_3(bpf_sys_bpf, int, cmd, void *, attr, u32, attr_size)
+{
+	return -EINVAL;
+}
+
+const struct bpf_func_proto bpf_sys_bpf_proto = {
+	.func		= bpf_sys_bpf,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_ANYTHING,
+	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_CONST_SIZE,
+};
+
+const struct bpf_func_proto * __weak
+tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	return bpf_base_func_proto(func_id);
+}
+
+static const struct bpf_func_proto *
+syscall_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	case BPF_FUNC_sys_bpf:
+		return &bpf_sys_bpf_proto;
+	default:
+		return tracing_prog_func_proto(func_id, prog);
+	}
+}
+
+const struct bpf_verifier_ops bpf_syscall_verifier_ops = {
+	.get_func_proto  = syscall_prog_func_proto,
+	.is_valid_access = syscall_prog_is_valid_access,
+};
+
+const struct bpf_prog_ops bpf_syscall_prog_ops = {
+	.test_run = bpf_prog_test_run_syscall,
+};
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bdfdb54676ea..37407d8fbca4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13196,6 +13196,14 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	int ret;
 	u64 key;
 
+	if (prog->type == BPF_PROG_TYPE_SYSCALL) {
+		if (prog->aux->sleepable)
+			/* attach_btf_id checked to be zero already */
+			return 0;
+		verbose(env, "Syscall programs can only be sleepable\n");
+		return -EINVAL;
+	}
+
 	if (prog->aux->sleepable && prog->type != BPF_PROG_TYPE_TRACING &&
 	    prog->type != BPF_PROG_TYPE_LSM) {
 		verbose(env, "Only fentry/fexit/fmod_ret and lsm programs can be sleepable\n");
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index a5d72c48fb66..a6972d7ddf80 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -918,3 +918,46 @@ int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog, const union bpf_attr *kat
 	kfree(user_ctx);
 	return ret;
 }
+
+int bpf_prog_test_run_syscall(struct bpf_prog *prog,
+			      const union bpf_attr *kattr,
+			      union bpf_attr __user *uattr)
+{
+	void __user *ctx_in = u64_to_user_ptr(kattr->test.ctx_in);
+	__u32 ctx_size_in = kattr->test.ctx_size_in;
+	void *ctx = NULL;
+	u32 retval;
+	int err = 0;
+
+	/* doesn't support data_in/out, ctx_out, duration, or repeat or flags */
+	if (kattr->test.data_in || kattr->test.data_out ||
+	    kattr->test.ctx_out || kattr->test.duration ||
+	    kattr->test.repeat || kattr->test.flags)
+		return -EINVAL;
+
+	if (ctx_size_in < prog->aux->max_ctx_offset ||
+	    ctx_size_in > U16_MAX)
+		return -EINVAL;
+
+	if (ctx_size_in) {
+		ctx = kzalloc(ctx_size_in, GFP_USER);
+		if (!ctx)
+			return -ENOMEM;
+		if (copy_from_user(ctx, ctx_in, ctx_size_in)) {
+			err = -EFAULT;
+			goto out;
+		}
+	}
+	retval = bpf_prog_run_pin_on_cpu(prog, ctx);
+
+	if (copy_to_user(&uattr->test.retval, &retval, sizeof(u32))) {
+		err = -EFAULT;
+		goto out;
+	}
+	if (ctx_size_in)
+		if (copy_to_user(ctx_in, ctx, ctx_size_in))
+			err = -EFAULT;
+out:
+	kfree(ctx);
+	return err;
+}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ec6d85a81744..c92648f38144 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -937,6 +937,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_EXT,
 	BPF_PROG_TYPE_LSM,
 	BPF_PROG_TYPE_SK_LOOKUP,
+	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 };
 
 enum bpf_attach_type {
@@ -4735,6 +4736,12 @@ union bpf_attr {
  *		be zero-terminated except when **str_size** is 0.
  *
  *		Or **-EBUSY** if the per-CPU memory copy buffer is busy.
+ *
+ * long bpf_sys_bpf(u32 cmd, void *attr, u32 attr_size)
+ * 	Description
+ * 		Execute bpf syscall with given arguments.
+ * 	Return
+ * 		A syscall result.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -4903,6 +4910,7 @@ union bpf_attr {
 	FN(check_mtu),			\
 	FN(for_each_map_elem),		\
 	FN(snprintf),			\
+	FN(sys_bpf),			\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.30.2

