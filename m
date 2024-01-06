Return-Path: <bpf+bounces-19159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50404825DF3
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 03:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740081C23746
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 02:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE1715AB;
	Sat,  6 Jan 2024 02:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="by2uOLxl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA0F136F
	for <bpf@vger.kernel.org>; Sat,  6 Jan 2024 02:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3606e15d718so1251525ab.1
        for <bpf@vger.kernel.org>; Fri, 05 Jan 2024 18:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704508698; x=1705113498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9pTSJvtgK9fzYVJafKGoAjt6MEEwj5RzUgUXTN7Vv0=;
        b=by2uOLxljEMvcQkw5OwCXljlNDdlzIN+37HIjt9Dya6CwpoIjtppBpn3qf1PIT3z7Y
         58BJuxDTkHegiT6KwoRaGD4cdkLlBAHlQ7qYgk4y8GWcrpCEOyxZC6MmfTph2ofhcipy
         dARseMWVTwX5KEnGutXaykYipJhu2DV+3sw6s8m+nYBCYqFPp8cz1taB0KNwcPAR3IRN
         OcP68Eb8pVy61pRdiuzPEqnSpbXaWGUlTFQuVG2XHjtPuNdO+AYZ3nok32iZ6IBOb+LW
         H7VpNvmd9rcLH4Epy3SNXplYYzSwdKcj94jz2x57Afp5boBCfCGoitg7tnrQXwNkZNoq
         +3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704508698; x=1705113498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9pTSJvtgK9fzYVJafKGoAjt6MEEwj5RzUgUXTN7Vv0=;
        b=Rbm+5Jqx3wpslKiVeGvhobdPcub7UZp0GLyAP0rCJnJOWXZf9xyRaZEmeEsTtAvM6M
         cRbqlZrgHivOVGmIHFLQBgYWoSvF06LmftvNesLQ6DYNHitc5P1rQwGRbKn17qYGDDIZ
         +KDaDRZ+mck2IQikt0LwN6Pc2Nb9N2Hz6B7PiPXW6PDbR0fG1LnWjKI3Ct3V4jC/7NRM
         579JVV+Q9EhZTeiQm3ZNg2mt6II3mdrrJekbvHAT1Sn8RuVwRNc9F6fb1u9nw7WaIRH8
         cMDpxUIhkFb4PtWHsSCD9+oxoRQtHZSk+jic+n0ijzJv6jcAlYaF8L3mIbtyw83e9LRF
         fhVg==
X-Gm-Message-State: AOJu0YzNUcDOqIhbWaf7nA+KkM2+rQUVzjlpgsEJ/IJzgDMqayynNs4r
	dAgsDLozN9OrsCL6g8tEd08=
X-Google-Smtp-Source: AGHT+IGHXqyqlRwdZK9t33nethu8r4HPuJZqKz60pbBqgUi3hCx9c5r51UHzctgfP8Tomfhd/fabnQ==
X-Received: by 2002:a05:6e02:1e02:b0:35d:5995:1d74 with SMTP id g2-20020a056e021e0200b0035d59951d74mr725692ila.57.1704508697813;
        Fri, 05 Jan 2024 18:38:17 -0800 (PST)
Received: from [192.168.1.1] (bb219-74-10-34.singnet.com.sg. [219.74.10.34])
        by smtp.gmail.com with ESMTPSA id jb1-20020a170903258100b001d2e958e34bsm2076298plb.159.2024.01.05.18.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 18:38:17 -0800 (PST)
Message-ID: <856e001b-f8a6-4b80-929f-f6839053a9aa@gmail.com>
Date: Sat, 6 Jan 2024 10:38:13 +0800
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
 <43499e38-f395-4efd-867f-8a2fa0571ecd@gmail.com>
 <CAADnVQLhxem1m5Nfkf7GhDKRcYaD+g9k3ZW_BD6t58OACr3fQg@mail.gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAADnVQLhxem1m5Nfkf7GhDKRcYaD+g9k3ZW_BD6t58OACr3fQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/1/6 01:43, Alexei Starovoitov wrote:
> On Thu, Jan 4, 2024 at 10:16 PM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>>
>>
>> On 5/1/24 12:15, Alexei Starovoitov wrote:
>>> On Thu, Jan 4, 2024 at 6:23 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>>>
>>>>
>>>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>>>> index fe30b9ebb8de4..67fa337fc2e0c 100644
>>>> --- a/arch/x86/net/bpf_jit_comp.c
>>>> +++ b/arch/x86/net/bpf_jit_comp.c
>>>> @@ -259,7 +259,7 @@ struct jit_context {
>>>>  /* Number of bytes emit_patch() needs to generate instructions */
>>>>  #define X86_PATCH_SIZE         5
>>>>  /* Number of bytes that will be skipped on tailcall */
>>>> -#define X86_TAIL_CALL_OFFSET   (11 + ENDBR_INSN_SIZE)
>>>> +#define X86_TAIL_CALL_OFFSET   (22 + ENDBR_INSN_SIZE)
>>>>
>>>>  static void push_r12(u8 **pprog)
>>>>  {
>>>> @@ -406,14 +406,21 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>>>>          */
>>>>         emit_nops(&prog, X86_PATCH_SIZE);
>>>>         if (!ebpf_from_cbpf) {
>>>> -               if (tail_call_reachable && !is_subprog)
>>>> +               if (tail_call_reachable && !is_subprog) {
>>>>                         /* When it's the entry of the whole tailcall context,
>>>>                          * zeroing rax means initialising tail_call_cnt.
>>>>                          */
>>>> -                       EMIT2(0x31, 0xC0); /* xor eax, eax */
>>>> -               else
>>>> -                       /* Keep the same instruction layout. */
>>>> -                       EMIT2(0x66, 0x90); /* nop2 */
>>>> +                       EMIT2(0x31, 0xC0);       /* xor eax, eax */
>>>> +                       EMIT1(0x50);             /* push rax */
>>>> +                       /* Make rax as ptr that points to tail_call_cnt. */
>>>> +                       EMIT3(0x48, 0x89, 0xE0); /* mov rax, rsp */
>>>> +                       EMIT1_off32(0xE8, 2);    /* call main prog */
>>>> +                       EMIT1(0x59);             /* pop rcx, get rid of tail_call_cnt */
>>>> +                       EMIT1(0xC3);             /* ret */
>>>> +               } else {
>>>> +                       /* Keep the same instruction size. */
>>>> +                       emit_nops(&prog, 13);
>>>> +               }
>>>
>>> I'm afraid the extra call breaks stack unwinding and many other things.
>>
>> I was worried about it. But I'm not sure how it breaks stack unwinding.
>>
>> However, without the extra call, I've tried another approach:
>>
>> * [RFC PATCH bpf-next 1/3] bpf, x64: Fix tailcall hierarchy
>>   https://lore.kernel.org/bpf/20231005145814.83122-2-hffilwlqm@gmail.com/
>>
>> It's to propagate tail_call_cnt_ptr, too. But more complicated:
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 8c10d9abc..001c5e4b7 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -313,24 +332,15 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>>                           bool tail_call_reachable, bool is_subprog,
>>                           bool is_exception_cb)
>>  {
>> +       int tcc_ptr_off = round_up(stack_depth, 8) + 8;
>> +       int tcc_off = tcc_ptr_off + 8;
>>         u8 *prog = *pprog;
>>
>>         /* BPF trampoline can be made to work without these nops,
>>          * but let's waste 5 bytes for now and optimize later
>>          */
>>         EMIT_ENDBR();
>> -       memcpy(prog, x86_nops[5], X86_PATCH_SIZE);
>> -       prog += X86_PATCH_SIZE;
>> -       if (!ebpf_from_cbpf) {
>> -               if (tail_call_reachable && !is_subprog)
>> -                       /* When it's the entry of the whole tailcall context,
>> -                        * zeroing rax means initialising tail_call_cnt.
>> -                        */
>> -                       EMIT2(0x31, 0xC0); /* xor eax, eax */
>> -               else
>> -                       /* Keep the same instruction layout. */
>> -                       EMIT2(0x66, 0x90); /* nop2 */
>> -       }
>> +       emit_nops(&prog, X86_PATCH_SIZE);
>>         /* Exception callback receives FP as third parameter */
>>         if (is_exception_cb) {
>>                 EMIT3(0x48, 0x89, 0xF4); /* mov rsp, rsi */
>> @@ -347,15 +357,52 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>>                 EMIT1(0x55);             /* push rbp */
>>                 EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
>>         }
>> +       if (!ebpf_from_cbpf) {
>> +               if (tail_call_reachable && !is_subprog) {
>> +                       /* Make rax as ptr that points to tail_call_cnt. */
>> +                       EMIT3(0x48, 0x89, 0xE8);          /* mov rax, rbp */
>> +                       EMIT2_off32(0x48, 0x2D, tcc_off); /* sub rax, tcc_off */
>> +                       /* When it's the entry of the whole tail call context,
>> +                        * storing 0 means initialising tail_call_cnt.
>> +                        */
>> +                       EMIT2_off32(0xC7, 0x00, 0);       /* mov dword ptr [rax], 0 */
>> +               } else {
>> +                       /* Keep the same instruction layout. */
>> +                       emit_nops(&prog, 3);
>> +                       emit_nops(&prog, 6);
>> +                       emit_nops(&prog, 6);
> 
> Extra 15 nops in the prologue of every bpf program (tailcall or not)
> is too high a price to pay.
> 
> Think of a simple fix other on verifier side or
> simple approach that all JITs can easily do.

It's not easy but I'll have a hard try.

Thanks,
Leon

