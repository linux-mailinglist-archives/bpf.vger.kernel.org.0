Return-Path: <bpf+bounces-27660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744598B06D0
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 12:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DFB8B25592
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 10:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F5D159579;
	Wed, 24 Apr 2024 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpgydWVv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A538158D9A;
	Wed, 24 Apr 2024 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952939; cv=none; b=GnKsFkdpP90RCyLUpeu+gMddG6QTzxHW9OiQ9Syp75CKoAiR2LSIGqb8AtksV3X49XqyfriBGXI3oaWSIQ/fD8aLyv+bH42kjGD8EJt9n0DH5WQ8zmreXcn3rBwM7G7JtHSnSzEXbZOJ7/rD74Equy+L0fApA2+BLyroS3D06cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952939; c=relaxed/simple;
	bh=wCj9bi4x5lvOnZ8Xre21Vebu8lXYzYQwHsXNevTbhBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OZjHB01VGbP+riDx/U5n8IKCSjn5eMBZg9mga2LNPo0VYIZWcd6X3CWX3q87G8CMWZ5r4bxOyqEknZtItmwVy6waFwpwiAgfWURvxS349q57qqOUN6q+an+MyrDYMNELBodooJAWzyGsH1i6shTzIldAABZjxRL7bKHlZZ53nRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpgydWVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F76CC32781;
	Wed, 24 Apr 2024 10:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713952938;
	bh=wCj9bi4x5lvOnZ8Xre21Vebu8lXYzYQwHsXNevTbhBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hpgydWVv8lhe8sDop0QP6z9HOmEjuhD2UgNEArldbn7czckqLhhXo9gljNMZX9Q3V
	 u2i3ACkDLXtGkPBy/H/+gY6dJjrztpZoaUxjZCoD8L/OtnwKfqqaa3y/85bZhefyL1
	 m+beRKO4LmsvHjvAMUucjtuYjg5WthS35IMSWnqYHHOQcXd0bOVRq9rBrGwwojhdwB
	 +zLEoBy9//gEUP/pkEFCUr3IcO8pizighn91OMH1kF9I8Hzki9bwrGJfKYlVoHuT4M
	 peJxAoULMyRIo4oIlJ19Fq0ZXv1dN6sLxEJr0yji4JdeoS4cdVCNzWt60oPAsH4Vxh
	 TNPUXFhBFH0TA==
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
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ilya Leoshkevich <iii@linux.ibm.com>
Cc: puranjay12@gmail.com
Subject: [PATCH bpf v6 1/3] bpf: verifier: prevent userspace memory access
Date: Wed, 24 Apr 2024 10:02:08 +0000
Message-Id: <20240424100210.11982-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240424100210.11982-1-puranjay@kernel.org>
References: <20240424100210.11982-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Puranjay Mohan <puranjay12@gmail.com>

With BPF_PROBE_MEM, BPF allows de-referencing an untrusted pointer. To
thwart invalid memory accesses, the JITs add an exception table entry
for all such accesses. But in case the src_reg + offset is a userspace
address, the BPF program might read that memory if the user has
mapped it.

Make the verifier add guard instructions around such memory accesses and
skip the load if the address falls into the userspace region.

The JITs need to implement bpf_arch_uaddress_limit() to define where
the userspace addresses end for that architecture or TASK_SIZE is taken
as default.

The implementation is as follows:

REG_AX =  SRC_REG
if(offset)
	REG_AX += offset;
REG_AX >>= 32;
if (REG_AX <= (uaddress_limit >> 32))
	DST_REG = 0;
else
	DST_REG = *(size *)(SRC_REG + offset);

Comparing just the upper 32 bits of the load address with the upper
32 bits of uaddress_limit implies that the values are being aligned down
to a 4GB boundary before comparison.

The above means that all loads with address <= uaddress_limit + 4GB are
skipped. This is acceptable because there is a large hole (much larger
than 4GB) between userspace and kernel space memory, therefore a
correctly functioning BPF program should not access this 4GB memory
above the userspace.

Let's analyze what this patch does to the following fentry program
dereferencing an untrusted pointer:

  SEC("fentry/tcp_v4_connect")
  int BPF_PROG(fentry_tcp_v4_connect, struct sock *sk)
  {
                *(volatile long *)sk;
                return 0;
  }

    BPF Program before              |           BPF Program after
    ------------------              |           -----------------

  0: (79) r1 = *(u64 *)(r1 +0)          0: (79) r1 = *(u64 *)(r1 +0)
  -----------------------------------------------------------------------
  1: (79) r1 = *(u64 *)(r1 +0) --\      1: (bf) r11 = r1
  ----------------------------\   \     2: (77) r11 >>= 32
  2: (b7) r0 = 0               \   \    3: (b5) if r11 <= 0x8000 goto pc+2
  3: (95) exit                  \   \-> 4: (79) r1 = *(u64 *)(r1 +0)
                                 \      5: (05) goto pc+1
                                  \     6: (b7) r1 = 0
                                   \--------------------------------------
                                        7: (b7) r0 = 0
                                        8: (95) exit

