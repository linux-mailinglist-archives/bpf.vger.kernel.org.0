Return-Path: <bpf+bounces-34772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 171DB9309F2
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 14:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A29281947
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 12:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD317346C;
	Sun, 14 Jul 2024 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/uGU6Z7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D5621A0B
	for <bpf@vger.kernel.org>; Sun, 14 Jul 2024 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720960762; cv=none; b=cYbpCQ8XYeDjSlesWeJARntRNaW+IvQXl7Swu+xtgw1cyY1GYNB6n3bp8VjMupVVQKqeXZZAYqNIFHX4XsPHbGq4Hbjc04ah6rl8PYU4OA1KJ9L2uOeCUiXnfNDp8LGBHI2CvZOySF/dxr75Ox1AMpZsSChncnawEm7bgCxxpcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720960762; c=relaxed/simple;
	bh=BHRByn4PjGZj/GAME00esmDoymHpoHr3Bw+yjSyXYTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ve/v7fdMpZluMNAuMthgCcE4lgQldeJ3R4ojML93d33MOouYVNQQ4i2QH0x9Jc+naXmxzQwuBJ1JR5dkD2ZlSYR64PatLG/ZBmoZbht1j4pgHNCgTTCDLNDhxYDdYe7RQOPDgp9K5+QJITyjVyCtV3+H7SllxaXCogHAhatSRKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/uGU6Z7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-706a1711ee5so2337144b3a.0
        for <bpf@vger.kernel.org>; Sun, 14 Jul 2024 05:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720960759; x=1721565559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJoQuNrmWxhiVHYQd7FblRzO3vm271i6XEqn/4FIYQI=;
        b=Z/uGU6Z7+9SEBbk2BYwxhm6lIp4J0ulhS5vazKgywy1Otkq/R//S2Jr3VIooE8gC39
         CV95+udGRFmO4QNEQpUgghZsPZcUUbYeO5yvzdEa9DMn6vx/Szt/rYqVwRoCsyG1sDYh
         S88ARiLxkRbR6QTnHswdhbCqYNZ0TukgPsE9xTCMn1xOAkWUmW3fmNQZ+q/fJ5SkDgCg
         xoaZkRdVC0hP4ZTlXknCNwrldavQPVxYvq926f+P8r/j87nKijCVn7uXrPU6NOFaxWMZ
         HdlKME7cVLs4tnjLxho4lepxYdH9XbXyLpQeECczBE8MyPZ2sJVDebwCSezMvk1Srd2P
         lelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720960759; x=1721565559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJoQuNrmWxhiVHYQd7FblRzO3vm271i6XEqn/4FIYQI=;
        b=iEwkoSB9x6slK2dj9wViGRQ+Qp/eZkCIRGXZCh/fKtOA9DWc69vGqCkiVp+Jho5Dso
         dfL6qBfkJ5e2603JyLxlyHlDKa3nKMX0ptLfbU+J84/BJ1oEehtCuXoUgxl+9uJtsZtN
         mh/tj+iAuyHj3hwFkm43uPZUth2H4qW+1vM/UYUtyPRWMwLcydWhZVRpTgILxi9ZdA8L
         43NG5G9OyJCTL7WKyTflJsdrNxv+yv51epO5ndJ9UXQ9JJceX+ycP3JgxJLi1MEYv7au
         cxlA6bCfnIS76AyWqDNFFi/l68mCgUwFjn28OF4mZqwWvKfNNTmO3So4L3TEuJ8PDMhd
         /+Mw==
X-Gm-Message-State: AOJu0Yxi6MK0TKcetoGjTkl40DyHPtfql68bm+JnUuMHHMeDpzbcX3UY
	EMR9FWRvXnG87ibYh+NrwL8PdWPCQ7VugqSvRrmbsELNJlVfWhF/L12p6Q==
X-Google-Smtp-Source: AGHT+IEJOcOL6ChcVYyRj1NshGYkCm78vovpBDQYXWi7Y5NP53AtOkACO5nUIb9hSAYn55SeLMFCqg==
X-Received: by 2002:a05:6a20:3d8a:b0:1c2:8b26:1bb6 with SMTP id adf61e73a8af0-1c29822d0c1mr16023915637.17.1720960758799;
        Sun, 14 Jul 2024 05:39:18 -0700 (PDT)
