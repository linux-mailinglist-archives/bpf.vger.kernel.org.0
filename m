Return-Path: <bpf+bounces-31363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AC88FBB0D
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 19:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29407B27735
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 17:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6D414A4D1;
	Tue,  4 Jun 2024 17:56:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AE0149E03
	for <bpf@vger.kernel.org>; Tue,  4 Jun 2024 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717523765; cv=none; b=bLYEks9yF0tKzx4PgevC48cad+jPajpqtfIA01HtMC9lvsqj+y9NvAWlXCwv2+/cYK+nGlIgNyJrgL/qzO9AP8ykgw9fAoRAP/LpANuahJkn2Hjd01mOROOYEPF9OXb3csIEsVmG1lo/yG5QY/NReJQvwRs8sNXOS96y19Fz464=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717523765; c=relaxed/simple;
	bh=UXa1C+qkfPE1iZUB2SZWhbyL+M+AxSkhWbpqDM3sy8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2r82nwBMTkm/F6dkEgPx6vM+bZH0MJ+qHYhsC3a2Y23hsLIypfdbNkmH3ny4BEojfv42c0hQ7xS2uBxYAzfAJTfZx8l5bm6csRLSPOUHpo/KHzKYGrS0UiagowihSXeLEjf7+b9Ob9Ahrp2s0np6M70wIOpt2IBa8I4PKY4Kig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 121F75189EBB; Tue,  4 Jun 2024 10:55:52 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH] bpf: Support shadow stack
Date: Tue,  4 Jun 2024 10:55:52 -0700
Message-ID: <20240604175552.1339642-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604175546.1339303-1-yonghong.song@linux.dev>
References: <20240604175546.1339303-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Try to add 3rd argument to bpf program where the 3rd argument
is the frame pointer to bpf program stack.

