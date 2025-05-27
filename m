Return-Path: <bpf+bounces-58989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776B0AC4E98
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 14:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38DBA16D442
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 12:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F342F2686B9;
	Tue, 27 May 2025 12:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUWTtuiN"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC3C25E838
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 12:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748348364; cv=none; b=YSRHlri2SckkL6rwk1hMJlPfgG9wx63U7p1mh1q/s/ImHUQAmhVMvtd1FqjU4+ymmQNlZQIneCgyRh2eK4XdfbSWvI9mYGWIa+F1U4iEOg1uEuxnJ0WievzNUd92udEvJ6SOINQOuWh9wgRTvw6TPFLHMJ2DJKRP2h/2ejSoPfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748348364; c=relaxed/simple;
	bh=Q2elwFt9ZJjKeP+HkVuTCadC8dr2S/AiYEZNDjWHVeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AlW/ev0RofsCZ2DH66+HWKBvTZec51ls7ZwC0jeaaI8dDW2OuMWlSXYnFc69iKH1AecW0r0EKKQsDP45njPgzFI/54+an7hCU6zTCohckqWCtvoT8Cwqq5uG7/c1E0Bk2PHs6UxatN/7T9rjTN1MxLCujoz2Zt5zKI+9W0RIMLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iUWTtuiN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748348361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dpgvSCgCupAxqnYARzvhbLlPO2NcjINXnankb1Ed5ZM=;
	b=iUWTtuiNOuNd8mEo+EKmFyd4areSTxotDVc0b6M+ZONcIbkeX8RIQweYLa9Wj8th2CfpMk
	+zpDQw9VuzBsAkXHf/E9f48J9V4Qhl0tlptaAjj8pBz5Svlf8QeSGKon9DKOiTZO+5rnc8
	+bcxRrjmCI4JaWIvF+qgEPJjJwZUgdo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-COrd5XIXN7OgW0OLh0ghEw-1; Tue, 27 May 2025 08:19:20 -0400
X-MC-Unique: COrd5XIXN7OgW0OLh0ghEw-1
X-Mimecast-MFC-AGG-ID: COrd5XIXN7OgW0OLh0ghEw_1748348359
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so19367425e9.1
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 05:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748348359; x=1748953159;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dpgvSCgCupAxqnYARzvhbLlPO2NcjINXnankb1Ed5ZM=;
        b=G3uV65wVb8h0Ijo52HS6LUJ7Stuh33Z+tmh1TckOcJHTuhFLB85E3fT0jYPf3k2hPs
         TSZo2qeTpsv+B5y+BGCYWHFGli4XAhw8g8LHmFommMc01jTo+ymBATepsnVgqKkwrahX
         PwY/iuAdSvzMTq3vCRUgE0a79GFXhQbRlSr4BjKjFrDym9yMR4r0exKOHjxBpsZtcAcN
         pl5UueyUHj6oPEtc1j0P0mUObLAKnr09Rjp55q8tB2loWwtfytZwLUDUhjKf8q/rZk9j
         moKuK1QIiCxKamp9ALOMq3YR6IDNVt56RRZmS+FMjwCJSs+RrbgW/+dGwMBjoOn2/exk
         0Crg==
X-Forwarded-Encrypted: i=1; AJvYcCXL+YrvHk9uI2lhNvYMzauqApvXvsCSJfSMgo9iTlhYjlJjCOyiqhq4PiGMwybGrcA0TR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YznILN71rM+PlA0ZyDkuBNnPK3niEkesPZ6VfpbrpKYIode30yI
	m0Hdc6N7rRZajaa1sPZWVHE6PoSceYV9pxEbrfMuqDctEajrOyeAOY3c3DVFBfhajPqUlIIkHmk
	j2dttU07Uw9rz3ufHb94Zti78Xgy0FzIpU6U8jmosJMUeaXrq0U3xmw==
X-Gm-Gg: ASbGncuAwGMzH/FlSiBezMCWtuvfnyt3MQLliXGgehky837jQrWVGAR5EM4MSW3HRZj
	zh0cKO3zyU7lxm0C2f9Q2aUaWpuz2TJYmgUU/c1L1kBzo6WivWnAmdtpaea46ZdKSnd/jSzJfcK
	AfEudN35IuHQLHOutI/gobKCPloN4ciajxscLjZE8wsIgjAkv1M6fY+D82XfDQcrRwqP6wcQvST
	RoBfWLM/ikeJt9ckoKCcP6AO8AYPBWTt7nvCmFzjnHeViUrs0FL/8K3XMVmV9fXl2UlXdo87hC5
	gABm4ooe3IfqYMhVdX0KTZimymrLUOn2iLF703bOKghX
