Return-Path: <bpf+bounces-47508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 742B59F9DEF
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 03:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E0316B1A2
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 02:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8431304BA;
	Sat, 21 Dec 2024 02:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DAH6AmRi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFBC7346D
	for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 02:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734748010; cv=none; b=BZiYN8owfqaAKutpIi4B6upuF/V67VVIoRVyhlNoFJzJ5yg+MxkOH4lpiwry6m178BGJDc5L+mqhbgbvS1gHLhu0a7JtIGnNMJAN5nHAzvzk6jek+57u+0iuEXxekCZeFuHlT9psOsxoMiDlcefnCxhqO/YqAY8vvEHgMJ1KUOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734748010; c=relaxed/simple;
	bh=NW9szmfdTHoe2D3mVTpiGrD4a/s1zwDd3pWsn5khd3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idDJEHwMaW7gkNjr6tQ7XeuatgPquy4JhoBnaU8SsLPni3dPbD73AqoybK2NKanIINkes1yJ36aIHL9h4wwifLsouq/w5PQm6SZSLPtB24f7BGDwupVmc3MswgwHwum3Hzodi2aGSsD/NL43x+0iV211FHvEuuJ8zHXqvJOFZqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DAH6AmRi; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ef7733a1dcso368340a91.3
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 18:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734748006; x=1735352806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S1/RtpjEa0jCfY77azOLIMNPRe40Wb/OqOYU01ezAoA=;
        b=DAH6AmRizCvS/Mud5KTLqgIwrnlDv0R6li/g6iUhUNZP2p6RvW0/svFjUlUOvFWhN7
         NVZXp+OwziO7Gex+o0ta2qst4r5oZ+oPY+P8dCyKehBgR/yS6ureOtVGHKVa6dPR6ZwE
         FEuSvz7TVbXKNTUVwUajQVAKO8kNEAi/DB2ePCg1yl5RyigHXQ3Yyr1nlkNxPG1lUr30
         RTQp15dOLpdtdTsBDORM5b4Ha0ZgY2X4lmdrt1LwGWOLZZi3sSYLj4kPRNnyyFdpygQF
         tG2dWgZwphbTqWf86B+Aeap84efqZNcPqdDWJSIzxwScUEF+BLepbi/KShfEpveckAfU
         H1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734748006; x=1735352806;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S1/RtpjEa0jCfY77azOLIMNPRe40Wb/OqOYU01ezAoA=;
        b=HvaHMiDmdVxgK0Rol/1LpMMdUDquWRwwlkf6B3gciXLsrMu0BLL/hL5aR29iwQazEi
         EvPZyIbdUIPCQKlxgylyTwZ/fKuv7FproVz4n4awQp/z/A2LxK/dQuMyd1vmeXjdCZRq
         9XaM/T1KFmlbvLAqaJA3YRYn6nQsRcbFhsSZqPvTWSfXpVHS4BOSqfjoG+GrHI7kxplt
         RS2Z4Json5Itw99PPoKA4CZFNeBjhpOdSw5Mj8EuR72dDwRRX8nLccblZxvPvKgszQSy
         Rsp4lk57dbZMhRad2WSv5KvEmhV4gk3HurpHyVuzhG8wopipTcWf/4SD7XsB4UJaoHXz
         siUQ==
X-Gm-Message-State: AOJu0YxleAHDt+8L0d87jb8WPcGveCVM6J0L5ZNfVHLFqz+jteb5HQ6f
	cwr+ykyRLMwvZ44F8jd5Fq08UTCCY51D38rByrklbadCMgvcgh5ST04RtFYpltM=
X-Gm-Gg: ASbGncsFz1qoSI+At4I9WWqANuhHJ5qRMk6mcHWeYoTPLH3zh55XO1lM8U/efJXMkLu
	gAIw5D3PqrpNHeEvoKvjiLJbKPfHZIgpExhu+37ZX83qV/U3gUCRQh/3shQbHvyyf7t+5BLxhVg
	U8FJa1GjmSFoA8vkKdnllnCiT37jfJvomCvaGOorHDeD4DQYcEiB2xhu+DWuHgSigILwrZSD0eg
	4WeK9Qw2p3qOljADApcHpjbtwDYvgnSVXKqPF9VMX8UI6Tl01ola0FIvN01w9P9nIZH/goBh7NZ
	tA==
