Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1174D5FF467
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 22:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiJNUPb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 16:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiJNUPK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 16:15:10 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DEB38A3F;
        Fri, 14 Oct 2022 13:15:02 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id j21so3208926qkk.9;
        Fri, 14 Oct 2022 13:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9B5WCJk+STzLKu34JLdJ6VKkq949MWYzKFWY8poF1r0=;
        b=2My0ygw6iyZ5trHVHQR65yvzDG1upIaY5RgMBNQDmSIhg+6odYURJBaYUxQhK/o/8F
         xT4ImJB4QhPyN0+21Hy4I5eS0wKd+42NkQU7mhfrnHUol/8Adwsgcz74AcAy1tsI1D7H
         we9vSKsRl0mP0IUu2OOmR5O/QGfMwdyPM2tnG2xX8gm3K7oFl1Va6Tii2UOX6wK/Rlww
         heAQvFEou3loN/sSe6uATY6C9/fMgQcfxU7yOaRkzL2tq1X1Lm5UrICfc2fSLt2rtFC0
         8oUI6Oi/v8Dd1d7DzQnKwLk9y11WrLED/masPIbdgtIaxZk9ezNamV5pa9K2SEbRSA2q
         rJbA==
X-Gm-Message-State: ACrzQf0REk+Gex5RCmyuxFfJudccXUBIs0sp9YZudhHBhkWbmj5i3aei
        xpmE3xbCjsH1zNvd+nb769bDjqb1ol38gg==
X-Google-Smtp-Source: AMsMyM5BFC3eT9RO2tF6GwqLWqA+cU9cHCaWZPObI7F0teiesgOJ9+1uGJ+OZQwdkVyqawD2K4m07A==
X-Received: by 2002:a05:620a:448c:b0:6ce:a013:7fa3 with SMTP id x12-20020a05620a448c00b006cea0137fa3mr5070457qkp.532.1665778500897;
        Fri, 14 Oct 2022 13:15:00 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::6918])
        by smtp.gmail.com with ESMTPSA id bp39-20020a05620a45a700b006ce3f1af120sm3183062qkb.44.2022.10.14.13.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 13:15:00 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, tj@kernel.org, memxor@gmail.com
Subject: [PATCH v3 1/3] bpf: Allow trusted pointers to be passed to KF_TRUSTED_ARGS kfuncs
Date:   Fri, 14 Oct 2022 15:14:25 -0500
Message-Id: <20221014201427.2435461-2-void@manifault.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221014201427.2435461-1-void@manifault.com>
References: <20221014201427.2435461-1-void@manifault.com>
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

To address this, this patch defines a new type flag called PTR_NESTED
which tracks whether a PTR_TO_BTF_ID pointer was retrieved from walking
a struct. A pointer passed directly from the kernel begins with
(PTR_NESTED & type) == 0, meaning of course that it is not nested. Any
pointer received from walking that object, however, would inherit that
flag and become a nested pointer.

With that flag, this patch also updates btf_check_func_arg_match() to
only flag a PTR_TO_BTF_ID object as requiring a refcount if it has any
type modifiers (which of course includes both PTR_UNTRUSTED and
PTR_NESTED). Otherwise, the pointer passes this check and continues
onto the others in btf_check_func_arg_match().

A subsequent patch will add kfuncs for storing a task kfunc as a kptr,
and then another patch will validate this feature by ensuring that the
verifier rejects a kfunc invocation with a nested pointer.

