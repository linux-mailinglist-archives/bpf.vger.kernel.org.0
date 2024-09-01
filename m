Return-Path: <bpf+bounces-38682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAF09676C9
	for <lists+bpf@lfdr.de>; Sun,  1 Sep 2024 15:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46C27B20E6C
	for <lists+bpf@lfdr.de>; Sun,  1 Sep 2024 13:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545E317E00F;
	Sun,  1 Sep 2024 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bw/TqWKk"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CFA143880
	for <bpf@vger.kernel.org>; Sun,  1 Sep 2024 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725198069; cv=none; b=GHXZlT+MLhT8jOic3Sg6cjRA0xmsA30NQ5FKobLdQ5ItLNoIFwjVt52bo2cRJl/kFWoG7T6IyUlegMmaalDDIDP1zPeKuUZD2d3tq3co6AKSOf1TLRP4AhFHYRlw+VcDbtJnWpHkcZOXq3hkCgnGbhd7FXzXsypPdsev32ZuuzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725198069; c=relaxed/simple;
	bh=ANyPNj9nDVgRBY78OaPZekGNmr78hQPSczgo96lUxqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jB/eAUyPPH/xLQxaaHTZw8JmXJyl9EH6fD3UHb7/sTRXOe3aZIxgzxckNTROzwhWTnYhjO0NznjBU1qdeMR5UA7s6VIX79pxuJ32D9eHSi0y1btAgALR0XKP5qJFYE0BrSa91VulXe7Hgvl8fMIhKd5IW1mToqWMlGFHoRaYbnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bw/TqWKk; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725198062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8HCqzwOX+eH0kqWdRTP/yCjOIus8cQ72D7HFP04MvtA=;
	b=bw/TqWKkg2e/XcKO3lIZnsOsIM7buVIfxjiki8t9LQw2qBB0vnvGBgUOfUHSgVZOwXL1Zd
	kKVs6yOqPI3OeMNemSkYv3jJdUIB0zHOAUuaOh5eehlH5+Usm75nW0/oq9bR4Rzogkylcp
	uaHnMQgk+vK+bRDGr625PIAM+GaAzEU=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	toke@redhat.com,
	martin.lau@kernel.org,
	yonghong.song@linux.dev,
	puranjay@kernel.org,
	xukuohai@huaweicloud.com,
	eddyz87@gmail.com,
	iii@linux.ibm.com,
	leon.hwang@linux.dev,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 1/4] bpf, x64: Fix tailcall infinite loop caused by freplace
Date: Sun,  1 Sep 2024 21:38:53 +0800
Message-ID: <20240901133856.64367-2-leon.hwang@linux.dev>
In-Reply-To: <20240901133856.64367-1-leon.hwang@linux.dev>
References: <20240901133856.64367-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch fixes a tailcall infinite loop issue caused by freplace.

Since commit 1c123c567fb1 ("bpf: Resolve fext program type when checking map compatibility"),
freplace prog is allowed to tail call its target prog. Then, when a
freplace prog attaches to its target prog's subprog and tail calls its
target prog, kernel will panic.

For example:

tc_bpf2bpf.c:

// SPDX-License-Identifier: GPL-2.0
\#include <linux/bpf.h>
\#include <bpf/bpf_helpers.h>

__noinline
int subprog_tc(struct __sk_buff *skb)
{
	return skb->len * 2;
}

SEC("tc")
int entry_tc(struct __sk_buff *skb)
{
	return subprog_tc(skb);
}

char __license[] SEC("license") = "GPL";

tailcall_bpf2bpf_hierarchy_freplace.c:

// SPDX-License-Identifier: GPL-2.0
\#include <linux/bpf.h>
\#include <bpf/bpf_helpers.h>

struct {
	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
	__uint(max_entries, 1);
	__uint(key_size, sizeof(__u32));
	__uint(value_size, sizeof(__u32));
} jmp_table SEC(".maps");

int count = 0;

static __noinline
int subprog_tail(struct __sk_buff *skb)
{
	bpf_tail_call_static(skb, &jmp_table, 0);
	return 0;
}

SEC("freplace")
int entry_freplace(struct __sk_buff *skb)
{
	count++;
	subprog_tail(skb);
	subprog_tail(skb);
	return count;
}

char __license[] SEC("license") = "GPL";

The attach target of entry_freplace is subprog_tc, and the tail callee
in subprog_tail is entry_tc.