X-Google-Smtp-Source: AGHT+IF4wynNfJy3pyz0x62SbwCC9YoQMwr3ZU2okQLmkhhgPkALuX6ZQIDStQOsNScLbT8XOM1DTw==
X-Received: by 2002:a05:6a20:1588:b0:1e1:ac28:eab0 with SMTP id adf61e73a8af0-1e5e07f0090mr3217625637.7.1734748006277;
        Fri, 20 Dec 2024 18:26:46 -0800 (PST)
Received: from [10.4.36.140] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad816279sm3788451b3a.35.2024.12.20.18.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 18:26:45 -0800 (PST)
Message-ID: <31314078-c734-4812-9178-d63a2c5c9f54@bytedance.com>
Date: Sat, 21 Dec 2024 10:26:38 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH bpf] bpf: Fix deadlock when freeing cgroup storage
Content-Language: en-US
To: Yonghong Song <yonghong.song@linux.dev>,
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
 <8ae5a9ec-33b1-4228-bde1-f155fd639c84@linux.dev>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <8ae5a9ec-33b1-4228-bde1-f155fd639c84@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/20/24 2:39 AM, Yonghong Song Wrote:
> 
> 
> 
> On 12/19/24 4:38 AM, Abel Wu wrote:
>> Hi Yonghong,
>>
>> On 12/19/24 10:45 AM, Yonghong Song Wrote:
>>>
>>>
>>>
>>> On 12/18/24 1:21 AM, Abel Wu wrote:
>>>> The following commit
>>>> bc235cdb423a ("bpf: Prevent deadlock from recursive bpf_task_storage_[get|delete]")
>>>> first introduced deadlock prevention for fentry/fexit programs attaching
>>>> on bpf_task_storage helpers. That commit also employed the logic in map
>>>> free path in its v6 version.
>>>>
>>>> Later bpf_cgrp_storage was first introduced in
>>>> c4bcfb38a95e ("bpf: Implement cgroup storage available to non-cgroup-attached bpf progs")
>>>> which faces the same issue as bpf_task_storage, instead of its busy
>>>> counter, NULL was passed to bpf_local_storage_map_free() which opened
>>>> a window to cause deadlock:
>>>>
>>>>     <TASK>
>>>>     _raw_spin_lock_irqsave+0x3d/0x50
>>>>     bpf_local_storage_update+0xd1/0x460
>>>>     bpf_cgrp_storage_get+0x109/0x130
>>>>     bpf_prog_72026450ec387477_cgrp_ptr+0x38/0x5e
>>>>     bpf_trace_run1+0x84/0x100
>>>>     cgroup_storage_ptr+0x4c/0x60
>>>>     bpf_selem_unlink_storage_nolock.constprop.0+0x135/0x160
>>>>     bpf_selem_unlink_storage+0x6f/0x110
>>>>     bpf_local_storage_map_free+0xa2/0x110
>>>>     bpf_map_free_deferred+0x5b/0x90
>>>>     process_one_work+0x17c/0x390
>>>>     worker_thread+0x251/0x360
>>>>     kthread+0xd2/0x100
>>>>     ret_from_fork+0x34/0x50
>>>>     ret_from_fork_asm+0x1a/0x30
>>>>     </TASK>
>>>>
>>>>     [ Since the verifier treats 'void *' as scalar which
>>>>       prevents me from getting a pointer to 'struct cgroup *',
>>>>       I added a raw tracepoint in cgroup_storage_ptr() to
>>>>       help reproducing this issue. ]
>>>>
>>>> Although it is tricky to reproduce, the risk of deadlock exists and
>>>> worthy of a fix, by passing its busy counter to the free procedure so
>>>> it can be properly incremented before storage/smap locking.
>>>
>>> The above stack trace and explanation does not show that we will have
>>> a potential dead lock here. You mentioned that it is tricky to reproduce,
>>> does it mean that you have done some analysis or coding to reproduce it?
>>> Could you share the details on why you think we may have deadlock here?
>>
>> The stack is A-A deadlocked: cgroup_storage_ptr() is called with
>> storage->lock held, while the bpf_prog attaching on this function
>> also tries to acquire the same lock by calling bpf_cgrp_storage_get()
>> thus leading to a AA deadlock.
>>
>> The tricky part is, instead of attaching on cgroup_storage_ptr()
>> directly, I added a tracepoint inside it to hook:
>>
>> ------
>> diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
>> index 20f05de92e9c..679209d4f88f 100644
>> --- a/kernel/bpf/bpf_cgrp_storage.c
>> +++ b/kernel/bpf/bpf_cgrp_storage.c
>> @@ -40,6 +40,8 @@ static struct bpf_local_storage __rcu **cgroup_storage_ptr(void *owner)
>>  {
>>         struct cgroup *cg = owner;
>>
>> +       trace_cgroup_ptr(cg);
>> +
>>         return &cg->bpf_cgrp_storage;
>>  }
>>
>> ------
>>
>> The reason doing so is that typecasting from 'void *owner' to
>> 'struct cgroup *' will be rejected by the verifier. But there
>> could be other ways to obtain a pointer to the @owner cgroup
>> too, making the deadlock possible.
> 
> I checked the callstack and what you described indeed the case.
> In function bpf_selem_unlink_storage(), local_storage->lock is
> held before calling bpf_selem_unlink_storage_nolock/cgroup_storage_ptr.
> If there is a fentry/tracepoint on the cgroup_storage_ptr and then we could
> have a deadlock as you described in the above.
> 
> As you mentioned, it is tricky to reproduce. fentry on cgroup_storage_ptr
> does not work due to func signature:
>    struct bpf_local_storage __rcu **cgroup_storage_ptr(void *owner)
> Even say we support 'void *' for fentry and we do bpf_rdonly_cast()
> to cast 'void *owner' to 'struct cgroup *owner', and owner cannot be
> passed to helper/kfunc.
> 
> Your fix looks good but it would be great to have a reproducer.
> One possibility is to find a function which can be fentried within
> local_storage->lock. If you know the cgroup id, in bpf program you
> can use bpf_cgroup_from_id() to get a trusted cgroup ptr from the id.
> and then you can use that cgroup ptr to do bpf_cgrp_storage_get() etc.
> which should be able to triger deadlock. Could you give a try?

