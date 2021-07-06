Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859D33BD05F
	for <lists+bpf@lfdr.de>; Tue,  6 Jul 2021 13:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbhGFLdn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Jul 2021 07:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235090AbhGFL3g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Jul 2021 07:29:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92F7761DA3;
        Tue,  6 Jul 2021 11:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625570437;
        bh=a11l12DkHhfmTwRp4mIdWPRiSklf5QKwYxYCoxUY4QU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n4DAAQkU5aEFy0026z9E6KMKwEmEGTJorByQ7yGFPcLIWyeGKuMl5N4s6A3ivO3Jn
         QCgHnsUWrRULKrya0WDQgaGlcI5FK3aT+Zhbw8dq2oOyH8TG9h/iPJza6WZpYi6c9G
         t39FJaiqsH40uDiUkzWpt/S9NoQzvvIiFt0YPy0AyYAoua4aUbC3QYQ7nQhCzryC+h
         894jjtVfI++33SqXXI0edGrgtlIE8LElyt2stZG1kQNxLjbOSfFYuJzw39MycqNf77
         xsuNoooGKNjbvhil0pZYYZv7u6tCmbVijESy4wQn81aGlPShEpD6H50FUy44NbY5AW
         JyEv9svaZcWrA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        syzbot+bed360704c521841c85d@syzkaller.appspotmail.com,
        Kurt Manucredo <fuzzybritches0@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 098/160] bpf: Fix up register-based shifts in interpreter to silence KUBSAN
Date:   Tue,  6 Jul 2021 07:17:24 -0400
Message-Id: <20210706111827.2060499-98-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706111827.2060499-1-sashal@kernel.org>
References: <20210706111827.2060499-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 28131e9d933339a92f78e7ab6429f4aaaa07061c ]

syzbot reported a shift-out-of-bounds that KUBSAN observed in the
interpreter:

  [...]
  UBSAN: shift-out-of-bounds in kernel/bpf/core.c:1420:2
  shift exponent 255 is too large for 64-bit type 'long long unsigned int'
  CPU: 1 PID: 11097 Comm: syz-executor.4 Not tainted 5.12.0-rc2-syzkaller #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
  Call Trace:
   __dump_stack lib/dump_stack.c:79 [inline]
   dump_stack+0x141/0x1d7 lib/dump_stack.c:120
   ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
   __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:327
   ___bpf_prog_run.cold+0x19/0x56c kernel/bpf/core.c:1420
   __bpf_prog_run32+0x8f/0xd0 kernel/bpf/core.c:1735
   bpf_dispatcher_nop_func include/linux/bpf.h:644 [inline]
   bpf_prog_run_pin_on_cpu include/linux/filter.h:624 [inline]
   bpf_prog_run_clear_cb include/linux/filter.h:755 [inline]
   run_filter+0x1a1/0x470 net/packet/af_packet.c:2031
   packet_rcv+0x313/0x13e0 net/packet/af_packet.c:2104
   dev_queue_xmit_nit+0x7c2/0xa90 net/core/dev.c:2387
   xmit_one net/core/dev.c:3588 [inline]
   dev_hard_start_xmit+0xad/0x920 net/core/dev.c:3609
   __dev_queue_xmit+0x2121/0x2e00 net/core/dev.c:4182
   __bpf_tx_skb net/core/filter.c:2116 [inline]
   __bpf_redirect_no_mac net/core/filter.c:2141 [inline]
   __bpf_redirect+0x548/0xc80 net/core/filter.c:2164
   ____bpf_clone_redirect net/core/filter.c:2448 [inline]
   bpf_clone_redirect+0x2ae/0x420 net/core/filter.c:2420
   ___bpf_prog_run+0x34e1/0x77d0 kernel/bpf/core.c:1523
   __bpf_prog_run512+0x99/0xe0 kernel/bpf/core.c:1737
   bpf_dispatcher_nop_func include/linux/bpf.h:644 [inline]
   bpf_test_run+0x3ed/0xc50 net/bpf/test_run.c:50
   bpf_prog_test_run_skb+0xabc/0x1c50 net/bpf/test_run.c:582
   bpf_prog_test_run kernel/bpf/syscall.c:3127 [inline]
   __do_sys_bpf+0x1ea9/0x4f00 kernel/bpf/syscall.c:4406
   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
   entry_SYSCALL_64_after_hwframe+0x44/0xae
  [...]

Generally speaking, KUBSAN reports from the kernel should be fixed.
However, in case of BPF, this particular report caused concerns since
the large shift is not wrong from BPF point of view, just undefined.
In the verifier, K-based shifts that are >= {64,32} (depending on the
bitwidth of the instruction) are already rejected. The register-based
cases were not given their content might not be known at verification
time. Ideas such as verifier instruction rewrite with an additional
AND instruction for the source register were brought up, but regularly
rejected due to the additional runtime overhead they incur.

As Edward Cree rightly put it:

  Shifts by more than insn bitness are legal in the BPF ISA; they are
  implementation-defined behaviour [of the underlying architecture],
  rather than UB, and have been made legal for performance reasons.
  Each of the JIT backends compiles the BPF shift operations to machine
  instructions which produce implementation-defined results in such a
  case; the resulting contents of the register may be arbitrary but
  program behaviour as a whole remains defined.

  Guard checks in the fast path (i.e. affecting JITted code) will thus
  not be accepted.

  The case of division by zero is not truly analogous here, as division
  instructions on many of the JIT-targeted architectures will raise a
  machine exception / fault on division by zero, whereas (to the best
  of my knowledge) none will do so on an out-of-bounds shift.

