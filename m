Return-Path: <bpf+bounces-18542-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D055E81BA01
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 15:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B61A1C23649
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 14:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC0D360BC;
	Thu, 21 Dec 2023 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVthwV8V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA983539E8
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d7f1109abcso562742b3a.3
        for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 06:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703170613; x=1703775413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2bJT1fXpmesPNyUTInYYqxfLd4aYn3Exkz1UHz0rGa8=;
        b=fVthwV8VbdG6ma4pIxc13085O0EskxmJwEdciNvgqs83/2MyTTar9Lhq3pWxEQlVLI
         hONZNratBHG9yRGY5j6QSxFI3HqU/ANCtY/JIa3Bn8TpaDjoiAmXwX6yPG7XzhwPry1I
         8uK9MxGGcJNrjDmKfAZoLdGNGUMZWY7p9O9n/pVJLH8ITPnnJZyr+l+5FkB8NT4lugae
         BQMVbTjlYd6yEqvQJYpwbSfntsyXXfa49IiGzCc3e6UdXAZpj0p1qSvLYQzzG+4EXbZU
         2fxIkVczSvL7RgoQfWimjIV3a2+XoPm5hXO+YD1q/fBOtfYipA+f2MTx0Z3xOtKdq6Xx
         8JJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703170613; x=1703775413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bJT1fXpmesPNyUTInYYqxfLd4aYn3Exkz1UHz0rGa8=;
        b=hKpok+xJbjfHpqyF1T6R+LHr3rGiLp4Lab11q5iCfN9JEQQrseVwyBEQYY5q6mh72y
         J4hbLQEhpZ1048yTRnvwJ6HxHspUzf6jV/4Qzx744yxM0YpJOXk0gbA2rCbEX6N15aQW
         +icuZinbbq9JtRbcYX0WsztIzXkH7459Nkpvim7tERkS+tGOKG2NrzVAHq2s1rE+vUMx
         stR4SCuLwAUR4lf68CB3g0sdV3fyVbNieiBTjIxG/cLoy4KLVQ0p4tznVihGd+b7sY8J
         tvkN2sFf0cWDxT/32/DFia3lCbGyP53uqoCV14Gyj/9b98eAzTuMcB271AiYfKCY1twZ
         ETDw==
X-Gm-Message-State: AOJu0YwWDGNm2UlsAy8YkS09cX8leN8hrqPCNBpkTiT/dRCnD7Crx1sY
	n2/dcSzQToBLFXScETi8n3c=
X-Google-Smtp-Source: AGHT+IH31oeEuQKsM3vPdDv6Zu4bW4gD8wbX24bPsAtDgs5RtooerQHVmwoU2uUwvb0rEc39h246Rg==
X-Received: by 2002:aa7:9f0b:0:b0:6d2:7e5f:8c6 with SMTP id g11-20020aa79f0b000000b006d27e5f08c6mr5278636pfr.41.1703170612934;
        Thu, 21 Dec 2023 06:56:52 -0800 (PST)
Received: from [192.168.1.12] (bb219-74-10-34.singnet.com.sg. [219.74.10.34])
        by smtp.gmail.com with ESMTPSA id q20-20020aa79834000000b006d978ad1c56sm992261pfl.54.2023.12.21.06.56.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 06:56:52 -0800 (PST)
Message-ID: <41187e00-7644-4974-90c8-cd8c499b7f9e@gmail.com>
Date: Thu, 21 Dec 2023 22:56:47 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v2 2/4] bpf, x64: Fix tailcall hierarchy
Content-Language: en-US
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, jakub@cloudflare.com, iii@linux.ibm.com,
 hengqi.chen@gmail.com
References: <20231011152725.95895-1-hffilwlqm@gmail.com>
 <20231011152725.95895-3-hffilwlqm@gmail.com> <ZYQpTm9SmTkGBNI0@boxer>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <ZYQpTm9SmTkGBNI0@boxer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2023/12/21 20:02, Maciej Fijalkowski wrote:
