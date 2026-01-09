Return-Path: <bpf+bounces-78408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA90D0C66D
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 22:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6B5B30393FD
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 21:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8556C33E348;
	Fri,  9 Jan 2026 21:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BpXSOh+L"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4608222AE65
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 21:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767995816; cv=none; b=U1vx6uO0eKxdHrZ9T/3duDpY02zjfXu1/TJGFipomgGmzhZDoHVdS4+QrffWAooMJ50wbUEPhBny3+ZSrLNthR9s31tGJz3zQoWTBWWCZDkV8IMJ6qTva12n+Hyf9uVgu+x1jneSQLWrs3VuBNeCk8SQWg/IsJTCkvEvCHXKay8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767995816; c=relaxed/simple;
	bh=6ZnbqF7/kXh5P0Ia9WUeE2BLIbZDXhE7dBGh2KAO1WQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ezWsgqfx26Ixo0e+BEVEaf8AzLQNK3hMYImC1S1HUV2K5s7623LHLIwzP3HFO9Ku/mvW0D+G4xchY2tpShkauQVoDFhze1s0N1MXlM9BkAP68y40r/E+/4NVZuyGCcyQY2mE18sCWeUdRIbLuZR5daB7UCb6y39MVQyp8PLb+JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BpXSOh+L; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f0e63b55-65c3-4367-b3da-275df18147a1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767995802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nHltPQvu0bb8b9qFGSmvXZdn22+rgNKMValwGJobJKw=;
	b=BpXSOh+LAYUeeksBKEmd/uUTGZ1ZZmWzxY2lIc+BqkFPTMpELsMayzEqBJvKZBIcGGvH8r
	lJ0jVgMfSQAfUJnjASoBRjGN5Aj8Fwp2Kx+HSKs51Vbm00DBMITy1PRC7JO4HqbK7WSHhr
	KFh77kVnvy5wkA+22OZH0srsTooBe+c=
Date: Fri, 9 Jan 2026 13:56:26 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 08/10] bpf: Add bpf_task_work_schedule_*
 kfuncs with KF_IMPLICIT_ARGS
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQ+k-nbq-2PGRSPJDRZ3G9sp9zu3Owqsj7zqO_G+3OQEww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/9/26 1:49 PM, Alexei Starovoitov wrote:
> On Fri, Jan 9, 2026 at 1:39 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> On 1/9/26 12:47 PM, Alexei Starovoitov wrote:
>>> On Fri, Jan 9, 2026 at 12:02 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>>>
>>>> On 1/9/26 11:58 AM, Alexei Starovoitov wrote:
>>>>> On Fri, Jan 9, 2026 at 10:50 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>>>>>
>>>>>> +__bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct bpf_task_work *tw,
>>>>>> +                                             void *map__map, bpf_task_work_callback_t callback,
>>>>>> +                                             struct bpf_prog_aux *aux)
>>>>>> +{
>>>>>> +       return bpf_task_work_schedule(task, tw, map__map, callback, aux, TWA_SIGNAL);
>>>>>> +}
>>>>>> +
>>>>>>  __bpf_kfunc int bpf_task_work_schedule_signal_impl(struct task_struct *task,
>>>>>>                                                    struct bpf_task_work *tw, void *map__map,
>>>>>>                                                    bpf_task_work_callback_t callback,
>>>>>>                                                    void *aux__prog)
>>>>>>  {
>>>>>> -       return bpf_task_work_schedule(task, tw, map__map, callback, aux__prog, TWA_SIGNAL);
>>>>>> +       return bpf_task_work_schedule_signal(task, tw, map__map, callback, aux__prog);
>>>>>>  }
>>>>>
>>>>> I thought we decided that _impl() will not be marked as __bpf_kfunc
>>>>> and will not be in BTF_ID(func, _impl).
>>>>> We can mark it as __weak noinline and it will be in kallsyms.
>>>>> That's all we need for the verifier and resolve_btfid, no?
>>>>>
>>>>> Sorry, it's been a long time. I must have forgotten something.
>>>>
>>>> For the *generated* _impl kfuncs there is no decl tags and the ids are
>>>> absent from BTF_ID sets, yes.
>>>>
>>>> However for the "legacy" cases it must be there for backwards
>>>> compatibility, as well as relevant verifier checks.
>>>
>>> I see.
>>> I feel bpf_task_work_schedule_resume() is ok to break, since it's so new.
>>> We can remove bpf_task_work_schedule_[resume|singal]_impl()
>>> to avoid carrying forward forever.
>>>
>>> bpf_stream_vprintk_impl() is not that clear. I would remove it too.
>>
>> That leaves only bpf_wq_set_callback_impl(). Can we break that too?
> 
> Sounds like Benjamin is ok removing it.
> So I think we can indeed remove them all.
> 
>> Then there won't be legacy cases at all. It was introduced in v6.16
>> along the with __prog suffix [1][2].
>>
>> If we go this route, we could clean up __prog support/docs too.
>>
>> I think it's worth it to make an "all or nothing" decision here:
>> either break all 4 existing kfuncs, or backwards-support all of them.
> 
> I don't see why "all or nothing" is a good thing.
> It won't be "all" anyway.
> We have bpf_rbtree_add_impl(), bpf_list_push_front_impl(), etc.
> And those we cannot remove. sched-ext is using them.
> Another few categories are bpf_obj_new_impl(), bpf_obj_drop_impl().
> There are not __prog type, but conceptually the same thing and
> KF_IMPLICIT_ARGS should support them too eventually.

I was thinking we could remove/simplify code relevant to backwards
compat of existing _impl kfuncs. But you're right, if we start using
implicit args for other types/kfuncs, the "legacy" case still has to
work.

Ok, in the next revision I'll remove all the __prog users, but leave
the "legacy" case support in place for future use.

> 
> 
>> git tag --contains bc049387b41f | grep -v rc
>> v6.16
>> v6.17
>> v6.18
>>
>> [1] https://lore.kernel.org/all/20250513142812.1021591-1-memxor@gmail.com/
>> [2] https://lore.kernel.org/all/20240420-bpf_wq-v2-13-6c986a5a741f@kernel.org/
>>
>>


