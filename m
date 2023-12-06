Return-Path: <bpf+bounces-16854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97C08067C7
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 07:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187071C21137
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 06:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056E112B6A;
	Wed,  6 Dec 2023 06:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKCfP0Bg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED00D40
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 22:51:33 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6ce7c1b07e1so963412b3a.2
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 22:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701845492; x=1702450292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=12LlbwNI7dE8ECdDBVsUSYIcKCDjkooqiSmizmFjh0o=;
        b=dKCfP0BgX77mVoKGPy61HOHIJyRsqrS2Bg+hsoBm5MkJkKNGKi8bukqlBRE8qSoMuc
         cZq2ZBCCu2pgFC1v5/6dMG1QcF1eq17tThtj0Hl/tGfXz8LqvJ3+yH6eeklGws8lQaLe
         LWX/sXaBVWQKusMvM/mJg3NgE6R3xdnomSg1crtap30gUIJYi0wVsNXFf0RmKHv4Hqyv
         1qxSMLwGDvjFtGzNGtuxzA1hC27wFamaLvshcXHR7toquEmliqXvLq7vusUQNMGaLHVI
         sGIo62emptTTHwGtNquHsxxGdybKrDBDWyMVU2ivRvgrndrn/m8BHCAyLl1rnibStz5M
         e9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701845492; x=1702450292;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12LlbwNI7dE8ECdDBVsUSYIcKCDjkooqiSmizmFjh0o=;
        b=oFl6s3k/G9km2oGCIwsoe7ZKCZi/upUZB51UosYbMJYYUroSEDeMYJDJa7hBjF9mEa
         eCYYYdThSl8a6LSpk7WmJscS5qiZy5CdZsnedRaDcjCuV1qOsimko6M8POy4V/bo23GK
         +L7oelVlUrXy6OzDBz3lQOZAH2616537f+b1A5BLoyPhyS0IKJqiqqHews/3hN5DAbcD
         70YzhdOrIXz7lbIw2/QnD7iq5+xhx2/twAzN9aXWwH0XAddMuSEHwophzWERVpbBZ9AV
         8Ev7gQfSGwJIlhOPwY+jUKbc0nMTVJtfFUB+I6CiZ8FChte21BDM0jzBYT5hfVMDL3v6
         Hr2Q==
X-Gm-Message-State: AOJu0YzeCmxJArwlf1j/kuYCs+D28++bP/jDKv+b7i/SJRNHtC2DaZox
	8p4bhjzDXO6Sa+Tv8KLvfHc=
X-Google-Smtp-Source: AGHT+IE/NHKfaUWk2vYOjCWgJcioHORuOD+dRcke4kvBjlZAc1GBa33DwI6aZ8SEnyDD3lxtGGQmxw==
X-Received: by 2002:a05:6a20:4284:b0:18c:f42c:d558 with SMTP id o4-20020a056a20428400b0018cf42cd558mr624197pzj.28.1701845492414;
        Tue, 05 Dec 2023 22:51:32 -0800 (PST)
Received: from [10.22.68.68] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id 20-20020a170902c25400b001cfc170c0cfsm7496793plg.119.2023.12.05.22.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 22:51:31 -0800 (PST)
Message-ID: <d144dda7-a90c-4a40-9caa-a48c0e7e7fae@gmail.com>
Date: Wed, 6 Dec 2023 14:51:28 +0800
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
 <20231011152725.95895-3-hffilwlqm@gmail.com> <ZW+sNudwg5Bc0Gbl@boxer>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <ZW+sNudwg5Bc0Gbl@boxer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/12/23 07:03, Maciej Fijalkowski wrote:
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
> 
> Sorry but I keep on reading this explanation and I'm lost what is being
> fixed here> 
> You want to limit the total amount of tail calls that entry prog can do to
> MAX_TAIL_CALL_CNT. Although I was working on that, my knowledge here is
> rusty, therefore my view might be distorted :) to me MAX_TAIL_CALL_CNT is
> to protect us from overflowing kernel stack and endless loops. As long a
> single call chain doesn't go over 8kB program is fine. Verifier has a
> limit of 256 subprogs from what I see.

I try to resolve the following-like cases here.

          +--------- tailcall --+
          |                     |
          V       --> subprog1 -+
 entry bpf prog <
          A       --> subprog2 -+
          |                     |
          +--------- tailcall --+

Without this fixing, the CPU will be stalled because of too many tailcalls.

> 
> Can you elaborate a bit more about the kernel crash you mention in the
> last paragraph?

We have progs, prog1, prog2, prog3 and prog4, and the scenario:

case1: kprobe1 --> prog1 --> subprog1 --tailcall-> prog2 --> subprog2 --tailcall-> prog3
case2: kprobe2 --> prog2 --> subprog2 --tailcall-> prog3
case3: kprobe3 --> prog4 --> subprog3 --tailcall-> prog3
                         --> subprog4 --tailcall-> prog4

How does prog2 back-propagate tail_call_cnt to prog1?

Possible way 1:
When prog2 and prog3 are added to PROG_ARRAY, poke their epilogues to
back-propagate tail_call_cnt by RCX register. It seems OK because kprobes do
not handle the value in RCX register, like case2.

Possible way 2:
Can back-propagate tail_call_cnt with RCX register by checking tail_call_cnt != 0
at epilogue when current prog has tailcall?
No. As for case1, prog2 handles the value in RCX register, which is not tail_call_cnt,
because prog3 has no tailcall and won't populate RCX register with tail_call_cnt.

However, I don't like the back-propagating way. Then, I "burn" my brain to figure
out pointer propagating ways.

RFC PATCH v1 way:
Propagate tail_call_cnt and its pointer together. Then, the pointer is used to
check MAX_TAIL_CALL_CNT and increment tail_call_cnt.

    |  STACK  |
    +---------+ RBP
    |         |
    |         |
    |         |
 +--| tcc_ptr |
 +->|   tcc   |
    |   rbx   |
    +---------+ RSP

RFC PATCH v2 way (current patchset):
Propagate tail_call_cnt pointer only. Then, the pointer is used to check
MAX_TAIL_CALL_CNT and increment tail_call_cnt.

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

> 
> I also realized that verifier assumes MAX_TAIL_CALL_CNT as 32 which has
> changed in the meantime to 33 and we should adjust the max allowed stack
> depth of subprogs? I believe this was brought up at LPC?

There's following code snippet in verifier.c:

	/* protect against potential stack overflow that might happen when
	 * bpf2bpf calls get combined with tailcalls. Limit the caller's stack
	 * depth for such case down to 256 so that the worst case scenario
	 * would result in 8k stack size (32 which is tailcall limit * 256 =
	 * 8k).

But, MAX_TAIL_CALL_CNT is 33.

This was not brought up at LPC 2022&2023. I don't know whether this was
brought up at previous LPCs.

Thanks,
Leon

