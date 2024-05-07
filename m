Return-Path: <bpf+bounces-28985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFFE8BF1F8
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 01:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4931F22FBA
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 23:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CE514B07B;
	Tue,  7 May 2024 23:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFsQpB3o"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B689E14A62B;
	Tue,  7 May 2024 23:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123467; cv=none; b=U6Oj9yJ42YhhbCynWTUmxAMSqyrx/Q/trEpntrAt+FWn7gurFHuUQcpcRglBSTlhRYnSyf0P709rT8aGlBAddr57Bgpp9ReLOKfOn7SBaEaSISS6BBLc9UqgOm4tF9sW8aesphmxAKvVL0fie77qRpDfCAENEJNjrE1edSYUBPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123467; c=relaxed/simple;
	bh=HBbYdmqNu6JQgsjT0XOmDvVnB7HKVTMbvQQlcp3ho6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlLwBm/Of3yx1LoveQfKlhwQHLttf3gzhrhVvybZohJ1FZt1c4PKhv6XUeY5z6hXLy4x9Yp3Giev+BZjgxtR3kn8B7VatnGAqlUICR7c8FPZ7bB7+XIyyOWEoReZelPj5/yV3CZ+EsxKcrYP4n1W7akIpW7Xhks0juPJ4YKe9Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFsQpB3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7E6C4AF67;
	Tue,  7 May 2024 23:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123467;
	bh=HBbYdmqNu6JQgsjT0XOmDvVnB7HKVTMbvQQlcp3ho6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XFsQpB3oBTyYHGnDLndrxBSMz0GmE1ugQNTryW/YPqquwNE06f9Yqf7HRCCTHS3Yj
	 KASqJcOe8E3z+EjahgdDqWy7AZ+Xf3EF/M6wJ9GUhICoGRKZLhd3joR5glofGd1xe9
	 wmtgkda4cEpPw96i/wK+/E34/qKYQR2OEHs0ilXkZ9BS8KxiXcQD07u2LvUgCWZtKX
	 wrLbQSP7p3D3egbGLwEfHqQiVlHheyy09UAA923Ii9KyL+yK8Z6Qgq+sBFlK0aplwR
	 4MWZVkxcG6341/zyPCSx7vEYmTy9b45cAmjryBxAyy68eW8jVMtm0VLFCsfM6oLUcs
	 BBbJ1xTtG6++g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	dsahern@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 18/43] bpf, x86: Fix PROBE_MEM runtime load check
Date: Tue,  7 May 2024 19:09:39 -0400
Message-ID: <20240507231033.393285-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit

From: Puranjay Mohan <puranjay@kernel.org>

[ Upstream commit b599d7d26d6ad1fc9975218574bc2ca6d0293cfd ]

When a load is marked PROBE_MEM - e.g. due to PTR_UNTRUSTED access - the
address being loaded from is not necessarily valid. The BPF jit sets up
exception handlers for each such load which catch page faults and 0 out
the destination register.

If the address for the load is outside kernel address space, the load
will escape the exception handling and crash the kernel. To prevent this
from happening, the emits some instruction to verify that addr is > end
of userspace addresses.

x86 has a legacy vsyscall ABI where a page at address 0xffffffffff600000
is mapped with user accessible permissions. The addresses in this page
are considered userspace addresses by the fault handler. Therefore, a
BPF program accessing this page will crash the kernel.

This patch fixes the runtime checks to also check that the PROBE_MEM
address is below VSYSCALL_ADDR.

Example BPF program:

 SEC("fentry/tcp_v4_connect")
 int BPF_PROG(fentry_tcp_v4_connect, struct sock *sk)
 {
	*(volatile unsigned long *)&sk->sk_tsq_flags;
	return 0;
 }

BPF Assembly:

 0: (79) r1 = *(u64 *)(r1 +0)
 1: (79) r1 = *(u64 *)(r1 +344)
 2: (b7) r0 = 0
 3: (95) exit

			       x86-64 JIT
			       ==========

            BEFORE                                    AFTER
	    ------                                    -----

 0:   nopl   0x0(%rax,%rax,1)             0:   nopl   0x0(%rax,%rax,1)
 5:   xchg   %ax,%ax                      5:   xchg   %ax,%ax
 7:   push   %rbp                         7:   push   %rbp
 8:   mov    %rsp,%rbp                    8:   mov    %rsp,%rbp
 b:   mov    0x0(%rdi),%rdi               b:   mov    0x0(%rdi),%rdi
-------------------------------------------------------------------------------
 f:   movabs $0x100000000000000,%r11      f:   movabs $0xffffffffff600000,%r10
