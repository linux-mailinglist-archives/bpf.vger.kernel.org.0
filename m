Return-Path: <bpf+bounces-59681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19274ACE5EE
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 22:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20DF188F275
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 20:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE1F21FF39;
	Wed,  4 Jun 2025 20:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZNs9ucc6"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93D021421C
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 20:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749070714; cv=none; b=IIvvTWQfQvmyLPuBSn2Ps3Q77+VLyZbScpOmHLRvDHtbQyXyaG75Ss2JOLSFSC/+n/Oy8y1DrdG5dLJG5VXGLchMkukz1ZzL0ZzC7TAggzmGJff64PJy6MqyJfY3TleykYif69WMy7ClSL7K3H5CRB3taPERdwEeOJ8J2pgpGGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749070714; c=relaxed/simple;
	bh=yl43/TjLt9UGhLhdDVk7aoKantS+Y2srC4b9YG8ZeZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k48o7sEUEqSthf7+DWOwPd51634oPmlN3/1NsKWhRmpeOx1IYCn5QpgasA9UzKV/EyE60YEFdlVNp6/NPsZ5myMZRNkoRZnfRcOIe+0figJg9iyhnO7xavEZmjkIr2KYaObIXVgyikOkSzvDZ6oOr50A4BSQ+3iNJPUGriWp/bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZNs9ucc6; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <af401134-2475-44bd-b387-4e37575bede8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749070709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zjy048oBaCIaLwZeN29bwuVzNbcXKjQrK1pbSHCDd/g=;
	b=ZNs9ucc6h06FSQy5JDHAdwSb6b3N7HIlvUhvenGnoKas+NmFKlX3oqQYs8lD3k9Dapu+XA
	3M3vIel48UmRk6QFGMztLvuoWo1/RDf2/UePQxsycVQaoNiYyylmxpHgZHysMR6BnuE7bA
	RityOnlDe2+8myiIgX04gGUv7mSHbm0=
Date: Wed, 4 Jun 2025 13:58:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: add
 cmp_map_pointer_with_const test
To: Yonghong Song <yonghong.song@linux.dev>, andrii@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, mykolal@fb.com, kernel-team@meta.com
References: <20250604003759.1020745-1-isolodrai@meta.com>
 <20250604003759.1020745-2-isolodrai@meta.com>
 <f93ce37e-e155-4165-88e2-1a3cadee7c82@linux.dev>
 <292afb4a-78ce-4f42-a322-d2fb5c0da241@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <292afb4a-78ce-4f42-a322-d2fb5c0da241@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/4/25 1:42 PM, Yonghong Song wrote:
