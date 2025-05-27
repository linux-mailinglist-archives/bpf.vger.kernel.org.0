Return-Path: <bpf+bounces-58978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB0AAC4B80
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 11:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9268E1896225
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 09:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF492505A5;
	Tue, 27 May 2025 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OG4CQPF4"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D96A24DCF1
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748338065; cv=none; b=ONNog9gBlgj+nO5RvsWgMsidq87+UHPu/TDkHNnhMYcSuZJhYxiSSZAZUx8ob6x15M/L4eps53OL1rVxry6myaup64mntRke1B30zfEsd2YnOsTTAtlOdnhEXzvGBOmRXjVxCQdlJvRWMcaz1Gydh9wnbmavE3De2nblEzSHHW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748338065; c=relaxed/simple;
	bh=NslesSYCTzFopP/rnPlog8qk8rA3cp6okdtOZVtqxmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nAS80h5zFEB0LBiVP4SMB58lizd50OwNMcwUYMII5BXK3jbz5nnRnBe9oOaNY3uLzlflz9a85GDTsH8Un85+ssXTynEfuhNVka7Cyql+IuwPqimLyJUt26JcEAQu5y55M6WSdg2rHhtdA7eCyF6aBuI+4tBLL8s3Mf8as+poKxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OG4CQPF4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748338062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YYhQpMO1cqk6PzoLJg9BrpHx0v/xNedZXm7uLXOi+48=;
	b=OG4CQPF4I4K58/EYQk2TJEQX3Fc71LYNL8AHG8B7SjLE8tVXS1iGnvzY8YVEdsH+weBNeT
	OQmI7/gcC1QceYJDeG1xHFx+o0Tfv4V0eBN6Kdb9LdxyusnL+2TBIaTfvyVYNkNTOSplX0
	k03Jq52TJ81yxfDM7Ke3a0BZ0F8NrMc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-RR0QFUdqMA6rR1UsxmLTqA-1; Tue, 27 May 2025 05:27:40 -0400
X-MC-Unique: RR0QFUdqMA6rR1UsxmLTqA-1
X-Mimecast-MFC-AGG-ID: RR0QFUdqMA6rR1UsxmLTqA_1748338059
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-44b1f5b91c1so23780885e9.1
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 02:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748338059; x=1748942859;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YYhQpMO1cqk6PzoLJg9BrpHx0v/xNedZXm7uLXOi+48=;
        b=GueiOnXFMVVS/3OnrbiafcpeAASAw4g3+YuwHNNZLO21XXgQOsVyQHXX3L9URmfjBQ
         dIgkRhrWafz9xIFonlVbBjF3xzZT6FbSzSw3HjBbRm5+VsSjcWoSLzXkOd/BLPZ4pDve
         IGaospF5HJJ4YT3DlXn0scIb8q1Rg8zlH3kkDRry6XITeKr1lj5Z+pskAAS3KCvChg9/
         VGm1AA0J1WFvTNsV0CqlI1qfSbhZQyeVkn1xHKSjSySE4XFkBYNQr9svbJ+mscSrboyn
         G0fP7TlZqznNwYaCwI6tVvhHiQZ8lvCJ99pVrJD6t0ps1wcWnWTdvg5W4krz0X2ZWhn2
         O30w==
X-Forwarded-Encrypted: i=1; AJvYcCXrcEBn7a642Wf/cXjqacVT4d6Pn8Vr/NsDYeMrEaOba0qFeSqge0CAsHj07HQ6P4sWb48=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQFmKa0uuSsM9oHFpe0NJ5rE3RlcVk4pu80kSk9bqlxf69mPaP
	/l6kz+gmVnu7j19E0oFhhEJ3tsRCjgdsdFUJjC3URqYhKd2I5wuzhqogMoNnLv7KlazEmRyZD6f
	5pBfguo4gmiVgQwRAXaaJunjyghynbmgOYUNE1NDgVS+dtqq5+XEQFg==
X-Gm-Gg: ASbGncs0zzgp9a+bT6s079IREAnIiI3QDk+CzENBC3AJlHEMm+hFjzuGStus604vx78
	Eh+at+UI/HZtOzIWG2UkIVSK1AcIQ1Y8hYKv4VIurbHfQBchWqPoCfbaGDFIrJ+XQK/DE1s1FvH
	oyo4NGo/ecxcbQMMWKj0QPiOjclQgUXSh0nPte8SMyz0cOwuZggEBUAccWGO8TErAjyFblxG95q
	+od13WXcSkP3SPuSEBhwIIjeMZfSJQCHvBqFj7/K5mXHWO9FqiJo4nuy6OQjn74LWvvQe/UBPkU
	HiIUXCcVvo7bpNYIosipVPXWAcglXjMMamsuTRGD0gRU
X-Received: by 2002:a05:600c:a07:b0:43c:fdbe:4398 with SMTP id 5b1f17b1804b1-44c916071admr105759805e9.6.1748338059240;
        Tue, 27 May 2025 02:27:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1TOsrwysWdxzl529keu1uTVd98UIgX+NLVxEQsxAC8CJwO2infiezFFhayliHYN3MBxdvoA==
X-Received: by 2002:a05:600c:a07:b0:43c:fdbe:4398 with SMTP id 5b1f17b1804b1-44c916071admr105759355e9.6.1748338058717;
        Tue, 27 May 2025 02:27:38 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f23bfd54sm272682595e9.17.2025.05.27.02.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 02:27:38 -0700 (PDT)
