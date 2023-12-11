Return-Path: <bpf+bounces-17459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D366B80DD90
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 22:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 882B2282593
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 21:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE74F54FAF;
	Mon, 11 Dec 2023 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tCZk2pKI"
X-Original-To: bpf@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [IPv6:2001:41d0:1004:224b::bb])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D3DBD
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 13:51:36 -0800 (PST)
Message-ID: <3589068d-7787-4584-8911-e57c380dd09b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702331495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Hd9tzpTEiB98dtJ76G+3rP/uiO0wEN2vqbWcu4+uF8=;
	b=tCZk2pKIHrTCJTRT23ibYB7Q2mUEdQLPwcbQpdTsnXIvEJlRoWLMIWmh3M834AfW4mc4oU
	zLkZ2UJJ9gRQa4xUHYL/y2nzmUX4HwfROtsLSBaDh9Oax2YgIc4PoSpkIob9xZAhulSC1G
	u6D6qomg3rTyfusjRhQnQxTkBlJFwDc=
Date: Mon, 11 Dec 2023 13:51:27 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 6/7] libbpf: BPF Static Keys support
Content-Language: en-GB
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev
 <sdf@google.com>, bpf <bpf@vger.kernel.org>
References: <20231206141030.1478753-7-aspsk@isovalent.com>
 <CAADnVQ+BRbJN1A9_fjDTXh0=VM5x6oGVgtcB1JB7K8TM5+6i5Q@mail.gmail.com>
 <ZXNCB5sEendzNj6+@zh-lab-node-5>
 <CAEf4Bzai9X2xQGjEOZvkSkx7ZB9CSSk4oTxoksTVSBoEvR4UsA@mail.gmail.com>
 <CAADnVQJtWVE9+rA2232P4g7ktUJ_+Nfwo+MYpv=6p7+Z9J20hw@mail.gmail.com>
 <bef79c65-e89a-4219-8c8b-750c60e1f2b4@linux.dev>
 <CAADnVQJd1aUFzznLhwNvkN+zot-u3=4A16utY93HoLJrP_vo3w@mail.gmail.com>
 <85aa91f9-d5c0-4e7b-950d-475da7787f64@linux.dev>
 <CAADnVQKZjmwxo0cBiHcp3FkAAmJT850qQJ5_=fAhfOKniJM2Kw@mail.gmail.com>
 <3682c649-6a6a-4f66-b4fa-fbcbb774ae94@linux.dev>
 <ZXdHc7xoAVf1g4a9@zh-lab-node-5>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ZXdHc7xoAVf1g4a9@zh-lab-node-5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 12/11/23 9:31 AM, Anton Protopopov wrote:
