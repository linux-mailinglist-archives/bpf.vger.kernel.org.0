Return-Path: <bpf+bounces-7999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3456677FC04
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 18:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2269A1C214B9
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 16:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4521643F;
	Thu, 17 Aug 2023 16:24:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF77F14011
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 16:24:53 +0000 (UTC)
Received: from out-45.mta1.migadu.com (out-45.mta1.migadu.com [IPv6:2001:41d0:203:375::2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC3C358D
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 09:24:11 -0700 (PDT)
Message-ID: <92974205-730f-4815-1eda-f8ee8217d8dc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692289432; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HPd5nuSFkX5hd+cHl4jhlYU35258HQuKqCxmfQo3vi8=;
	b=Ee78VPD1ew4eHdPtMsGuOkU9M2GtVbBv34+OGYCeA5QJkarxXXgPEHwLvEyn1N3AWZokuP
	Hl+2uB3rzP9RBpBEO+ZYQLlXRaek1zF1AKWrxf2u2zhWz0Lvm4NjAGCPw0/VdH1vG2sy2j
	LluKFMajoHxWTv1nQBZ8eaFPUs99qio=
Date: Thu, 17 Aug 2023 09:23:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: Masks and overflow of signed immediates in BPF instructions
Content-Language: en-US
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com
References: <877cpwgzgh.fsf@oracle.com>
 <ab4264da-7c73-e7c5-334d-ed61c9fdd241@linux.dev> <87leec44v1.fsf@oracle.com>
 <87wmxv2ut4.fsf@oracle.com> <bbd86b4e-89ea-8e60-883e-f348117483b4@linux.dev>
 <878raa14rc.fsf@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <878raa14rc.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/17/23 1:01 AM, Jose E. Marchesi wrote:
> 
>> [...]
>> In llvm, for inline asm, 0xfffffffe, 4294967294 and -2 have the same
>> 4-byte bit-wise encoding, so they will be all encoded the same
>> 0xfffffffe in the actual insn.
>>
>> The following is an example for x86 target in llvm:
>>
>> $ cat t.c
>> int foo() {
>>    int a, b;
>>
>>    asm volatile("movl $0xfffffffe, %0" : "=r"(a) :);
>>    asm volatile("movl $-2, %0" : "=r"(b) :);
>>    return a + b;
>> }
>> $ clang -O2 -c t.c
>> $ llvm-objdump -d t.o
>>
>> t.o:    file format elf64-x86-64
>>
>> Disassembly of section .text:
>>
>> 0000000000000000 <foo>:
>>         0: b9 fe ff ff ff                movl    $0xfffffffe, %ecx #
>>        imm = 0xFFFFFFFE
>>         5: b8 fe ff ff ff                movl    $0xfffffffe, %eax #
>>        imm = 0xFFFFFFFE
>>         a: 01 c8                         addl    %ecx, %eax
>>         c: c3                            retq
>> $
>>
>> Whether it is 0xfffffffe or -2, the insn encoding is the same
>> and disasm prints out 0xfffffffe.
> 
> Thanks for the explanation.
> 
> I have pushed the commit below to binutils that makes GAS match the llvm
> assembler behavior regarding constant immediates.  With this patch there
> are no more assembler errors when building the kernel bpf selftests.

Great! Thanks.

> 
> Note however that there is one pending divergence in the behavior of
> both assemblers when facing invalid programs where immediate operands
> cannot be represented in the number of bits of the field like in:
> 
>    $ cat foo.s
>    if r1 > r2 goto 0x3fff1
> 
> llvm silently truncates it to 16-bit:
> 
>    $ clang -target bpf foo.s
>    $ bpf-unkonwn-none-objdump -M pseudoc -dr foo.o
>    0000000000000000 <.text>:
>       0:	2d 21 f1 ff 00 00 00 00 	if r1>r2 goto -15
> 
> GAS emits an error instead:
> 
>    $ as -mdialect=pseudoc foo.s
>    foo.s: Assembler messages:
>    foo.s:1: Error: pc-relative offset out of range, shall fit in 16 bits.
> 
> (The same happens with 32-bit immediates.)
> 
> We think the error is pertinent, and we recommend the llvm assembler to
> behave the same way.

Thanks! We will take a look at this issue soon.