X-Received: by 2002:a05:600c:8118:b0:442:c993:6f94 with SMTP id 5b1f17b1804b1-44c919e175bmr99720405e9.12.1748348358733;
        Tue, 27 May 2025 05:19:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9dHheYQ6jjBI2FKSetXXN+VSYwYoQYtuOWQcr3sQNbTjPTDjJmG6xO3RtYb+/EQnZqNCivQ==
X-Received: by 2002:a05:600c:8118:b0:442:c993:6f94 with SMTP id 5b1f17b1804b1-44c919e175bmr99720075e9.12.1748348358188;
        Tue, 27 May 2025 05:19:18 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d9f09622sm5414130f8f.98.2025.05.27.05.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 05:19:17 -0700 (PDT)
Message-ID: <aa7ea2f4-da94-4850-8225-0fb6e0e32767@redhat.com>
Date: Tue, 27 May 2025 14:19:16 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org,
 usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com,
 willy@infradead.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org
References: <20250520060504.20251-1-laoar.shao@gmail.com>
 <CALOAHbDPF+Mxqwh+5ScQFCyEdiz1ghNbgxJKAqmBRDeAZfe3sA@mail.gmail.com>
 <7d8a9a5c-e0ef-4e36-9e1d-1ef8e853aed4@redhat.com>
 <CALOAHbB-KQ4+z-Lupv7RcxArfjX7qtWcrboMDdT4LdpoTXOMyw@mail.gmail.com>
 <c983ffa8-cd14-47d4-9430-b96acedd989c@redhat.com>
 <CALOAHbBjueZhwrzp81FP-7C7ntEp5Uzaz26o2s=ZukVSmidEOA@mail.gmail.com>
 <ada2fcc0-3915-40e7-8908-b4d73a2eb050@redhat.com>
 <CALOAHbB9kuZ_8XJbTw98VuNtSdeUT=m9PAfO0uxsf4WaC3LXrA@mail.gmail.com>
 <5f0aadb1-28a8-4be0-bad9-16b738840e57@redhat.com>
 <CALOAHbB-HtU9ERzxDaz8NoC4-BG5Lb7-dF0v16Bp2Ckr1M7JEw@mail.gmail.com>
 <5d48d0c3-89a3-44da-bc1a-9a4601f146a4@redhat.com>
 <CALOAHbBUK=oPihkG22Z7L92rHNw-fB=p8zSk+1NFmzBjBENmVg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CALOAHbBUK=oPihkG22Z7L92rHNw-fB=p8zSk+1NFmzBjBENmVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27.05.25 11:43, Yafang Shao wrote:
> On Tue, May 27, 2025 at 5:27 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 27.05.25 10:40, Yafang Shao wrote:
>>> On Tue, May 27, 2025 at 4:30 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>>>> I don't think we want to add such a mechanism (new mode) where the
>>>>>> primary configuration mechanism is through bpf.
>>>>>>
>>>>>> Maybe bpf could be used as an alternative, but we should look into a
>>>>>> reasonable alternative first, like the discussed mctrl()/.../ raised in
>>>>>> the process_madvise() series.
>>>>>>
>>>>>> No "bpf" mode in disguise, please :)
>>>>>
>>>>> This goal can be readily achieved using a BPF program. In any case, it
>>>>> is a feasible solution.
>>>>
>>>> No BPF-only solution.
>>>>
>>>>>
>>>>>>
>>>>>>> We could define
>>>>>>> the API as follows:
>>>>>>>
>>>>>>> struct bpf_thp_ops {
>>>>>>>            /**
>>>>>>>             * @task_thp_mode: Get the THP mode for a specific task
>>>>>>>             *
>>>>>>>             * Return:
>>>>>>>             * - TASK_THP_ALWAYS: "always" mode
>>>>>>>             * - TASK_THP_MADVISE: "madvise" mode
>>>>>>>             * - TASK_THP_NEVER: "never" mode
>>>>>>>             * Future modes can also be added.
>>>>>>>             */
>>>>>>>            int (*task_thp_mode)(struct task_struct *p);
>>>>>>> };
>>>>>>>
>>>>>>> For observability, we could add a "THP mode" field to
>>>>>>> /proc/[pid]/status. For example:
>>>>>>>
>>>>>>> $ grep "THP mode" /proc/123/status
>>>>>>> always
>>>>>>> $ grep "THP mode" /proc/456/status
>>>>>>> madvise
>>>>>>> $ grep "THP mode" /proc/789/status
>>>>>>> never
>>>>>>>
>>>>>>> The THP mode for each task would be determined by the attached BPF
>>>>>>> program based on the task's attributes. We would place the BPF hook in
>>>>>>> appropriate kernel functions. Note that this setting wouldn't be
>>>>>>> inherited during fork/exec - the BPF program would make the decision
>>>>>>> dynamically for each task.
>>>>>>
>>>>>> What would be the mode (default) when the bpf program would not be active?
>>>>>>
>>>>>>> This approach also enables runtime adjustments to THP modes based on
>>>>>>> system-wide conditions, such as memory fragmentation or other
>>>>>>> performance overheads. The BPF program could adapt policies
>>>>>>> dynamically, optimizing THP behavior in response to changing
>>>>>>> workloads.
>>>>>>
>>>>>> I am not sure that is the proper way to handle these scenarios: I never
>>>>>> heard that people would be adjusting the system-wide policy dynamically
>>>>>> in that way either.
>>>>>>
>>>>>> Whatever we do, we have to make sure that what we add won't
>>>>>> over-complicate things in the future. Having tooling dynamically adjust
>>>>>> the THP policy of processes that coarsely sounds ... very wrong long-term.
>>>>>
>>>>> This is just an example demonstrating how BPF can be used to adjust
>>>>> its flexibility. Notably, all these policies can be implemented
>>>>> without modifying the kernel.
>>>>
>>>> See below on "policy".
>>>>
>>>>>
>>>>>>
>>>>>>     > > As Liam pointed out in another thread, naming is challenging here -
>>>>>>> "process" might not be the most accurate term for this context.
>>>>>>
>>>>>> No, it's not even a per-process thing. It is per MM, and a MM might be
>>>>>> used by multiple processes ...
>>>>>
>>>>> I consistently use 'thread' for the latter case.
>>>>
>>>> You can use CLONE_VM without CLONE_THREAD ...
>>>
>>> If I understand correctly, this can only occur for shared THP but not
>>> anonymous THP. For instance, if either process allocates an anonymous
>>> THP, it would trigger the creation of a new MM. Please correct me if
>>> I'm mistaken.
>>
>> What clone(CLONE_VM) will do is essentially create a new process, that
>> shares the MM with the original process. Similar to a thread, just that
>> the new process will show up in /proc/ as ... a new process, not as a
>> thread under /prod/$pid/tasks of the original process.
>>
>> Both processes will operate on the shared MM struct as if they were
>> ordinary threads. No Copy-on-Write involved.
>>
>> One example use case I've been involved in is async teardown in QEMU [1].
>>
>> [1] https://kvm-forum.qemu.org/2022/ibm_async_destroy.pdf
> 
> I understand what you mean, but what I'm really confused about is how
> this relates to allocating anonymous THP.  If either one allocates
> anon THP, it will definitely create a new MM, right ?

No. They work on the same address space - same MM. Either can allocate a 
new anon THP and the other one would be able to modify it. No fork/CoW.

I only bring it up because it's two "processes" sharing the same MM. And 
the THP mode in your proposal would actually be per-MM and not per process.

It's confusing ... :)

> 
>>
>>>
>>>>
>>>> Additionally, this
>>>>> can be implemented per-MM without kernel code modifications.
>>>>> With a well-designed API, users can even implement custom THP
>>>>> policies—all without altering kernel code.
>>>>
>>>> You can switch between modes, that' all you can do. I wouldn't really
>>>> call that "custom policy" as it is extremely limited.
>>>>
>>>> And that's exactly my point: it's basic switching between modes ... a
>>>> reasonable policy in the future will make placement decisions and not
>>>> just state "always/never/madvise".
>>>
>>> Could you please elaborate further on 'make placement decisions'? As
>>> previously mentioned, we (including the broader community) really need
>>> the user input to determine whether THP allocation is appropriate in a
>>> given case.
>>
>> The glorious future were we make smarter decisions where to actually
>> place THPs even in the "always" mode.
>>
>> E.g., just because we enable "always" for a process does not mean that
>> we really want a THP everywhere; quite the opposite.
> 
> So 'always' simply means "the system doesn't guarantee THP allocation
> will succeed" ?

I mean, with THPs, there are no guarantees, ever :(

> If that's the case, we should revisit RFC v1 [0],
> where we proposed rejecting THP allocations in certain scenarios for
> specific tasks.

Hooking into actual page allocation during page faults (e.g., THP size, 
khugepaged collapse decisions) is IMHO a much better application of ebpf 
than setting a THP mode per process (or MM ... ) using epbf.

So yes, you could drive the system in "always" mode and decide to not 
allocate THPs during page faults / khugepaged for specific processes.

IMHO that also does not contradict the VM_HUGEPAGE / VM_NOHUGEPAGE 
default setting proposal: VM_HUGEPAGE could feed into the epbf program 
as yet another parameter to make a decision.

-- 
Cheers,

David / dhildenb


