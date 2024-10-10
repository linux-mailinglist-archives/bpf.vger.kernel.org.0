Return-Path: <bpf+bounces-41599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E4F998EFD
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 19:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF06286801
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 17:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBE819ABCB;
	Thu, 10 Oct 2024 17:56:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBA219D89E
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 17:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582980; cv=none; b=BzYAkXuZ2R0BztNvWwYp7I627Iu/9cMy3/1HwIDMmeUpDCltPQGT+kqAt5qIacDJb1qWnj0SALFYeEdwHn5/ZphszbTgfRhbyzHNSdw5+/N2F2PyBycyh1o7F3ODeuGpfJfLJ1QgGI99MDmcsWZUktZpRQckdTchQB8Euyefm88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582980; c=relaxed/simple;
	bh=yuLxpvwL7uG7lRCX6678J8lv7oU/X2ADSI5kFDo6wiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0bXohcjK7582w/57R6dzJehMSIlh91nNzqtv9Mxi5H4vPaKT2gHcErHJqIvXelVcRRLqvSmrfHUtj1b5CNhVc3qddz/35hAnSE5XJCkwcw5bkIANBjVkxE5VTBYidc/DMMfvkEOGklS9Z+5X1LGlteun86WhfLulx7/nSgRDwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 25A239F27BD1; Thu, 10 Oct 2024 10:56:18 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v4 05/10] bpf, x86: Add jit support for private stack
Date: Thu, 10 Oct 2024 10:56:18 -0700
Message-ID: <20241010175618.1897998-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241010175552.1895980-1-yonghong.song@linux.dev>
References: <20241010175552.1895980-1-yonghong.song@linux.dev>
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

Let us say that priv_stack_ptr is the memory address allocated for
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
 arch/x86/net/bpf_jit_comp.c | 88 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index f01fdabf786e..a6ba85cec49a 100644
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
@@ -484,13 +500,17 @@ static void emit_prologue_tail_call(u8 **pprog, boo=
l is_subprog)
 	*pprog =3D prog;
 }
=20
+static void emit_priv_frame_ptr(u8 **pprog, struct bpf_prog *bpf_prog,
+				enum bpf_priv_stack_mode priv_stack_mode);
+
 /*
  * Emit x86-64 prologue code for BPF program.
  * bpf_tail_call helper will skip the first X86_TAIL_CALL_OFFSET bytes
  * while jumping to another program
  */
 static void emit_prologue(u8 **pprog, u32 stack_depth, struct bpf_prog *=
bpf_prog,
-			  bool tail_call_reachable)
+			  bool tail_call_reachable,
+			  enum bpf_priv_stack_mode priv_stack_mode)
 {
 	bool ebpf_from_cbpf =3D bpf_prog_was_classic(bpf_prog);
 	bool is_exception_cb =3D bpf_prog->aux->exception_cb;
@@ -520,6 +540,8 @@ static void emit_prologue(u8 **pprog, u32 stack_depth=
, struct bpf_prog *bpf_prog
 		 * first restore those callee-saved regs from stack, before
 		 * reusing the stack frame.
 		 */
+		if (priv_stack_mode !=3D NO_PRIV_STACK)
+			pop_r9(&prog);
 		pop_callee_regs(&prog, all_callee_regs_used);
 		pop_r12(&prog);
 		/* Reset the stack frame. */
@@ -532,6 +554,8 @@ static void emit_prologue(u8 **pprog, u32 stack_depth=
, struct bpf_prog *bpf_prog
 	/* X86_TAIL_CALL_OFFSET is here */
 	EMIT_ENDBR();
=20
+	emit_priv_frame_ptr(&prog, bpf_prog, priv_stack_mode);
+
 	/* sub rsp, rounded_stack_depth */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8));
@@ -1451,6 +1475,42 @@ static void emit_alu_helper_1(u8 **pprog, u8 insn_=
code, u32 dst_reg, s32 imm32)
 	*pprog =3D prog;
 }
