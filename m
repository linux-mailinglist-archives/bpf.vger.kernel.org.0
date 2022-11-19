Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF26863110A
	for <lists+bpf@lfdr.de>; Sat, 19 Nov 2022 22:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbiKSVHz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Nov 2022 16:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbiKSVHy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Nov 2022 16:07:54 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B8F165A2;
        Sat, 19 Nov 2022 13:07:52 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id k4so5771111qkj.8;
        Sat, 19 Nov 2022 13:07:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1MIZt5eVbFhBIDNyB6J+LcelBVeEuA18ALA3xy0ri8=;
        b=0XDgwh1FfnyntYfWD3LT2tYoE2ycBCK7jVZcB1PxTmQ0reuHf8Atlabp1SBdhxF3zH
         89vWxA3O42zxJ+X11X0r1vxTLdU+VsO6z66JCyZJqN6ZBzEPvrM89TyyKA10yrMT9+nT
         f8jhJ0OzhIllbb71q/fp2hkjAYe/zNZJuYVGadWEITwmaRYKfY2YD+xyKwJFK9WteTVY
         irmnT6xPIHFWdVNRS9/QMwoQiXY/Eztjy4O+KFbKzInkz8HVvHzC5LIOlWNemuCm7OuU
         5xYz8GDSz6rj1bD+7bHNV2H0ENAv7t624Y5ctOZ8wn1mF2xoSpTIFU34jSpL3j3vdrXb
         Qddw==
X-Gm-Message-State: ANoB5pn3zqQc4/ODsdSXVGAtOM3R3dnu5rXoeGhNipeTbptlquMrN+Ge
        QaGE0+Tn4MdvdXwvEtxkl4g=
X-Google-Smtp-Source: AA0mqf7MM16h9UtsJj6BpA6nTaJqxIoqDPUXPRO8S3+zbtSKyLx/YNDnBr7oYcXlWqXKsw3jQ48bGw==
X-Received: by 2002:a05:620a:9c8:b0:6fa:ae8b:f78f with SMTP id y8-20020a05620a09c800b006faae8bf78fmr11201355qky.778.1668892070964;
        Sat, 19 Nov 2022 13:07:50 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:6319])
        by smtp.gmail.com with ESMTPSA id z11-20020ac8100b000000b003a50ef44a77sm4181361qti.28.2022.11.19.13.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Nov 2022 13:07:50 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, haoluo@google.com, jolsa@kernel.org,
        kpsingh@kernel.org, memxor@gmail.com, tj@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH bpf-next v8 1/3] bpf: Allow trusted pointers to be passed to KF_TRUSTED_ARGS kfuncs
Date:   Sat, 19 Nov 2022 15:07:46 -0600
Message-Id: <20221119210748.3325667-2-void@manifault.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221119210748.3325667-1-void@manifault.com>
References: <20221119210748.3325667-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kfuncs currently support specifying the KF_TRUSTED_ARGS flag to signal
to the verifier that it should enforce that a BPF program passes it a
"safe", trusted pointer. Currently, "safe" means that the pointer is
either PTR_TO_CTX, or is refcounted. There may be cases, however, where
the kernel passes a BPF program a safe / trusted pointer to an object
that the BPF program wishes to use as a kptr, but because the object
does not yet have a ref_obj_id from the perspective of the verifier, the
program would be unable to pass it to a KF_ACQUIRE | KF_TRUSTED_ARGS
kfunc.

The solution is to expand the set of pointers that are considered
trusted according to KF_TRUSTED_ARGS, so that programs can invoke kfuncs
with these pointers without getting rejected by the verifier.

There is already a PTR_UNTRUSTED flag that is set in some scenarios,
such as when a BPF program reads a kptr directly from a map
without performing a bpf_kptr_xchg() call. These pointers of course can
and should be rejected by the verifier. Unfortunately, however,
PTR_UNTRUSTED does not cover all the cases for safety that need to
be addressed to adequately protect kfuncs. Specifically, pointers
obtained by a BPF program "walking" a struct are _not_ considered
PTR_UNTRUSTED according to BPF. For example, say that we were to add a
kfunc called bpf_task_acquire(), with KF_ACQUIRE | KF_TRUSTED_ARGS, to
acquire a struct task_struct *. If we only used PTR_UNTRUSTED to signal
that a task was unsafe to pass to a kfunc, the verifier would mistakenly
allow the following unsafe BPF program to be loaded:

SEC("tp_btf/task_newtask")
int BPF_PROG(unsafe_acquire_task,
             struct task_struct *task,
             u64 clone_flags)
{
        struct task_struct *acquired, *nested;

        nested = task->last_wakee;

        /* Would not be rejected by the verifier. */
        acquired = bpf_task_acquire(nested);
        if (!acquired)
                return 0;

        bpf_task_release(acquired);
        return 0;
}

To address this, this patch defines a new type flag called PTR_TRUSTED
which tracks whether a PTR_TO_BTF_ID pointer is safe to pass to a
KF_TRUSTED_ARGS kfunc or a BPF helper function. PTR_TRUSTED pointers are
passed directly from the kernel as a tracepoint or struct_ops callback
argument. Any nested pointer that is obtained from walking a PTR_TRUSTED
pointer is no longer PTR_TRUSTED. From the example above, the struct
task_struct *task argument is PTR_TRUSTED, but the 'nested' pointer
obtained from 'task->last_wakee' is not PTR_TRUSTED.

A subsequent patch will add kfuncs for storing a task kfunc as a kptr,
and then another patch will add selftests to validate.

Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/kfuncs.rst                  | 30 ++++---
 include/linux/bpf.h                           | 30 +++++++
 include/linux/bpf_verifier.h                  |  7 ++
 include/linux/btf.h                           | 65 +++++++++------
 kernel/bpf/btf.c                              |  9 ++
 kernel/bpf/verifier.c                         | 83 ++++++++++++++-----
 kernel/trace/bpf_trace.c                      |  2 +-
 net/ipv4/bpf_tcp_ca.c                         |  4 +-
 tools/testing/selftests/bpf/verifier/calls.c  |  2 +-
 .../selftests/bpf/verifier/ref_tracking.c     |  4 +-
 10 files changed, 171 insertions(+), 65 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 3b1501c3b6cd..90774479ab7a 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -161,22 +161,20 @@ KF_ACQUIRE and KF_RET_NULL flags.
 --------------------------
 
 The KF_TRUSTED_ARGS flag is used for kfuncs taking pointer arguments. It
