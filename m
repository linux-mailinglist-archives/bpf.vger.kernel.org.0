Return-Path: <bpf+bounces-26441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD52F89F989
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 16:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564931F2B111
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 14:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625CC15F409;
	Wed, 10 Apr 2024 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4xaUd+E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4405913E3F3
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712758183; cv=none; b=ka89dqp7BZckyPPcziIYmScHpwUfAURO7AdmwL+qOUXr0vZbm5IgmriWdA+ph/nkddENOHEFCpt2DotkEakpyUJ2CiO+HJCISEw9zt7lSVjDWoV6fZZ1Zt0pBYGLbYebzOYskrgw4iyb/gPOxsCqg1IerhHpjCFdbVyTu/LiSws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712758183; c=relaxed/simple;
	bh=kGueJkBWvRlGFwiBQhbk6CSsHNjYhwlWZdYelvUKl0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DvBCUo0AVxQ6OiZCtzBOK7iyEO9WPA0UajtuXt8Nhh3v6HycPqmHJtECzwUja+nnhJjzy1iTdUorUfxvkXSDqgwbBP8yxtqCf7LS0ncMEtCFTmK2pcZ5IikJayWeiVadp9DeDvicjYM/UAAMP1FzGm00U1pclbyXuagdaru9Ofc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4xaUd+E; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-53fa455cd94so5237037a12.2
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 07:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712758181; x=1713362981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dW9Nth+VaOAL0bUv5pG/cXT7CTu/Up7meglrwkedYEY=;
        b=A4xaUd+EcvJVIlhZu6y1zpYcmOkoZaVju/RYAfQqtQcys6OPmS1wxU2zEK49CLhMu/
         T9bW+K1N3kVZM9uuEE+coIcb4kAjCPAqAQR/ktLhG6noq8NPFYw60FEp9G9QnnHmVSdY
         TLFcSduafDZWTcVganjkyHkCD8Wic0NpHnaxASi8TV8mL8EDUJl+xt+OJtfkQygREI+z
         WeRi0R/FR2lLYvdqwqRj9QbDN7CaaEhrc7MA8wRld/9asntqpsUYk5KakpWLX/Ug7Bk/
         MpUYTs8AKMneLK7a/DinqDCG1T7pWSnrNyymLDt8GEE/1z5IiVz2+iVC90YQduNkSTCk
         T4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712758181; x=1713362981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dW9Nth+VaOAL0bUv5pG/cXT7CTu/Up7meglrwkedYEY=;
        b=Tt/eHqNBb0tF+us04tFw5omkrmH6ifoToBioYtvfnUyCjIDUdMNEZGv0H4rNAlN5eJ
         THoy+rmM2o/DPsRgG1Oc7O7S/E/9hkNDdDpNkkVMMdDnbsWQd9MVxHoFPmiS+rIcBMxk
         1QjSU6mEDtVBWxikM1AEPV/sFShhWp/mDicD10U6173Zwvh9i5UBbbjHGKVFSkR/k0x0
         yEOIUMMJ44NXyMa/QhJRlLsqDxk3Lp7jgdGO+aWutd9CP4URjmy1cp6tUL6reM5yRv1v
         GO+2MNfQ7uAJH8Wcd22SbCTw5WxuTPlUsbEF6o9v3WCD92RZQ3mc4kdRj2zVMNjy5U8V
         lMFQ==
X-Gm-Message-State: AOJu0Yz3owX+sgLqBiwpORTRny0Gxjv2VP1s3swqMQZarpUjBMFQeM0f
	LAuwEO92HF9Vjd1HkU4zPhhj0mRRhSGN8dFuzuQdsCC1J4C4luaK
