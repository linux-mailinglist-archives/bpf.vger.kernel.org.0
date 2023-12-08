Return-Path: <bpf+bounces-17090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B22F5809935
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 03:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67ABF282324
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 02:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA3D20EB;
	Fri,  8 Dec 2023 02:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7m2K7/J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639C51709
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 18:32:25 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-67adaacd943so9623146d6.0
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 18:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702002744; x=1702607544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trptKOjPkaqXlno/iydALkNzdgsX7ruGqFROS1fKiHo=;
        b=k7m2K7/JjL2m7WIx7thAKMw/4k1bPMRr9+u05eHMpaWPL5CKNpDej8+PgtybERhJyF
         vPt9Fn3kpf2Ffons332z9bV+ti2eDm3ZKEhRRPYbFG51aX4kBHaqsrA4K1+M23hYZNSL
         U1BuYcyFxmhIy9Gd1uUvdWDwhGqalX+ce62NfIUq0PRqizXQ5xyzANAWRVI6fb6C/wcK
         YgAkiKDaP3cCj9MUtu2s7BJi/1lFAgxL6EO0GBFYg4jITZsotZGn0PWrrqP98VrqpA3H
         xKe+M/iJyP7tGr2tEERtdSHWx3Yh7eQtjaBz+2Pl7qGCnNF+FIeuUAVzorpAZl2JD+4k
         nrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702002744; x=1702607544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trptKOjPkaqXlno/iydALkNzdgsX7ruGqFROS1fKiHo=;
        b=RoIVVf4naH+5PXRMUr/BkXSV65FzfAnefzjZZ3Vu+Kp9B9UFNDrrMJ+F3Ur7pk0Zvz
         F6ZpxVvC9COohRlWOCo0cXo/in4aNMTrKYcbhsdjVIAouWIvoY0Y2qoy9RVFeizA2npB
         imkB3CZOiZqnqE8mllM4UV8hW2pWBKtmYSnbiXtNpmy34C+YX+ombSREgVpTUCGymrJ9
         UhH/q26m7Pl4tVySZDXtai4ncvKeC9Cx9JPF81D4ywemS/2WBk/5x8szMqlX36bBkZ7t
         ctWbqYvwQIUpD6b5jfT2KUixFT2B2OVXYu3hNgxc4+z/942LC4RNxFaB5n4bqcSa/zGB
         j4vA==
X-Gm-Message-State: AOJu0YyFz9AzNyOBXmJKuaMV44KHRszQgZCkvPrdzNnSM6JTJ8boec4K
	m2jf/NrvolOPlvS/wLzSMyi1p7VA7RpRRg==
X-Google-Smtp-Source: AGHT+IGL55A8JUbnYp0IN8MspK4ZymNmalNIBdkSWNeEgLO9Gps143aYND1+pVG2x7hNmLo5D5EqoQ==
X-Received: by 2002:a05:6214:4254:b0:67e:aadd:870a with SMTP id ne20-20020a056214425400b0067eaadd870amr366991qvb.116.1702002743532;
        Thu, 07 Dec 2023 18:32:23 -0800 (PST)
Received: from andrei-framework.verizon.net ([2600:4041:599b:1100:2b9f:d631:c5b3:a90f])
        by smtp.gmail.com with ESMTPSA id g5-20020ad45105000000b0067ac80bb33fsm408063qvp.125.2023.12.07.18.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 18:32:23 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: sunhao.th@gmail.com,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com,
	Andrei Matei <andreimatei1@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf v4 2/3] bpf: fix accesses to uninit stack slots
Date: Thu,  7 Dec 2023 21:31:49 -0500
Message-Id: <20231208023150.254207-3-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231208023150.254207-1-andreimatei1@gmail.com>
References: <20231208023150.254207-1-andreimatei1@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Privileged programs are supposed to be able to read uninitialized stack
memory (ever since 6715df8d5) but, before this patch, these accesses
were permitted inconsistently. In particular, accesses were permitted
above state->allocated_stack, but not below it. In other words, if the
stack was already "large enough", the access was permitted, but
otherwise the access was rejected instead of being allowed to "grow the
stack". This undesired rejection was happening in two places:
- in check_stack_slot_within_bounds()
- in check_stack_range_initialized()
This patch arranges for these accesses to be permitted. A bunch of tests
that were relying on the old rejection had to change; all of them were
changed to add also run unprivileged, in which case the old behavior
persists. One tests couldn't be updated - global_func16 - because it
can't run unprivileged for other reasons.