=20
+static void emit_root_priv_frame_ptr(u8 **pprog, struct bpf_prog *bpf_pr=
og,
+				     u32 orig_stack_depth)
+{
+	void __percpu *priv_frame_ptr;
+	u8 *prog =3D *pprog;
+
+	priv_frame_ptr =3D bpf_prog->aux->priv_stack_ptr + orig_stack_depth;
+
+	/* movabs r9, priv_frame_ptr */
+	emit_mov_imm64(&prog, X86_REG_R9, (long) priv_frame_ptr >> 32,
+		       (u32) (long) priv_frame_ptr);
+#ifdef CONFIG_SMP
+	/* add <r9>, gs:[<off>] */
+	EMIT2(0x65, 0x4c);
+	EMIT3(0x03, 0x0c, 0x25);
+	EMIT((u32)(unsigned long)&this_cpu_off, 4);
+#endif
+	*pprog =3D prog;
+}
+
+static void emit_priv_frame_ptr(u8 **pprog, struct bpf_prog *bpf_prog,
+				enum bpf_priv_stack_mode priv_stack_mode)
+{
+	u32 orig_stack_depth =3D round_up(bpf_prog->aux->stack_depth, 8);
+	u8 *prog =3D *pprog;
+
+	if (priv_stack_mode =3D=3D PRIV_STACK_ROOT_PROG)
+		emit_root_priv_frame_ptr(&prog, bpf_prog, orig_stack_depth);
+	else if (priv_stack_mode =3D=3D PRIV_STACK_SUB_PROG && orig_stack_depth=
)
+		/* r9 +=3D orig_stack_depth */
+		emit_alu_helper_1(&prog, BPF_ALU64 | BPF_ADD | BPF_K, X86_REG_R9,
+				  orig_stack_depth);
+
+	*pprog =3D prog;
+}
+
 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
=20
 #define __LOAD_TCC_PTR(off)			\
@@ -1464,6 +1524,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *a=
ddrs, u8 *image, u8 *rw_image
 {
 	bool tail_call_reachable =3D bpf_prog->aux->tail_call_reachable;
 	struct bpf_insn *insn =3D bpf_prog->insnsi;
+	enum bpf_priv_stack_mode priv_stack_mode;
 	bool callee_regs_used[4] =3D {};
 	int insn_cnt =3D bpf_prog->len;
 	bool seen_exit =3D false;
@@ -1476,13 +1537,17 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
 	int err;
=20
 	stack_depth =3D bpf_prog->aux->stack_depth;
+	priv_stack_mode =3D bpf_prog->aux->priv_stack_mode;
+	if (priv_stack_mode !=3D NO_PRIV_STACK)
+		stack_depth =3D 0;
=20
 	arena_vm_start =3D bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
 	user_vm_start =3D bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
=20
 	detect_reg_usage(insn, insn_cnt, callee_regs_used);
=20
-	emit_prologue(&prog, stack_depth, bpf_prog, tail_call_reachable);
+	emit_prologue(&prog, stack_depth, bpf_prog, tail_call_reachable,
+		      priv_stack_mode);
 	/* Exception callback will clobber callee regs for its own use, and
 	 * restore the original callee regs from main prog's stack frame.
 	 */
@@ -1521,6 +1586,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
 		u8 *func;
 		int nops;
=20
+		if (priv_stack_mode !=3D NO_PRIV_STACK) {
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
@@ -2146,9 +2219,15 @@ st:			if (is_imm8(insn->off))
 			}
 			if (!imm32)
 				return -EINVAL;
+			if (priv_stack_mode !=3D NO_PRIV_STACK) {
+				push_r9(&prog);
+				ip +=3D 2;
+			}
 			ip +=3D x86_call_depth_emit_accounting(&prog, func, ip);
 			if (emit_call(&prog, func, ip))
 				return -EINVAL;
+			if (priv_stack_mode !=3D NO_PRIV_STACK)
+				pop_r9(&prog);
 			break;
 		}
=20
@@ -3572,6 +3651,11 @@ bool bpf_jit_supports_exceptions(void)
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