Received: from localhost.localdomain (bb219-74-23-111.singnet.com.sg. [219.74.23.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc4e4edsm22994635ad.266.2024.07.14.05.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 05:39:18 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	eddyz87@gmail.com,
	puranjay@kernel.org,
	jakub@cloudflare.com,
	pulehui@huawei.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH v6 bpf-next 1/3] bpf, x64: Fix tailcall hierarchy
Date: Sun, 14 Jul 2024 20:39:00 +0800
Message-ID: <20240714123902.32305-2-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240714123902.32305-1-hffilwlqm@gmail.com>
References: <20240714123902.32305-1-hffilwlqm@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a tailcall issue caused by abusing the tailcall in
bpf2bpf feature.

As we know, tail_call_cnt propagates by rax from caller to callee when
to call subprog in tailcall context. But, like the following example,
MAX_TAIL_CALL_CNT won't work because of missing tail_call_cnt
back-propagation from callee to caller.

\#include <linux/bpf.h>
\#include <bpf/bpf_helpers.h>
\#include "bpf_legacy.h"

struct {
	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
	__uint(max_entries, 1);
	__uint(key_size, sizeof(__u32));
	__uint(value_size, sizeof(__u32));
} jmp_table SEC(".maps");

int count = 0;

static __noinline
int subprog_tail1(struct __sk_buff *skb)
{
	bpf_tail_call_static(skb, &jmp_table, 0);
	return 0;
}

static __noinline
int subprog_tail2(struct __sk_buff *skb)
{
	bpf_tail_call_static(skb, &jmp_table, 0);
	return 0;
}

SEC("tc")
int entry(struct __sk_buff *skb)
{
	volatile int ret = 1;

	count++;
	subprog_tail1(skb);
	subprog_tail2(skb);

	return ret;
}

char __license[] SEC("license") = "GPL";

At run time, the tail_call_cnt in entry() will be propagated to
subprog_tail1() and subprog_tail2(). But, when the tail_call_cnt in
subprog_tail1() updates when bpf_tail_call_static(), the tail_call_cnt
in entry() won't be updated at the same time. As a result, in entry(),
when tail_call_cnt in entry() is less than MAX_TAIL_CALL_CNT and
subprog_tail1() returns because of MAX_TAIL_CALL_CNT limit,
bpf_tail_call_static() in suprog_tail2() is able to run because the
tail_call_cnt in subprog_tail2() propagated from entry() is less than
MAX_TAIL_CALL_CNT.

So, how many tailcalls are there for this case if no error happens?

From top-down view, does it look like hierarchy layer and layer?

With this view, there will be 2+4+8+...+2^33 = 2^34 - 2 = 17,179,869,182
tailcalls for this case.

How about there are N subprog_tail() in entry()? There will be almost
N^34 tailcalls.

Then, in this patch, it resolves this case on x86_64.

In stead of propagating tail_call_cnt from caller to callee, it
propagates its pointer, tail_call_cnt_ptr, tcc_ptr for short.

However, where does it store tail_call_cnt?

It stores tail_call_cnt on the stack of main prog. When tail call
happens in subprog, it increments tail_call_cnt by tcc_ptr.

Meanwhile, it stores tail_call_cnt_ptr on the stack of main prog, too.

And, before jump to tail callee, it has to pop tail_call_cnt and
tail_call_cnt_ptr.

Then, at the prologue of subprog, it must not make rax as
tail_call_cnt_ptr again. It has to reuse tail_call_cnt_ptr from caller.

As a result, at run time, it has to recognize rax is tail_call_cnt or
tail_call_cnt_ptr at prologue by:

1. rax is tail_call_cnt if rax is <= MAX_TAIL_CALL_CNT.
2. rax is tail_call_cnt_ptr if rax is > MAX_TAIL_CALL_CNT, because a
   pointer won't be <= MAX_TAIL_CALL_CNT.

Here's an example to dump JITed.

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
	int ret = 1;

	count++;
	subprog_tail(skb);
	subprog_tail(skb);

	return ret;
}

When bpftool p d j id 42:

int entry(struct __sk_buff * skb):
bpf_prog_0c0f4c2413ef19b1_entry:
; int entry(struct __sk_buff *skb)
   0:	endbr64
   4:	nopl	(%rax,%rax)
   9:	xorq	%rax, %rax		;; rax = 0 (tail_call_cnt)
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
  23:	movq	%rdi, %rbx		;; rbx = skb (callee saved)
; count++;
  26:	movabsq	$-82417199407104, %rdi
  30:	movl	(%rdi), %esi
  33:	addl	$1, %esi
  36:	movl	%esi, (%rdi)
; subprog_tail(skb);
  39:	movq	%rbx, %rdi		;; rdi = skb
  3c:	movq	-16(%rbp), %rax		;; rax = tcc_ptr
  43:	callq	0x80			;; call subprog_tail()
