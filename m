Return-Path: <bpf+bounces-64086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C1FB0E2A3
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 19:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478535680F2
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 17:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA3C27E1AC;
	Tue, 22 Jul 2025 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlCIe9FQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1035234
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753205583; cv=none; b=Cos78s91P/l9FZQFP4QdRc229dITZR0fR9GCcdnQYXH2xTRU/JoMEu2HBDAK91qziaqgiTvCiRjG5MLrPv9L7ycvDhWNGgCqVIv3KqzD/OS8Whz18jjncnNJ2dy/zQtpTBUnFz0hDmmwarrVF1Xv8Z66Bl+bpyj+vxFM2e4O41U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753205583; c=relaxed/simple;
	bh=Qoukclw0KYaiazGAATKMFmXuR9PxEJH0YMOlXhnTTgw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=SYA8gQcdsQx2c+B50w1vhCUoOk41Z0KI4T7JTchK+94/Ycg6BugVbuYORWtVNU3qrTZs7QWWsFDgUNDwyE+bh/MXdRND1BOuNdV/1cF4WI1EnTdeUrk6VSUnvFyzoZhD5uKnjk5qjaS63uJri0r3++IcZs1xZbQg/UscW04wokk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlCIe9FQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681D6C4CEEB;
	Tue, 22 Jul 2025 17:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753205582;
	bh=Qoukclw0KYaiazGAATKMFmXuR9PxEJH0YMOlXhnTTgw=;
	h=From:To:Subject:Date:From;
	b=tlCIe9FQoL7PYk33fqj8JOxm7zliJeEZPcrUw7SZOAaGe0oLpJRDZE3O3YWetEnJh
	 /QhgclB8qZpdQxQiaPgw1CIx1IDoShd5pz7j0CTyqkGIDsvot/6JsV51PpMIb6wTEq
	 NZ5tfX5PkyCXgQr9+Yr5hcbCWr9czorHWehsdUTU1nM9sUxBIqUrijTOv0b4t3jViE
	 TlKjhNVPlIgHKnTRD6sAI9PG5etEAvXnIMPRVTs1rYAuDk07kVSLOqD5zfsSlUrsNV
	 D6kOGkJ0Bas/0B5bB/AlW2L4a3Zg64tTYlX1mqyReqm2VEd8iZtORzUK3yG+e4fiON
	 jP6q5AIGgDvEg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next] bpf, arm64: JIT support for private stack
Date: Tue, 22 Jul 2025 17:32:50 +0000
Message-ID: <20250722173254.3879-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The private stack is allocated in bpf_int_jit_compile() with 16-byte
alignment. It includes additional guard regions to detect stack
overflows and underflows at runtime.

Memory layout:

              +------------------------------------------------------+
              |                                                      |
              |  16 bytes padding (overflow guard - stack top)       |
              |  [ detects writes beyond top of stack ]              |
     BPF FP ->+------------------------------------------------------+
              |                                                      |
              |  BPF private stack (sized by verifier)               |
              |  [ 16-byte aligned ]                                 |
              |                                                      |
BPF PRIV SP ->+------------------------------------------------------+
              |                                                      |
              |  16 bytes padding (underflow guard - stack bottom)   |
              |  [ detects accesses before start of stack ]          |
              |                                                      |
              +------------------------------------------------------+

On detection of an overflow or underflow, the kernel emits messages
like:
    BPF private stack overflow/underflow detected for prog <prog_name>

After commit bd737fcb6485 ("bpf, arm64: Get rid of fpb"), Jited BPF
programs use the stack in two ways:
1. Via the BPF frame pointer (top of stack), using negative offsets.
2. Via the stack pointer (bottom of stack), using positive offsets in
   LDR/STR instructions.

When a private stack is used, ARM64 callee-saved register x27 replaces
the stack pointer. The BPF frame pointer usage remains unchanged; but it
now points to the top of the private stack.

