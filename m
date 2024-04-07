Return-Path: <bpf+bounces-26116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D822489B0A2
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 13:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32D5CB215A4
	for <lists+bpf@lfdr.de>; Sun,  7 Apr 2024 11:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778311E862;
	Sun,  7 Apr 2024 11:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOOwpcoB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5284322324
	for <bpf@vger.kernel.org>; Sun,  7 Apr 2024 11:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712489661; cv=none; b=b4K0pY9iwZIaaqjIo0hnSUhXTitK9ZwUcMdFMTDvYRovQr+Q57a/pIxhHeAmHmQZc5fpRz8c632wB3Z0KPSVgz3YFYFNQvvLxE/022r52+WtY9dHsi8yHd4QnnMMsgcFdqAJFE6SMtguiQ+tdH2aLJaX3sQ8FDwtG+p/Zp54+QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712489661; c=relaxed/simple;
	bh=AHrnw9OFct2hHWfMCy+l3rc7lnPnbTtqToqR7AomDW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cN+bbLHsUK3URmnP2LoKL6CrZ/+om2HM1RO6YNk2tVIElXWh1doJoKUq3lQ2wy6TBUxDgCQE8GPIXNuNPcFUq4YBlln2SGeJhcqsLDvceU1lQDpTnyPgDFCjihNRYtvlo5M+A0Gy92kTmKCqbwngVwjg7ay02X+y/T2DEeF6wDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOOwpcoB; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e74bd85f26so3175962b3a.1
        for <bpf@vger.kernel.org>; Sun, 07 Apr 2024 04:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712489658; x=1713094458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=csQdbHk4RvUHurNPLQuddPx114+b6dZSyAF6SBdgRNo=;
        b=YOOwpcoBKR352+dOKzsJvQRpUn0ZvNaerOYEqmG53mtpncTYpjUKdobmR1jpD6CPDR
         J+AWZQgsiIReJVk7To8+AxmSHWpgZGCZvvC49GS7MM1kwfgvC8KP8ttWlF/9DgqSjzau
         KZCdkuUVxzUtnIDYnL99yRFQA6zhS090XxzadX2TznWpVvWizSc/4v2FAk4fxsxz5GIW
         5RCJwVYlKqwc0RapJsQGB2Ojf5rbeZqgMMy7jwgbQDYHKewLPcKT+giMIKGCoAF3rwd2
         N8zbCElEsTZyJczNsMj9pX44qajOcbAF//EDf3CCaXvxmxzsoyGNmZcAHIunWu27iazu
         014g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712489658; x=1713094458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=csQdbHk4RvUHurNPLQuddPx114+b6dZSyAF6SBdgRNo=;
        b=tD4nJ9pUXdG69vnlnyDUnIgr+i4W5WzsvEJhF4CXA6nss+2VQjnC+2UidT3umXaCL4
         cfc7wi6nGJ77+RvbhV57bUDaBFvkHdrzDJvzFzlrwqqUHAeF6XKuBT8erlv9Y1g9+eRL
         SJDlCvJOmhUdQwUROSvO5kl1R3emfHJnDzd1A+dW2oB5erhEfITdvPnTAt9MSoYhDRPR
         jg1Em3lXqoJDIyVYBzaCbXEmF7lPpoOkMP75efTobZaWFmnvTSrTViWMjBCutHctgwCH
         ePrznjViV8pBVkAvHZmnmGNC06IVBd+4zYF/H1tPY/tb1vsTRQONypPaU6ieaslhzzZO
         LKPQ==
X-Gm-Message-State: AOJu0YwOQMBrSBgcbfAQn0QsuSyTR6iAyPdcoF4UCygkdVuBxEUraWqB
	e8Sei8tt8B5E3sUbS/+BDGxym3Z3dlSvgXZdjqHj4d+idP/yzUNS
X-Google-Smtp-Source: AGHT+IGkTGoq422RAmr6PVeynn4DNnSxHkwqpRZhwiKWpj5jUPZZrddVGdEzk6iBb6SmGwUDocwUYg==
X-Received: by 2002:a05:6a20:9792:b0:1a3:e2be:604c with SMTP id hx18-20020a056a20979200b001a3e2be604cmr4589802pzc.28.1712489658274;
        Sun, 07 Apr 2024 04:34:18 -0700 (PDT)
Received: from [192.168.1.76] (bb116-14-181-187.singnet.com.sg. [116.14.181.187])
        by smtp.gmail.com with ESMTPSA id q18-20020a170902dad200b001e25da6f2f2sm4730203plx.68.2024.04.07.04.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 04:34:17 -0700 (PDT)
