Return-Path: <bpf+bounces-49819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E542EA1C724
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 10:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27FC81659C1
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 09:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF15ECA5A;
	Sun, 26 Jan 2025 09:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lK7KLb+h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC1C25A646
	for <bpf@vger.kernel.org>; Sun, 26 Jan 2025 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737883231; cv=none; b=YzB04Kdl3+BFgg3/se+nfWaayMC8TdKMpOXF/RHZT11w8prJSiuHIURaKH+ZHARLuEKWRRkDelc8ldu7E9J09/+OdPfFRNzxSfHvkGhOhe5Lwd0fUCywZWMD/m40qm6whM+9GTHrECByG2J0Yz+v8B0tpYu5ogg1NgqFC2ZTFGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737883231; c=relaxed/simple;
	bh=2xXnUVOzfn9YZzSq9FbBkVl57zAep+jA+LSRxB+4hf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IuDjQF8uAjS5gqvH23w8bVPKrM55n065/uENNDJn+fgldb4yrm+3KG8Wv1jhP81t4jGdlC/NCICxciaNUVTuoIG8lt8vIV75Y626oV/h89fEsGlfQO78l+Sa0SH4jUIr8mdaJtuNEd/S5TEkT6TlrlnqniMc0qW6zKkBAZKS8I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lK7KLb+h; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f800b5c2d5so511781a91.2
        for <bpf@vger.kernel.org>; Sun, 26 Jan 2025 01:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737883228; x=1738488028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+TnV06hAF677jhT5jfft0dnQG7RHTf/BYHbyC97bYMY=;
        b=lK7KLb+hh9ZWyevDTLFLkjGlas/ScUFnlmJxvlbvZpEkva4QELuy5lSk0pCInGDwP0
         qagcMaV/nZrwFG1HUFURGZax9Om4cJ5BKcx1L6mfjMvfeWuLMzYennWhu9zSAibzKN4P
         2aTIXA9gBDHTdFTwYcqvtsKzVOCJJKQhIzUoY3pwxdzR8Cn1P1QAaubaPu++D8Ltd7mn
         TGQUpt5IB9P7bPuM+ZOrjRUwiY1EIlH+WvwragIHDmWfqbDI/HQ4hePaIbL/oHCt6Zcu
         t7ZlnhcwvEyAkG/8iaCJNOmKL31ncdg0p1kI0X9qqh6I1nBCbYNw7ZTpGT6pYS7lviMk
         2kBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737883228; x=1738488028;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+TnV06hAF677jhT5jfft0dnQG7RHTf/BYHbyC97bYMY=;
        b=snRc2KzCoR60lbz+89VH8wfLOorl+BMHw9qYk4V13PhsCHFK2/crjJH/6qvPI1hPaG
         Fbboah7NHVs8lsdPAE+N4d0MLtdFQZI5HqNcQOPnzg8gIYtywpTR8CJ66vRlZN27lznI
         86jWabEZWTJO/aUqHIaF/5uRYFGcwiKsUx0dlJST/3q9n3WznOsMjBFKb5Kg5gLLv0N1
         jvkZ0Jis9pE1INqxBlP1YT5je2GVuMVSaemNmfYyLqgXeu6SX2Z8kh5temJxIn1bAlKo
         fLfDfSv4NCBRpWIF7vGLBXI1U9I0QLre5KhD5+0tzSXg0ltBNmZUx13mYK8tQqwmSS0m
         tNzg==
X-Forwarded-Encrypted: i=1; AJvYcCUhz5GMQNp0YqGCg3M70Suznhb1hW8aG6/aFi7JoPnClEemwJFA6l6VITjp+e173YInKTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEjynZNgG+DFeGvH4lvQoF6qk08VM152AqTmr6rXPy/zuRe1hp
	MqM3iHJbNwddFgQLzKg+vGA7m07r9Cx+9+xcfX3DgIK06IyT6ue+Gv8dRSB51RA=
X-Gm-Gg: ASbGnctqqTDUOwGRG1Aj2wK0EA/YqGmvOQdrJHf5Z0fhbTHNFhO3pzatq9zMhfoEDcA
	wWLKOwlDqhDOi+wJZkct0YEcU5Q8g2ybNrYqxAkBoS3cZcrX0EP73OGGqhtyVORcICyx/w/lFEN
	Me0sHgt68uzaNY+2Odnf6HmS5t6pbytxSE0nR33c6tp2eyAJxLcoSvAmF9/mFEUSqB7eI597JHm
	i+3UKmgfq7DUVL4i1ttPk1T/DQmElixpa0lL8Lp3mmCW8h0GQycdGTjor4Rgr7XYtRyDlG3uOH5
	dO7ubg+TuDN+Zim8CrA19160s9t9ow6gv0eu/bPA
