Return-Path: <bpf+bounces-78611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 957A0D14D06
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 19:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1E15303EBA4
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 18:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56323876D4;
	Mon, 12 Jan 2026 18:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bw3Ys4yY"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BED43815C5
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768244054; cv=none; b=iWl7NcQlHRDMqqtzVUcZgaNANeSYjyl43Bwy4eQQyrubL+JXaF+/01D60GVkXAMXg4Qs9lklmHKNTYRO3pWxbEY5993lcAMxWZabqZ2MEgxJqD+zgzZUtC+hrA9XpQT6qHycvHlkVC3r2NVBXAXf7fTtJNHrcqq7ZYsnYvpAvX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768244054; c=relaxed/simple;
	bh=QqykXITTByyTT+FGlcEOND0SlMloNxcQl9qxBKW1MJ0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cXOU8m4NqRGboV9XrwJBj4+JVSGam2miQe4oU61uWucxqiwwZqNQpKS405+0NFRg6dcWbKan6qPFw+SmjLXBcT677+zlwLaWg4nL5JnyBGtanb6gkm4HKQ8Prz3wv6Y52uAaoAY4Es5VDhY+3gQFVq3bW5cGvZOAkoUJPUwhzGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bw3Ys4yY; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3a697699-ffcb-4e2f-a7a4-9e3f571aa402@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768244039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9vtTJ8E+WsBFblmJc5UE1EN6AZB8Sa5imYu+eocYP4=;
	b=Bw3Ys4yYFJsGcrFo94H7o4SnkRA4tr8AFowTqSo0kSbLHRH2fm7D/evq7AdA/S2U9Y/TG4
	T62PnUk+mExAbwv2FPR7pjVaQJCHzjjl8B+lHaA2tGuvkeRlpe6l9qLum4aAB576+c6rnd
	mWcYkqF0IzDnkAW7JNrPExrWO7RglpU=
Date: Mon, 12 Jan 2026 10:53:53 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 08/10] bpf: Add bpf_task_work_schedule_*
 kfuncs with KF_IMPLICIT_ARGS
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>,
 Tejun Heo <tj@kernel.org>, Alan Maguire <alan.maguire@oracle.com>,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
 sched-ext@lists.linux.dev
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
 <20260109184852.1089786-9-ihor.solodrai@linux.dev>
 <CAADnVQJDv80_T+1jz=7_8y+8hRTjMqqkm38in2er8iRU-p9W+g@mail.gmail.com>
 <b099a95e-5e69-4eeb-a2c9-9a52b8042a85@linux.dev>
 <CAADnVQ+_AmiwuupkVJTGyKY3KOp68GLuivs2LMEr0M_yaHPUUg@mail.gmail.com>
 <0c4d84ab-1725-45bc-9c1c-8bdc1f5fc032@linux.dev>
 <CAADnVQ+k-nbq-2PGRSPJDRZ3G9sp9zu3Owqsj7zqO_G+3OQEww@mail.gmail.com>
 <f0e63b55-65c3-4367-b3da-275df18147a1@linux.dev>
Content-Language: en-US
In-Reply-To: <f0e63b55-65c3-4367-b3da-275df18147a1@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/9/26 1:56 PM, Ihor Solodrai wrote:
> On 1/9/26 1:49 PM, Alexei Starovoitov wrote:
>> On Fri, Jan 9, 2026 at 1:39 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>>
>>> [...]
>>>
>>>> I feel bpf_task_work_schedule_resume() is ok to break, since it's so new.
>>>> We can remove bpf_task_work_schedule_[resume|singal]_impl()
>>>> to avoid carrying forward forever.
>>>>
>>>> bpf_stream_vprintk_impl() is not that clear. I would remove it too.
>>>
>>> That leaves only bpf_wq_set_callback_impl(). Can we break that too?
>>
>> Sounds like Benjamin is ok removing it.
>> So I think we can indeed remove them all.
>>
>>> Then there won't be legacy cases at all. It was introduced in v6.16
>>> along the with __prog suffix [1][2].
>>>
>>> If we go this route, we could clean up __prog support/docs too.
>>>
>>> I think it's worth it to make an "all or nothing" decision here:
>>> either break all 4 existing kfuncs, or backwards-support all of them.
>>
>> I don't see why "all or nothing" is a good thing.
>> It won't be "all" anyway.
>> We have bpf_rbtree_add_impl(), bpf_list_push_front_impl(), etc.
>> And those we cannot remove. sched-ext is using them.
>> Another few categories are bpf_obj_new_impl(), bpf_obj_drop_impl().
>> There are not __prog type, but conceptually the same thing and
>> KF_IMPLICIT_ARGS should support them too eventually.
> 
> I was thinking we could remove/simplify code relevant to backwards
> compat of existing _impl kfuncs. But you're right, if we start using
> implicit args for other types/kfuncs, the "legacy" case still has to
> work.
> 
> Ok, in the next revision I'll remove all the __prog users, but leave
> the "legacy" case support in place for future use.

I just had an off-list chat with Andrii, and we agreed that leaving
the existing _impl kfuncs supported may be a good idea.

It doesn't cost us much: we keep the mechanism for legacy functions
anyways, so supporting bpf_wq_set_callback_impl() and co only requires
keeping definitions in the kernel.

The only benefit of *removing* these _impl functions is that we could
clean up __prog support.

But having backwards compat seems like a better deal.
What do you think?


> 
>>
>>
>>> git tag --contains bc049387b41f | grep -v rc
>>> v6.16
>>> v6.17
>>> v6.18
>>>
>>> [1] https://lore.kernel.org/all/20250513142812.1021591-1-memxor@gmail.com/
>>> [2] https://lore.kernel.org/all/20240420-bpf_wq-v2-13-6c986a5a741f@kernel.org/
>>>
>>>
> 


