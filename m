Return-Path: <bpf+bounces-19026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4438243A8
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 15:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15770B261C1
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 14:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C9A224FA;
	Thu,  4 Jan 2024 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2K0qO71"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84423224ED
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-28bd623c631so426454a91.3
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 06:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704378189; x=1704982989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCG6I33gkhYXs2o79kAaxgm2xJGrP3YviAZ0nUhtKuI=;
        b=l2K0qO71yFQxv7oqzCH+0B9N6q12d29UDKByEwjZflMYlEPkaCAm5e6sYekj3UbbY5
         0mXRnKatjyr6gOjqiszHt2cMCOltOFixoLUlfVCIdSFT2MiIN4kf1wja6A7CYVsoVdkf
         QXwtP5z/f0kHpvsj1kYPachQzA6Rnn3ws5TKLMv9zpkN5LMMA2v0vggwSJuRJZiWJcN0
         g8rIDQwWWgXOqr5PbHmux9wLOOH3t9QjuVn1qyYYQIg8YL/NNiCMl9yrAX6uwHu2lUiX
         CX0gRCxyXkMAqofhkirqzmedJmnB0UUoCSBJhG3y0B6OvCaJHcsmAzKjoEWwv5bKAoT7
         bCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704378189; x=1704982989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCG6I33gkhYXs2o79kAaxgm2xJGrP3YviAZ0nUhtKuI=;
        b=ZzG78yq4P0mHXQHOthkNdP/0SrBQ6j+lIzOwBPBsrt0mcmdVn5Uxm0uKgnKW/ESTmn
         g29e7/j6pqBNRGlzhtSbrnl9f+E+9yprHefjRy8ePFDzlAuhZXr/ZjaHXhtNPax18pKt
         BGndDA1vKujJbrqdgjnAzHFWX8GBa21CkMRjal2wmBratc3upCki2K6fWAGEmfVdZ7Ah
         dtO6meNV8iblK0q53owuCqzzIerG26TUx4M/JzXAVJ/uDQ6CEkAa5aTDfuceGU/PWtuQ
         iophQr+Xarw8Yucq9ZiMeK291UfKGMS1roJW1VLPy+ZFi8w9koAN2k1k7BJ9+/lPAvTE
         Iz5A==
X-Gm-Message-State: AOJu0YwKfw1z6J1I9vnHEeqJGSrAx17HVck0gFDgZNwKjzmTEmqtnRmc
	AwVtbI1rcZ3vNfJCjk63i0Vb+yVLR5c=
X-Google-Smtp-Source: AGHT+IElXnYWVKXLItyHId/nerFZHLG0UpDtqfmH1KLKonvXq3UDO1SKNLyYpP70U3EtVlSWM8a2qA==
X-Received: by 2002:a17:90a:5289:b0:28c:4c8d:5574 with SMTP id w9-20020a17090a528900b0028c4c8d5574mr601443pjh.49.1704378189141;
        Thu, 04 Jan 2024 06:23:09 -0800 (PST)
Received: from localhost.localdomain (bb219-74-10-34.singnet.com.sg. [219.74.10.34])
        by smtp.gmail.com with ESMTPSA id c10-20020a17090a020a00b0028cb82a8da0sm4081507pjc.31.2024.01.04.06.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 06:23:08 -0800 (PST)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	jakub@cloudflare.com,
	iii@linux.ibm.com,
	hengqi.chen@gmail.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 2/4] bpf, x64: Fix tailcall hierarchy
Date: Thu,  4 Jan 2024 22:22:24 +0800
Message-ID: <20240104142226.87869-3-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240104142226.87869-1-hffilwlqm@gmail.com>
References: <20240104142226.87869-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailcall
handling in JIT"), the tailcall on x64 works better than before.

From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF subprograms
for x64 JIT"), tailcall is able to run in BPF subprograms on x64.

How about:

1. More than 1 subprograms are called in a bpf program.
2. The tailcalls in the subprograms call the bpf program.

Because of missing tail_call_cnt back-propagation, a tailcall hierarchy
comes up. And MAX_TAIL_CALL_CNT limit does not work for this case.

Let's take a look into an example:

#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>
#include "bpf_legacy.h"

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

SEC("tc")
int entry(struct __sk_buff *skb)
{
	volatile int ret = 1;

	count++;
	subprog_tail(skb); /* subprog call1 */
	subprog_tail(skb); /* subprog call2 */

	return ret;
}

