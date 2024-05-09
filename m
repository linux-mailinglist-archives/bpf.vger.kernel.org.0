Return-Path: <bpf+bounces-29191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF2B8C11A5
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 17:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1541C20DF5
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 15:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBE415279A;
	Thu,  9 May 2024 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJCAb2EU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE8A149E0C
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267167; cv=none; b=eAf/dvMZjWVbuBQRDVMeVClOtv0Sx87as3hyY7LNYrB7KGWM3oCbyQCadyKlIJBiXf0BJ0D+2TMeFSdeZwZdMkYZ0Hj/lDWgwwZUGP3gSUbkGNF2ScOc6sTDPS4zR3qa2pLV2N+y5uWz/VQCKRXknKXJ+N4q13fBlePaDBP2r9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267167; c=relaxed/simple;
	bh=1CG97BKNtEOnR4kLagFVp54CN0TIksOiEb6OoZv+LaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UuS87UH8PAGnFv4iNO7xuRPvRCsDIda0BkNmTo+EHg9ESLczEljDasIn2kkZDwBH9Dm3scrk7zvLLE9Hs88erlVKH7r1YC8D59n3IuCIDK0J0i9mTt6rZ8TqGLS3X0UxFYu/7bkdhI2CO/DWiEruqxzuQiFoSVAhNSf/slBOSVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJCAb2EU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e3ca546d40so7769675ad.3
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 08:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715267164; x=1715871964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JH8D0LP5iAgPnhqDkCYu2KHnOxKyRCafveNGh32pgQY=;
        b=bJCAb2EUKYtv4kBO/CRhTpDGR8WWYj8u5IRD7x0attBfNM8ncOyKC1fJSsPDDDTnTC
         j9B2jsasHmAmN194I8c3Z4pnoCpCcccXJ4rJeKnsxu2+/FdTrNTyxLXHDIfT7jKu/60i
         BugKAioTvdJwT+LZq0s8029GEcYdqunKmctRmvkt8LM7XNcDo3v63S+ZyalCjwo+Bd+F
         sx5HRrQdOwf3W7lSxNYXdqsF4hkLoNnITv8NVcifJWLdASLwrCIeyvYPgif+yBjv80mZ
         tnxDfEBo7Ejro1FDbCD2U968reX20Pnf6gQLwElX5kvCq6d7+AXhwgvQnWoMCKBMGXQz
         mAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715267164; x=1715871964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JH8D0LP5iAgPnhqDkCYu2KHnOxKyRCafveNGh32pgQY=;
        b=LPOE0iv/tcvVDe3/z7euwcuwKXfk/+kBKCT4nXRYuDgt69oVWJC+RVjwf8DI1ErOeP
         cVaXUNqfm+JjjMLtv/I3grJRvnDzirhRAPnVBm6tOfYT2GZXM4wi+TX4mTyfm8vorRII
         MGXbg1m3J2/c9UqnIvRDPi+on/OyqOWmHh0jS7Xdl++OD2APOXP2YvGtPrS5lCFxrWQO
         3XlVvbmLYhswlFA2SrdFNw+sHnc7ESzJLTupRgxkfXUAQtYpmOOEkQx4VBvPS6pykU53
         APrIvxmxBOAR2v3HBVUFkBiMgKPAxNvCjVUJDW7/Fej63fz2GQ7M8TiVQjVA8vUBzFXd
         DB1g==
X-Gm-Message-State: AOJu0YyQCpY00V+xeIH5cMZLSyLtBZYZSGGqTaeSZLtGEW3Bph9R39oL
	y5imKlK/dV8YnZ1HUbaStwIp6ypUMP0EwwZG0XkBU7TtMUkSnerUnG8Fiw==
X-Google-Smtp-Source: AGHT+IFPfaJGzpdhUix3LG7pN68GACkOvgEITLQZlI7I6XiQYCbX2NBVtHtsiE0fOGrW9r/3V/24ZA==
X-Received: by 2002:a17:902:b909:b0:1ea:cb6f:ee5b with SMTP id d9443c01a7336-1eeb0393fb6mr55724205ad.38.1715267163829;
        Thu, 09 May 2024 08:06:03 -0700 (PDT)
