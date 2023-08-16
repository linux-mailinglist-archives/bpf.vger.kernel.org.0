Return-Path: <bpf+bounces-7912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA1377E640
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 18:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC63281AFE
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 16:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C15916432;
	Wed, 16 Aug 2023 16:22:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF37156E8
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 16:22:18 +0000 (UTC)
Received: from out-30.mta0.migadu.com (out-30.mta0.migadu.com [91.218.175.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057642711
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 09:22:16 -0700 (PDT)
Message-ID: <bbd86b4e-89ea-8e60-883e-f348117483b4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692202933; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pe266H6yLoZFPljTbXhxvPbLZcJenRDQ7MYvn3RPzL8=;
	b=OJUcKpHlMNTfKEyOrzJZyK2AiNdJ8Lur50Zi6qK4cl5teKPYBdncLbuS/keif1DpLFi7rD
	A7fE5s8z2+UL8wtxblG141xy7G7mDbLdqGb9aaJkjpvd3qmh8kPii658X0g46dWl52/5/N
	DonJk5PkOdZxrVFEgLv9JX3THwDNgwQ=
Date: Wed, 16 Aug 2023 09:22:09 -0700
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
 <87wmxv2ut4.fsf@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <87wmxv2ut4.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/16/23 2:36 AM, Jose E. Marchesi wrote:
> 
>>> On 8/15/23 7:19 AM, Jose E. Marchesi wrote:
>>>> Hello.
>>>> The selftest progs/verifier_masking.c contains inline assembly code
>>>> like:
>>>>     	w1 = 0xffffffff;
>>>> The 32-bit immediate of that instruction is signed.  Therefore, GAS
>>>> complains that the above instruction overflows its field:
>>>>     /tmp/ccNOXFQy.s:46: Error: signed immediate out of range, shall
>>>> fit in 32 bits
>>>> The llvm assembler is likely relying on signed overflow for the
>>>> above to
>>>> work.
>>>
>>> Not really.
>>>
>>>    def _ri_32 : ALU_RI<BPF_ALU, Opc, off,
>>>                     (outs GPR32:$dst),
>>>                     (ins GPR32:$src2, i32imm:$imm),
>>>                     "$dst "#OpcodeStr#" $imm",
>>>                     [(set GPR32:$dst, (OpNode GPR32:$src2,
>>>                     i32immSExt32:$imm))]>;
>>>
>>>
>>> If generating from source, the pattern [(set GPR32:$dst, (OpNode
>>> GPR32:$src2, i32immSExt32:$imm))] so value 0xffffffff is not SExt32
>>> and it won't match and eventually a LDimm_64 insn will be generated.
>>
>> If by "generating from source" you mean compiling from C, then sure, I
>> wasn't implying clang was generating `r1 = 0xffffffff' for assigning
>> that positive value to a register.
>>
>>> But for inline asm, we will have
>>>    (outs GPR32:$dst)
>>>    (ins GPR32:$src2, i32imm:$imm)
>>>
>>> and i32imm is defined as
>>>    def i32imm : Operand<i32>;
>>> which is a unsigned 32bit value, so it is recognized properly
>>> and the insn is encoded properly.
>>
>> We thought the imm32 operand in ALU instructions is signed, not
>> unsigned.  Is it really unsigned??
> 
> I am going through all the BPF instructions that get 32-bit, 16-bit and
> 64-bit immediates, because it seems to me that we may need to
> distinguish between two different levels:
> 
> - Value encoded in the instruction immediate: interpreted as signed or
>    as unsigned.

The 'imm' in the instruction is a 32-bit signed insn.
I think we have no dispute here.

> 
> - How the assembler interprets a written number for the corresponding
>    instruction operand: for example, for which instructions the assemler
>    shall accept 0xfffffffe and 4294967294 and -2 all to denote the same
>    value, what value is it (negative or positive) or shall it emit an
>    overflow error.

In llvm, for inline asm, 0xfffffffe, 4294967294 and -2 have the same
4-byte bit-wise encoding, so they will be all encoded the same
0xfffffffe in the actual insn.

The following is an example for x86 target in llvm:

$ cat t.c
int foo() {
   int a, b;

   asm volatile("movl $0xfffffffe, %0" : "=r"(a) :);
   asm volatile("movl $-2, %0" : "=r"(b) :);
   return a + b;
}
$ clang -O2 -c t.c
$ llvm-objdump -d t.o

t.o:    file format elf64-x86-64

Disassembly of section .text:

0000000000000000 <foo>:
        0: b9 fe ff ff ff                movl    $0xfffffffe, %ecx 
# imm = 0xFFFFFFFE
        5: b8 fe ff ff ff                movl    $0xfffffffe, %eax 
# imm = 0xFFFFFFFE
        a: 01 c8                         addl    %ecx, %eax
        c: c3                            retq
$

Whether it is 0xfffffffe or -2, the insn encoding is the same
and disasm prints out 0xfffffffe.

> 
> Will follow up with a summary that hopefully will serve to clarify this.
> 
>>>> Using negative numbers to denote masks is ugly and obfuscating (for
>>>> non-obvious cases like -1/0xffffffff) so I suggest we introduce a
>>>> pseudo-op so we can do:
>>>>      w1 = %mask(0xffffffff)
>>>
>>> I changed above
>>>    w1 = 0xffffffff;
>>> to
>>>    w1 = %mask(0xffffffff)
>>> and hit the following compilation failure.
>>>
>>> progs/verifier_masking.c:54:9: error: invalid % escape in inline
>>> assembly string
>>>     53 |         asm volatile ("                                 \
>>>        |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>     54 |         w1 = %mask(0xffffffff);                         \
>>>        |                ^
>>> 1 error generated.
>>>
>>> Do you have documentation what is '%mask' thing?
>>
>> It doesn't exist.
>>
>> I am suggesting to add support for that pseudo-op to the BPF assemblers:
>> both GAS and the llvm BPF assembler.
>>
>>>> allowing the assembler to do the right thing (TM) converting and
>>>> checking that the mask is valid and not relying on UB.
>>>> Thoughts?
>>>>

