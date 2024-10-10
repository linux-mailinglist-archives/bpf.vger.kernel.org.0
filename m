Return-Path: <bpf+bounces-41606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A38FF998F1B
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 19:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22BC91F25D42
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 17:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5D319D084;
	Thu, 10 Oct 2024 17:59:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D13319D078
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 17:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583153; cv=none; b=E369W7zUsgGyajtAlmwuyXUgl7EmD4qV37Unbt63/Q1VGCrH6rWP6MApTCSzhiCnLM0Jh/zbpZhxoykhKpDctNjCjbBHiOvTMOzKv0v6fU0tWREkd+yw0SJJn5cyMjZ7geFjNP6WsIPLTzPp6nKZ0LBDFA1hykL6zUQy7wqYgi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583153; c=relaxed/simple;
	bh=JXHiWZQsFCNNhQXWmIKmRiUaix4QlY5rCF/57pGJMws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXyShq5ACKXMUbHHDuqTZFCa8+LzD21aDcp17KeMUOW05Ax1pNGEwgBQNa8Hx+q5csIovUFOdYS9rctZzSN2/bSlefqkx/2zr9YVzjR3Qa3PHp+lGRq1uvCJK3mqVuKvX8rLia3zWshmdpVTivXIFzZsDzV6petU+9OEw9bgqeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 4FD4B9F27C4C; Thu, 10 Oct 2024 10:56:38 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v4 09/10] bpf, x86: Jit support for nested bpf_prog_call
Date: Thu, 10 Oct 2024 10:56:38 -0700
Message-ID: <20241010175638.1899406-1-yonghong.song@linux.dev>
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

Two functions are added in the kernel
  - int notrace __bpf_prog_enter_recur_limited(struct bpf_prog *prog)
  - void notrace __bpf_prog_exit_recur_limited(struct bpf_prog *prog)
and they are called in bpf progs through jit.

Func __bpf_prog_enter_recur_limited() will return 0 if maximum recursion
level has been reached in which case, bpf prog will return to the caller
directly. Otherwise, it will return the current recursion level. The
recursion level will be used by jit to calculated proper frame pointer
for that recursion level.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 94 +++++++++++++++++++++++++++++++++----
 include/linux/bpf.h         |  2 +
 kernel/bpf/trampoline.c     | 16 +++++++
 3 files changed, 104 insertions(+), 8 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 297dd64f4b6a..a763e018e87f 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -501,7 +501,8 @@ static void emit_prologue_tail_call(u8 **pprog, bool =
is_subprog)
 }
