Return-Path: <bpf+bounces-31362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5616F8FBB0C
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 19:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A03C7B27151
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 17:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A5814A0B7;
	Tue,  4 Jun 2024 17:56:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC62149C4D
	for <bpf@vger.kernel.org>; Tue,  4 Jun 2024 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717523765; cv=none; b=ofhN2AxLK7DdyfYQdSGn2A5jf5h3EfdEVT44KtMBvg/Q2qOz+Js8+dwYWCbIV5vmjIKd4xinBAcu5kg8WsoIcU1q+6GTGuP6b3yElw91RwqHlVqmC4tApAizJkY7Z7fAlAF17R9qrA1TeEaEgZJqrWxjWQwU8unsairX296IvBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717523765; c=relaxed/simple;
	bh=Bnzv1UwZa3McbXA0v6i8MyOQS4wRc6ARlhqsO7Q1GHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAgYcBzdvwRS6elCB/1MzIqBjAIYzXJD4n7S+pWEuh98smIAuK02Rsb8KFADkqFzfnXknSGGnbyYeTQY+DwHkp1CdZUpqFeT5h9YzOzFcTQWEpWAlG4T8Qd5QYTnBfD4Yu3kIvQ8P+ghTAcNzp5apvKh6xmWn3uxxfO/Wjd3qtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 2AEF65189ECD; Tue,  4 Jun 2024 10:55:57 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH] bpf: Support bpf shadow stack
Date: Tue,  4 Jun 2024 10:55:57 -0700
Message-ID: <20240604175557.1339832-1-yonghong.song@linux.dev>
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

To support shadow stack, for each program in jit, allocate the
stack in the entry of bpf program, and free the stack in
the exit of bpf program.

This works for all bpf selftests, but it is expensive.
To avoid runtime kmalloc, we could preallocate some spaces,
e.g., percpu pages to be used for stack. This should work
for non-sleepable programs. For sleepable program, current
kmalloc/free may still work since performance is not critical.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 200 ++++++++++++++++++++++++++++++++----
 include/linux/bpf.h         |   3 +
 kernel/bpf/core.c           |  25 +++++
 3 files changed, 209 insertions(+), 19 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 673fdbd765d7..653792af3b11 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -267,7 +267,7 @@ struct jit_context {
 };
=20
 /* Maximum number of bytes emitted while JITing one eBPF insn */
-#define BPF_MAX_INSN_SIZE	128
+#define BPF_MAX_INSN_SIZE	160
 #define BPF_INSN_SAFETY		64
=20
 /* Number of bytes emit_patch() needs to generate instructions */