Received: from localhost.localdomain (bb116-14-181-187.singnet.com.sg. [116.14.181.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d1642sm15376135ad.31.2024.05.09.08.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 08:06:03 -0700 (PDT)
From: Leon Hwang <hffilwlqm@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	maciej.fijalkowski@intel.com,
	jakub@cloudflare.com,
	pulehui@huawei.com,
	hffilwlqm@gmail.com,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v4 3/5] bpf, x64: Fix tailcall hierarchy
Date: Thu,  9 May 2024 23:05:39 +0800
Message-ID: <20240509150541.81799-4-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240509150541.81799-1-hffilwlqm@gmail.com>
References: <20240509150541.81799-1-hffilwlqm@gmail.com>
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

With view, there will be 2+4+8+...+2^33 = 2^34 - 2 = 17,179,869,182
tailcalls for this case.

How about there are N subprog_tail() in entry()? There will be almost
N^34 tailcalls.

Then, in this patch, it resolves this case on x86_64.

In stead of propagating tail_call_cnt from caller to callee, it
propagate its pointer, tail_call_cnt_ptr, tcc_ptr for short.

However, where does it store tail_call_cnt?

It stores tail_call_cnt on the stack of bpf prog's caller by the way in
previous patch "bpf: Introduce bpf_jit_supports_tail_call_cnt_ptr()".
Then, in bpf prog's prologue, it loads tcc_ptr from bpf_tail_call_run_ctx,
and restores the original ctx from bpf_tail_call_run_ctx meanwhile.

Then, when a tailcall runs, it compares tail_call_cnt accessed by
tcc_ptr with MAX_TAIL_CALL_CNT and then increments tail_call_cnt at
tcc_ptr.

Furthermore, when trampoline is the caller of bpf prog, it is required
to prepare tail_call_cnt and tail call run ctx on the stack of the
trampoline.

Finally, enable bpf_jit_supports_tail_call_cnt_ptr() to use
bpf_tail_call_run_ctx in __bpf_prog_run().

Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for x64 JIT")
Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 101 ++++++++++++++++++++++++------------
 include/linux/bpf.h         |   2 +
 2 files changed, 70 insertions(+), 33 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index ff217cc35ce92..43dc628e66222 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -273,7 +273,7 @@ struct jit_context {
 /* Number of bytes emit_patch() needs to generate instructions */
 #define X86_PATCH_SIZE		5
 /* Number of bytes that will be skipped on tailcall */
-#define X86_TAIL_CALL_OFFSET	(11 + ENDBR_INSN_SIZE)
+#define X86_TAIL_CALL_OFFSET	(16 + ENDBR_INSN_SIZE)
 
 static void push_r12(u8 **pprog)
 {
@@ -420,14 +420,17 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 	 */
 	emit_nops(&prog, X86_PATCH_SIZE);
 	if (!ebpf_from_cbpf) {
-		if (tail_call_reachable && !is_subprog)
-			/* When it's the entry of the whole tailcall context,
-			 * zeroing rax means initialising tail_call_cnt.
-			 */
-			EMIT2(0x31, 0xC0); /* xor eax, eax */
-		else
+		if (tail_call_reachable && !is_subprog) {
+			/* Store tcc_ptr to rax. */
+			/* mov rax, qword ptr [rdi + 8] */
+			EMIT4(0x48, 0x8B, 0x47, 0x08);
+			/* Restore the original ctx. */
+			/* mov rdi, qword ptr [rdi] */
+			EMIT3(0x48, 0x8B, 0x3F);
+		} else {
 			/* Keep the same instruction layout. */
-			EMIT2(0x66, 0x90); /* nop2 */
+			emit_nops(&prog, 7);
+		}
 	}
 	/* Exception callback receives FP as third parameter */
 	if (is_exception_cb) {
@@ -453,6 +456,7 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8));
 	if (tail_call_reachable)
+		/* Here, rax is tail_call_cnt_ptr. */
 		EMIT1(0x50);         /* push rax */
 	*pprog = prog;
 }
@@ -589,13 +593,15 @@ static void emit_return(u8 **pprog, u8 *ip)
 	*pprog = prog;
 }
 