; subprog_tail(skb);
  48:	movq	%rbx, %rdi		;; rdi = skb
  4b:	movq	-16(%rbp), %rax		;; rax = tcc_ptr
  52:	callq	0x80			;; call subprog_tail()
; return ret;
  57:	movl	$1, %eax
  5c:	popq	%rbx
  5d:	leave
  5e:	retq

int subprog_tail(struct __sk_buff * skb):
bpf_prog_3a140cef239a4b4f_subprog_tail:
; int subprog_tail(struct __sk_buff *skb)
   0:	endbr64
   4:	nopl	(%rax,%rax)
   9:	nopl	(%rax)			;; do not touch tail_call_cnt
   c:	pushq	%rbp
   d:	movq	%rsp, %rbp
  10:	endbr64
  14:	pushq	%rax			;; [rbp - 8]  = rax (tcc_ptr)
  15:	pushq	%rax			;; [rbp - 16] = rax (tcc_ptr)
  16:	pushq	%rbx			;; callee saved
  17:	pushq	%r13			;; callee saved
  19:	movq	%rdi, %rbx		;; rbx = skb
; asm volatile("r1 = %[ctx]\n\t"
  1c:	movabsq	$-105487587488768, %r13	;; r13 = jmp_table
  26:	movq	%rbx, %rdi		;; 1st arg, skb
  29:	movq	%r13, %rsi		;; 2nd arg, jmp_table
  2c:	xorl	%edx, %edx		;; 3rd arg, index = 0
  2e:	movq	-16(%rbp), %rax		;; rax = [rbp - 16] (tcc_ptr)
  35:	cmpq	$33, (%rax)
  39:	jae	0x4e			;; if *tcc_ptr >= 33 goto 0x4e --------+
  3b:	jmp	0x4e			;; jmp bypass, toggled by poking       |
  40:	addq	$1, (%rax)		;; (*tcc_ptr)++                        |
  44:	popq	%r13			;; callee saved                        |
  46:	popq	%rbx			;; callee saved                        |
  47:	popq	%rax			;; undo rbp-16 push                    |
  48:	popq	%rax			;; undo rbp-8  push                    |
  49:	nopl	(%rax,%rax)		;; tail call target, toggled by poking |
; return 0;				;;                                     |
  4e:	popq	%r13			;; restore callee saved <--------------+
  50:	popq	%rbx			;; restore callee saved
  51:	leave
  52:	retq

Furthermore, when trampoline is the caller of bpf prog, which is
tail_call_reachable, it is required to propagate rax through trampoline.

Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for x64 JIT")
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 107 ++++++++++++++++++++++++++----------
 1 file changed, 79 insertions(+), 28 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d25d81c8ecc00..074b41fafbe3f 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -273,7 +273,7 @@ struct jit_context {
 /* Number of bytes emit_patch() needs to generate instructions */
 #define X86_PATCH_SIZE		5
 /* Number of bytes that will be skipped on tailcall */
-#define X86_TAIL_CALL_OFFSET	(11 + ENDBR_INSN_SIZE)
+#define X86_TAIL_CALL_OFFSET	(12 + ENDBR_INSN_SIZE)
 
 static void push_r12(u8 **pprog)
 {
@@ -403,6 +403,37 @@ static void emit_cfi(u8 **pprog, u32 hash)
 	*pprog = prog;
 }
 
+static void emit_prologue_tail_call(u8 **pprog, bool is_subprog)
+{
+	u8 *prog = *pprog;
+
+	if (!is_subprog) {
+		/* cmp rax, MAX_TAIL_CALL_CNT */
+		EMIT4(0x48, 0x83, 0xF8, MAX_TAIL_CALL_CNT);
+		EMIT2(X86_JA, 6);        /* ja 6 */
+		/* rax is tail_call_cnt if <= MAX_TAIL_CALL_CNT.
+		 * case1: entry of main prog.
+		 * case2: tail callee of main prog.
+		 */
+		EMIT1(0x50);             /* push rax */
+		/* Make rax as tail_call_cnt_ptr. */
+		EMIT3(0x48, 0x89, 0xE0); /* mov rax, rsp */
+		EMIT2(0xEB, 1);          /* jmp 1 */
+		/* rax is tail_call_cnt_ptr if > MAX_TAIL_CALL_CNT.
+		 * case: tail callee of subprog.
+		 */
+		EMIT1(0x50);             /* push rax */
+		/* push tail_call_cnt_ptr */
+		EMIT1(0x50);             /* push rax */
+	} else { /* is_subprog */
+		/* rax is tail_call_cnt_ptr. */
+		EMIT1(0x50);             /* push rax */
+		EMIT1(0x50);             /* push rax */
+	}
+
+	*pprog = prog;
+}
+
 /*
  * Emit x86-64 prologue code for BPF program.
  * bpf_tail_call helper will skip the first X86_TAIL_CALL_OFFSET bytes
@@ -424,10 +455,10 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 			/* When it's the entry of the whole tailcall context,
 			 * zeroing rax means initialising tail_call_cnt.
 			 */
-			EMIT2(0x31, 0xC0); /* xor eax, eax */
+			EMIT3(0x48, 0x31, 0xC0); /* xor rax, rax */
 		else
 			/* Keep the same instruction layout. */
-			EMIT2(0x66, 0x90); /* nop2 */
+			emit_nops(&prog, 3);     /* nop3 */
 	}
 	/* Exception callback receives FP as third parameter */
 	if (is_exception_cb) {
@@ -453,7 +484,7 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8));
 	if (tail_call_reachable)
