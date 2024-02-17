Return-Path: <bpf+bounces-22212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2C7858FC3
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 14:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9A51F21EA2
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 13:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8F87AE4E;
	Sat, 17 Feb 2024 13:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PT1Nzrpv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043DC81E
	for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 13:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708177426; cv=none; b=AEx0Zv9VB5WOKMI2Px7XKuBfvHefUEujo9DCsmYnlhbqbFGi3j8W5l14Da6eOmnJ3rtS15i4lpok0QR07in8xg8+Imi3lEFnsvEWpCSF1YjcefYX9fK571RqM6qO2PlkAZS1ohXwSJh5xiNeLnyylQZelA9ognWKPiQUAJuZ8ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708177426; c=relaxed/simple;
	bh=s5zBhJIjMwhxExoSKM+rLJW7bhcqDvXGbgBSyp128aM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DOJjnY2BLAebhz+E0KVBJEaEOvfMzwzXEcVcdNqND8KJTTXMXwmYW2xfUFy16SkoJY/W+Wpo9zQKprQI6TCotUgjAan1CsFRRFPz7o7hYBHgMUXwqhtZHD3GlTfYlRFxWpiYrTJ3jFnhydaH5NrW7xj0HQfr/vihtIRABE6bD8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PT1Nzrpv; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e2e44aad03so1799952a34.2
        for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 05:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708177424; x=1708782224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u24ZabdJhwxHTq7Xj2fFdRjO7z8UWls1RSR6WlzhuhQ=;
        b=PT1Nzrpv42irFjbZBH6lyHLSjMGfwvxxTi7r3EJZUXwrkXOFWOqMStvliJCLdbf0lz
         EpW/yweY1URGL+yDCzWLYJ6kMaVfG+NdVpr2EuJ5cv8gBRNKz0xtLg9lhQwJfTRvdQWo
         ARsRrP6b/01CkHnvZ3zKwLO6vRGmyu5Xky4NgVR2e3vlF2RXIILkq5hgo6jUUkeyAVaL
         eeLQ5PxK9v4M5eve3w51LD9dy/eCy0DdkpQmMAsdGA9s8FPefjOFx18Y/zizm6w58pe5
         LVXEa8KcFGwh42XKhLdpb5+cpefSN2M+5g7eMfMO9bMH0mzYPLzmdy5C55FB4shGoEZ/
         ymJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708177424; x=1708782224;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u24ZabdJhwxHTq7Xj2fFdRjO7z8UWls1RSR6WlzhuhQ=;
        b=sAlAlYYo889F+s1JzYgJVt24jli+aYBrPHhjJ01guMFEQLXanTGhq3EgTBXk8ySDRN
         mBrPIqv45gbXGXbUso7/vwS3YlOQMMkPwgeGph57H+7s268JY3R4cGVfxQdzl+K4K8Vw
         BO2D3C29Gz+rKMjK7COg5l0ccMFvgi7k3xM5Td3vrzdq9/yww8kcLArSsF/dbTnT+drF
         TqUkBm+Wh1ldwm0j8wydvvITB0b3Un0OQsvQ4n0yQOttKlkbdlrwxx7iJlIvo45jAAmN
         vsCYvpf5U0iBkMcaigHcZxhYWkk7rwftgHcx2zkZj6PL9/RkgRJoK/Uq7eID6x+Qm7Iv
         dXqQ==
X-Gm-Message-State: AOJu0Yz24zr0Oc6Uu6UBBzIIpKJcT41BlgPjGu7BL829QUenHa/85XXk
	+GFaY6KxFAPAXT9Q4P53J1APithEfFrjFk/5k4fztCJmgKXITRfNkKPRuuqAO8g=
X-Google-Smtp-Source: AGHT+IFN7HBNIUR4QYF1BTxUiLlfA5zD6e7QmZYTJuZM86Q2qvDe8rjD2od6PuZbCLgp9DqimBwyFA==
X-Received: by 2002:a05:6358:93a6:b0:17b:304f:b2b with SMTP id h38-20020a05635893a600b0017b304f0b2bmr2121631rwb.26.1708177423843;
        Sat, 17 Feb 2024 05:43:43 -0800 (PST)
Received: from [192.168.11.225] (220-136-219-73.dynamic-ip.hinet.net. [220.136.219.73])
        by smtp.gmail.com with ESMTPSA id ei15-20020a17090ae54f00b002992886277dsm1835913pjb.16.2024.02.17.05.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 05:43:43 -0800 (PST)
