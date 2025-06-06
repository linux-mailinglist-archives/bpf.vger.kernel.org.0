Return-Path: <bpf+bounces-59844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5255ACFC88
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 08:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA6116AAE8
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 06:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA69724EA8F;
	Fri,  6 Jun 2025 06:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n1QgVl2Z"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC311A275
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 06:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749191095; cv=none; b=LEHKWTT2oqG/Jwl5bmmnQYi+x40mz4AFXPMzZv2ItT9UlL/BI4RTJ25mcDjlittF0Os+9XfQRLG+iQOMj062gG7skZ4qFU9hmJ3k+DgeBOE7z5+oCHqM6jSHtv/7CZb3LTJZS5wu/SLGqqjaqj05fyS5XLx4UjXMsdnvjevVUqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749191095; c=relaxed/simple;
	bh=dv9dCsIbYMBOEFF2zOWWQ4KPOQXtnaaZ3i0iFb2Tz94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tF8Pv/E13b/3tm4ILAQNA4IOurnaO//ozIeMfhUnw5DaaYvmmuuShtaFOmP4Pt5bc9VrC1if8KBRkzeftXsQY4Gw2qk8Cy+8HJUvZgwdDfqHd6TYyy/CjIjyo0hqmhfMgbA2ZRNJRNAssaQjcf//IPKK6TnfwSRqFcqDPzW3SbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n1QgVl2Z; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <70affb12-327b-4882-bd1d-afda8b8c6f56@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749191090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o7wSK53w+DHFKvyiqVd8WESLkwI3bOdh6rKqELDVVeo=;
	b=n1QgVl2ZxWC1EjpdzxZDO15/AmP0igp/pjhCLzLFHFChJojEUljpbHf6HqcItxaFgXOiw3
	m5eAf0UbBxykWUT78suq1jhi3OJZiIfLxvkslRSynDLkiDcTgS31u/DA6McVLs0BIRZnDH
	mmaMUe7h9YAjMos2trKXEbbDXBkPzDs=
Date: Thu, 5 Jun 2025 23:24:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: add
 cmp_map_pointer_with_const test
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Kernel Team <kernel-team@meta.com>
References: <20250604222729.3351946-1-isolodrai@meta.com>
 <20250604222729.3351946-2-isolodrai@meta.com>
 <CAADnVQJr0JZ1BKeSEE0YM=xcnP0QEBM0smmCkjNs2oaOR1jcbw@mail.gmail.com>
 <38c56b31-ac8a-436d-bc4a-0731bc702ecf@linux.dev>
 <CAADnVQKcSi2fgJky4vOm9Xidar2QQWgmUoZZg0xauXjshDs1Nw@mail.gmail.com>
 <adc7ee88-7b35-4977-8320-3dc852ba48f8@linux.dev>
 <9b6c75b2-5f33-47cc-ba23-6233a5c93938@linux.dev>
 <CAADnVQJneX_rzcr-L0-yUwy38ffwwDqVq4E8byC+wpTMYTrT4Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJneX_rzcr-L0-yUwy38ffwwDqVq4E8byC+wpTMYTrT4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/5/25 11:11 AM, Alexei Starovoitov wrote:
