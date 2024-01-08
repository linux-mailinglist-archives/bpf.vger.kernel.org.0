Return-Path: <bpf+bounces-19228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539C4827A6E
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 22:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B831C22EB1
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 21:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1668F5644D;
	Mon,  8 Jan 2024 21:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q/X3YOsx"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD205645B
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 21:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a9e87ef0-5cac-4088-ba2e-ae5d250eaad8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704750676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9yG32KJ6m0+N2RJEpUSw+XFBsmqaecZy6B+KZlREIVo=;
	b=Q/X3YOsxqwVmwHbi9WGvoSXG/cvUmyNmlF6mEADxMacJURvsmxKbF4VV/daShuYbE2/2HE
	OI7/9OUESChXp8mX9h1g/4FnqDy3EWWoiNNAS7ug4oqAaGZa7lt9B1eV5AWJdCcRnA3WRM
	XJcxA3+hVL5CASFA0PO8zIaIbskZ2Bk=
Date: Mon, 8 Jan 2024 13:51:07 -0800
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
 <60c5be25-5c35-4e47-948b-66cc8b1b4feb@linux.dev>
 <60cd23a09c8fe6ea45af151b6e806e456a0b120c.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <60cd23a09c8fe6ea45af151b6e806e456a0b120c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/8/24 12:05 PM, Eduard Zingerman wrote:
> On Mon, 2024-01-08 at 11:51 -0800, Yonghong Song wrote:
> [...]
>>> In case if check_stack_read_var_off() would be modified to check not
>>> only for STACK_ZERO, but also for zero spills, I think that all such
>>> spills would have to be marked precise at the time of read,
>>> as backtracking would not be able to find those later.
>> I don't understand the above. If the code pattern looks like
>>     r1 = ...; /* r1 range [-32, -16);
>>     *(u8 *)(r10 + r1) = r2;
>>     ...
>>     r3 = *(u8 *)(r10 + r1);
>>     r3 needs to be marked as precise.
>>
>> Conservatively marking r2 in '*(u8 *)(r10 + r1) = r2' as precise
>> should be the correct way to do.
>>
>> Or you are thinking even more complex code pattern like
>>     *(u64 *)(r10 - 32) = r4;
>>     *(u64 *)(r10 - 24) = r5;
>>     ...
>>     r1 = ...; /* r1 range [-32, -16) */
>>     r3 = *(u8 *)(r10 + r1);
>>     r3 needs to be marked as precise.
>>
>> In this case, we should proactively mark r4 and r5 as precise.
>> But currently we did not do it, right?
> Yes, I'm thinking about the latter scenario.
> There would be zero spills for fp-32 and fp-24.
> If check_stack_read_var_off() is modified to handle zero spills,
> then it would conclude that r3 is zero.
> But if r3 is later marked precise, there would be no info for
> backtracking to mark fp-32, fp-24, r4, r5 as precise:
> - either backtracking info would have to be supplemented with a list
>    of stack locations that were spilled zeros at time of
>    check_stack_read_var_off();
> - or check_stack_read_var_off() would need to conservatively mark
>    all spilled zeros as precise.
>
> Nothing like that is needed now, because check_stack_read_var_off()
> would return unbound scalar for r3 upon seeing zero spill.
>
>> I think this later case is a very unlikely case.
> But it is possible and verifier has to be conservative.

Indeed. Such variable stack read has been handled properly.

Now I think I understand better on how verifier works for
load/store with var offsets. Basically some small changes
in check_stack_write_var_off(). Will post v3 soon.