Relevant tests:

 #415/1   struct_ops_private_stack/private_stack:OK
 #415/2   struct_ops_private_stack/private_stack_fail:OK
 #415/3   struct_ops_private_stack/private_stack_recur:OK
 #415     struct_ops_private_stack:OK
 #549/1   verifier_private_stack/Private stack, single prog:OK
 #549/2   verifier_private_stack/Private stack, subtree > MAX_BPF_STACK:OK
 #549/3   verifier_private_stack/No private stack:OK
 #549/4   verifier_private_stack/Private stack, callback:OK
 #549/5   verifier_private_stack/Private stack, exception in main prog:OK
 #549/6   verifier_private_stack/Private stack, exception in subprog:OK
 #549/7   verifier_private_stack/Private stack, async callback, not nested:OK
 #549/8   verifier_private_stack/Private stack, async callback, potential nesting:OK
 #549     verifier_private_stack:OK
 Summary: 2/11 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
Note: This needs the fix in [1] to work properly.
[1] https://lore.kernel.org/all/20250722133410.54161-2-puranjay@kernel.org/
---
 arch/arm64/net/bpf_jit_comp.c                 | 131 ++++++++++++++++--
 arch/x86/net/bpf_jit_comp.c                   |   9 +-
 include/linux/filter.h                        |   2 +
 kernel/bpf/core.c                             |   7 +
 .../bpf/progs/struct_ops_private_stack.c      |   2 +-
 .../bpf/progs/struct_ops_private_stack_fail.c |   2 +-
 .../progs/struct_ops_private_stack_recur.c    |   2 +-
 .../bpf/progs/verifier_private_stack.c        |  89 +++++++++++-
 8 files changed, 221 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 89b1b8c248c62..5a0170536c8d4 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -30,6 +30,7 @@
 #define TMP_REG_2 (MAX_BPF_JIT_REG + 1)
 #define TCCNT_PTR (MAX_BPF_JIT_REG + 2)
 #define TMP_REG_3 (MAX_BPF_JIT_REG + 3)
+#define PRIVATE_SP (MAX_BPF_JIT_REG + 4)
 #define ARENA_VM_START (MAX_BPF_JIT_REG + 5)
 
 #define check_imm(bits, imm) do {				\
@@ -68,6 +69,8 @@ static const int bpf2a64[] = {
 	[TCCNT_PTR] = A64_R(26),
 	/* temporary register for blinding constants */
 	[BPF_REG_AX] = A64_R(9),
+	/* callee saved register for private stack pointer */
+	[PRIVATE_SP] = A64_R(27),
 	/* callee saved register for kern_vm_start address */
 	[ARENA_VM_START] = A64_R(28),
 };
@@ -86,6 +89,7 @@ struct jit_ctx {
 	u64 user_vm_start;
 	u64 arena_vm_start;
 	bool fp_used;
+	bool priv_sp_used;
 	bool write;
 };
 
@@ -98,6 +102,10 @@ struct bpf_plt {
 #define PLT_TARGET_SIZE   sizeof_field(struct bpf_plt, target)
 #define PLT_TARGET_OFFSET offsetof(struct bpf_plt, target)
 
+/* Memory size/value to protect private stack overflow/underflow */
+#define PRIV_STACK_GUARD_SZ    16
+#define PRIV_STACK_GUARD_VAL   0xEB9F12345678eb9fULL
+
 static inline void emit(const u32 insn, struct jit_ctx *ctx)
 {
 	if (ctx->image != NULL && ctx->write)
@@ -387,8 +395,11 @@ static void find_used_callee_regs(struct jit_ctx *ctx)
 	if (reg_used & 8)
 		ctx->used_callee_reg[i++] = bpf2a64[BPF_REG_9];
 
-	if (reg_used & 16)
+	if (reg_used & 16) {
 		ctx->used_callee_reg[i++] = bpf2a64[BPF_REG_FP];
+		if (ctx->priv_sp_used)
+			ctx->used_callee_reg[i++] = bpf2a64[PRIVATE_SP];
+	}
 
 	if (ctx->arena_vm_start)
 		ctx->used_callee_reg[i++] = bpf2a64[ARENA_VM_START];
@@ -461,6 +472,19 @@ static void pop_callee_regs(struct jit_ctx *ctx)
 	}
 }
 
