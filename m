Return-Path: <bpf+bounces-58968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4467DAC49BA
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 09:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1AD3BBD47
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 07:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5E7248891;
	Tue, 27 May 2025 07:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUlO8mky"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4501A0BD6
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 07:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748332686; cv=none; b=KBGY2qwVPgS/DQeHhb3nZyd3UeIm6aPWN+AL/VLeGWQq5+ewBiwYHBR9nsCAXnmQHLj11nKZhxQYh0N7K2kPQHAjLpcSXAuLhm79NLUSqD46i10otPi4469KoQoo3w1MkAJA4212n8sjKSu2rvJQwrL0OvoUKwIXgQM0iXAy84Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748332686; c=relaxed/simple;
	bh=MNYtkGPjikM0JGCudoNPx6h00HuCw+ohwhH+r1dMSyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MG4pV5cJWLM6leR9YN4y6ijY2FbgF9UZhPoC4MmfcK8f7TP4iVzxhne2mNeDMTrBIq56frMTGBEuHcIExSz8roIe4/tfFkOmNH7lVziXVyor6KZ8X5lqDP3azoQbQ0zN7HjisCIl8e4U/GjPhSdSUBQgWmvEjjfQ/wCGHhfUpdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eUlO8mky; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748332683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lffBjdsGaTDSAQBMSq/VbDYCdNxFSFEKJC4bmj58M9g=;
	b=eUlO8mky4FE3gnCdgCBJ57BUhODd+JwO9xcGll93GQO2Hrr/3i72Qp3w0yFI2h2I7lSLVS
	8OJpiRm6BrslE4Ie3fjRVH/bSVsvs16YHHL4RfjSHJ7nntIw+IyRV576qQWQMFxfZeeEfN
	Gq19coYJvXP8L5C8y+PE/QF9Bz3BhFs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-TOvQSzt4OqyaAMYWebhzDg-1; Tue, 27 May 2025 03:58:02 -0400
X-MC-Unique: TOvQSzt4OqyaAMYWebhzDg-1
X-Mimecast-MFC-AGG-ID: TOvQSzt4OqyaAMYWebhzDg_1748332681
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43efa869b19so19338685e9.2
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 00:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748332681; x=1748937481;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lffBjdsGaTDSAQBMSq/VbDYCdNxFSFEKJC4bmj58M9g=;
        b=lQBHlvb1EUIFwwSn8RlnvXIeF7shfyh4mLtiGWJdnMjcLH/nIBms4Lhnot+JOmoq1P
         WS9ur31exA/XitIsc9xfY4jSmIStbva0gAaBWpI9VuL6vDyZ3ccn+1pI6ZuJUySlgCrr
         54FiqB0te70BlW+dC+tF2RzLWo0aB3oUhmXpXYYOHCXBuW+k6VmtsZkif581PNCm/g6H
         2pbEB/+hCI/dWvRt6derlcD1/Q5WWqdYsOuDmpXN00ixD5S/bvSXj9KpP2+I5fW5aGPG
         ISuY3FhfJTJe311ZG9eRlQWKKYbZXbgcIzY+x3SrwyaY1+tSepGwg8//GuJtaYVSbrIt
         Kinw==
X-Forwarded-Encrypted: i=1; AJvYcCUin1e6cBwTs/IKbgB6Cg69Tloxo91j1KVHtYQxGleNLIr2HDWvIP+U4ODsFJ0UU5nwSG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjgjLfQZGC4kCgiSsbZdb7tKT2xjJFNMfRjRNrVIWFWGwAVwqG
	u3A9E6G5ga5iX5qm0a0oTUDvEaKO4ESrydyre+cz3Msb1oHPf1GuUyLvDbxUSgG7c1gGgBZ2MF8
	7vE/xsiVC3sAymAqEOYSxXPP62Z4VjU6TP19K4hxrkcrSgSvsBXFcXg==
X-Gm-Gg: ASbGncuy+YNDPg8ujuLyIvQEKE6HaIg0H/pnjj0vaDh/eKsVu3XdSDMSP00Fbg28ycL
	2Ep7weCp5v+2Rlq4yJ/rw8vl7W6acK6omIcKU/Vfm9wtGQymKMiMpks67eofVT5Hop9ds2yrnAM
	JYeP1bY+NKui5ka7WuTSTQD6x3WcX6unGe0Bo/UT3ve/JX9Z0syiGQoARP6ChcnJpD9hXpH67o7
	NX2ayPPnfF6CQbmi5+H5nkXoHvhMLBWBJLS236kVcVNH43jTwM4fF1SysJJIzx6eiDGYy7Feu5D
	XwWYXXf6lCPtVLJofvtIKofDLTDnGZbxr2WPaHutrdif
X-Received: by 2002:a05:600c:5249:b0:442:f990:3ce7 with SMTP id 5b1f17b1804b1-44c9465cecfmr109720375e9.16.1748332680776;
        Tue, 27 May 2025 00:58:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuTfYxIqr0RSJCt2Z5TpxlwMeko6qSLG+rq8iui0Nn4QjMd2lY7DBZllMBR/v9pk9Re0qbhw==
X-Received: by 2002:a05:600c:5249:b0:442:f990:3ce7 with SMTP id 5b1f17b1804b1-44c9465cecfmr109720015e9.16.1748332680306;
        Tue, 27 May 2025 00:58:00 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f3ce483bsm257682615e9.33.2025.05.27.00.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 00:57:59 -0700 (PDT)
