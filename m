Return-Path: <bpf+bounces-31695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9068F901A23
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 07:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFDCE2812B5
	for <lists+bpf@lfdr.de>; Mon, 10 Jun 2024 05:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DC2D27E;
	Mon, 10 Jun 2024 05:18:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CAA3224
	for <bpf@vger.kernel.org>; Mon, 10 Jun 2024 05:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717996736; cv=none; b=hr9vdhZ6HIS4FYvFHYk68eusHQE7nUBn1yfMICENFeUF35NQcFFDzS8lE8Yuo+WXVeoqZKZuNa89GnU8/dKQ3eWHB5w6+gyXBABBK/8+N6Z5gf1izHNl/EHxzmK/QjOesU9OsaevgWg+iUpqnd42W2jVjv5jLhup8fFoxOB8OxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717996736; c=relaxed/simple;
	bh=tzSbnVb69f1Nxe+OZtBtWKYj0n+7KyRwZKmhemZxJO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ipArL+VxhpBxm+U0NYV+eL4KDPJPU5lAT/bERAPly1ftsX2FsiLoO9LzCdDpJsqd5W2+0z72spkEMt6fI+nQEaFAqWYhXrJhWROVD9SsvyZEtJsJ95StRbUMsGJ8XJUO3+xdIMBcnnSdBDQt5lg7fjeSsD2aEEBOFQJ57vR/ja8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id EB13754BA6E3; Sun,  9 Jun 2024 22:18:39 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [RFC PATCH bpf-next] bpf: Support shadow stack for bpf progs
Date: Sun,  9 Jun 2024 22:18:39 -0700
Message-ID: <20240610051839.1296086-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The main motivation for shadow stack comes from nested
scheduler in sched-ext from Tejun. The basic idea is that
 - each cgroup will its own associated bpf program,
 - bpf program with parent cgroup will call bpf programs
   in immediate child cgroups.

Let us say we have the following cgroup hierarchy:
  root_cg (prog0):
    cg1 (prog1):
      cg11 (prog11):
        cg111 (prog111)
        cg112 (prog112)
      cg12 (prog12):
        cg121 (prog121)
        cg122 (prog122)
    cg2 (prog2):
      cg21 (prog21)
      cg22 (prog22)
      cg23 (prog23)

In the above example, prog0 will call a kfunc which will
call prog1 and prog2 to get sched info for cg1 and cg2 and
then the information is summarized and sent back to prog0.
Similarly, prog11 and prog12 will be invoked in the kfunc
and the result will be summarized and sent back to prog1, etc.

Currently, for each thread, the x86 kernel allocate 8KB stack.
The each bpf program (including its subprograms) has maximum
512B stack size to avoid potential stack overflow.
And nested bpf programs increase the risk of stack overflow.
To avoid potential stack overflow caused by bpf programs,
this patch implemented a shadow stack so bpf program stack
space is allocated dynamically when the program is jited.

But more than one instance of the same bpf program may
run in the system. To make things simple, percpu shadow
stack is allocated for each program, so if the same program
is running on different cpus concurrently, we won't have
any issue. Note that the kernel already have logic to prevent
the recursion for the same bpf program on the same cpu
(kprobe, fentry, etc.).

The patch implemented a percpu shadow stack based approach
for x86 arch.
  - The stack size will be 0.
  - In the beginning of jit, r9 is used to save percpu
    shadow stack pointer.
  - Each rbp in the bpf asm insn is replaced by r9.
  - For each call, push r9 before the call and pop r9
    after the call to preserve r9 value.

The following are some code example to illustrate the idea
for selftest cgroup_skb_sk_lookup:

   the existing code                        the shadow-stack approach cod=
e
   endbr64                                  endbr64
   nop    DWORD PTR [rax+rax*1+0x0]         nop    DWORD PTR [rax+rax*1+0=
x0]
   xchg   ax,ax                             xchg   ax,ax
   push   rbp                               push   rbp
   mov    rbp,rsp                           mov    rbp,rsp
   endbr64                                  endbr64
   sub    rsp,0x68
   push   rbx                               push   rbx
   ...                                      ...
   ...                                      mov    r9d,0x8c1c860
   ...                                      add    r9,QWORD PTR gs:0x21a0=