Message-ID: <55442238-33d6-4e7d-9dd1-e36da20f7c90@gmail.com>
Date: Sun, 7 Apr 2024 19:34:12 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/3] bpf, x64: Fix tailcall hierarchy
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Pu Lehui <pulehui@huawei.com>,
 Hengqi Chen <hengqi.chen@gmail.com>, kernel-patches-bot@fb.com
References: <20240402152638.31377-1-hffilwlqm@gmail.com>
 <20240402152638.31377-3-hffilwlqm@gmail.com>
 <CAADnVQ+vJyi6JFsck8KbyxvOuRvmAO5gVTJPwNiyNeBwzsHu9Q@mail.gmail.com>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAADnVQ+vJyi6JFsck8KbyxvOuRvmAO5gVTJPwNiyNeBwzsHu9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/4/5 09:03, Alexei Starovoitov wrote:
>>   * Solution changes from percpu tail_call_cnt to tail_call_cnt at task_struct.
> 
> Please remind us what was wrong with per-cpu approach?

There are some cases that the per-cpu approach cannot handle properly.
Especialy, on non-SMP machine, if there are many bpf progs to run with
tail call simultaneously, MAX_TAIL_CALL_CNT limit is unable to limit the
tail call expectedly.

> 
> Also notice we have pseudo per-cpu bpf insns now,
> so things might be easier today.

Great to hear that. With pseudo per-cpu bpf insns, it is able to get
tcc_ptr from task_struct without a function call.

> 
> On Tue, Apr 2, 2024 at 8:27 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>> From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailcall
>> handling in JIT"), the tailcall on x64 works better than before.
> ...
>>
>> As a result, the previous tailcall way can be removed totally, including
>>
>> 1. "push rax" at prologue.
>> 2. load tail_call_cnt to rax before calling function.
>> 3. "pop rax" before jumping to tailcallee when tailcall.
>> 4. "push rax" and load tail_call_cnt to rax at trampoline.
> 
> Please trim it.
> It looks like you've been copy pasting it and it's no longer
> accurate.
> Short description of the problem will do.

Got it.

