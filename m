Return-Path: <bpf+bounces-19157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34757825DED
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 03:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CD4FB225F2
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 02:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EB7136F;
	Sat,  6 Jan 2024 02:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQ2Ki1H1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7D415A5
	for <bpf@vger.kernel.org>; Sat,  6 Jan 2024 02:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d4a980fdedso1408045ad.1
        for <bpf@vger.kernel.org>; Fri, 05 Jan 2024 18:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704508424; x=1705113224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ga3PZ5qlb2i7JPvKac2kI75tbBvsdRZu018hB095ruY=;
        b=fQ2Ki1H1udwM2nCQatpvr3/e2v9s75TygR6soNmmo8mR1ynsaHnpf/qEA3bHq0c26h
         KcFBFBMkBd476QYCJXSevxEZCz6R4Vyd3OmVSe0AHF72FYBXmlZoUBh7NGpMsYVSXWcY
         FL0xNXU0EWuLQ6BH41dTZpFvl3se5p9onoTz/gq3MqdOPE2AEkgMGdkzfJW2vxt2BWXR
         yprY1b5I3hJBWZgPY+2iaieNp0vAn7gfS3T3rPvJAx9ccLAQfjwRYg9A8A4Xjidlnn3q
         yeiiSaxGdA2cpEnu2/LkVQdPZT8B4CN3tT14JwPBTR2x1NlY7r8amRtqTskzNW/DPQZV
         T0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704508424; x=1705113224;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ga3PZ5qlb2i7JPvKac2kI75tbBvsdRZu018hB095ruY=;
        b=bgPYoR77gs+w9kuCS3fueBSbAR8PVdT6JVIHE22Q9+cJS1lxWqsv8rAP7ydVIhYJJw
         2FH9CEyUpnG3/94uX7uqI/nlOz+hEXiC9Q/eziuJH8PXqxdQTGUINDlOx4iqT/DksXzn
         Ihi0TA0+lHFXTi0iQdDWNIeXihbz+t/ob8h+3Nsu/LtsefamijWOowmL6Mwg7EZuv63F
         fISQJ2gyUREjoj5OjqhIzWSPKbUiQXUEgTFGgVnlnGozchvFbprgC/XzLa8WcI6/zQpO
         OguXoQ4E5SrVMnSEKQKK3eG5aj2eV6fTuiX1w4OV3AKBHtbx1GqzUFw30j3g861yfciM
         URPg==
X-Gm-Message-State: AOJu0YwTTy4bPCH0Z7ctMCN/HgHePcTAnJ/GIENI8kn8ud25HsvCmuvK
	fQs9Im+k+zuUoTlBvD1Nrg4=
X-Google-Smtp-Source: AGHT+IEAt2CCVxJIJelDcSLbsBf/w3kJ9HqqUnUvfz/4LqJHwJB6dwiT1UI0NF5SaAKT9bv1opf10Q==
X-Received: by 2002:a17:903:280c:b0:1d3:5fc4:f4cc with SMTP id kp12-20020a170903280c00b001d35fc4f4ccmr356495plb.29.1704508423502;
        Fri, 05 Jan 2024 18:33:43 -0800 (PST)
Received: from [192.168.1.1] (bb219-74-10-34.singnet.com.sg. [219.74.10.34])
        by smtp.gmail.com with ESMTPSA id l10-20020a17090270ca00b001d4526d0039sm2051205plt.169.2024.01.05.18.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 18:33:43 -0800 (PST)
Message-ID: <955156f4-6b0c-48c5-9167-1cf466e8cd35@gmail.com>
Date: Sat, 6 Jan 2024 10:33:39 +0800
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
 <b2f808ba-56c9-4104-939a-4eed36159bd4@gmail.com>
 <CAADnVQ+qh0KFJkmRo5NxhfHS2othCJU=q=jcPrr2pNUGSUvR6Q@mail.gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAADnVQ+qh0KFJkmRo5NxhfHS2othCJU=q=jcPrr2pNUGSUvR6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/1/6 01:47, Alexei Starovoitov wrote:
