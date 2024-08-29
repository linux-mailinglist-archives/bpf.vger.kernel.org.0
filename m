Return-Path: <bpf+bounces-38338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F83963803
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 03:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9611F23CF4
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 01:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A0F208CA;
	Thu, 29 Aug 2024 01:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qejrDkqJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AEF2837F
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 01:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724896515; cv=none; b=tz+rvb8oNMi88Ed/XnNw7iE3HdENBzosIQKbQ6KKG46yUw/PpJB9nzoUWjVfl5igVKIYT/+HIJTbokTmtzFB3PeGR88ot0/a4klIfvULuCj4czcZjgnGwlnD7llLBJfZBdwSKrg31KmVLw2WPqyQRWBmCSjNt9ZCq35RkqbdAlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724896515; c=relaxed/simple;
	bh=qzAfXPzF767/GvrTzz7dmZa0FlsfaH16IhwRIB1qrY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=icU4LkhryfUwYoDWi+52XwyQQRhT+m+U0t/rbt+VEqTExOE6q9tjiLh7yHhmXnkN8Dm0uPPKo93jUHE++Oh6/ZrvBUEmT+5DlX/Xk9SfVXBuf3WO5X472CYjIvU95svhIi1iYd8Oco+/C+JBpw7pM9dZKoDzNt5ZrNcbRp2t8kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qejrDkqJ; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0723964d-97b9-4b48-995c-3c9efa980f5a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724896511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MR0T95174GvoKL8fBKsrn92m5inRkPrg1CAjBsS0wjs=;
	b=qejrDkqJjVTaxQQOCle5aYgSrNGv91ij4CcEUrRQbg0fsfeO35PuqgH+rPhP45/B5dvE/h
	3l8+5Gbi/jUX1SyGm6Hyc0aPGSjxovFewQETSBLHk9vdb2yY1vzsfhmoDEKotrxdcWydey
	UOPJlYtwzpRnyfgpjaYFKZyhrzV5+YI=
Date: Wed, 28 Aug 2024 18:54:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf, x64: Fix a jit convergence issue
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Daniel Hodges <hodgesd@meta.com>
References: <20240825200406.1874982-1-yonghong.song@linux.dev>
 <CAADnVQ+5HD1ZxBqpDgNuwPkO1+VGzm1yqhxuDD4HYtkRYHwXiA@mail.gmail.com>
 <7e2ad37e-e750-4cbd-8305-bf16bbebcc53@linux.dev>
 <CAADnVQLbknLw9fOhgbSNaNzKi5gfQTP74vXQu3D1P2OVF81b+Q@mail.gmail.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQLbknLw9fOhgbSNaNzKi5gfQTP74vXQu3D1P2OVF81b+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 8/28/24 4:44 PM, Alexei Starovoitov wrote:
> On Wed, Aug 28, 2024 at 3:47 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>> It can be je/je too, no?
>> Yes. It is possible.
>>
>>> so 128 - 4 instead of 128 - 3 ?
>> You probably mean "127 - 4 instead of 127 - 3" since
>> the maximum value is 127.
> Yes, of course :)
>
>> I checked 127 - 4 = 0x7c and indeed we should. See below examples:
>>
>>      20e:    48 85 ff                test   rdi,rdi
>>      211:    XX XX                   je     0x291
>>      213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
>>      ...
>>      28d:    XX XX XX XX XX XX       je     0x212
>>      293:    bf 03 00 00 00          mov    edi,0x3
>>
>> =>
>>
>>      20e:    48 85 ff                test   rdi,rdi
>>      211:    XX XX XX XX XX XX       je     0x297 (0x293 - 0x213)
>>      217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
>>      ...
>>      291:    XX XX                   je     0x217 (0x217 - 0x293)
>>      293:    bf 03 00 00 00          mov    edi,0x3
>>
>> =>
>>
>>      20e:    48 85 ff                test   rdi,rdi
>>      211:    XX XX                   je     0x28f (0x293 - 0x217)
>>      213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
>>      ...
>>      28d:    XX XX                   je     0x213 (0x213 - 0x293)  // -0x80 allowed
>>      293:    bf 03 00 00 00          mov    edi,0x3
>>
>> =>
>>
>>      20e:    48 85 ff                test   rdi,rdi
>>      211:    XX XX XX XX XX XX       je     0x28f (0x293 - 0x213)
>>      217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
>>      ...
>>      291:    XX XX                   je     0x217 (0x217 - 0x293)
>>      293:    bf 03 00 00 00          mov    edi,0x3
>>
>> =>
>>      ...
>>
>>
>> Here 0x293 - 0x217 = 0x7c
> How did you craft such a test?
> Can we add it as a selftest somehow?

This is not from a complete test. I assumed some state during convergence
and from there to further derive states. But I will try to see whether
I can construct actual test cases or not.