Message-ID: <98557e73-1fdf-453d-b5d0-7d0e2b471a8b@gmail.com>
Date: Sat, 17 Feb 2024 21:43:38 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/4] bpf, x64: Fix tailcall hierarchy
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Hengqi Chen <hengqi.chen@gmail.com>, kernel-patches-bot@fb.com
References: <20240104142226.87869-1-hffilwlqm@gmail.com>
 <20240104142226.87869-3-hffilwlqm@gmail.com>
 <CAADnVQJ1szry9P00wweVDu4d0AQoM_49qT-_ueirvggAiCZrpw@mail.gmail.com>
 <7af3f9c6-d25a-4ca5-9e15-c1699adcf7ab@gmail.com>
 <CAADnVQLOswL3BY1s0B28wRZH1PU675S6_2=XknjZKNgyJ=yDxw@mail.gmail.com>
 <81607ab3-a7f5-4ad1-98c2-771c73bfb55c@gmail.com>
 <CAADnVQJVC21dh9igQ7w=iMamx-M=U2H+Vt7fJE-9tB4qR4tHsQ@mail.gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAADnVQJVC21dh9igQ7w=iMamx-M=U2H+Vt7fJE-9tB4qR4tHsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/2/16 10:18, Alexei Starovoitov wrote:
> On Thu, Feb 15, 2024 at 5:16 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>>
>> Here's the diff:
> 
> Please always send a diff against bpf-next.
> No one remembers your prior patch from months ago.

Got it. Thanks for your guide.
>>
>> +DEFINE_PER_CPU(u32, bpf_tail_call_cnt);
>> +
>> +__attribute__((used))
>> +static u32 *bpf_tail_call_cnt_prepare(void)
>> +{
>> +       u32 *tcc_ptr = this_cpu_ptr(&bpf_tail_call_cnt);
>> +
>> +       /* Initialise tail_call_cnt. */
>> +       *tcc_ptr = 0;
>> +
>> +       return tcc_ptr;
>> +}
> 
> This might need to be in asm to make sure no callee saved registers
> are touched.
> 
> In general that's better, but it feels we can do better
> and avoid passing rax around.
> Just access bpf_tail_call_cnt directly from emit_bpf_tail_call.
Yes, we can do better to avoid passing rax around:

1. At prologue, initialise percpu tail_call_cnt.
2. When tailcall, fetch and increment percpu tail_call_cnt.

As a result, we can remove pushing/popping rax at anywhere.

Finally, here's the diff against latest bpf-next with asm to handle
percpu tail_call_cnt:

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 67315505da32e..6f34636fc31d7 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -18,6 +18,7 @@
 #include <asm/text-patching.h>
 #include <asm/unwind.h>
 #include <asm/cfi.h>
+#include <asm/percpu.h>

 static bool all_callee_regs_used[4] = {true, true, true, true};