Given the KUBSAN report only affects the BPF interpreter, but not JITs,
one solution is to add the ANDs with 63 or 31 into ___bpf_prog_run().
That would make the shifts defined, and thus shuts up KUBSAN, and the
compiler would optimize out the AND on any CPU that interprets the shift
amounts modulo the width anyway (e.g., confirmed from disassembly that
on x86-64 and arm64 the generated interpreter code is the same before
and after this fix).

The BPF interpreter is slow path, and most likely compiled out anyway
as distros select BPF_JIT_ALWAYS_ON to avoid speculative execution of
BPF instructions by the interpreter. Given the main argument was to
avoid sacrificing performance, the fact that the AND is optimized away
from compiler for mainstream archs helps as well as a solution moving
forward. Also add a comment on LSH/RSH/ARSH translation for JIT authors
to provide guidance when they see the ___bpf_prog_run() interpreter
code and use it as a model for a new JIT backend.

Reported-by: syzbot+bed360704c521841c85d@syzkaller.appspotmail.com
Reported-by: Kurt Manucredo <fuzzybritches0@gmail.com>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Co-developed-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Tested-by: syzbot+bed360704c521841c85d@syzkaller.appspotmail.com
Cc: Edward Cree <ecree.xilinx@gmail.com>
Link: https://lore.kernel.org/bpf/0000000000008f912605bd30d5d7@google.com
Link: https://lore.kernel.org/bpf/bac16d8d-c174-bdc4-91bd-bfa62b410190@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/core.c | 61 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 75244ecb2389..952d98beda63 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1399,29 +1399,54 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 select_insn:
 	goto *jumptable[insn->code];
 
-	/* ALU */
-#define ALU(OPCODE, OP)			\
-	ALU64_##OPCODE##_X:		\
-		DST = DST OP SRC;	\
-		CONT;			\
-	ALU_##OPCODE##_X:		\
-		DST = (u32) DST OP (u32) SRC;	\
-		CONT;			\
-	ALU64_##OPCODE##_K:		\
-		DST = DST OP IMM;		\
-		CONT;			\
-	ALU_##OPCODE##_K:		\
-		DST = (u32) DST OP (u32) IMM;	\
+	/* Explicitly mask the register-based shift amounts with 63 or 31
+	 * to avoid undefined behavior. Normally this won't affect the
+	 * generated code, for example, in case of native 64 bit archs such
+	 * as x86-64 or arm64, the compiler is optimizing the AND away for
+	 * the interpreter. In case of JITs, each of the JIT backends compiles
+	 * the BPF shift operations to machine instructions which produce
+	 * implementation-defined results in such a case; the resulting
+	 * contents of the register may be arbitrary, but program behaviour
+	 * as a whole remains defined. In other words, in case of JIT backends,
+	 * the AND must /not/ be added to the emitted LSH/RSH/ARSH translation.
+	 */
+	/* ALU (shifts) */
+#define SHT(OPCODE, OP)					\
+	ALU64_##OPCODE##_X:				\
+		DST = DST OP (SRC & 63);		\
+		CONT;					\
+	ALU_##OPCODE##_X:				\
+		DST = (u32) DST OP ((u32) SRC & 31);	\
+		CONT;					\
+	ALU64_##OPCODE##_K:				\
+		DST = DST OP IMM;			\
+		CONT;					\
+	ALU_##OPCODE##_K:				\
+		DST = (u32) DST OP (u32) IMM;		\
+		CONT;
+	/* ALU (rest) */
+#define ALU(OPCODE, OP)					\
+	ALU64_##OPCODE##_X:				\
+		DST = DST OP SRC;			\
+		CONT;					\
+	ALU_##OPCODE##_X:				\
+		DST = (u32) DST OP (u32) SRC;		\
+		CONT;					\
+	ALU64_##OPCODE##_K:				\
+		DST = DST OP IMM;			\
+		CONT;					\
+	ALU_##OPCODE##_K:				\
+		DST = (u32) DST OP (u32) IMM;		\
 		CONT;
-
 	ALU(ADD,  +)
 	ALU(SUB,  -)
 	ALU(AND,  &)
 	ALU(OR,   |)
-	ALU(LSH, <<)
-	ALU(RSH, >>)
 	ALU(XOR,  ^)
 	ALU(MUL,  *)
+	SHT(LSH, <<)
+	SHT(RSH, >>)
+#undef SHT
 #undef ALU
 	ALU_NEG:
 		DST = (u32) -DST;
@@ -1446,13 +1471,13 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 		insn++;
 		CONT;
 	ALU_ARSH_X:
-		DST = (u64) (u32) (((s32) DST) >> SRC);
+		DST = (u64) (u32) (((s32) DST) >> (SRC & 31));
 		CONT;
 	ALU_ARSH_K:
 		DST = (u64) (u32) (((s32) DST) >> IMM);
 		CONT;
 	ALU64_ARSH_X:
-		(*(s64 *) &DST) >>= SRC;
+		(*(s64 *) &DST) >>= (SRC & 63);
 		CONT;
 	ALU64_ARSH_K:
 		(*(s64 *) &DST) >>= IMM;
-- 
2.30.2