-indicates that the all pointer arguments will always have a guaranteed lifetime,
-and pointers to kernel objects are always passed to helpers in their unmodified
-form (as obtained from acquire kfuncs).
-
-It can be used to enforce that a pointer to a refcounted object acquired from a
-kfunc or BPF helper is passed as an argument to this kfunc without any
-modifications (e.g. pointer arithmetic) such that it is trusted and points to
-the original object.
-
-Meanwhile, it is also allowed pass pointers to normal memory to such kfuncs,
-but those can have a non-zero offset.
-
-This flag is often used for kfuncs that operate (change some property, perform
-some operation) on an object that was obtained using an acquire kfunc. Such
-kfuncs need an unchanged pointer to ensure the integrity of the operation being
-performed on the expected object.
+indicates that the all pointer arguments are valid, and that all pointers to
+BTF objects have been passed in their unmodified form (that is, at a zero
+offset, and without having been obtained from walking another pointer).
+
+There are two types of pointers to kernel objects which are considered "valid":
+
+1. Pointers which are passed as tracepoint or struct_ops callback arguments.
+2. Pointers which were returned from a KF_ACQUIRE or KF_KPTR_GET kfunc.
+
+Pointers to non-BTF objects (e.g. scalar pointers) may also be passed to
+KF_TRUSTED_ARGS kfuncs, and may have a non-zero offset.
+
+The definition of "valid" pointers is subject to change at any time, and has
+absolutely no ABI stability guarantees.
 
 2.4.6 KF_SLEEPABLE flag
 -----------------------
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8b32376ce746..c9eafa67f2a2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -543,6 +543,35 @@ enum bpf_type_flag {
 	 */
 	MEM_ALLOC		= BIT(11 + BPF_BASE_TYPE_BITS),
 
+	/* PTR was passed from the kernel in a trusted context, and may be
+	 * passed to KF_TRUSTED_ARGS kfuncs or BPF helper functions.
+	 * Confusingly, this is _not_ the opposite of PTR_UNTRUSTED above.
+	 * PTR_UNTRUSTED refers to a kptr that was read directly from a map
+	 * without invoking bpf_kptr_xchg(). What we really need to know is
+	 * whether a pointer is safe to pass to a kfunc or BPF helper function.
+	 * While PTR_UNTRUSTED pointers are unsafe to pass to kfuncs and BPF
+	 * helpers, they do not cover all possible instances of unsafe
+	 * pointers. For example, a pointer that was obtained from walking a
+	 * struct will _not_ get the PTR_UNTRUSTED type modifier, despite the
+	 * fact that it may be NULL, invalid, etc. This is due to backwards
+	 * compatibility requirements, as this was the behavior that was first
+	 * introduced when kptrs were added. The behavior is now considered
+	 * deprecated, and PTR_UNTRUSTED will eventually be removed.
+	 *
+	 * PTR_TRUSTED, on the other hand, is a pointer that the kernel
+	 * guarantees to be valid and safe to pass to kfuncs and BPF helpers.
+	 * For example, pointers passed to tracepoint arguments are considered
+	 * PTR_TRUSTED, as are pointers that are passed to struct_ops
+	 * callbacks. As alluded to above, pointers that are obtained from
+	 * walking PTR_TRUSTED pointers are _not_ trusted. For example, if a
+	 * struct task_struct *task is PTR_TRUSTED, then accessing
+	 * task->last_wakee will lose the PTR_TRUSTED modifier when it's stored
+	 * in a BPF register. Similarly, pointers passed to certain programs
+	 * types such as kretprobes are not guaranteed to be valid, as they may
+	 * for example contain an object that was recently freed.
+	 */
+	PTR_TRUSTED		= BIT(12 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
 };
@@ -636,6 +665,7 @@ enum bpf_return_type {
 	RET_PTR_TO_RINGBUF_MEM_OR_NULL	= PTR_MAYBE_NULL | MEM_RINGBUF | RET_PTR_TO_MEM,
 	RET_PTR_TO_DYNPTR_MEM_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_MEM,
 	RET_PTR_TO_BTF_ID_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_BTF_ID,
+	RET_PTR_TO_BTF_ID_TRUSTED	= PTR_TRUSTED	 | RET_PTR_TO_BTF_ID,
 
 	/* This must be the last entry. Its purpose is to ensure the enum is
 	 * wide enough to hold the higher bits reserved for bpf_type_flag.
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 23f30c685f28..e77907f21e48 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -680,4 +680,11 @@ static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)
 	}
 }
 
+#define BPF_REG_TRUSTED_MODIFIERS (MEM_ALLOC | PTR_TRUSTED)
+
+static inline bool bpf_type_has_unsafe_modifiers(u32 type)
+{
+	return type_flag(type) & ~BPF_REG_TRUSTED_MODIFIERS;
+}
+
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/include/linux/btf.h b/include/linux/btf.h
index d5b26380a60f..d38aa4251c28 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -19,36 +19,53 @@
 #define KF_RELEASE	(1 << 1) /* kfunc is a release function */
 #define KF_RET_NULL	(1 << 2) /* kfunc returns a pointer that may be NULL */
 #define KF_KPTR_GET	(1 << 3) /* kfunc returns reference to a kptr */
-/* Trusted arguments are those which are meant to be referenced arguments with
- * unchanged offset. It is used to enforce that pointers obtained from acquire
- * kfuncs remain unmodified when being passed to helpers taking trusted args.
+/* Trusted arguments are those which are guaranteed to be valid when passed to
+ * the kfunc. It is used to enforce that pointers obtained from either acquire
+ * kfuncs, or from the main kernel on a tracepoint or struct_ops callback
+ * invocation, remain unmodified when being passed to helpers taking trusted
+ * args.
  *
- * Consider
- *	struct foo {
- *		int data;
- *		struct foo *next;
- *	};
+ * Consider, for example, the following new task tracepoint:
  *
- *	struct bar {
- *		int data;
- *		struct foo f;
- *	};
+ *	SEC("tp_btf/task_newtask")
+ *	int BPF_PROG(new_task_tp, struct task_struct *task, u64 clone_flags)
+ *	{
+ *		...
+ *	}
  *
- *	struct foo *f = alloc_foo(); // Acquire kfunc
- *	struct bar *b = alloc_bar(); // Acquire kfunc
+ * And the following kfunc:
  *
- * If a kfunc set_foo_data() wants to operate only on the allocated object, it
- * will set the KF_TRUSTED_ARGS flag, which will prevent unsafe usage like:
+ *	BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
  *
- *	set_foo_data(f, 42);	   // Allowed
- *	set_foo_data(f->next, 42); // Rejected, non-referenced pointer
- *	set_foo_data(&f->next, 42);// Rejected, referenced, but wrong type
- *	set_foo_data(&b->f, 42);   // Rejected, referenced, but bad offset
+ * All invocations to the kfunc must pass the unmodified, unwalked task:
  *
- * In the final case, usually for the purposes of type matching, it is deduced
- * by looking at the type of the member at the offset, but due to the
- * requirement of trusted argument, this deduction will be strict and not done
- * for this case.
+ *	bpf_task_acquire(task);		    // Allowed
+ *	bpf_task_acquire(task->last_wakee); // Rejected, walked task
+ *
+ * Programs may also pass referenced tasks directly to the kfunc:
+ *
+ *	struct task_struct *acquired;
+ *
+ *	acquired = bpf_task_acquire(task);	// Allowed, same as above
+ *	bpf_task_acquire(acquired);		// Allowed
+ *	bpf_task_acquire(task);			// Allowed
+ *	bpf_task_acquire(acquired->last_wakee); // Rejected, walked task
+ *
+ * Programs may _not_, however, pass a task from an arbitrary fentry/fexit, or
+ * kprobe/kretprobe to the kfunc, as BPF cannot guarantee that all of these
+ * pointers are guaranteed to be safe. For example, the following BPF program
+ * would be rejected:
+ *
+ * SEC("kretprobe/free_task")
+ * int BPF_PROG(free_task_probe, struct task_struct *tsk)
+ * {
+ *	struct task_struct *acquired;
+ *
+ *	acquired = bpf_task_acquire(acquired); // Rejected, not a trusted pointer
+ *	bpf_task_release(acquired);
+ *
+ *	return 0;
+ * }
  */
 #define KF_TRUSTED_ARGS (1 << 4) /* kfunc only takes trusted pointer arguments */
 #define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f7d5fab61535..c17bb9880a62 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5799,6 +5799,11 @@ static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
 	return nr_args + 1;
 }
 
+static bool prog_type_args_trusted(enum bpf_prog_type prog_type)
+{
+	return prog_type == BPF_PROG_TYPE_TRACING || prog_type == BPF_PROG_TYPE_STRUCT_OPS;
+}
+
 bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		    const struct bpf_prog *prog,
 		    struct bpf_insn_access_aux *info)