> On Thu, Jun 5, 2025 at 10:42 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>>
>> On 6/5/25 10:17 AM, Ihor Solodrai wrote:
>>> On 6/5/25 9:08 AM, Alexei Starovoitov wrote:
>>>> On Wed, Jun 4, 2025 at 8:04 PM Ihor Solodrai
>>>> <ihor.solodrai@linux.dev> wrote:
>>>>> On 6/4/25 3:41 PM, Alexei Starovoitov wrote:
>>>>>> On Wed, Jun 4, 2025 at 3:28 PM Ihor Solodrai <isolodrai@meta.com>
>>>>>> wrote:
>>>>>>> Add a test for CONST_PTR_TO_MAP comparison with a non-0 constant. A
>>>>>>> BPF program with this code must not pass verification in unpriv.
>>>>>>>
>>>>>>> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
>>>>>>> ---
>>>>>>>     .../selftests/bpf/progs/verifier_unpriv.c       | 17
>>>>>>> +++++++++++++++++
>>>>>>>     1 file changed, 17 insertions(+)
>>>>>>>
>>>>>>> diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
>>>>>>> b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
>>>>>>> index 28200f068ce5..c4a48b57e167 100644
>>>>>>> --- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
>>>>>>> +++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
>>>>>>> @@ -634,6 +634,23 @@ l0_%=:     r0 =
>>>>>>> 0;                                         \
>>>>>>>            : __clobber_all);
>>>>>>>     }
>>>>>>>
>>>>>>> +SEC("socket")
>>>>>>> +__description("unpriv: cmp map pointer with const")
>>>>>>> +__success __failure_unpriv __msg_unpriv("R1 pointer comparison
>>>>>>> prohibited")
>>>>>>> +__retval(0)
>>>>>>> +__naked void cmp_map_pointer_with_const(void)
>>>>>>> +{
>>>>>>> +       asm volatile ("                                 \
>>>>>>> +       r1 = 0;                                         \
>>>>>>> +       r1 = %[map_hash_8b] ll;                         \
>>>>>>> +       if r1 == 0xdeadbeef goto l0_%=;         \
>>>>>> I bet this doesn't fit into imm32 either.
>>>>>> It should fit into _signed_ imm32.
>>>>> Apparently it's fine both for gcc and clang:
>>>>> https://github.com/kernel-patches/bpf/actions/runs/15454151804
>>>> Both compilers are buggy then.
>>>>
>>>>> I guess the value from inline asm is just put into IMM bytes as
>>>>> is. llvm-objdump is exactly the same, although the value is pretty
>>>>> printed as negative:
>>>>>
>>>>> 0000000000000320 <cmp_map_pointer_with_const>:
>>>>>         100:       b7 01 00 00 00 00 00 00 r1 = 0x0
>>>>>         101:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1
>>>>> = 0x0 ll
>>>>>         103:       15 01 00 00 ef be ad de if r1 == -0x21524111 goto
>>>>> +0x0
>>>> It's 64-bit 0xFFFFffffdeadbeef
>>>> Not the same as 0xdeadbeef
>>> I am not sure what the issue is, would appreciate an explanation.
>>>
>>> Inline asm contains a 32bit literal (without a sign). Compiler takes
>>> this literal as is and puts it into imm field of the instruction,
>>> which is also 32bit. The instruction is valid and this value _means_
>>> signed integer, in particular for the verifier.
> Not quite. It's signed imm32 in _runtime_.
>
>>> Are you saying that compiler should check the sign of the literal and
>>> verify it's in signed 32bit range? In other words if you want
>>> 0xdeadbeef bytes in the imm, you must write -0x21524111 in the asm?
>>>
>>> AFAIU it'd be different from C then, because you can write:
>>>
>>>     int k = 0xdeadbeef;
>>>     printf("%d\n", k); // prints -559038737
>>>
>>> and it's fine.
>>>
>>> Looking at Yonghong's llvm pr [1], it will not error for 0xdeadbeef
>>> because it's less than UINT_MAX:
>>>
>>>      if (MO.isImm()) {
>>>          int64_t Imm = MO.getImm();
>>>          if (MI.getOpcode() != BPF::LD_imm64 && (Imm < INT_MIN || Imm >
>>> UINT_MAX))
>>>            Ctx.reportError(MI.getLoc(),
>>>                            "immediate out of range, shall fit in 32
>>> bits");
>>>          return static_cast<unsigned>(Imm);
>>>        }
>>>
>>> [1] https://github.com/llvm/llvm-project/pull/142989
>>>
>>>
>> If we have C code like
>>     if (var == 0xdeadbeef) { ... }
>>
>> The compiler will actually convert 'var == imm' to 'rX == rY' and
>> rY will have content of 0xdeadbeef. This will happen during IR lowering
>> from middle end to machine instructions.
> ... and the compiler will use ld_imm64 insn to store 0xdeadbeef in rY.
>
>> The tricky thing is inline asm. I am debating myself whether we
>> should align with GCC or not to allow 'rX == 0xdeadbeef' in inline asm.
>> in llvm the inline asm code is processed at MC level (after all
>> optimizations).
>> Ultimately I aligned with GCC for compatibility. My first response to this
>> thread is to only allow in range or INT_MIN and INT_MAX.
>>
>> So the question is that we treat inline asm as the pure encoding
>> or it should have other semantics.
> I think both compilers should error (or warn) when imm32 doesn't fit
> into int_min/max, because the asm code for
> if r1 == 0xdeadbeef goto l0_%=;
> will not do what the author expects.

if we intend to use 'int' range instead then we will have more cases like below.
For example,

store with imm:
    int foo(long *a, long *b) {
       *a = 0xabababab;
       *b = 0x76543210;
       return 0;
    }

In this example, using an inline asm to do
    *(u64 *)(r1 + 0) = 0xabababab
will not be what user expected to get.

The same issue for conditional like 'long a; if (a > 0xabababab) ...', or
alu64 operations like 'long a; if (a & 0xabababab) ...'.

I can expand checking in llvm for the these patterns.


