Return-Path: <bpf+bounces-15861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5574A7F90B2
	for <lists+bpf@lfdr.de>; Sun, 26 Nov 2023 02:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFF7AB20FBD
	for <lists+bpf@lfdr.de>; Sun, 26 Nov 2023 01:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6062111D;
	Sun, 26 Nov 2023 01:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwC2URNC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F131C6
	for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 17:53:25 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-67a35b68c34so2479246d6.3
        for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 17:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700963604; x=1701568404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kr76JfGPoUPzsnkTHb7uqRyqNUAVL1oHAUQkoDeK6xQ=;
        b=GwC2URNCP1IQB7LrFP6O+ojloCoDvslIR+sjl+//nZSLIQQ7Mc4/TLU/zG9D83Bx1b
         ntukiwwWkRtEmIsMBDro+qI599crznpekvShLcCPPk3sgUrrPceWCC4BK+SbXEO/vAww
         bpcW3RlbfoOeZYG+4B/vB+SFoWnJOxVK7To+D/kajCxPctMIh+tQb13+ZhVlfcT5wRNb
         avmK3cqIMBZuUPg10QPBr4vHwM12cKpno/G3m5IH/yCQKm5vNyrND4C3Vb6eojil3OuZ
         v6TEKc7K5o0XjgB7SJuFlhVNlaSQ9zTKCreMAGiQ+EWOw/igo6LcD4lt/gwhJnbrQhOr
         naLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700963604; x=1701568404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kr76JfGPoUPzsnkTHb7uqRyqNUAVL1oHAUQkoDeK6xQ=;
        b=vmti9ww6i3kPgf9QrmFx+CAu7fEdHhkAettRzz6YKd/lxTVNj7SiU/KkFggE4pLz0k
         8RkZOA2xC74OApuVQiwuPA4Ble2fZjrbkkT6u+Mewo8aAj4+Ixer4mVxS+q2/YRfxDLk
         hFxl1RQBKqqSUGASRrZRid2hKP2jQnwEKL47OxjJTKY9TEBFkPG2SAzgn1/ExxYs9qK9
         iAbRgVcGyNTIZh1Hqm4v44tqcX5n2ZCQqZaWZZJI4l3l/4BS3Xm/QUOOPBFkYJ0cSQmi
         KwA1oB5X4/6jrTANGMBqhOSzhhz/np/8EtGbC6CQexxq2YSDoYljdS46HAzQh9NqTKzL
         Jiqg==
X-Gm-Message-State: AOJu0YzE0Oy9DEmrDRMHHpuxVQi/gbl3oJ3dA8rPZoZyzP4nFMb6un8L
	J/pzNpbFnrYU9ck9Ug5gVajR9NZEYUc=
X-Google-Smtp-Source: AGHT+IErn+E8r3KMEJCBLZ9aGSSefwyhxiljIM/YkSLQ7y9mff5djc97e7ZKSUkDIwZVnA/LA/KY/w==
X-Received: by 2002:ad4:4582:0:b0:67a:2c28:ce06 with SMTP id x2-20020ad44582000000b0067a2c28ce06mr2397493qvu.63.1700963603627;
        Sat, 25 Nov 2023 17:53:23 -0800 (PST)
Received: from andrei-framework.. (c-73-133-17-174.hsd1.md.comcast.net. [73.133.17.174])
        by smtp.gmail.com with ESMTPSA id k11-20020a0cb24b000000b0066cfbe4e0f4sm1245501qve.26.2023.11.25.17.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 17:53:23 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org,
	andrii.nakryiko@gmail.com
Cc: sunhao.th@gmail.com,
	eddyz87@gmail.com,
	kernel-team@dataexmachina.dev,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf v2 1/2] bpf: fix accesses to uninit stack slots
Date: Sat, 25 Nov 2023 20:50:45 -0500
Message-Id: <20231126015045.1092826-2-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231126015045.1092826-1-andreimatei1@gmail.com>
References: <20231126015045.1092826-1-andreimatei1@gmail.com>
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
This patch arranges for these accesses to be permitted.

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