Message-ID: <5d48d0c3-89a3-44da-bc1a-9a4601f146a4@redhat.com>
Date: Tue, 27 May 2025 11:27:37 +0200
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
In-Reply-To: <CALOAHbB-HtU9ERzxDaz8NoC4-BG5Lb7-dF0v16Bp2Ckr1M7JEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27.05.25 10:40, Yafang Shao wrote:
> On Tue, May 27, 2025 at 4:30 PM David Hildenbrand <david@redhat.com> wrote:
>>
>>>> I don't think we want to add such a mechanism (new mode) where the
>>>> primary configuration mechanism is through bpf.
>>>>
>>>> Maybe bpf could be used as an alternative, but we should look into a
>>>> reasonable alternative first, like the discussed mctrl()/.../ raised in
>>>> the process_madvise() series.
>>>>
>>>> No "bpf" mode in disguise, please :)
>>>
>>> This goal can be readily achieved using a BPF program. In any case, it
>>> is a feasible solution.
>>
>> No BPF-only solution.
>>
>>>
>>>>
>>>>> We could define
>>>>> the API as follows:
>>>>>
>>>>> struct bpf_thp_ops {
>>>>>           /**
>>>>>            * @task_thp_mode: Get the THP mode for a specific task
>>>>>            *
>>>>>            * Return:
>>>>>            * - TASK_THP_ALWAYS: "always" mode
>>>>>            * - TASK_THP_MADVISE: "madvise" mode
>>>>>            * - TASK_THP_NEVER: "never" mode
>>>>>            * Future modes can also be added.
>>>>>            */
>>>>>           int (*task_thp_mode)(struct task_struct *p);
>>>>> };
>>>>>
>>>>> For observability, we could add a "THP mode" field to
>>>>> /proc/[pid]/status. For example:
>>>>>
>>>>> $ grep "THP mode" /proc/123/status
>>>>> always
>>>>> $ grep "THP mode" /proc/456/status
>>>>> madvise
>>>>> $ grep "THP mode" /proc/789/status
>>>>> never
>>>>>
>>>>> The THP mode for each task would be determined by the attached BPF
>>>>> program based on the task's attributes. We would place the BPF hook in
>>>>> appropriate kernel functions. Note that this setting wouldn't be
>>>>> inherited during fork/exec - the BPF program would make the decision
>>>>> dynamically for each task.
>>>>
>>>> What would be the mode (default) when the bpf program would not be active?
>>>>
>>>>> This approach also enables runtime adjustments to THP modes based on
>>>>> system-wide conditions, such as memory fragmentation or other
>>>>> performance overheads. The BPF program could adapt policies
>>>>> dynamically, optimizing THP behavior in response to changing
>>>>> workloads.
>>>>
>>>> I am not sure that is the proper way to handle these scenarios: I never
>>>> heard that people would be adjusting the system-wide policy dynamically
>>>> in that way either.
>>>>
>>>> Whatever we do, we have to make sure that what we add won't
>>>> over-complicate things in the future. Having tooling dynamically adjust
>>>> the THP policy of processes that coarsely sounds ... very wrong long-term.
>>>
>>> This is just an example demonstrating how BPF can be used to adjust
>>> its flexibility. Notably, all these policies can be implemented
>>> without modifying the kernel.
>>
>> See below on "policy".
>>
>>>
>>>>
>>>>    > > As Liam pointed out in another thread, naming is challenging here -
>>>>> "process" might not be the most accurate term for this context.
>>>>
>>>> No, it's not even a per-process thing. It is per MM, and a MM might be
>>>> used by multiple processes ...
>>>
>>> I consistently use 'thread' for the latter case.
>>
>> You can use CLONE_VM without CLONE_THREAD ...
> 
> If I understand correctly, this can only occur for shared THP but not
> anonymous THP. For instance, if either process allocates an anonymous
> THP, it would trigger the creation of a new MM. Please correct me if
> I'm mistaken.

What clone(CLONE_VM) will do is essentially create a new process, that 
shares the MM with the original process. Similar to a thread, just that 
the new process will show up in /proc/ as ... a new process, not as a 
thread under /prod/$pid/tasks of the original process.

Both processes will operate on the shared MM struct as if they were 
ordinary threads. No Copy-on-Write involved.

One example use case I've been involved in is async teardown in QEMU [1].

[1] https://kvm-forum.qemu.org/2022/ibm_async_destroy.pdf

> 
>>
>> Additionally, this
>>> can be implemented per-MM without kernel code modifications.
>>> With a well-designed API, users can even implement custom THP
>>> policies—all without altering kernel code.
>>
>> You can switch between modes, that' all you can do. I wouldn't really
>> call that "custom policy" as it is extremely limited.
>>
>> And that's exactly my point: it's basic switching between modes ... a
>> reasonable policy in the future will make placement decisions and not
>> just state "always/never/madvise".
> 
> Could you please elaborate further on 'make placement decisions'? As
> previously mentioned, we (including the broader community) really need
> the user input to determine whether THP allocation is appropriate in a
> given case.

The glorious future were we make smarter decisions where to actually 
place THPs even in the "always" mode.

E.g., just because we enable "always" for a process does not mean that 
we really want a THP everywhere; quite the opposite.

Treat the "always"/"madvise"/"never" as a rough mode, not a future-proof 
policy that we would want to fine-tune dynamically ... that would be 
very limiting.

-- 
Cheers,

David / dhildenb


