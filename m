Return-Path: <bpf+bounces-16174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 797E47FDEA5
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 18:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E83A9B2101A
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 17:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAC058AD8;
	Wed, 29 Nov 2023 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dL7RL8Lx"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B5495
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 09:45:03 -0800 (PST)
Message-ID: <814656bd-ba11-44aa-8340-f1f990c3e3e7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701279901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/rnhEN1gQN9HveusTrX/t0+mKd3c3pXR2LpMK1RLoY=;
	b=dL7RL8LxZ1AfBQVZYgBz+Q52eEz5nzgJozTBL6cmaHCZzAWOnggUpZhhLlSvtraqPOFOVs
	TCMuM4cNnPDFBpv53O2GEw5MNk97GkTN41jK/O8GSEKMCeWuJ8Ma3ptnudBnDXrU481A6P
	ufdO43xX0Y0PTKPJS8LeENhFoT1HYRE=
Date: Wed, 29 Nov 2023 09:44:55 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: BPF GCC status - Nov 2023
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf <bpf@vger.kernel.org>
References: <87leahx2xh.fsf@oracle.com>
 <3733942b-f0ef-4e71-8c49-aa4177e9433c@linux.dev> <87jzq1t4sk.fsf@oracle.com>
 <a1073bd0-9df2-4a9e-900c-7e8ac63ac464@linux.dev>
 <CAADnVQJjQDQBNHZzpuBZfQdfeqGSX9_Y106PDgiY=bi-S0Wsqw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJjQDQBNHZzpuBZfQdfeqGSX9_Y106PDgiY=bi-S0Wsqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/29/23 12:01 PM, Alexei Starovoitov wrote:
> On Wed, Nov 29, 2023 at 8:44 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 11/29/23 2:08 AM, Jose E. Marchesi wrote:
>>>> On 11/28/23 11:23 AM, Jose E. Marchesi wrote:
>>>>> [During LPC 2023 we talked about improving communication between the GCC
>>>>>     BPF toolchain port and the kernel side.  This is the first periodical
>>>>>     report that we plan to publish in the GCC wiki and send to interested
>>>>>     parties.  Hopefully this will help.]
>>>>>
>>>>> GCC wiki page for the port: https://gcc.gnu.org/wiki/BPFBackEnd
>>>>> IRC channel: #gccbpf at irc.oftc.net.
>>>>> Help on using the port: gcc@gcc.gnu.org
>>>>> Patches and/or development discussions: gcc-patches@gnu.org
>>>> Thanks a lot for detailed report. Really helpful to nail down
>>>> issues facing one or both compilers. See comments below for
>>>> some mentioned issues.
>>>>
>>>>> Assembler
>>>>> =========
>>>> [...]
>>>>
>>>>> - In the Pseudo-C syntax register names are not preceded by % characters
>>>>>      nor any other prefix.  A consequence of that is that in contexts like
>>>>>      instruction operands, where both register names and expressions
>>>>>      involving symbols are expected, there is no way to disambiguate
>>>>>      between them.  GAS was allowing symbols like `w3' or `r5' in syntactic
>>>>>      contexts where no registers were expected, such as in:
>>>>>
>>>>>        r0 = w3 ll  ; GAS interpreted w3 as symbol, clang emits error
>>>>>
>>>>>      The clang assembler wasn't allowing that.  During LPC we agreed that
>>>>>      the simplest approach is to not allow any symbol to have the same name
>>>>>      than a register, in any context.  So we changed GAS so it now doesn't
>>>>>      allow to use register names as symbols in any expression, such as:
>>>>>
>>>>>        r0 = w3 + 1 ll  ; This now fails for both GAS and llvm.
>>>>>        r0 = 1 + w3 ll  ; NOTE this does not fail with llvm, but it should.
>>>> Could you provide a reproducible case above for llvm? llvm does not
>>>> support syntax like 'r0 = 1 + w3 ll'. For add, it only supports
>>>> 'r1 += r2' or 'r1 += 100' syntax.
>>> It is a 128-bit load with an expression.  In compiler explorer, clang:
>>>
>>>     int
>>>     foo ()
>>>     {
>>>       asm volatile ("r1 = 10 + w3 ll");
>>>       return 0;
>>>     }
>>>
>>> I get:
>>>
>>>     foo:                                    # @foo
>>>             r1 = 10+w3 ll
>>>             r0 = 0
>>>             exit
>>>
>>> i.e. `10 + w3' is interpreted as an expression with two operands: the
>>> literal number 10 and a symbol (not a register) `w3'.
>>>
>>> If the expression is `w3+10' instead, your parser recognizes the w3 as a
>>> register name and errors out, as expected.
>>>
>>> I suppose llvm allows to hook on the expression parser to handle
>>> individual operands.  That's how we handled this in GAS.
>> Thanks for the code. I can reproduce the result with compiler explorer.
>> The following is the link https://godbolt.org/z/GEGexf1Pj
>> where I added -grecord-gcc-switches to dump compilation flags
>> into .s file.
>>
>> The following is the compiler explorer compilation command line:
>> /opt/compiler-explorer/clang-trunk-20231129/bin/clang-18 -g -o /app/output.s \
>>     -S --target=bpf -fcolor-diagnostics -gen-reproducer=off -O2 \
>>     -g -grecord-command-line /app/example.c
>>
>> I then compile the above C code with
>>     clang -g -S --target=bpf -fcolor-diagnostics -gen-reproducer=off -O2 -g -grecord-command-line t.c
>> with identical flags.
>>
>> I tried locally with llvm16/17/18. They all failed compilation since
>> 'r1 = 10+w3 ll' cannot be recognized by the llvm.
>> We will investigate why llvm18 in compiler explorer compiles
>> differently from my local build.
> Is that a different issue from:
> https://github.com/compiler-explorer/compiler-explorer/issues/5701
> ?
Yes, it is a different one. I verified that the issue #5701 has been fixed.