Message-ID: <ada2fcc0-3915-40e7-8908-b4d73a2eb050@redhat.com>
Date: Tue, 27 May 2025 09:57:58 +0200
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CALOAHbBjueZhwrzp81FP-7C7ntEp5Uzaz26o2s=ZukVSmidEOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27.05.25 07:46, Yafang Shao wrote:
> On Mon, May 26, 2025 at 6:49 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 26.05.25 11:37, Yafang Shao wrote:
>>> On Mon, May 26, 2025 at 4:14 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>>> Hi all,
>>>>>
>>>>> Let’s summarize the current state of the discussion and identify how
>>>>> to move forward.
>>>>>
>>>>> - Global-Only Control is Not Viable
>>>>> We all seem to agree that a global-only control for THP is unwise. In
>>>>> practice, some workloads benefit from THP while others do not, so a
>>>>> one-size-fits-all approach doesn’t work.
>>>>>
>>>>> - Should We Use "Always" or "Madvise"?
>>>>> I suspect no one would choose 'always' in its current state. ;)
>>>>
>>>> IIRC, RHEL9 has the default set to "always" for a long time.
>>>
>>> good to know.
>>>
>>>>
>>>> I guess it really depends on how different the workloads are that you
>>>> are running on the same machine.
>>>
>>> Correct. If we want to enable THP for specific workloads without
>>> modifying the kernel, we must isolate them on dedicated servers.
>>> However, this approach wastes resources and is not an acceptable
>>> solution.
>>>
>>>>
>>>>    > Both Lorenzo and David propose relying on the madvise mode. However,>
>>>> since madvise is an unprivileged userspace mechanism, any user can
>>>>> freely adjust their THP policy. This makes fine-grained control
>>>>> impossible without breaking userspace compatibility—an undesirable
>>>>> tradeoff.
>>>>
>>>> If required, we could look into a "sealing" mechanism, that would
>>>> essentially lock modification attempts performed by the process (i.e.,
>>>> MADV_HUGEPAGE).
>>>
>>> If we don’t introduce a new THP mode and instead rely solely on
>>> madvise, the "sealing" mechanism could either violate the intended
>>> semantics of madvise(), or simply break madvise() entirely, right?
>>
>> We would have to be a bit careful, yes.
>>
>> Errors from MADV_HUGEPAGE/MADV_NOHUGEPAGE are often ignored, because
>> these options also fail with -EINVAL on kernels without THP support.
>>
>> Ignoring MADV_NOHUGEPAGE can be problematic with userfaultfd.
>>
>> What you likely really want to do is seal when you configured
>> MADV_NOHUGEPAGE to be the default, and fail MADV_HUGEPAGE later.
>>
>>>>
>>>> The could be added on top of the current proposals that are flying
>>>> around, and could be done e.g., per-process.
>>>
>>> How about introducing a dedicated "process" mode? This would allow
>>> each process to use different THP modes—some in "always," others in
>>> "madvise," and the rest in "never." Future THP modes could also be
>>> added to this framework.
>>
>> We have to be really careful about not creating even more mess with more
>> modes.
>>
>> How would that design look like in detail (how would we set it per
>> process etc?)?
> 
> I have a preliminary idea to implement this using BPF. 

I don't think we want to add such a mechanism (new mode) where the 
primary configuration mechanism is through bpf.

Maybe bpf could be used as an alternative, but we should look into a 
reasonable alternative first, like the discussed mctrl()/.../ raised in 
the process_madvise() series.

No "bpf" mode in disguise, please :)

> We could define
> the API as follows:
> 
> struct bpf_thp_ops {
>         /**
>          * @task_thp_mode: Get the THP mode for a specific task
>          *
>          * Return:
>          * - TASK_THP_ALWAYS: "always" mode
>          * - TASK_THP_MADVISE: "madvise" mode
>          * - TASK_THP_NEVER: "never" mode
>          * Future modes can also be added.
>          */
>         int (*task_thp_mode)(struct task_struct *p);
> };
> 
> For observability, we could add a "THP mode" field to
> /proc/[pid]/status. For example:
> 
> $ grep "THP mode" /proc/123/status
> always
> $ grep "THP mode" /proc/456/status
> madvise
> $ grep "THP mode" /proc/789/status
> never
> 
> The THP mode for each task would be determined by the attached BPF
> program based on the task's attributes. We would place the BPF hook in
> appropriate kernel functions. Note that this setting wouldn't be
> inherited during fork/exec - the BPF program would make the decision
> dynamically for each task.

What would be the mode (default) when the bpf program would not be active?

> This approach also enables runtime adjustments to THP modes based on
> system-wide conditions, such as memory fragmentation or other
> performance overheads. The BPF program could adapt policies
> dynamically, optimizing THP behavior in response to changing
> workloads.

I am not sure that is the proper way to handle these scenarios: I never 
heard that people would be adjusting the system-wide policy dynamically 
in that way either.

Whatever we do, we have to make sure that what we add won't 
over-complicate things in the future. Having tooling dynamically adjust 
the THP policy of processes that coarsely sounds ... very wrong long-term.

 > > As Liam pointed out in another thread, naming is challenging here -
> "process" might not be the most accurate term for this context.

No, it's not even a per-process thing. It is per MM, and a MM might be 
used by multiple processes ...

-- 
Cheers,

David / dhildenb