-		EMIT1(0x50);         /* push rax */
+		emit_prologue_tail_call(&prog, is_subprog);
 	*pprog = prog;
 }
 
@@ -589,13 +620,15 @@ static void emit_return(u8 **pprog, u8 *ip)
 	*pprog = prog;
 }
 
+#define BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack)	(-16 - round_up(stack, 8))
+
 /*
  * Generate the following code:
  *
  * ... bpf_tail_call(void *ctx, struct bpf_array *array, u64 index) ...
  *   if (index >= array->map.max_entries)
  *     goto out;
- *   if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
+ *   if ((*tcc_ptr)++ >= MAX_TAIL_CALL_CNT)
  *     goto out;
  *   prog = array->ptrs[index];
  *   if (prog == NULL)
@@ -608,7 +641,7 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 					u32 stack_depth, u8 *ip,
 					struct jit_context *ctx)
 {
-	int tcc_off = -4 - round_up(stack_depth, 8);
+	int tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack_depth);
 	u8 *prog = *pprog, *start = *pprog;
 	int offset;
 
@@ -630,16 +663,14 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 	EMIT2(X86_JBE, offset);                   /* jbe out */
 
 	/*
-	 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
+	 * if ((*tcc_ptr)++ >= MAX_TAIL_CALL_CNT)
 	 *	goto out;
 	 */
-	EMIT2_off32(0x8B, 0x85, tcc_off);         /* mov eax, dword ptr [rbp - tcc_off] */
-	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL_CALL_CNT */
+	EMIT3_off32(0x48, 0x8B, 0x85, tcc_ptr_off); /* mov rax, qword ptr [rbp - tcc_ptr_off] */
+	EMIT4(0x48, 0x83, 0x38, MAX_TAIL_CALL_CNT); /* cmp qword ptr [rax], MAX_TAIL_CALL_CNT */
 
 	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
 	EMIT2(X86_JAE, offset);                   /* jae out */
-	EMIT3(0x83, 0xC0, 0x01);                  /* add eax, 1 */
-	EMIT2_off32(0x89, 0x85, tcc_off);         /* mov dword ptr [rbp - tcc_off], eax */
 
 	/* prog = array->ptrs[index]; */
 	EMIT4_off32(0x48, 0x8B, 0x8C, 0xD6,       /* mov rcx, [rsi + rdx * 8 + offsetof(...)] */
@@ -654,6 +685,9 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
 	EMIT2(X86_JE, offset);                    /* je out */
 
+	/* Inc tail_call_cnt if the slot is populated. */
+	EMIT4(0x48, 0x83, 0x00, 0x01);            /* add qword ptr [rax], 1 */
+
 	if (bpf_prog->aux->exception_boundary) {
 		pop_callee_regs(&prog, all_callee_regs_used);
 		pop_r12(&prog);
@@ -663,6 +697,11 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 			pop_r12(&prog);
 	}
 
+	/* Pop tail_call_cnt_ptr. */
+	EMIT1(0x58);                              /* pop rax */
+	/* Pop tail_call_cnt, if it's main prog.
+	 * Pop tail_call_cnt_ptr, if it's subprog.
+	 */
 	EMIT1(0x58);                              /* pop rax */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4,     /* add rsp, sd */
@@ -691,21 +730,19 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 				      bool *callee_regs_used, u32 stack_depth,
 				      struct jit_context *ctx)
 {
-	int tcc_off = -4 - round_up(stack_depth, 8);
+	int tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack_depth);
 	u8 *prog = *pprog, *start = *pprog;
 	int offset;
 
 	/*
-	 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
+	 * if ((*tcc_ptr)++ >= MAX_TAIL_CALL_CNT)
 	 *	goto out;
 	 */
