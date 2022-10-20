Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70646606B3B
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 00:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJTWYg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 18:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiJTWYe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 18:24:34 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D7413FA0;
        Thu, 20 Oct 2022 15:24:30 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id y10so647733qvo.11;
        Thu, 20 Oct 2022 15:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsC6/XBmm3wKyT5T4NGf7K2mMWvAtqX37cD6zeDYKck=;
        b=fs5cWDjFErlEG6dGu7Xrz0lwWHSUeFeO3YDmR3uDj8iX/cZJa3K7HUVYjsngfAaxgs
         W0/K8Qn4qqZOrJzn6nGrURBd0knmwmhTvHyZVcTuFeKKwu/i/Vxog7Qq5g42OZbykbTa
         xa3Py25WPv7veDXVeKHdigChlS5Y3MaqZwejW1FSaSaXyEpiszx+8fox0Rc+GvmCHEM7
         P1jiW+U+NEE+58GgTQM7PG01SCgCb6jZJyX2/wYOPKE5yltxSRchC/G04TWzZBmJzzFa
         ursYQAVlsWU6z1RoyAiAZV7E0227lMbNRg+p67IUvKyqLAYtZKpfsDbUz6okbU9MKKHL
         pSSg==
X-Gm-Message-State: ACrzQf2Og1nL+xTepvp7fKL12gvSSDypypWShqOKTjit5IAzH3mhuLks
        YaUDrdY0hmq+zubn5orNLZ/UDRrhdVzpmQ==
X-Google-Smtp-Source: AMsMyM7yEKp1c3fmDYAP0FkmQbeXyykK1YKAMBaUtcTmKgSIxawca2nW8b+/SmjvDYRH6m9h2auZKw==
X-Received: by 2002:a0c:dd89:0:b0:4ba:f06d:6fda with SMTP id v9-20020a0cdd89000000b004baf06d6fdamr65415qvk.51.1666304669258;
        Thu, 20 Oct 2022 15:24:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::80b7])
        by smtp.gmail.com with ESMTPSA id dt27-20020a05620a479b00b006b9c9b7db8bsm8524990qkb.82.2022.10.20.15.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 15:24:28 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, tj@kernel.org, memxor@gmail.com
Subject: [PATCH bpf-next v6 1/3] bpf: Allow trusted pointers to be passed to KF_TRUSTED_ARGS kfuncs
Date:   Thu, 20 Oct 2022 17:24:14 -0500
Message-Id: <20221020222416.3415511-2-void@manifault.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221020222416.3415511-1-void@manifault.com>
References: <20221020222416.3415511-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
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

To address this, this patch defines a new type flag called PTR_WALKED
which tracks whether a PTR_TO_BTF_ID pointer was retrieved from walking
a struct. A pointer passed directly from the kernel begins with
(PTR_WALKED & type) == 0, meaning of course that it is not obtained from
walking another struct. Any pointer received from walking that object,
however, would inherit that flag and become a walked pointer.

Additionally, because some kfuncs still only want BPF programs to be
able to send them an arg that they "own" (i.e. which they own a refcount
on) another kfunc arg flag called KF_OWNED_ARGS is added which is
identical to KF_TRUSTED_ARGS, but imposes the stricter requirement that
the arg must also have a refcount.

A subsequent patch will add kfuncs for storing a task kfunc as a kptr,
and then another patch will validate this feature by ensuring that the
verifier rejects a kfunc invocation with a nested pointer.

Signed-off-by: David Vernet <void@manifault.com>
---
 Documentation/bpf/kfuncs.rst                  | 50 ++++++++++----
 include/linux/bpf.h                           |  6 ++
 include/linux/btf.h                           | 57 ++++++++++++++--
 kernel/bpf/btf.c                              | 18 ++++-
 kernel/bpf/verifier.c                         | 66 ++++++++++++++-----
 net/bpf/test_run.c                            |  2 +-
 net/netfilter/nf_conntrack_bpf.c              |  8 +--
 net/netfilter/nf_nat_bpf.c                    |  2 +-
 .../selftests/bpf/prog_tests/map_kptr.c       |  2 +-
 tools/testing/selftests/bpf/verifier/calls.c  |  4 +-
 .../testing/selftests/bpf/verifier/map_kptr.c |  2 +-
 11 files changed, 169 insertions(+), 48 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 0f858156371d..8e2825150a8d 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -137,30 +137,54 @@ KF_ACQUIRE and KF_RET_NULL flags.
 --------------------------
 
 The KF_TRUSTED_ARGS flag is used for kfuncs taking pointer arguments. It