=20
 static void emit_priv_frame_ptr(u8 **pprog, struct bpf_prog *bpf_prog,
-				enum bpf_priv_stack_mode priv_stack_mode);
+				enum bpf_priv_stack_mode priv_stack_mode,
+				bool is_subprog, u8 *image, u8 *temp);
=20
 /*
  * Emit x86-64 prologue code for BPF program.
@@ -510,7 +511,8 @@ static void emit_priv_frame_ptr(u8 **pprog, struct bp=
f_prog *bpf_prog,
  */
 static void emit_prologue(u8 **pprog, u32 stack_depth, struct bpf_prog *=
bpf_prog,
 			  bool tail_call_reachable,
-			  enum bpf_priv_stack_mode priv_stack_mode)
+			  enum bpf_priv_stack_mode priv_stack_mode, u8 *image,
+			  u8 *temp)
 {
 	bool ebpf_from_cbpf =3D bpf_prog_was_classic(bpf_prog);
 	bool is_exception_cb =3D bpf_prog->aux->exception_cb;
@@ -554,7 +556,7 @@ static void emit_prologue(u8 **pprog, u32 stack_depth=
, struct bpf_prog *bpf_prog
 	/* X86_TAIL_CALL_OFFSET is here */
 	EMIT_ENDBR();
=20
-	emit_priv_frame_ptr(&prog, bpf_prog, priv_stack_mode);
+	emit_priv_frame_ptr(&prog, bpf_prog, priv_stack_mode, is_subprog, image=
, temp);
=20
 	/* sub rsp, rounded_stack_depth */
 	if (stack_depth)
@@ -696,6 +698,15 @@ static void emit_return(u8 **pprog, u8 *ip)
 	*pprog =3D prog;
 }
=20
+static int num_bytes_of_emit_return(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
+		return 5;
+	if (IS_ENABLED(CONFIG_MITIGATION_SLS))
+		return 2;
+	return 1;
+}
+
 #define BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack)	(-16 - round_up(stack, 8)=
)
=20
 /*
@@ -1527,17 +1538,67 @@ static void emit_root_priv_frame_ptr(u8 **pprog, =
struct bpf_prog *bpf_prog,
 }
=20
 static void emit_priv_frame_ptr(u8 **pprog, struct bpf_prog *bpf_prog,
-				enum bpf_priv_stack_mode priv_stack_mode)
+				enum bpf_priv_stack_mode priv_stack_mode,
+				bool is_subprog, u8 *image, u8 *temp)
 {
 	u32 orig_stack_depth =3D round_up(bpf_prog->aux->stack_depth, 8);
 	u8 *prog =3D *pprog;
=20
-	if (priv_stack_mode =3D=3D PRIV_STACK_ROOT_PROG)
-		emit_root_priv_frame_ptr(&prog, bpf_prog, orig_stack_depth);
-	else if (priv_stack_mode =3D=3D PRIV_STACK_SUB_PROG && orig_stack_depth=
)
+	if (priv_stack_mode =3D=3D PRIV_STACK_ROOT_PROG) {
+		int offs;
+		u8 *func;
+
+		if (!bpf_prog->aux->has_prog_call) {
+			emit_root_priv_frame_ptr(&prog, bpf_prog, orig_stack_depth);
+		} else {
+			EMIT1(0x57);		/* push rdi */
+			if (is_subprog) {
+				/* subprog may have up to 5 arguments */
+				EMIT1(0x56);		/* push rsi */
+				EMIT1(0x52);		/* push rdx */
+				EMIT1(0x51);		/* push rcx */
+				EMIT2(0x41, 0x50);	/* push r8 */
+			}
+			emit_mov_imm64(&prog, BPF_REG_1, (long) bpf_prog >> 32,
+				       (u32) (long) bpf_prog);
+			func =3D (u8 *)__bpf_prog_enter_recur_limited;
+			offs =3D prog - temp;
+			offs +=3D x86_call_depth_emit_accounting(&prog, func, image + offs);
+			emit_call(&prog, func, image + offs);
+			if (is_subprog) {
+				EMIT2(0x41, 0x58);	/* pop r8 */
+				EMIT1(0x59);		/* pop rcx */
+				EMIT1(0x5a);		/* pop rdx */
+				EMIT1(0x5e);		/* pop rsi */
+			}
+			EMIT1(0x5f);		/* pop rdi */
+
+			EMIT4(0x48, 0x83, 0xf8, 0x0);   /* cmp rax,0x0 */
+			EMIT2(X86_JNE, num_bytes_of_emit_return() + 1);
+
+			/* return if stack recursion has been reached */
+			EMIT1(0xC9);    /* leave */
+			emit_return(&prog, image + (prog - temp));
+
+			/* cnt -=3D 1 */
+			emit_alu_helper_1(&prog, BPF_ALU64 | BPF_SUB | BPF_K,
+					  BPF_REG_0, 1);
+
+			/* accum_stack_depth =3D cnt * subtree_stack_depth */
+			emit_alu_helper_3(&prog, BPF_ALU64 | BPF_MUL | BPF_K, BPF_REG_0,
+					  bpf_prog->aux->subtree_stack_depth);
+
+			emit_root_priv_frame_ptr(&prog, bpf_prog, orig_stack_depth);
+
+			/* r9 +=3D accum_stack_depth */
+			emit_alu_helper_2(&prog, BPF_ALU64 | BPF_ADD | BPF_X, X86_REG_R9,
+					  BPF_REG_0);
+		}
+	} else if (priv_stack_mode =3D=3D PRIV_STACK_SUB_PROG && orig_stack_dep=
th) {
 		/* r9 +=3D orig_stack_depth */
 		emit_alu_helper_1(&prog, BPF_ALU64 | BPF_ADD | BPF_K, X86_REG_R9,
 				  orig_stack_depth);
+	}
=20
 	*pprog =3D prog;
 }