> 
>> Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
>> Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for x64 JIT")
>> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
>> ---
>>  arch/x86/net/bpf_jit_comp.c | 137 +++++++++++++++++++++---------------
>>  1 file changed, 81 insertions(+), 56 deletions(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 3b639d6f2f54d..cd06e02e83b64 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/bpf.h>
>>  #include <linux/memory.h>
>>  #include <linux/sort.h>
>> +#include <linux/sched.h>
>>  #include <asm/extable.h>
>>  #include <asm/ftrace.h>
>>  #include <asm/set_memory.h>
>> @@ -18,6 +19,8 @@
>>  #include <asm/text-patching.h>
>>  #include <asm/unwind.h>
>>  #include <asm/cfi.h>
>> +#include <asm/current.h>
>> +#include <asm/percpu.h>
>>
>>  static bool all_callee_regs_used[4] = {true, true, true, true};
>>
>> @@ -273,7 +276,7 @@ struct jit_context {
>>  /* Number of bytes emit_patch() needs to generate instructions */
>>  #define X86_PATCH_SIZE         5
>>  /* Number of bytes that will be skipped on tailcall */
>> -#define X86_TAIL_CALL_OFFSET   (11 + ENDBR_INSN_SIZE)
>> +#define X86_TAIL_CALL_OFFSET   (14 + ENDBR_INSN_SIZE)
>>
>>  static void push_r12(u8 **pprog)
>>  {
>> @@ -403,6 +406,9 @@ static void emit_cfi(u8 **pprog, u32 hash)
>>         *pprog = prog;
>>  }
>>
>> +static int emit_call(u8 **pprog, void *func, void *ip);
>> +static __used void bpf_tail_call_cnt_init(void);
>> +
>>  /*
>>   * Emit x86-64 prologue code for BPF program.
>>   * bpf_tail_call helper will skip the first X86_TAIL_CALL_OFFSET bytes
>> @@ -410,9 +416,9 @@ static void emit_cfi(u8 **pprog, u32 hash)
>>   */
>>  static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>>                           bool tail_call_reachable, bool is_subprog,
>> -                         bool is_exception_cb)
>> +                         bool is_exception_cb, u8 *ip)
>>  {
>> -       u8 *prog = *pprog;
>> +       u8 *prog = *pprog, *start = *pprog;
>>
>>         emit_cfi(&prog, is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash);
>>         /* BPF trampoline can be made to work without these nops,
>> @@ -421,13 +427,14 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>>         emit_nops(&prog, X86_PATCH_SIZE);
>>         if (!ebpf_from_cbpf) {
>>                 if (tail_call_reachable && !is_subprog)
>> -                       /* When it's the entry of the whole tailcall context,
>> -                        * zeroing rax means initialising tail_call_cnt.
>> +                       /* Call bpf_tail_call_cnt_init to initilise
>> +                        * tail_call_cnt.
>>                          */
>> -                       EMIT2(0x31, 0xC0); /* xor eax, eax */
>> +                       emit_call(&prog, bpf_tail_call_cnt_init,
>> +                                 ip + (prog - start));
> 
> You're repeating the same bug we discussed before.
> There is nothing in bpf_tail_call_cnt_init() that
> prevents the compiler from scratching rdi,rsi,...
> bpf_tail_call_cnt_init() is a normal function from compiler pov
> and it's allowed to use those regs.
> Must have been lucky that CI is not showing crashes.

Oh, get it. In order to prevent the compiler from scratching
rdi,rsi,..., the asm clobbered register list in bpf_tail_call_cnt_init()
must be "rdi", "rsi", "rdx", "rcx", "r8". I learn it from the GCC doc[0].

static __used void bpf_tail_call_cnt_init(void)
{
	/* In short:
	 * current->bpf_tail_call_cnt = 0;
	 */

	asm volatile (
	    "addq " __percpu_arg(0) ", %1\n\t"
	    "movq (%1), %1\n\t"
	    "movl $0x0, %c2(%1)\n\t"
	    :
	    : "m" (__my_cpu_var(this_cpu_off)), "r" (&pcpu_hot.current_task),
	      "i" (offsetof(struct task_struct, bpf_tail_call_cnt))
	    : "rdi", "rsi", "rdx", "rcx", "r8" /* to avoid scratching these regs */
	);
}

[0]
https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Clobbers-and-Scratch-Registers-1

> 
>>                 else
>>                         /* Keep the same instruction layout. */
>> -                       EMIT2(0x66, 0x90); /* nop2 */
>> +                       emit_nops(&prog, X86_PATCH_SIZE);
>>         }
>>         /* Exception callback receives FP as third parameter */
>>         if (is_exception_cb) {
>> @@ -452,8 +459,6 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>>         /* sub rsp, rounded_stack_depth */
>>         if (stack_depth)
>>                 EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8));
>> -       if (tail_call_reachable)
>> -               EMIT1(0x50);         /* push rax */
>>         *pprog = prog;
>>  }
>>
>> @@ -589,13 +594,61 @@ static void emit_return(u8 **pprog, u8 *ip)
>>         *pprog = prog;
>>  }
>>
>> +static __used void bpf_tail_call_cnt_init(void)
>> +{
>> +       /* The following asm equals to
>> +        *
>> +        * u32 *tcc_ptr = &current->bpf_tail_call_cnt;
>> +        *
>> +        * *tcc_ptr = 0;
>> +        */
>> +
>> +       asm volatile (
>> +           "addq " __percpu_arg(0) ", %1\n\t"
>> +           "addq %2, %1\n\t"
>> +           "movq (%1), %1\n\t"
>> +           "addq %3, %1\n\t"
>> +           "movl $0, (%1)\n\t"
>> +           :
>> +           : "m" (this_cpu_off), "r" (&pcpu_hot),
>> +             "i" (offsetof(struct pcpu_hot, current_task)),
>> +             "i" (offsetof(struct task_struct, bpf_tail_call_cnt))
>> +       );
>> +}
>> +
>> +static __used u32 *bpf_tail_call_cnt_ptr(void)
>> +{
>> +       u32 *tcc_ptr;
>> +
>> +       /* The following asm equals to
>> +        *
>> +        * u32 *tcc_ptr = &current->bpf_tail_call_cnt;
>> +        *
>> +        * return tcc_ptr;
>> +        */
>> +
>> +       asm volatile (
>> +           "addq " __percpu_arg(1) ", %2\n\t"
>> +           "addq %3, %2\n\t"
>> +           "movq (%2), %2\n\t"
>> +           "addq %4, %2\n\t"
>> +           "movq %2, %0\n\t"
>> +           : "=r" (tcc_ptr)
>> +           : "m" (this_cpu_off), "r" (&pcpu_hot),
>> +             "i" (offsetof(struct pcpu_hot, current_task)),
>> +             "i" (offsetof(struct task_struct, bpf_tail_call_cnt))
>> +       );
>> +
>> +       return tcc_ptr;
>> +}
>> +
>>  /*
>>   * Generate the following code:
>>   *
>>   * ... bpf_tail_call(void *ctx, struct bpf_array *array, u64 index) ...
>>   *   if (index >= array->map.max_entries)
>>   *     goto out;
>> - *   if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
>> + *   if ((*tcc_ptr)++ >= MAX_TAIL_CALL_CNT)
>>   *     goto out;
>>   *   prog = array->ptrs[index];
>>   *   if (prog == NULL)
>> @@ -608,7 +661,6 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
>>                                         u32 stack_depth, u8 *ip,
>>                                         struct jit_context *ctx)
>>  {
>> -       int tcc_off = -4 - round_up(stack_depth, 8);
>>         u8 *prog = *pprog, *start = *pprog;
>>         int offset;
>>
>> @@ -630,16 +682,16 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
>>         EMIT2(X86_JBE, offset);                   /* jbe out */
>>
>>         /*
>> -        * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
>> +        * if ((*tcc_ptr)++ >= MAX_TAIL_CALL_CNT)
>>          *      goto out;
>>          */
>> -       EMIT2_off32(0x8B, 0x85, tcc_off);         /* mov eax, dword ptr [rbp - tcc_off] */
>> -       EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL_CALL_CNT */
>> +       /* call bpf_tail_call_cnt_ptr */
>> +       emit_call(&prog, bpf_tail_call_cnt_ptr, ip + (prog - start));
> 
> same issue.