+#define BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack)	(-8 - round_up(stack, 8))
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
@@ -608,7 +614,7 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 					u32 stack_depth, u8 *ip,
 					struct jit_context *ctx)
 {
-	int tcc_off = -4 - round_up(stack_depth, 8);
+	int tcc_ptr_off = BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack_depth);
 	u8 *prog = *pprog, *start = *pprog;
 	int offset;
 
@@ -630,16 +636,15 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 	EMIT2(X86_JBE, offset);                   /* jbe out */
 
 	/*
-	 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
+	 * if ((*tcc_ptr)++ >= MAX_TAIL_CALL_CNT)
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
@@ -663,6 +668,7 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
 			pop_r12(&prog);
 	}
 
+	/* pop tail_call_cnt_ptr */
 	EMIT1(0x58);                              /* pop rax */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4,     /* add rsp, sd */
@@ -691,21 +697,20 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
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
+	EMIT3(0x83, 0x38, MAX_TAIL_CALL_CNT);         /* cmp dword ptr [rax], MAX_TAIL_CALL_CNT */
 
 	offset = ctx->tail_call_direct_label - (prog + 2 - start);
 	EMIT2(X86_JAE, offset);                       /* jae out */
-	EMIT3(0x83, 0xC0, 0x01);                      /* add eax, 1 */
-	EMIT2_off32(0x89, 0x85, tcc_off);             /* mov dword ptr [rbp - tcc_off], eax */
+	EMIT3(0x83, 0x00, 0x01);                      /* add dword ptr [rax], 1 */
 
 	poke->tailcall_bypass = ip + (prog - start);
 	poke->adj_off = X86_TAIL_CALL_OFFSET;
@@ -724,6 +729,7 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
 			pop_r12(&prog);
 	}
 
+	/* pop tail_call_cnt_ptr */
 	EMIT1(0x58);                                  /* pop rax */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4, round_up(stack_depth, 8));
@@ -1314,8 +1320,8 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
 
 /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
-#define RESTORE_TAIL_CALL_CNT(stack)				\
-	EMIT3_off32(0x48, 0x8B, 0x85, -round_up(stack, 8) - 8)
+#define LOAD_TAIL_CALL_CNT_PTR(stack)						\
+	EMIT3_off32(0x48, 0x8B, 0x85, BPF_TAIL_CALL_CNT_PTR_STACK_OFF(stack))
 
 static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
 		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
@@ -2045,7 +2051,7 @@ st:			if (is_imm8(insn->off))
 
 			func = (u8 *) __bpf_call_base + imm32;
 			if (tail_call_reachable) {
-				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
+				LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
 				ip += 7;
 			}
 			if (!imm32)
