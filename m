Return-Path: <bpf+bounces-8003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4EF77FCD0
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 19:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96AF282151
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 17:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A00C171CD;
	Thu, 17 Aug 2023 17:14:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219CC168D5
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 17:14:53 +0000 (UTC)
Received: from out-36.mta0.migadu.com (out-36.mta0.migadu.com [91.218.175.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE7311F
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 10:14:51 -0700 (PDT)
Message-ID: <83e093b1-97ec-14e3-56ee-8258eea66709@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692292489; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LMcKi0ydrStm13N45Zfx32zYgsLEq16LOM/fjnId+is=;
	b=wxv92e1EMmBhgkk6Ol9hKrxFRKkZm28a3dOH6ysvGcivYhN1LZn+IlPPHJLrZ2RhuG1KY0
	SXwYmu+Ghre6qgrHmsP82BQzYcTpC71rrwywBKQ3oF9NxVncd/8cIcI9ByoeGz8a82owB+
	06Bzidv5nZ1zgqcT+Iew0EeT1xnGIiI=
Date: Thu, 17 Aug 2023 10:14:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: Masks and overflow of signed immediates in BPF instructions
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com
References: <877cpwgzgh.fsf@oracle.com>
 <ab4264da-7c73-e7c5-334d-ed61c9fdd241@linux.dev> <87leec44v1.fsf@oracle.com>
 <87wmxv2ut4.fsf@oracle.com> <bbd86b4e-89ea-8e60-883e-f348117483b4@linux.dev>
 <878raa14rc.fsf@oracle.com> <92974205-730f-4815-1eda-f8ee8217d8dc@linux.dev>
In-Reply-To: <92974205-730f-4815-1eda-f8ee8217d8dc@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/17/23 9:23 AM, Yonghong Song wrote:
> 
> 
> On 8/17/23 1:01 AM, Jose E. Marchesi wrote:
>>
>>> [...]
>>> In llvm, for inline asm, 0xfffffffe, 4294967294 and -2 have the same
>>> 4-byte bit-wise encoding, so they will be all encoded the same
>>> 0xfffffffe in the actual insn.
>>>
>>> The following is an example for x86 target in llvm:
>>>
>>> $ cat t.c
>>> int foo() {
>>>    int a, b;
>>>
>>>    asm volatile("movl $0xfffffffe, %0" : "=r"(a) :);
>>>    asm volatile("movl $-2, %0" : "=r"(b) :);
>>>    return a + b;
>>> }
>>> $ clang -O2 -c t.c
>>> $ llvm-objdump -d t.o
>>>
>>> t.o:    file format elf64-x86-64
>>>
>>> Disassembly of section .text:
>>>
>>> 0000000000000000 <foo>:
>>>         0: b9 fe ff ff ff                movl    $0xfffffffe, %ecx #
>>>        imm = 0xFFFFFFFE
>>>         5: b8 fe ff ff ff                movl    $0xfffffffe, %eax #
>>>        imm = 0xFFFFFFFE
>>>         a: 01 c8                         addl    %ecx, %eax
>>>         c: c3                            retq
>>> $
>>>
>>> Whether it is 0xfffffffe or -2, the insn encoding is the same
>>> and disasm prints out 0xfffffffe.
>>
>> Thanks for the explanation.
>>
>> I have pushed the commit below to binutils that makes GAS match the llvm
>> assembler behavior regarding constant immediates.  With this patch there
>> are no more assembler errors when building the kernel bpf selftests.
> 
> Great! Thanks.
> 
>>
>> Note however that there is one pending divergence in the behavior of
>> both assemblers when facing invalid programs where immediate operands
>> cannot be represented in the number of bits of the field like in:
>>
>>    $ cat foo.s
>>    if r1 > r2 goto 0x3fff1
>>
>> llvm silently truncates it to 16-bit:
>>
>>    $ clang -target bpf foo.s
>>    $ bpf-unkonwn-none-objdump -M pseudoc -dr foo.o
>>    0000000000000000 <.text>:
>>       0:    2d 21 f1 ff 00 00 00 00     if r1>r2 goto -15
>>
>> GAS emits an error instead:
>>
>>    $ as -mdialect=pseudoc foo.s
>>    foo.s: Assembler messages:
>>    foo.s:1: Error: pc-relative offset out of range, shall fit in 16 bits.
>>
>> (The same happens with 32-bit immediates.)
>>
>> We think the error is pertinent, and we recommend the llvm assembler to
>> behave the same way.
> 
> Thanks! We will take a look at this issue soon.

A patch like below can issue the warning for the above case:

diff --git a/llvm/lib/Target/BPF/MCTargetDesc/BPFMCCodeEmitter.cpp 
b/llvm/lib/Target/BPF/MCTargetDesc/BPFMCCodeEmitter.cpp
index 420a2aad480a..fca6bf30fb4b 100644
--- a/llvm/lib/Target/BPF/MCTargetDesc/BPFMCCodeEmitter.cpp
+++ b/llvm/lib/Target/BPF/MCTargetDesc/BPFMCCodeEmitter.cpp
@@ -136,6 +136,12 @@ void BPFMCCodeEmitter::encodeInstruction(const 
MCInst &MI,
      OSE.write<uint16_t>(0);
      OSE.write<uint32_t>(Imm >> 32);
    } else {
+    if (Opcode == BPF::JUGT_rr) {
+      const MCOperand &MO = MI.getOperand(2);
+      int64_t Imm = MO.isImm() ? MO.getImm() : 0;
+      if (Imm > INT16_MAX || Imm < INT16_MIN)
+        report_fatal_error("Branch target out of insn range");
+    }
      // Get instruction encoding and emit it
      uint64_t Value = getBinaryCodeForInstr(MI, Fixups, STI);
      CB.push_back(Value >> 56);

Need to generalize to other related conditional/unconditional
operands. Will have a formal patch for llvm soon.

Thanks.