@@ -5942,6 +5947,9 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	}
 
 	info->reg_type = PTR_TO_BTF_ID;
+	if (prog_type_args_trusted(prog->type))
+		info->reg_type |= PTR_TRUSTED;
+
 	if (tgt_prog) {
 		enum bpf_prog_type tgt_type;
 
@@ -6887,6 +6895,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
 			}
 
 			reg->type = PTR_TO_MEM | PTR_MAYBE_NULL;
+
 			reg->id = ++env->id_gen;
 
 			continue;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 195d24316750..3a90a1c7613f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -557,7 +557,7 @@ static bool is_cmpxchg_insn(const struct bpf_insn *insn)
 static const char *reg_type_str(struct bpf_verifier_env *env,
 				enum bpf_reg_type type)
 {
-	char postfix[16] = {0}, prefix[32] = {0};
+	char postfix[16] = {0}, prefix[64] = {0};
 	static const char * const str[] = {
 		[NOT_INIT]		= "?",
 		[SCALAR_VALUE]		= "scalar",
@@ -589,16 +589,14 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
 			strncpy(postfix, "_or_null", 16);
 	}
 
-	if (type & MEM_RDONLY)
-		strncpy(prefix, "rdonly_", 32);
-	if (type & MEM_RINGBUF)
-		strncpy(prefix, "ringbuf_", 32);
-	if (type & MEM_USER)
-		strncpy(prefix, "user_", 32);
-	if (type & MEM_PERCPU)
-		strncpy(prefix, "percpu_", 32);
-	if (type & PTR_UNTRUSTED)
-		strncpy(prefix, "untrusted_", 32);
+	snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s",
+		 type & MEM_RDONLY ? "rdonly_" : "",
+		 type & MEM_RINGBUF ? "ringbuf_" : "",
+		 type & MEM_USER ? "user_" : "",
+		 type & MEM_PERCPU ? "percpu_" : "",
+		 type & PTR_UNTRUSTED ? "untrusted_" : "",
+		 type & PTR_TRUSTED ? "trusted_" : ""
+	);
 
 	snprintf(env->type_str_buf, TYPE_STR_BUF_LEN, "%s%s%s",
 		 prefix, str[base_type(type)], postfix);