> On Fri, Jan 5, 2024 at 2:34 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
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
>>> The proper frame needs to be setup (push rbp; etc)
>>> and 'leave' + emit_return() is used.
>>> Plain 'ret' is not ok.
>>> x86_call_depth_emit_accounting() needs to be used too.
>>> That will make X86_TAIL_CALL_OFFSET adjustment very complicated.
>>> Also the fix doesn't address the stack size issue.
>>> We shouldn't allow all the extra frames at run-time.
>>>
>>> The tail_cnt_ptr approach is interesting but too heavy,
>>> since arm64, s390 and other JITs would need to repeat it with equally
>>> complicated calculations in TAIL_CALL_OFFSET.
>>>
>>> The fix should really be thought through for all JITs. Not just x86.
>>>
>>> I'm thinking whether we should do the following instead:
>>>
>>> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
>>> index 0bdbbbeab155..0b45571559be 100644
>>> --- a/kernel/bpf/arraymap.c
>>> +++ b/kernel/bpf/arraymap.c
>>> @@ -910,7 +910,7 @@ static void *prog_fd_array_get_ptr(struct bpf_map *map,
>>>         if (IS_ERR(prog))
>>>                 return prog;
>>>
>>> -       if (!bpf_prog_map_compatible(map, prog)) {
>>> +       if (!bpf_prog_map_compatible(map, prog) || prog->aux->func_cnt) {
>>>                 bpf_prog_put(prog);
>>>                 return ERR_PTR(-EINVAL);
>>>         }
>>>
>>> This will stop stack growth, but it will break a few existing tests.
>>> I feel it's a price worth paying.
>>
>> I don't think this can avoid this issue completely.
>>
>> For example:
>>
>> #include "vmlinux.h"
>>
>> #include "bpf_helpers.h"
>>
>> struct {
>>     __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>>     __uint(max_entries, 1);
>>     __uint(key_size, sizeof(__u32));
>>     __uint(value_size, sizeof(__u32));
>> } prog_array SEC(".maps");
>>
>>
>> static __noinline int
>> subprog(struct __sk_buff *skb)
>> {
>>     volatile int retval = 0;
>>
>>     bpf_tail_call(skb, &prog_array, 0);
>>
>>     return retval;
>> }
>>
>> SEC("tc")
>> int entry(struct __sk_buff *skb)
>> {
>>     const int N = 10000;
>>
>>     for (int i = 0; i < N; i++)
>>         subprog(skb);
>>
>>     return 0;
>> }
>>
>> char _license[] SEC("license") = "GPL";
>>
>> Then, objdump its asm:
>>
>> Disassembly of section .text:
>>
>> 0000000000000000 <subprog>:
>> ; {
>>        0:       b7 02 00 00 00 00 00 00 r2 = 0x0
>> ;     volatile int retval = 0;
>>        1:       63 2a fc ff 00 00 00 00 *(u32 *)(r10 - 0x4) = r2
>> ;     bpf_tail_call(skb, &prog_array, 0);
>>        2:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 = 0x0 ll
>>        4:       b7 03 00 00 00 00 00 00 r3 = 0x0
>>        5:       85 00 00 00 0c 00 00 00 call 0xc
>> ;     return retval;
>>        6:       61 a1 fc ff 00 00 00 00 r1 = *(u32 *)(r10 - 0x4)
>>        7:       95 00 00 00 00 00 00 00 exit
>>
>> Disassembly of section tc:
>>
>> 0000000000000000 <entry>:
>> ; {
>>        0:       bf 16 00 00 00 00 00 00 r6 = r1
>>        1:       b7 07 00 00 10 27 00 00 r7 = 0x2710
>>
>> 0000000000000010 <LBB0_1>:
>> ;         subprog(skb);
>>        2:       bf 61 00 00 00 00 00 00 r1 = r6
>>        3:       85 10 00 00 ff ff ff ff call -0x1
>> ;     for (int i = 0; i < N; i++)
>>        4:       07 07 00 00 ff ff ff ff r7 += -0x1
>>        5:       bf 71 00 00 00 00 00 00 r1 = r7
>>        6:       67 01 00 00 20 00 00 00 r1 <<= 0x20
>>        7:       77 01 00 00 20 00 00 00 r1 >>= 0x20
>>        8:       15 01 01 00 00 00 00 00 if r1 == 0x0 goto +0x1 <LBB0_2>
>>        9:       05 00 f8 ff 00 00 00 00 goto -0x8 <LBB0_1>
>>
>> 0000000000000050 <LBB0_2>:
>> ;     return 0;
>>       10:       b7 00 00 00 00 00 00 00 r0 = 0x0
>>       11:       95 00 00 00 00 00 00 00 exit
>>
>> As a result, the bpf prog in prog_array can be tailcalled for N times,
>> even though there's no subprog in the bpf prog in prog_array.
> 
> You mean that total execution time is N*N ?

No, it's N. There's N tailcalls in subprog() to be called in entry().

> and tailcall is a way to increase loop count?

Yes, this is a way. And MAX_TAIL_CALL_CNT limit does not work for this case.

> We allow BPF_MAX_LOOPS = 8 * 1024 * 1024 in bpf_loop,
> so many calls to subprog(skb); is not an issue
> as long as they don't stall cpu and don't increase stack size.

What if there are BPF_MAX_LOOPS subprog(skb) and there are BPF_MAX_LOOPS
loops in the tail-callee bpf prog?

Thanks,
Leon

