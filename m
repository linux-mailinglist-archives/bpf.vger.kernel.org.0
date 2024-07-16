Return-Path: <bpf+bounces-34870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D998931E5B
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 03:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59EA283693
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 01:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682C28814;
	Tue, 16 Jul 2024 01:17:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5464A24
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 01:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721092625; cv=none; b=P39ygERexDwQ6CoDnWgob4xE4c0yrKxRMk8vA7hxHiyuJGn9g+RCcRvWRbc0lvm8qtQfJeOt9jvzDXoDcitpbqzch1ehdLTEkx1awmLltnwfzG3eTO1wluRSZlY7DKzT9fYG69BzwQl6BhdozbwVfs1d0Rev3jc3aQSOszONN58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721092625; c=relaxed/simple;
	bh=4RS7rIonO4mA802lCXvHhMb6tjaabzesbWVfWhwv2LY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pjTQz4aICtzSQiOrSNtIJGHleV4R3svPA7hLrTV8Ah02tHwv46JIbWxA3eMQ8HAN0PMjGVV3DkQRr4JnxsbBpMz3KgYPB8dFUY0NTu4A91qS1DtM/gtm71jjRzUJwCGsUUszAKtDFOdHLN2pZlSHvcUTfY3oI0SKZqU5R0MKjug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id D8AE96A17D4E; Mon, 15 Jul 2024 18:16:47 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v1 1/2] bpf: Support private stack for bpf progs
Date: Mon, 15 Jul 2024 18:16:47 -0700
Message-ID: <20240716011647.811746-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The main motivation for private stack comes from nested
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
this patch implemented a private stack so bpf program stack
space is allocated dynamically when the program is jited.
Such private stack is applied to tracing programs like
kprobe/uprobe, perf_event, tracepoint, raw tracepoint and
tracing.

But more than one instance of the same bpf program may
run in the system. To make things simple, percpu private
stack is allocated for each program, so if the same program
is running on different cpus concurrently, we won't have
any issue. Note that the kernel already have logic to prevent
the recursion for the same bpf program on the same cpu
(kprobe, fentry, etc.).

The patch implemented a percpu private stack based approach
for x86 arch.
  - The stack size will be 0 and any stack access is from
    jit-time allocated percpu storage.
  - In the beginning of jit, r9 is used to save percpu
    private stack pointer.
  - Each rbp in the bpf asm insn is replaced by r9.
  - For each call, push r9 before the call and pop r9
    after the call to preserve r9 value.

Compared to previous RFC patch [1], this patch added
some conditions to enable private stack, e.g., verifier
calculated stack size, prog type, etc. The new patch
also added a performance test to compare private stack
vs. no private stack.

The following are some code example to illustrate the idea
for selftest cgroup_skb_sk_lookup:

   the existing code                        the private-stack approach co=
de
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
Here the number of calls are those calls in the final jited binary.
Comparing function call itself, the push/pop overhead should be
minimum in most common cases.

Our original use case is for sched-ext nested scheduler. This will be don=
e
in the future.

  [1] https://lore.kernel.org/bpf/707970c5-6bba-450a-be08-adf24d8b9276@li=
nux.dev/T/

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 63 ++++++++++++++++++++++++++++++++++---
 include/linux/bpf.h         |  2 ++
 kernel/bpf/core.c           | 20 ++++++++++++
 kernel/bpf/syscall.c        |  1 +
 4 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d25d81c8ecc0..60f5d86fb6aa 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1309,6 +1309,22 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u=
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
 /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
@@ -1324,18 +1340,25 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
 	int insn_cnt =3D bpf_prog->len;
 	bool seen_exit =3D false;
 	u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
+	u32 stack_depth =3D bpf_prog->aux->stack_depth;
+	void __percpu *private_frame_ptr =3D NULL;
 	u64 arena_vm_start, user_vm_start;
 	int i, excnt =3D 0;
 	int ilen, proglen =3D 0;
 	u8 *prog =3D temp;
 	int err;
=20
+	if (bpf_prog->private_stack_ptr) {
+		private_frame_ptr =3D bpf_prog->private_stack_ptr + round_up(stack_dep=
th, 8);
+		stack_depth =3D 0;
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
 		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
 	/* Exception callback will clobber callee regs for its own use, and
@@ -1357,6 +1380,9 @@ static int do_jit(struct bpf_prog *bpf_prog, int *a=
ddrs, u8 *image, u8 *rw_image
 		emit_mov_imm64(&prog, X86_REG_R12,
 			       arena_vm_start >> 32, (u32) arena_vm_start);
=20
+	if (private_frame_ptr)
+		emit_private_frame_ptr(&prog, private_frame_ptr);
+
 	ilen =3D prog - temp;
 	if (rw_image)
 		memcpy(rw_image + proglen, temp, ilen);
@@ -1376,6 +1402,14 @@ static int do_jit(struct bpf_prog *bpf_prog, int *=
addrs, u8 *image, u8 *rw_image
 		u8 *func;
 		int nops;
=20
+		if (private_frame_ptr) {
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
@@ -2007,6 +2041,7 @@ st:			if (is_imm8(insn->off))
 				emit_mov_reg(&prog, is64, real_src_reg, BPF_REG_0);
 				/* Restore R0 after clobbering RAX */
 				emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
+
 				break;
 			}
