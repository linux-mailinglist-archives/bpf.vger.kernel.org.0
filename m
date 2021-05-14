Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8688C38012A
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 02:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhENAhm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 20:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhENAhl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 20:37:41 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F7EC061574
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:36:30 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id z18so11658681plg.8
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 17:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NLe9KDnBxAAJmk79x9/dX9MFkp9RAJXzMn5yL+m/jLA=;
        b=LwJe2RUjO1JI73tZzwttjeZyMfKck2Dn9FnWSXFBWAmfI0aGWCucLL7SepQNsK3Two
         csP5WCQmyHxOnjxv2rJXNsDdJwNlqpd069kOzA6nMb1ADoQDNQxVUO8deS4F8hFMJ+9C
         o9l1hU5Br7N/lkT1KKBFWRD6bwIfdp2fWshAEWuzLtVpl6ooBlr6UOfzEfrzDMh922jk
         eQrFlETUMWXYjuDnpWkyv1fdnP9BdJG1VZzjXp+InzPOEJSQdY/lEY5HnnKc7gxwk8v4
         6nkeGrU746wtEyv5srr8nMdTtKFb2Na8+gAZYYzQ+zhJAhL+6/K7EtkqtN6B7+d/hNVa
         skWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NLe9KDnBxAAJmk79x9/dX9MFkp9RAJXzMn5yL+m/jLA=;
        b=a/vE08khQ9TRHAdKBtOIpz46w08u+e2jMtYLG2akK0ULs+FS057vWlQW+FJ3uYkEKP
         r/SwnFyIOR6vspqMKxE1CUY1ocC0LlJ2oX2Djd/WTEQQ7Y/BQ6aemztLKssoArL8WZLm
         LoBUpilUIz/lQ0NNeWPnPv+oXuC1SpyyXX2CL8XtrWvbGDZ36dLtLR5gg2H2ihEqOsEz
         A6I5J9NkUVUVVs99EF4B0bNs8oj2qq7h4rgQNeK5pLInJsIc8Zd4aTYZ/b0V4MELetUJ
         fUilj8z9uzdbNDZXuv6oGFxvsbYjjxVk/9jSQ7wYQ124+pJXfcW9xcu80yhCO6AOlyjX
         HbWg==
X-Gm-Message-State: AOAM530zLjFxMFXu0jVSDMJl/3cDTgUC1G4NKcW3GcgBcDdaSLORTXVM
        /vd2i/1WaW8s6KZIGTl8/2w=
X-Google-Smtp-Source: ABdhPJy6dTBH+twEtou8dz9tfLpyBXYDBvC9yAODYAfFTBXIw/fRMh81/ifbB08OP2D7YZ673iYvkw==
X-Received: by 2002:a17:902:c411:b029:ee:9b6b:f78e with SMTP id k17-20020a170902c411b02900ee9b6bf78emr42829048plk.33.1620952590332;
        Thu, 13 May 2021 17:36:30 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.4])
        by smtp.gmail.com with ESMTPSA id b9sm302336pfo.107.2021.05.13.17.36.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 May 2021 17:36:29 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 01/21] bpf: Introduce bpf_sys_bpf() helper and program type.
Date:   Thu, 13 May 2021 17:36:03 -0700
Message-Id: <20210514003623.28033-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
References: <20210514003623.28033-1-alexei.starovoitov@gmail.com>
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

