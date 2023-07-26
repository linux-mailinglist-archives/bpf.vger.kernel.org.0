Return-Path: <bpf+bounces-5905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BE0762A30
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 06:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E4D2819F8
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 04:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1105C5384;
	Wed, 26 Jul 2023 04:16:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C341855
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 04:16:57 +0000 (UTC)
Received: from out-12.mta1.migadu.com (out-12.mta1.migadu.com [95.215.58.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBA265B5
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 21:16:35 -0700 (PDT)
Message-ID: <d10ca36d-7ae6-90bf-8c2a-671cafe8f5fb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690344973; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pfh19pvhpDcZIg7CGnlCyAvBxtdH6lvwM9FBte46oBE=;
	b=gjs1VtD83bdBcIisuUBjmX4rnpoRq4bugvIbWRgyx74cySOL0rkJS1+M/zScFo15e81dO/
	8i4rJbWWP7BbbQI3HrJ35Hj5Em3yi21AH2kneddMR5jAMa9pA7Z3pgM/ES3gVvYqOdDh1B
	p+MqgriKzffabamGygZebS7MCAKC0NA=
Date: Tue, 25 Jul 2023 21:16:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: Register encoding in assembly for load/store instructions
To: Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Yonghong Song <yhs@meta.com>, bpf <bpf@vger.kernel.org>
References: <87ila7dhmp.fsf@oracle.com>
 <5e6b7c30-eba4-31ca-e0ac-1e21f4c9d8aa@linux.dev> <87o7jzbz0z.fsf@oracle.com>
 <146bc14b-e15c-6e62-1fa0-4e9e67c974c9@linux.dev> <87zg3jah2s.fsf@oracle.com>
 <6a102de2-2bd4-6933-e901-de00cda10045@linux.dev> <87v8e78w63.fsf@oracle.com>
 <CAADnVQLDGUSSCkhxjgt6bxxN7hOh7L-86-wzESp2Oo8SQ91hOg@mail.gmail.com>
 <a1371ac96bdca45a07366868d331410a9836204e.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <a1371ac96bdca45a07366868d331410a9836204e.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/25/23 5:39 PM, Eduard Zingerman wrote:
> On Tue, 2023-07-25 at 17:31 -0700, Alexei Starovoitov wrote:
>> On Tue, Jul 25, 2023 at 3:28 PM Jose E. Marchesi
>> <jose.marchesi@oracle.com> wrote:
>>>
>>>
>>>> On 7/25/23 1:09 PM, Jose E. Marchesi wrote:
>>>>>
>>>>>> On 7/25/23 11:56 AM, Jose E. Marchesi wrote:
>>>>>>>
>>>>>>>> On 7/25/23 10:29 AM, Jose E. Marchesi wrote:
>>>>>>>>> Hello Yonghong.
>>>>>>>>> We have noticed that the llvm disassembler uses different notations
>>>>>>>>> for
>>>>>>>>> registers in load and store instructions, depending somehow on the width
>>>>>>>>> of the data being loaded or stored.
>>>>>>>>> For example, this is an excerpt from the assembler-disassembler.s
>>>>>>>>> test
>>>>>>>>> file in llvm:
>>>>>>>>>       // Note: For the group below w1 is used as a destination for
>>>>>>>>> sizes u8, u16, u32.
>>>>>>>>>       //       This is disassembler quirk, but is technically not wrong, as there are
>>>>>>>>>       //       no different encodings for 'r1 = load' vs 'w1 = load'.
>>>>>>>>>       //
>>>>>>>>>       // CHECK: 71 21 2a 00 00 00 00 00   w1 = *(u8 *)(r2 + 0x2a)
>>>>>>>>>       // CHECK: 69 21 2a 00 00 00 00 00   w1 = *(u16 *)(r2 + 0x2a)
>>>>>>>>>       // CHECK: 61 21 2a 00 00 00 00 00   w1 = *(u32 *)(r2 + 0x2a)
>>>>>>>>>       // CHECK: 79 21 2a 00 00 00 00 00   r1 = *(u64 *)(r2 + 0x2a)
>>>>>>>>>       r1 = *(u8*)(r2 + 42)
>>>>>>>>>       r1 = *(u16*)(r2 + 42)
>>>>>>>>>       r1 = *(u32*)(r2 + 42)
>>>>>>>>>       r1 = *(u64*)(r2 + 42)
>>>>>>>>> The comment there clarifies that the usage of wN instead of rN in
>>>>>>>>> the
>>>>>>>>> u8, u16 and u32 cases is a "disassembler quirk".
>>>>>>>>> Anyway, the problem is that it seems that `clang -S' actually emits
>>>>>>>>> these forms with wN.
>>>>>>>>> Is that intended?
>>>>>>>>
>>>>>>>> Yes, this is intended since alu32 mode is enabled where
>>>>>>>> w* registers are used for 8/16/32 bit load.
>>>>>>> So then why suppporting 'r1 = 8948 8*9r2 + 0x2a)'?  The mode is
>>>>>>> still
>>>>>>> alu32 mode.  Isn't the u{8,16,32} part enough to discriminate?
>>>>>>
>>>>>> What does this 'r1 = 8948 8*9r2 + 0x2a)' mean?
>>>>>>
>>>>>> For u8/u16/u32 loads, if objdump with option to indicate alu32 mode,
>>>>>> then w* register is used. If no alu32 mode for objdump, then r* register
>>>>>> is used. Basically the same insn, disasm is different depending on
>>>>>> alu32 mode or not. u8/u16/u32 is not enough to differentiate.
>>>>> Ok, so the llvm objdump has a switch that tells when to use rN or wN
>>>>> when printing these particular instructions.  Thats the "disassembler
>>>>> quirk".  To what purpose?  Isnt the person passing the command line
>>>>> switch the same person reading the disassembled program?  Is this "alu32
>>>>> mode" more than a cosmetic thing?
>>>>> But what concern us is the assembler, not the disassembler.
>>>>> clang -S (which is not objdump) seems to generate these instructions
>>>>> with wN (see https://godbolt.org/z/5G433Yvrb for a store instruction for
>>>>> example) and we assume the output of clang -S is intended to be passed
>>>>> to an assembler, much like with gcc -S.
>>>>> So, should we support both syntaxes as _input_ syntax in the
>>>>> assembler?
>>>>
>>>> Considering -mcpu=v3 is recommended cpu flavor (at least in bpf mailing
>>>> list), and -mcpu=v3 has alu32 enabled by default. So I think
>>>> gcc can start to emit insn assuming alu32 mode is on by default.
>>>> So
>>>>     w1 = *(u8 *)(r2 + 42)
>>>> is preferred.
>>>
>>> We have V4 by default now.  So we can emit
>>>
>>>    w1 = *(u8 *)(r2 + 42)
>>>
>>> when -mcpu is v3 or higher, or if -malu32 is specified, and
>>>
>>>    r1 = *(u8 *)(r2 + 42)
>>>
>>> when -mcpu is v2 or lower, or if -mnoalu32 is specified.
>>>
>>> Sounds good?
>>>
>>> However this implies that the assembler should indeed recognize both
>>> forms of instructions.  But note that it will assembly them to the
>>> exactly same encoded instruction.  This includes inline asm (remember
>>> GCC does not have an integrated assembler.)
>>
>> Good point.
>> I think we made a mistake in clang.
>> We shouldn't be printing
>> w1 = *(u8 *)(r2 + 42)
>> since such instruction doesn't exist in BPF ISA
>> and it's confusing.
>> There is only one instruction:
>> r1 = *(u8 *)(r2 + 42)
>> which is an 8-bit load that zero extends into 64-bit.
>> x86 JIT actually implements it as 8-bit load that stores
>> into a 32-bit subregister, so it kinda matches w1,
>> but that's an implementation detail of the JIT.
>>
>> I think both gcc and clang should always print r1 = *(u8 *)(r2 + 42)
>> regardless of alu32 or not.
>> In gas and clang assembler we can support both w1= and r1=
>> flavors for backward compat.
>>
> 
> I agree with Alexei (the ... disassembler quirk ... comment is left by me :).
> Can dig into clang part of things if this is a consensus.

For disassembler, we have stx as well may use w* registers with alu32.
In llvm BPFDisassembler.cpp, we have

   if ((InstClass == BPF_LDX || InstClass == BPF_STX) &&
       getInstSize(Insn) != BPF_DW &&
       (InstMode == BPF_MEM || InstMode == BPF_ATOMIC) &&
       STI.hasFeature(BPF::ALU32))
     Result = decodeInstruction(DecoderTableBPFALU3264, Instr, Insn, 
Address,
                                this, STI);
   else
     Result = decodeInstruction(DecoderTableBPF64, Instr, Insn, Address, 
this,
                                STI);

Maybe we should just do

   Result = decodeInstruction(DecoderTableBPF64, Instr, Insn, Address, 
this, STI);

So we already disassemble based on non-alu32 mode?


