Return-Path: <bpf+bounces-40373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB98987C00
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 01:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515D22856A9
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 23:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F7D1B07A2;
	Thu, 26 Sep 2024 23:45:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F46D13C683
	for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 23:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727394340; cv=none; b=hF0NB5iRuv1iblxhG7/76uo4kyNxZOjcgvx+V7g3RS5FHY7tzcSkl9suLIlKlb2xryvXr8m5919OpUuIfZ205/KKlGkGmfQ6JMDyAcLYG3jFEHfNWHs2QSFpBwqaU2Huylsfq/jxvr0J3HDrr21K9Z+JDtUAYNFiaCmeeJZh9II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727394340; c=relaxed/simple;
	bh=FEbdUWsTuM01VEzEcCRNhgjZWj8vPDLfbKej36mK/KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Df2Hwe65jaE87V7UoxDW9R4BL0nvfRq33AQrNlodZuGZ7vwDqWbmog9MuINtwuhEw6mrl2H3bhnzXmi3MeG1QktL8cV8MnqCj9qYRCtZgPHSpb5094ZnNsaZjBrvEW0Y1I9xwp0H8+c91WuAYJoTCsaGdAg0z2J5sIj8Ebz5bLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 76C4A967C7A4; Thu, 26 Sep 2024 16:45:26 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 4/5] bpf, x86: Add jit support for private stack
Date: Thu, 26 Sep 2024 16:45:26 -0700
Message-ID: <20240926234526.1770736-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240926234506.1769256-1-yonghong.song@linux.dev>
References: <20240926234506.1769256-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add jit support for private stack. For a particular subtree, e.g.,
  subtree_root <=3D=3D stack depth 120
   subprog1    <=3D=3D stack depth 80
    subprog2   <=3D=3D stack depth 40
   subprog3    <=3D=3D stack depth 160

Let us say that private_stack_ptr is the memory address allocated for
private stack. The frame pointer for each above is calculated like below:
  subtree_root  <=3D=3D subtree_root_fp =3D private_stack_ptr + 120
   subprog1     <=3D=3D subtree_subprog1_fp =3D subtree_root_fp + 80
    subprog2    <=3D=3D subtree_subprog2_fp =3D subtree_subprog1_fp + 40
   subprog3     <=3D=3D subtree_subprog1_fp =3D subtree_root_fp + 160

For any function call to helper/kfunc, push/pop prog frame pointer
is needed in order to preserve frame pointer value.

To deal with exception handling, push/pop frame pointer is also used
surrounding call to subsequent subprog. For example,
  subtree_root
   subprog1
     ...
     insn: call bpf_throw
     ...

After jit, we will have
  subtree_root
   insn: push r9
   subprog1
     ...
     insn: push r9
     insn: call bpf_throw
     insn: pop r9
     ...
   insn: pop r9

  exception_handler
     pop r9
     ...
where r9 represents the fp for each subprog.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 87 ++++++++++++++++++++++++++++++++++---
 1 file changed, 81 insertions(+), 6 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 06b080b61aa5..c264822c926b 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -325,6 +325,22 @@ struct jit_context {
 /* Number of bytes that will be skipped on tailcall */
 #define X86_TAIL_CALL_OFFSET	(12 + ENDBR_INSN_SIZE)
=20
+static void push_r9(u8 **pprog)
+{
+	u8 *prog =3D *pprog;
+
+	EMIT2(0x41, 0x51);   /* push r9 */
+	*pprog =3D prog;
+}
+
+static void pop_r9(u8 **pprog)
+{
+	u8 *prog =3D *pprog;
+
+	EMIT2(0x41, 0x59);   /* pop r9 */
+	*pprog =3D prog;
+}
+
 static void push_r12(u8 **pprog)
 {
 	u8 *prog =3D *pprog;
@@ -491,7 +507,7 @@ static void emit_prologue_tail_call(u8 **pprog, bool =
is_subprog)
  */
 static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cb=
pf,
 			  bool tail_call_reachable, bool is_subprog,
-			  bool is_exception_cb)
+			  bool is_exception_cb, enum bpf_pstack_state  pstack)
 {
 	u8 *prog =3D *pprog;
=20
@@ -518,6 +534,8 @@ static void emit_prologue(u8 **pprog, u32 stack_depth=
, bool ebpf_from_cbpf,
 		 * first restore those callee-saved regs from stack, before
 		 * reusing the stack frame.
 		 */
+		if (pstack)
+			pop_r9(&prog);
 		pop_callee_regs(&prog, all_callee_regs_used);
 		pop_r12(&prog);
 		/* Reset the stack frame. */
@@ -1404,6 +1422,22 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u=
8 src_reg, bool is64, u8 op)
 	*pprog =3D prog;
 }
