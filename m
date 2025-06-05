Return-Path: <bpf+bounces-59761-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4071ACF300
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 17:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2B01893C02
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 15:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C8418C031;
	Thu,  5 Jun 2025 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gGNe11gs"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41805198A2F
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749137171; cv=none; b=mRk+RGYxp6EEbEQEuxwKeLoYHQE+Sz8O5OzNEBpGxwEAebVtueriuy49EG7MPynXnFttUDRn0VOfVUUWhtqGU0dKFLkzpOiaYYYR6pmP0zaBJiKuo8ZRFtvGrOE2eGa5essH6AYQ8buYbtarxFjygMJwXAQAEiIsjqIZ5BagpGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749137171; c=relaxed/simple;
	bh=2COd+7j0yZonHym6jfynqevDD8DhtJ8V35ToY6IHOxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDD2FMo3n9lmWsb/9C6m0deccvobO9vA5jOsN9UFKHJXDukAAXkLCcHv0U9CUje1TPMqXrHJLfTCpG+Ch0yyCsukeN3Aau5lM5xW57oJqPkuVWuP4+CygMPxHrN8XKXgdE+ggSvUPjXm30CFJDGY3Ih6cAcMDUCnLRxKjyOAAlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gGNe11gs; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a12a01df-a449-4d2b-bf46-2e6b1001f16c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749137164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cv+PxZnkD4BemmWc+1hIcSCIwmtkM0pMtEu3K0ifUrM=;
	b=gGNe11gsNvOvrnusqeMcvKpXTQOT33X8wgOoUEu7EVzADHB22nnx4lP+ZCHYm0yGNSwRc8
	8K2aWH+Od0Lx0piWM/Pm/CEIgFKxQRSkYGIighHy470hsEDk1Vu3KnjsxIfC/ex1yRiH0t
	3DOR+YPZAvFdQgqJNoOWmnYPNM+JfD4=
Date: Thu, 5 Jun 2025 08:25:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: add
 cmp_map_pointer_with_const test
Content-Language: en-GB
To: Ihor Solodrai <ihor.solodrai@linux.dev>, andrii@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, mykolal@fb.com, kernel-team@meta.com
References: <20250604003759.1020745-1-isolodrai@meta.com>
 <20250604003759.1020745-2-isolodrai@meta.com>
 <f93ce37e-e155-4165-88e2-1a3cadee7c82@linux.dev>
 <292afb4a-78ce-4f42-a322-d2fb5c0da241@linux.dev>
 <af401134-2475-44bd-b387-4e37575bede8@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <af401134-2475-44bd-b387-4e37575bede8@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/4/25 1:58 PM, Ihor Solodrai wrote:
> On 6/4/25 1:42 PM, Yonghong Song wrote:
>>
>>
>> On 6/4/25 9:44 AM, Ihor Solodrai wrote:
>>> On 6/3/25 5:37 PM, Ihor Solodrai wrote:
>>>> Add a test for CONST_PTR_TO_MAP comparison with a non-0 constant. A
>>>> BPF program with this code must not pass verification in unpriv.
>>>>
>>>> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
>>>> ---
>>>>   .../selftests/bpf/progs/verifier_unpriv.c       | 17 
>>>> +++++++++++++++++
>>>>   1 file changed, 17 insertions(+)
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/ 
>>>> tools/testing/selftests/bpf/progs/verifier_unpriv.c
>>>> index 28200f068ce5..85b41f927272 100644
>>>> --- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
>>>> +++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
>>>> @@ -634,6 +634,23 @@ l0_%=:    r0 = 0;                        \
>>>>       : __clobber_all);
>>>>   }
>>>>   +SEC("socket")
>>>> +__description("unpriv: cmp map pointer with const")
>>>> +__success __failure_unpriv __msg_unpriv("R1 pointer comparison 
>>>> prohibited")
>>>> +__retval(0)
>>>> +__naked void cmp_map_pointer_with_const(void)
>>>> +{
>>>> +    asm volatile ("                    \
>>>> +    r1 = 0;                        \
>>>> +    r1 = %[map_hash_8b] ll;                \
>>>> +    if r1 == 0xcafefeeddeadbeef goto l0_%=;        \
>>>
>>> GCC BPF caught (correctly) that this is not a valid instruction 
>>> because imm is supposed to be 32bit [1]:
>>>
>>>     progs/verifier_unpriv.c: Assembler messages:
>>>     progs/verifier_unpriv.c:643: Error: immediate out of range, 
>>> shall fit in 32 bits
>>>     make: *** [Makefile:751: /tmp/work/bpf/bpf/src/tools/testing/ 
>>> selftests/bpf/bpf_gcc/verifier_unpriv.bpf.o] Error 1
>>>
>>> But LLVM 20 let it compile and the test passes. I wonder whether 
>>> it's a bug in LLVM worth reporting?
>>>
>>> [1] https://github.com/kernel-patches/bpf/actions/runs/15430930573/ 
>>> job/43428666342
>>
>> This is a missed case for llvm. See:
>> https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/BPF/ 
>> MCTargetDesc/BPFMCCodeEmitter.cpp#L82-L85
>> Basically for the following code,
>>
>> unsigned BPFMCCodeEmitter::getMachineOpValue(const MCInst &MI,
>>                                               const MCOperand &MO,
>> SmallVectorImpl<MCFixup> &Fixups,
>>                                               const MCSubtargetInfo 
>> &STI) const {
>>    if (MO.isReg())
>>      return MRI.getEncodingValue(MO.getReg());
>>    if (MO.isImm())
>>      return static_cast<unsigned>(MO.getImm());
>>
>> For 'static_cast<unsigned>(MO.getImm())', MO.getImm() value is a s64, 
>> so casting to u32 should check
>> the value range and we didn't check them, hence didn't report an error.
>
> I see. Out of curiosity I looked at llvm-objdump and indeed only lower
> 32 bits are in the binary:
>
> 0000000000000320 <cmp_map_pointer_with_const>:
>      100:       b7 01 00 00 00 00 00 00 r1 = 0x0
>      101:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 
> 0x0 ll
>      103:       15 01 00 00 ef be ad de if r1 == -0x21524111 goto +0x0 
> <l0_11>

FYI, I just submitted a fix https://github.com/llvm/llvm-project/pull/142989
which will emit the same error messages as gcc if the value cannot fit into
32bit (32bit value will do sign extension to 64bit value).