-indicates that the all pointer arguments will always have a guaranteed lifetime,
-and pointers to kernel objects are always passed to helpers in their unmodified
-form (as obtained from acquire kfuncs).
+indicates that the all pointer arguments will always have a guaranteed
+lifetime, and pointers to kernel objects are always passed to helpers in their
+unmodified form (either as passed by the main kernel, or as obtained from
+acquire kfuncs).
 
-It can be used to enforce that a pointer to a refcounted object acquired from a
-kfunc or BPF helper is passed as an argument to this kfunc without any
-modifications (e.g. pointer arithmetic) such that it is trusted and points to
-the original object.
+It can be used to enforce that a safe pointer passed to the program by the
+kernel, or a refcounted object acquired from a kfunc or BPF helper, is passed
+as an argument to this kfunc without any modifications (e.g. pointer
+arithmetic) such that it is trusted and points to the original object.
 
 Meanwhile, it is also allowed pass pointers to normal memory to such kfuncs,
 but those can have a non-zero offset.
 
-This flag is often used for kfuncs that operate (change some property, perform
-some operation) on an object that was obtained using an acquire kfunc. Such
-kfuncs need an unchanged pointer to ensure the integrity of the operation being
-performed on the expected object.
+This flag is often used for kfuncs that receive a trusted pointer from the
+kernel, and which do not require a reference to be held by the program. For
+example, if there's a kernel object that was allocated by the main kernel, and
+which the BPF program wishes to store in a map as a kptr, KF_TRUSTED_ARGS can
+be used to ensure that the pointer is actually a trusted kernel pointer before
+a reference is acquired on it in a KF_ACQUIRE kfunc.
+
+2.4.6 KF_OWNED_ARGS flag
+------------------------
+
+The KF_OWNED_ARGS flag is identical to the KF_TRUSTED_ARGS flag, though it is
+more restrictive in that it also requires the BPF program to hold a reference
+on the object.
 
-2.4.6 KF_SLEEPABLE flag
+In other words, it can be used to enforce that a pointer to a refcounted object
+acquired from a kfunc or BPF helper is passed as an argument to this kfunc
+without any modifications (e.g. pointer arithmetic) such that it is trusted and
+points to the original object that was allocated or owned by the BPF program.
+
+This flag is often used for kfuncs that operate (change some property, perform
+some operation) on an object that was obtained using an acquire kfunc. For
+example, if an acquire kfunc allocates an object on behalf of a program,
+KF_OWNED_ARGS would be an appropriate flag to specify for other kfuncs which
+allow the program to mutate that object. KF_TRUSTED_ARGS, on the other hand,
+would likely not be sufficiently restrictive as the kfunc does not want to
+allow the BPF program to mutate another instance of the same object type which
+was allocated by the main kernel.
+
+2.4.7 KF_SLEEPABLE flag
 -----------------------
 
 The KF_SLEEPABLE flag is used for kfuncs that may sleep. Such kfuncs can only
 be called by sleepable BPF programs (BPF_F_SLEEPABLE).
 
