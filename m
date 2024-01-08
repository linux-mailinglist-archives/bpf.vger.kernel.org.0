Return-Path: <bpf+bounces-19204-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE708278C4
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 20:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BFFB284BBB
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 19:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E8453E11;
	Mon,  8 Jan 2024 19:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WtIyyVXP"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DD754F8D
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 19:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <60c5be25-5c35-4e47-948b-66cc8b1b4feb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704743488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/rQWO/NUPYN2iNJZ9HKpcIgWHDe6FoGPibFMeL6obrM=;
	b=WtIyyVXPn9toSl7BLl+idQp/0jIw8yhMl6aIi3p6O/WEiBtONK7G+gG5HwEOcq8oFA70DH
	WWsMt2ajkxVgqbkQnGnu2fAwii/qmaULmyCdqf5SPnFuR/osWc2pTTm9bFJ6S24nfdtFnt
	rmAlYKAKQ28//ckAjLQ6mwRX9F+Gv88=
Date: Mon, 8 Jan 2024 11:51:23 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Track aligned st store as imprecise
 spilled registers
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Martin KaFai Lau <kafai@fb.com>
References: <20240103232617.3770727-1-yonghong.song@linux.dev>
 <f4c1ebf73ccf4099f44045e8a5b053b7acdffeed.camel@gmail.com>
 <cbff1224-39c0-4555-a688-53e921065b97@linux.dev>
 <69410e766d68f4e69400ba9b1c3b4c56feaa2ca2.camel@gmail.com>
 <CAEf4Bzb0LdSPnFZ-kPRftofA6LsaOkxXLN4_fr9BLR3iG-te-g@mail.gmail.com>
 <67a4b5b8bdb24a80c1289711c7c156b6c8247403.camel@gmail.com>
 <CAEf4BzZ8tAXQtCvUEEELy8S26Wf7OEO6APSprQFEBND7M_FXrQ@mail.gmail.com>
 <1c2e09212c4ac27345083a3c374dd82b0bbfdf2f.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <1c2e09212c4ac27345083a3c374dd82b0bbfdf2f.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/5/24 3:52 PM, Eduard Zingerman wrote:
> On Thu, 2024-01-04 at 17:05 -0800, Andrii Nakryiko wrote:
> [...]
>>> The test is actually quite minimal, the longest part is conjuring of
>>> varying offset pointer in r2, here it is with additional comments:
>>>
>>>      /* Write 0 or 100500 to fp-16, 0 is on the first verification pass */
>>>      "call %[bpf_get_prandom_u32];"
>>>      "r9 = 100500;"
>>>      "if r0 > 42 goto +1;"
>>>      "r9 = 0;"
>>>      "*(u64 *)(r10 - 16) = r9;"
>>>      /* prepare a variable length access */
>>>      "call %[bpf_get_prandom_u32];"
>>>      "r0 &= 0xf;" /* r0 range is [0; 15] */
>>>      "r1 = -1;"
>>>      "r1 -= r0;"  /* r1 range is [-16; -1] */
>>>      "r2 = r10;"
>>>      "r2 += r1;"  /* r2 range is [fp-16; fp-1] */
>>>      /* do a variable length write of constant 0 */
>>>      "r0 = 0;"
>>>      "*(u8 *)(r2 + 0) = r0;"
> [...]
>> Yes, and the test fails, but if you read the log, you'll see that fp-8
>> is never marked precise, but it should. So we need more elaborate test
>> that would somehow exploit fp-8 imprecision.
> Sorry, I don't understand why fp-8 should be precise for this particular test.
> Only value read from fp-16 is used in precise context.
>
> [...]
>> So keep both read and write as variable offset. And we are saved by
>> some missing logic in read_var_off that would set r2 as known zero
>> (because it should be for the branch where both fp-8 and fp-16 are
>> zero). But that fails in the branch that should succeed, and if that
>> branch actually succeeds, I suspect the branch where we initialize
>> with non-zero r9 will erroneously succeed.
>>
>> Anyways, I still claim that we are mishandling a precision of spilled
>> register when doing zero var_off writes.
> Currently check_stack_read_var_off() has two possible outcomes:
> - if all bytes at varying offset are STACK_ZERO destination register
>    is set to zero;
> - otherwise destination register is set to unbound scalar.
>
> Unless I missed something, STACK_ZERO is assigned to .slot_type only
> in check_stack_write_fixed_off(), and there the source register is
> marked as precise immediately.
>
> So, it appears to me that current state of patch #1 is ok.
>
> In case if check_stack_read_var_off() would be modified to check not
> only for STACK_ZERO, but also for zero spills, I think that all such
> spills would have to be marked precise at the time of read,
> as backtracking would not be able to find those later.

I don't understand the above. If the code pattern looks like
   r1 = ...; /* r1 range [-32, -16);
   *(u8 *)(r10 + r1) = r2;
   ...
   r3 = *(u8 *)(r10 + r1);
   r3 needs to be marked as precise.

Conservatively marking r2 in '*(u8 *)(r10 + r1) = r2' as precise
should be the correct way to do.

Or you are thinking even more complex code pattern like
   *(u64 *)(r10 - 32) = r4;
   *(u64 *)(r10 - 24) = r5;
   ...
   r1 = ...; /* r1 range [-32, -16) */
   r3 = *(u8 *)(r10 + r1);
   r3 needs to be marked as precise.

In this case, we should proactively mark r4 and r5 as precise.
But currently we did not do it, right?
I think this later case is a very unlikely case.

> But that is not related to change in check_stack_write_var_off()
> introduced by this patch.