This patch also fixes the tracking of the stack size for variable-offset
reads. This second fix is bundled in the same commit as the first one
because they're inter-related. Before this patch, writes to the stack
using registers containing a variable offset (as opposed to registers
with fixed, known values) were not properly contributing to the
function's needed stack size. As a result, it was possible for a program
to verify, but then to attempt to read out-of-bounds data at runtime
because a too small stack had been allocated for it.

Each function tracks the size of the stack it needs in
bpf_subprog_info.stack_depth, which is maintained by
update_stack_depth(). For regular memory accesses, check_mem_access()
was calling update_state_depth() but it was passing in only the fixed
part of the offset register, ignoring the variable offset. This was
incorrect; the minimum possible value of that register should be used
instead.

This tracking is now fixed by centralizing the tracking of stack size in
grow_stack_state(), and by lifting the calls to grow_stack_state() to
check_stack_access_within_bounds() as suggested by Andrii. The code is
now simpler and more convincingly tracks the correct maximum stack size.
check_stack_range_initialized() can now rely on enough stack having been
allocated for the access; this helps with the fix for the first issue.

A few tests were changed to also check the stack depth computation. The
one that fails without this patch is verifier_var_off:stack_write_priv_vs_unpriv.

Reported-by: Hao Sun <sunhao.th@gmail.com>
Fixes: 01f810ace9ed3 ("bpf: Allow variable-offset stack access")
Closes: https://lore.kernel.org/bpf/CABWLsev9g8UP_c3a=1qbuZUi20tGoUXoU07FPf-5FLvhOKOY+Q@mail.gmail.com/
Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c                         | 67 ++++++++-----------
 tools/testing/selftests/bpf/progs/iters.c     |  2 +-
 .../selftests/bpf/progs/test_global_func16.c  |  2 +-
 .../bpf/progs/verifier_basic_stack.c          |  8 +--
 .../selftests/bpf/progs/verifier_int_ptr.c    |  5 +-
 .../selftests/bpf/progs/verifier_raw_stack.c  |  5 +-
 .../selftests/bpf/progs/verifier_var_off.c    | 62 ++++++++++++++---
 .../selftests/bpf/verifier/atomic_cmpxchg.c   | 11 ---
 tools/testing/selftests/bpf/verifier/calls.c  |  4 +-
 9 files changed, 93 insertions(+), 73 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index af2819d5c8ee..bdef4e981dc0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1685,7 +1685,10 @@ static int resize_reference_state(struct bpf_func_state *state, size_t n)
 	return 0;
 }
 
-static int grow_stack_state(struct bpf_func_state *state, int size)
+/* Possibly update state->allocated_stack to be at least size bytes. Also
+ * possibly update the function's high-water mark in its bpf_subprog_info.
+ */
+static int grow_stack_state(struct bpf_verifier_env *env, struct bpf_func_state *state, int size)
 {
 	size_t old_n = state->allocated_stack / BPF_REG_SIZE, n = size / BPF_REG_SIZE;
 
@@ -1697,6 +1700,11 @@ static int grow_stack_state(struct bpf_func_state *state, int size)
 		return -ENOMEM;
 
 	state->allocated_stack = size;
+
+	/* update known max for given subprogram */
+	if (env->subprog_info[state->subprogno].stack_depth < size)
+		env->subprog_info[state->subprogno].stack_depth = size;
+
 	return 0;
 }
 
@@ -4669,9 +4677,6 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 	struct bpf_reg_state *reg = NULL;
 	u32 dst_reg = insn->dst_reg;
 
-	err = grow_stack_state(state, round_up(slot + 1, BPF_REG_SIZE));
-	if (err)
-		return err;
 	/* caller checked that off % size == 0 and -MAX_BPF_STACK <= off < 0,
 	 * so it's aligned access and [off, off + size) are within stack limits
 	 */
@@ -4827,10 +4832,6 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
 	    (!value_reg && is_bpf_st_mem(insn) && insn->imm == 0))
 		writing_zero = true;
 