Signed-off-by: David Vernet <void@manifault.com>
---
 include/linux/bpf.h                          |  6 ++++++
 kernel/bpf/btf.c                             | 11 ++++++++++-
 kernel/bpf/verifier.c                        | 15 ++++++++++++++-
 tools/testing/selftests/bpf/verifier/calls.c |  4 ++--
 4 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 9e7d46d16032..b624024edb4e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -457,6 +457,12 @@ enum bpf_type_flag {
 	/* Size is known at compile time. */
 	MEM_FIXED_SIZE		= BIT(10 + BPF_BASE_TYPE_BITS),
 
+	/* PTR was obtained from walking a struct. This is used with
+	 * PTR_TO_BTF_ID to determine whether the pointer is safe to pass to a
+	 * kfunc with KF_TRUSTED_ARGS.
+	 */
+	PTR_NESTED		= BIT(11 + BPF_BASE_TYPE_BITS),
+
 	__BPF_TYPE_FLAG_MAX,
 	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
 };
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index eba603cec2c5..3d7bad11b10b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6333,8 +6333,17 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 		/* Check if argument must be a referenced pointer, args + i has
 		 * been verified to be a pointer (after skipping modifiers).
 		 * PTR_TO_CTX is ok without having non-zero ref_obj_id.
+		 *
+		 * All object pointers must be refcounted, other than:
+		 * - PTR_TO_CTX
+		 * - Trusted pointers (i.e. pointers with no type modifiers)
 		 */
-		if (is_kfunc && trusted_args && (obj_ptr && reg->type != PTR_TO_CTX) && !reg->ref_obj_id) {
+		if (is_kfunc &&
+		    trusted_args &&
+		    obj_ptr &&
+		    base_type(reg->type) != PTR_TO_CTX &&
+		    type_flag(reg->type) &&
+		    !reg->ref_obj_id) {
 			bpf_log(log, "R%d must be referenced\n", regno);
 			return -EINVAL;
 		}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6f6d2d511c06..a625aaddeb34 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -581,6 +581,8 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
 		strncpy(prefix, "user_", 32);
 	if (type & MEM_PERCPU)
 		strncpy(prefix, "percpu_", 32);
+	if (type & PTR_NESTED)
+		strncpy(prefix, "nested_", 32);
 	if (type & PTR_UNTRUSTED)
 		strncpy(prefix, "untrusted_", 32);
 
@@ -4558,6 +4560,9 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	if (type_flag(reg->type) & PTR_UNTRUSTED)
 		flag |= PTR_UNTRUSTED;
 
+	/* A pointer can only be unwalked when it wasn't accessed by walking a struct. */
+	flag |= PTR_NESTED;
+
 	if (atype == BPF_READ && value_regno >= 0)
 		mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
 
@@ -5694,7 +5699,12 @@ static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
 static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
 static const struct bpf_reg_types alloc_mem_types = { .types = { PTR_TO_MEM | MEM_ALLOC } };
 static const struct bpf_reg_types const_map_ptr_types = { .types = { CONST_PTR_TO_MAP } };
-static const struct bpf_reg_types btf_ptr_types = { .types = { PTR_TO_BTF_ID } };
+static const struct bpf_reg_types btf_ptr_types = {
+	.types = {
+		PTR_TO_BTF_ID,
+		PTR_TO_BTF_ID | PTR_NESTED
+	},
+};
 static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALUE } };
 static const struct bpf_reg_types percpu_btf_ptr_types = { .types = { PTR_TO_BTF_ID | MEM_PERCPU } };
 static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
@@ -5768,6 +5778,9 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	if (arg_type & PTR_MAYBE_NULL)
 		type &= ~PTR_MAYBE_NULL;
 
+	if (!(arg_type & ARG_PTR_TO_BTF_ID))
+		type &= ~PTR_NESTED;
+
 	for (i = 0; i < ARRAY_SIZE(compatible->types); i++) {
 		expected = compatible->types[i];
 		if (expected == NOT_INIT)
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index e1a937277b54..496c29b1a298 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -181,7 +181,7 @@
 	},
 	.result_unpriv = REJECT,
 	.result = REJECT,
-	.errstr = "negative offset ptr_ ptr R1 off=-4 disallowed",
+	.errstr = "negative offset nested_ptr_ ptr R1 off=-4 disallowed",
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
-- 
2.38.0