Reported-by: Hao Sun <sunhao.th@gmail.com>
Fixes: 01f810ace9ed3 ("bpf: Allow variable-offset stack access")
Closes: https://lore.kernel.org/bpf/CABWLsev9g8UP_c3a=1qbuZUi20tGoUXoU07FPf-5FLvhOKOY+Q@mail.gmail.com/
Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 include/linux/bpf_verifier.h                  |  4 ++
 kernel/bpf/verifier.c                         | 70 ++++++++-----------
 .../selftests/bpf/progs/test_global_func16.c  |  2 +-
 .../bpf/progs/verifier_basic_stack.c          |  6 +-
 .../selftests/bpf/progs/verifier_int_ptr.c    |  2 +-
 .../selftests/bpf/progs/verifier_raw_stack.c  |  2 +-
 .../selftests/bpf/progs/verifier_var_off.c    |  4 +-
 .../selftests/bpf/verifier/atomic_cmpxchg.c   | 11 ---
 tools/testing/selftests/bpf/verifier/calls.c  |  2 +-
 9 files changed, 42 insertions(+), 61 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index aa4d19d0bc94..5fc389e8be35 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -630,6 +630,10 @@ struct bpf_verifier_env {
 	int exception_callback_subprog;
 	bool explore_alu_limits;
 	bool allow_ptr_leaks;
+	/* Allow access to uninitialized stack memory. Writes with fixed offset are
+	 * always allowed, so this refers to reads (with fixed or variable offset),
+	 * to writes with variable offset and to indirect (helper) accesses.
+	 */
 	bool allow_uninit_stack;
 	bool bpf_capable;
 	bool bypass_spec_v1;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index af2819d5c8ee..f9546dd73f3c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1685,10 +1685,12 @@ static int resize_reference_state(struct bpf_func_state *state, size_t n)
 	return 0;
 }
 
