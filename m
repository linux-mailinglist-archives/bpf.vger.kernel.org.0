Return-Path: <bpf+bounces-7830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E080277D0FE
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 19:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151431C20D4E
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 17:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD45615ACA;
	Tue, 15 Aug 2023 17:29:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F3D156F7
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 17:29:08 +0000 (UTC)
Received: from out-58.mta1.migadu.com (out-58.mta1.migadu.com [IPv6:2001:41d0:203:375::3a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDF21BD1
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 10:29:06 -0700 (PDT)
Message-ID: <13d32d42-0924-5533-8407-e4cbc9ee117f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692120543; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97Hh2iTO5trvF1wj3lFd4DwLC3YM/hSy3kXnTHRAdUc=;
	b=d8weqmgk+2MXcv6jXvWHasMubrbdSVKoEJs6rfTWl4FHc/Xq5/IWLSiMTGzjHMLg935C2s
	HVcgufZcrS+G0PS3SvgzpiLRKDdelIFZmSLzXwRhfV0H3fUvKiK4Y8hkEO9HC2OHUtixof
	a085H1JPQtGekmrQZgJ+MMBdVzvG7eE=
Date: Tue, 15 Aug 2023 10:28:58 -0700
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <87leec44v1.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/15/23 10:01 AM, Jose E. Marchesi wrote:
> 
>> On 8/15/23 7:19 AM, Jose E. Marchesi wrote:
>>> Hello.
>>> The selftest progs/verifier_masking.c contains inline assembly code
>>> like:
>>>     	w1 = 0xffffffff;
>>> The 32-bit immediate of that instruction is signed.  Therefore, GAS
>>> complains that the above instruction overflows its field:
>>>     /tmp/ccNOXFQy.s:46: Error: signed immediate out of range, shall
>>> fit in 32 bits
>>> The llvm assembler is likely relying on signed overflow for the
>>> above to
>>> work.
>>
>> Not really.
>>
>>    def _ri_32 : ALU_RI<BPF_ALU, Opc, off,
>>                     (outs GPR32:$dst),
>>                     (ins GPR32:$src2, i32imm:$imm),
>>                     "$dst "#OpcodeStr#" $imm",
>>                     [(set GPR32:$dst, (OpNode GPR32:$src2,
>>                     i32immSExt32:$imm))]>;
>>
>>
>> If generating from source, the pattern [(set GPR32:$dst, (OpNode
>> GPR32:$src2, i32immSExt32:$imm))] so value 0xffffffff is not SExt32
>> and it won't match and eventually a LDimm_64 insn will be generated.
> 
> If by "generating from source" you mean compiling from C, then sure, I
> wasn't implying clang was generating `r1 = 0xffffffff' for assigning
> that positive value to a register.
> 
>> But for inline asm, we will have
>>    (outs GPR32:$dst)
>>    (ins GPR32:$src2, i32imm:$imm)
>>
>> and i32imm is defined as
>>    def i32imm : Operand<i32>;
>> which is a unsigned 32bit value, so it is recognized properly
>> and the insn is encoded properly.
> 
> We thought the imm32 operand in ALU instructions is signed, not
> unsigned.  Is it really unsigned??

The 'i32' in LLVM just represents a 4-byte value, there is no
signed-ness attached, which I interpret it as unsigned.
See below example,

$ cat t.c
int a;
unsigned b;
long c;
long add1() { return a + c; }
long add2() { return b + c; }
$ clang --target=bpf -O2 -S -emit-llvm t.c
$ cat t.ll
; ModuleID = 't.c'
source_filename = "t.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

@a = dso_local local_unnamed_addr global i32 0, align 4
@c = dso_local local_unnamed_addr global i64 0, align 8
@b = dso_local local_unnamed_addr global i32 0, align 4

; Function Attrs: mustprogress nofree norecurse nosync nounwind 
willreturn memory(read, argmem: none, inaccessiblemem: none)
define dso_local i64 @add1() local_unnamed_addr #0 {
entry:
   %0 = load i32, ptr @a, align 4, !tbaa !3
   %conv = sext i32 %0 to i64
   %1 = load i64, ptr @c, align 8, !tbaa !7
   %add = add nsw i64 %1, %conv
   ret i64 %add
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind 
willreturn memory(read, argmem: none, inaccessiblemem: none)
define dso_local i64 @add2() local_unnamed_addr #0 {
entry:
   %0 = load i32, ptr @b, align 4, !tbaa !3
   %conv = zext i32 %0 to i64
   %1 = load i64, ptr @c, align 8, !tbaa !7
   %add = add nsw i64 %1, %conv
   ret i64 %add
}

You can see global variables 'a', 'b' and 'c' are defined
as 'i32' and 'i64' respectively. The signed/unsigned-ness is
used during IR code generation.

> 
>>> Using negative numbers to denote masks is ugly and obfuscating (for
>>> non-obvious cases like -1/0xffffffff) so I suggest we introduce a
>>> pseudo-op so we can do:
>>>      w1 = %mask(0xffffffff)
>>
>> I changed above
>>    w1 = 0xffffffff;
>> to
>>    w1 = %mask(0xffffffff)
>> and hit the following compilation failure.
>>
>> progs/verifier_masking.c:54:9: error: invalid % escape in inline
>> assembly string
>>     53 |         asm volatile ("                                 \
>>        |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     54 |         w1 = %mask(0xffffffff);                         \
>>        |                ^
>> 1 error generated.
>>
>> Do you have documentation what is '%mask' thing?
> 
> It doesn't exist.
> 
> I am suggesting to add support for that pseudo-op to the BPF assemblers:
> both GAS and the llvm BPF assembler.
> 
>>> allowing the assembler to do the right thing (TM) converting and
>>> checking that the mask is valid and not relying on UB.
>>> Thoughts?
>>>