@@ -3859,7 +3857,7 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
 			       struct bpf_reg_state *reg, u32 regno)
 {
 	const char *targ_name = kernel_type_name(kptr_field->kptr.btf, kptr_field->kptr.btf_id);
-	int perm_flags = PTR_MAYBE_NULL;
+	int perm_flags = PTR_MAYBE_NULL | PTR_TRUSTED;
 	const char *reg_name = "";
 
 	/* Only unreferenced case accepts untrusted pointers */
@@ -4735,6 +4733,9 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	if (type_flag(reg->type) & PTR_UNTRUSTED)
 		flag |= PTR_UNTRUSTED;
 
+	/* Any pointer obtained from walking a trusted pointer is no longer trusted. */
+	flag &= ~PTR_TRUSTED;
+
 	if (atype == BPF_READ && value_regno >= 0)
 		mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
 
@@ -5847,6 +5848,7 @@ static const struct bpf_reg_types btf_id_sock_common_types = {
 		PTR_TO_TCP_SOCK,
 		PTR_TO_XDP_SOCK,
 		PTR_TO_BTF_ID,
+		PTR_TO_BTF_ID | PTR_TRUSTED,
 	},
 	.btf_id = &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
 };
@@ -5887,8 +5889,18 @@ static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
 static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
 static const struct bpf_reg_types ringbuf_mem_types = { .types = { PTR_TO_MEM | MEM_RINGBUF } };
 static const struct bpf_reg_types const_map_ptr_types = { .types = { CONST_PTR_TO_MAP } };
-static const struct bpf_reg_types btf_ptr_types = { .types = { PTR_TO_BTF_ID } };
-static const struct bpf_reg_types percpu_btf_ptr_types = { .types = { PTR_TO_BTF_ID | MEM_PERCPU } };
+static const struct bpf_reg_types btf_ptr_types = {
+	.types = {
+		PTR_TO_BTF_ID,
+		PTR_TO_BTF_ID | PTR_TRUSTED,
+	},
+};
+static const struct bpf_reg_types percpu_btf_ptr_types = {
+	.types = {
+		PTR_TO_BTF_ID | MEM_PERCPU,
+		PTR_TO_BTF_ID | MEM_PERCPU | PTR_TRUSTED,
+	}
+};
 static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
 static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
 static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
@@ -5976,7 +5988,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	return -EACCES;
 
 found:
-	if (reg->type == PTR_TO_BTF_ID) {
+	if (reg->type == PTR_TO_BTF_ID || (reg->type & PTR_TRUSTED)) {
 		/* For bpf_sk_release, it needs to match against first member
 		 * 'struct sock_common', hence make an exception for it. This
 		 * allows bpf_sk_release to work for multiple socket types.
@@ -6058,6 +6070,8 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	 */
 	case PTR_TO_BTF_ID:
 	case PTR_TO_BTF_ID | MEM_ALLOC:
+	case PTR_TO_BTF_ID | PTR_TRUSTED:
+	case PTR_TO_BTF_ID | MEM_ALLOC | PTR_TRUSTED:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
 		 * it's fixed offset must be 0.	In the other cases, fixed offset
 		 * can be non-zero.
@@ -7942,6 +7956,25 @@ static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int arg)
 	return arg == 0 && (meta->kfunc_flags & KF_KPTR_GET);
 }
 
+static bool is_trusted_reg(const struct bpf_reg_state *reg)
+{
+	/* A referenced register is always trusted. */
+	if (reg->ref_obj_id)
+		return true;
+
+	/* If a register is not referenced, it is trusted if it has either the
+	 * MEM_ALLOC or PTR_TRUSTED type modifiers, and no others. Some of the
+	 * other type modifiers may be safe, but we elect to take an opt-in
+	 * approach here as some (e.g. PTR_UNTRUSTED and PTR_MAYBE_NULL) are
+	 * not.
+	 *
+	 * Eventually, we should make PTR_TRUSTED the single source of truth
+	 * for whether a register is trusted.
+	 */
+	return (type_flag(reg->type) & BPF_REG_TRUSTED_MODIFIERS) &&
+	       !bpf_type_has_unsafe_modifiers(reg->type);
+}
+
 static bool __kfunc_param_match_suffix(const struct btf *btf,
 				       const struct btf_param *arg,
 				       const char *suffix)
@@ -8223,7 +8256,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 	const char *reg_ref_tname;
 	u32 reg_ref_id;
 
