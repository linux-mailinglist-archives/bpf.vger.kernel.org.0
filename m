Return-Path: <bpf+bounces-58972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF96AC4A58
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 10:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66A8188A424
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 08:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B358823FC42;
	Tue, 27 May 2025 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axlpQpUd"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DBF1FE46D
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748334619; cv=none; b=QEq/QVD4gtZui0goppXUD4R3lQF5RhqajensNiFjv1LNyBnmrUZeq6hYSWq5K4fVCQ25LNoTWxQc5DbiX9m5kR7cVlxdxpOK5SpLiFqN/lH3wtMRXiSZ80Ckny37IM9weKEfx0csGp9VgWtXNCJjRzo4rs2O/8d8lm+L/I18zK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748334619; c=relaxed/simple;
	bh=C5aLyhve7LneykgJ6yjcUePlYpYR9bRt/6kE3m3i/Tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NIsaPhoJ0vwvBe1uIHat78y031SALMX72i2bJ64+sEN3cm2DY43dYvEkqC1fe9mqpoRTKxU/Oou7/vCamuhNWya5ZAg4l5z6AS13vpVd1daqv/ecHzEEqh9mEol4VbcuLHT11iqrwCs1oka7cGbzL6B+WujUETr0YywuERr+Z2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=axlpQpUd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748334616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iHA7OV237Vk3sqWS2uDi1UYli183BcNP320+7EACUO8=;
	b=axlpQpUdoTg05SK8WuLKou9r3QCsithTv4CadLnmCi6Anfv8an0StOw3IQFM/NbUcGiZjq
	MuIDVr2e9WDl7YVtuXIcnA5a/Np7rLvg9gjtgBiZttB0y/9kHTsp2gnI8mYcwz+V+QyZSw
	3icwj6Dvlnv0HT7crSWCdniyrsUXTVg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-AnwC6o-cO_iDQXmlE0HDIQ-1; Tue, 27 May 2025 04:30:15 -0400
X-MC-Unique: AnwC6o-cO_iDQXmlE0HDIQ-1
X-Mimecast-MFC-AGG-ID: AnwC6o-cO_iDQXmlE0HDIQ_1748334614
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4d95f197dso1065277f8f.3
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 01:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748334614; x=1748939414;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iHA7OV237Vk3sqWS2uDi1UYli183BcNP320+7EACUO8=;
        b=CI9+TJ8uw5cs3af4v2B4rHMMrMn/mCFpvDqzuIKQ87IwlN8/4SSiVOwkU1KEmPeJyF
         HIShh3e2wbUlOuj1mb3ZdPP8BsKpeIVg17gkt8xANhbQbM6At4l+wRtJCs2JLoIfsKEo
         U7NrqMosv4pnunihP8N3RgT5UMEdJAcLQAo7SQdijMttRcteJNSEPAGexiU6mE8hVykd
         Sh+saFIssWBR6opjJcy7mRFipfLcetMaViD5q83jDCAQt9SW6MO/WptIBDm3Msiro8Sq
         OqVx6GK/r1HNek8//xq1JazIZIJlY23UxRYip9v9KWAuGtp+l6OWimwGxrDuJwfDAQhw
         7kFg==
X-Forwarded-Encrypted: i=1; AJvYcCVoyTU4NINF/4AVjlaorkWspo1T6OHwccXvLZcPntli6t5r5ZMgYWkm8HRdRVN4DwMExmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyegkSwau8ocykZS9VYN95kVmL9+7g5uoNldAuOUsRTel2tGDSc
	H8eyCxRnQ0bzDyKRpC32KCHSVUqa4at8Q+5oS3w4R5fFDYPE6fZ6xLA6z398ZLDl1pbJ99E2fVl
	44po8QYXB6eDaWNai2mD2w82XLCsk4Q43OBhTLQ3meU6Isk0AuykR0Q==
X-Gm-Gg: ASbGnctgWEOvEwWUNKLH8uFjqEPbq+T3MGyoNDD3bkM5ysrj0Rsq1SJZrwbSGZwEKly
	1xCsnGD6rFJM2bjC0uZcWm6POYfPYwlXtJTpnerOQbKZY3a2MoRMgXZc2lFwZPX72EE+ILc9/w/
	3YP61s+HYw3tdCRDIY4r3oud3hD4NUlO0b/B6F6f8MgApiwV7yZK4MGQC99C+E+10P1Cr4SKxnK
	2++cngypCSQNIC7tIlHTSF4AjMeDUBv9j30goCGJtj/BdG830LCG1eghBVVjVNg9mPG3FPvN7Px
	4qlwTpXEw58+ziiWA3QqnFJplr/ru0+0HFxBoK/v16Oh/45GRCOkqpY=
