Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEE4376F30
	for <lists+bpf@lfdr.de>; Sat,  8 May 2021 05:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhEHDtp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 May 2021 23:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhEHDto (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 May 2021 23:49:44 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4DCC061574
        for <bpf@vger.kernel.org>; Fri,  7 May 2021 20:48:43 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g24so6293303pji.4
        for <bpf@vger.kernel.org>; Fri, 07 May 2021 20:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7NBSOquCBwdDutQSOyJSpYJU/InzThTPO7vwE3A0bCY=;
        b=fHs7zMiitSdKKpWiuSCNJM1VXueVFqcIXzmsdHJpdm50vh8phZnsfi53Yez6OnWh1D
         ddruW27s+u2CyJlCJp6JZDZKUxpMI038YPtMivlVdC/NlaPXFGjrI71IUXjkHiAN7Cv9
         YLXDyQGBjExvj+Z9+9MuxwASKIGLwRmwXCd3V48HJk/KvkxVNWxkmGcJBZKrD/jPZXYd
         j52L/NmX2g9ilAWm24vb4k3yW3oW035eKjZ4Z+/19AQNlg7ZIlLU7CTbf7BUzOBY4A8t
         SlN68G8l+29RdHylZjRLWzj+DwrUmUTF/9+xhIkraM4B4y62SBGXzXilPZ/M5UHbWofq
         OzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7NBSOquCBwdDutQSOyJSpYJU/InzThTPO7vwE3A0bCY=;
        b=mRhZFNUPJGdpvBTJE2vzbIXmxQIPdhmpEsUtkhVl8xlQAdufo6ARZASeNOMdS91K8p
         6fZt2swd/8y8yUha2eDSNaIuYD96JI0vEoh0K3I5B0xvVrujltFEWQB4uPz6Sk6G8lNv
         +NkOkoKkYCGvM/xJFAwDlUWk6y7IPC48rXm7Yy5sRImfd8WpSti5WYAVr3f3VAe0SbXp
         NMpq5s7O7MiQ9vy0CGecv1dNcEl0AfVWsVYHgS/Pdfpu+kIznDx6h9/hhMvbGNSHgIEF
         XxtlNCS3Xz/QPvr41nOihMuUtDiuykaZmzBOVyvJWbUXRUQ21Jiwpb52rW5RiaetieGh
         /qCA==
X-Gm-Message-State: AOAM53163Rr5auk1IxGIYjExG/1ZKUoJ6rp4OcWy2niLCiG+OY01q6p8
        qdePElnKGzMsYf9uPU8p9gmDOsUCnUo=
X-Google-Smtp-Source: ABdhPJxA/dgtyXZ/vgYvOSV0gp69aTGMoK1bRaBOKbaUcmTrRVLCQAlsyOmtKnev6ZPZ7tnfX+VOzg==
X-Received: by 2002:a17:90a:246:: with SMTP id t6mr14564557pje.228.1620445722670;
        Fri, 07 May 2021 20:48:42 -0700 (PDT)
Received: from ast-mbp.thefacebook.com ([163.114.132.1])
        by smtp.gmail.com with ESMTPSA id u12sm5784606pfh.122.2021.05.07.20.48.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 May 2021 20:48:41 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, john.fastabend@gmail.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 01/22] bpf: Introduce bpf_sys_bpf() helper and program type.
Date:   Fri,  7 May 2021 20:48:16 -0700
Message-Id: <20210508034837.64585-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
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
index 8fd552c16763..ad4df0a4ce54 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13207,6 +13207,14 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
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