There are a few issues here:
  - Currently, only main bpf program is using shadow stack.
    other sub programs (static or global) still use stack.
    It is POSSIBLE to a hidden register to pass
    frame pointer (derived from main program) to those static
    or global functions.
  - But tail call and ext programs are not working now we
    we do not know at jit time what programs will be used
    in tail call and ext. It is possible to do some jit
    during text_poke time. But that will need additional
    stack allocation at jit time and that will be complicated.
  - For xdp program, need to patch jit for xdp dispatcher.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 105 +++++++++++++++++++++++++++++-------
 include/linux/bpf-cgroup.h  |   9 ++--
 include/linux/bpf.h         |  29 ++++++----
 include/linux/filter.h      |  25 +++++++--
 kernel/bpf/cgroup.c         |   9 ++--
 kernel/bpf/core.c           |  36 +++++++++++--
 kernel/bpf/offload.c        |   3 +-
 7 files changed, 173 insertions(+), 43 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 673fdbd765d7..32d7a53e7150 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -275,6 +275,14 @@ struct jit_context {
 /* Number of bytes that will be skipped on tailcall */
 #define X86_TAIL_CALL_OFFSET	(11 + ENDBR_INSN_SIZE)
=20
+static void push_r9(u8 **pprog)
+{
+	u8 *prog =3D *pprog;
+
+	EMIT2(0x41, 0x51);
+	*pprog =3D prog;
+}
+
 static void push_r12(u8 **pprog)
 {
 	u8 *prog =3D *pprog;
@@ -298,6 +306,14 @@ static void push_callee_regs(u8 **pprog, bool *calle=
e_regs_used)
 	*pprog =3D prog;
 }
=20
+static void pop_r9(u8 **pprog)
+{
+	u8 *prog =3D *pprog;
+
+	EMIT2(0x41, 0x59);
+	*pprog =3D prog;
+}
+
 static void pop_r12(u8 **pprog)
 {
 	u8 *prog =3D *pprog;
@@ -605,7 +621,7 @@ static void emit_return(u8 **pprog, u8 *ip)
  */
 static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 					u8 **pprog, bool *callee_regs_used,
-					u32 stack_depth, u8 *ip,
+					bool tail_call_reachable, u32 stack_depth, u8 *ip,
 					struct jit_context *ctx)
 {
 	int tcc_off =3D -4 - round_up(stack_depth, 8);
@@ -658,6 +674,8 @@ static void emit_bpf_tail_call_indirect(struct bpf_pr=
og *bpf_prog,
 		pop_callee_regs(&prog, all_callee_regs_used);
 		pop_r12(&prog);
 	} else {
+		if (!tail_call_reachable && !bpf_prog->is_func)
+			pop_r9(&prog);
 		pop_callee_regs(&prog, callee_regs_used);
 		if (bpf_arena_get_kern_vm_start(bpf_prog->aux->arena))
 			pop_r12(&prog);
@@ -688,7 +706,7 @@ static void emit_bpf_tail_call_indirect(struct bpf_pr=
og *bpf_prog,
 static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 				      struct bpf_jit_poke_descriptor *poke,
 				      u8 **pprog, u8 *ip,
-				      bool *callee_regs_used, u32 stack_depth,
+				      bool *callee_regs_used, bool tail_call_reachable, u32 stack_de=
pth,
 				      struct jit_context *ctx)
 {
 	int tcc_off =3D -4 - round_up(stack_depth, 8);
@@ -719,6 +737,8 @@ static void emit_bpf_tail_call_direct(struct bpf_prog=
 *bpf_prog,
 		pop_callee_regs(&prog, all_callee_regs_used);
 		pop_r12(&prog);
 	} else {
+		if (!tail_call_reachable && !bpf_prog->is_func)
+			pop_r9(&prog);
 		pop_callee_regs(&prog, callee_regs_used);
 		if (bpf_arena_get_kern_vm_start(bpf_prog->aux->arena))
 			pop_r12(&prog);
@@ -1321,6 +1341,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *a=
ddrs, u8 *image, u8 *rw_image
 		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
 {
 	bool tail_call_reachable =3D bpf_prog->aux->tail_call_reachable;
+	u32 stack_depth =3D bpf_prog->aux->stack_depth;
 	struct bpf_insn *insn =3D bpf_prog->insnsi;
 	bool callee_regs_used[4] =3D {};
 	int insn_cnt =3D bpf_prog->len;
@@ -1333,6 +1354,9 @@ static int do_jit(struct bpf_prog *bpf_prog, int *a=
ddrs, u8 *image, u8 *rw_image
 	u8 *prog =3D temp;
 	int err;
=20
+	if (!tail_call_reachable && !bpf_prog->is_func)
+		stack_depth =3D 0;
+
 	arena_vm_start =3D bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
 	user_vm_start =3D bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
=20
@@ -1342,7 +1366,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *a=
ddrs, u8 *image, u8 *rw_image
 	/* tail call's presence in current prog implies it is reachable */
 	tail_call_reachable |=3D tail_call_seen;
=20
-	emit_prologue(&prog, bpf_prog->aux->stack_depth,
+	emit_prologue(&prog, stack_depth,
 		      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
 		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
 	/* Exception callback will clobber callee regs for its own use, and
@@ -1359,6 +1383,10 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
 		if (arena_vm_start)
 			push_r12(&prog);
 		push_callee_regs(&prog, callee_regs_used);
+		if (!tail_call_reachable && !bpf_prog->is_func) {
+			emit_mov_reg(&prog, true, X86_REG_R9, BPF_REG_3);
+			push_r9(&prog);
+		}
 	}
 	if (arena_vm_start)
 		emit_mov_imm64(&prog, X86_REG_R12,
@@ -1383,6 +1411,20 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
 		u8 *func;
 		int nops;
=20
+		if (!bpf_prog->aux->exception_boundary && !tail_call_reachable && !bpf=
_prog->is_func) {
+			if (src_reg =3D=3D BPF_REG_FP) {
+				pop_r9(&prog);
+				push_r9(&prog);
+				src_reg =3D X86_REG_R9;
+			}
+
+			if (dst_reg =3D=3D BPF_REG_FP) {
+				pop_r9(&prog);
+				push_r9(&prog);
+				dst_reg =3D X86_REG_R9;
+			}
+		}
+
 		switch (insn->code) {
 			/* ALU */
 		case BPF_ALU | BPF_ADD | BPF_X:
@@ -2045,7 +2087,7 @@ st:			if (is_imm8(insn->off))
=20
 			func =3D (u8 *) __bpf_call_base + imm32;
 			if (tail_call_reachable) {
-				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
+				RESTORE_TAIL_CALL_CNT(stack_depth);
 				if (!imm32)
 					return -EINVAL;
 				offs =3D 7 + x86_call_depth_emit_accounting(&prog, func);
@@ -2065,13 +2107,15 @@ st:			if (is_imm8(insn->off))
 							  &bpf_prog->aux->poke_tab[imm32 - 1],
 							  &prog, image + addrs[i - 1],
 							  callee_regs_used,
-							  bpf_prog->aux->stack_depth,
+							  tail_call_reachable,
+							  stack_depth,
 							  ctx);
 			else
 				emit_bpf_tail_call_indirect(bpf_prog,
 							    &prog,
 							    callee_regs_used,
-							    bpf_prog->aux->stack_depth,
+							    tail_call_reachable,
+							    stack_depth,
 							    image + addrs[i - 1],
 							    ctx);
 			break;
@@ -2326,6 +2370,8 @@ st:			if (is_imm8(insn->off))
 				pop_callee_regs(&prog, all_callee_regs_used);
 				pop_r12(&prog);
 			} else {
+				if (!tail_call_reachable && !bpf_prog->is_func)
+					pop_r9(&prog);
 				pop_callee_regs(&prog, callee_regs_used);
 				if (arena_vm_start)
 					pop_r12(&prog);
@@ -2555,7 +2601,7 @@ static void restore_regs(const struct btf_func_mode=
l *m, u8 **prog,
=20
 static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 			   struct bpf_tramp_link *l, int stack_size,
-			   int run_ctx_off, bool save_ret,
+			   int run_ctx_off, int shadow_stack_off, bool save_ret,
 			   void *image, void *rw_image)
 {
 	u8 *prog =3D *pprog;
@@ -2597,6 +2643,13 @@ static int invoke_bpf_prog(const struct btf_func_m=
odel *m, u8 **pprog,
 	jmp_insn =3D prog;
 	emit_nops(&prog, 2);
=20
+	/* call bpf_shadow_stack_alloc */
+	/* arg1: mov rdi, prog */
+	emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
+	if (emit_rsb_call(&prog, bpf_shadow_stack_alloc, image + (prog - (u8 *)=
rw_image)))
+		return -EINVAL;
+	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -shadow_stack_off);
+
 	/* arg1: lea rdi, [rbp - stack_size] */
 	if (!is_imm8(-stack_size))
 		EMIT3_off32(0x48, 0x8D, 0xBD, -stack_size);
@@ -2607,6 +2660,10 @@ static int invoke_bpf_prog(const struct btf_func_m=
odel *m, u8 **pprog,
 		emit_mov_imm64(&prog, BPF_REG_2,
 			       (long) p->insnsi >> 32,
 			       (u32) (long) p->insnsi);
+	/* arg3: shadow_stack for jit */
+	if (p->jited)
+		emit_mov_reg(&prog, true, BPF_REG_3, BPF_REG_0);
+
 	/* call JITed bpf program or interpreter */
 	if (emit_rsb_call(&prog, p->bpf_func, image + (prog - (u8 *)rw_image)))
 		return -EINVAL;
@@ -2622,6 +2679,12 @@ static int invoke_bpf_prog(const struct btf_func_m=
odel *m, u8 **pprog,
 	if (save_ret)
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
=20
+	/* call bpf_shadow_stack_free */
+	emit_mov_imm64(&prog, BPF_REG_1, (long) p >> 32, (u32) (long) p);
+	emit_ldx(&prog, BPF_DW, BPF_REG_2, BPF_REG_FP, -shadow_stack_off);
+	if (emit_rsb_call(&prog, bpf_shadow_stack_free, image + (prog - (u8 *)r=
w_image)))
+		return -EINVAL;
+
 	/* replace 2 nops with JE insn, since jmp target is known */
 	jmp_insn[0] =3D X86_JE;
 	jmp_insn[1] =3D prog - jmp_insn - 2;
@@ -2670,7 +2733,7 @@ static int emit_cond_near_jump(u8 **pprog, void *fu=
nc, void *ip, u8 jmp_cond)
=20
 static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 		      struct bpf_tramp_links *tl, int stack_size,
-		      int run_ctx_off, bool save_ret,
+		      int run_ctx_off, int shadow_stack_off, bool save_ret,
 		      void *image, void *rw_image)
 {
 	int i;
@@ -2678,7 +2741,7 @@ static int invoke_bpf(const struct btf_func_model *=
m, u8 **pprog,
=20
 	for (i =3D 0; i < tl->nr_links; i++) {
 		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size,
-				    run_ctx_off, save_ret, image, rw_image))
+				    run_ctx_off, shadow_stack_off, save_ret, image, rw_image))
 			return -EINVAL;
 	}
 	*pprog =3D prog;
@@ -2687,7 +2750,7 @@ static int invoke_bpf(const struct btf_func_model *=
m, u8 **pprog,
=20
 static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog=
,
 			      struct bpf_tramp_links *tl, int stack_size,
-			      int run_ctx_off, u8 **branches,
+			      int run_ctx_off, int shadow_stack_off, u8 **branches,
 			      void *image, void *rw_image)
 {
 	u8 *prog =3D *pprog;
@@ -2699,7 +2762,7 @@ static int invoke_bpf_mod_ret(const struct btf_func=
_model *m, u8 **pprog,
 	emit_mov_imm32(&prog, false, BPF_REG_0, 0);
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
 	for (i =3D 0; i < tl->nr_links; i++) {
-		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size, run_ctx_off, t=
rue,
+		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size, run_ctx_off, s=
hadow_stack_off, true,
 				    image, rw_image))
 			return -EINVAL;
=20
@@ -2790,7 +2853,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
 					 void *func_addr)
 {
 	int i, ret, nr_regs =3D m->nr_args, stack_size =3D 0;
-	int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_off;
+	int regs_off, nregs_off, ip_off, run_ctx_off, shadow_stack_off, arg_sta=
ck_off, rbx_off;
 	struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_RETURN];
@@ -2839,6 +2902,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
 	 *
 	 * RBP - run_ctx_off [ bpf_tramp_run_ctx ]
 	 *
+	 * RBP - shadow_stack_off [ shadow_stack ]
+	 *
 	 *                     [ stack_argN ]  BPF_TRAMP_F_CALL_ORIG
 	 *                     [ ...        ]
 	 *                     [ stack_arg2 ]
@@ -2869,6 +2934,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
 	stack_size +=3D (sizeof(struct bpf_tramp_run_ctx) + 7) & ~0x7;
 	run_ctx_off =3D stack_size;
=20
+	stack_size +=3D 8;
+	shadow_stack_off =3D stack_size;
+
 	if (nr_regs > 6 && (flags & BPF_TRAMP_F_CALL_ORIG)) {
 		/* the space that used to pass arguments on-stack */
 		stack_size +=3D (nr_regs - get_nr_used_regs(m)) * 8;
@@ -2949,7 +3017,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
 	}
=20
 	if (fentry->nr_links) {
-		if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off,
+		if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off, shadow_stack_o=
ff,
 			       flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image))
 			return -EINVAL;
 	}
@@ -2961,7 +3029,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
 			return -ENOMEM;
=20
 		if (invoke_bpf_mod_ret(m, &prog, fmod_ret, regs_off,
-				       run_ctx_off, branches, image, rw_image)) {
+				       run_ctx_off, shadow_stack_off, branches, image, rw_image)) {
 			ret =3D -EINVAL;
 			goto cleanup;
 		}
@@ -3011,7 +3079,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
 	}
=20
 	if (fexit->nr_links) {
-		if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off,
+		if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off, shadow_stack_of=
f,
 			       false, image, rw_image)) {
 			ret =3D -EINVAL;
 			goto cleanup;
@@ -3121,11 +3189,11 @@ int arch_bpf_trampoline_size(const struct btf_fun=
c_model *m, u32 flags,
 	 * We cannot use kvmalloc here, because we need image to be in
 	 * module memory range.
 	 */
-	image =3D bpf_jit_alloc_exec(PAGE_SIZE);
+	image =3D bpf_jit_alloc_exec(PAGE_SIZE * 2);
 	if (!image)
 		return -ENOMEM;
=20
-	ret =3D __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, im=
age,
+	ret =3D __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE * 2=
, image,
 					    m, flags, tlinks, func_addr);
 	bpf_jit_free_exec(image);
 	return ret;
@@ -3361,8 +3429,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pro=
g *prog)
 		cond_resched();
 	}
=20
-	if (bpf_jit_enable > 1)
+	if (bpf_jit_enable > 1) {
 		bpf_jit_dump(prog->len, proglen, pass + 1, rw_image);
+	}
=20
 	if (image) {
 		if (!prog->is_func || extra_pass) {
diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index fb3c3e7181e6..36fbefb1bf07 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -24,11 +24,14 @@ struct ctl_table_header;
 struct task_struct;
=20
 unsigned int __cgroup_bpf_run_lsm_sock(const void *ctx,
-				       const struct bpf_insn *insn);
+				       const struct bpf_insn *insn,
+				       void *shadow_stack);
 unsigned int __cgroup_bpf_run_lsm_socket(const void *ctx,
-					 const struct bpf_insn *insn);
+					 const struct bpf_insn *insn,
+					 void *shadow_stack);
 unsigned int __cgroup_bpf_run_lsm_current(const void *ctx,
-					  const struct bpf_insn *insn);
+					  const struct bpf_insn *insn,
+					  void *shadow_stack);
=20
 #ifdef CONFIG_CGROUP_BPF
=20
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5034c1b4ded7..6e5ffaa2f1d0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -69,7 +69,8 @@ typedef int (*bpf_iter_init_seq_priv_t)(void *private_d=
ata,
 					struct bpf_iter_aux_info *aux);
 typedef void (*bpf_iter_fini_seq_priv_t)(void *private_data);
 typedef unsigned int (*bpf_func_t)(const void *,
-				   const struct bpf_insn *);
+				   const struct bpf_insn *,
+				   void *);
 struct bpf_iter_seq_info {
 	const struct seq_operations *seq_ops;
 	bpf_iter_init_seq_priv_t init_seq_private;
@@ -1076,9 +1077,9 @@ struct btf_func_model {
  */
 enum {
 #if defined(__s390x__)
-	BPF_MAX_TRAMP_LINKS =3D 27,
+	BPF_MAX_TRAMP_LINKS =3D 24,
 #else
-	BPF_MAX_TRAMP_LINKS =3D 38,
+	BPF_MAX_TRAMP_LINKS =3D 35,
 #endif
 };
=20
@@ -1133,6 +1134,9 @@ typedef void (*bpf_trampoline_exit_t)(struct bpf_pr=
og *prog, u64 start,
 bpf_trampoline_enter_t bpf_trampoline_enter(const struct bpf_prog *prog)=
;
 bpf_trampoline_exit_t bpf_trampoline_exit(const struct bpf_prog *prog);
=20
+void * notrace bpf_shadow_stack_alloc(struct bpf_prog *prog);
+void notrace bpf_shadow_stack_free(struct bpf_prog *prog, void *shadow_f=
rame);
+
 struct bpf_ksym {
 	unsigned long		 start;
 	unsigned long		 end;
@@ -1228,9 +1232,11 @@ struct bpf_dispatcher {
 static __always_inline __bpfcall unsigned int bpf_dispatcher_nop_func(
 	const void *ctx,
 	const struct bpf_insn *insnsi,
-	bpf_func_t bpf_func)
+	bpf_func_t bpf_func,
+	void *shadow_stack)
 {
-	return bpf_func(ctx, insnsi);
+	// printk("%s: shadow_stack =3D %px\n", __func__, shadow_stack);
+	return bpf_func(ctx, insnsi, shadow_stack);
 }
=20
 /* the implementation of the opaque uapi struct bpf_dynptr */
@@ -1289,7 +1295,7 @@ int arch_prepare_bpf_dispatcher(void *image, void *=
buf, s64 *funcs, int num_func
 	DEFINE_STATIC_CALL(bpf_dispatcher_##name##_call, bpf_dispatcher_nop_fun=
c)
=20
 #define __BPF_DISPATCHER_CALL(name)				\
-	static_call(bpf_dispatcher_##name##_call)(ctx, insnsi, bpf_func)
+	static_call(bpf_dispatcher_##name##_call)(ctx, insnsi, bpf_func, shadow=
_stack)
=20
 #define __BPF_DISPATCHER_UPDATE(_d, _new)			\
 	__static_call_update((_d)->sc_key, (_d)->sc_tramp, (_new))
@@ -1297,7 +1303,7 @@ int arch_prepare_bpf_dispatcher(void *image, void *=
buf, s64 *funcs, int num_func
 #else
 #define __BPF_DISPATCHER_SC_INIT(name)
 #define __BPF_DISPATCHER_SC(name)
-#define __BPF_DISPATCHER_CALL(name)		bpf_func(ctx, insnsi)
+#define __BPF_DISPATCHER_CALL(name)		bpf_func(ctx, insnsi, shadow_stack)
 #define __BPF_DISPATCHER_UPDATE(_d, _new)
 #endif
=20
@@ -1320,7 +1326,8 @@ int arch_prepare_bpf_dispatcher(void *image, void *=
buf, s64 *funcs, int num_func
 	noinline __bpfcall unsigned int bpf_dispatcher_##name##_func(	\
 		const void *ctx,					\
 		const struct bpf_insn *insnsi,				\
-		bpf_func_t bpf_func)					\
+		bpf_func_t bpf_func,					\
+		void *shadow_stack)					\
 	{								\
 		return __BPF_DISPATCHER_CALL(name);			\
 	}								\
@@ -1332,7 +1339,8 @@ int arch_prepare_bpf_dispatcher(void *image, void *=
buf, s64 *funcs, int num_func
 	unsigned int bpf_dispatcher_##name##_func(			\
 		const void *ctx,					\
 		const struct bpf_insn *insnsi,				\
-		bpf_func_t bpf_func);					\
+		bpf_func_t bpf_func,					\
+		void *shadow_stack);					\
 	extern struct bpf_dispatcher bpf_dispatcher_##name;
=20
 #define BPF_DISPATCHER_FUNC(name) bpf_dispatcher_##name##_func
@@ -1549,7 +1557,8 @@ struct bpf_prog {
 	struct bpf_prog_stats __percpu *stats;
 	int __percpu		*active;
 	unsigned int		(*bpf_func)(const void *ctx,
-					    const struct bpf_insn *insn);
+					    const struct bpf_insn *insn,
+					    void *shadow_stack);
 	struct bpf_prog_aux	*aux;		/* Auxiliary fields */
 	struct sock_fprog_kern	*orig_prog;	/* Original BPF program */
 	/* Instructions for interpreter */
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 7a27f19bf44d..0c4bc8e80925 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -665,13 +665,25 @@ extern int (*nfct_btf_struct_access)(struct bpf_ver=
ifier_log *log,
 typedef unsigned int (*bpf_dispatcher_fn)(const void *ctx,
 					  const struct bpf_insn *insnsi,
 					  unsigned int (*bpf_func)(const void *,
-								   const struct bpf_insn *));
+								   const struct bpf_insn *,
+								   void *),
+					  void *shadow_stack);
=20
 static __always_inline u32 __bpf_prog_run(const struct bpf_prog *prog,
 					  const void *ctx,
 					  bpf_dispatcher_fn dfunc)
 {
-	u32 ret;
+	void *shadow_stack =3D NULL, *shadow_frame =3D NULL;
+	u32 ret, roundup_stack_size;
+
+	if (prog->aux->stack_depth) {
+		roundup_stack_size =3D round_up(prog->aux->stack_depth, 16);
+		shadow_stack =3D kmalloc(roundup_stack_size, __GFP_NORETRY);
+		if (shadow_stack)
+			shadow_frame =3D shadow_stack + roundup_stack_size;
+	}
+
+	// printk("shadow_stack =3D %px, shadow_frame =3D %px\n", shadow_stack,=
 shadow_frame);
=20
 	cant_migrate();
 	if (static_branch_unlikely(&bpf_stats_enabled_key)) {
@@ -679,7 +691,7 @@ static __always_inline u32 __bpf_prog_run(const struc=
t bpf_prog *prog,
 		u64 duration, start =3D sched_clock();
 		unsigned long flags;
=20
-		ret =3D dfunc(ctx, prog->insnsi, prog->bpf_func);
+		ret =3D dfunc(ctx, prog->insnsi, prog->bpf_func, shadow_frame);
=20
 		duration =3D sched_clock() - start;
 		stats =3D this_cpu_ptr(prog->stats);
@@ -688,8 +700,13 @@ static __always_inline u32 __bpf_prog_run(const stru=
ct bpf_prog *prog,
 		u64_stats_add(&stats->nsecs, duration);
 		u64_stats_update_end_irqrestore(&stats->syncp, flags);
 	} else {
-		ret =3D dfunc(ctx, prog->insnsi, prog->bpf_func);
+		ret =3D dfunc(ctx, prog->insnsi, prog->bpf_func, shadow_frame);
 	}
+
+	// printk("shadow_frame =3D %px\n", shadow_frame);
+
+	if (prog->aux->stack_depth)
+		kfree(shadow_stack);
 	return ret;
 }
=20
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 8ba73042a239..dc53fe853400 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -64,7 +64,8 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
 }
=20
 unsigned int __cgroup_bpf_run_lsm_sock(const void *ctx,
-				       const struct bpf_insn *insn)
+				       const struct bpf_insn *insn,
+				       void *shadow_stack)
 {
 	const struct bpf_prog *shim_prog;
 	struct sock *sk;
@@ -86,7 +87,8 @@ unsigned int __cgroup_bpf_run_lsm_sock(const void *ctx,
 }
=20
 unsigned int __cgroup_bpf_run_lsm_socket(const void *ctx,
-					 const struct bpf_insn *insn)
+					 const struct bpf_insn *insn,
+					 void *shadow_stack)
 {
 	const struct bpf_prog *shim_prog;
 	struct socket *sock;
@@ -108,7 +110,8 @@ unsigned int __cgroup_bpf_run_lsm_socket(const void *=
ctx,
 }
=20
 unsigned int __cgroup_bpf_run_lsm_current(const void *ctx,
-					  const struct bpf_insn *insn)
+					  const struct bpf_insn *insn,
+					  void *shadow_stack)
 {
 	const struct bpf_prog *shim_prog;
 	struct cgroup *cgrp;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index a41718eaeefe..24ad269f1f7e 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -563,7 +563,7 @@ void bpf_prog_kallsyms_del_all(struct bpf_prog *fp)
=20
 #ifdef CONFIG_BPF_JIT
 /* All BPF JIT sysctl knobs here. */
-int bpf_jit_enable   __read_mostly =3D IS_BUILTIN(CONFIG_BPF_JIT_DEFAULT=
_ON);
+int bpf_jit_enable   __read_mostly =3D 1;
 int bpf_jit_kallsyms __read_mostly =3D IS_BUILTIN(CONFIG_BPF_JIT_DEFAULT=
_ON);
 int bpf_jit_harden   __read_mostly;
 long bpf_jit_limit   __read_mostly;
@@ -2213,7 +2213,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct =
bpf_insn *insn)
=20
 #define PROG_NAME(stack_size) __bpf_prog_run##stack_size
 #define DEFINE_BPF_PROG_RUN(stack_size) \
-static unsigned int PROG_NAME(stack_size)(const void *ctx, const struct =
bpf_insn *insn) \
+static unsigned int PROG_NAME(stack_size)(const void *ctx, const struct =
bpf_insn *insn, void *shadow_stack) \
 { \
 	u64 stack[stack_size / sizeof(u64)]; \
 	u64 regs[MAX_BPF_EXT_REG] =3D {}; \
@@ -2260,7 +2260,8 @@ EVAL4(DEFINE_BPF_PROG_RUN_ARGS, 416, 448, 480, 512)=
;
 #define PROG_NAME_LIST(stack_size) PROG_NAME(stack_size),
=20
 static unsigned int (*interpreters[])(const void *ctx,
-				      const struct bpf_insn *insn) =3D {
+				      const struct bpf_insn *insn,
+				      void *shadow_stack) =3D {
 EVAL6(PROG_NAME_LIST, 32, 64, 96, 128, 160, 192)
 EVAL6(PROG_NAME_LIST, 224, 256, 288, 320, 352, 384)
 EVAL4(PROG_NAME_LIST, 416, 448, 480, 512)
@@ -2434,8 +2435,35 @@ struct bpf_prog *bpf_prog_select_runtime(struct bp=
f_prog *fp, int *err)
 }
 EXPORT_SYMBOL_GPL(bpf_prog_select_runtime);
=20
+void * notrace bpf_shadow_stack_alloc(struct bpf_prog *prog)
+{
+	void *shadow_stack =3D NULL, *shadow_frame =3D NULL;
+	u32 roundup_stack_size;
+
+	if (!prog->aux->stack_depth)
+		return NULL;
+
+	roundup_stack_size =3D round_up(prog->aux->stack_depth, 16);
+	shadow_stack =3D kmalloc(roundup_stack_size, __GFP_NORETRY);
+	if (shadow_stack)
+		shadow_frame =3D shadow_stack + roundup_stack_size;
+	return shadow_frame;
+}
+
+void notrace bpf_shadow_stack_free(struct bpf_prog *prog, void *shadow_f=
rame)
+{
+	u32 roundup_stack_size;
+
+	if (!shadow_frame)
+		return;
+
+	roundup_stack_size =3D round_up(prog->aux->stack_depth, 16);
+	kfree(shadow_frame - roundup_stack_size);
+}
+
 static unsigned int __bpf_prog_ret1(const void *ctx,
-				    const struct bpf_insn *insn)
+				    const struct bpf_insn *insn,
+				    void *shadow_stack)
 {
 	return 1;
 }
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 1a4fec330eaa..730947ee1e1d 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -414,7 +414,8 @@ static int bpf_prog_offload_translate(struct bpf_prog=
 *prog)
 }
=20
 static unsigned int bpf_prog_warn_on_exec(const void *ctx,
-					  const struct bpf_insn *insn)
+					  const struct bpf_insn *insn,
+					  void *shadow_stack)
 {
 	WARN(1, "attempt to execute device eBPF program on the host!");
 	return 0;
--=20
2.43.0