19:   add    $0x2a0,%rdi                 19:   mov    %rdi,%r11
20:   cmp    %r11,%rdi                   1c:   add    $0x2a0,%r11
23:   jae    0x0000000000000029          23:   sub    %r10,%r11
25:   xor    %edi,%edi                   26:   movabs $0x100000000a00000,%r10
27:   jmp    0x000000000000002d          30:   cmp    %r10,%r11
29:   mov    0x0(%rdi),%rdi              33:   ja     0x0000000000000039
--------------------------------\        35:   xor    %edi,%edi
2d:   xor    %eax,%eax           \       37:   jmp    0x0000000000000040
2f:   leave                       \      39:   mov    0x2a0(%rdi),%rdi
30:   ret                          \--------------------------------------------
                                         40:   xor    %eax,%eax
                                         42:   leave
                                         43:   ret

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Link: https://lore.kernel.org/r/20240424100210.11982-3-puranjay@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 57 ++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 32 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a6a4d3ca8ddc6..878a4c6dd7565 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1458,36 +1458,41 @@ st:			if (is_imm8(insn->off))
 			if (BPF_MODE(insn->code) == BPF_PROBE_MEM ||
 			    BPF_MODE(insn->code) == BPF_PROBE_MEMSX) {
 				/* Conservatively check that src_reg + insn->off is a kernel address:
-				 *   src_reg + insn->off >= TASK_SIZE_MAX + PAGE_SIZE
-				 * src_reg is used as scratch for src_reg += insn->off and restored
-				 * after emit_ldx if necessary
+				 *   src_reg + insn->off > TASK_SIZE_MAX + PAGE_SIZE
+				 *   and
+				 *   src_reg + insn->off < VSYSCALL_ADDR
 				 */
 
-				u64 limit = TASK_SIZE_MAX + PAGE_SIZE;
+				u64 limit = TASK_SIZE_MAX + PAGE_SIZE - VSYSCALL_ADDR;
 				u8 *end_of_jmp;
 
-				/* At end of these emitted checks, insn->off will have been added
-				 * to src_reg, so no need to do relative load with insn->off offset
-				 */
-				insn_off = 0;
+				/* movabsq r10, VSYSCALL_ADDR */
+				emit_mov_imm64(&prog, BPF_REG_AX, (long)VSYSCALL_ADDR >> 32,
+					       (u32)(long)VSYSCALL_ADDR);
 
-				/* movabsq r11, limit */
-				EMIT2(add_1mod(0x48, AUX_REG), add_1reg(0xB8, AUX_REG));
-				EMIT((u32)limit, 4);
-				EMIT(limit >> 32, 4);
+				/* mov src_reg, r11 */
+				EMIT_mov(AUX_REG, src_reg);
 
 				if (insn->off) {
-					/* add src_reg, insn->off */
-					maybe_emit_1mod(&prog, src_reg, true);
-					EMIT2_off32(0x81, add_1reg(0xC0, src_reg), insn->off);
+					/* add r11, insn->off */
+					maybe_emit_1mod(&prog, AUX_REG, true);
+					EMIT2_off32(0x81, add_1reg(0xC0, AUX_REG), insn->off);
 				}
 
-				/* cmp src_reg, r11 */
-				maybe_emit_mod(&prog, src_reg, AUX_REG, true);
-				EMIT2(0x39, add_2reg(0xC0, src_reg, AUX_REG));
+				/* sub r11, r10 */
+				maybe_emit_mod(&prog, AUX_REG, BPF_REG_AX, true);
+				EMIT2(0x29, add_2reg(0xC0, AUX_REG, BPF_REG_AX));
+
+				/* movabsq r10, limit */
+				emit_mov_imm64(&prog, BPF_REG_AX, (long)limit >> 32,
+					       (u32)(long)limit);
+
+				/* cmp r10, r11 */
+				maybe_emit_mod(&prog, AUX_REG, BPF_REG_AX, true);
+				EMIT2(0x39, add_2reg(0xC0, AUX_REG, BPF_REG_AX));
 
-				/* if unsigned '>=', goto load */
-				EMIT2(X86_JAE, 0);
+				/* if unsigned '>', goto load */
+				EMIT2(X86_JA, 0);
 				end_of_jmp = prog;
 
 				/* xor dst_reg, dst_reg */
@@ -1513,18 +1518,6 @@ st:			if (is_imm8(insn->off))
 				/* populate jmp_offset for JMP above */
 				start_of_ldx[-1] = prog - start_of_ldx;
 
-				if (insn->off && src_reg != dst_reg) {
-					/* sub src_reg, insn->off
-					 * Restore src_reg after "add src_reg, insn->off" in prev
-					 * if statement. But if src_reg == dst_reg, emit_ldx
-					 * above already clobbered src_reg, so no need to restore.
-					 * If add src_reg, insn->off was unnecessary, no need to
-					 * restore either.
-					 */
-					maybe_emit_1mod(&prog, src_reg, true);
-					EMIT2_off32(0x81, add_1reg(0xE8, src_reg), insn->off);
-				}
-
 				if (!bpf_prog->aux->extable)
 					break;
 
-- 
2.43.0