-	EMIT2_off32(0x8B, 0x85, tcc_off);             /* mov eax, dword ptr [rbp - tcc_off] */
-	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);         /* cmp eax, MAX_TAIL_CALL_CNT */
+	EMIT3_off32(0x48, 0x8B, 0x85, tcc_ptr_off);   /* mov rax, qword ptr [rbp - tcc_ptr_off] */
+	EMIT4(0x48, 0x83, 0x38, MAX_TAIL_CALL_CNT);   /* cmp qword ptr [rax], MAX_TAIL_CALL_CNT */
 
 	offset = ctx->tail_call_direct_label - (prog + 2 - start);
 	EMIT2(X86_JAE, offset);                       /* jae out */
-	EMIT3(0x83, 0xC0, 0x01);                      /* add eax, 1 */
-	EMIT2_off32(0x89, 0x85, tcc_off);             /* mov dword ptr [rbp - tcc_off], eax */
 
 	poke->tailcall_bypass = ip + (prog - start);
 	poke->adj_off = X86_TAIL_CALL_OFFSET;
@@ -715,6 +752,9 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 	emit_jump(&prog, (u8 *)poke->tailcall_target + X86_PATCH_SIZE,
 		  poke->tailcall_bypass);
 
+	/* Inc tail_call_cnt if the slot is populated. */
+	EMIT4(0x48, 0x83, 0x00, 0x01);                /* add qword ptr [rax], 1 */
+
 	if (bpf_prog->aux->exception_boundary) {
 		pop_callee_regs(&prog, all_callee_regs_used);
 		pop_r12(&prog);
@@ -724,6 +764,11 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 			pop_r12(&prog);
 	}
 
+	/* Pop tail_call_cnt_ptr. */
+	EMIT1(0x58);                                  /* pop rax */
+	/* Pop tail_call_cnt, if it's main prog.
+	 * Pop tail_call_cnt_ptr, if it's subprog.
+	 */
 	EMIT1(0x58);                                  /* pop rax */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4, round_up(stack_depth, 8));
@@ -1311,9 +1356,11 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
 
 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
 
-/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
-#define RESTORE_TAIL_CALL_CNT(stack)				\
-	EMIT3_off32(0x48, 0x8B, 0x85, -round_up(stack, 8) - 8)
+#define __LOAD_TCC_PTR(off)			\
+	EMIT3_off32(0x48, 0x8B, 0x85, off)
+/* mov rax, qword ptr [rbp - rounded_stack_depth - 16] */
+#define LOAD_TAIL_CALL_CNT_PTR(stack)				\
+	__LOAD_TCC_PTR(BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack))
 
 static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
 		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
@@ -2031,7 +2078,7 @@ st:			if (is_imm8(insn->off))
 
 			func = (u8 *) __bpf_call_base + imm32;
 			if (tail_call_reachable) {
-				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
+				LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
 				ip += 7;
 			}
 			if (!imm32)
@@ -2706,6 +2753,10 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
 	return 0;
 }
 
+/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
+#define LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack)	\
+	__LOAD_TCC_PTR(-round_up(stack, 8) - 8)
+
 /* Example:
  * __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev);
  * its 'struct btf_func_model' will be nr_args=2
@@ -2826,7 +2877,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	 *                     [ ...        ]
 	 *                     [ stack_arg2 ]
 	 * RBP - arg_stack_off [ stack_arg1 ]
-	 * RSP                 [ tail_call_cnt ] BPF_TRAMP_F_TAIL_CALL_CTX
+	 * RSP                 [ tail_call_cnt_ptr ] BPF_TRAMP_F_TAIL_CALL_CTX
 	 */
 
 	/* room for return value of orig_call or fentry prog */
@@ -2955,10 +3006,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		save_args(m, &prog, arg_stack_off, true);
 
 		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
-			/* Before calling the original function, restore the
-			 * tail_call_cnt from stack to rax.
+			/* Before calling the original function, load the
+			 * tail_call_cnt_ptr from stack to rax.
 			 */
-			RESTORE_TAIL_CALL_CNT(stack_size);
+			LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack_size);
 		}
 
 		if (flags & BPF_TRAMP_F_ORIG_STACK) {
@@ -3017,10 +3068,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 			goto cleanup;
 		}
 	} else if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
-		/* Before running the original function, restore the
-		 * tail_call_cnt from stack to rax.
+		/* Before running the original function, load the
+		 * tail_call_cnt_ptr from stack to rax.
 		 */
-		RESTORE_TAIL_CALL_CNT(stack_size);
+		LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack_size);
 	}
 
 	/* restore return value of orig_call or fentry prog back into RAX */
-- 
2.44.0