@@ -275,6 +275,14 @@ struct jit_context {
 /* Number of bytes that will be skipped on tailcall */
 #define X86_TAIL_CALL_OFFSET	(11 + ENDBR_INSN_SIZE)
=20
+static void push_r9(u8 **pprog)
+{
+	u8 *prog =3D *pprog;
+
+	EMIT2(0x41, 0x51);   /* push r9 */
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
+	EMIT2(0x41, 0x59);   /* pop r9 */
+	*pprog =3D prog;
+}
+
 static void pop_r12(u8 **pprog)
 {
 	u8 *prog =3D *pprog;
@@ -437,6 +453,7 @@ static void emit_prologue(u8 **pprog, u32 stack_depth=
, bool ebpf_from_cbpf,
 		 * first restore those callee-saved regs from stack, before
 		 * reusing the stack frame.
 		 */
+		pop_r9(&prog);
 		pop_callee_regs(&prog, all_callee_regs_used);
 		pop_r12(&prog);
 		/* Reset the stack frame. */
@@ -589,6 +606,9 @@ static void emit_return(u8 **pprog, u8 *ip)
 	*pprog =3D prog;
 }
=20
+static int emit_shadow_stack_free(u8 **pprog, struct bpf_prog *bpf_prog,
+				  u8 *ip, u8 *temp);
+
 /*
  * Generate the following code:
  *
@@ -603,14 +623,14 @@ static void emit_return(u8 **pprog, u8 *ip)
  *   goto *(prog->bpf_func + prologue_size);
  * out:
  */
-static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
+static int emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 					u8 **pprog, bool *callee_regs_used,
-					u32 stack_depth, u8 *ip,
+					u32 stack_depth, u8 *ip, u8 *temp,
 					struct jit_context *ctx)
 {
 	int tcc_off =3D -4 - round_up(stack_depth, 8);
 	u8 *prog =3D *pprog, *start =3D *pprog;
-	int offset;
+	int err, offset;
=20
 	/*
 	 * rdi - pointer to ctx
@@ -626,8 +646,8 @@ static void emit_bpf_tail_call_indirect(struct bpf_pr=
og *bpf_prog,
 	EMIT3(0x39, 0x56,                         /* cmp dword ptr [rsi + 16], =
edx */
 	      offsetof(struct bpf_array, map.max_entries));
=20
-	offset =3D ctx->tail_call_indirect_label - (prog + 2 - start);
-	EMIT2(X86_JBE, offset);                   /* jbe out */
+	offset =3D ctx->tail_call_indirect_label - (prog + 6 - start);
+	EMIT2_off32(0x0f, 0x86, offset);                   /* jbe out */
=20
 	/*
 	 * if (tail_call_cnt++ >=3D MAX_TAIL_CALL_CNT)
@@ -654,10 +674,16 @@ static void emit_bpf_tail_call_indirect(struct bpf_=
prog *bpf_prog,
 	offset =3D ctx->tail_call_indirect_label - (prog + 2 - start);
 	EMIT2(X86_JE, offset);                    /* je out */
=20
+	err =3D emit_shadow_stack_free(&prog, bpf_prog, ip, temp);
+	if (err)
+		return err;
+
+	pop_r9(&prog);
 	if (bpf_prog->aux->exception_boundary) {
 		pop_callee_regs(&prog, all_callee_regs_used);
 		pop_r12(&prog);
 	} else {
+		pop_r9(&prog);
 		pop_callee_regs(&prog, callee_regs_used);
 		if (bpf_arena_get_kern_vm_start(bpf_prog->aux->arena))
 			pop_r12(&prog);
@@ -683,17 +709,18 @@ static void emit_bpf_tail_call_indirect(struct bpf_=
prog *bpf_prog,
 	/* out: */
 	ctx->tail_call_indirect_label =3D prog - start;
 	*pprog =3D prog;
+	return 0;
 }
=20
-static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
+static int emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 				      struct bpf_jit_poke_descriptor *poke,
-				      u8 **pprog, u8 *ip,
+				      u8 **pprog, u8 *ip, u8 *temp,
 				      bool *callee_regs_used, u32 stack_depth,
 				      struct jit_context *ctx)
 {
 	int tcc_off =3D -4 - round_up(stack_depth, 8);
 	u8 *prog =3D *pprog, *start =3D *pprog;
-	int offset;
+	int err, offset;
=20
 	/*
 	 * if (tail_call_cnt++ >=3D MAX_TAIL_CALL_CNT)
@@ -715,10 +742,16 @@ static void emit_bpf_tail_call_direct(struct bpf_pr=
og *bpf_prog,
 	emit_jump(&prog, (u8 *)poke->tailcall_target + X86_PATCH_SIZE,
 		  poke->tailcall_bypass);
=20
+	err =3D emit_shadow_stack_free(&prog, bpf_prog, ip, temp);
+	if (err)
+		return err;
+
+	pop_r9(&prog);
 	if (bpf_prog->aux->exception_boundary) {
 		pop_callee_regs(&prog, all_callee_regs_used);
 		pop_r12(&prog);
 	} else {
+		pop_r9(&prog);
 		pop_callee_regs(&prog, callee_regs_used);
 		if (bpf_arena_get_kern_vm_start(bpf_prog->aux->arena))
 			pop_r12(&prog);
@@ -734,6 +767,7 @@ static void emit_bpf_tail_call_direct(struct bpf_prog=
 *bpf_prog,
 	ctx->tail_call_direct_label =3D prog - start;
=20
 	*pprog =3D prog;
+	return 0;
 }
=20
 static void bpf_tail_call_direct_fixup(struct bpf_prog *prog)
@@ -1311,6 +1345,103 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, =
u8 src_reg, bool is64, u8 op)
 	*pprog =3D prog;
 }
=20
+/* call bpf_shadow_stack_alloc function. Preserve r1-r5 registers. */
+static int emit_shadow_stack_alloc(u8 **pprog, struct bpf_prog *bpf_prog=
,
+				   u8 *image, u8 *temp)
+{
+	int offs;
+	u8 *func;
+
+	/* save parameters to preserve original bpf arguments. */
+	emit_mov_reg(pprog, true, X86_REG_R9, BPF_REG_1);
+	push_r9(pprog);
+	emit_mov_reg(pprog, true, X86_REG_R9, BPF_REG_2);
+	push_r9(pprog);
+	emit_mov_reg(pprog, true, X86_REG_R9, BPF_REG_3);
+	push_r9(pprog);
+	emit_mov_reg(pprog, true, X86_REG_R9, BPF_REG_4);
+	push_r9(pprog);
+	emit_mov_reg(pprog, true, X86_REG_R9, BPF_REG_5);
+	push_r9(pprog);
+
+	emit_mov_imm64(pprog, BPF_REG_1, (long) bpf_prog >> 32, (u32) (long) bp=
f_prog);
+	func =3D (u8 *)bpf_shadow_stack_alloc;
+	offs =3D *pprog - temp;
+	offs +=3D x86_call_depth_emit_accounting(pprog, func);
+	if (emit_call(pprog, func, image + offs))
+		return -EINVAL;
+
+	pop_r9(pprog);
+	emit_mov_reg(pprog, true, BPF_REG_5, X86_REG_R9);
+	pop_r9(pprog);
+	emit_mov_reg(pprog, true, BPF_REG_4, X86_REG_R9);
+	pop_r9(pprog);
+	emit_mov_reg(pprog, true, BPF_REG_3, X86_REG_R9);
+	pop_r9(pprog);
+	emit_mov_reg(pprog, true, BPF_REG_2, X86_REG_R9);
+	pop_r9(pprog);
+	emit_mov_reg(pprog, true, BPF_REG_1, X86_REG_R9);
+
+	/* Save the frame pointer to the stack so it can be
+	 * retrieved later.
+	 */
+	emit_mov_reg(pprog, true, X86_REG_R9, BPF_REG_0);
+	push_r9(pprog);
+
+	return 0;
+}
+
+/* call bpf_shadow_stack_free function. Preserve r0-r5 registers. */
+static int emit_shadow_stack_free(u8 **pprog, struct bpf_prog *bpf_prog,
+				  u8 *ip, u8 *temp)
+{
+	int offs;
+	u8 *func;
+
+	pop_r9(pprog);
+	push_r9(pprog);
+	/* X86_REG_R9 holds the shadow frame pointer */
+	emit_mov_reg(pprog, true, AUX_REG, X86_REG_R9);
+
+	/* save reg 0-5 to preserve original values */
+	emit_mov_reg(pprog, true, X86_REG_R9, BPF_REG_0);
+	push_r9(pprog);
+	emit_mov_reg(pprog, true, X86_REG_R9, BPF_REG_1);
+	push_r9(pprog);
+	emit_mov_reg(pprog, true, X86_REG_R9, BPF_REG_2);
+	push_r9(pprog);
+	emit_mov_reg(pprog, true, X86_REG_R9, BPF_REG_3);
+	push_r9(pprog);
+	emit_mov_reg(pprog, true, X86_REG_R9, BPF_REG_4);
+	push_r9(pprog);
+	emit_mov_reg(pprog, true, X86_REG_R9, BPF_REG_5);
+	push_r9(pprog);
+
+	emit_mov_imm64(pprog, BPF_REG_1, (long) bpf_prog >> 32, (u32) (long) bp=
f_prog);
+	emit_mov_reg(pprog, true, BPF_REG_2, AUX_REG);
+	func =3D (u8 *)bpf_shadow_stack_free;
+	offs =3D *pprog - temp;
+	offs +=3D x86_call_depth_emit_accounting(pprog, func);
+	if (emit_call(pprog, func, ip + offs))
+		return -EINVAL;
+
+	/* restore reg 0-5 to preserve original values */
+	pop_r9(pprog);
+	emit_mov_reg(pprog, true, BPF_REG_5, X86_REG_R9);
+	pop_r9(pprog);
+	emit_mov_reg(pprog, true, BPF_REG_4, X86_REG_R9);
+	pop_r9(pprog);
+	emit_mov_reg(pprog, true, BPF_REG_3, X86_REG_R9);
+	pop_r9(pprog);
+	emit_mov_reg(pprog, true, BPF_REG_2, X86_REG_R9);
+	pop_r9(pprog);
+	emit_mov_reg(pprog, true, BPF_REG_1, X86_REG_R9);
+	pop_r9(pprog);
+	emit_mov_reg(pprog, true, BPF_REG_0, X86_REG_R9);
+
+	return 0;
+}
+
 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
=20
 /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
@@ -1328,11 +1459,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
 	bool seen_exit =3D false;
 	u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
 	u64 arena_vm_start, user_vm_start;
-	int i, excnt =3D 0;
+	int i, excnt =3D 0, stack_depth;
 	int ilen, proglen =3D 0;
 	u8 *prog =3D temp;
 	int err;
=20
+	/* enable shadow stack */
+	stack_depth =3D 0;
+
 	arena_vm_start =3D bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
 	user_vm_start =3D bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
=20
@@ -1342,7 +1476,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *a=
ddrs, u8 *image, u8 *rw_image
 	/* tail call's presence in current prog implies it is reachable */
 	tail_call_reachable |=3D tail_call_seen;
=20
-	emit_prologue(&prog, bpf_prog->aux->stack_depth,
+	emit_prologue(&prog, stack_depth,
 		      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
 		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
 	/* Exception callback will clobber callee regs for its own use, and
@@ -1359,11 +1493,17 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
 		if (arena_vm_start)
 			push_r12(&prog);
 		push_callee_regs(&prog, callee_regs_used);
+		/* save r9 */
+		push_r9(&prog);
 	}
 	if (arena_vm_start)
 		emit_mov_imm64(&prog, X86_REG_R12,
 			       arena_vm_start >> 32, (u32) arena_vm_start);
=20
+	err =3D emit_shadow_stack_alloc(&prog, bpf_prog, image, temp);
+	if (err)
+		return err;
+
 	ilen =3D prog - temp;
 	if (rw_image)
 		memcpy(rw_image + proglen, temp, ilen);
@@ -1371,6 +1511,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *a=
ddrs, u8 *image, u8 *rw_image
 	addrs[0] =3D proglen;
 	prog =3D temp;
=20
+
 	for (i =3D 1; i <=3D insn_cnt; i++, insn++) {
 		const s32 imm32 =3D insn->imm;
 		u32 dst_reg =3D insn->dst_reg;
@@ -1383,6 +1524,18 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
 		u8 *func;
 		int nops;
=20
+		if (src_reg =3D=3D BPF_REG_FP) {
+			pop_r9(&prog);
+			push_r9(&prog);
+			src_reg =3D X86_REG_R9;
+		}
+
+		if (dst_reg =3D=3D BPF_REG_FP) {
+			pop_r9(&prog);
+			push_r9(&prog);
+			dst_reg =3D X86_REG_R9;
+		}
+
 		switch (insn->code) {
 			/* ALU */
 		case BPF_ALU | BPF_ADD | BPF_X:
@@ -2045,7 +2198,7 @@ st:			if (is_imm8(insn->off))
=20
 			func =3D (u8 *) __bpf_call_base + imm32;
 			if (tail_call_reachable) {
-				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
+				RESTORE_TAIL_CALL_CNT(stack_depth);
 				if (!imm32)
 					return -EINVAL;
 				offs =3D 7 + x86_call_depth_emit_accounting(&prog, func);
@@ -2061,19 +2214,21 @@ st:			if (is_imm8(insn->off))
=20
 		case BPF_JMP | BPF_TAIL_CALL:
 			if (imm32)
-				emit_bpf_tail_call_direct(bpf_prog,
+				err =3D emit_bpf_tail_call_direct(bpf_prog,
 							  &bpf_prog->aux->poke_tab[imm32 - 1],
-							  &prog, image + addrs[i - 1],
+							  &prog, image + addrs[i - 1], temp,
 							  callee_regs_used,
-							  bpf_prog->aux->stack_depth,
+							  stack_depth,
 							  ctx);
 			else
-				emit_bpf_tail_call_indirect(bpf_prog,
+				err =3D emit_bpf_tail_call_indirect(bpf_prog,
 							    &prog,
 							    callee_regs_used,
-							    bpf_prog->aux->stack_depth,
-							    image + addrs[i - 1],
+							    stack_depth,
+							    image + addrs[i - 1], temp,
 							    ctx);
+			if (err)
+				return err;
 			break;
=20
 			/* cond jump */
@@ -2322,10 +2477,17 @@ st:			if (is_imm8(insn->off))
 			seen_exit =3D true;
 			/* Update cleanup_addr */
 			ctx->cleanup_addr =3D proglen;
+
+			err =3D emit_shadow_stack_free(&prog, bpf_prog, image + addrs[i - 1],=
 temp);
+			if (err)
+				return err;
+
+			pop_r9(&prog);
 			if (bpf_prog->aux->exception_boundary) {
 				pop_callee_regs(&prog, all_callee_regs_used);
 				pop_r12(&prog);
 			} else {
+				pop_r9(&prog);
 				pop_callee_regs(&prog, callee_regs_used);
 				if (arena_vm_start)
 					pop_r12(&prog);
@@ -2347,7 +2509,7 @@ st:			if (is_imm8(insn->off))
=20
 		ilen =3D prog - temp;
 		if (ilen > BPF_MAX_INSN_SIZE) {
-			pr_err("bpf_jit: fatal insn size error\n");
+			pr_err("bpf_jit: fatal insn size error: %d\n", ilen);
 			return -EFAULT;
 		}
=20
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5034c1b4ded7..b0f9ea882253 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1133,6 +1133,9 @@ typedef void (*bpf_trampoline_exit_t)(struct bpf_pr=
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
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index a41718eaeefe..831841b5af7f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2434,6 +2434,31 @@ struct bpf_prog *bpf_prog_select_runtime(struct bp=
f_prog *fp, int *err)
 }
 EXPORT_SYMBOL_GPL(bpf_prog_select_runtime);
=20
+void * notrace bpf_shadow_stack_alloc(struct bpf_prog *prog)
+{
+	int stack_depth =3D prog->aux->stack_depth;
+	void *shadow_stack;
+
+	if (!stack_depth)
+		return NULL;
+	shadow_stack =3D kmalloc(round_up(stack_depth, 16), __GFP_NORETRY);
+	if (!shadow_stack)
+		return NULL;
+	return shadow_stack + round_up(stack_depth, 16);
+}
+
+void notrace bpf_shadow_stack_free(struct bpf_prog *prog, void *shadow_f=
rame)
+{
+	int stack_depth =3D prog->aux->stack_depth;
+	void *shadow_stack;
+
+	if (!shadow_frame)
+		return;
+
+	shadow_stack =3D shadow_frame - round_up(stack_depth, 16);
+	kfree(shadow_stack);
+}
+
 static unsigned int __bpf_prog_ret1(const void *ctx,
 				    const struct bpf_insn *insn)
 {
--=20
2.43.0