@@ -259,7 +260,7 @@ struct jit_context {
 /* Number of bytes emit_patch() needs to generate instructions */
 #define X86_PATCH_SIZE		5
 /* Number of bytes that will be skipped on tailcall */
-#define X86_TAIL_CALL_OFFSET	(22 + ENDBR_INSN_SIZE)
+#define X86_TAIL_CALL_OFFSET	(14 + ENDBR_INSN_SIZE)

 static void push_r12(u8 **pprog)
 {
@@ -389,68 +390,6 @@ static void emit_cfi(u8 **pprog, u32 hash)
 	*pprog = prog;
 }

-/*
- * Emit x86-64 prologue code for BPF program.
- * bpf_tail_call helper will skip the first X86_TAIL_CALL_OFFSET bytes
- * while jumping to another program
- */
-static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
-			  bool tail_call_reachable, bool is_subprog,
-			  bool is_exception_cb)
-{
-	u8 *prog = *pprog;
-
-	emit_cfi(&prog, is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash);
-	/* BPF trampoline can be made to work without these nops,
-	 * but let's waste 5 bytes for now and optimize later
-	 */
-	emit_nops(&prog, X86_PATCH_SIZE);
-	if (!ebpf_from_cbpf) {
-		if (tail_call_reachable && !is_subprog) {
-			/* When it's the entry of the whole tailcall context,
-			 * zeroing rax means initialising tail_call_cnt.
-			 */
-			EMIT2(0x31, 0xC0);       /* xor eax, eax */
-			EMIT1(0x50);             /* push rax */
-			/* Make rax as ptr that points to tail_call_cnt. */
-			EMIT3(0x48, 0x89, 0xE0); /* mov rax, rsp */
-			EMIT1_off32(0xE8, 2);    /* call main prog */
-			EMIT1(0x59);             /* pop rcx, get rid of tail_call_cnt */
-			EMIT1(0xC3);             /* ret */
-		} else {
-			/* Keep the same instruction size. */
-			emit_nops(&prog, 13);
-		}
-	}
-	/* Exception callback receives FP as third parameter */
-	if (is_exception_cb) {
-		EMIT3(0x48, 0x89, 0xF4); /* mov rsp, rsi */
-		EMIT3(0x48, 0x89, 0xD5); /* mov rbp, rdx */
-		/* The main frame must have exception_boundary as true, so we
-		 * first restore those callee-saved regs from stack, before
-		 * reusing the stack frame.
-		 */
-		pop_callee_regs(&prog, all_callee_regs_used);
-		pop_r12(&prog);
-		/* Reset the stack frame. */
-		EMIT3(0x48, 0x89, 0xEC); /* mov rsp, rbp */
-	} else {
-		EMIT1(0x55);             /* push rbp */
-		EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
-	}
-
-	/* X86_TAIL_CALL_OFFSET is here */
-	EMIT_ENDBR();
-
-	/* sub rsp, rounded_stack_depth */
-	if (stack_depth)
-		EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8));
-	if (tail_call_reachable)
-		/* Here, rax is tail_call_cnt_ptr. */
-		EMIT1(0x50);         /* push rax */
-	*pprog = prog;
-}
-
 static int emit_patch(u8 **pprog, void *func, void *ip, u8 opcode)
 {
 	u8 *prog = *pprog;
@@ -544,6 +483,105 @@ int bpf_arch_text_poke(void *ip, enum
bpf_text_poke_type t,
 	return __bpf_arch_text_poke(ip, t, old_addr, new_addr);
 }

+DEFINE_PER_CPU(u32, bpf_tail_call_cnt);
+
+__attribute__((used))
+static void bpf_tail_call_cnt_prepare(void)
+{
+	/* The following asm equals to
+	 *
+	 * u32 *tcc_ptr = this_cpu_ptr(&bpf_tail_call_cnt);
+	 *
+	 * *tcc_ptr = 0;
+	 *
+	 * Make sure this asm use %rax only.
+	 */
+
+	asm volatile (
+	     "addq " __percpu_arg(0) ", %1\n\t"
+	     "movl $0, (%%rax)\n\t"
+	     :
+	     : "m" (this_cpu_off), "r" (&bpf_tail_call_cnt)
+	);
+}
+
+__attribute__((used))
+static u32 bpf_tail_call_cnt_fetch_and_inc(void)
+{
+	u32 tail_call_cnt;
+
+	/* The following asm equals to
+	 *
+	 * u32 *tcc_ptr = this_cpu_ptr(&bpf_tail_call_cnt);
+	 *
+	 * (*tcc_ptr)++;
+	 * tail_call_cnt = *tcc_ptr;
+	 * tail_call_cnt--;
+	 *
+	 * Make sure this asm use %rax only.
+	 */
+
+	asm volatile (
+	     "addq " __percpu_arg(1) ", %2\n\t"
+	     "incl (%%rax)\n\t"
+	     "movl (%%rax), %0\n\t"
+	     "decl %0\n\t"
+	     : "=r" (tail_call_cnt)
+	     : "m" (this_cpu_off), "r" (&bpf_tail_call_cnt)
+	);
+
+	return tail_call_cnt;
+}
+
+/*
+ * Emit x86-64 prologue code for BPF program.
+ * bpf_tail_call helper will skip the first X86_TAIL_CALL_OFFSET bytes
+ * while jumping to another program
+ */
+static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
+			  bool tail_call_reachable, bool is_subprog,
+			  bool is_exception_cb, u8 *ip)
+{
+	u8 *prog = *pprog, *start = *pprog;
+
+	emit_cfi(&prog, is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash);
+	/* BPF trampoline can be made to work without these nops,
+	 * but let's waste 5 bytes for now and optimize later
+	 */
+	emit_nops(&prog, X86_PATCH_SIZE);
+	if (!ebpf_from_cbpf) {
+		if (tail_call_reachable && !is_subprog)
+			emit_call(&prog, bpf_tail_call_cnt_prepare,
+				  ip + (prog - start));
+		else
+			emit_nops(&prog, X86_PATCH_SIZE);
+	}
+	/* Exception callback receives FP as third parameter */
+	if (is_exception_cb) {
+		EMIT3(0x48, 0x89, 0xF4); /* mov rsp, rsi */
+		EMIT3(0x48, 0x89, 0xD5); /* mov rbp, rdx */
+		/* The main frame must have exception_boundary as true, so we
+		 * first restore those callee-saved regs from stack, before
+		 * reusing the stack frame.
+		 */
+		pop_callee_regs(&prog, all_callee_regs_used);
+		pop_r12(&prog);
+		/* Reset the stack frame. */
+		EMIT3(0x48, 0x89, 0xEC); /* mov rsp, rbp */
+	} else {
+		EMIT1(0x55);             /* push rbp */
+		EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
+	}
+
+	/* X86_TAIL_CALL_OFFSET is here */
+	EMIT_ENDBR();
+
+	/* sub rsp, rounded_stack_depth */
+	if (stack_depth)
+		EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8));
+	*pprog = prog;
+}
+
 #define EMIT_LFENCE()	EMIT3(0x0F, 0xAE, 0xE8)

 static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