X-Google-Smtp-Source: AGHT+IGygq9tUWp8njsCW0TS+Ng9bzZ7kQDJNqdGNKtm09Vbg2cJGRoClosv8wDMc3Sf41yPBD8zVQ==
X-Received: by 2002:a17:902:ebc1:b0:21b:b2b4:93ab with SMTP id d9443c01a7336-21c355fb283mr200076955ad.14.1737883228584;
        Sun, 26 Jan 2025 01:20:28 -0800 (PST)
Received: from [10.254.144.106] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414cb74sm43070635ad.161.2025.01.26.01.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2025 01:20:27 -0800 (PST)
Message-ID: <46947563-c2e8-4346-84ca-c0774fa0ce39@bytedance.com>
Date: Sun, 26 Jan 2025 17:19:04 +0800
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
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 David Vernet <void@manifault.com>,
 "open list:BPF [STORAGE & CGROUPS]" <bpf@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241218092149.42339-1-wuyun.abel@bytedance.com>
 <eb9d4609-970e-4760-af94-8e48cca7ec23@linux.dev>
 <9c53734d-9185-46b7-b07d-bf24ac06e688@bytedance.com>
 <8ae5a9ec-33b1-4228-bde1-f155fd639c84@linux.dev>
 <CAADnVQ+pYevQ9QsRB-oLu1ONtzZ31J=3ANqB+aFLLiU4VcGgNA@mail.gmail.com>
 <00fa1c00-9b14-47d6-917f-17fcb3d5b18a@linux.dev>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <00fa1c00-9b14-47d6-917f-17fcb3d5b18a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alexei, Yonghong, I am really sorry that I didn't notice the failure
of sending out this reply that day until Martin reminds me in v2..

The bpf_local_storage (esp. bpf_cgrp_storage) is becoming one of the
most important facility in our containerized infrastructure due to its
excellent scalability and performance. We (Bytedance) are migrating our
bpf progs, which provide container insights, to use bpf_cgrp_storage, so
it is important if there is a way to profile its internals to see how it
behaves under real workloads.


