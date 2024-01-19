Return-Path: <bpf+bounces-19871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A268323DD
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 04:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5D2286F0A
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 03:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C551870;
	Fri, 19 Jan 2024 03:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LFulBc6j"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EB617F5
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 03:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705635930; cv=none; b=LQg2fK82LJ+/oKFSS8tFyAYCM57Op4rlbRzUdmbyxL+1QPv+2GZT9ps3blry0625ldWusanZT44dr0NzSty88WfYo3Td7Gj+vBWnGxlAMh32ixskIMzFyM6TJC/0clJBWMRLhrWC3a24F4woAlBG15j4VGtM6xv+U2giRaLaltg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705635930; c=relaxed/simple;
	bh=2U0bcCu2xZryThiaX/4P9zxDWmLpTALZZ+P6LmbGOlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LOazDa2YRJCrZpAxlqhQWiBsRIdYz/g8qZp1vdKV3wT/qQEH7QMvrnHtxJ4IHYN70xj9BuvkyFwPoXvYYpqzLUdQ8C+ZjU4ya+oD1OFBo3OCzFJXiFrpbZAzfyCf4ZcuyAX3eX76OyQJoFq+/snj/XPcOCNPijB+ViE720OjhSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LFulBc6j; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <26d90b2c-72ce-4c3f-8c88-08ea3e605f3a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705635925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=holevQZibf3UYG/1+9tz+7iXBpW6lsskKeYUcJOjbXs=;
	b=LFulBc6jBI88dyB4Q6KTaeJrCyzpLCHP+e4QrI1FDpECTtspoWZ9WUQ2W6QxKEmqGJ6311
	1drjkMsGO0IR0B8HC26EOLejbKQW9RmhQBZUYVLsC3Y29AWUvszaxpGFq9mR0xVX801aT2
	ejoi0FVXbBMCpA3idVYa5x2cQ4GslLw=
Date: Thu, 18 Jan 2024 19:45:17 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: Add bpf_iter_cpumask kfuncs
Content-Language: en-GB
To: Hou Tao <houtao@huaweicloud.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, tj@kernel.org, andrii@kernel.org,
 kpsingh@kernel.org, song@kernel.org, martin.lau@linux.dev,
 daniel@iogearbox.net, ast@kernel.org, bpf@vger.kernel.org, lkp@intel.com,
 john.fastabend@gmail.com, sdf@google.com, haoluo@google.com, jolsa@kernel.org
References: <20240117024823.4186-1-laoar.shao@gmail.com>
 <20240117024823.4186-2-laoar.shao@gmail.com>
 <a7699a08-827b-4433-99a8-bfbfda1d38af@linux.dev>
 <a5c077b5-5575-f1a8-9a65-b3877af56c0d@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <a5c077b5-5575-f1a8-9a65-b3877af56c0d@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/18/24 4:51 PM, Hou Tao wrote:
> Hi,
>
> On 1/19/2024 6:27 AM, Yonghong Song wrote:
>> On 1/16/24 6:48 PM, Yafang Shao wrote:
>>> Add three new kfuncs for bpf_iter_cpumask.
>>> - bpf_iter_cpumask_new
>>>     It is defined with KF_RCU_PROTECTED and KF_RCU.
>>>     KF_RCU_PROTECTED is defined because we must use it under the
>>>     protection of RCU.
>>>     KF_RCU is defined because the cpumask must be a RCU trusted pointer
>>>     such as task->cpus_ptr.
>> I am not sure whether we need both or not.
>>
>> KF_RCU_PROTECTED means the function call needs within the rcu cs.
>> KF_RCU means the argument usage needs within the rcu cs.
>> We only need one of them (preferrably KF_RCU).
>>
>>> - bpf_iter_cpumask_next
>>> - bpf_iter_cpumask_destroy
>>>
>>> These new kfuncs facilitate the iteration of percpu data, such as
>>> runqueues, psi_cgroup_cpu, and more.
>>>
>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>>> ---
>>>    kernel/bpf/cpumask.c | 69 ++++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 69 insertions(+)
>>>
>>> diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
>>> index 2e73533a3811..1840e48e6142 100644
>>> --- a/kernel/bpf/cpumask.c
>>> +++ b/kernel/bpf/cpumask.c
>>> @@ -422,6 +422,72 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct
>>> cpumask *cpumask)
>>>        return cpumask_weight(cpumask);
>>>    }
>>>    +struct bpf_iter_cpumask {
>>> +    __u64 __opaque[2];
>>> +} __aligned(8);
>>> +
>>> +struct bpf_iter_cpumask_kern {
>>> +    const struct cpumask *mask;
>>> +    int cpu;
>>> +} __aligned(8);
>>> +
>>> +/**
>>> + * bpf_iter_cpumask_new() - Create a new bpf_iter_cpumask for a
>>> specified cpumask
>>> + * @it: The new bpf_iter_cpumask to be created.
>>> + * @mask: The cpumask to be iterated over.
>>> + *
>>> + * This function initializes a new bpf_iter_cpumask structure for
>>> iterating over
>>> + * the specified CPU mask. It assigns the provided cpumask to the
>>> newly created
>>> + * bpf_iter_cpumask @it for subsequent iteration operations.
>>> + *
>>> + * On success, 0 is returen. On failure, ERR is returned.
>>> + */
>>> +__bpf_kfunc int bpf_iter_cpumask_new(struct bpf_iter_cpumask *it,
>>> const struct cpumask *mask)
>>> +{
>>> +    struct bpf_iter_cpumask_kern *kit = (void *)it;
>>> +
>>> +    BUILD_BUG_ON(sizeof(struct bpf_iter_cpumask_kern) >
>>> sizeof(struct bpf_iter_cpumask));
>>> +    BUILD_BUG_ON(__alignof__(struct bpf_iter_cpumask_kern) !=
>>> +             __alignof__(struct bpf_iter_cpumask));
>>> +
>>> +    kit->mask = mask;
>>> +    kit->cpu = -1;
>>> +    return 0;
>>> +}
>> We have problem here. Let us say bpf_iter_cpumask_new() is called
>> inside rcu cs.
>> Once the control goes out of rcu cs, 'mask' could be freed, right?
>> Or you require bpf_iter_cpumask_next() needs to be in the same rcu cs
>> as bpf_iter_cpumask_new(). But such a requirement seems odd.
> So the case is possible when using bpf_iter_cpumask_new() and
> bpf_iter_cpumask_next() in sleepable program and these two kfuncs are
> used in two different rcu_read_lock/rcu_read_unlock code blocks, right ?

Right, or bpf_iter_cpumask_new() inside rcu cs and bpf_iter_cpumask_next() not.

>> I think we can do things similar to bpf_iter_task_vma. You can
>> allocate memory
>> with bpf_mem_alloc() in bpf_iter_cpumask_new() to keep a copy of mask.
>> This
>> way, you do not need to worry about potential use-after-free issue.
>> The memory can be freed with bpf_iter_cpumask_destroy().
>>
>>> +
>>> +/**
>>> + * bpf_iter_cpumask_next() - Get the next CPU in a bpf_iter_cpumask
>>> + * @it: The bpf_iter_cpumask
>>> + *
>>> + * This function retrieves a pointer to the number of the next CPU
>>> within the
>>> + * specified bpf_iter_cpumask. It allows sequential access to CPUs
>>> within the
>>> + * cpumask. If there are no further CPUs available, it returns NULL.
>>> + *
>>> + * Returns a pointer to the number of the next CPU in the cpumask or
>>> NULL if no
>>> + * further CPUs.
>>> + */
>>> +__bpf_kfunc int *bpf_iter_cpumask_next(struct bpf_iter_cpumask *it)
>>> +{
>>> +    struct bpf_iter_cpumask_kern *kit = (void *)it;
>>> +    const struct cpumask *mask = kit->mask;
>>> +    int cpu;
>>> +
>>> +    cpu = cpumask_next(kit->cpu, mask);
>>> +    if (cpu >= nr_cpu_ids)
>>> +        return NULL;
>>> +
>>> +    kit->cpu = cpu;
>>> +    return &kit->cpu;
>>> +}
>>> +
>>> +/**
>>> + * bpf_iter_cpumask_destroy() - Destroy a bpf_iter_cpumask
>>> + * @it: The bpf_iter_cpumask to be destroyed.
>>> + */
>>> +__bpf_kfunc void bpf_iter_cpumask_destroy(struct bpf_iter_cpumask *it)
>>> +{
>>> +}
>>> +
>>>    __bpf_kfunc_end_defs();
>>>      BTF_SET8_START(cpumask_kfunc_btf_ids)
>>> @@ -450,6 +516,9 @@ BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
>>>    BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
>>>    BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
>>>    BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
>>> +BTF_ID_FLAGS(func, bpf_iter_cpumask_new, KF_ITER_NEW |
>>> KF_RCU_PROTECTED | KF_RCU)
>>> +BTF_ID_FLAGS(func, bpf_iter_cpumask_next, KF_ITER_NEXT | KF_RET_NULL)
>>> +BTF_ID_FLAGS(func, bpf_iter_cpumask_destroy, KF_ITER_DESTROY)
>>>    BTF_SET8_END(cpumask_kfunc_btf_ids)
>>>      static const struct btf_kfunc_id_set cpumask_kfunc_set = {
>> .