@@ -602,7 +640,6 @@ static void emit_bpf_tail_call_indirect(struct
bpf_prog *bpf_prog,
 					u32 stack_depth, u8 *ip,
 					struct jit_context *ctx)
 {
-	int tcc_ptr_off = -8 - round_up(stack_depth, 8);
 	u8 *prog = *pprog, *start = *pprog;
 	int offset;

@@ -623,16 +660,14 @@ static void emit_bpf_tail_call_indirect(struct
bpf_prog *bpf_prog,
 	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
 	EMIT2(X86_JBE, offset);                   /* jbe out */

-	/*
-	 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
-	 *	goto out;
+	/* if (bpf_tail_call_cnt_fetch_and_inc() >= MAX_TAIL_CALL_CNT)
+	 * 	goto out;
 	 */
-	EMIT3_off32(0x48, 0x8B, 0x85, tcc_ptr_off); /* mov rax, qword ptr [rbp
- tcc_ptr_off] */
-	EMIT3(0x83, 0x38, MAX_TAIL_CALL_CNT);     /* cmp dword ptr [rax],
MAX_TAIL_CALL_CNT */
+	emit_call(&prog, bpf_tail_call_cnt_fetch_and_inc, ip + (prog - start));
+	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL_CALL_CNT */

 	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
 	EMIT2(X86_JAE, offset);                   /* jae out */
-	EMIT3(0x83, 0x00, 0x01);                  /* add dword ptr [rax], 1 */

 	/* prog = array->ptrs[index]; */
 	EMIT4_off32(0x48, 0x8B, 0x8C, 0xD6,       /* mov rcx, [rsi + rdx * 8 +
offsetof(...)] */
@@ -654,8 +689,6 @@ static void emit_bpf_tail_call_indirect(struct
bpf_prog *bpf_prog,
 		pop_callee_regs(&prog, callee_regs_used);
 	}

-	/* pop tail_call_cnt_ptr */
-	EMIT1(0x58);                              /* pop rax */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4,     /* add rsp, sd */
 			    round_up(stack_depth, 8));
@@ -683,20 +716,17 @@ static void emit_bpf_tail_call_direct(struct
bpf_prog *bpf_prog,
 				      bool *callee_regs_used, u32 stack_depth,
 				      struct jit_context *ctx)
 {
-	int tcc_ptr_off = -8 - round_up(stack_depth, 8);
 	u8 *prog = *pprog, *start = *pprog;
 	int offset;

-	/*
-	 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
-	 *	goto out;
+	/* if (bpf_tail_call_cnt_fetch_and_inc() >= MAX_TAIL_CALL_CNT)
+	 * 	goto out;
 	 */
-	EMIT3_off32(0x48, 0x8B, 0x85, tcc_ptr_off);   /* mov rax, qword ptr
[rbp - tcc_ptr_off] */
-	EMIT3(0x83, 0x38, MAX_TAIL_CALL_CNT);         /* cmp dword ptr [rax],
MAX_TAIL_CALL_CNT */
+	emit_call(&prog, bpf_tail_call_cnt_fetch_and_inc, ip);
+	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);         /* cmp eax,
MAX_TAIL_CALL_CNT */

 	offset = ctx->tail_call_direct_label - (prog + 2 - start);
 	EMIT2(X86_JAE, offset);                       /* jae out */
-	EMIT3(0x83, 0x00, 0x01);                      /* add dword ptr [rax], 1 */

 	poke->tailcall_bypass = ip + (prog - start);
 	poke->adj_off = X86_TAIL_CALL_OFFSET;
@@ -713,8 +743,6 @@ static void emit_bpf_tail_call_direct(struct
bpf_prog *bpf_prog,
 		pop_callee_regs(&prog, callee_regs_used);
 	}

-	/* pop tail_call_cnt_ptr */
-	EMIT1(0x58);                                  /* pop rax */
 	if (stack_depth)
 		EMIT3_off32(0x48, 0x81, 0xC4, round_up(stack_depth, 8));

@@ -1141,10 +1169,6 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg,
u8 src_reg, bool is64, u8 op)

 #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))

-/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
-#define LOAD_TAIL_CALL_CNT_PTR(stack)				\
-	EMIT3_off32(0x48, 0x8B, 0x85, -round_up(stack, 8) - 8)
-
 static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8
*rw_image,
 		  int oldproglen, struct jit_context *ctx, bool jmp_padding)
 {
@@ -1168,7 +1192,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int
*addrs, u8 *image, u8 *rw_image

 	emit_prologue(&prog, bpf_prog->aux->stack_depth,
 		      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
-		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
+		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb,
+		      image);
 	/* Exception callback will clobber callee regs for its own use, and
 	 * restore the original callee regs from main prog's stack frame.
 	 */
@@ -1760,17 +1785,12 @@ st:			if (is_imm8(insn->off))
 		case BPF_JMP | BPF_CALL: {
 			int offs;

+			if (!imm32)
+				return -EINVAL;
+
 			func = (u8 *) __bpf_call_base + imm32;
-			if (tail_call_reachable) {
-				LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
-				if (!imm32)
-					return -EINVAL;
-				offs = 7 + x86_call_depth_emit_accounting(&prog, func);
-			} else {
-				if (!imm32)
-					return -EINVAL;
-				offs = x86_call_depth_emit_accounting(&prog, func);
-			}
+			offs = x86_call_depth_emit_accounting(&prog, func);
+
 			if (emit_call(&prog, func, image + addrs[i - 1] + offs))
 				return -EINVAL;
 			break;
@@ -2558,7 +2578,6 @@ static int __arch_prepare_bpf_trampoline(struct
bpf_tramp_image *im, void *rw_im
 	 *                     [ ...        ]
 	 *                     [ stack_arg2 ]
 	 * RBP - arg_stack_off [ stack_arg1 ]
-	 * RSP                 [ tail_call_cnt_ptr ] BPF_TRAMP_F_TAIL_CALL_CTX
 	 */

 	/* room for return value of orig_call or fentry prog */
@@ -2630,8 +2649,6 @@ static int __arch_prepare_bpf_trampoline(struct
bpf_tramp_image *im, void *rw_im
 		/* sub rsp, stack_size */
 		EMIT4(0x48, 0x83, 0xEC, stack_size);
 	}
-	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
-		EMIT1(0x50);		/* push rax */
 	/* mov QWORD PTR [rbp - rbx_off], rbx */
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);

@@ -2686,15 +2703,9 @@ static int __arch_prepare_bpf_trampoline(struct
bpf_tramp_image *im, void *rw_im
 		restore_regs(m, &prog, regs_off);
 		save_args(m, &prog, arg_stack_off, true);

-		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
-			/* Before calling the original function, load the
-			 * tail_call_cnt_ptr to rax.
-			 */
-			LOAD_TAIL_CALL_CNT_PTR(stack_size);
-
 		if (flags & BPF_TRAMP_F_ORIG_STACK) {
-			emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, 8);
-			EMIT2(0xff, 0xd3); /* call *rbx */
+			emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
+			EMIT2(0xff, 0xd0); /* call *rax */
 		} else {
 			/* call original function */
 			if (emit_rsb_call(&prog, orig_call, image + (prog - (u8 *)rw_image))) {
@@ -2747,11 +2758,6 @@ static int __arch_prepare_bpf_trampoline(struct
bpf_tramp_image *im, void *rw_im
 			ret = -EINVAL;
 			goto cleanup;
 		}
-	} else if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
-		/* Before running the original function, load the
-		 * tail_call_cnt_ptr to rax.
-		 */
-		LOAD_TAIL_CALL_CNT_PTR(stack_size);
 	}

 	/* restore return value of orig_call or fentry prog back into RAX */


Thanks,
Leon