> On Wed, Oct 11, 2023 at 11:27:23PM +0800, Leon Hwang wrote:
>> From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailcall
>> handling in JIT"), the tailcall on x64 works better than before.
>>
>> From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF subprograms
>> for x64 JIT"), tailcall is able to run in BPF subprograms on x64.
>>
>> How about:
>>
>> 1. More than 1 subprograms are called in a bpf program.
>> 2. The tailcalls in the subprograms call the bpf program.
>>
>> Because of missing tail_call_cnt back-propagation, a tailcall hierarchy
>> comes up. And MAX_TAIL_CALL_CNT limit does not work for this case.
>>
>> As we know, in tail call context, the tail_call_cnt propagates by stack
>> and rax register between BPF subprograms. So, propagating tail_call_cnt
>> pointer by stack and rax register makes tail_call_cnt as like a global
>> variable, in order to make MAX_TAIL_CALL_CNT limit works for tailcall
>> hierarchy cases.
>>
>> Before jumping to other bpf prog, load tail_call_cnt from the pointer
>> and then compare with MAX_TAIL_CALL_CNT. Finally, increment
>> tail_call_cnt by its pointer.
>>
>> But, where does tail_call_cnt store?
>>
>> It stores on the stack of bpf prog's caller, like
>>
>>     |  STACK  |
>>     |         |
>>     |   rip   |
>>  +->|   tcc   |
>>  |  |   rip   |
>>  |  |   rbp   |
>>  |  +---------+ RBP
>>  |  |         |
>>  |  |         |
>>  |  |         |
>>  +--| tcc_ptr |
>>     |   rbx   |
>>     +---------+ RSP
>>
>> And tcc_ptr is unnecessary to be popped from stack at the epilogue of bpf
>> prog, like the way of commit d207929d97ea028f ("bpf, x64: Drop "pop %rcx"
>> instruction on BPF JIT epilogue").
>>
>> Why not back-propagate tail_call_cnt?
>>
>> It's because it's vulnerable to back-propagate it. It's unable to work
>> well with the following case.
>>
>> int prog1();
>> int prog2();
>>
>> prog1 is tail caller, and prog2 is tail callee. If we do back-propagate
>> tail_call_cnt at the epilogue of prog2, can prog2 run standalone at the
>> same time? The answer is NO. Otherwise, there will be a register to be
>> polluted, which will make kernel crash.
>>
>> Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
>> Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for x64 JIT")
>> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
>> ---
>>  arch/x86/net/bpf_jit_comp.c | 40 ++++++++++++++++++++++---------------
>>  1 file changed, 24 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index c2a0465d37da4..36631129cc800 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -256,7 +256,7 @@ struct jit_context {
>>  /* Number of bytes emit_patch() needs to generate instructions */
>>  #define X86_PATCH_SIZE		5
>>  /* Number of bytes that will be skipped on tailcall */
>> -#define X86_TAIL_CALL_OFFSET	(11 + ENDBR_INSN_SIZE)
>> +#define X86_TAIL_CALL_OFFSET	(22 + ENDBR_INSN_SIZE)
>>  
>>  static void push_r12(u8 **pprog)
>>  {
>> @@ -340,14 +340,21 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>>  	EMIT_ENDBR();
>>  	emit_nops(&prog, X86_PATCH_SIZE);
>>  	if (!ebpf_from_cbpf) {
>> -		if (tail_call_reachable && !is_subprog)
>> +		if (tail_call_reachable && !is_subprog) {
>>  			/* When it's the entry of the whole tailcall context,
>>  			 * zeroing rax means initialising tail_call_cnt.
>>  			 */
>> -			EMIT2(0x31, 0xC0); /* xor eax, eax */
>> -		else
>> -			/* Keep the same instruction layout. */
>> -			EMIT2(0x66, 0x90); /* nop2 */
>> +			EMIT2(0x31, 0xC0);       /* xor eax, eax */
>> +			EMIT1(0x50);             /* push rax */
>> +			/* Make rax as ptr that points to tail_call_cnt. */
>> +			EMIT3(0x48, 0x89, 0xE0); /* mov rax, rsp */
>> +			EMIT1_off32(0xE8, 2);    /* call main prog */
>> +			EMIT1(0x59);             /* pop rcx, get rid of tail_call_cnt */
>> +			EMIT1(0xC3);             /* ret */
>> +		} else {
>> +			/* Keep the same instruction size. */
>> +			emit_nops(&prog, 13);
>> +		}
> 
> At first sight it seemed to me too invasive but after trying out few other
> approaches in the end it is elegant.
> 
> I wanted to avoid a bit puzzling call insn in the prologue with a following
> prologue layout (this will be based on entry prog from tailcall_bpf2bpf3.c that
> was the first one to break):
> 
> ffffffffc0012cb4:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> ffffffffc0012cb9:       55                      push   %rbp
> ffffffffc0012cba:       48 89 e5                mov    %rsp,%rbp
> ffffffffc0012cbd:       48 83 ec 10             sub    $0x10,%rsp
> ffffffffc0012cc1:       48 89 65 f8             mov    %rsp,-0x8(%rbp)
> ffffffffc0012cc5:       48 c7 04 24 00 00 00    movq   $0x0,(%rsp)
> ffffffffc0012ccc:       00
> ffffffffc0012ccd:       48 8b 45 f8             mov    -0x8(%rbp),%rax
> ffffffffc0012cd1:       50                      push   %rax
> ffffffffc0012cd2:       48 81 ec 80 00 00 00    sub    $0x80,%rsp
> 
> So we would have hidden 16 bytes on stack at the *beginning* of entry stack
> frame. First thing right after rbp would be tcc pointer so referring to it
> wouldn't require us to take into account stack depth. But then if we
> follow with rest of insns:
> 
> ffffffffc0012cd9:       31 f6                   xor    %esi,%esi
> ffffffffc0012cdb:       48 89 75 f8             mov    %rsi,-0x8(%rbp)  // BUG, overwrite of tcc ptr
> ffffffffc0012cdf:       48 89 75 f0             mov    %rsi,-0x10(%rbp)
> ffffffffc0012ce3:       48 89 75 e8             mov    %rsi,-0x18(%rbp)
> ffffffffc0012ce7:       48 89 75 e0             mov    %rsi,-0x20(%rbp)
> ffffffffc0012ceb:       48 89 75 d8             mov    %rsi,-0x28(%rbp)
> ffffffffc0012cef:       48 89 75 d0             mov    %rsi,-0x30(%rbp)
> ffffffffc0012cf3:       48 89 75 c8             mov    %rsi,-0x38(%rbp)
> ffffffffc0012cf7:       48 89 75 c0             mov    %rsi,-0x40(%rbp)
> ffffffffc0012cfb:       48 89 75 b8             mov    %rsi,-0x48(%rbp)
> ffffffffc0012cff:       48 89 75 b0             mov    %rsi,-0x50(%rbp)
> ffffffffc0012d03:       48 89 75 a8             mov    %rsi,-0x58(%rbp)
> ffffffffc0012d07:       48 89 75 a0             mov    %rsi,-0x60(%rbp)
> ffffffffc0012d0b:       48 89 75 98             mov    %rsi,-0x68(%rbp)
> ffffffffc0012d0f:       48 89 75 90             mov    %rsi,-0x70(%rbp)
> ffffffffc0012d13:       48 89 75 88             mov    %rsi,-0x78(%rbp)
> ffffffffc0012d17:       48 89 75 80             mov    %rsi,-0x80(%rbp)
> ffffffffc0012d1b:       48 0f b6 75 ff          movzbq -0x1(%rbp),%rsi
> ffffffffc0012d20:       40 88 75 ff             mov    %sil,-0x1(%rbp)
> ffffffffc0012d24:       48 8b 85 f8 ff ff ff    mov    -0x8(%rbp),%rax
> ffffffffc0012d2b:       e8 30 00 00 00          call   0xffffffffc0012d60
> ffffffffc0012d30:       c9                      leave
> ffffffffc0012d31:       c3                      ret
> 
> So even though it would seem more obvious while looking at prologue what
> is the intent behind it, this would require us to patch the instructions
> that make us of R10/stack, which in the end would be way more invasive.
> 
> After all, for x86 JIT code:
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Thanks for your review.

> 
> but it is a must to have a better commit message here.
> 

I'll write a better commit message here.

Thanks,
Leon

> Thanks!
> 
>>  	}
>>  	/* Exception callback receives FP as third parameter */
>>  	if (is_exception_cb) {
>> @@ -373,6 +380,7 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>>  	if (stack_depth)
>>  		EMIT3_off32(0x48, 0x81, 0xEC, round_up(stack_depth, 8));
>>  	if (tail_call_reachable)
>> +		/* Here, rax is tail_call_cnt_ptr. */
>>  		EMIT1(0x50);         /* push rax */
>>  	*pprog = prog;
>>  }
>> @@ -528,7 +536,7 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
>>  					u32 stack_depth, u8 *ip,
>>  					struct jit_context *ctx)
>>  {
>> -	int tcc_off = -4 - round_up(stack_depth, 8);
>> +	int tcc_ptr_off = -8 - round_up(stack_depth, 8);
>>  	u8 *prog = *pprog, *start = *pprog;
>>  	int offset;
>>  
>> @@ -553,13 +561,12 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
>>  	 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
>>  	 *	goto out;
>>  	 */
>> -	EMIT2_off32(0x8B, 0x85, tcc_off);         /* mov eax, dword ptr [rbp - tcc_off] */
>> -	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);     /* cmp eax, MAX_TAIL_CALL_CNT */
>> +	EMIT3_off32(0x48, 0x8B, 0x85, tcc_ptr_off); /* mov rax, qword ptr [rbp - tcc_ptr_off] */
>> +	EMIT3(0x83, 0x38, MAX_TAIL_CALL_CNT);     /* cmp dword ptr [rax], MAX_TAIL_CALL_CNT */
>>  
>>  	offset = ctx->tail_call_indirect_label - (prog + 2 - start);
>>  	EMIT2(X86_JAE, offset);                   /* jae out */
>> -	EMIT3(0x83, 0xC0, 0x01);                  /* add eax, 1 */
>> -	EMIT2_off32(0x89, 0x85, tcc_off);         /* mov dword ptr [rbp - tcc_off], eax */
>> +	EMIT3(0x83, 0x00, 0x01);                  /* add dword ptr [rax], 1 */
>>  
>>  	/* prog = array->ptrs[index]; */
>>  	EMIT4_off32(0x48, 0x8B, 0x8C, 0xD6,       /* mov rcx, [rsi + rdx * 8 + offsetof(...)] */
>> @@ -581,6 +588,7 @@ static void emit_bpf_tail_call_indirect(struct bpf_prog *bpf_prog,
>>  		pop_callee_regs(&prog, callee_regs_used);
>>  	}
>>  
>> +	/* pop tail_call_cnt_ptr */
>>  	EMIT1(0x58);                              /* pop rax */
>>  	if (stack_depth)
>>  		EMIT3_off32(0x48, 0x81, 0xC4,     /* add rsp, sd */
>> @@ -609,7 +617,7 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
>>  				      bool *callee_regs_used, u32 stack_depth,
>>  				      struct jit_context *ctx)
>>  {
>> -	int tcc_off = -4 - round_up(stack_depth, 8);
>> +	int tcc_ptr_off = -8 - round_up(stack_depth, 8);
>>  	u8 *prog = *pprog, *start = *pprog;
>>  	int offset;
>>  
>> @@ -617,13 +625,12 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
>>  	 * if (tail_call_cnt++ >= MAX_TAIL_CALL_CNT)
>>  	 *	goto out;
>>  	 */
>> -	EMIT2_off32(0x8B, 0x85, tcc_off);             /* mov eax, dword ptr [rbp - tcc_off] */
>> -	EMIT3(0x83, 0xF8, MAX_TAIL_CALL_CNT);         /* cmp eax, MAX_TAIL_CALL_CNT */
>> +	EMIT3_off32(0x48, 0x8B, 0x85, tcc_ptr_off);   /* mov rax, qword ptr [rbp - tcc_ptr_off] */
>> +	EMIT3(0x83, 0x38, MAX_TAIL_CALL_CNT);         /* cmp dword ptr [rax], MAX_TAIL_CALL_CNT */
>>  
>>  	offset = ctx->tail_call_direct_label - (prog + 2 - start);
>>  	EMIT2(X86_JAE, offset);                       /* jae out */
>> -	EMIT3(0x83, 0xC0, 0x01);                      /* add eax, 1 */
>> -	EMIT2_off32(0x89, 0x85, tcc_off);             /* mov dword ptr [rbp - tcc_off], eax */
>> +	EMIT3(0x83, 0x00, 0x01);                      /* add dword ptr [rax], 1 */
>>  
>>  	poke->tailcall_bypass = ip + (prog - start);
>>  	poke->adj_off = X86_TAIL_CALL_OFFSET;
>> @@ -640,6 +647,7 @@ static void emit_bpf_tail_call_direct(struct bpf_prog *bpf_prog,
>>  		pop_callee_regs(&prog, callee_regs_used);
>>  	}
>>  
>> +	/* pop tail_call_cnt_ptr */
>>  	EMIT1(0x58);                                  /* pop rax */
>>  	if (stack_depth)
>>  		EMIT3_off32(0x48, 0x81, 0xC4, round_up(stack_depth, 8));
>> -- 
>> 2.41.0
>>
>>