Sure.

> 
> Also, in your commit message, it will be great if you can illustrage
> where each lock happens, e.g.
>     local_storage->lock
>       bpf_selem_unlink_storage_nolock.constprop.0
>         ...
>         bpf_local_storage_update
>           ...
>           local_storage->lock
>           ...
> 

OK, will update.

>>
>> Thanks,
>>     Abel
>>
>>>
>>>>
>>>> Fixes: c4bcfb38a95e ("bpf: Implement cgroup storage available to non-cgroup-attached bpf progs")
>>>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>>>> ---
>>>>   kernel/bpf/bpf_cgrp_storage.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
>>>> index 20f05de92e9c..7996fcea3755 100644
>>>> --- a/kernel/bpf/bpf_cgrp_storage.c
>>>> +++ b/kernel/bpf/bpf_cgrp_storage.c
>>>> @@ -154,7 +154,7 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
>>>>   static void cgroup_storage_map_free(struct bpf_map *map)
>>>>   {
>>>> -    bpf_local_storage_map_free(map, &cgroup_cache, NULL);
>>>> +    bpf_local_storage_map_free(map, &cgroup_cache, &bpf_cgrp_storage_busy);
>>>>   }
>>>>   /* *gfp_flags* is a hidden argument provided by the verifier */
>>>
>>
> 