As you can see from above, in the best case (off=0), 5 extra instructions
are emitted.

Now, we analyze the same program after it has gone through the JITs of
ARM64 and RISC-V architectures. We follow the single load instruction
that has the untrusted pointer and see what instrumentation has been
added around it.

                                x86-64 JIT
                                ==========
     JIT's Instrumentation
          (upstream)
     ---------------------

   0:   nopl   0x0(%rax,%rax,1)
   5:   xchg   %ax,%ax
   7:   push   %rbp
   8:   mov    %rsp,%rbp
   b:   mov    0x0(%rdi),%rdi
  ---------------------------------
   f:   movabs $0x800000000000,%r11
  19:   cmp    %r11,%rdi
  1c:   jb     0x000000000000002a
  1e:   mov    %rdi,%r11
  21:   add    $0x0,%r11
  28:   jae    0x000000000000002e
  2a:   xor    %edi,%edi
  2c:   jmp    0x0000000000000032
  2e:   mov    0x0(%rdi),%rdi
  ---------------------------------
  32:   xor    %eax,%eax
  34:   leave
  35:   ret

The x86-64 JIT already emits some instructions to protect against user
memory access. This patch doesn't make any changes for the x86-64 JIT.

                                  ARM64 JIT
                                  =========

        No Intrumentation                       Verifier's Instrumentation
           (upstream)                                  (This patch)
        -----------------                       --------------------------

   0:   add     x9, x30, #0x0                0:   add     x9, x30, #0x0
   4:   nop                                  4:   nop
   8:   paciasp                              8:   paciasp
   c:   stp     x29, x30, [sp, #-16]!        c:   stp     x29, x30, [sp, #-16]!
  10:   mov     x29, sp                     10:   mov     x29, sp
  14:   stp     x19, x20, [sp, #-16]!       14:   stp     x19, x20, [sp, #-16]!
  18:   stp     x21, x22, [sp, #-16]!       18:   stp     x21, x22, [sp, #-16]!
  1c:   stp     x25, x26, [sp, #-16]!       1c:   stp     x25, x26, [sp, #-16]!
  20:   stp     x27, x28, [sp, #-16]!       20:   stp     x27, x28, [sp, #-16]!
  24:   mov     x25, sp                     24:   mov     x25, sp
  28:   mov     x26, #0x0                   28:   mov     x26, #0x0
  2c:   sub     x27, x25, #0x0              2c:   sub     x27, x25, #0x0
  30:   sub     sp, sp, #0x0                30:   sub     sp, sp, #0x0
  34:   ldr     x0, [x0]                    34:   ldr     x0, [x0]
--------------------------------------------------------------------------------
  38:   ldr     x0, [x0] ----------\        38:   add     x9, x0, #0x0
-----------------------------------\\       3c:   lsr     x9, x9, #32
  3c:   mov     x7, #0x0            \\      40:   cmp     x9, #0x10, lsl #12
  40:   mov     sp, sp               \\     44:   b.ls    0x0000000000000050
  44:   ldp     x27, x28, [sp], #16   \\--> 48:   ldr     x0, [x0]
  48:   ldp     x25, x26, [sp], #16    \    4c:   b       0x0000000000000054
  4c:   ldp     x21, x22, [sp], #16     \   50:   mov     x0, #0x0
  50:   ldp     x19, x20, [sp], #16      \---------------------------------------
  54:   ldp     x29, x30, [sp], #16         54:   mov     x7, #0x0
  58:   add     x0, x7, #0x0                58:   mov     sp, sp
  5c:   autiasp                             5c:   ldp     x27, x28, [sp], #16
  60:   ret                                 60:   ldp     x25, x26, [sp], #16
  64:   nop                                 64:   ldp     x21, x22, [sp], #16
  68:   ldr     x10, 0x0000000000000070     68:   ldp     x19, x20, [sp], #16
  6c:   br      x10                         6c:   ldp     x29, x30, [sp], #16
                                            70:   add     x0, x7, #0x0
                                            74:   autiasp
                                            78:   ret
                                            7c:   nop
                                            80:   ldr     x10, 0x0000000000000088
                                            84:   br      x10

There are 6 extra instructions added in ARM64 in the best case. This will
become 7 in the worst case (off != 0).

                           RISC-V JIT (RISCV_ISA_C Disabled)
                           ==========

        No Intrumentation           Verifier's Instrumentation
           (upstream)                      (This patch)
        -----------------           --------------------------

   0:   nop                            0:   nop
   4:   nop                            4:   nop
   8:   li      a6, 33                 8:   li      a6, 33
   c:   addi    sp, sp, -16            c:   addi    sp, sp, -16
  10:   sd      s0, 8(sp)             10:   sd      s0, 8(sp)
  14:   addi    s0, sp, 16            14:   addi    s0, sp, 16
  18:   ld      a0, 0(a0)             18:   ld      a0, 0(a0)
---------------------------------------------------------------
  1c:   ld      a0, 0(a0) --\         1c:   mv      t0, a0
--------------------------\  \        20:   srli    t0, t0, 32
  20:   li      a5, 0      \  \       24:   lui     t1, 4096
  24:   ld      s0, 8(sp)   \  \      28:   sext.w  t1, t1
  28:   addi    sp, sp, 16   \  \     2c:   bgeu    t1, t0, 12
  2c:   sext.w  a0, a5        \  \--> 30:   ld      a0, 0(a0)
  30:   ret                    \      34:   j       8
                                \     38:   li      a0, 0
                                 \------------------------------
                                      3c:   li      a5, 0
                                      40:   ld      s0, 8(sp)
                                      44:   addi    sp, sp, 16
                                      48:   sext.w  a0, a5
                                      4c:   ret

There are 7 extra instructions added in RISC-V.

Fixes: 800834285361 ("bpf, arm64: Add BPF exception tables")
Reported-by: Breno Leitao <leitao@debian.org>
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c |  6 ++++++
 include/linux/filter.h      |  1 +
 kernel/bpf/core.c           |  9 +++++++++
 kernel/bpf/verifier.c       | 30 ++++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index df5fac428408..b520b66ad14b 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3473,3 +3473,9 @@ bool bpf_jit_supports_ptr_xchg(void)
 {
 	return true;
 }
+
+/* x86-64 JIT emits its own code to filter user addresses so return 0 here */
+u64 bpf_arch_uaddress_limit(void)
+{
+	return 0;
+}
diff --git a/include/linux/filter.h b/include/linux/filter.h
index c99bc3df2d28..219ee7a76874 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -963,6 +963,7 @@ bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_jit_supports_exceptions(void);
 bool bpf_jit_supports_ptr_xchg(void);
 bool bpf_jit_supports_arena(void);
+u64 bpf_arch_uaddress_limit(void);
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp, u64 bp), void *cookie);
 bool bpf_helper_changes_pkt_data(void *func);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 696bc55de8e8..1ea5ce5bb599 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2942,6 +2942,15 @@ bool __weak bpf_jit_supports_arena(void)
 	return false;
 }
 
+u64 __weak bpf_arch_uaddress_limit(void)
+{
+#if defined(CONFIG_64BIT) && defined(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE)
+	return TASK_SIZE;
+#else
+	return 0;
+#endif
+}
+
 /* Return TRUE if the JIT backend satisfies the following two conditions:
  * 1) JIT backend supports atomic_xchg() on pointer-sized words.
  * 2) Under the specific arch, the implementation of xchg() is the same
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index aa24beb65393..cb7ad1f795e1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19675,6 +19675,36 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			goto next_insn;
 		}
 
+		/* Make it impossible to de-reference a userspace address */
+		if (BPF_CLASS(insn->code) == BPF_LDX &&
+		    (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
+		     BPF_MODE(insn->code) == BPF_PROBE_MEMSX)) {
+			struct bpf_insn *patch = &insn_buf[0];
+			u64 uaddress_limit = bpf_arch_uaddress_limit();
+
+			if (!uaddress_limit)
+				goto next_insn;
+
+			*patch++ = BPF_MOV64_REG(BPF_REG_AX, insn->src_reg);
+			if (insn->off)
+				*patch++ = BPF_ALU64_IMM(BPF_ADD, BPF_REG_AX, insn->off);
+			*patch++ = BPF_ALU64_IMM(BPF_RSH, BPF_REG_AX, 32);
+			*patch++ = BPF_JMP_IMM(BPF_JLE, BPF_REG_AX, uaddress_limit >> 32, 2);
+			*patch++ = *insn;
+			*patch++ = BPF_JMP_IMM(BPF_JA, 0, 0, 1);
+			*patch++ = BPF_MOV64_IMM(insn->dst_reg, 0);
+
+			cnt = patch - insn_buf;
+			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+
+			delta    += cnt - 1;
+			env->prog = prog = new_prog;
+			insn      = new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
+
 		/* Implement LD_ABS and LD_IND with a rewrite, if supported by the program type. */
 		if (BPF_CLASS(insn->code) == BPF_LD &&
 		    (BPF_MODE(insn->code) == BPF_ABS ||
-- 
2.40.1