Then, the infinite loop will be entry_tc -> subprog_tc -> entry_freplace
-> subprog_tail --tailcall-> entry_tc, because tail_call_cnt in
entry_freplace will count from zero for every time of entry_freplace
execution. Kernel will panic:

[   15.310490] BUG: TASK stack guard page was hit at (____ptrval____)
(stack is (____ptrval____)..(____ptrval____))
[   15.310490] Oops: stack guard page: 0000 [#1] PREEMPT SMP NOPTI
[   15.310490] CPU: 1 PID: 89 Comm: test_progs Tainted: G           OE
   6.10.0-rc6-g026dcdae8d3e-dirty #72
[   15.310490] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX,
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   15.310490] RIP: 0010:bpf_prog_3a140cef239a4b4f_subprog_tail+0x14/0x53
[   15.310490] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
cc cc cc cc cc f3 0f 1e fa 0f 1f 44 00 00 0f 1f 00 55 48 89 e5 f3 0f 1e
fa <50> 50 53 41 55 48 89 fb 49 bd 00 2a 46 82 98 9c ff ff 48 89 df 4c
[   15.310490] RSP: 0018:ffffb500c0aa0000 EFLAGS: 00000202
[   15.310490] RAX: ffffb500c0aa0028 RBX: ffff9c98808b7e00 RCX:
0000000000008cb5
[   15.310490] RDX: 0000000000000000 RSI: ffff9c9882462a00 RDI:
ffff9c98808b7e00
[   15.310490] RBP: ffffb500c0aa0000 R08: 0000000000000000 R09:
0000000000000000
[   15.310490] R10: 0000000000000001 R11: 0000000000000000 R12:
ffffb500c01af000
[   15.310490] R13: ffffb500c01cd000 R14: 0000000000000000 R15:
0000000000000000
[   15.310490] FS:  00007f133b665140(0000) GS:ffff9c98bbd00000(0000)
knlGS:0000000000000000
[   15.310490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.310490] CR2: ffffb500c0a9fff8 CR3: 0000000102478000 CR4:
00000000000006f0
[   15.310490] Call Trace:
[   15.310490]  <#DF>
[   15.310490]  ? die+0x36/0x90
[   15.310490]  ? handle_stack_overflow+0x4d/0x60
[   15.310490]  ? exc_double_fault+0x117/0x1a0
[   15.310490]  ? asm_exc_double_fault+0x23/0x30
[   15.310490]  ? bpf_prog_3a140cef239a4b4f_subprog_tail+0x14/0x53
[   15.310490]  </#DF>
[   15.310490]  <TASK>
[   15.310490]  bpf_prog_85781a698094722f_entry+0x4c/0x64
[   15.310490]  bpf_prog_1c515f389a9059b4_entry2+0x19/0x1b
[   15.310490]  ...
[   15.310490]  bpf_prog_85781a698094722f_entry+0x4c/0x64
[   15.310490]  bpf_prog_1c515f389a9059b4_entry2+0x19/0x1b
[   15.310490]  bpf_test_run+0x210/0x370
[   15.310490]  ? bpf_test_run+0x128/0x370
[   15.310490]  bpf_prog_test_run_skb+0x388/0x7a0
[   15.310490]  __sys_bpf+0xdbf/0x2c40
[   15.310490]  ? clockevents_program_event+0x52/0xf0
[   15.310490]  ? lock_release+0xbf/0x290
[   15.310490]  __x64_sys_bpf+0x1e/0x30
[   15.310490]  do_syscall_64+0x68/0x140
[   15.310490]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   15.310490] RIP: 0033:0x7f133b52725d
[   15.310490] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b bb 0d 00 f7 d8 64 89 01 48
[   15.310490] RSP: 002b:00007ffddbc10258 EFLAGS: 00000206 ORIG_RAX:
0000000000000141
[   15.310490] RAX: ffffffffffffffda RBX: 00007ffddbc10828 RCX:
00007f133b52725d
[   15.310490] RDX: 0000000000000050 RSI: 00007ffddbc102a0 RDI:
000000000000000a
[   15.310490] RBP: 00007ffddbc10270 R08: 0000000000000000 R09:
00007ffddbc102a0
[   15.310490] R10: 0000000000000064 R11: 0000000000000206 R12:
0000000000000004
[   15.310490] R13: 0000000000000000 R14: 0000558ec4c24890 R15:
00007f133b6ed000
[   15.310490]  </TASK>
[   15.310490] Modules linked in: bpf_testmod(OE)
[   15.310490] ---[ end trace 0000000000000000 ]---
[   15.310490] RIP: 0010:bpf_prog_3a140cef239a4b4f_subprog_tail+0x14/0x53
[   15.310490] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
cc cc cc cc cc f3 0f 1e fa 0f 1f 44 00 00 0f 1f 00 55 48 89 e5 f3 0f 1e
fa <50> 50 53 41 55 48 89 fb 49 bd 00 2a 46 82 98 9c ff ff 48 89 df 4c
[   15.310490] RSP: 0018:ffffb500c0aa0000 EFLAGS: 00000202
[   15.310490] RAX: ffffb500c0aa0028 RBX: ffff9c98808b7e00 RCX:
0000000000008cb5
[   15.310490] RDX: 0000000000000000 RSI: ffff9c9882462a00 RDI:
ffff9c98808b7e00
[   15.310490] RBP: ffffb500c0aa0000 R08: 0000000000000000 R09:
0000000000000000
[   15.310490] R10: 0000000000000001 R11: 0000000000000000 R12:
ffffb500c01af000
[   15.310490] R13: ffffb500c01cd000 R14: 0000000000000000 R15:
0000000000000000
[   15.310490] FS:  00007f133b665140(0000) GS:ffff9c98bbd00000(0000)
knlGS:0000000000000000
[   15.310490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.310490] CR2: ffffb500c0a9fff8 CR3: 0000000102478000 CR4:
00000000000006f0
[   15.310490] Kernel panic - not syncing: Fatal exception in interrupt
[   15.310490] Kernel Offset: 0x30000000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)

