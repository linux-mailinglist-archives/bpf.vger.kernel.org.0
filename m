Return-Path: <bpf+bounces-19118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C6E825226
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 11:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD3A1F22297
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 10:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8742CCBB;
	Fri,  5 Jan 2024 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bN4KaBm6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42D9286B9
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d3e2972f65so6866795ad.3
        for <bpf@vger.kernel.org>; Fri, 05 Jan 2024 02:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704450847; x=1705055647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OYMVDYjaoPRxV8LEkB2bL8bUOeWfQNcrUnFS5jJjeAQ=;
        b=bN4KaBm64LVK5OyjbglJ3tR5X+09jsdEPQQjI9DwbV6gxWLxuHY0dwWDOdNz+Ob52w
         esEntE6T+cHI0k3EsN/bUufDqrmcqWFUOa/TkRS+4XfIDZus/OwdSuY0tWioEzNQ0jJn
         pmkflUZ6qHcEq/5R/B+IMSi0GNNjkd7Du2qiMjKnZm6FvmEKo6EvfoLshdbKE6u1vn3X
         qr7UZ5ZQuRjFgkpZJzKT0r3MMlrk6WWgGAG47qYHraCac053BNRTFokCJRgAdYkpl3Kl
         hkfwnNJaGyBclg/k+axtah4G9DFxFZL6lNRSp4aG8U3S8bzPBtw1Y67DyGYuGpYEqMIp
         AuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704450847; x=1705055647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OYMVDYjaoPRxV8LEkB2bL8bUOeWfQNcrUnFS5jJjeAQ=;
        b=JtC/gIGINIYWeFTHI8nlMHYhCfyl7b+BAKheEn23GbIcVbVTE6rA2+FqYAckqZ+Wbq
         v9z9u9G3f+vfwW2n61bCOeYZnYonfTnDivuuXV0UMdwt2TLHbZJ9fYq/juKkOTttH7KX
         PvXifGTK4U1hOKU6SomB6FEKgV0X167kdEJ/x680s2xk82dhHSJXIrOWy64rZJIANVt3
         GiADl8C2tRbFeaNaXisPioc9JQERj68r2Yc0/WMTkS6SuZLUAs3jt1QkQtoSHAgJXjWU
         EuwEtVKU5oH6yd57ja2Yt83NfmlW/eoYyxUn3PAiMsCNZysasQ9DvPcMN7DwzfEC8UtV
         wxjw==
X-Gm-Message-State: AOJu0Yy8s7xqTc7i3BvFTWNmktPUUn7lskQTtFIA9aJhvO+LzBMsqPuA
	cjXpSEmM1H5HxytOXTrYsZU=
X-Google-Smtp-Source: AGHT+IHyYhYD4+Z2kPy2mD5RET6SJD9G/ebJX1q1KjKYDmMP1XbauRXWw4As8wEqMosaboSim+ixNw==
X-Received: by 2002:a17:902:8641:b0:1d4:4623:ab6a with SMTP id y1-20020a170902864100b001d44623ab6amr1635512plt.45.1704450846981;
        Fri, 05 Jan 2024 02:34:06 -0800 (PST)