-	err = grow_stack_state(state, round_up(-min_off, BPF_REG_SIZE));
-	if (err)
-		return err;
-
 	for (i = min_off; i < max_off; i++) {
 		int spi;
 
@@ -5959,20 +5960,6 @@ static int check_ptr_alignment(struct bpf_verifier_env *env,
 					   strict);
 }
 
-static int update_stack_depth(struct bpf_verifier_env *env,
-			      const struct bpf_func_state *func,
-			      int off)
-{
-	u16 stack = env->subprog_info[func->subprogno].stack_depth;
-
-	if (stack >= -off)
-		return 0;
-
-	/* update known max for given subprogram */
-	env->subprog_info[func->subprogno].stack_depth = -off;
-	return 0;
-}
-
 /* starting from main bpf function walk all instructions of the function
  * and recursively walk all callees that given function can call.
  * Ignore jump and exit insns.
@@ -6761,13 +6748,14 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
  * The minimum valid offset is -MAX_BPF_STACK for writes, and
  * -state->allocated_stack for reads.
  */
-static int check_stack_slot_within_bounds(int off,
-					  struct bpf_func_state *state,
-					  enum bpf_access_type t)
+static int check_stack_slot_within_bounds(struct bpf_verifier_env *env,
+                                          int off,
+                                          struct bpf_func_state *state,
+                                          enum bpf_access_type t)
 {
 	int min_valid_off;
 
-	if (t == BPF_WRITE)
+	if (t == BPF_WRITE || env->allow_uninit_stack)
 		min_valid_off = -MAX_BPF_STACK;
 	else
 		min_valid_off = -state->allocated_stack;
@@ -6822,9 +6810,9 @@ static int check_stack_access_within_bounds(
 			max_off = min_off;
 	}
 
-	err = check_stack_slot_within_bounds(min_off, state, type);
+	err = check_stack_slot_within_bounds(env, min_off, state, type);
 	if (!err)
-		err = check_stack_slot_within_bounds(max_off, state, type);
+		err = check_stack_slot_within_bounds(env, max_off, state, type);
 
 	if (err) {
 		if (tnum_is_const(reg->var_off)) {
@@ -6837,8 +6825,10 @@ static int check_stack_access_within_bounds(
 			verbose(env, "invalid variable-offset%s stack R%d var_off=%s size=%d\n",
 				err_extra, regno, tn_buf, access_size);
 		}
+		return err;
 	}
-	return err;
+
+	return grow_stack_state(env, state, round_up(-min_off, BPF_REG_SIZE));
 }
 
 /* check whether memory at (regno + off) is accessible for t = (read | write)
@@ -6853,7 +6843,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 {
 	struct bpf_reg_state *regs = cur_regs(env);
 	struct bpf_reg_state *reg = regs + regno;
-	struct bpf_func_state *state;
 	int size, err = 0;
 
 	size = bpf_size_to_bytes(bpf_size);
@@ -6996,11 +6985,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		if (err)
 			return err;
 
-		state = func(env, reg);
-		err = update_stack_depth(env, state, off);
-		if (err)
-			return err;
-
 		if (t == BPF_READ)
 			err = check_stack_read(env, regno, off, size,
 					       value_regno);
@@ -7195,7 +7179,8 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 
 /* When register 'regno' is used to read the stack (either directly or through
  * a helper function) make sure that it's within stack boundary and, depending
- * on the access type, that all elements of the stack are initialized.
+ * on the access type and privileges, that all elements of the stack are
+ * initialized.
  *
  * 'off' includes 'regno->off', but not its dynamic part (if any).
  *
@@ -7303,8 +7288,11 @@ static int check_stack_range_initialized(
 
 		slot = -i - 1;
 		spi = slot / BPF_REG_SIZE;
-		if (state->allocated_stack <= slot)
-			goto err;
+		if (state->allocated_stack <= slot) {
+			verbose(env, "verifier bug: allocated_stack too small");
+			return -EFAULT;
+		}
+
 		stype = &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
 		if (*stype == STACK_MISC)
 			goto mark;
@@ -7328,7 +7316,6 @@ static int check_stack_range_initialized(
 			goto mark;
 		}
 
-err:
 		if (tnum_is_const(reg->var_off)) {
 			verbose(env, "invalid%s read from stack R%d off %d+%d size %d\n",
 				err_extra, regno, min_off, i - min_off, access_size);
@@ -7353,7 +7340,7 @@ static int check_stack_range_initialized(
 		 * helper may write to the entire memory range.
 		 */
 	}