This patch fixes the issue by initializing tail_call_cnt at the prologue
of entry_tc.

Next, when call subprog_tc, the tail_call_cnt_ptr is propagated to
subprog_tc by rax.
Next, when jump to entry_freplace, the tail_call_cnt_ptr will be reused to
count tailcall in freplace prog.
Next, when call subprog_tail, the tail_call_cnt_ptr is propagated to
subprog_tail by rax.
Next, while tail calling to entry_tc, the tail_call_cnt on the stack of
entry_tc increments via the tail_call_cnt_ptr.

The whole procedure shows as the following JITed prog dumping.

bpftool p d j n entry_tc:

int entry_tc(struct __sk_buff * skb):
bpf_prog_1c515f389a9059b4_entry_tc:
; return subprog_tc(skb);
   0:	endbr64
   4:	xorq	%rax, %rax		;; rax = 0 (tail_call_cnt)
   7:	nopl	(%rax,%rax)
   c:	pushq	%rbp
   d:	movq	%rsp, %rbp
  10:	endbr64
  14:	cmpq	$33, %rax		;; if rax > 33, rax = tcc_ptr
  18:	ja	0x20			;; if rax > 33 goto 0x20 ---+
  1a:	pushq	%rax			;; [rbp - 8] = rax = 0      |
  1b:	movq	%rsp, %rax		;; rax = rbp - 8            |
  1e:	jmp	0x21			;; ---------+               |
  20:	pushq	%rax			;; <--------|---------------+
  21:	pushq	%rax			;; <--------+ [rbp - 16] = rax
  22:	movq	-16(%rbp), %rax		;; rax = tcc_ptr
  29:	callq	0x70			;; call subprog_tc()
; return subprog_tc(skb);
  2e:	leave
  2f:	retq

int subprog_tc(struct __sk_buff * skb):
bpf_prog_1e8f76e2374a0607_subprog_tc:
; return skb->len * 2;
   0:	endbr64
   4:	nopl	(%rax)			;; do not touch tail_call_cnt
   7:	jmp	0x108			;; jump to entry_freplace()
   c:	pushq	%rbp
   d:	movq	%rsp, %rbp
  10:	endbr64
  14:	pushq	%rax
  15:	pushq	%rax
  16:	movl	112(%rdi), %eax
; return skb->len * 2;
  19:	shll	%eax
; return skb->len * 2;
  1b:	leave
  1c:	retq

bpftool p d j n entry_freplace:

int entry_freplace(struct __sk_buff * skb):
bpf_prog_85781a698094722f_entry_freplace:
; int entry_freplace(struct __sk_buff *skb)
   0:	endbr64
   4:	nopl	(%rax)			;; do not touch tail_call_cnt
   7:	nopl	(%rax,%rax)
   c:	pushq	%rbp
   d:	movq	%rsp, %rbp
  10:	endbr64
  14:	cmpq	$33, %rax		;; if rax > 33, rax = tcc_ptr
  18:	ja	0x20			;; if rax > 33 goto 0x20 ---+
  1a:	pushq	%rax			;; [rbp - 8] = rax = 0      |
  1b:	movq	%rsp, %rax		;; rax = rbp - 8            |
  1e:	jmp	0x21			;; ---------+               |
  20:	pushq	%rax			;; <--------|---------------+
  21:	pushq	%rax			;; <--------+ [rbp - 16] = rax
  22:	pushq	%rbx			;; callee saved
  23:	pushq	%r13			;; callee saved
  25:	movq	%rdi, %rbx		;; rbx = skb (callee saved)
; count++;
  28:	movabsq	$-123406219759616, %r13
  32:	movl	(%r13), %edi
  36:	addl	$1, %edi
  39:	movl	%edi, (%r13)
; subprog_tail(skb);
  3d:	movq	%rbx, %rdi		;; rdi = skb
  40:	movq	-16(%rbp), %rax		;; rax = tcc_ptr
  47:	callq	0x80			;; call subprog_tail()
; subprog_tail(skb);
  4c:	movq	%rbx, %rdi		;; rdi = skb
  4f:	movq	-16(%rbp), %rax		;; rax = tcc_ptr
  56:	callq	0x80			;; call subprog_tail()
; return count;
  5b:	movl	(%r13), %eax
; return count;
  5f:	popq	%r13
  61:	popq	%rbx
  62:	leave
  63:	retq

int subprog_tail(struct __sk_buff * skb):
bpf_prog_3a140cef239a4b4f_subprog_tail:
; int subprog_tail(struct __sk_buff *skb)
   0:	endbr64
   4:	nopl	(%rax)			;; do not touch tail_call_cnt
   7:	nopl	(%rax,%rax)
   c:	pushq	%rbp
   d:	movq	%rsp, %rbp
  10:	endbr64
  14:	pushq	%rax			;; [rbp - 8]  = rax (tcc_ptr)
  15:	pushq	%rax			;; [rbp - 16] = rax (tcc_ptr)
  16:	pushq	%rbx			;; callee saved
  17:	pushq	%r13			;; callee saved
  19:	movq	%rdi, %rbx		;; rbx = skb