X-Google-Smtp-Source: AGHT+IFg2r1wGIr5cToqPOKWjL/J/uNpKFFoRp8zE40aXgdOzwIFwabZENeLPT4+afmjY5LyC+9YTw==
X-Received: by 2002:a17:90a:2d8f:b0:2a2:4040:f57b with SMTP id p15-20020a17090a2d8f00b002a24040f57bmr2783098pjd.36.1712758181233;
        Wed, 10 Apr 2024 07:09:41 -0700 (PDT)
Received: from [192.168.1.76] (bb116-14-181-187.singnet.com.sg. [116.14.181.187])
        by smtp.gmail.com with ESMTPSA id ga12-20020a17090b038c00b0029c7743cb33sm1379086pjb.40.2024.04.10.07.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 07:09:40 -0700 (PDT)
Message-ID: <6140d7a3-53c6-46ea-b812-d2f45ed2ca92@gmail.com>
Date: Wed, 10 Apr 2024 22:09:33 +0800
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
 <55442238-33d6-4e7d-9dd1-e36da20f7c90@gmail.com>
 <CAADnVQKxnEBS7JxK8YqXaa1C0kZZ=KSyPmqiE79KuZbe8Y_7YA@mail.gmail.com>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAADnVQKxnEBS7JxK8YqXaa1C0kZZ=KSyPmqiE79KuZbe8Y_7YA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/4/8 00:30, Alexei Starovoitov wrote:
> On Sun, Apr 7, 2024 at 4:34 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>>
>>
>> On 2024/4/5 09:03, Alexei Starovoitov wrote:
>>>>   * Solution changes from percpu tail_call_cnt to tail_call_cnt at task_struct.
>>>
>>> Please remind us what was wrong with per-cpu approach?
>>
>> There are some cases that the per-cpu approach cannot handle properly.
>> Especialy, on non-SMP machine, if there are many bpf progs to run with
>> tail call simultaneously, MAX_TAIL_CALL_CNT limit is unable to limit the
>> tail call expectedly.
> 
> That's not a very helpful explanation.

I apologize for my poor communication skill. I hope I can help to fix
this issue.

Why did I raise this approach, tcc in task_struct? When I tried to
figure out a better position to store tcc instead as a stack variable or
a per-cpu variable, why not store it in runtime context?
Around a tail call, the tail caller and the tail callee run on the same
thread, and the thread won't be migrated because of migrate_disable(),
if I understand correctly. As a consequence, it's better to store tcc in
thread struct or in thread local storage. In kernel, task_struct is the
thread struct, if I understand correctly. Thereafter, when multiple
progs tail_call-ing on the same cpu, the per-task tcc should limit them
independently, e.g.

   prog1     prog2
  thread1   thread2
     |         |
     |--sched->|
     |         |
     |<-sched--|
     |         |
   ---------------
        CPU1

NOTE: prog1 is diff from prog2. And they have tail call to handle while
they're scheduled.

The tcc in thread2 would not override the tcc in thread1.

When the same scenario as the above diagram shows happens to per-cpu tcc
approach, the tcc in thread2 will override the tcc in thread1. As a
result, per-cpu tcc cannot limit the tail call in thread1 and thread2
independently. This is what I concern about per-cpu tcc approach.


> Last, I recall, the concern was that tcc will be a bit off.
> The per-cpu tcc will limit recursion sooner when multiple progs
> tail_call-ing on the same cpu?

Yes.

> If so, I think it's a trade-off that should be discussed.
> tcc in task_struct will have the same issue.
> It will limit tailcalls sooner in some cases.

Could you explain one of them in details?

> 
> There were some issues with overriding of per-cpu tcc.
> The same concerns apply to per-task tcc.
> 
>>>
>>> Also notice we have pseudo per-cpu bpf insns now,
>>> so things might be easier today.
>>
>> Great to hear that. With pseudo per-cpu bpf insns, it is able to get
>> tcc_ptr from task_struct without a function call.
>>

[SNIP]