> On Sat, Dec 09, 2023 at 10:32:42PM -0800, Yonghong Song wrote:
>> On 12/9/23 9:18 AM, Alexei Starovoitov wrote:
>>> On Fri, Dec 8, 2023 at 9:05 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>> On 12/8/23 8:25 PM, Alexei Starovoitov wrote:
>>>>> On Fri, Dec 8, 2023 at 8:15 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>>>> On 12/8/23 8:05 PM, Alexei Starovoitov wrote:
>>>>>>> On Fri, Dec 8, 2023 at 2:04 PM Andrii Nakryiko
>>>>>>> <andrii.nakryiko@gmail.com> wrote:
>>>>>>>> I feel like embedding some sort of ID inside the instruction is very..
>>>>>>>> unusual, shall we say?
>>>>>>> yeah. no magic numbers inside insns pls.
>>>>>>>
>>>>>>> I don't like JA_CFG name, since I read CFG as control flow graph,
>>>>>>> while you probably meant CFG as configurable.
>>>>>>> How about BPF_JA_OR_NOP ?
>>>>>>> Then in combination with BPF_JMP or BPF_JMP32 modifier
>>>>>>> the insn->off|imm will be used.
>>>>>>> 1st bit in src_reg can indicate the default action: nop or jmp.
>>>>>>> In asm it may look like asm("goto_or_nop +5")
>>>>>> How does the C source code looks like in order to generate
>>>>>> BPF_JA_OR_NOP insn? Any source examples?
>>>>> It will be in inline asm only. The address of that insn will
>>>>> be taken either via && or via asm (".long %l[label]").
>>>>>    From llvm pov both should go through the same relo creation logic. I hope :)
>>>> A hack in llvm below with an example, could you check whether the C
>>>> syntax and object dump result
>>>> is what you want to see?
>>> Thank you for the ultra quick llvm diff!
>>>
>>>> diff --git a/llvm/lib/Target/BPF/AsmParser/BPFAsmParser.cpp
>>>> b/llvm/lib/Target/BPF/AsmParser/BPFAsmParser.cpp
>>>> index 90697c6645be..38b1cbc31f9a 100644
>>>> --- a/llvm/lib/Target/BPF/AsmParser/BPFAsmParser.cpp
>>>> +++ b/llvm/lib/Target/BPF/AsmParser/BPFAsmParser.cpp
>>>> @@ -231,6 +231,7 @@ public:
>>>>             .Case("call", true)
>>>>             .Case("goto", true)
>>>>             .Case("gotol", true)
>>>> +        .Case("goto_or_nop", true)
>>>>             .Case("*", true)
>>>>             .Case("exit", true)
>>>>             .Case("lock", true)
>>>> @@ -259,6 +260,7 @@ public:
>>>>             .Case("bswap64", true)
>>>>             .Case("goto", true)
>>>>             .Case("gotol", true)
>>>> +        .Case("goto_or_nop", true)
>>>>             .Case("ll", true)
>>>>             .Case("skb", true)
>>>>             .Case("s", true)
>>>> diff --git a/llvm/lib/Target/BPF/BPFInstrInfo.td
>>>> b/llvm/lib/Target/BPF/BPFInstrInfo.td
>>>> index 5972c9d49c51..a953d10429bf 100644
>>>> --- a/llvm/lib/Target/BPF/BPFInstrInfo.td
>>>> +++ b/llvm/lib/Target/BPF/BPFInstrInfo.td
>>>> @@ -592,6 +592,19 @@ class BRANCH<BPFJumpOp Opc, string OpcodeStr,
>>>> list<dag> Pattern>
>>>>       let BPFClass = BPF_JMP;
>>>>     }
>>>>
>>>> +class BRANCH_OR_NOP<BPFJumpOp Opc, string OpcodeStr, list<dag> Pattern>
>>>> +    : TYPE_ALU_JMP<Opc.Value, BPF_K.Value,
>>>> +                   (outs),
>>>> +                   (ins brtarget:$BrDst),
>>>> +                   !strconcat(OpcodeStr, " $BrDst"),
>>>> +                   Pattern> {
>>>> +  bits<16> BrDst;
>>>> +
>>>> +  let Inst{47-32} = BrDst;
>>>> +  let Inst{31-0} = 1;
>>>> +  let BPFClass = BPF_JMP;
>>>> +}
>>>> +
>>>>     class BRANCH_LONG<BPFJumpOp Opc, string OpcodeStr, list<dag> Pattern>
>>>>         : TYPE_ALU_JMP<Opc.Value, BPF_K.Value,
>>>>                        (outs),
>>>> @@ -632,6 +645,7 @@ class CALLX<string OpcodeStr>
>>>>     let isBranch = 1, isTerminator = 1, hasDelaySlot=0, isBarrier = 1 in {
>>>>       def JMP : BRANCH<BPF_JA, "goto", [(br bb:$BrDst)]>;
>>>>       def JMPL : BRANCH_LONG<BPF_JA, "gotol", []>;
>>>> +  def JMP_OR_NOP : BRANCH_OR_NOP<BPF_JA, "goto_or_nop", []>;
>>> I was thinking of burning the new 0xE opcode for it,
>>> but you're right. It's a flavor of existing JA insn and it's indeed
>>> better to just use src_reg=1 bit to indicate so.
>> Right, using src_reg to indicate a new flavor of JA insn sounds
>> a good idea. My previously-used 'imm' field is a pure hack.
>>
>>> We probably need to use the 2nd bit of src_reg to indicate its default state
>>> (jmp or fallthrough).
>> Good point.
>>
>>>>            asm volatile goto ("r0 = 0; \
>>>>                                goto_or_nop %l[label]; \
>>>>                                r2 = 2; \
>>>>                                r3 = 3; \
>>> Not sure how to represent the default state in assembly though.
>>> "goto_or_nop" defaults to goto
>>> "nop_or_goto" default to nop
>>> ?
>>>
>>> Do we need "gotol" for imm32 or will it be automatic?
>> It won't be automatic.
>>
>> At the end of this email, I will show the new change
>> to have gotol_or_nop and nop_or_gotol insn and an example
> Thanks a lot Yonghong! May I ask you to send a full patch for LLVM
> (with gotol) so that I can test it?

Okay, I will send a RFC patch to llvm-project so you can do 'git fetch'
to get the patch into your local llvm-project repo and build a compiler
to test.

>
> Overall, I think that JA + flags in SRC_REG is indeed better than a
> new instruction, as a new code is not used.
>
> This looks for me that two bits aren't enough, and the third is
> required, as the second bit seems to be overloaded:
>
>    * bit 1 indicates that this is a "JA_MAYBE"
>    * bit 2 indicates a jump or nop (i.e., the current state)
>
> However, we also need another bit which indicates what to do with the
> instruction when we issue [an abstract] command
>
>    flip_branch_on_or_off(branch, 0/1)
>
> Without this information (and in the absense of external meta-data on
> how to patch the branch) we can't determine what a given (BPF, not
> jitted) program currently does. For example, if we issue
>
>    flip_branch_on_or_off(branch, 0)
>
> then we can't reflect this in the xlated program by setting the second
> bit to jmp/off. Again, JITted program is fine, but it will be
> desynchronized from xlated in term of logic (some instructions will be
> mapped as NOP -> x86_JUMP, others as NOP -> x86_NOP).
>
> In my original patch we kept this triplet as
>
>    (offset to indicate a "special jump", JA+0/JA+OFF, Normal/Inverse)
[...]