X-Received: by 2002:a05:6000:2489:b0:3a4:cf53:2983 with SMTP id ffacd0b85a97d-3a4cf533190mr8506082f8f.31.1748334613630;
        Tue, 27 May 2025 01:30:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGYmzwZjZy0zAz6y2aSwnykO2vChBzpefXSHOSV5v+iF6PDbmiF/i25uqOBNBJpUbSFqn+8A==
X-Received: by 2002:a05:6000:2489:b0:3a4:cf53:2983 with SMTP id ffacd0b85a97d-3a4cf533190mr8506035f8f.31.1748334613124;
        Tue, 27 May 2025 01:30:13 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78aeb8csm259530905e9.28.2025.05.27.01.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 01:30:12 -0700 (PDT)
Message-ID: <5f0aadb1-28a8-4be0-bad9-16b738840e57@redhat.com>
Date: Tue, 27 May 2025 10:30:10 +0200
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
In-Reply-To: <CALOAHbB9kuZ_8XJbTw98VuNtSdeUT=m9PAfO0uxsf4WaC3LXrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>> I don't think we want to add such a mechanism (new mode) where the
>> primary configuration mechanism is through bpf.
>>
>> Maybe bpf could be used as an alternative, but we should look into a
>> reasonable alternative first, like the discussed mctrl()/.../ raised in
>> the process_madvise() series.
>>
>> No "bpf" mode in disguise, please :)
> 
> This goal can be readily achieved using a BPF program. In any case, it
> is a feasible solution.

No BPF-only solution.

> 
>>
>>> We could define
>>> the API as follows:
>>>
>>> struct bpf_thp_ops {
>>>          /**
>>>           * @task_thp_mode: Get the THP mode for a specific task
>>>           *
>>>           * Return:
>>>           * - TASK_THP_ALWAYS: "always" mode
>>>           * - TASK_THP_MADVISE: "madvise" mode
>>>           * - TASK_THP_NEVER: "never" mode
>>>           * Future modes can also be added.
>>>           */
>>>          int (*task_thp_mode)(struct task_struct *p);
>>> };
>>>
>>> For observability, we could add a "THP mode" field to
>>> /proc/[pid]/status. For example:
>>>
>>> $ grep "THP mode" /proc/123/status
>>> always
>>> $ grep "THP mode" /proc/456/status
>>> madvise
>>> $ grep "THP mode" /proc/789/status
>>> never
>>>
>>> The THP mode for each task would be determined by the attached BPF
>>> program based on the task's attributes. We would place the BPF hook in
>>> appropriate kernel functions. Note that this setting wouldn't be
>>> inherited during fork/exec - the BPF program would make the decision
>>> dynamically for each task.
>>
>> What would be the mode (default) when the bpf program would not be active?
>>
>>> This approach also enables runtime adjustments to THP modes based on
>>> system-wide conditions, such as memory fragmentation or other
>>> performance overheads. The BPF program could adapt policies
>>> dynamically, optimizing THP behavior in response to changing
>>> workloads.
>>
>> I am not sure that is the proper way to handle these scenarios: I never
>> heard that people would be adjusting the system-wide policy dynamically
>> in that way either.
>>
>> Whatever we do, we have to make sure that what we add won't
>> over-complicate things in the future. Having tooling dynamically adjust
>> the THP policy of processes that coarsely sounds ... very wrong long-term.
> 
> This is just an example demonstrating how BPF can be used to adjust
> its flexibility. Notably, all these policies can be implemented
> without modifying the kernel.

See below on "policy".

> 
>>
>>   > > As Liam pointed out in another thread, naming is challenging here -
>>> "process" might not be the most accurate term for this context.
>>
>> No, it's not even a per-process thing. It is per MM, and a MM might be
>> used by multiple processes ...
> 
> I consistently use 'thread' for the latter case.

You can use CLONE_VM without CLONE_THREAD ...

Additionally, this
> can be implemented per-MM without kernel code modifications.
> With a well-designed API, users can even implement custom THP
> policies—all without altering kernel code.

You can switch between modes, that' all you can do. I wouldn't really 
call that "custom policy" as it is extremely limited.

And that's exactly my point: it's basic switching between modes ... a 
reasonable policy in the future will make placement decisions and not 
just state "always/never/madvise".


-- 
Cheers,

David / dhildenb