-static int grow_stack_state(struct bpf_func_state *state, int size)
+/* Possibly update state->allocated_stack to be at least size bytes. Also
+ * possibly update the function's high-water mark in its bpf_subprog_info.
+ */
+static int grow_stack_state(struct bpf_verifier_env *env, struct bpf_func_state *state, int size)
 {
 	size_t old_n = state->allocated_stack / BPF_REG_SIZE, n = size / BPF_REG_SIZE;
-
 	if (old_n >= n)
 		return 0;
 
@@ -1697,6 +1699,12 @@ static int grow_stack_state(struct bpf_func_state *state, int size)
 		return -ENOMEM;
 
 	state->allocated_stack = size;
+
+	/* update known max for given subprogram */
+	u16 stack = env->subprog_info[state->subprogno].stack_depth;
+	if (stack < size)
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
@@ -6761,13 +6748,15 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
  * The minimum valid offset is -MAX_BPF_STACK for writes, and
  * -state->allocated_stack for reads.
  */
-static int check_stack_slot_within_bounds(int off,
-					  struct bpf_func_state *state,
-					  enum bpf_access_type t)
+static int check_stack_slot_within_bounds(
+		struct bpf_verifier_env *env,
+		int off,
+		struct bpf_func_state *state,
+		enum bpf_access_type t)
 {
 	int min_valid_off;
 
-	if (t == BPF_WRITE)
+	if (t == BPF_WRITE || env->allow_uninit_stack)
 		min_valid_off = -MAX_BPF_STACK;
 	else
 		min_valid_off = -state->allocated_stack;
@@ -6822,9 +6811,9 @@ static int check_stack_access_within_bounds(
 			max_off = min_off;
 	}
 
-	err = check_stack_slot_within_bounds(min_off, state, type);
+	err = check_stack_slot_within_bounds(env, min_off, state, type);
 	if (!err)
-		err = check_stack_slot_within_bounds(max_off, state, type);
+		err = check_stack_slot_within_bounds(env, max_off, state, type);
 
 	if (err) {
 		if (tnum_is_const(reg->var_off)) {
@@ -6837,8 +6826,10 @@ static int check_stack_access_within_bounds(
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
@@ -6853,7 +6844,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 {
 	struct bpf_reg_state *regs = cur_regs(env);
 	struct bpf_reg_state *reg = regs + regno;
-	struct bpf_func_state *state;
 	int size, err = 0;
 
 	size = bpf_size_to_bytes(bpf_size);
@@ -6996,11 +6986,6 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
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
@@ -7195,7 +7180,8 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 
 /* When register 'regno' is used to read the stack (either directly or through
  * a helper function) make sure that it's within stack boundary and, depending
- * on the access type, that all elements of the stack are initialized.
+ * on the access type and privileges, that all elements of the stack are
+ * initialized.
  *
  * 'off' includes 'regno->off', but not its dynamic part (if any).
  *
@@ -7303,8 +7289,11 @@ static int check_stack_range_initialized(
 
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
@@ -7328,7 +7317,6 @@ static int check_stack_range_initialized(
 			goto mark;
 		}
 
-err:
 		if (tnum_is_const(reg->var_off)) {
 			verbose(env, "invalid%s read from stack R%d off %d+%d size %d\n",
 				err_extra, regno, min_off, i - min_off, access_size);
@@ -7353,7 +7341,7 @@ static int check_stack_range_initialized(
 		 * helper may write to the entire memory range.
 		 */
 	}
-	return update_stack_depth(env, state, min_off);
+	return 0;
 }
 
 static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
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
index 359df865a8f3..069c3f91705c 100644
--- a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
@@ -27,8 +27,8 @@ __naked void stack_out_of_bounds(void)
 
 SEC("socket")
 __description("uninitialized stack1")
-__failure __msg("invalid indirect read from stack")
-__failure_unpriv
+__success
+__failure_unpriv __msg_unpriv("invalid indirect read from stack")
 __naked void uninitialized_stack1(void)
 {
 	asm volatile ("					\
@@ -45,7 +45,7 @@ __naked void uninitialized_stack1(void)
 
 SEC("socket")
 __description("uninitialized stack2")
-__failure __msg("invalid read from stack")
+__success
 __failure_unpriv
 __naked void uninitialized_stack2(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_int_ptr.c b/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
index b054f9c48143..b5cedc0d23c1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_int_ptr.c
@@ -7,7 +7,7 @@
 
 SEC("cgroup/sysctl")
 __description("ARG_PTR_TO_LONG uninitialized")
-__failure __msg("invalid indirect read from stack R4 off -16+0 size 8")
+__success
 __naked void arg_ptr_to_long_uninitialized(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
index efbfc3a4ad6a..5468c5302495 100644
--- a/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_raw_stack.c
@@ -7,7 +7,7 @@
 
 SEC("tc")
 __description("raw_stack: no skb_load_bytes")
-__failure __msg("invalid read from stack R6 off=-8 size=8")
+__success
 __naked void stack_no_skb_load_bytes(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
index 83a90afba785..bbf3628c625a 100644
--- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
+++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
@@ -61,7 +61,7 @@ __naked void stack_read_priv_vs_unpriv(void)
 
 SEC("lwt_in")
 __description("variable-offset stack read, uninitialized")
-__failure __msg("invalid variable-offset read from stack R2")
+__success
 __naked void variable_offset_stack_read_uninitialized(void)
 {
 	asm volatile ("					\
@@ -255,7 +255,7 @@ __naked void access_min_out_of_bound(void)
 
 SEC("lwt_in")
 __description("indirect variable-offset stack access, min_off < min_initialized")
-__failure __msg("invalid indirect read from stack R2 var_off")
+__success
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
index 3d5cd51071f0..89b79997c1b4 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -1505,7 +1505,7 @@
 	.prog_type = BPF_PROG_TYPE_XDP,
 	.fixup_map_hash_8b = { 23 },
 	.result = REJECT,
-	.errstr = "invalid read from stack R7 off=-16 size=8",
+	.errstr = "R0 invalid mem access 'scalar'",
 },
 {
 	"calls: two calls that receive map_value via arg=ptr_stack_of_caller. test1",
-- 
2.40.1