> 
> 
> On 6/4/25 9:44 AM, Ihor Solodrai wrote:
>> On 6/3/25 5:37 PM, Ihor Solodrai wrote:
>>> Add a test for CONST_PTR_TO_MAP comparison with a non-0 constant. A
>>> BPF program with this code must not pass verification in unpriv.
>>>
>>> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
>>> ---
>>>   .../selftests/bpf/progs/verifier_unpriv.c       | 17 +++++++++++++++++
>>>   1 file changed, 17 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/ 
>>> tools/testing/selftests/bpf/progs/verifier_unpriv.c
>>> index 28200f068ce5..85b41f927272 100644
>>> --- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
>>> +++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
>>> @@ -634,6 +634,23 @@ l0_%=:    r0 = 0;                        \
>>>       : __clobber_all);
>>>   }
>>>   +SEC("socket")
>>> +__description("unpriv: cmp map pointer with const")
>>> +__success __failure_unpriv __msg_unpriv("R1 pointer comparison 
>>> prohibited")
>>> +__retval(0)
>>> +__naked void cmp_map_pointer_with_const(void)
>>> +{
>>> +    asm volatile ("                    \
>>> +    r1 = 0;                        \
>>> +    r1 = %[map_hash_8b] ll;                \
>>> +    if r1 == 0xcafefeeddeadbeef goto l0_%=;        \
>>
>> GCC BPF caught (correctly) that this is not a valid instruction 
>> because imm is supposed to be 32bit [1]:
>>
>>     progs/verifier_unpriv.c: Assembler messages:
>>     progs/verifier_unpriv.c:643: Error: immediate out of range, shall 
>> fit in 32 bits
>>     make: *** [Makefile:751: /tmp/work/bpf/bpf/src/tools/testing/ 
>> selftests/bpf/bpf_gcc/verifier_unpriv.bpf.o] Error 1
>>
>> But LLVM 20 let it compile and the test passes. I wonder whether it's 
>> a bug in LLVM worth reporting?
>>
>> [1] https://github.com/kernel-patches/bpf/actions/runs/15430930573/ 
>> job/43428666342
> 
> This is a missed case for llvm. See:
>    https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/BPF/ 
> MCTargetDesc/BPFMCCodeEmitter.cpp#L82-L85
> Basically for the following code,
> 
> unsigned BPFMCCodeEmitter::getMachineOpValue(const MCInst &MI,
>                                               const MCOperand &MO,
>                                               SmallVectorImpl<MCFixup> 
> &Fixups,
>                                               const MCSubtargetInfo 
> &STI) const {
>    if (MO.isReg())
>      return MRI.getEncodingValue(MO.getReg());
>    if (MO.isImm())
>      return static_cast<unsigned>(MO.getImm());
> 
> For 'static_cast<unsigned>(MO.getImm())', MO.getImm() value is a s64, so 
> casting to u32 should check
> the value range and we didn't check them, hence didn't report an error.

I see. Out of curiosity I looked at llvm-objdump and indeed only lower
32 bits are in the binary:

0000000000000320 <cmp_map_pointer_with_const>:
      100:       b7 01 00 00 00 00 00 00 r1 = 0x0
      101:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0x0 ll
      103:       15 01 00 00 ef be ad de if r1 == -0x21524111 goto +0x0 
<l0_11>

Thanks for checking, Yonghong.

> 
> The following is the fix:
>     if (MO.isReg())
>       return MRI.getEncodingValue(MO.getReg());
> -  if (MO.isImm())
> +  if (MO.isImm()) {
> +    assert(MO.getImm() >= INT_MIN && MO.getImm() <= INT_MAX);
>       return static_cast<unsigned>(MO.getImm());
> +  }
> 
> With the above, if the clang build enables assertion, the following dump 
> will show up:
> 
> clang: /home/yhs/work/llvm-project/llvm/lib/Target/BPF/MCTargetDesc/ 
> BPFMCCodeEmitter.cpp:86: unsigned int (anonymous 
> namespace)::BPFMCCodeEmitter::getMachin
> eOpValue(const MCInst &, const MCOperand &, SmallVectorImpl<MCFixup> &, 
> const MCSubtargetInfo &) const: Assertion `MO.getImm() >= INT_MIN && 
> MO.getImm() <=
> INT_MAX' failed.
> 
> Although llvm tends to use 'assert' a lot (and 'assert' thing will 
> become noop on production
> build), e.g.,
> 
> [~/work/llvm-project/llvm/lib/Target/BPF/MCTargetDesc (release/19.x)]$ 
> grep assert *.cpp
> BPFAsmBackend.cpp:#include <cassert>
> BPFAsmBackend.cpp:  assert(unsigned(Kind - FirstTargetFixupKind) < 
> getNumFixupKinds() &&
> BPFAsmBackend.cpp:    assert(Value <= UINT32_MAX);
> BPFAsmBackend.cpp:    assert(Fixup.getKind() == FK_PCRel_2);
> BPFELFObjectWriter.cpp:        assert(SectionELF && "Null section for 
> reloc symbol");
> BPFInstPrinter.cpp:  assert(Kind == MCSymbolRefExpr::VK_None);
> BPFInstPrinter.cpp:  assert((Modifier == nullptr || Modifier[0] == 0) && 
> "No modifiers supported");
> BPFInstPrinter.cpp:    assert(Op.isExpr() && "Expected an expression");
> BPFInstPrinter.cpp:  assert(RegOp.isReg() && "Register operand not a 
> register");
> BPFInstPrinter.cpp:    assert(0 && "Expected an immediate");
> BPFMCCodeEmitter.cpp:#include <cassert>
> BPFMCCodeEmitter.cpp:  assert(MO.isExpr());
> BPFMCCodeEmitter.cpp:  assert(Expr->getKind() == MCExpr::SymbolRef);
> BPFMCCodeEmitter.cpp:  assert(Op1.isReg() && "First operand is not 
> register.");
> BPFMCCodeEmitter.cpp:  assert(Op2.isImm() && "Second operand is not 
> immediate.");
> 
> Production build tends not to enable assertion for performance reason, so
> I guess we could emit an error to user for such cases. Will fix in llvm21.
> 
>>
>>> +l0_%=:    r0 = 0; \
>>> +    exit;                        \
>>> +"    :
>>> +    : __imm_addr(map_hash_8b)
>>> +    : __clobber_all);
>>> +}
>>> +
>>>   SEC("socket")
>>>   __description("unpriv: write into frame pointer")
>>>   __failure __msg("frame pointer is read only")
>>
>>
> 