=20
@@ -2031,14 +2066,20 @@ st:			if (is_imm8(insn->off))
=20
 			func =3D (u8 *) __bpf_call_base + imm32;
 			if (tail_call_reachable) {
-				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
+				RESTORE_TAIL_CALL_CNT(stack_depth);
 				ip +=3D 7;
 			}
 			if (!imm32)
 				return -EINVAL;
+			if (private_frame_ptr) {
+				EMIT2(0x41, 0x51); /* push r9 */
+				ip +=3D 2;
+			}
 			ip +=3D x86_call_depth_emit_accounting(&prog, func, ip);
 			if (emit_call(&prog, func, ip))
 				return -EINVAL;
+			if (private_frame_ptr)
+				EMIT2(0x41, 0x59); /* pop r9 */
 			break;
 		}
=20
@@ -2048,13 +2089,13 @@ st:			if (is_imm8(insn->off))
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
@@ -3218,6 +3259,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pro=
g *prog)
 {
 	struct bpf_binary_header *rw_header =3D NULL;
 	struct bpf_binary_header *header =3D NULL;
+	void __percpu *private_stack_ptr =3D NULL;
 	struct bpf_prog *tmp, *orig_prog =3D prog;
 	struct x64_jit_data *jit_data;
 	int proglen, oldproglen =3D 0;
@@ -3284,6 +3326,15 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pr=
og *prog)
 	ctx.cleanup_addr =3D proglen;
 skip_init_addrs:
=20
+	if (bpf_enable_private_stack(prog) && !prog->private_stack_ptr) {
+		private_stack_ptr =3D __alloc_percpu_gfp(prog->aux->stack_depth, 8, GF=
P_KERNEL);
+		if (!private_stack_ptr) {
+			prog =3D orig_prog;
+			goto out_addrs;
+		}
+		prog->private_stack_ptr =3D private_stack_ptr;
+	}
+
 	/*
 	 * JITed image shrinks with every pass and the loop iterates
 	 * until the image stops shrinking. Very large BPF programs
@@ -3309,6 +3360,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_pr=
og *prog)
 				prog->jited =3D 0;
 				prog->jited_len =3D 0;
 			}
+			if (private_stack_ptr) {
+				free_percpu(private_stack_ptr);
+				prog->private_stack_ptr =3D NULL;
+			}
 			goto out_addrs;
 		}
 		if (image) {
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4f1d4a97b9d1..19a3f5355363 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1563,6 +1563,7 @@ struct bpf_prog {
 					    const struct bpf_insn *insn);
 	struct bpf_prog_aux	*aux;		/* Auxiliary fields */
 	struct sock_fprog_kern	*orig_prog;	/* Original BPF program */
+	void __percpu		*private_stack_ptr;
 	/* Instructions for interpreter */
 	union {
 		DECLARE_FLEX_ARRAY(struct sock_filter, insns);
@@ -1819,6 +1820,7 @@ static inline void bpf_module_put(const void *data,=
 struct module *owner)
 		module_put(owner);
 }
 int bpf_struct_ops_link_create(union bpf_attr *attr);
+bool bpf_enable_private_stack(struct bpf_prog *prog);
=20
 #ifdef CONFIG_NET
 /* Define it here to avoid the use of forward declaration */
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7ee62e38faf0..f69eb0c5fe03 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2813,6 +2813,26 @@ void bpf_prog_free(struct bpf_prog *fp)
 }
 EXPORT_SYMBOL_GPL(bpf_prog_free);
=20
+bool bpf_enable_private_stack(struct bpf_prog *prog)
+{
+	if (prog->aux->stack_depth <=3D 64)
+		return false;
+
+	switch (prog->aux->prog->type) {
+	case BPF_PROG_TYPE_KPROBE:
+	case BPF_PROG_TYPE_TRACEPOINT:
+	case BPF_PROG_TYPE_PERF_EVENT:
+	case BPF_PROG_TYPE_RAW_TRACEPOINT:
+		return true;
+	case BPF_PROG_TYPE_TRACING:
+		if (prog->expected_attach_type !=3D BPF_TRACE_ITER)
+			return true;
+		fallthrough;
+	default:
+		return false;
+	}
+}
+
 /* RNG for unprivileged user space with separated state from prandom_u32=
(). */
 static DEFINE_PER_CPU(struct rnd_state, bpf_user_rnd_state);
=20
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 869265852d51..89162ddb4747 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2244,6 +2244,7 @@ static void __bpf_prog_put_rcu(struct rcu_head *rcu=
)
=20
 	kvfree(aux->func_info);
 	kfree(aux->func_info_aux);
+	free_percpu(aux->prog->private_stack_ptr);
 	free_uid(aux->user);
 	security_bpf_prog_free(aux->prog);
 	bpf_prog_free(aux->prog);
--=20
2.43.0