>
>>>> +static bool is_imm8_cond_offset(int value)
>>>> +{
>>>> +       return value <= 124 && value >= -128;
>>> the other side needs the same treatment, no ?
>> good question. From my understanding, the non-convergence in the
>> above needs both forward and backport conditions. The solution we
>> are using is based on putting a limitation on forward conditions
>> w.r.t. jit code gen.
>>
>> Another solution is actually to put a limitation on backward
>> conditions. For example, let us say the above is_imm8_cond_offset()
>> has
>>          return value <= 127 && value > -124
>>
>> See below example:
>>
>>      20e:    48 85 ff                test   rdi,rdi
>>      211:    XX XX                   je     0x291
>>      213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
>>      ...
>>      28d:    XX XX XX XX XX XX       je     0x212
>>      293:    bf 03 00 00 00          mov    edi,0x3
>>
>> =>
>>
>>      20e:    48 85 ff                test   rdi,rdi
>>      211:    XX XX XX XX XX XX       je     0x297 (0x293 - 0x213)
>>      217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
>>      ...
>>      291:    XX XX XX XX XX XX       je     0x21b (0x217 - 0x293)
>>      297:    bf 03 00 00 00          mov    edi,0x3
>>
>> =>
>>
>>      20e:    48 85 ff                test   rdi,rdi
>>      211:    XX XX XX XX XX XX       je     0x297 (0x297 - 0x217)
>>      217:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
>>      ...
>>      291:    XX XX XX XX XX XX       je     0x217 (0x217 - 0x297)
>>      297:    bf 03 00 00 00          mov    edi,0x3
>>
>> converged here.
>>
>> So I think we do not need to limit both sides. One side should be enough.
> I see and agree when both sides are je/je.
> What if the earlier one is a jmp ?
>
> Then we can hit:
>             if (nops != 0 && nops != 3) {
>                       pr_err("unexpected jump padding: %d bytes\n",
>                                               nops);
> ?
>
> So one side of "jmp_cond padding" and the same side in "jump padding"
> needs to do it?

I did some further experiments with pattern like
   jmp <-> je
and
   jmp <-> jmp

The below is the illustration (not from a complete test):

================

     211:    XX XX                   jmp     0x291
     213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
     ...
     28d:    XX XX XX XX XX XX       je     0x212
     293:    bf 03 00 00 00          mov    edi,0x3

=>

     211:    XX XX XX XX XX          jmp     (0x293 - 0x213)
     216:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
     ...
     291:    XX XX                   je      (0x216 - 0x293)
     293:    bf 03 00 00 00          mov    edi,0x3

=>

     211:    XX XX                   jmp     (0x293 - 0x216 = 0x7d)
     213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
     ...
     28d:    XX XX                   je      (0x213 - 0x293)
     293:    bf 03 00 00 00          mov    edi,0x3

=>

     211:    XX XX XX XX XX          jmp     (0x293 - 0x213)
     216:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
     ...
     291:    XX XX                   je      (0x216 - 0x293)
     293:    bf 03 00 00 00          mov    edi,0x3

=>
     ...

not converged!

================

     211:    XX XX                   jmp     0x291
     213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
     ...
     28c:    XX XX XX XX XX XX       je     0x212
     292:    bf 03 00 00 00          mov    edi,0x3

=>

     211:    XX XX                   jmp     (0x292 - 0x213)
     213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
     ...
     28c:    XX XX                   je     (0x213 - 0x292)
     28e:    bf 03 00 00 00          mov    edi,0x3

=>

     211:    XX XX                   jmp     (0x28e - 0x213 = 0x7b)
     213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
     ...
     28c:    XX XX                   je     (0x213 - 0x28e)
     28e:    bf 03 00 00 00          mov    edi,0x3

converged!

=================

     211:    XX XX                   jmp     0x291
     213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
     ...
     28e:    XX XX XX XX XX          jmp     0x212
     293:    bf 03 00 00 00          mov    edi,0x3

=>

     211:    XX XX XX XX XX          jmp    (0x293 - 0x213)
     216:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
     ...
     292:    XX XX                   jmp    (0x216 - 0x293)
     294:    bf 03 00 00 00          mov    edi,0x3

=>

     211:    XX XX                   jmp    (0x294 - 0x216 = 0x7e)
     213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
     ...
     28e:    XX XX XX XX XX          jmp    (0x213 - 0x294)
     294:    bf 03 00 00 00          mov    edi,0x3

=>

     211:    XX XX                   jmp    (0x294 - 0x216 = 0x7e)
     213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
     ...
     28e:    XX XX XX XX XX          jmp    (0x213 - 0x294)
     294:    bf 03 00 00 00          mov    edi,0x3

=>

     211:    XX XX XX XX XX          jmp    (0x294 - 0x213)
     216:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
     ...
     292:    XX XX                   jmp    (0x216 - 0x294)
     294:    bf 03 00 00 00          mov    edi,0x3

=>
    ...

no converged!

===================================

     211:    XX XX                   jmp     0x291
     213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
     ...
     28d:    XX XX XX XX XX          jmp     0x212
     292:    bf 03 00 00 00          mov    edi,0x3

=>

     211:    XX XX                   jmp     (0x292 - 0x213)
     213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
     ...
     28d:    XX XX                   jmp     (0x213 - 0x292)
     290:    bf 03 00 00 00          mov    edi,0x3

=>

     211:    XX XX                   jmp     (0x290 - 0x213 = 0x7d)
     213:    48 8b 77 00             mov    rsi,QWORD PTR [rdi+0x0]
     ...
     28d:    XX XX                   jmp     (0x213 - 0x290)
     290:    bf 03 00 00 00          mov    edi,0x3

converged!

So I emulated je <-> je, je <-> jmp, jmp <-> je and jmp <-> jmp.

So we need to apply the same checking is_imm8_cond_offset() to jmp insn.
This should cover all cases.

Hitting the following
            if (nops != 0 && nops != 3) {
                      pr_err("unexpected jump padding: %d bytes\n",
                                              nops);

is not due to the above illustration with 'jmp' insn as indeed
its insn length changes with 0 or 3. But it is due to some jmp/cond_jmp
insn inside je/jmp <-> je/jmp.