On 12/20/24 2:57 AM, Yonghong Song Wrote:
> 
> 
> 
> On 12/19/24 10:43 AM, Alexei Starovoitov wrote:
>> On Thu, Dec 19, 2024 at 10:39 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>>
>>>
>>>
>>> On 12/19/24 4:38 AM, Abel Wu wrote:
>>>> Hi Yonghong,
>>>>
>>>> On 12/19/24 10:45 AM, Yonghong Song Wrote:
>>>>>
>>>>>
>>>>> On 12/18/24 1:21 AM, Abel Wu wrote:
>>>>>> The following commit
>>>>>> bc235cdb423a ("bpf: Prevent deadlock from recursive
>>>>>> bpf_task_storage_[get|delete]")
>>>>>> first introduced deadlock prevention for fentry/fexit programs
>>>>>> attaching
>>>>>> on bpf_task_storage helpers. That commit also employed the logic in map
>>>>>> free path in its v6 version.
>>>>>>
>>>>>> Later bpf_cgrp_storage was first introduced in
>>>>>> c4bcfb38a95e ("bpf: Implement cgroup storage available to
>>>>>> non-cgroup-attached bpf progs")
>>>>>> which faces the same issue as bpf_task_storage, instead of its busy
>>>>>> counter, NULL was passed to bpf_local_storage_map_free() which opened
>>>>>> a window to cause deadlock:
>>>>>>
>>>>>>      <TASK>
>>>>>>      _raw_spin_lock_irqsave+0x3d/0x50
>>>>>>      bpf_local_storage_update+0xd1/0x460
>>>>>>      bpf_cgrp_storage_get+0x109/0x130
>>>>>>      bpf_prog_72026450ec387477_cgrp_ptr+0x38/0x5e
>>>>>>      bpf_trace_run1+0x84/0x100
>>>>>>      cgroup_storage_ptr+0x4c/0x60
>>>>>>      bpf_selem_unlink_storage_nolock.constprop.0+0x135/0x160
>>>>>>      bpf_selem_unlink_storage+0x6f/0x110
>>>>>>      bpf_local_storage_map_free+0xa2/0x110
>>>>>>      bpf_map_free_deferred+0x5b/0x90
>>>>>>      process_one_work+0x17c/0x390
>>>>>>      worker_thread+0x251/0x360
>>>>>>      kthread+0xd2/0x100
>>>>>>      ret_from_fork+0x34/0x50
>>>>>>      ret_from_fork_asm+0x1a/0x30
>>>>>>      </TASK>
>>>>>>
>>>>>>      [ Since the verifier treats 'void *' as scalar which
>>>>>>        prevents me from getting a pointer to 'struct cgroup *',
>>>>>>        I added a raw tracepoint in cgroup_storage_ptr() to
>>>>>>        help reproducing this issue. ]
>>>>>>
>>>>>> Although it is tricky to reproduce, the risk of deadlock exists and
>>>>>> worthy of a fix, by passing its busy counter to the free procedure so
>>>>>> it can be properly incremented before storage/smap locking.
>>>>> The above stack trace and explanation does not show that we will have
>>>>> a potential dead lock here. You mentioned that it is tricky to
>>>>> reproduce,
>>>>> does it mean that you have done some analysis or coding to reproduce it?
>>>>> Could you share the details on why you think we may have deadlock here?
>>>> The stack is A-A deadlocked: cgroup_storage_ptr() is called with
>>>> storage->lock held, while the bpf_prog attaching on this function
>>>> also tries to acquire the same lock by calling bpf_cgrp_storage_get()
>>>> thus leading to a AA deadlock.
>>>>
>>>> The tricky part is, instead of attaching on cgroup_storage_ptr()
>>>> directly, I added a tracepoint inside it to hook:
>>>>
>>>> ------
>>>> diff --git a/kernel/bpf/bpf_cgrp_storage.c
>>>> b/kernel/bpf/bpf_cgrp_storage.c
>>>> index 20f05de92e9c..679209d4f88f 100644
>>>> --- a/kernel/bpf/bpf_cgrp_storage.c
>>>> +++ b/kernel/bpf/bpf_cgrp_storage.c
>>>> @@ -40,6 +40,8 @@ static struct bpf_local_storage __rcu
>>>> **cgroup_storage_ptr(void *owner)
>>>>   {
>>>>          struct cgroup *cg = owner;
>>>>
>>>> +       trace_cgroup_ptr(cg);
>>>> +
>>>>          return &cg->bpf_cgrp_storage;
>>>>   }
>>>>
>>>> ------
>>>>
>>>> The reason doing so is that typecasting from 'void *owner' to
>>>> 'struct cgroup *' will be rejected by the verifier. But there
>>>> could be other ways to obtain a pointer to the @owner cgroup
>>>> too, making the deadlock possible.
>>> I checked the callstack and what you described indeed the case.
>>> In function bpf_selem_unlink_storage(), local_storage->lock is
>>> held before calling bpf_selem_unlink_storage_nolock/cgroup_storage_ptr.
>>> If there is a fentry/tracepoint on the cgroup_storage_ptr and then we could
>>> have a deadlock as you described in the above.
>>>
>>> As you mentioned, it is tricky to reproduce. fentry on cgroup_storage_ptr
>>> does not work due to func signature:
>>>     struct bpf_local_storage __rcu **cgroup_storage_ptr(void *owner)
>>> Even say we support 'void *' for fentry and we do bpf_rdonly_cast()
>>> to cast 'void *owner' to 'struct cgroup *owner', and owner cannot be
>>> passed to helper/kfunc.
>>>
>>> Your fix looks good but it would be great to have a reproducer.
>>> One possibility is to find a function which can be fentried within
>>> local_storage->lock. If you know the cgroup id, in bpf program you
>>> can use bpf_cgroup_from_id() to get a trusted cgroup ptr from the id.
>>> and then you can use that cgroup ptr to do bpf_cgrp_storage_get() etc.
>>> which should be able to triger deadlock. Could you give a try?
>> I'd rather mark a set of functions as notrace to avoid this situation
>> or add:
>> CFLAGS_REMOVE_bpf_cgrp_storage.o = $(CC_FLAGS_FTRACE)
> 
> If we go through CFLAGS_REMOVE path, we need to do
> 
> CFLAGS_REMOVE_bpf_local_storage.o = $(CC_FLAGS_FTRACE)
> 
> as well since bpf_selem_unlink_storage_nolock() calls a few functions
> which, if fentry traced, could trigger similar issue (with bpf_cgroup_from_id() approach).
> 

If we go through this path, shall we also do the same to other local
storages? It's a little weird that only disabling tracing on this one
while allowing others. And once if we had removed trace flags for all
bpf_*_storage, the previous efforts of avoiding recurring on bpf local
storages are no longer needed anymore IMHO.

After carefully (or not?) examined all the critical sections inside
bpf_local_storage.c, I didn't find any trace-able points that can cause
deadlock if the busy_counter gets properly incremented (and the cgroup
storage's counter is the only one that not doing so).

I totally agree that disabling tracing on the local storages is the ideal
solution to get rid of deadlock issues, but can we just fix this counter
problem in order to retain the observability into the internals of local
storage as I believe it will play a more and more important role in modern
containerized infrastructures.

Thanks & Best Regards,
	Abel