>>>>                 if (tail_call_reachable && !is_subprog)
>>>> -                       /* When it's the entry of the whole tailcall context,
>>>> -                        * zeroing rax means initialising tail_call_cnt.
>>>> +                       /* Call bpf_tail_call_cnt_init to initilise
>>>> +                        * tail_call_cnt.
>>>>                          */
>>>> -                       EMIT2(0x31, 0xC0); /* xor eax, eax */
>>>> +                       emit_call(&prog, bpf_tail_call_cnt_init,
>>>> +                                 ip + (prog - start));
>>>
>>> You're repeating the same bug we discussed before.
>>> There is nothing in bpf_tail_call_cnt_init() that
>>> prevents the compiler from scratching rdi,rsi,...
>>> bpf_tail_call_cnt_init() is a normal function from compiler pov
>>> and it's allowed to use those regs.
>>> Must have been lucky that CI is not showing crashes.
>>
>> Oh, get it. In order to prevent the compiler from scratching
>> rdi,rsi,..., the asm clobbered register list in bpf_tail_call_cnt_init()
>> must be "rdi", "rsi", "rdx", "rcx", "r8". I learn it from the GCC doc[0].
>>
>> static __used void bpf_tail_call_cnt_init(void)
>> {
>>         /* In short:
>>          * current->bpf_tail_call_cnt = 0;
>>          */
>>
>>         asm volatile (
>>             "addq " __percpu_arg(0) ", %1\n\t"
>>             "movq (%1), %1\n\t"
>>             "movl $0x0, %c2(%1)\n\t"
>>             :
>>             : "m" (__my_cpu_var(this_cpu_off)), "r" (&pcpu_hot.current_task),
>>               "i" (offsetof(struct task_struct, bpf_tail_call_cnt))
>>             : "rdi", "rsi", "rdx", "rcx", "r8" /* to avoid scratching these regs */
> 
> That will only prevent the compiler from allocating these regs
> into "r" constraint, but the compiler can still use them outside of asm.
> You need __naked too.

Got it.

> 
>>         );
>> }
>>
>> [0]
>> https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Clobbers-and-Scratch-Registers-1
>>
>>>
>>>>                 else
>>>>                         /* Keep the same instruction layout. */
>>>> -                       EMIT2(0x66, 0x90); /* nop2 */
>>>> +                       emit_nops(&prog, X86_PATCH_SIZE);
>>>>         }
>>>>         /* Exception callback receives FP as third parameter */
>>>>         if (is_exception_cb) {
>>>> @@ -452,8 +459,6 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>>>>         /* sub rsp, rounded_stack_depth */
>>>>         if (stack_depth)
>>>>                 EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8));
>>>> -       if (tail_call_reachable)
>>>> -               EMIT1(0x50);         /* push rax */
>>>>         *pprog = prog;
>>>>  }
>>>>
>>>> @@ -589,13 +594,61 @@ static void emit_return(u8 **pprog, u8 *ip)
>>>>         *pprog = prog;
>>>>  }
>>>>

[SNIP]

>>>> +       emit_call(&prog, bpf_tail_call_cnt_ptr, ip + (prog - start));
>>>
>>> same issue.
>>
>> I will rewrite it to emit_bpf_tail_call_cnt_ptr(), which will use pseudo
>> per-cpu bpf insns to get tcc_ptr from task_struct.
>>
>> static void emit_bpf_tail_call_cnt_ptr(u8 **pprog)
>> {
>>         u8 *prog = *pprog;
>>
>>         /* In short:
>>          * return &current->bpf_tail_call_cnt;
>>          */
>>
>>         /* mov rax, &pcpu_hot.current_task */
>>         EMIT3_off32(0x48, 0xC7, 0xC0, ((u32)(unsigned
>> long)&pcpu_hot.current_task));
>>
>> #ifdef CONFIG_SMP
>>         /* add rax, gs:[&this_cpu_off] */
>>         EMIT1(0x65);
>>         EMIT4_off32(0x48, 0x03, 0x04, 0x25, ((u32)(unsigned long)&this_cpu_off));
>> #endif
>>
>>         /* mov rax, qword ptr [rax] */
>>         EMIT3(0x48, 0x8B, 0x00);
>>         /* add rax, offsetof(struct task_struct, bpf_tail_call_cnt) */
>>         EMIT2_off32(0x48, 0x05, ((u32)offsetof(struct task_struct,
>> bpf_tail_call_cnt)));
>>
>>         *pprog = prog;
>> }
> 
> I think it's cleaner to use __naked func with asm volatile
> and explicit 'rax'.