-2.4.7 KF_DESTRUCTIVE flag
+2.4.8 KF_DESTRUCTIVE flag
 --------------------------
 
 The KF_DESTRUCTIVE flag is used to indicate functions calling which is
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9e7d46d16032..ccdbefd72a95 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -457,6 +457,12 @@ enum bpf_type_flag {
 	/* Size is known at compile time. */
 	MEM_FIXED_SIZE		= BIT(10 + BPF_BASE_TYPE_BITS),
 
+	/* PTR was obtained from walking a struct. This is used with
+	 * PTR_TO_BTF_ID to determine whether the pointer is safe to pass to a
+	 * kfunc with KF_TRUSTED_ARGS.
+	 */
+	PTR_WALKED		= BIT(11 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
 };
diff --git a/include/linux/btf.h b/include/linux/btf.h
index f9aababc5d78..7f5a438196a2 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -17,9 +17,48 @@
 #define KF_RELEASE	(1 << 1) /* kfunc is a release function */
 #define KF_RET_NULL	(1 << 2) /* kfunc returns a pointer that may be NULL */
 #define KF_KPTR_GET	(1 << 3) /* kfunc returns reference to a kptr */
-/* Trusted arguments are those which are meant to be referenced arguments with
- * unchanged offset. It is used to enforce that pointers obtained from acquire
- * kfuncs remain unmodified when being passed to helpers taking trusted args.
+/* Trusted arguments are those which are meant to be guaranteed valid
+ * arguments, with an unchanged offset. It is used to enforce that pointers
+ * obtained from either acquire kfuncs or the main kernel remain unmodified
+ * when being passed to helpers taking trusted args.
+ *
+ * Consider, for example, the following task tracepoint:
+ *
+ *	SEC("tp_btf/task_newtask")
+ *	int BPF_PROG(new_task_tp, struct task_struct *task, u64 clone_flags)
+ *	{
+ *		...
+ *	}
+ *
+ * And the following kfunc:
+ *
+ *	BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RET_NULL | KF_TRUSTED_ARGS)
+ *
+ * All invocations to the kfunc must pass the unmodified, unwalked task:
+ *
+ *	bpf_task_acquire(task);		    // Allowed
+ *	bpf_task_acquire(task->last_wakee); // Rejected, walked task
+ *
+ * Users may also pass referenced tasks directly to the kfunc:
+ *
+ *	struct task_struct *acquired;
+ *
+ *	acquired = bpf_task_acquire(task);	// Allowed, same as above
+ *	bpf_task_acquire(acquired);		// Allowed
+ *	bpf_task_acquire(task);			// Allowed
+ *	bpf_task_acquire(acquired->last_wakee); // Rejected, walked task
+ *
+ * If users wish to only allow referenced objects to be passed to a kfunc, they
+ * may instead specify the KF_OWNED_ARGS flag.
+ */
+#define KF_TRUSTED_ARGS (1 << 4) /* kfunc only takes trusted pointer arguments */
+#define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
+#define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
+/* Owned arguments are similar to trusted arguments, but are even more
+ * restrictive.  Owned arguments are arguments which are "owned" by the BPF
+ * program, meaning it has acquired a reference to the object via an acquire
+ * kfunc. Just as with trusted arguments, the verifier enforces that owned
+ * arguments have an unchanged offset when they're passed to kfuncs.
  *
  * Consider
  *	struct foo {
@@ -36,7 +75,7 @@
  *	struct bar *b = alloc_bar(); // Acquire kfunc
  *
  * If a kfunc set_foo_data() wants to operate only on the allocated object, it
- * will set the KF_TRUSTED_ARGS flag, which will prevent unsafe usage like:
+ * will set the KR_ARGS_OWNED flag, which will prevent unsafe usage like:
  *
  *	set_foo_data(f, 42);	   // Allowed
  *	set_foo_data(f->next, 42); // Rejected, non-referenced pointer
@@ -47,10 +86,14 @@
  * by looking at the type of the member at the offset, but due to the
  * requirement of trusted argument, this deduction will be strict and not done
  * for this case.
+ *
+ * Note as well that if tracepoints existed which took a struct foo *f argument
+ * that was passed from the kernel, the verifier would also reject
+ * set_foo_bar(f, 42) on it, as the BPF program had not acquired a reference on
+ * it. If the kfunc had instead specified KF_TRUSTED_ARGS, this would be
+ * permitted.
  */
-#define KF_TRUSTED_ARGS (1 << 4) /* kfunc only takes trusted pointer arguments */
-#define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
-#define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
+#define KF_OWNED_ARGS   (1 << 7) /* kfunc performs destructive actions */
 
 /*
  * Return the name of the passed struct, if exists, or halt the build if for
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index eba603cec2c5..a3712abae108 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6227,7 +6227,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 				    bool processing_call)
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
-	bool rel = false, kptr_get = false, trusted_args = false;
+	bool rel = false, kptr_get = false, trusted_args = false, owned_args = false;
 	bool sleepable = false;
 	struct bpf_verifier_log *log = &env->log;
 	u32 i, nargs, ref_id, ref_obj_id = 0;
@@ -6265,7 +6265,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 		/* Only kfunc can be release func */
 		rel = kfunc_meta->flags & KF_RELEASE;
 		kptr_get = kfunc_meta->flags & KF_KPTR_GET;
-		trusted_args = kfunc_meta->flags & KF_TRUSTED_ARGS;
+		owned_args = kfunc_meta->flags & KF_OWNED_ARGS;
+		trusted_args = owned_args || (kfunc_meta->flags & KF_TRUSTED_ARGS);
 		sleepable = kfunc_meta->flags & KF_SLEEPABLE;
 	}
 
