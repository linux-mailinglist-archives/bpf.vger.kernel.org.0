Return-Path: <bpf+bounces-15696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E084C7F4FEF
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 19:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C0128147E
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 18:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC1055760;
	Wed, 22 Nov 2023 18:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ggHxEcC+"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [IPv6:2001:41d0:203:375::b9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41E792
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 10:51:28 -0800 (PST)
Message-ID: <82e99ae6-be6e-494b-abac-040eaa89ecf7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700679087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KDxdhvxEYEzhvYXgI84jgZbxDD65vMIxB2OQsJBitpc=;
	b=ggHxEcC+wO5CJYLFnpe92P54LLpTt+fQ5iN2nJ9tJkZy9Mc/KjKosh+oGyckpJgu4BN80C
	gWAxqH3yWXrrwKDnW4DXx1SFgxiLA0fyDyLCYhl9XTP5eZbH/svKF+DupKS1E5djAFnAnb
	7YDaPzafe9GTy3afZyxJV1yWF0U4T04=
Date: Wed, 22 Nov 2023 10:51:20 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] C inlined assembly for reproducing max<min
Content-Language: en-GB
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eddy Z <eddyz87@gmail.com>, Tao Lyu <tao.lyu@epfl.ch>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Hao Luo <haoluo@google.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 mathias.payer@nebelwelt.net, meng.xu.cs@uwaterloo.ca,
 sanidhya.kashyap@epfl.ch, Song Liu <song@kernel.org>
References: <d3a518de-ada3-45e8-be3e-df942c2208b5@linux.dev>
 <20231122144018.4047232-1-tao.lyu@epfl.ch>
 <2e8a1584-a289-4b2e-800c-8b463e734bcb@linux.dev>
 <CAADnVQJqmpSoABqd-dCQBU2ExiPda1mHz2pKHv2jzpSMYFMeqQ@mail.gmail.com>
 <874jhdk51j.fsf@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <874jhdk51j.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/22/23 1:37 PM, Jose E. Marchesi wrote:
>> On Wed, Nov 22, 2023 at 10:08 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>> +SEC("?tc")
>>>> +__log_level(2)
>>>> +int test_verifier_range(void)
>>>> +{
>>>> +    asm volatile (
>>>> +        "r5 = 100; \
>>>> +        r5 /= 3; \
>>>> +        w5 >>= 7; \
>>>> +        r5 &= -386969681; \
>>>> +        r5 -= -884670597; \
>>>> +        w0 = w5; \
>>>> +        if w0 & 0x894b6a55 goto +2; \
>>> So actually it is 'if w0 & 0x894b6a55 goto +2' failed
>>> the compilation.
>>>
>>> Indeed, the above operation is not supported in llvm.
>>> See
>>>     https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/BPF/BPFInstrFormats.td#L62-L74
>>> the missing BPFJumpOp<0x4> which corresponds to JSET.
>>>
>>> The following llvm patch (on top of llvm-project main branch):
>>>
>>> diff --git a/llvm/lib/Target/BPF/BPFInstrFormats.td b/llvm/lib/Target/BPF/BPFInstrFormats.td
>>> index 841d97efc01c..6ed83d877ac0 100644
>>> --- a/llvm/lib/Target/BPF/BPFInstrFormats.td
>>> +++ b/llvm/lib/Target/BPF/BPFInstrFormats.td
>>> @@ -63,6 +63,7 @@ def BPF_JA   : BPFJumpOp<0x0>;
>>>    def BPF_JEQ  : BPFJumpOp<0x1>;
>>>    def BPF_JGT  : BPFJumpOp<0x2>;
>>>    def BPF_JGE  : BPFJumpOp<0x3>;
>>> +def BPF_JSET : BPFJumpOp<0x4>;
>>>    def BPF_JNE  : BPFJumpOp<0x5>;
>>>    def BPF_JSGT : BPFJumpOp<0x6>;
>>>    def BPF_JSGE : BPFJumpOp<0x7>;
>>> diff --git a/llvm/lib/Target/BPF/BPFInstrInfo.td b/llvm/lib/Target/BPF/BPFInstrInfo.td
>>> index 305cbbd34d27..9e75f35efe70 100644
>>> --- a/llvm/lib/Target/BPF/BPFInstrInfo.td
>>> +++ b/llvm/lib/Target/BPF/BPFInstrInfo.td
>>> @@ -246,6 +246,70 @@ class JMP_RI_32<BPFJumpOp Opc, string OpcodeStr, PatLeaf Cond>
>>>      let BPFClass = BPF_JMP32;
>>>    }
>>>
>>> +class JSET_RR<string OpcodeStr>
>>> +    : TYPE_ALU_JMP<BPF_JSET.Value, BPF_X.Value,
>>> +                   (outs),
>>> +                   (ins GPR:$dst, GPR:$src, brtarget:$BrDst),
>>> +                   "if $dst "#OpcodeStr#" $src goto $BrDst",
>>> +                   []> {
>>> +  bits<4> dst;
>>> +  bits<4> src;
>>> +  bits<16> BrDst;
>>> +
>>> +  let Inst{55-52} = src;
>>> +  let Inst{51-48} = dst;
>>> +  let Inst{47-32} = BrDst;
>>> +  let BPFClass = BPF_JMP;
>>> +}
>>> +
>>> +class JSET_RI<string OpcodeStr>
>>> +    : TYPE_ALU_JMP<BPF_JSET.Value, BPF_K.Value,
>>> +                   (outs),
>>> +                   (ins GPR:$dst, i64imm:$imm, brtarget:$BrDst),
>>> +                   "if $dst "#OpcodeStr#" $imm goto $BrDst",
>>> +                   []> {
>>> +  bits<4> dst;
>>> +  bits<16> BrDst;
>>> +  bits<32> imm;
>>> +
>>> +  let Inst{51-48} = dst;
>>> +  let Inst{47-32} = BrDst;
>>> +  let Inst{31-0} = imm;
>>> +  let BPFClass = BPF_JMP;
>>> +}
>>> +
>>> +class JSET_RR_32<string OpcodeStr>
>>> +    : TYPE_ALU_JMP<BPF_JSET.Value, BPF_X.Value,
>>> +                   (outs),
>>> +                   (ins GPR32:$dst, GPR32:$src, brtarget:$BrDst),
>>> +                   "if $dst "#OpcodeStr#" $src goto $BrDst",
>>> +                   []> {
>>> +  bits<4> dst;
>>> +  bits<4> src;
>>> +  bits<16> BrDst;
>>> +
>>> +  let Inst{55-52} = src;
>>> +  let Inst{51-48} = dst;
>>> +  let Inst{47-32} = BrDst;
>>> +  let BPFClass = BPF_JMP32;
>>> +}
>>> +
>>> +class JSET_RI_32<string OpcodeStr>
>>> +    : TYPE_ALU_JMP<BPF_JSET.Value, BPF_K.Value,
>>> +                   (outs),
>>> +                   (ins GPR32:$dst, i32imm:$imm, brtarget:$BrDst),
>>> +                   "if $dst "#OpcodeStr#" $imm goto $BrDst",
>>> +                   []> {
>>> +  bits<4> dst;
>>> +  bits<16> BrDst;
>>> +  bits<32> imm;
>>> +
>>> +  let Inst{51-48} = dst;
>>> +  let Inst{47-32} = BrDst;
>>> +  let Inst{31-0} = imm;
>>> +  let BPFClass = BPF_JMP32;
>>> +}
>>> +
>>>    multiclass J<BPFJumpOp Opc, string OpcodeStr, PatLeaf Cond, PatLeaf Cond32> {
>>>      def _rr : JMP_RR<Opc, OpcodeStr, Cond>;
>>>      def _ri : JMP_RI<Opc, OpcodeStr, Cond>;
>>> @@ -265,6 +329,10 @@ defm JULT : J<BPF_JLT, "<", BPF_CC_LTU, BPF_CC_LTU_32>;
>>>    defm JULE : J<BPF_JLE, "<=", BPF_CC_LEU, BPF_CC_LEU_32>;
>>>    defm JSLT : J<BPF_JSLT, "s<", BPF_CC_LT, BPF_CC_LT_32>;
>>>    defm JSLE : J<BPF_JSLE, "s<=", BPF_CC_LE, BPF_CC_LE_32>;
>>> +def JSET_RR    : JSET_RR<"&">;
>>> +def JSET_RI    : JSET_RI<"&">;
>>> +def JSET_RR_32 : JSET_RR_32<"&">;
>>> +def JSET_RI_32 : JSET_RI_32<"&">;
>>>    }
>>>
>>>    // ALU instructions
>>>
>>> can solve your inline asm issue. We will discuss whether llvm compiler
>>> should be implementing this instruction from source or not.
>> I'd say 'yes'. clang/llvm should support such asm syntax.
>>
>> Jose, Eduard,
>> Thoughts?
> We already support it in GAS:
>
>
>    $ echo 'if w0 & 0x894b6a55 goto +2' | bpf-unknown-none-as -mdialect=pseudoc -
>    $ bpf-unknown-none-objdump -M hex,pseudoc -d a.out
>    
>    a.out:     file format elf64-bpfle
>    
>    
>    Disassembly of section .text:
>    
>    0000000000000000 <.text>:
>       0:	46 00 02 00 55 6a 4b 89 	if w0&0x894b6a55 goto 0x2
>
>
> We weren't aware we were diverging with llvm by doing so.  We support
> syntax for all the conditional jump instructions using the following
> operators:
>
>    BPF_JEQ    ==
>    BPF_JGT    >
>    BPF_JSGT   s>
>    BPF_JGE    >=
>    BPF_JSGE   s>=
>    BPF_JLT    <
>    BPF_JLST   s<
>    BPF_JLE    <=
>    BPF_JSLE   s<=
>    BPF_JSET   &
>    BPF_JNE    !=

Sounds good. Eduard inthe other thread has similar opinion. Will add asm support in llvm soon.