@@ -2555,11 +2561,17 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 			   int run_ctx_off, bool save_ret,
 			   void *image, void *rw_image)
 {
-	u8 *prog = *pprog;
-	u8 *jmp_insn;
+	int ctx_tail_call_run_ctx_off = -run_ctx_off + offsetof(struct bpf_tramp_run_ctx,
+								tail_call_run_ctx);
+	int ctx_tcc_ptr_off = ctx_tail_call_run_ctx_off + offsetof(struct bpf_tail_call_run_ctx,
+								   tail_call_cnt_ptr);
+	int ctx_tail_call_cnt_off = -run_ctx_off + offsetof(struct bpf_tramp_run_ctx,
+							    tail_call_cnt);
 	int ctx_cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
 	struct bpf_prog *p = l->link.prog;
 	u64 cookie = l->cookie;
+	u8 *prog = *pprog;
+	u8 *jmp_insn;
 
 	/* mov rdi, cookie */
 	emit_mov_imm64(&prog, BPF_REG_1, (long) cookie >> 32, (u32) (long) cookie);
@@ -2604,6 +2616,23 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 		emit_mov_imm64(&prog, BPF_REG_2,
 			       (long) p->insnsi >> 32,
 			       (u32) (long) p->insnsi);
+	if (p->aux->use_tail_call_run_ctx) {
+		/* Cache the original ctx */
+		/* mov qword ptr [rbp - ctx_tail_call_run_ctx_off], rdi */
+		EMIT3_off32(0x48, 0x89, 0xBD, ctx_tail_call_run_ctx_off);
+		/* Make rdi as tcc_ptr */
+		/* lea rdi, [rbp - ctx_tail_call_cnt_off] */
+		EMIT3_off32(0x48, 0x8D, 0xBD, ctx_tail_call_cnt_off);
+		/* Clear tail_call_cnt */
+		/* mov dword ptr [rdi], 0 */
+		EMIT2_off32(0xC7, 0x07, 0x00);
+		/* Cache tcc_ptr */
+		/* mov qword ptr [rbp - ctx_tcc_ptr_off], rdi */
+		EMIT3_off32(0x48, 0x89, 0xBD, ctx_tcc_ptr_off);
+		/* Update rdi as tail call run ctx */
+		/* lea rdi, [rbp - ctx_tail_call_run_ctx_off] */
+		EMIT3_off32(0x48, 0x8D, 0xBD, ctx_tail_call_run_ctx_off);
+	}
 	/* call JITed bpf program or interpreter */
 	if (emit_rsb_call(&prog, p->bpf_func, image + (prog - (u8 *)rw_image)))
 		return -EINVAL;
@@ -2840,7 +2869,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	 *                     [ ...        ]
 	 *                     [ stack_arg2 ]
 	 * RBP - arg_stack_off [ stack_arg1 ]
-	 * RSP                 [ tail_call_cnt ] BPF_TRAMP_F_TAIL_CALL_CTX
+	 * RSP                 [ tail_call_cnt_ptr ] BPF_TRAMP_F_TAIL_CALL_CTX
 	 */
 
 	/* room for return value of orig_call or fentry prog */
@@ -2969,10 +2998,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		save_args(m, &prog, arg_stack_off, true);
 
 		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
-			/* Before calling the original function, restore the
-			 * tail_call_cnt from stack to rax.
+			/* Before calling the original function, load the
+			 * tail_call_cnt_ptr from stack to rax.
 			 */
-			RESTORE_TAIL_CALL_CNT(stack_size);
+			LOAD_TAIL_CALL_CNT_PTR(stack_size);
 		}
 
 		if (flags & BPF_TRAMP_F_ORIG_STACK) {
@@ -3031,10 +3060,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 			goto cleanup;
 		}
 	} else if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
-		/* Before running the original function, restore the
-		 * tail_call_cnt from stack to rax.
+		/* Before running the original function, load the
+		 * tail_call_cnt_ptr from stack to rax.
 		 */
-		RESTORE_TAIL_CALL_CNT(stack_size);
+		LOAD_TAIL_CALL_CNT_PTR(stack_size);
 	}
 
 	/* restore return value of orig_call or fentry prog back into RAX */
@@ -3432,6 +3461,12 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 	return true;
 }
 
+/* Indicate the JIT backend supports tail call count pointer in tailcall context. */
+bool bpf_jit_supports_tail_call_cnt_ptr(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_percpu_insn(void)
 {
 	return true;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 95888700966f7..94f994204acea 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2057,6 +2057,8 @@ struct bpf_tramp_run_ctx {
 	struct bpf_run_ctx run_ctx;
 	u64 bpf_cookie;
 	struct bpf_run_ctx *saved_run_ctx;
+	struct bpf_tail_call_run_ctx tail_call_run_ctx;
+	u32 tail_call_cnt;
 };
 
 static inline struct bpf_run_ctx *bpf_set_run_ctx(struct bpf_run_ctx *new_ctx)
-- 
2.44.0


