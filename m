Return-Path: <bpf+bounces-59778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EE0ACF53B
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 19:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CA3A7A68ED
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 17:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1BD27A133;
	Thu,  5 Jun 2025 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZWMKQmaH"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E61F1EB5CE
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749143868; cv=none; b=i5VXeVYoMhHBLcRJ3k7vFHkyt5WkzKwblK0wED9EvWRRKXUJ4qVfkbFZ4eTR4khEvfVdhbFBsYSyDNj55ePcYzsAfgIWbKWztUAF14BmAtQpbIbKyz1WkmZD7GiANSXKldRSzOCbxQL40PJiaaobzBetuLLre0A5lgvETD7QBw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749143868; c=relaxed/simple;
	bh=wVlFk/lbfnFFUDo6ZY/Lao4uh4Lfx3ZZoGCbSO2mVIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hgoHN6FrwfhREA2frV6nUkRXuf4xpzT4ck3JoeJbFuxy/74MYtoHCcyJk+6DTzEuJfkZrqUHipusC3boI6TrnlPiWGkV7cdwX/tjHgLg5bi8GUwocwNq4nE8J++1Kugz5k8bDGVv0rgAaguoDz6G+y36UsH+VZUbgHMhQ8XpvEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZWMKQmaH; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <adc7ee88-7b35-4977-8320-3dc852ba48f8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749143863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0jBIOYPqn4f6LrJoGlZPEnqtmWgNf42ITfyLz9CS6s=;
	b=ZWMKQmaHQ+oK0fP50/AlL/1Uw/vB/MlQtovJHZhYt/8dPq0rVyVafejjy7MAXKGBRf/LNq
	i+oMVZNKvRkUS04z8DCzuDUxZsfjaI+nfklgmvgtICOexdl8wa24QFe3NZ+ItlKeebT21t
	v4FQkQxyTrV3wh9vKO5KvsEOzhP23s8=
Date: Thu, 5 Jun 2025 10:17:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: add
 cmp_map_pointer_with_const test
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Yonghong Song <yonghong.song@linux.dev>, Kernel Team <kernel-team@meta.com>
References: <20250604222729.3351946-1-isolodrai@meta.com>
 <20250604222729.3351946-2-isolodrai@meta.com>
 <CAADnVQJr0JZ1BKeSEE0YM=xcnP0QEBM0smmCkjNs2oaOR1jcbw@mail.gmail.com>
 <38c56b31-ac8a-436d-bc4a-0731bc702ecf@linux.dev>
 <CAADnVQKcSi2fgJky4vOm9Xidar2QQWgmUoZZg0xauXjshDs1Nw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQKcSi2fgJky4vOm9Xidar2QQWgmUoZZg0xauXjshDs1Nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/5/25 9:08 AM, Alexei Starovoitov wrote:
> On Wed, Jun 4, 2025 at 8:04 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> On 6/4/25 3:41 PM, Alexei Starovoitov wrote:
>>> On Wed, Jun 4, 2025 at 3:28 PM Ihor Solodrai <isolodrai@meta.com> wrote:
>>>>
>>>> Add a test for CONST_PTR_TO_MAP comparison with a non-0 constant. A
>>>> BPF program with this code must not pass verification in unpriv.
>>>>
>>>> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
>>>> ---
>>>>    .../selftests/bpf/progs/verifier_unpriv.c       | 17 +++++++++++++++++
>>>>    1 file changed, 17 insertions(+)
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
>>>> index 28200f068ce5..c4a48b57e167 100644
>>>> --- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
>>>> +++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
>>>> @@ -634,6 +634,23 @@ l0_%=:     r0 = 0;                                         \
>>>>           : __clobber_all);
>>>>    }
>>>>
>>>> +SEC("socket")
>>>> +__description("unpriv: cmp map pointer with const")
>>>> +__success __failure_unpriv __msg_unpriv("R1 pointer comparison prohibited")
>>>> +__retval(0)
>>>> +__naked void cmp_map_pointer_with_const(void)
>>>> +{
>>>> +       asm volatile ("                                 \
>>>> +       r1 = 0;                                         \
>>>> +       r1 = %[map_hash_8b] ll;                         \
>>>> +       if r1 == 0xdeadbeef goto l0_%=;         \
>>>
>>> I bet this doesn't fit into imm32 either.
>>> It should fit into _signed_ imm32.
>>
>> Apparently it's fine both for gcc and clang:
>> https://github.com/kernel-patches/bpf/actions/runs/15454151804
> 
> Both compilers are buggy then.
> 
>> I guess the value from inline asm is just put into IMM bytes as
>> is. llvm-objdump is exactly the same, although the value is pretty
>> printed as negative:
>>
>> 0000000000000320 <cmp_map_pointer_with_const>:
>>        100:       b7 01 00 00 00 00 00 00 r1 = 0x0
>>        101:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0x0 ll
>>        103:       15 01 00 00 ef be ad de if r1 == -0x21524111 goto +0x0
> 
> It's 64-bit 0xFFFFffffdeadbeef
> Not the same as 0xdeadbeef

I am not sure what the issue is, would appreciate an explanation.

Inline asm contains a 32bit literal (without a sign). Compiler takes
this literal as is and puts it into imm field of the instruction,
which is also 32bit. The instruction is valid and this value _means_
signed integer, in particular for the verifier.

Are you saying that compiler should check the sign of the literal and
verify it's in signed 32bit range? In other words if you want
0xdeadbeef bytes in the imm, you must write -0x21524111 in the asm?

AFAIU it'd be different from C then, because you can write:

    int k = 0xdeadbeef;
    printf("%d\n", k); // prints -559038737

and it's fine.

Looking at Yonghong's llvm pr [1], it will not error for 0xdeadbeef
because it's less than UINT_MAX:

     if (MO.isImm()) {
         int64_t Imm = MO.getImm();
         if (MI.getOpcode() != BPF::LD_imm64 && (Imm < INT_MIN || Imm > 
UINT_MAX))
           Ctx.reportError(MI.getLoc(),
                           "immediate out of range, shall fit in 32 bits");
         return static_cast<unsigned>(Imm);
       }

[1] https://github.com/llvm/llvm-project/pull/142989