0
   ...                                      ...
   mov    rdx,rbp                           mov    rdx, r9
   add    rdx,0xffffffffffffffb4            rdx,0xffffffffffffffb4
   ...                                      ...
   mov    ecx,0x28                          mov    ecx,0x28
                                            push   r9
   call   0xffffffffe305e474                call   0xffffffffe305e524
                                            pop    r9
   mov    rdi,rax                           mov    rdi,rax
   ...                                      ...
   movzx  rdi,BYTE PTR [rbp-0x46]           movzx  rdi,BYTE PTR [r9-0x46]
   ...                                      ...

So the number of insns is increased by 1 + num_of_calls * 2.

There are an alternative approach is to do
  mov    r9d,0x8c1c860
  add    r9,QWORD PTR gs:0x21a00
right before each rbp usage where the rbp is replaced with r9.
The number of insns is increased by num_of_rbp_usage * 2.

The current implementation is preferred since for a bpf prog
using a lot of stack space, the number of calls is mostly likely
much smaller than stack access.

This simple implementation passed all selftests. I marked it as
RFC since several issues need to be resolved.
  - The tradeoff between simplicity/more_memory/reasonable_performance vs=
.
    complex/less_memory/worse_performance.

    The percpu shadow stack makes implementation much simpler.
    My previous approach (as discussed in lsfmmbpf2024) used
    a more complex way trying to avoid excess shadow stack memory by usin=
g
    a few percpu pages for non-sleepable programs and runtime allocation
    for sleepable programs. This can save some memory but will make jit
    more complex and also degrade performance quite a bit esp. for sleepa=
ble
    programs.
  - Should we introduce a flag during program load to indicate whether
    the program should use shadow stack or not? There are a couple of cas=
es
    here:
      - for xdp prog, performance is hugely critical. the current
        implement may still degreate performance slightly.
      - for a system with huge number of cpus, e.g., 256, 1024,
        and only one instance of the bpf program is running. It could
        be quite some memory waste, esp. if there are quite some bpf
        progs are running on the system.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 61 ++++++++++++++++++++++++++++++++++---
 include/linux/bpf.h         |  1 +
 kernel/bpf/syscall.c        |  1 +
 3 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 5159c7a22922..1af62ade0ceb 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -19,6 +19,8 @@
 #include <asm/unwind.h>
 #include <asm/cfi.h>
=20
+static const int global_enable_shadow_stack =3D 1;
+
 static bool all_callee_regs_used[4] =3D {true, true, true, true};
=20
 static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
@@ -1311,6 +1313,21 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u=
8 src_reg, bool is64, u8 op)
 	*pprog =3D prog;
 }