I will rewrite it to emit_bpf_tail_call_cnt_ptr(), which will use pseudo
per-cpu bpf insns to get tcc_ptr from task_struct.

static void emit_bpf_tail_call_cnt_ptr(u8 **pprog)
{
	u8 *prog = *pprog;

	/* In short:
	 * return &current->bpf_tail_call_cnt;
	 */

	/* mov rax, &pcpu_hot.current_task */
	EMIT3_off32(0x48, 0xC7, 0xC0, ((u32)(unsigned
long)&pcpu_hot.current_task));

#ifdef CONFIG_SMP
	/* add rax, gs:[&this_cpu_off] */
	EMIT1(0x65);
	EMIT4_off32(0x48, 0x03, 0x04, 0x25, ((u32)(unsigned long)&this_cpu_off));
#endif

	/* mov rax, qword ptr [rax] */
	EMIT3(0x48, 0x8B, 0x00);
	/* add rax, offsetof(struct task_struct, bpf_tail_call_cnt) */
	EMIT2_off32(0x48, 0x05, ((u32)offsetof(struct task_struct,
bpf_tail_call_cnt)));

	*pprog = prog;
}

> 
>> +       EMIT3(0x83, 0x38, MAX_TAIL_CALL_CNT);     /* cmp dword ptr [rax], MAX_TAIL_CALL_CNT */
>>
>>         offset = ctx->tail_call_indirect_label - (prog + 2 - start);
>>         EMIT2(X86_JAE, offset);                   /* jae out */
>> -       EMIT3(0x83, 0xC0, 0x01);                  /* add eax, 1 */
>> -       EMIT2_off32(0x89, 0x85, tcc_off);         /* mov dword ptr [rbp - tcc_off], eax */
>> +       EMIT2(0xFF, 0x00);                        /* inc dword ptr [rax] */
>>
>>         /* prog = array->ptrs[index]; */
>>         EMIT4_off32(0x48, 0x8B, 0x8C, 0xD6,       /* mov rcx, [rsi + rdx * 8 + offsetof(...)] */
>> @@ -663,7 +715,6 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
>>                         pop_r12(&prog);
>>         }
>>
>> -       EMIT1(0x58);                              /* pop rax */
>>         if (stack_depth)
>>                 EMIT3_off32(0x48, 0x81, 0xC4,     /* add rsp, sd */
>>                             round_up(stack_depth, 8));
>> @@ -691,21 +742,20 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
>>                                       bool *callee_regs_used, u32 stack_depth,
>>                                       struct jit_context *ctx)
>>  {
>> -       int tcc_off = -4 - round_up(stack_depth, 8);
>>         u8 *prog = *pprog, *start = *pprog;
>>         int offset;
>>
>>         /*
>> -        * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
>> +        * if ((*tcc_ptr)++ >= MAX_TAIL_CALL_CNT)
>>          *      goto out;
>>          */
>> -       EMIT2_off32(0x8B, 0x85, tcc_off);             /* mov eax, dword ptr [rbp - tcc_off] */
>> -       EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);         /* cmp eax, MAX_TAIL_CALL_CNT */
>> +       /* call bpf_tail_call_cnt_ptr */
>> +       emit_call(&prog, bpf_tail_call_cnt_ptr, ip);
> 
> and here as well.

Replace with emit_bpf_tail_call_cnt_ptr(), too.

> 
> pw-bot: cr

I would like to send next version with these update.

Thanks,
Leon