-	return update_stack_depth(env, state, min_off);
+	return 0;
 }
 
 static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index c20c4e38b71c..844d968c27d6 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -846,7 +846,7 @@ __naked int delayed_precision_mark(void)
 		"call %[bpf_iter_num_next];"
 		"if r0 == 0 goto 2f;"
 		"if r6 != 42 goto 3f;"
-		"r7 = -32;"
+		"r7 = -33;"
 		"call %[bpf_get_prandom_u32];"
 		"r6 = r0;"
 		"goto 1b;\n"
diff --git a/tools/testing/selftests/bpf/progs/test_global_func16.c b/tools/testing/selftests/bpf/progs/test_global_func16.c
index e7206304632e..e3e64bc472cd 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func16.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func16.c
@@ -13,7 +13,7 @@ __noinline int foo(int (*arr)[10])
 }
 
 SEC("cgroup_skb/ingress")
-__failure __msg("invalid indirect read from stack")
+__success
 int global_func16(struct __sk_buff *skb)
 {
 	int array[10];
diff --git a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
index 359df865a8f3..8d77cc5323d3 100644
--- a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
@@ -27,8 +27,8 @@ __naked void stack_out_of_bounds(void)
 
 SEC("socket")
 __description("uninitialized stack1")
-__failure __msg("invalid indirect read from stack")
-__failure_unpriv
+__success __log_level(4) __msg("stack depth 8")
+__failure_unpriv __msg_unpriv("invalid indirect read from stack")
 __naked void uninitialized_stack1(void)
 {
 	asm volatile ("					\
@@ -45,8 +45,8 @@ __naked void uninitialized_stack1(void)
 
 SEC("socket")
 __description("uninitialized stack2")
-__failure __msg("invalid read from stack")
-__failure_unpriv
+__success __log_level(4) __msg("stack depth 8")
+__failure_unpriv __msg_unpriv("invalid read from stack")
 __naked void uninitialized_stack2(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_int_ptr.c b/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
index b054f9c48143..589e8270de46 100644
--- a/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
@@ -5,9 +5,10 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
-SEC("cgroup/sysctl")
+SEC("socket")
 __description("ARG_PTR_TO_LONG uninitialized")
-__failure __msg("invalid indirect read from stack R4 off -16+0 size 8")
+__success
+__failure_unpriv __msg_unpriv("invalid indirect read from stack R4 off -16+0 size 8")
 __naked void arg_ptr_to_long_uninitialized(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
index efbfc3a4ad6a..f67390224a9c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
@@ -5,9 +5,10 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
-SEC("tc")
+SEC("socket")
 __description("raw_stack: no skb_load_bytes")
-__failure __msg("invalid read from stack R6 off=-8 size=8")
+__success
+__failure_unpriv __msg_unpriv("invalid read from stack R6 off=-8 size=8")
 __naked void stack_no_skb_load_bytes(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
index 83a90afba785..d1f23c1a7c5b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
+++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
@@ -59,9 +59,10 @@ __naked void stack_read_priv_vs_unpriv(void)
 "	::: __clobber_all);
 }
 
-SEC("lwt_in")
+SEC("cgroup/skb")
 __description("variable-offset stack read, uninitialized")
-__failure __msg("invalid variable-offset read from stack R2")
+__success
+__failure_unpriv __msg_unpriv("R2 variable stack access prohibited for !root")
 __naked void variable_offset_stack_read_uninitialized(void)
 {
 	asm volatile ("					\
@@ -83,12 +84,55 @@ __naked void variable_offset_stack_read_uninitialized(void)
 
 SEC("socket")
 __description("variable-offset stack write, priv vs unpriv")
-__success __failure_unpriv
+__success
+/* Check that the maximum stack depth is correctly maintained according to the
+ * maximum possible variable offset.
+ */
+__log_level(4) __msg("stack depth 16")
+__failure_unpriv
 /* Variable stack access is rejected for unprivileged.
  */
 __msg_unpriv("R2 variable stack access prohibited for !root")
 __retval(0)
 __naked void stack_write_priv_vs_unpriv(void)
+{
+	asm volatile ("                               \
+	/* Get an unknown value */                    \
+	r2 = *(u32*)(r1 + 0);                         \
+	/* Make it small and 8-byte aligned */        \
+	r2 &= 8;                                      \
+	r2 -= 16;                                     \
+	/* Add it to fp. We now have either fp-8 or   \
+	 * fp-16, but we don't know which             \
+	 */                                           \
+	r2 += r10;                                    \
+	/* Dereference it for a stack write */        \
+	r0 = 0;                                       \
+	*(u64*)(r2 + 0) = r0;                         \
+	exit;                                         \
+"	::: __clobber_all);
+}
+
+/* Similar to the previous test, but this time also perform a read from the
+ * address written to with a variable offset. The read is allowed, showing that,
+ * after a variable-offset write, a priviledged program can read the slots that
+ * were in the range of that write (even if the verifier doesn't actually know if
+ * the slot being read was really written to or not.
+ *
+ * Despite this test being mostly a superset, the previous test is also kept for
+ * the sake of it checking the stack depth in the case where there is no read.
+ */
+SEC("socket")
+__description("variable-offset stack write followed by read")
+__success
+/* Check that the maximum stack depth is correctly maintained according to the
+ * maximum possible variable offset.
+ */
+__log_level(4) __msg("stack depth 16")
+__failure_unpriv
+__msg_unpriv("R2 variable stack access prohibited for !root")
+__retval(0)
+__naked void stack_write_followed_by_read(void)
 {
 	asm volatile ("					\
 	/* Get an unknown value */			\
@@ -103,12 +147,7 @@ __naked void stack_write_priv_vs_unpriv(void)
 	/* Dereference it for a stack write */		\
 	r0 = 0;						\
 	*(u64*)(r2 + 0) = r0;				\
-	/* Now read from the address we just wrote. This shows\
-	 * that, after a variable-offset write, a priviledged\
-	 * program can read the slots that were in the range of\
-	 * that write (even if the verifier doesn't actually know\
-	 * if the slot being read was really written to or not.\
-	 */						\
+	/* Now read from the address we just wrote. */ \
 	r3 = *(u64*)(r2 + 0);				\
 	r0 = 0;						\
 	exit;						\
@@ -253,9 +292,10 @@ __naked void access_min_out_of_bound(void)
 	: __clobber_all);
 }
 
-SEC("lwt_in")
+SEC("cgroup/skb")
 __description("indirect variable-offset stack access, min_off < min_initialized")
-__failure __msg("invalid indirect read from stack R2 var_off")
+__success
+__failure_unpriv __msg_unpriv("R2 variable stack access prohibited for !root")
 __naked void access_min_off_min_initialized(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
index 319337bdcfc8..9a7b1106fda8 100644
--- a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
+++ b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
@@ -83,17 +83,6 @@
 	.result = REJECT,
 	.errstr = "!read_ok",
 },
-{
-	"Can't use cmpxchg on uninit memory",
-	.insns = {
-		BPF_MOV64_IMM(BPF_REG_0, 3),
-		BPF_MOV64_IMM(BPF_REG_2, 4),
-		BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, BPF_REG_10, BPF_REG_2, -8),
-		BPF_EXIT_INSN(),
-	},
-	.result = REJECT,
-	.errstr = "invalid read from stack",
-},
 {
 	"BPF_W cmpxchg should zero top 32 bits",
 	.insns = {
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 3d5cd51071f0..ab25a81fd3a1 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -1505,7 +1505,9 @@
 	.prog_type = BPF_PROG_TYPE_XDP,
 	.fixup_map_hash_8b = { 23 },
 	.result = REJECT,
-	.errstr = "invalid read from stack R7 off=-16 size=8",
+	.errstr = "R0 invalid mem access 'scalar'",
+	.result_unpriv = REJECT,
+	.errstr_unpriv = "invalid read from stack R7 off=-16 size=8",
 },
 {
 	"calls: two calls that receive map_value via arg=ptr_stack_of_caller. test1",
-- 
2.40.1