@@ -6333,8 +6334,19 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 		/* Check if argument must be a referenced pointer, args + i has
 		 * been verified to be a pointer (after skipping modifiers).
 		 * PTR_TO_CTX is ok without having non-zero ref_obj_id.
+		 *
+		 * All object pointers must be refcounted, other than:
+		 * - PTR_TO_CTX
+		 * - Trusted pointers (i.e. pointers with no type modifiers).
+		 *   Kfuncs that have specified KF_OWNED_ARGS require
+		 *   references even if a pointer is otherwise trusted.
 		 */
-		if (is_kfunc && trusted_args && (obj_ptr && reg->type != PTR_TO_CTX) && !reg->ref_obj_id) {
+		if (is_kfunc &&
+		    trusted_args &&
+		    obj_ptr &&
+		    base_type(reg->type) != PTR_TO_CTX &&
+		    (owned_args || type_flag(reg->type)) &&
+		    !reg->ref_obj_id) {
 			bpf_log(log, "R%d must be referenced\n", regno);
 			return -EINVAL;
 		}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6f6d2d511c06..7b8b20feeb62 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -541,7 +541,7 @@ static bool is_cmpxchg_insn(const struct bpf_insn *insn)
 static const char *reg_type_str(struct bpf_verifier_env *env,
 				enum bpf_reg_type type)
 {
-	char postfix[16] = {0}, prefix[32] = {0};
+	char postfix[16] = {0}, prefix[64] = {0};
 	static const char * const str[] = {
 		[NOT_INIT]		= "?",
 		[SCALAR_VALUE]		= "scalar",
@@ -573,16 +573,14 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
 			strncpy(postfix, "_or_null", 16);
 	}
 
-	if (type & MEM_RDONLY)
-		strncpy(prefix, "rdonly_", 32);
-	if (type & MEM_ALLOC)
-		strncpy(prefix, "alloc_", 32);
-	if (type & MEM_USER)
-		strncpy(prefix, "user_", 32);
-	if (type & MEM_PERCPU)
-		strncpy(prefix, "percpu_", 32);
-	if (type & PTR_UNTRUSTED)
-		strncpy(prefix, "untrusted_", 32);
+	snprintf(prefix, sizeof(prefix), "%s%s%s%s%s%s",
+		 type & MEM_RDONLY ? "rdonly_" : "",
+		 type & MEM_ALLOC ? "alloc_" : "",
+		 type & MEM_USER ? "user_" : "",
+		 type & MEM_PERCPU ? "percpu_" : "",
+		 type & PTR_UNTRUSTED ? "untrusted_" : "",
+		 type & PTR_WALKED ? "walked_" : ""
+	);
 
 	snprintf(env->type_str_buf, TYPE_STR_BUF_LEN, "%s%s%s",
 		 prefix, str[base_type(type)], postfix);
@@ -4558,6 +4556,9 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	if (type_flag(reg->type) & PTR_UNTRUSTED)
 		flag |= PTR_UNTRUSTED;
 
+	/* Mark this and any future pointers as having been obtained from walking a struct. */
+	flag |= PTR_WALKED;
+
 	if (atype == BPF_READ && value_regno >= 0)
 		mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
 
@@ -5661,6 +5662,7 @@ static const struct bpf_reg_types btf_id_sock_common_types = {
 		PTR_TO_TCP_SOCK,
 		PTR_TO_XDP_SOCK,
 		PTR_TO_BTF_ID,
+		PTR_TO_BTF_ID | PTR_WALKED,
 	},
 	.btf_id = &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
 };
@@ -5694,9 +5696,19 @@ static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
 static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
 static const struct bpf_reg_types alloc_mem_types = { .types = { PTR_TO_MEM | MEM_ALLOC } };
 static const struct bpf_reg_types const_map_ptr_types = { .types = { CONST_PTR_TO_MAP } };
-static const struct bpf_reg_types btf_ptr_types = { .types = { PTR_TO_BTF_ID } };
+static const struct bpf_reg_types btf_ptr_types = {
+	.types = {
+		PTR_TO_BTF_ID,
+		PTR_TO_BTF_ID | PTR_WALKED
+	},
+};
 static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALUE } };
-static const struct bpf_reg_types percpu_btf_ptr_types = { .types = { PTR_TO_BTF_ID | MEM_PERCPU } };
+static const struct bpf_reg_types percpu_btf_ptr_types = {
+	.types = {
+		PTR_TO_BTF_ID | MEM_PERCPU,
+		PTR_TO_BTF_ID | MEM_PERCPU | PTR_WALKED,
+	}
+};
 static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
 static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
 static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
@@ -5860,6 +5872,7 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
 	 * fixed offset.
 	 */
 	case PTR_TO_BTF_ID:
+	case PTR_TO_BTF_ID | PTR_WALKED:
 		/* When referenced PTR_TO_BTF_ID is passed to release function,
 		 * it's fixed offset must be 0.	In the other cases, fixed offset
 		 * can be non-zero.
@@ -12136,8 +12149,30 @@ static bool reg_type_mismatch_ok(enum bpf_reg_type type)
  */
 static bool reg_type_mismatch(enum bpf_reg_type src, enum bpf_reg_type prev)
 {
-	return src != prev && (!reg_type_mismatch_ok(src) ||
-			       !reg_type_mismatch_ok(prev));
+	/* Compare only the base types of the registers, to avoid confusing the
+	 * verifier with the following type of code:
+	 *
+	 * struct fib6_nh *fib6_nh;
+	 * struct nexthop *nh;
+	 *
+	 * fib6_nh = &rt->fib6_nh[0];
+	 *
+	 * nh = rt->nh;
+	 * if (nh)
+	 *	fib6_nh = &nh->nh_info->fib6_nh;
+	 *
+	 * If we did not compare base types, the verifier would reject this
+	 * because the register in the former branch will have PTR_TO_BTF_ID,
+	 * whereas the latter branch will have PTR_TO_BTF_ID | PTR_WALKED.
+	 *
+	 * The safety of the memory access is validated in check_mem_access()
+	 * before this function is called. The intention here is rather to
+	 * prevent a program from doing something like using PTR_TO_BTF_ID in
+	 * one path, and PTR_TO_CTX in another, as it would cause the
+	 * convert_ctx_access() handling to be incorrect.
+	 */
+	return base_type(src) != base_type(prev) &&
+	       (!reg_type_mismatch_ok(src) || !reg_type_mismatch_ok(prev));
 }
 
 static int do_check(struct bpf_verifier_env *env)
@@ -13499,6 +13534,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			break;
 		case PTR_TO_BTF_ID:
 		case PTR_TO_BTF_ID | PTR_UNTRUSTED:
+		case PTR_TO_BTF_ID | PTR_WALKED:
 			if (type == BPF_READ) {
 				insn->code = BPF_LDX | BPF_PROBE_MEM |
 					BPF_SIZE((insn)->code);
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 13d578ce2a09..a298bef13e12 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -758,7 +758,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_fail3)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_pass1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail1)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_mem_len_fail2)
-BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_kfunc_call_test_ref, KF_OWNED_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_destructive, KF_DESTRUCTIVE)
 BTF_SET8_END(test_sk_check_kfunc_ids)
 
diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index 8639e7efd0e2..ef937f4b4fe4 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -479,10 +479,10 @@ BTF_ID_FLAGS(func, bpf_skb_ct_alloc, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_skb_ct_lookup, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_ct_insert_entry, KF_ACQUIRE | KF_RET_NULL | KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_ct_release, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_ct_set_timeout, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_ct_change_timeout, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_ct_set_status, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_ct_change_status, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_ct_set_timeout, KF_OWNED_ARGS)
+BTF_ID_FLAGS(func, bpf_ct_change_timeout, KF_OWNED_ARGS)
+BTF_ID_FLAGS(func, bpf_ct_set_status, KF_OWNED_ARGS)
+BTF_ID_FLAGS(func, bpf_ct_change_status, KF_OWNED_ARGS)
 BTF_SET8_END(nf_ct_kfunc_set)
 
 static const struct btf_kfunc_id_set nf_conntrack_kfunc_set = {
diff --git a/net/netfilter/nf_nat_bpf.c b/net/netfilter/nf_nat_bpf.c
index 0fa5a0bbb0ff..69d6668756c4 100644
--- a/net/netfilter/nf_nat_bpf.c
+++ b/net/netfilter/nf_nat_bpf.c
@@ -57,7 +57,7 @@ int bpf_ct_set_nat_info(struct nf_conn___init *nfct,
 __diag_pop()
 
 BTF_SET8_START(nf_nat_kfunc_set)
-BTF_ID_FLAGS(func, bpf_ct_set_nat_info, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_ct_set_nat_info, KF_OWNED_ARGS)
 BTF_SET8_END(nf_nat_kfunc_set)
 
 static const struct btf_kfunc_id_set nf_bpf_nat_kfunc_set = {
diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr.c b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
index 0d66b1524208..1070ce936d32 100644
--- a/tools/testing/selftests/bpf/prog_tests/map_kptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/map_kptr.c
@@ -20,7 +20,7 @@ struct {
 	{ "reject_bad_type_match", "invalid kptr access, R1 type=untrusted_ptr_prog_test_ref_kfunc" },
 	{ "marked_as_untrusted_or_null", "R1 type=untrusted_ptr_or_null_ expected=percpu_ptr_" },
 	{ "correct_btf_id_check_size", "access beyond struct prog_test_ref_kfunc at off 32 size 4" },
-	{ "inherit_untrusted_on_walk", "R1 type=untrusted_ptr_ expected=percpu_ptr_" },
+	{ "inherit_untrusted_on_walk", "R1 type=untrusted_walked_ptr_ expected=percpu_ptr_" },
 	{ "reject_kptr_xchg_on_unref", "off=8 kptr isn't referenced kptr" },
 	{ "reject_kptr_get_no_map_val", "arg#0 expected pointer to map value" },
 	{ "reject_kptr_get_no_null_map_val", "arg#0 expected pointer to map value" },
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index e1a937277b54..3327b3e75ce8 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -181,7 +181,7 @@
 	},
 	.result_unpriv = REJECT,
 	.result = REJECT,
-	.errstr = "negative offset ptr_ ptr R1 off=-4 disallowed",
+	.errstr = "negative offset walked_ptr_ ptr R1 off=-4 disallowed",
 },
 {
 	"calls: invalid kfunc call: PTR_TO_BTF_ID with variable offset",
@@ -243,7 +243,7 @@
 	},
 	.result_unpriv = REJECT,
 	.result = REJECT,
-	.errstr = "R1 must be referenced",
+	.errstr = "arg#0 pointer type STRUCT prog_test_ref_kfunc must point to scalar",
 },
 {
 	"calls: valid kfunc call: referenced arg needs refcounted PTR_TO_BTF_ID",
diff --git a/tools/testing/selftests/bpf/verifier/map_kptr.c b/tools/testing/selftests/bpf/verifier/map_kptr.c
index 6914904344c0..003bae55d79e 100644
--- a/tools/testing/selftests/bpf/verifier/map_kptr.c
+++ b/tools/testing/selftests/bpf/verifier/map_kptr.c
@@ -242,7 +242,7 @@
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.fixup_map_kptr = { 1 },
 	.result = REJECT,
-	.errstr = "R1 type=untrusted_ptr_ expected=percpu_ptr_",
+	.errstr = "R1 type=untrusted_walked_ptr_ expected=percpu_ptr_",
 },
 {
 	"map_kptr: unref: no reference state created",
-- 
2.38.0

