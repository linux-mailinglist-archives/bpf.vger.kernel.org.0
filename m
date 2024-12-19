Return-Path: <bpf+bounces-47344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D277E9F8369
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 19:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07BDB188AD66
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 18:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601081A3BAD;
	Thu, 19 Dec 2024 18:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eoCz8Xnn"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BA81A2642
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734633560; cv=none; b=DH1Z9ALoeaWNcMFZKzsUjhKNDwM8g8HmKFwGXqh+WS2Qou5yPrvLCv6zDStwrIFFoVQMZ2otF5tS0PmlIM+ddctMFWBJbFVz3M/FbMoKFA7yFvcx7Iccwq0sS1Ysw1CdndwWmunjd4Cupy9iQ/SbNp1VqpCzm5fdrHGR8qOeI2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734633560; c=relaxed/simple;
	bh=+iNJ/DTZzawaklcwcuquqDi9FB586pa9Bn/Z+ooiiig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9cmu28/kDJEMe0nT7HTSJHRimwzzqdiXqslOkzy2WfjXullyb7rSt3P25lnOTgqWQCl1ScatT6tN0O63bwCVtAaKyhvv9RwJGmkFCjdgNCvRykS4b25qd5Lk9brvU6w4Q4+IbrmH8iD+rK9Z2XMalrHh3cTNXYqx+IUG5ZXuck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eoCz8Xnn; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8ae5a9ec-33b1-4228-bde1-f155fd639c84@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734633555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r4Q971WLG9PjntoRz+Mu6SncprLe7VNedUk7IW3MVeE=;
	b=eoCz8XnncbwuL0pEA/cOzrZIE6PgMSgxv4n3Ri3yaXxIKcuDUwkS1/YrkamY+r/DueR7xB
	M0loSklMHBy9SdxP1eJFtuW3lXB5dBVB3YzDXe388o13HBZLuIWlgrdW1MPrkWDU5bhwQm
	MImVHGJntWHDxj8+1A4ElVaK6kn4KNs=
Date: Thu, 19 Dec 2024 10:39:09 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: Fix deadlock when freeing cgroup storage
Content-Language: en-GB
To: Abel Wu <wuyun.abel@bytedance.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 David Vernet <void@manifault.com>
Cc: "open list:BPF [STORAGE & CGROUPS]" <bpf@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241218092149.42339-1-wuyun.abel@bytedance.com>
 <eb9d4609-970e-4760-af94-8e48cca7ec23@linux.dev>
 <9c53734d-9185-46b7-b07d-bf24ac06e688@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <9c53734d-9185-46b7-b07d-bf24ac06e688@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