; asm volatile("r1 = %[ctx]\n\t"
  1c:	movabsq	$-128494642337280, %r13	;; r13 = jmp_table
  26:	movq	%rbx, %rdi		;; 1st arg, skb
  29:	movq	%r13, %rsi		;; 2nd arg, jmp_table
  2c:	xorl	%edx, %edx		;; 3rd arg, index = 0
  2e:	movq	-16(%rbp), %rax		;; rax = [rbp - 16] (tcc_ptr)
  35:	cmpq	$33, (%rax)
  39:	jae	0x4e			;; if *tcc_ptr >= 33 goto 0x4e --------+
  3b:	nopl	(%rax,%rax)		;; jmp bypass, toggled by poking       |
  40:	addq	$1, (%rax)		;; (*tcc_ptr)++                        |
  44:	popq	%r13			;; callee saved                        |
  46:	popq	%rbx			;; callee saved                        |
  47:	popq	%rax			;; undo rbp-16 push                    |
  48:	popq	%rax			;; undo rbp-8  push                    |
  49:	jmp	0xfffffffffffffe18	;; tail call target, toggled by poking |
; return 0;				;;                                     |
  4e:	popq	%r13			;; restore callee saved <--------------+
  50:	popq	%rbx			;; restore callee saved
  51:	leave
  52:	retq

As a result, the tail_call_cnt is stored on the stack of entry_tc. And
the tail_call_cnt_ptr is propagated between subprog_tc, entry_freplace,
subprog_tail and entry_tc.

But wait, what if entry_freplace has tailcall and entry_tc has no
tailcall? It's to disallow attaching this entry_freplace to this
entry_tc in verifier.

And, what if entry_freplace has tailcall and entry_tc has tailcall and
entry_freplace attaches to entry_tc? In this patch, the tailcall info of
entry_freplace inherits from its target. Therefore, it swaps the
positions of nop5 and xor/nop3 in order to initialize tail_call_cnt at
the prologue of entry_tc and then propagate the tail_call_cnt to
entry_freplace.

Fixes: 1c123c567fb1 ("bpf: Resolve fext program type when checking map compatibility")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 26 ++++++++++++++++++--------
 kernel/bpf/verifier.c       |  6 ++++++
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 074b41fafbe3f..143974b3e953b 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -274,6 +274,8 @@ struct jit_context {
 #define X86_PATCH_SIZE		5
 /* Number of bytes that will be skipped on tailcall */
 #define X86_TAIL_CALL_OFFSET	(12 + ENDBR_INSN_SIZE)
+/* Number of extra bytes that will be skipped on poke */
+#define X86_POKE_EXTRA		3
 
 static void push_r12(u8 **pprog)
 {
@@ -441,17 +443,13 @@ static void emit_prologue_tail_call(u8 **pprog, bool is_subprog)
  */
 static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 			  bool tail_call_reachable, bool is_subprog,
-			  bool is_exception_cb)
+			  bool is_exception_cb, bool is_extension)
 {
 	u8 *prog = *pprog;
 
 	emit_cfi(&prog, is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash);
-	/* BPF trampoline can be made to work without these nops,
-	 * but let's waste 5 bytes for now and optimize later
-	 */
-	emit_nops(&prog, X86_PATCH_SIZE);
 	if (!ebpf_from_cbpf) {
-		if (tail_call_reachable && !is_subprog)
+		if (tail_call_reachable && !is_extension && !is_subprog)
 			/* When it's the entry of the whole tailcall context,
 			 * zeroing rax means initialising tail_call_cnt.
 			 */
@@ -460,6 +458,10 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 			/* Keep the same instruction layout. */
 			emit_nops(&prog, 3);     /* nop3 */
 	}
+	/* BPF trampoline can be made to work without these nops,
+	 * but let's waste 5 bytes for now and optimize later
+	 */
+	emit_nops(&prog, X86_PATCH_SIZE);
 	/* Exception callback receives FP as third parameter */
 	if (is_exception_cb) {
 		EMIT3(0x48, 0x89, 0xF4); /* mov rsp, rsi */
@@ -573,10 +575,13 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 
 	/*
 	 * See emit_prologue(), for IBT builds the trampoline hook is preceded
-	 * with an ENDBR instruction.
+	 * with an ENDBR instruction and 3 bytes tail_call_cnt initialization
+	 * instruction.
 	 */
 	if (is_endbr(*(u32 *)ip))
 		ip += ENDBR_INSN_SIZE;
+	if (is_bpf_text_address((long)ip))
+		ip += X86_POKE_EXTRA;
 
 	return __bpf_arch_text_poke(ip, t, old_addr, new_addr);
 }
@@ -1366,6 +1371,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
 {
 	bool tail_call_reachable = bpf_prog->aux->tail_call_reachable;
+	bool is_extension = bpf_prog->type == BPF_PROG_TYPE_EXT;
 	struct bpf_insn *insn = bpf_prog->insnsi;
 	bool callee_regs_used[4] = {};
 	int insn_cnt = bpf_prog->len;
@@ -1384,7 +1390,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
 
 	emit_prologue(&prog, bpf_prog->aux->stack_depth,
 		      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
-		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
+		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb,
+		      is_extension);
 	/* Exception callback will clobber callee regs for its own use, and
 	 * restore the original callee regs from main prog's stack frame.
 	 */
@@ -2923,6 +2930,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		 */
 		if (is_endbr(*(u32 *)orig_call))
 			orig_call += ENDBR_INSN_SIZE;
+		if (is_bpf_text_address((long)orig_call))
+			orig_call += X86_POKE_EXTRA;
 		orig_call += X86_PATCH_SIZE;
 	}
 
@@ -3025,6 +3034,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		/* remember return value in a stack for bpf prog to access */
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
 		im->ip_after_call = image + (prog - (u8 *)rw_image);
+		emit_nops(&prog, X86_POKE_EXTRA);
 		emit_nops(&prog, X86_PATCH_SIZE);
 	}
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 217eb0eafa2a6..0a92fd4e0401e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21898,6 +21898,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			bpf_log(log, "Cannot extend fentry/fexit\n");
 			return -EINVAL;
 		}
+		if (prog_extension && prog->aux->tail_call_reachable &&
+		    !(aux->func ? aux->func[subprog]->aux->tail_call_reachable :
+		      aux->tail_call_reachable)) {
+			bpf_log(log, "Cannot extend no-tailcall target with tailcall ext prog\n");
+			return -EINVAL;
+		}
 	} else {
 		if (prog_extension) {
 			bpf_log(log, "Cannot replace kernel functions\n");
-- 
2.44.0


