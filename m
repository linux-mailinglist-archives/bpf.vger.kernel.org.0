Return-Path: <bpf+bounces-1610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E50071F112
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 19:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F251C210DF
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 17:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA4948227;
	Thu,  1 Jun 2023 17:47:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B9E42501
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 17:47:07 +0000 (UTC)
Received: from out-50.mta0.migadu.com (out-50.mta0.migadu.com [IPv6:2001:41d0:1004:224b::32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2CA13E
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 10:47:05 -0700 (PDT)
Message-ID: <7e09f647-da79-4088-4579-1520e3fd8427@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1685641623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3LY1ZYjFBTj7xg00T1VOeO53CX7VMzfrAWCy8Z4DGs=;
	b=j/SIUv/+xYCC9hOV0WOdofKeu3vx6E6+DhXDkUAUVO7Tt5W4txiLtca6KjlrdqLX7VADPL
	aZ0tP+ASptP+H2/lbT1rbtExfJp1mNP4OWu0/l/qL5qbPfzusJSw9HoGzh0chnAu85G5zZ
	2jd4PohftOCKez2KaojRejtJMbfRQbc=
Date: Thu, 1 Jun 2023 10:47:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: Fix UAF in task local storage
Content-Language: en-US
To: Song Liu <songliubraving@meta.com>, KP Singh <kpsingh@kernel.org>
Cc: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
 Martin Lau <kafai@meta.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 Kuba Piecuch <jpiecuch@google.com>
References: <20230601122622.513140-1-kpsingh@kernel.org>
 <CAPhsuW45Sb0TeOYouTvaVDhOGfz+2nBht0AmGyF4=yq15HE8AA@mail.gmail.com>
 <CACYkzJ7S7JwX77NSSurr1wWYnFQs0TZwUKcwW5Zmva3CkkAx5w@mail.gmail.com>
 <5486EA34-136F-45EA-BD9B-EA54EC436CA1@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <5486EA34-136F-45EA-BD9B-EA54EC436CA1@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/1/23 9:54 AM, Song Liu wrote:
> 
> 
>> On Jun 1, 2023, at 9:27 AM, KP Singh <kpsingh@kernel.org> wrote:
>>
>> On Thu, Jun 1, 2023 at 6:18 PM Song Liu <song@kernel.org> wrote:
>>>
>>> On Thu, Jun 1, 2023 at 5:26 AM KP Singh <kpsingh@kernel.org> wrote:
>>>>
>>>> When the the task local storage was generalized for tracing programs, the
>>>> bpf_task_local_storage callback was moved from a BPF LSM hook callback
>>>> for security_task_free LSM hook to it's own callback. But a failure case
>>>> in bad_fork_cleanup_security was missed which, when triggered, led to a dangling
>>>> task owner pointer and a subsequent use-after-free.
>>>>
>>>> This issue was noticed when a BPF LSM program was attached to the
>>>> task_alloc hook on a kernel with KASAN enabled. The program used
>>>> bpf_task_storage_get to copy the task local storage from the current
>>>> task to the new task being created.
>>>
>>> This is pretty tricky. Let's add a selftest for this.
>>
>> I don't have an easy repro for this (the UAF does not trigger
>> immediately), Also I am not sure how one would test a UAF in a
>> selftest. What actually happens is:
>>
>> * We have a dangling task pointer in local storage.
>> * This is used sometime later which then leads to weird memory
>> corruption errors.
> 
> I think we will see it easily with KASAN, no?
> 
>>
>>>
>>>>
>>>> Fixes: a10787e6d58c ("bpf: Enable task local storage for tracing programs")
>>>> Reported-by: Kuba Piecuch <jpiecuch@google.com>
>>>> Signed-off-by: KP Singh <kpsingh@kernel.org>
>>>> ---
>>>>
>>>> This fixes the regression from the LSM blob based implementation, we can
>>>> still have UAFs, if bpf_task_storage_get is invoked after bpf_task_storage_free
>>>> in the cleanup path.
>>>
>>> Can we fix this by calling bpf_task_storage_free() from free_task()?
>>
>> I think we can yeah. But, this is yet another deviation from how the
>> security blob is managed (security_task_free) frees the blob that we
>> were previously using.

Does it mean doing bpf_task_storage_free() in free_task() will break some use 
cases? Could you explain?
Doing bpf_task_storage_free() in free_task() seems to be more straight forward.

> 
> Yeah, this will make the code even more tricky.
> 
> Another idea I had is to filter on task->__state in the helper. IOW,
> task local storage does not work on starting or died tasks. But I am
> not sure whether this will make BPF_LSM less effective (not covering
> certain tasks).
> 
> Thanks,
> Song
> 
> 