char __license[] SEC("license") = "GPL";

And the entry bpf prog is populated to the 0th slot of jmp_table. Then,
what happens when entry bpf prog runs? The CPU will be stalled because
of too many tailcalls like this CI:

https://github.com/kernel-patches/bpf/pull/5807/checks

In this CI results, the test_progs failed to run on aarch64 and s390x
because of "rcu: INFO: rcu_sched self-detected stall on CPU".

So, if CPU does not stall because of too many tailcalls, how many
tailcalls will be there for this case? And why MAX_TAIL_CALL_CNT limit
does not work for this case?

Let's step into some running steps.

At the very first time when subprog_tail() is called, subprog_tail() does
tailcall the entry bpf prog. Then, subprog_taill() is called at second time
at the position subprog call1, and it tailcalls the entry bpf prog again.

Then, again and again. At the very first time when MAX_TAIL_CALL_CNT limit
works, subprog_tail() has been called for 34 times at the position subprog
call1. And at this time, the tail_call_cnt is 33 in subprog_tail().

Next, the 34th subprog_tail() returns to entry() because of
MAX_TAIL_CALL_CNT limit.

In entry(), the 34th entry(), at the time after the 34th subprog_tail() at
the position subprog call1 finishes and before the 1st subprog_tail() at
the position subprog call2 calls in entry(), what's the value of
tail_call_cnt in entry()? It's 33.

As we know, tail_all_cnt is pushed on the stack of entry(), and propagates
to subprog_tail() by %rax from stack.

Then, at the time when subprog_tail() at the position subprog call2 is
called for its first time, tail_call_cnt 33 propagates to subprog_tail()
by %rax. And the tailcall in subprog_tail() is aborted because of
tail_call_cnt >= MAX_TAIL_CALL_CNT too.

Then, subprog_tail() at the position subprog call2 ends, and the 34th
entry() ends. And it returns to the 33rd subprog_tail() called from the
position subprog call1. But wait, at this time, what's the value of
tail_call_cnt under the stack of subprog_tail()? It's 33.

Then, in the 33rd entry(), at the time after the 33th subprog_tail() at
the position subprog call1 finishes and before the 2nd subprog_tail() at
the position subprog call2 calls, what's the value of tail_call_cnt
in current entry()? It's *32*. Why not 33?

Before stepping into subprog_tail() at the position subprog call2 in 33rd
entry(), like stopping the time machine, let's have a look at the stack
memory:

  |  STACK  |
  +---------+ RBP  <-- current rbp
  |   ret   | STACK of 33rd entry()
  |   tcc   | its value is 32
  +---------+ RSP  <-- current rsp
  |   rip   | STACK of 34rd entry()
  |   rbp   | reuse the STACK of 33rd subprog_tail() at the position
  |   ret   |                                        subprog call1
  |   tcc   | its value is 33
  +---------+ rsp
  |   rip   | STACK of 1st subprog_tail() at the position subprog call2
  |   rbp   |
  |   tcc   | its value is 33
  +---------+ rsp

Why not 33? It's because tail_call_cnt does not back-propagate from
subprog_tail() to entry().

Then, while stepping into subprog_tail() at the position subprog call2 in 33rd
entry():

  |  STACK  |
  +---------+
  |   ret   | STACK of 33rd entry()
  |   tcc   | its value is 32
  |   rip   |
  |   rbp   |
  +---------+ RBP  <-- current rbp
  |   tcc   | its value is 32; STACK of subprog_tail() at the position
  +---------+ RSP  <-- current rsp                        subprog call2

Then, while pausing after tailcalling in 2nd subprog_tail() at the position
subprog call2:

  |  STACK  |
  +---------+
  |   ret   | STACK of 33rd entry()
  |   tcc   | its value is 32
  |   rip   |
  |   rbp   |
  +---------+ RBP  <-- current rbp
  |   tcc   | its value is 33; STACK of subprog_tail() at the position
  +---------+ RSP  <-- current rsp                        subprog call2

Note: what happens to tail_call_cnt:
	/*
	 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
	 *	goto out;
	 */
It's to check >= MAX_TAIL_CALL_CNT first and then increment tail_call_cnt.

So, current tailcall is allowed to run.