Yeah. With asm volatile, these two bpf_tail_call_cnt functions are
similar. And it's easier to understand them together.

> 
> The suggestion to consider BPF_ADDR_PERCPU insn was in the context
> of generating it in the verifier, so that JITs don't need
> to do anything special with tcc.
> Like if the verifier emits tcc checks that JIT's
> emit_bpf_tail_call_[in]direct() will only deal with the actual call.
> That was a bit of an orthogonal optimization/cleanup idea.

Awesome! It's great to handle it in verifier with BPF_ADDR_PERCPU insn.

> 
>>
>>>
>>>> +       EMIT3(0x83, 0x38, MAX_TAIL_CALL_CNT);     /* cmp dword ptr [rax], MAX_TAIL_CALL_CNT */
>>>>
>>>>         offset = ctx->tail_call_indirect_label - (prog + 2 - start);
>>>>         EMIT2(X86_JAE, offset);                   /* jae out */
>>>> -       EMIT3(0x83, 0xC0, 0x01);                  /* add eax, 1 */
>>>> -       EMIT2_off32(0x89, 0x85, tcc_off);         /* mov dword ptr [rbp - tcc_off], eax */
>>>> +       EMIT2(0xFF, 0x00);                        /* inc dword ptr [rax] */
>>>>
>>>>         /* prog = array->ptrs[index]; */
>>>>         EMIT4_off32(0x48, 0x8B, 0x8C, 0xD6,       /* mov rcx, [rsi + rdx * 8 + offsetof(...)] */
>>>> @@ -663,7 +715,6 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
>>>>                         pop_r12(&prog);
>>>>         }
>>>>
>>>> -       EMIT1(0x58);                              /* pop rax */
>>>>         if (stack_depth)
>>>>                 EMIT3_off32(0x48, 0x81, 0xC4,     /* add rsp, sd */
>>>>                             round_up(stack_depth, 8));
>>>> @@ -691,21 +742,20 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
>>>>                                       bool *callee_regs_used, u32 stack_depth,
>>>>                                       struct jit_context *ctx)
>>>>  {
>>>> -       int tcc_off = -4 - round_up(stack_depth, 8);
>>>>         u8 *prog = *pprog, *start = *pprog;
>>>>         int offset;
>>>>
>>>>         /*
>>>> -        * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
>>>> +        * if ((*tcc_ptr)++ >= MAX_TAIL_CALL_CNT)
>>>>          *      goto out;
>>>>          */
>>>> -       EMIT2_off32(0x8B, 0x85, tcc_off);             /* mov eax, dword ptr [rbp - tcc_off] */
>>>> -       EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);         /* cmp eax, MAX_TAIL_CALL_CNT */
>>>> +       /* call bpf_tail_call_cnt_ptr */
>>>> +       emit_call(&prog, bpf_tail_call_cnt_ptr, ip);
>>>
>>> and here as well.
>>
>> Replace with emit_bpf_tail_call_cnt_ptr(), too.
>>
>>>
>>> pw-bot: cr
>>
>> I would like to send next version with these update.
> 
> pw-bot is a special keyword that is recognized by "patchwork bot".
> "cr" stands for "changes requested".
> It's a patch status in patchwork.
> It means that the patch will not be applied as-is.
> So it means that you have to make changes and resend.

Thanks for your explanation. Thanks for your patience.


Thanks,
Leon

