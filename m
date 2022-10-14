Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59D75FF48C
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 22:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiJNU3Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 16:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiJNU3Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 16:29:24 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D005D705;
        Fri, 14 Oct 2022 13:29:23 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id 8so3250834qka.1;
        Fri, 14 Oct 2022 13:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=db6CGA38cn3llOR2GqnSc/iqHm89NTf7glPgZKqwHZI=;
        b=xD29nvJdvg8V3jTHczqqdSLHCEbtuViJBvz82xcUWEoz2vDB42WIha0iQDkA9Cgygt
         0ub8W8nJW2OmGAzWzFpfPcIVPOX8hG+HyaEBwLkzINT/IwIqp4QfZc18Mf/iN9JA03qR
         Pj5axXP95uXyYUjk2FmKv4xblkVIpOi7kmagmEcD5trPbwPY2nr2fowi3iSC2m0Zg33g
         czoEz6+DqJk7auW/LuuQiZWsr8ntitfQ5nOK+HjaEMqNvIcb9SRN2V9Xt6a44cMesgeN
         gNCO6aCsSrv9lJh4jWg3zxSVkI9UNKZQ88Zahwt/q6mJwzZL7dEROnw1cy7ANPOP9VRU
         1hjw==
X-Gm-Message-State: ACrzQf2jSDUzTzpTOXKGoZLUC/h0wNQr77+ATVhIkzHqxUN2mbn2pFYs
        ohSrYzD5qjS+hkyUKpSSJVFY6aHjZeX9yg==
X-Google-Smtp-Source: AMsMyM5Jsti+uAMK6d79gch9z/L/mBF/KpB3D7JyWrP5PgK7p9tUrlSSVWoETJ9ZwPRi9NQcCwQLFQ==
X-Received: by 2002:a37:afc7:0:b0:6ed:bca6:f552 with SMTP id y190-20020a37afc7000000b006edbca6f552mr5008845qke.283.1665779362582;
        Fri, 14 Oct 2022 13:29:22 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::6918])
        by smtp.gmail.com with ESMTPSA id bk10-20020a05620a1a0a00b006eeaf9160d6sm3164371qkb.24.2022.10.14.13.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 13:29:22 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, tj@kernel.org, memxor@gmail.com
Subject: [PATCH v4 1/3] bpf: Allow trusted pointers to be passed to KF_TRUSTED_ARGS kfuncs
Date:   Fri, 14 Oct 2022 15:28:50 -0500
Message-Id: <20221014202852.2491657-2-void@manifault.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221014202852.2491657-1-void@manifault.com>
References: <20221014202852.2491657-1-void@manifault.com>
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
 kernel/bpf/verifier.c                        | 12 +++++++++++-
 tools/testing/selftests/bpf/verifier/calls.c |  4 ++--
 4 files changed, 29 insertions(+), 4 deletions(-)

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
index 6f6d2d511c06..d16a08ca507b 100644
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
 
+	/* All pointers obtained by walking a struct are nested. */
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