Then, entry() is tailcalled. And the stack memory status is:

  |  STACK  |
  +---------+
  |   ret   | STACK of 33rd entry()
  |   tcc   | its value is 32
  |   rip   |
  |   rbp   |
  +---------+ RBP  <-- current rbp
  |   ret   | STACK of 35th entry(); reuse STACK of subprog_tail() at the
  |   tcc   | its value is 33                   the position subprog call2
  +---------+ RSP  <-- current rsp

So, the tailcalls in the 35th entry() will be aborted.

And, ..., again and again.  :(

And, I hope you have understood the reason why MAX_TAIL_CALL_CNT limit
does not work for this case.

And, how many tailcalls are there for this case if CPU does not stall?

From top-down view, does it look like hierarchy layer and layer?

I think it is a hierarchy layer model with 2+4+8+...+2**33 tailcalls. As a
result, if CPU does not stall, there will be 2**34 - 2 = 17,179,869,182
tailcalls. That's the guy making CPU stalled.

What about there are N subprog_tail() in entry()? If CPU does not stall
because of too many tailcalls, there will be almost N**34 tailcalls.

And, as we know about the issue, how does this patch resolve it?

I hope you have patience to read the following details, because it's
really hard to understand the code directly.

As we know, in tail call context, the tail_call_cnt propagates by stack
and rax register between BPF subprograms and trampolines.

How about propagating the pointer of tail_call_cnt instead of tail_call_cnt?

When propagating tail_call_cnt pointer by stack and rax register, it'll
make tail_call_cnt works like a global variable in current tail call
context. Then MAX_TAIL_CALL_CNT limit will be able to work for all
tailcalls in current tail call context.

But, where does tail_call_cnt store?

It stores on the stack of entry bpf prog's caller, like

    |  STACK  |
    |         |
    |   rip   |
 +->|   tcc   |
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ RBP
 |  |         |
 |  |         |
 |  |         |
 +--| tcc_ptr |
    |   rbx   |
    +---------+ RSP

Note: tcc is tail_call_cnt, tcc_ptr is tail_call_cnt pointer.

So, how does it store tail_call_cnt to the stack of entry bpf prog's
caller?

At the epilogue of entry bpf prog, before pushing %rbp, it initialises
tail_call_cnt by "xor eax, eax" and then push it to stack by "push rax".
Then, make %rax as the pointer that points to tail_call_cnt by "mov rax,
rsp". Next, call the main part of the entry bpf prog by "call 2". (This
is the exceptional point.) With this "call", %rip is pushed to stack. And
at the end of the entry bpf prog runtime, the %rip is popped from stack;
then, pop tail_call_cnt by "pop rcx" from stack too; and finally "ret"
again. The "pop rcx" and "ret" is the 2 in "call 2".

It seems invasive to use a "call" here. But it is the key of this patch.
With this "call", it is able to store tail_call_cnt to stack of entry
bpf prog's caller instead of the stack of entry bpf prog. As a result,
tail_call_cnt is protected by "call" actually.

