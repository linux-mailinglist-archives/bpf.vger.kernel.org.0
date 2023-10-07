Return-Path: <bpf+bounces-11598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2257A7BC4EA
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 07:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9784282303
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 05:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9420F6FA5;
	Sat,  7 Oct 2023 05:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYUAqzKx"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492726ABC
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 05:51:06 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7EBE9
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 22:51:04 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c737d61a00so22844275ad.3
        for <bpf@vger.kernel.org>; Fri, 06 Oct 2023 22:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696657864; x=1697262664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tqXDcnkG+CZb6KOOyqD5lQV6fF0K5BgmaWwxyFcCjzk=;
        b=DYUAqzKx4cOVc2aEy2g5UGyhuX6UBuptZBMVT+rsj1+qMWs4+OcgP2eFjR4GKa3QEL
         Vcl8Q519E9k+QqIvYkJTUF33K6XywSA6rcfa89bQiFFvEAvm5vAvPZ+JAO3MTWbPbiBP
         AY4oZKwAZ4KGOY+6SOwgWZKYybbH+T416gdxrTw7ZqJsO/aHmNmh4JH4kxfzIUByRExO
         fBKoCM2BTX4RXsgwJ06TfFjlV1kcAJ1phmj05yJJsjNG+9EpUJnEcMTJWPbViqGfr8qU
         DyFcxb8ikM0jG14w4QPMMjjYK/VWW3pIzFkW3ELCQKT4IykT9Z502qwQn+NJu0SysQKQ
         pKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696657864; x=1697262664;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tqXDcnkG+CZb6KOOyqD5lQV6fF0K5BgmaWwxyFcCjzk=;
        b=F+6kAqrt0+Kt1TYK2nXUYInpiwhL6XRn6V9MbWlLmCZJLRl01OAkF+tHkVljTjr2jm
         8k3c1YNM399ZSCDnu7SOdQrtksJaED8Gu/Y7QX7bYSEmLe2M9+BvEZaaqSWD/Gh4Zp6T
         hu/vlYl9rcSePk5DHQxlJbUp521HKyUihfcr79ap1Tk3RHMvoT9Ms8AaDarGx8exAqWu
         J8SZUsMCfvwv9L0P/ULnzUJr/AKG/sS6sU4SkfD6TLI9/iT9ezIThWCm08VoHHnHic+g
         9tr5oKKOyFIxkbAjdZxwKJvlsaWUlq6ezOAn1R1B4ROyvjuzEK6wwMe95bMeQeMwjhXn
         Htww==
X-Gm-Message-State: AOJu0YwZgmLbMLF/6d4X42T3PRr+wzJ9AeQVav7MADLIswPgEMBjnMJb
	eSWxFkvqQjW0rY4tAXiCfBs=
X-Google-Smtp-Source: AGHT+IF2HM4UhG4qcajSzm6gvlAyAObPDJQUNLd8HSjMl8paY8U+JINsQXb3lkGDmv6esUtj0aBqIg==
X-Received: by 2002:a17:903:456:b0:1c4:4c73:94e6 with SMTP id iw22-20020a170903045600b001c44c7394e6mr9438534plb.51.1696657863625;
        Fri, 06 Oct 2023 22:51:03 -0700 (PDT)
Received: from [192.168.1.12] (bb119-74-148-123.singnet.com.sg. [119.74.148.123])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902d38c00b001b9d335223csm4949362pld.26.2023.10.06.22.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 22:51:03 -0700 (PDT)
Message-ID: <3448eb23-7adb-67bd-1571-46e1ae98c3cc@gmail.com>
Date: Sat, 7 Oct 2023 13:50:59 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH bpf-next 1/3] bpf, x64: Fix tailcall hierarchy
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, maciej.fijalkowski@intel.com, jakub@cloudflare.com,
 iii@linux.ibm.com, hengqi.chen@gmail.com
References: <20231005145814.83122-1-hffilwlqm@gmail.com>
 <20231005145814.83122-2-hffilwlqm@gmail.com> <ZR763xGlqqu2gb41@google.com>
 <787e2f5e-41b3-0793-97e3-a6566c2b34bf@gmail.com>
 <CAKH8qBtjbEdCVyHr7seTFYcgNRF_uzGW761GVH-5Q81=HuLGuw@mail.gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAKH8qBtjbEdCVyHr7seTFYcgNRF_uzGW761GVH-5Q81=HuLGuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/10/7 00:44, Stanislav Fomichev wrote:
> On Thu, Oct 5, 2023 at 6:43 PM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>>
>>
>> On 6/10/23 02:05, Stanislav Fomichev wrote:
>>> On 10/05, Leon Hwang wrote:
>>>> From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and tailcall
>>>> handling in JIT"), the tailcall on x64 works better than before.
>>>>
>>>> From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF subprograms
>>>> for x64 JIT"), tailcall is able to run in BPF subprograms on x64.
>>>>
>>>> How about:
>>>>
>>>> 1. More than 1 subprograms are called in a bpf program.
>>>> 2. The tailcalls in the subprograms call the bpf program.
>>>>
>>>> Because of missing tail_call_cnt back-propagation, a tailcall hierarchy
>>>> comes up. And MAX_TAIL_CALL_CNT limit does not work for this case.
>>>>
>>>> As we know, in tail call context, the tail_call_cnt propagates by stack
>>>> and rax register between BPF subprograms. So, propagating tail_call_cnt
>>>> pointer by stack and rax register makes tail_call_cnt as like a global
>>>> variable, in order to make MAX_TAIL_CALL_CNT limit works for tailcall
>>>> hierarchy cases.
>>>>
>>>> Before jumping to other bpf prog, load tail_call_cnt from the pointer
>>>> and then compare with MAX_TAIL_CALL_CNT. Finally, increment
>>>> tail_call_cnt by the pointer.
>>>>
>>>> But, where does tail_call_cnt store?
>>>>
>>>> It stores on the stack of uppest-hierarchy-layer bpf prog, like
>>>>
>>>>  |  STACK  |
>>>>  +---------+ RBP
>>>>  |         |
>>>>  |         |
>>>>  |         |
>>>>  | tcc_ptr |
>>>>  |   tcc   |
>>>>  |   rbx   |
>>>>  +---------+ RSP
>>>>
>>>> Why not back-propagate tail_call_cnt?
>>>>
>>>> It's because it's vulnerable to back-propagate it. It's unable to work
>>>> well with the following case.
>>>>
>>>> int prog1();
>>>> int prog2();
>>>>
>>>> prog1 is tail caller, and prog2 is tail callee. If we do back-propagate
>>>> tail_call_cnt at the epilogue of prog2, can prog2 run standalone at the
>>>> same time? The answer is NO. Otherwise, there will be a register to be
>>>> polluted, which will make kernel crash.
>>>>
>>>> Can tail_call_cnt store at other place instead of the stack of bpf prog?
>>>>
>>>> I'm not able to infer a better place to store tail_call_cnt. It's not a
>>>> working inference to store it at ctx or on the stack of bpf prog's
>>>> caller.
>>>>
>>>> Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
>>>> Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for x64 JIT")
>>>> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
>>>> ---
>>>>  arch/x86/net/bpf_jit_comp.c | 120 +++++++++++++++++++++++-------------
>>>>  1 file changed, 76 insertions(+), 44 deletions(-)
>>>>
>>>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>>>> index 8c10d9abc2394..8ad6368353c2b 100644
>>>> --- a/arch/x86/net/bpf_jit_comp.c
>>>> +++ b/arch/x86/net/bpf_jit_comp.c
>>>> @@ -256,7 +256,7 @@ struct jit_context {
>>>>  /* Number of bytes emit_patch() needs to generate instructions */
>>>>  #define X86_PATCH_SIZE              5
>>>>  /* Number of bytes that will be skipped on tailcall */
>>>> -#define X86_TAIL_CALL_OFFSET        (11 + ENDBR_INSN_SIZE)
>>>> +#define X86_TAIL_CALL_OFFSET        (24 + ENDBR_INSN_SIZE)
>>>>
>>>>  static void push_r12(u8 **pprog)
>>>>  {
>>>> @@ -304,6 +304,25 @@ static void pop_callee_regs(u8 **pprog, bool *callee_regs_used)
>>>>      *pprog = prog;
>>>>  }
>>>>
>>>
>>> [..]
>>>
>>>> +static void emit_nops(u8 **pprog, int len)
>>>> +{
>>>> +    u8 *prog = *pprog;
>>>> +    int i, noplen;
>>>> +
>>>> +    while (len > 0) {
>>>> +            noplen = len;
>>>> +
>>>> +            if (noplen > ASM_NOP_MAX)
>>>> +                    noplen = ASM_NOP_MAX;
>>>> +
>>>> +            for (i = 0; i < noplen; i++)
>>>> +                    EMIT1(x86_nops[noplen][i]);
>>>> +            len -= noplen;
>>>> +    }
>>>> +
>>>> +    *pprog = prog;
>>>> +}
>>>
>>> From high level - makes sense to me.
>>> I'll leave a thorough review to the people who understand more :-)
>>> I see Maciej commenting on your original "Fix tailcall infinite loop"
>>> series.
>>
>> Welcome for your review.
>>
>>>
>>> One suggestion I have is: the changes to 'memcpy(prog, x86_nops[5],
>>> X86_PATCH_SIZE);' and this emit_nops move here don't seem like
>>> they actually belong to this patch. Maybe do them separately?
>>
>> Moving emit_nops here is for them:
>>
>> +                       /* Keep the same instruction layout. */
>> +                       emit_nops(&prog, 3);
>> +                       emit_nops(&prog, 6);
>> +                       emit_nops(&prog, 6);
>>
>> and do the changes to 'memcpy(prog, x86_nops[5], X86_PATCH_SIZE);' BTW.
> 
> Right, I'm saying that you can do the move + replace memcpy in a
> separate (first) patch to make the patch with the actual changes a bit
> smaller.
> But that's not strictly required, up to you.

LGTM

Thanks,
Leon