+static void emit_percpu_ptr(const u8 dst_reg, void __percpu *ptr,
+			    struct jit_ctx *ctx)
+{
+	const u8 tmp = bpf2a64[TMP_REG_1];
+
+	emit_a64_mov_i64(dst_reg, (__force const u64)ptr, ctx);
+	if (cpus_have_cap(ARM64_HAS_VIRT_HOST_EXTN))
+		emit(A64_MRS_TPIDR_EL2(tmp), ctx);
+	else
+		emit(A64_MRS_TPIDR_EL1(tmp), ctx);
+	emit(A64_ADD(1, dst_reg, dst_reg, tmp), ctx);
+}
+
 #define BTI_INSNS (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL) ? 1 : 0)
 #define PAC_INSNS (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL) ? 1 : 0)
 
@@ -476,6 +500,8 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 	const bool is_main_prog = !bpf_is_subprog(prog);
 	const u8 fp = bpf2a64[BPF_REG_FP];
 	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
+	const u8 priv_sp = bpf2a64[PRIVATE_SP];
+	void __percpu *priv_stack_ptr;
 	const int idx0 = ctx->idx;
 	int cur_offset;
 
@@ -551,15 +577,23 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 		emit(A64_SUB_I(1, A64_SP, A64_FP, 96), ctx);
 	}
 
-	if (ctx->fp_used)
-		/* Set up BPF prog stack base register */
-		emit(A64_MOV(1, fp, A64_SP), ctx);
-
 	/* Stack must be multiples of 16B */
 	ctx->stack_size = round_up(prog->aux->stack_depth, 16);
 
+	if (ctx->fp_used) {
+		if (ctx->priv_sp_used) {
+			/* Set up private stack pointer */
+			priv_stack_ptr = prog->aux->priv_stack_ptr + PRIV_STACK_GUARD_SZ;
+			emit_percpu_ptr(priv_sp, priv_stack_ptr, ctx);
+			emit(A64_ADD_I(1, fp, priv_sp, ctx->stack_size), ctx);
+		} else {
+			/* Set up BPF prog stack base register */
+			emit(A64_MOV(1, fp, A64_SP), ctx);
+		}
+	}
+
 	/* Set up function call stack */