Meanwhile tcc_ptr is unnecessary to be popped from stack at the epilogue of bpf
prog, like the way of commit d207929d97ea028f ("bpf, x64: Drop "pop %rcx"
instruction on BPF JIT epilogue").

And when a tailcall happens, load tail_call_cnt pointer from stack to %rax
by "mov rax, qword ptr [rbp - tcc_ptr_off]", and compare tail_call_cnt with
MAX_TAIL_CALL_CNT by "cmp dword ptr [rax], MAX_TAIL_CALL_CNT", and then
increment tail_call_cnt by "add dword ptr [rax], 1". Finally, when pop %rax,
it's to pop tail_call_cnt pointer from stack to %rax.

Next, let's step into some running steps.

When the epilogue of entry() runs, the stack of entry() should be like:

    |  STACK  | STACK of entry()'s caller
    |         |
    |   rip   |
 +->|   tcc   | its value is 0
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ RBP  <-- current rbp
 |  |   ret   | STACK of entry()
 +--| tcc_ptr |
    |   rbx   | saved regs
    +---------+ RSP  <-- current rsp

Then, when subprog_tail() is called for its very first time, its stack
should be like:

    |  STACK  | STACK of entry()'s caller
    |         |
    |   rip   |
 +->|   tcc   | its value is 0
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ rbp
 |  |   ret   | STACK of entry()
 +--| tcc_ptr |
 |  |   rbx   | saved regs
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ RBP  <-- current rbp
 +--| tcc_ptr | STACK of subprog_tail()
    +---------+ RSP  <-- current rsp

Then, when subprog_tail() tailcalls entry():

    |  STACK  | STACK of entry()'s caller
    |         |
    |   rip   |
 +->|   tcc   | its value is 1
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ rbp
 |  |   ret   | STACK of entry()
 +--| tcc_ptr |
 |  |   rbx   | saved regs
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ RBP  <-- current rbp
 |  |   ret   | STACK of entry(), reuse STACK of subprog_tail()
 +--| tcc_ptr |
    +---------+ RSP  <-- current rsp

Then, when entry() calls subprog_tail():

    |  STACK  | STACK of entry()'s caller
    |         |
    |   rip   |
 +->|   tcc   | its value is 1
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ rbp
 |  |   ret   | STACK of entry()
 +--| tcc_ptr |
 |  |   rbx   | saved regs
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ rbp
 |  |   ret   | STACK of entry(), reuse STACK of subprog_tail()
 +--| tcc_ptr |
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ RBP  <-- current rbp
 +--| tcc_ptr | STACK of subprog_tail()
    +---------+ RSP  <-- current rsp

Then, when subprog_tail() tailcalls entry():

    |  STACK  | STACK of entry()'s caller
    |         |
    |   rip   |
 +->|   tcc   | its value is 2
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ rbp
 |  |   ret   | STACK of entry()
 +--| tcc_ptr |
 |  |   rbx   | saved regs
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ rbp
 |  |   ret   | STACK of entry(), reuse STACK of subprog_tail()
 +--| tcc_ptr |
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ RBP  <-- current rbp
 |  |   ret   | STACK of entry(), reuse STACK of subprog_tail()
 +--| tcc_ptr |
    +---------+ RSP  <-- current rsp

Then, again and again. At the very first time when MAX_TAIL_CALL_CNT limit
works, subprog_tail() has been called for 34 times at the position subprog
call1. And at this time, the stack should be like:

    |  STACK  | STACK of entry()'s caller
    |         |
    |   rip   |
 +->|   tcc   | its value is 33
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ rbp
 |  |   ret   | STACK of entry()
 +--| tcc_ptr |
 |  |   rbx   | saved regs
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ rbp
 |  |   ret   | STACK of entry(), reuse STACK of subprog_tail()
 +--| tcc_ptr |
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ rbp
 |  |   ret   | STACK of entry(), reuse STACK of subprog_tail()
 +--| tcc_ptr |
 |  |   rip   |
 |  |   rbp   |
 |  +---------+ rbp
 |  |    *    |
 |  |    *    |
 |  |    *    |
 |  +---------+ RBP  <-- current rbp
 +--| tcc_ptr | STACK of subprog_tail()
    +---------+ RSP  <-- current rsp

At this time, the tailcalls in the future will be aborted because
tail_call_cnt has been 33, which reaches its MAX_TAIL_CALL_CNT limit.

This is the way how this patch works.

It's really nice if you reach here. I hope you have a clear idea to
understand the following code with above explaining.

Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for x64 JIT")
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 40 ++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index fe30b9ebb8de4..67fa337fc2e0c 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -259,7 +259,7 @@ struct jit_context {
 /* Number of bytes emit_patch() needs to generate instructions */
 #define X86_PATCH_SIZE		5
 /* Number of bytes that will be skipped on tailcall */
-#define X86_TAIL_CALL_OFFSET	(11 + ENDBR_INSN_SIZE)
+#define X86_TAIL_CALL_OFFSET	(22 + ENDBR_INSN_SIZE)
 
 static void push_r12(u8 **pprog)
 {
@@ -406,14 +406,21 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 	 */
 	emit_nops(&prog, X86_PATCH_SIZE);
 	if (!ebpf_from_cbpf) {
-		if (tail_call_reachable && !is_subprog)
+		if (tail_call_reachable && !is_subprog) {
 			/* When it's the entry of the whole tailcall context,
 			 * zeroing rax means initialising tail_call_cnt.
 			 */
-			EMIT2(0x31, 0xC0); /* xor eax, eax */
-		else
-			/* Keep the same instruction layout. */
-			EMIT2(0x66, 0x90); /* nop2 */
+			EMIT2(0x31, 0xC0);       /* xor eax, eax */
+			EMIT1(0x50);             /* push rax */
+			/* Make rax as ptr that points to tail_call_cnt. */
+			EMIT3(0x48, 0x89, 0xE0); /* mov rax, rsp */
+			EMIT1_off32(0xE8, 2);    /* call main prog */
+			EMIT1(0x59);             /* pop rcx, get rid of tail_call_cnt */
+			EMIT1(0xC3);             /* ret */
+		} else {
+			/* Keep the same instruction size. */
+			emit_nops(&prog, 13);
+		}
 	}
 	/* Exception callback receives FP as third parameter */
 	if (is_exception_cb) {
@@ -439,6 +446,7 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8));
 	if (tail_call_reachable)
+		/* Here, rax is tail_call_cnt_ptr. */
 		EMIT1(0x50);         /* push rax */
 	*pprog = prog;
 }
@@ -594,7 +602,7 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 					u32 stack_depth, u8 *ip,
 					struct jit_context *ctx)
 {
-	int tcc_off = -4 - round_up(stack_depth, 8);
+	int tcc_ptr_off = -8 - round_up(stack_depth, 8);
 	u8 *prog = *pprog, *start = *pprog;
 	int offset;
 
@@ -619,13 +627,12 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 	 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
 	 *	goto out;
 	 */
-	EMIT2_off32(0x8B, 0x85, tcc_off);         /* mov eax, dword ptr [rbp - tcc_off] */
-	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL_CALL_CNT */
+	EMIT3_off32(0x48, 0x8B, 0x85, tcc_ptr_off); /* mov rax, qword ptr [rbp - tcc_ptr_off] */
+	EMIT3(0x83, 0x38, MAX_TAIL_CALL_CNT);     /* cmp dword ptr [rax], MAX_TAIL_CALL_CNT */
 
 	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
 	EMIT2(X86_JAE, offset);                   /* jae out */
-	EMIT3(0x83, 0xC0, 0x01);                  /* add eax, 1 */
-	EMIT2_off32(0x89, 0x85, tcc_off);         /* mov dword ptr [rbp - tcc_off], eax */
+	EMIT3(0x83, 0x00, 0x01);                  /* add dword ptr [rax], 1 */
 
 	/* prog = array->ptrs[index]; */
 	EMIT4_off32(0x48, 0x8B, 0x8C, 0xD6,       /* mov rcx, [rsi + rdx * 8 + offsetof(...)] */
@@ -647,6 +654,7 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 		pop_callee_regs(&prog, callee_regs_used);
 	}
 
+	/* pop tail_call_cnt_ptr */
 	EMIT1(0x58);                              /* pop rax */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4,     /* add rsp, sd */
@@ -675,7 +683,7 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 				      bool *callee_regs_used, u32 stack_depth,
 				      struct jit_context *ctx)
 {
-	int tcc_off = -4 - round_up(stack_depth, 8);
+	int tcc_ptr_off = -8 - round_up(stack_depth, 8);
 	u8 *prog = *pprog, *start = *pprog;
 	int offset;
 
@@ -683,13 +691,12 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 	 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
 	 *	goto out;
 	 */
-	EMIT2_off32(0x8B, 0x85, tcc_off);             /* mov eax, dword ptr [rbp - tcc_off] */
-	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);         /* cmp eax, MAX_TAIL_CALL_CNT */
+	EMIT3_off32(0x48, 0x8B, 0x85, tcc_ptr_off);   /* mov rax, qword ptr [rbp - tcc_ptr_off] */
+	EMIT3(0x83, 0x38, MAX_TAIL_CALL_CNT);         /* cmp dword ptr [rax], MAX_TAIL_CALL_CNT */
 
 	offset = ctx->tail_call_direct_label - (prog + 2 - start);
 	EMIT2(X86_JAE, offset);                       /* jae out */
-	EMIT3(0x83, 0xC0, 0x01);                      /* add eax, 1 */
-	EMIT2_off32(0x89, 0x85, tcc_off);             /* mov dword ptr [rbp - tcc_off], eax */
+	EMIT3(0x83, 0x00, 0x01);                      /* add dword ptr [rax], 1 */
 
 	poke->tailcall_bypass = ip + (prog - start);
 	poke->adj_off = X86_TAIL_CALL_OFFSET;
@@ -706,6 +713,7 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 		pop_callee_regs(&prog, callee_regs_used);
 	}
 
+	/* pop tail_call_cnt_ptr */
 	EMIT1(0x58);                                  /* pop rax */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4, round_up(stack_depth, 8));
-- 
2.42.1