-	if (reg->type == PTR_TO_BTF_ID) {
+	if (base_type(reg->type) == PTR_TO_BTF_ID) {
 		reg_btf = reg->btf;
 		reg_ref_id = reg->btf_id;
 	} else {
@@ -8369,6 +8402,7 @@ static int check_reg_allocation_locked(struct bpf_verifier_env *env, struct bpf_
 		ptr = reg->map_ptr;
 		break;
 	case PTR_TO_BTF_ID | MEM_ALLOC:
+	case PTR_TO_BTF_ID | MEM_ALLOC | PTR_TRUSTED:
 		ptr = reg->btf;
 		break;
 	default:
@@ -8599,8 +8633,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_BTF_ID:
 			if (!is_kfunc_trusted_args(meta))
 				break;
-			if (!reg->ref_obj_id) {
-				verbose(env, "R%d must be referenced\n", regno);
+
+			if (!is_trusted_reg(reg)) {
+				verbose(env, "R%d must be referenced or trusted\n", regno);
 				return -EINVAL;
 			}
 			fallthrough;
@@ -8621,8 +8656,13 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			return -EFAULT;
 		}
 
-		if (is_kfunc_release(meta) && reg->ref_obj_id)
+		if (is_kfunc_release(meta) && reg->ref_obj_id) {
 			arg_type |= OBJ_RELEASE;
+			if (bpf_type_has_unsafe_modifiers(reg->type)) {
+				verbose(env, "R%d release reg has unsafe modifiers\n", i);
+				return -EINVAL;
+			}
+		}
 		ret = check_func_arg_reg_off(env, reg, regno, arg_type);
 		if (ret < 0)
 			return ret;
@@ -8705,7 +8745,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			break;
 		case KF_ARG_PTR_TO_BTF_ID:
 			/* Only base_type is checked, further checks are done here */
-			if (reg->type != PTR_TO_BTF_ID &&
+			if (base_type(reg->type) != PTR_TO_BTF_ID &&
 			    (!reg2btf_ids[base_type(reg->type)] || type_flag(reg->type))) {
 				verbose(env, "arg#%d expected pointer to btf or socket\n", i);
 				return -EINVAL;
@@ -14716,6 +14756,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			break;
 		case PTR_TO_BTF_ID:
 		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
+		case PTR_TO_BTF_ID | PTR_TRUSTED:
 		/* PTR_TO_BTF_ID | MEM_ALLOC always has a valid lifetime, unlike
 		 * PTR_TO_BTF_ID, and an active ref_obj_id, but the same cannot
 		 * be said once it is marked PTR_UNTRUSTED, hence we must handle
@@ -14723,6 +14764,8 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		 * for this case.
 		 */
 		case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
+		case PTR_TO_BTF_ID | PTR_UNTRUSTED | PTR_TRUSTED:
+		case PTR_TO_BTF_ID | PTR_UNTRUSTED | MEM_ALLOC | PTR_TRUSTED:
 			if (type == BPF_READ) {
 				insn->code = BPF_LDX | BPF_PROBE_MEM |
 					BPF_SIZE((insn)->code);
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f2d8d070d024..5b9008bc597b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -774,7 +774,7 @@ BPF_CALL_0(bpf_get_current_task_btf)
 const struct bpf_func_proto bpf_get_current_task_btf_proto = {
 	.func		= bpf_get_current_task_btf,
 	.gpl_only	= true,
-	.ret_type	= RET_PTR_TO_BTF_ID,
+	.ret_type	= RET_PTR_TO_BTF_ID_TRUSTED,
 	.ret_btf_id	= &btf_tracing_ids[BTF_TRACING_TYPE_TASK],
 };
 
diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index d15c91de995f..4517d2bd186a 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -61,7 +61,9 @@ static bool bpf_tcp_ca_is_valid_access(int off, int size,
 	if (!bpf_tracing_btf_ctx_access(off, size, type, prog, info))
 		return false;
 
-	if (info->reg_type == PTR_TO_BTF_ID && info->btf_id == sock_id)
+	if (base_type(info->reg_type) == PTR_TO_BTF_ID &&
+	    !bpf_type_has_unsafe_modifiers(info->reg_type) &&
+	    info->btf_id == sock_id)
 		/* promote it to tcp_sock */
 		info->btf_id = tcp_sock_id;
 
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 86d6fef2e3b4..0e4daeb27c27 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -109,7 +109,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = REJECT,
-	.errstr = "arg#0 expected pointer to btf or socket",
+	.errstr = "R0 release reg has unsafe modifiers",
 	.fixup_kfunc_btf_id = {
 		{ "bpf_kfunc_call_test_acquire", 3 },
 		{ "bpf_kfunc_call_test_release", 5 },
diff --git a/tools/testing/selftests/bpf/verifier/ref_tracking.c b/tools/testing/selftests/bpf/verifier/ref_tracking.c
index 55cba01c99d5..2f7aa703ecc1 100644
--- a/tools/testing/selftests/bpf/verifier/ref_tracking.c
+++ b/tools/testing/selftests/bpf/verifier/ref_tracking.c
@@ -142,7 +142,7 @@
 	.kfunc = "bpf",
 	.expected_attach_type = BPF_LSM_MAC,
 	.flags = BPF_F_SLEEPABLE,
-	.errstr = "arg#0 expected pointer to btf or socket",
+	.errstr = "R0 release reg has unsafe modifiers",
 	.fixup_kfunc_btf_id = {
 		{ "bpf_lookup_user_key", 2 },
 		{ "bpf_key_put", 4 },
@@ -163,7 +163,7 @@
 	.kfunc = "bpf",
 	.expected_attach_type = BPF_LSM_MAC,
 	.flags = BPF_F_SLEEPABLE,
-	.errstr = "arg#0 expected pointer to btf or socket",
+	.errstr = "R0 release reg has unsafe modifiers",
 	.fixup_kfunc_btf_id = {
 		{ "bpf_lookup_system_key", 1 },
 		{ "bpf_key_put", 3 },
-- 
2.38.1