-	if (ctx->stack_size)
+	if (ctx->stack_size && !ctx->priv_sp_used)
 		emit(A64_SUB_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
 
 	if (ctx->arena_vm_start)
@@ -623,7 +657,7 @@ static int emit_bpf_tail_call(struct jit_ctx *ctx)
 	emit(A64_STR64I(tcc, ptr, 0), ctx);
 
 	/* restore SP */
-	if (ctx->stack_size)
+	if (ctx->stack_size && !ctx->priv_sp_used)
 		emit(A64_ADD_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
 
 	pop_callee_regs(ctx);
@@ -991,7 +1025,7 @@ static void build_epilogue(struct jit_ctx *ctx, bool was_classic)
 	const u8 ptr = bpf2a64[TCCNT_PTR];
 
 	/* We're done with BPF stack */
-	if (ctx->stack_size)
+	if (ctx->stack_size && !ctx->priv_sp_used)
 		emit(A64_ADD_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
 
 	pop_callee_regs(ctx);
@@ -1120,6 +1154,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	const u8 tmp2 = bpf2a64[TMP_REG_2];
 	const u8 fp = bpf2a64[BPF_REG_FP];
 	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
+	const u8 priv_sp = bpf2a64[PRIVATE_SP];
 	const s16 off = insn->off;
 	const s32 imm = insn->imm;
 	const int i = insn - ctx->prog->insnsi;
@@ -1564,7 +1599,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			src = tmp2;
 		}
 		if (src == fp) {
-			src_adj = A64_SP;
+			src_adj = ctx->priv_sp_used ? priv_sp : A64_SP;
 			off_adj = off + ctx->stack_size;
 		} else {
 			src_adj = src;
@@ -1654,7 +1689,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			dst = tmp2;
 		}
 		if (dst == fp) {
-			dst_adj = A64_SP;
+			dst_adj = ctx->priv_sp_used ? priv_sp : A64_SP;
 			off_adj = off + ctx->stack_size;
 		} else {
 			dst_adj = dst;
@@ -1716,7 +1751,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			dst = tmp2;
 		}
 		if (dst == fp) {
-			dst_adj = A64_SP;
+			dst_adj = ctx->priv_sp_used ? priv_sp : A64_SP;
 			off_adj = off + ctx->stack_size;
 		} else {
 			dst_adj = dst;
@@ -1859,6 +1894,39 @@ static inline void bpf_flush_icache(void *start, void *end)
 	flush_icache_range((unsigned long)start, (unsigned long)end);
 }
 
+static void priv_stack_init_guard(void __percpu *priv_stack_ptr, int alloc_size)
+{
+	int cpu, underflow_idx = (alloc_size - PRIV_STACK_GUARD_SZ) >> 3;
+	u64 *stack_ptr;
+
+	for_each_possible_cpu(cpu) {
+		stack_ptr = per_cpu_ptr(priv_stack_ptr, cpu);
+		stack_ptr[0] = PRIV_STACK_GUARD_VAL;
+		stack_ptr[1] = PRIV_STACK_GUARD_VAL;
+		stack_ptr[underflow_idx] = PRIV_STACK_GUARD_VAL;
+		stack_ptr[underflow_idx + 1] = PRIV_STACK_GUARD_VAL;
+	}
+}
+
+static void priv_stack_check_guard(void __percpu *priv_stack_ptr, int alloc_size,
+				   struct bpf_prog *prog)
+{
+	int cpu, underflow_idx = (alloc_size - PRIV_STACK_GUARD_SZ) >> 3;
+	u64 *stack_ptr;
+
+	for_each_possible_cpu(cpu) {
+		stack_ptr = per_cpu_ptr(priv_stack_ptr, cpu);
+		if (stack_ptr[0] != PRIV_STACK_GUARD_VAL ||
+		    stack_ptr[1] != PRIV_STACK_GUARD_VAL ||
+		    stack_ptr[underflow_idx] != PRIV_STACK_GUARD_VAL ||
+		    stack_ptr[underflow_idx + 1] != PRIV_STACK_GUARD_VAL) {
+			pr_err("BPF private stack overflow/underflow detected for prog %sx\n",
+			       bpf_jit_get_prog_name(prog));
+			break;
+		}
+	}
+}
+
 struct arm64_jit_data {
 	struct bpf_binary_header *header;
 	u8 *ro_image;
@@ -1873,7 +1941,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	struct bpf_binary_header *header;
 	struct bpf_binary_header *ro_header;
 	struct arm64_jit_data *jit_data;
+	void __percpu *priv_stack_ptr = NULL;
 	bool was_classic = bpf_prog_was_classic(prog);
+	int priv_stack_alloc_sz;
 	bool tmp_blinded = false;
 	bool extra_pass = false;
 	struct jit_ctx ctx;
@@ -1905,6 +1975,23 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		}
 		prog->aux->jit_data = jit_data;
 	}
+	priv_stack_ptr = prog->aux->priv_stack_ptr;
+	if (!priv_stack_ptr && prog->aux->jits_use_priv_stack) {
+		/* Allocate actual private stack size with verifier-calculated
+		 * stack size plus two memory guards to protect overflow and
+		 * underflow.
+		 */
+		priv_stack_alloc_sz = round_up(prog->aux->stack_depth, 16) +
+				      2 * PRIV_STACK_GUARD_SZ;
+		priv_stack_ptr = __alloc_percpu_gfp(priv_stack_alloc_sz, 16, GFP_KERNEL);
+		if (!priv_stack_ptr) {
+			prog = orig_prog;
+			goto out_priv_stack;
+		}
+
+		priv_stack_init_guard(priv_stack_ptr, priv_stack_alloc_sz);
+		prog->aux->priv_stack_ptr = priv_stack_ptr;
+	}
 	if (jit_data->ctx.offset) {
 		ctx = jit_data->ctx;
 		ro_image_ptr = jit_data->ro_image;
@@ -1928,6 +2015,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
 	ctx.arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
 
+	if (priv_stack_ptr)
+		ctx.priv_sp_used = true;
+
 	/* Pass 1: Estimate the maximum image size.
 	 *
 	 * BPF line info needs ctx->offset[i] to be the offset of
@@ -2067,7 +2157,12 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 			ctx.offset[i] *= AARCH64_INSN_SIZE;
 		bpf_prog_fill_jited_linfo(prog, ctx.offset + 1);
 out_off:
+		if (!ro_header && priv_stack_ptr) {
+			free_percpu(priv_stack_ptr);
+			prog->aux->priv_stack_ptr = NULL;
+		}
 		kvfree(ctx.offset);
+out_priv_stack:
 		kfree(jit_data);
 		prog->aux->jit_data = NULL;
 	}
@@ -2086,6 +2181,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	goto out_off;
 }
 
+bool bpf_jit_supports_private_stack(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_kfunc_call(void)
 {
 	return true;
@@ -2931,6 +3031,8 @@ void bpf_jit_free(struct bpf_prog *prog)
 	if (prog->jited) {
 		struct arm64_jit_data *jit_data = prog->aux->jit_data;
 		struct bpf_binary_header *hdr;
+		void __percpu *priv_stack_ptr;
+		int priv_stack_alloc_sz;
 
 		/*
 		 * If we fail the final pass of JIT (from jit_subprogs),
@@ -2944,6 +3046,13 @@ void bpf_jit_free(struct bpf_prog *prog)
 		}
 		hdr = bpf_jit_binary_pack_hdr(prog);
 		bpf_jit_binary_pack_free(hdr, NULL);
+		priv_stack_ptr = prog->aux->priv_stack_ptr;
+		if (priv_stack_ptr) {
+			priv_stack_alloc_sz = round_up(prog->aux->stack_depth, 16) +
+					      2 * PRIV_STACK_GUARD_SZ;
+			priv_stack_check_guard(priv_stack_ptr, priv_stack_alloc_sz, prog);
+			free_percpu(prog->aux->priv_stack_ptr);
+		}
 		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(prog));
 	}
 
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 40e1b3b9634fe..7e3fca1646203 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3501,13 +3501,6 @@ int arch_prepare_bpf_dispatcher(void *image, void *buf, s64 *funcs, int num_func
 	return emit_bpf_dispatcher(&prog, 0, num_funcs - 1, funcs, image, buf);
 }
 
-static const char *bpf_get_prog_name(struct bpf_prog *prog)
-{
-	if (prog->aux->ksym.prog)
-		return prog->aux->ksym.name;
-	return prog->aux->name;
-}
-
 static void priv_stack_init_guard(void __percpu *priv_stack_ptr, int alloc_size)
 {
 	int cpu, underflow_idx = (alloc_size - PRIV_STACK_GUARD_SZ) >> 3;
@@ -3531,7 +3524,7 @@ static void priv_stack_check_guard(void __percpu *priv_stack_ptr, int alloc_size
 		if (stack_ptr[0] != PRIV_STACK_GUARD_VAL ||
 		    stack_ptr[underflow_idx] != PRIV_STACK_GUARD_VAL) {
 			pr_err("BPF private stack overflow/underflow detected for prog %sx\n",
-			       bpf_get_prog_name(prog));
+			       bpf_jit_get_prog_name(prog));
 			break;
 		}
 	}
diff --git a/include/linux/filter.h b/include/linux/filter.h
index eca229752cbef..5cc7a82ec8322 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1278,6 +1278,8 @@ int bpf_jit_get_func_addr(const struct bpf_prog *prog,
 			  const struct bpf_insn *insn, bool extra_pass,
 			  u64 *func_addr, bool *func_addr_fixed);
 
+const char *bpf_jit_get_prog_name(struct bpf_prog *prog);
+
 struct bpf_prog *bpf_jit_blind_constants(struct bpf_prog *fp);
 void bpf_jit_prog_release_other(struct bpf_prog *fp, struct bpf_prog *fp_other);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 61613785bdd0f..29c0225c14aa9 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1297,6 +1297,13 @@ int bpf_jit_get_func_addr(const struct bpf_prog *prog,
 	return 0;
 }
 
+const char *bpf_jit_get_prog_name(struct bpf_prog *prog)
+{
+	if (prog->aux->ksym.prog)
+		return prog->aux->ksym.name;
+	return prog->aux->name;
+}
+
 static int bpf_jit_blind_insn(const struct bpf_insn *from,
 			      const struct bpf_insn *aux,
 			      struct bpf_insn *to_buff,
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
index 0e4d2ff63ab81..dbe646013811a 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
@@ -7,7 +7,7 @@
 
 char _license[] SEC("license") = "GPL";
 
-#if defined(__TARGET_ARCH_x86)
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
 bool skip __attribute((__section__(".data"))) = false;
 #else
 bool skip = true;
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
index 58d5d8dc22352..3d89ad7cbe2a9 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
@@ -7,7 +7,7 @@
 
 char _license[] SEC("license") = "GPL";
 
-#if defined(__TARGET_ARCH_x86)
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
 bool skip __attribute((__section__(".data"))) = false;
 #else
 bool skip = true;
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
index 31e58389bb8b0..b1f6d7e5a8e50 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
@@ -7,7 +7,7 @@
 
 char _license[] SEC("license") = "GPL";
 
-#if defined(__TARGET_ARCH_x86)
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
 bool skip __attribute((__section__(".data"))) = false;
 #else
 bool skip = true;
diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
index fc91b414364e0..1ecd34ebde196 100644
--- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
@@ -8,7 +8,7 @@
 /* From include/linux/filter.h */
 #define MAX_BPF_STACK    512
 
-#if defined(__TARGET_ARCH_x86)
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
 
 struct elem {
 	struct bpf_timer t;
@@ -30,6 +30,18 @@ __jited("	movabsq	$0x{{.*}}, %r9")
 __jited("	addq	%gs:{{.*}}, %r9")
 __jited("	movl	$0x2a, %edi")
 __jited("	movq	%rdi, -0x100(%r9)")
+__arch_arm64
+__jited("	stp	x25, x27, [sp, {{.*}}]!")
+__jited("	mov	x27, {{.*}}")
+__jited("	movk	x27, {{.*}}, lsl #16")
+__jited("	movk	x27, {{.*}}")
+__jited("	mrs	x10, TPIDR_EL{{[0-1]}}")
+__jited("	add	x27, x27, x10")
+__jited("	add	x25, x27, {{.*}}")
+__jited("	mov	x0, #0x2a")
+__jited("	str	x0, [x27]")
+__jited("...")
+__jited("	ldp	x25, x27, [sp], {{.*}}")
 __naked void private_stack_single_prog(void)
 {
 	asm volatile ("			\
@@ -45,6 +57,9 @@ __description("No private stack")
 __success
 __arch_x86_64
 __jited("	subq	$0x8, %rsp")
+__arch_arm64
+__jited("	mov	x25, sp")
+__jited("	sub	sp, sp, #0x10")
 __naked void no_private_stack_nested(void)
 {
 	asm volatile ("			\
@@ -81,6 +96,19 @@ __jited("	pushq	%r9")
 __jited("	callq	0x{{.*}}")
 __jited("	popq	%r9")
 __jited("	xorl	%eax, %eax")
+__arch_arm64
+__jited("	stp	x25, x27, [sp, {{.*}}]!")
+__jited("	mov	x27, {{.*}}")
+__jited("	movk	x27, {{.*}}, lsl #16")
+__jited("	movk	x27, {{.*}}")
+__jited("	mrs	x10, TPIDR_EL{{[0-1]}}")
+__jited("	add	x27, x27, x10")
+__jited("	add	x25, x27, {{.*}}")
+__jited("	mov	x0, #0x2a")
+__jited("	str	x0, [x27]")
+__jited("	bl	{{.*}}")
+__jited("...")
+__jited("	ldp	x25, x27, [sp], {{.*}}")
 __naked void private_stack_nested_1(void)
 {
 	asm volatile ("				\
@@ -131,6 +159,24 @@ __jited("	movq	%rdi, -0x200(%r9)")
 __jited("	pushq	%r9")
 __jited("	callq")
 __jited("	popq	%r9")
+__arch_arm64
+__jited("func #1")
+__jited("...")
+__jited("	stp	x25, x27, [sp, {{.*}}]!")
+__jited("	mov	x27, {{.*}}")
+__jited("	movk	x27, {{.*}}, lsl #16")
+__jited("	movk	x27, {{.*}}")
+__jited("	mrs	x10, TPIDR_EL{{[0-1]}}")
+__jited("	add	x27, x27, x10")
+__jited("	add	x25, x27, {{.*}}")
+__jited("	bl	0x{{.*}}")
+__jited("	add	x7, x0, #0x0")
+__jited("	mov	x0, #0x2a")
+__jited("	str	x0, [x27]")
+__jited("	bl	0x{{.*}}")
+__jited("	add	x7, x0, #0x0")
+__jited("	mov	x7, #0x0")
+__jited("	ldp	x25, x27, [sp], {{.*}}")
 __naked void private_stack_callback(void)
 {
 	asm volatile ("			\
@@ -154,6 +200,28 @@ __arch_x86_64
 __jited("	pushq	%r9")
 __jited("	callq")
 __jited("	popq	%r9")
+__arch_arm64
+__jited("	stp	x29, x30, [sp, #-0x10]!")
+__jited("	mov	x29, sp")
+__jited("	stp	xzr, x26, [sp, #-0x10]!")
+__jited("	mov	x26, sp")
+__jited("	stp	x19, x20, [sp, #-0x10]!")
+__jited("	stp	x21, x22, [sp, #-0x10]!")
+__jited("	stp	x23, x24, [sp, #-0x10]!")
+__jited("	stp	x25, x26, [sp, #-0x10]!")
+__jited("	stp	x27, x28, [sp, #-0x10]!")
+__jited("	mov	x27, {{.*}}")
+__jited("	movk	x27, {{.*}}, lsl #16")
+__jited("	movk	x27, {{.*}}")
+__jited("	mrs	x10, TPIDR_EL{{[0-1]}}")
+__jited("	add	x27, x27, x10")
+__jited("	add	x25, x27, {{.*}}")
+__jited("	mov	x0, #0x2a")
+__jited("	str	x0, [x27]")
+__jited("	mov	x0, #0x0")
+__jited("	bl	0x{{.*}}")
+__jited("	add	x7, x0, #0x0")
+__jited("	ldp	x27, x28, [sp], #0x10")
 int private_stack_exception_main_prog(void)
 {
 	asm volatile ("			\
@@ -179,6 +247,19 @@ __jited("	movq	%rdi, -0x200(%r9)")
 __jited("	pushq	%r9")
 __jited("	callq")
 __jited("	popq	%r9")
+__arch_arm64
+__jited("	stp	x27, x28, [sp, #-0x10]!")
+__jited("	mov	x27, {{.*}}")
+__jited("	movk	x27, {{.*}}, lsl #16")
+__jited("	movk	x27, {{.*}}")
+__jited("	mrs	x10, TPIDR_EL{{[0-1]}}")
+__jited("	add	x27, x27, x10")
+__jited("	add	x25, x27, {{.*}}")
+__jited("	mov	x0, #0x2a")
+__jited("	str	x0, [x27]")
+__jited("	bl	0x{{.*}}")
+__jited("	add	x7, x0, #0x0")
+__jited("	ldp	x27, x28, [sp], #0x10")
 int private_stack_exception_sub_prog(void)
 {
 	asm volatile ("			\
@@ -220,6 +301,10 @@ __description("Private stack, async callback, not nested")
 __success __retval(0)
 __arch_x86_64
 __jited("	movabsq	$0x{{.*}}, %r9")
+__arch_arm64
+__jited("	mrs	x10, TPIDR_EL{{[0-1]}}")
+__jited("	add	x27, x27, x10")
+__jited("	add	x25, x27, {{.*}}")
 int private_stack_async_callback_1(void)
 {
 	struct bpf_timer *arr_timer;
@@ -241,6 +326,8 @@ __description("Private stack, async callback, potential nesting")
 __success __retval(0)
 __arch_x86_64
 __jited("	subq	$0x100, %rsp")
+__arch_arm64
+__jited("	sub	sp, sp, #0x100")
 int private_stack_async_callback_2(void)
 {
 	struct bpf_timer *arr_timer;
-- 
2.47.1