@@ -1578,7 +1639,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *a=
ddrs, u8 *image, u8 *rw_image
 	detect_reg_usage(insn, insn_cnt, callee_regs_used);
=20
 	emit_prologue(&prog, stack_depth, bpf_prog, tail_call_reachable,
-		      priv_stack_mode);
+		      priv_stack_mode, image, temp);
 	/* Exception callback will clobber callee regs for its own use, and
 	 * restore the original callee regs from main prog's stack frame.
 	 */
@@ -2519,6 +2580,23 @@ st:			if (is_imm8(insn->off))
 				if (arena_vm_start)
 					pop_r12(&prog);
 			}
+
+			if (bpf_prog->aux->has_prog_call) {
+				u8 *func, *ip;
+				int offs;
+
+				ip =3D image + addrs[i - 1];
+				/* save and restore the return value */
+				EMIT1(0x50);    /* push rax */
+				emit_mov_imm64(&prog, BPF_REG_1, (long) bpf_prog >> 32,
+					       (u32) (long) bpf_prog);
+				func =3D (u8 *)__bpf_prog_exit_recur_limited;
+				offs =3D prog - temp;
+				offs +=3D x86_call_depth_emit_accounting(&prog, func, ip + offs);
+				emit_call(&prog, func, ip + offs);
+				EMIT1(0x58);    /* pop rax */
+			}
+
 			EMIT1(0xC9);         /* leave */
 			emit_return(&prog, image + addrs[i - 1] + (prog - temp));
 			break;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 952cb398eb30..605004cba9f7 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1148,6 +1148,8 @@ u64 notrace __bpf_prog_enter_sleepable_recur(struct=
 bpf_prog *prog,
 					     struct bpf_tramp_run_ctx *run_ctx);
 void notrace __bpf_prog_exit_sleepable_recur(struct bpf_prog *prog, u64 =
start,
 					     struct bpf_tramp_run_ctx *run_ctx);
+int notrace __bpf_prog_enter_recur_limited(struct bpf_prog *prog);
+void notrace __bpf_prog_exit_recur_limited(struct bpf_prog *prog);
 void notrace __bpf_tramp_enter(struct bpf_tramp_image *tr);
 void notrace __bpf_tramp_exit(struct bpf_tramp_image *tr);
 typedef u64 (*bpf_trampoline_enter_t)(struct bpf_prog *prog,
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index f8302a5ca400..d9e7260e4b39 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -960,6 +960,22 @@ void notrace __bpf_prog_exit_sleepable_recur(struct =
bpf_prog *prog, u64 start,
 	rcu_read_unlock_trace();
 }
=20
+int notrace __bpf_prog_enter_recur_limited(struct bpf_prog *prog)
+{
+	int cnt =3D this_cpu_inc_return(*(prog->active));
+
+	if (cnt > BPF_MAX_PRIV_STACK_NEST_LEVEL) {
+		bpf_prog_inc_misses_counter(prog);
+		return 0;
+	}
+	return cnt;
+}
+
+void notrace __bpf_prog_exit_recur_limited(struct bpf_prog *prog)
+{
+	this_cpu_dec(*(prog->active));
+}
+
 static u64 notrace __bpf_prog_enter_sleepable(struct bpf_prog *prog,
 					      struct bpf_tramp_run_ctx *run_ctx)
 {
--=20
2.43.5