Received: from [10.22.68.80] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e80a00b001cfca7b8ee7sm1093474plg.99.2024.01.05.02.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 02:34:03 -0800 (PST)
Message-ID: <b2f808ba-56c9-4104-939a-4eed36159bd4@gmail.com>
Date: Fri, 5 Jan 2024 18:33:53 +0800
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
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAADnVQJ1szry9P00wweVDu4d0AQoM_49qT-_ueirvggAiCZrpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/1/24 12:15, Alexei Starovoitov wrote:
> On Thu, Jan 4, 2024 at 6:23 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index fe30b9ebb8de4..67fa337fc2e0c 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -259,7 +259,7 @@ struct jit_context {
>>  /* Number of bytes emit_patch() needs to generate instructions */
>>  #define X86_PATCH_SIZE         5
>>  /* Number of bytes that will be skipped on tailcall */
>> -#define X86_TAIL_CALL_OFFSET   (11 + ENDBR_INSN_SIZE)
>> +#define X86_TAIL_CALL_OFFSET   (22 + ENDBR_INSN_SIZE)
>>
>>  static void push_r12(u8 **pprog)
>>  {
>> @@ -406,14 +406,21 @@ static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
>>          */
>>         emit_nops(&prog, X86_PATCH_SIZE);
>>         if (!ebpf_from_cbpf) {
>> -               if (tail_call_reachable && !is_subprog)
>> +               if (tail_call_reachable && !is_subprog) {
>>                         /* When it's the entry of the whole tailcall context,
>>                          * zeroing rax means initialising tail_call_cnt.
>>                          */
>> -                       EMIT2(0x31, 0xC0); /* xor eax, eax */
>> -               else
>> -                       /* Keep the same instruction layout. */
>> -                       EMIT2(0x66, 0x90); /* nop2 */
>> +                       EMIT2(0x31, 0xC0);       /* xor eax, eax */
>> +                       EMIT1(0x50);             /* push rax */
>> +                       /* Make rax as ptr that points to tail_call_cnt. */
>> +                       EMIT3(0x48, 0x89, 0xE0); /* mov rax, rsp */
>> +                       EMIT1_off32(0xE8, 2);    /* call main prog */
>> +                       EMIT1(0x59);             /* pop rcx, get rid of tail_call_cnt */
>> +                       EMIT1(0xC3);             /* ret */
>> +               } else {
>> +                       /* Keep the same instruction size. */
>> +                       emit_nops(&prog, 13);
>> +               }
> 
> I'm afraid the extra call breaks stack unwinding and many other things.
> The proper frame needs to be setup (push rbp; etc)
> and 'leave' + emit_return() is used.
> Plain 'ret' is not ok.
> x86_call_depth_emit_accounting() needs to be used too.
> That will make X86_TAIL_CALL_OFFSET adjustment very complicated.
> Also the fix doesn't address the stack size issue.
> We shouldn't allow all the extra frames at run-time.
> 
> The tail_cnt_ptr approach is interesting but too heavy,
> since arm64, s390 and other JITs would need to repeat it with equally
> complicated calculations in TAIL_CALL_OFFSET.
> 
> The fix should really be thought through for all JITs. Not just x86.
> 
> I'm thinking whether we should do the following instead:
> 
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 0bdbbbeab155..0b45571559be 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -910,7 +910,7 @@ static void *prog_fd_array_get_ptr(struct bpf_map *map,
>         if (IS_ERR(prog))
>                 return prog;
> 
> -       if (!bpf_prog_map_compatible(map, prog)) {
> +       if (!bpf_prog_map_compatible(map, prog) || prog->aux->func_cnt) {
>                 bpf_prog_put(prog);
>                 return ERR_PTR(-EINVAL);
>         }
> 
> This will stop stack growth, but it will break a few existing tests.
> I feel it's a price worth paying.

I don't think this can avoid this issue completely.

For example:

#include "vmlinux.h"

#include "bpf_helpers.h"

struct {
    __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
    __uint(max_entries, 1);
    __uint(key_size, sizeof(__u32));
    __uint(value_size, sizeof(__u32));
} prog_array SEC(".maps");


static __noinline int
subprog(struct __sk_buff *skb)
{
    volatile int retval = 0;

    bpf_tail_call(skb, &prog_array, 0);

    return retval;
}

SEC("tc")
int entry(struct __sk_buff *skb)
{
    const int N = 10000;

    for (int i = 0; i < N; i++)
        subprog(skb);

    return 0;
}

char _license[] SEC("license") = "GPL";

Then, objdump its asm:

Disassembly of section .text:

0000000000000000 <subprog>:
; {
       0:       b7 02 00 00 00 00 00 00 r2 = 0x0
;     volatile int retval = 0;
       1:       63 2a fc ff 00 00 00 00 *(u32 *)(r10 - 0x4) = r2
;     bpf_tail_call(skb, &prog_array, 0);
       2:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 = 0x0 ll
       4:       b7 03 00 00 00 00 00 00 r3 = 0x0
       5:       85 00 00 00 0c 00 00 00 call 0xc
;     return retval;
       6:       61 a1 fc ff 00 00 00 00 r1 = *(u32 *)(r10 - 0x4)
       7:       95 00 00 00 00 00 00 00 exit

Disassembly of section tc:

0000000000000000 <entry>:
; {
       0:       bf 16 00 00 00 00 00 00 r6 = r1
       1:       b7 07 00 00 10 27 00 00 r7 = 0x2710

0000000000000010 <LBB0_1>:
;         subprog(skb);
       2:       bf 61 00 00 00 00 00 00 r1 = r6
       3:       85 10 00 00 ff ff ff ff call -0x1
;     for (int i = 0; i < N; i++)
       4:       07 07 00 00 ff ff ff ff r7 += -0x1
       5:       bf 71 00 00 00 00 00 00 r1 = r7
       6:       67 01 00 00 20 00 00 00 r1 <<= 0x20
       7:       77 01 00 00 20 00 00 00 r1 >>= 0x20
       8:       15 01 01 00 00 00 00 00 if r1 == 0x0 goto +0x1 <LBB0_2>
       9:       05 00 f8 ff 00 00 00 00 goto -0x8 <LBB0_1>

0000000000000050 <LBB0_2>:
;     return 0;
      10:       b7 00 00 00 00 00 00 00 r0 = 0x0
      11:       95 00 00 00 00 00 00 00 exit

As a result, the bpf prog in prog_array can be tailcalled for N times,
even though there's no subprog in the bpf prog in prog_array.

Thanks,
Leon

> 
> John, Daniel,
> 
> do you see anything breaking on cilium side if we disallow
> progs with subprogs to be inserted in prog_array ?
> 
> Other alternatives?