On 12/19/24 4:38 AM, Abel Wu wrote:
> Hi Yonghong,
>
> On 12/19/24 10:45 AM, Yonghong Song Wrote:
>>
>>
>>
>> On 12/18/24 1:21 AM, Abel Wu wrote:
>>> The following commit
>>> bc235cdb423a ("bpf: Prevent deadlock from recursive 
>>> bpf_task_storage_[get|delete]")
>>> first introduced deadlock prevention for fentry/fexit programs 
>>> attaching
>>> on bpf_task_storage helpers. That commit also employed the logic in map
>>> free path in its v6 version.
>>>
>>> Later bpf_cgrp_storage was first introduced in
>>> c4bcfb38a95e ("bpf: Implement cgroup storage available to 
>>> non-cgroup-attached bpf progs")
>>> which faces the same issue as bpf_task_storage, instead of its busy
>>> counter, NULL was passed to bpf_local_storage_map_free() which opened
>>> a window to cause deadlock:
>>>
>>>     <TASK>
>>>     _raw_spin_lock_irqsave+0x3d/0x50
>>>     bpf_local_storage_update+0xd1/0x460
>>>     bpf_cgrp_storage_get+0x109/0x130
>>>     bpf_prog_72026450ec387477_cgrp_ptr+0x38/0x5e
>>>     bpf_trace_run1+0x84/0x100
>>>     cgroup_storage_ptr+0x4c/0x60
>>>     bpf_selem_unlink_storage_nolock.constprop.0+0x135/0x160
>>>     bpf_selem_unlink_storage+0x6f/0x110
>>>     bpf_local_storage_map_free+0xa2/0x110
>>>     bpf_map_free_deferred+0x5b/0x90
>>>     process_one_work+0x17c/0x390
>>>     worker_thread+0x251/0x360
>>>     kthread+0xd2/0x100
>>>     ret_from_fork+0x34/0x50
>>>     ret_from_fork_asm+0x1a/0x30
>>>     </TASK>
>>>
>>>     [ Since the verifier treats 'void *' as scalar which
>>>       prevents me from getting a pointer to 'struct cgroup *',
>>>       I added a raw tracepoint in cgroup_storage_ptr() to
>>>       help reproducing this issue. ]
>>>
>>> Although it is tricky to reproduce, the risk of deadlock exists and
>>> worthy of a fix, by passing its busy counter to the free procedure so
>>> it can be properly incremented before storage/smap locking.
>>
>> The above stack trace and explanation does not show that we will have
>> a potential dead lock here. You mentioned that it is tricky to 
>> reproduce,
>> does it mean that you have done some analysis or coding to reproduce it?
>> Could you share the details on why you think we may have deadlock here?
>
> The stack is A-A deadlocked: cgroup_storage_ptr() is called with
> storage->lock held, while the bpf_prog attaching on this function
> also tries to acquire the same lock by calling bpf_cgrp_storage_get()
> thus leading to a AA deadlock.
>
> The tricky part is, instead of attaching on cgroup_storage_ptr()
> directly, I added a tracepoint inside it to hook:
>
> ------
> diff --git a/kernel/bpf/bpf_cgrp_storage.c 
> b/kernel/bpf/bpf_cgrp_storage.c
> index 20f05de92e9c..679209d4f88f 100644
> --- a/kernel/bpf/bpf_cgrp_storage.c
> +++ b/kernel/bpf/bpf_cgrp_storage.c
> @@ -40,6 +40,8 @@ static struct bpf_local_storage __rcu 
> **cgroup_storage_ptr(void *owner)
>  {
>         struct cgroup *cg = owner;
>
> +       trace_cgroup_ptr(cg);
> +
>         return &cg->bpf_cgrp_storage;
>  }
>
> ------
>
> The reason doing so is that typecasting from 'void *owner' to
> 'struct cgroup *' will be rejected by the verifier. But there
> could be other ways to obtain a pointer to the @owner cgroup
> too, making the deadlock possible.

I checked the callstack and what you described indeed the case.
In function bpf_selem_unlink_storage(), local_storage->lock is
held before calling bpf_selem_unlink_storage_nolock/cgroup_storage_ptr.
If there is a fentry/tracepoint on the cgroup_storage_ptr and then we could
have a deadlock as you described in the above.

As you mentioned, it is tricky to reproduce. fentry on cgroup_storage_ptr
does not work due to func signature:
   struct bpf_local_storage __rcu **cgroup_storage_ptr(void *owner)
Even say we support 'void *' for fentry and we do bpf_rdonly_cast()
to cast 'void *owner' to 'struct cgroup *owner', and owner cannot be
passed to helper/kfunc.

Your fix looks good but it would be great to have a reproducer.
One possibility is to find a function which can be fentried within
local_storage->lock. If you know the cgroup id, in bpf program you
can use bpf_cgroup_from_id() to get a trusted cgroup ptr from the id.
and then you can use that cgroup ptr to do bpf_cgrp_storage_get() etc.
which should be able to triger deadlock. Could you give a try?

Also, in your commit message, it will be great if you can illustrage
where each lock happens, e.g.
    local_storage->lock
      bpf_selem_unlink_storage_nolock.constprop.0
        ...
        bpf_local_storage_update
          ...
          local_storage->lock
          ...
    

>
> Thanks,
>     Abel
>
>>
>>>
>>> Fixes: c4bcfb38a95e ("bpf: Implement cgroup storage available to 
>>> non-cgroup-attached bpf progs")
>>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>>> ---
>>>   kernel/bpf/bpf_cgrp_storage.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/bpf/bpf_cgrp_storage.c 
>>> b/kernel/bpf/bpf_cgrp_storage.c
>>> index 20f05de92e9c..7996fcea3755 100644
>>> --- a/kernel/bpf/bpf_cgrp_storage.c
>>> +++ b/kernel/bpf/bpf_cgrp_storage.c
>>> @@ -154,7 +154,7 @@ static struct bpf_map 
>>> *cgroup_storage_map_alloc(union bpf_attr *attr)
>>>   static void cgroup_storage_map_free(struct bpf_map *map)
>>>   {
>>> -    bpf_local_storage_map_free(map, &cgroup_cache, NULL);
>>> +    bpf_local_storage_map_free(map, &cgroup_cache, 
>>> &bpf_cgrp_storage_busy);
>>>   }
>>>   /* *gfp_flags* is a hidden argument provided by the verifier */
>>
>