=20
+static void emit_percpu_shadow_frame_ptr(u8 **pprog, void *shadow_frame_=
ptr)
+{
+	u8 *prog =3D *pprog;
+
+	/* movabs r9, shadow_frame_ptr */
+	emit_mov_imm32(&prog, false, X86_REG_R9, (u32) (long) shadow_frame_ptr)=
;
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
 /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
@@ -1326,13 +1343,31 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
 	int insn_cnt =3D bpf_prog->len;
 	bool tail_call_seen =3D false;
 	bool seen_exit =3D false;
+	void *percpu_shadow_stack_ptr, *shadow_frame_ptr =3D NULL;
+	bool enable_shadow_stack =3D global_enable_shadow_stack;
 	u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
+	u32 stack_depth =3D bpf_prog->aux->stack_depth;
 	u64 arena_vm_start, user_vm_start;
 	int i, excnt =3D 0;
 	int ilen, proglen =3D 0;
 	u8 *prog =3D temp;
 	int err;
=20
+	if (stack_depth && enable_shadow_stack) {
+		if (bpf_prog->percpu_shadow_stack_ptr) {
+			percpu_shadow_stack_ptr =3D bpf_prog->percpu_shadow_stack_ptr;
+		} else {
+			percpu_shadow_stack_ptr =3D __alloc_percpu_gfp(stack_depth, 8, GFP_KE=
RNEL);
+			if (!percpu_shadow_stack_ptr)
+				return -ENOMEM;
+			bpf_prog->percpu_shadow_stack_ptr =3D percpu_shadow_stack_ptr;
+		}
+		shadow_frame_ptr =3D percpu_shadow_stack_ptr + round_up(stack_depth, 8=
);
+		stack_depth =3D 0;
+	} else {
+		enable_shadow_stack =3D 0;
+	}
+
 	arena_vm_start =3D bpf_arena_get_kern_vm_start(bpf_prog->aux->arena);
 	user_vm_start =3D bpf_arena_get_user_vm_start(bpf_prog->aux->arena);
=20
@@ -1342,7 +1377,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *a=
ddrs, u8 *image, u8 *rw_image
 	/* tail call's presence in current prog implies it is reachable */
 	tail_call_reachable |=3D tail_call_seen;
=20
-	emit_prologue(&prog, bpf_prog->aux->stack_depth,
+	emit_prologue(&prog, stack_depth,
 		      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
 		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
 	/* Exception callback will clobber callee regs for its own use, and
@@ -1364,6 +1399,9 @@ static int do_jit(struct bpf_prog *bpf_prog, int *a=
ddrs, u8 *image, u8 *rw_image
 		emit_mov_imm64(&prog, X86_REG_R12,
 			       arena_vm_start >> 32, (u32) arena_vm_start);
=20
+	if (enable_shadow_stack)
+		emit_percpu_shadow_frame_ptr(&prog, shadow_frame_ptr);
+
 	ilen =3D prog - temp;
 	if (rw_image)
 		memcpy(rw_image + proglen, temp, ilen);
@@ -1383,6 +1421,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
 		u8 *func;
 		int nops;
=20
+		if (enable_shadow_stack) {
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
@@ -2014,6 +2060,7 @@ st:			if (is_imm8(insn->off))
 				emit_mov_reg(&prog, is64, real_src_reg, BPF_REG_0);
 				/* Restore R0 after clobbering RAX */
 				emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
+
 				break;
 			}
=20
@@ -2038,14 +2085,20 @@ st:			if (is_imm8(insn->off))
=20
 			func =3D (u8 *) __bpf_call_base + imm32;
 			if (tail_call_reachable) {
-				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
+				RESTORE_TAIL_CALL_CNT(stack_depth);
 				ip +=3D 7;
 			}
 			if (!imm32)
 				return -EINVAL;
+			if (enable_shadow_stack) {
+				EMIT2(0x41, 0x51);
+				ip +=3D 2;
+			}
 			ip +=3D x86_call_depth_emit_accounting(&prog, func, ip);
 			if (emit_call(&prog, func, ip))
 				return -EINVAL;
+			if (enable_shadow_stack)
+				EMIT2(0x41, 0x59);
 			break;
 		}
=20
@@ -2055,13 +2108,13 @@ st:			if (is_imm8(insn->off))
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
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a834f4b761bc..08014b4954f0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1563,6 +1563,7 @@ struct bpf_prog {
 					    const struct bpf_insn *insn);
 	struct bpf_prog_aux	*aux;		/* Auxiliary fields */
 	struct sock_fprog_kern	*orig_prog;	/* Original BPF program */
+	void			*percpu_shadow_stack_ptr;
 	/* Instructions for interpreter */
 	union {
 		DECLARE_FLEX_ARRAY(struct sock_filter, insns);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 5070fa20d05c..7b9093cc3671 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2244,6 +2244,7 @@ static void __bpf_prog_put_rcu(struct rcu_head *rcu=
)
=20
 	kvfree(aux->func_info);
 	kfree(aux->func_info_aux);
+	free_percpu(aux->prog->percpu_shadow_stack_ptr);
 	free_uid(aux->user);
 	security_bpf_prog_free(aux->prog);
 	bpf_prog_free(aux->prog);
--=20
2.43.0