=20
+static void emit_private_frame_ptr(u8 **pprog, void *private_frame_ptr)
+{
+	u8 *prog =3D *pprog;
+
+	/* movabs r9, private_frame_ptr */
+	emit_mov_imm64(&prog, X86_REG_R9, (long) private_frame_ptr >> 32,
+		       (u32) (long) private_frame_ptr);
+
+	/* add <r9>, gs:[<off>] */
+	EMIT2(0x65, 0x4c);
+	EMIT3(0x03, 0x0c, 0x25);
+	EMIT((u32)(unsigned long)&this_cpu_off, 4);
+
+	*pprog =3D prog;
+}
+
 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
=20
 #define __LOAD_TCC_PTR(off)			\
@@ -1421,20 +1455,31 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
 	int insn_cnt =3D bpf_prog->len;
 	bool seen_exit =3D false;
 	u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
+	void __percpu *private_frame_ptr =3D NULL;
 	u64 arena_vm_start, user_vm_start;
+	u32 orig_stack_depth, stack_depth;
 	int i, excnt =3D 0;
 	int ilen, proglen =3D 0;
 	u8 *prog =3D temp;
 	int err;
=20
+	stack_depth =3D bpf_prog->aux->stack_depth;
+	orig_stack_depth =3D round_up(stack_depth, 8);
+	if (bpf_prog->pstack) {
+		stack_depth =3D 0;
+		if (bpf_prog->pstack =3D=3D PSTACK_TREE_ROOT)
+			private_frame_ptr =3D bpf_prog->private_stack_ptr + orig_stack_depth;
+	}
+
 	arena_vm_start =3D bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
 	user_vm_start =3D bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
=20
 	detect_reg_usage(insn, insn_cnt, callee_regs_used);
=20
-	emit_prologue(&prog, bpf_prog->aux->stack_depth,
+	emit_prologue(&prog, stack_depth,
 		      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
-		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
+		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb,
+		      bpf_prog->pstack);
 	/* Exception callback will clobber callee regs for its own use, and
 	 * restore the original callee regs from main prog's stack frame.
 	 */
@@ -1454,6 +1499,17 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
 		emit_mov_imm64(&prog, X86_REG_R12,
 			       arena_vm_start >> 32, (u32) arena_vm_start);
=20
+	if (bpf_prog->pstack =3D=3D PSTACK_TREE_ROOT) {
+		emit_private_frame_ptr(&prog, private_frame_ptr);
+	} else if (bpf_prog->pstack =3D=3D PSTACK_TREE_INTERNAL  && orig_stack_=
depth) {
+		/* r9 +=3D orig_stack_depth */
+		maybe_emit_1mod(&prog, X86_REG_R9, true);
+		if (is_imm8(orig_stack_depth))
+			EMIT3(0x83, add_1reg(0xC0, X86_REG_R9), orig_stack_depth);
+		else
+			EMIT2_off32(0x81, add_1reg(0xC0, X86_REG_R9), orig_stack_depth);
+	}
+
 	ilen =3D prog - temp;
 	if (rw_image)
 		memcpy(rw_image + proglen, temp, ilen);
@@ -1473,6 +1529,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
 		u8 *func;
 		int nops;
=20
+		if (bpf_prog->pstack) {
+			if (src_reg =3D=3D BPF_REG_FP)
+				src_reg =3D X86_REG_R9;
+
+			if (dst_reg =3D=3D BPF_REG_FP)
+				dst_reg =3D X86_REG_R9;
+		}
+
 		switch (insn->code) {
 			/* ALU */
 		case BPF_ALU | BPF_ADD | BPF_X:
@@ -2128,14 +2192,20 @@ st:			if (is_imm8(insn->off))
=20
 			func =3D (u8 *) __bpf_call_base + imm32;
 			if (tail_call_reachable) {
-				LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
+				LOAD_TAIL_CALL_CNT_PTR(stack_depth);
 				ip +=3D 7;
 			}
 			if (!imm32)
 				return -EINVAL;
+			if (bpf_prog->pstack) {
+				push_r9(&prog);
+				ip +=3D 2;
+			}
 			ip +=3D x86_call_depth_emit_accounting(&prog, func, ip);
 			if (emit_call(&prog, func, ip))
 				return -EINVAL;
+			if (bpf_prog->pstack)
+				pop_r9(&prog);
 			break;
 		}
=20
@@ -2145,13 +2215,13 @@ st:			if (is_imm8(insn->off))
 							  &bpf_prog->aux->poke_tab[imm32 - 1],
 							  &prog, image + addrs[i - 1],
 							  callee_regs_used,
-							  bpf_prog->aux->stack_depth,
+							  stack_depth,
 							  ctx);
 			else
 				emit_bpf_tail_call_indirect(bpf_prog,
 							    &prog,
 							    callee_regs_used,
-							    bpf_prog->aux->stack_depth,
+							    stack_depth,
 							    image + addrs[i - 1],
 							    ctx);
 			break;
@@ -3559,6 +3629,11 @@ bool bpf_jit_supports_exceptions(void)
 	return IS_ENABLED(CONFIG_UNWINDER_ORC);
 }
=20
+bool bpf_jit_supports_private_stack(void)
+{
+	return true;
+}
+
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp=
, u64 bp), void *cookie)
 {
 #if defined(CONFIG_UNWINDER_ORC)
--=20
2.43.5


