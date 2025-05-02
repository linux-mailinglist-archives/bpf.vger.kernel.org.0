Return-Path: <bpf+bounces-57221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C995AA72CF
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 15:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8563B65D4
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 13:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D626825485F;
	Fri,  2 May 2025 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDORorUE"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EA842049
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746191061; cv=none; b=fw6XtIkx2V+DS7lhAHbsVNzXRjudFXBedE2TPtJ8tjKDbql/PeK6hDmzaVDqx9clv2ZxQCfUlWQ+EeazZx37HgI/fj/TiqH2T67DUGuvdjoKh9MQUDGYWce2kqOmoGq2y7aEAXdCXpsoz78cGPYhUJbyiHY2oRfcGpkfe2e4AZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746191061; c=relaxed/simple;
	bh=lrDgOQfyolLHdwQcVezc/TKCoyYkd4lxbtp7TYem5BM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cczZfi4iMXXJfCMRN2dtBxu0+DQMG+VzTETYOtdRjvhaaNx5PC3Zd9S2dRQtdleAfcc0Zc+46UKFnOtwZihMRGfIgAdL2mTOlh/jd5KwI0GoqPdJ/yAhDmcYBTD1VcYbrRyyEqcIhM41XFWSCfMdbRuLOAMQGXwSFU61nsUnSKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JDORorUE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746191058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=b8vA7ufv7rxozbMaS0DZrNFTmwM1zLtlrnDHq+jM2h4=;
	b=JDORorUEoyPa8Ec3shOEBo7JdS/2GZSXuwVXOZovfYN8aOGi372Ifs2dfBIdnZ0/AhLnN8
	NQV8NADJxM87lBgFx7oRsL/zfLBFl2nAoR/RabjFBZ3qMvKak817WIujwQgVSyjDpLKavP
	eCGYfHKpBu06vJ1YA/74jBMFYrr8r7A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-3YkH0jAfOpy6_IfLHRPbSg-1; Fri, 02 May 2025 09:04:16 -0400
X-MC-Unique: 3YkH0jAfOpy6_IfLHRPbSg-1
X-Mimecast-MFC-AGG-ID: 3YkH0jAfOpy6_IfLHRPbSg_1746191055
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912a0439afso566591f8f.3
        for <bpf@vger.kernel.org>; Fri, 02 May 2025 06:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746191055; x=1746795855;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b8vA7ufv7rxozbMaS0DZrNFTmwM1zLtlrnDHq+jM2h4=;
        b=qw6+VUsckbcbkLJ2HeFHtLmvkzOGrgvVbefCunOgpbY1AA9GhhMG8F6xSWJT5Fd93k
         j0ffL+41EakJ+y6VZ9/QsM9Z7U5kCHVUPW/qUNUwbn19tYuycveqavYQNBKIH78v7JgJ
         ormz2KpS1NvMecZLaFM+g4jX9anWoFjM3bfjG+MDi0bRUwclg0EwPP7KU9+G2Z3a/r2q
         87w6EAS2/QjMpNE9BjqiVbRFd8RE7N2tqyyu0SOxbcS1mXzfawlA4vBw1rCHRs/mGz8l
         UfxAsI82VqjyDz8DRj91zkfR6DNdD+U2MUeRwJtzsb0twr5A0N96o/fT4Drmh+cjuhwU
         szvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIAmR3oEpVnwwBnOG7MFq/tnWTg5LSXwvvPuISr05UIeG+ayBFxo+P0xlpOuBtKPpPnWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5am3Gp/PW1m5uuphAk/clJllegccwkjawOKW6fJc+89SsoQWZ
	R2YuVPjlMBK4/pPBZ5Kg41cXpjCVUIYiByBxNEDBvPk2Bn6EF/5KGw/HoHPKyMVKQWRVoAQxjAM
	e2Zg7oOkWBV33rmVKLa0ZOPBargB4zRHmC20qC/mcZBuiS2cbsw==
X-Gm-Gg: ASbGnctolyG4t+aSKeoPvVceWgWoQgm6Kg/LGYsnCSH+EFmGCVoJ90KnkDcw0s6nHin
	XhBdRW0YhdiX0YohZ6K7L5txfqhGFgoNg5eAarVperz7Zb0cT8mj10nAFIWpXLiEjaJsCM9LJxP
	55SfAf+DM7nidhbc/8vp2x5KvO/UxmlKjEjL80smDKuqtz5e2MGV10R/HazKgajJidXJAHcjcRf
	dCAa2XT6wlGsXxKd8GCeh3DHppbeX5788kwwV8ZXq63X9+8s9rLffHDZ0+TxEfvasbVpOUPn1oF
	egEEVQwniBDbiDBE3f693uP79p7EnTr5datfwqXgn+DbiiaxGBCIOg5R/8315uigPoKmOKDxh/w
	Um1GJ6muXkWz2BOE0FjWBIDJzRlON/IMPUVUYE9M=
X-Received: by 2002:a05:6000:144d:b0:3a0:7a90:23a9 with SMTP id ffacd0b85a97d-3a099ad4749mr1993908f8f.6.1746191055145;
        Fri, 02 May 2025 06:04:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8jpbSSJEe8gtGnqL+2yrcAlYrtSegOPp0Ofhi+j5di9OzaCw4P4w2wfI1df6wE73kvrTHgg==
X-Received: by 2002:a05:6000:144d:b0:3a0:7a90:23a9 with SMTP id ffacd0b85a97d-3a099ad4749mr1993851f8f.6.1746191054546;
        Fri, 02 May 2025 06:04:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:d600:afc5:4312:176f:3fb0? (p200300cbc713d600afc54312176f3fb0.dip0.t-ipconnect.de. [2003:cb:c713:d600:afc5:4312:176f:3fb0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae3528sm2157932f8f.30.2025.05.02.06.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 06:04:14 -0700 (PDT)
Message-ID: <4883bdec-f7f2-4350-bf72-f0fa75c9ddd5@redhat.com>
Date: Fri, 2 May 2025 15:04:12 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] mm, bpf: BPF based THP adjustment
To: Yafang Shao <laoar.shao@gmail.com>, Zi Yan <ziy@nvidia.com>
Cc: Gutierrez Asier <gutierrez.asier@huawei-partners.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, bpf@vger.kernel.org, linux-mm@kvack.org,
 Michal Hocko <mhocko@suse.com>
References: <20250429024139.34365-1-laoar.shao@gmail.com>
 <D9J7UWF1S5WH.285Y0GXSUD30W@nvidia.com>
 <CALOAHbBfSat7-qOjKseEJy=w5MVF7um3vYKPCb0VMbEgw-KAuw@mail.gmail.com>
 <42ECBC51-E695-4480-A055-36D08FE61C12@nvidia.com>
 <CALOAHbCtBB81MKV5=rTM03qt=qCF-CWctCmF0xjxDo_sXwaOYw@mail.gmail.com>
 <8F000270-A724-4536-B69E-C22701522B89@nvidia.com>
 <mnv3jjbdqx3eqrcxjrn5eeql3kpcfa6jzyjihh2cdyvrd7ldga@3cmkqwudlomh>
 <CALOAHbCNrOqqTV9gZ8PeaS1fcaQJ-CkUcwvFsx6VjHTmaTHjgQ@mail.gmail.com>
 <ygshjrctjzzggrv5kcnn6pg4hrxikoiue5bljvqcazfioa5cij@ijfcv7r4elol>
 <CALOAHbCL-NOEeA1+t=D2F_q7UUi7GvkLDry5=SiehtWs1TKX1Q@mail.gmail.com>
 <20250430174521.GC2020@cmpxchg.org>
 <84DE7C0C-DA49-4E4F-9F66-E07567665A53@nvidia.com>
 <6850ac3f-af96-4cc6-9dd0-926dd3a022c9@huawei-partners.com>
 <CALOAHbDbVOzKy9yZxePZFY8XSOgoLT4S_c=VW8sbbU6v9F-Ong@mail.gmail.com>
 <3006EA5B-3E02-4D82-8626-90735FE8F656@nvidia.com>
 <CALOAHbA6uWTGZ10n3Lk2Jm5xBPC5ob9aw87EHmkvm6__PYJ_5g@mail.gmail.com>
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
In-Reply-To: <CALOAHbA6uWTGZ10n3Lk2Jm5xBPC5ob9aw87EHmkvm6__PYJ_5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 02.05.25 14:18, Yafang Shao wrote:
> On Fri, May 2, 2025 at 8:00 PM Zi Yan <ziy@nvidia.com> wrote:
>>
>> On 2 May 2025, at 1:48, Yafang Shao wrote:
>>
>>> On Fri, May 2, 2025 at 3:36 AM Gutierrez Asier
>>> <gutierrez.asier@huawei-partners.com> wrote:
>>>>
>>>>
>>>> On 4/30/2025 8:53 PM, Zi Yan wrote:
>>>>> On 30 Apr 2025, at 13:45, Johannes Weiner wrote:
>>>>>
>>>>>> On Thu, May 01, 2025 at 12:06:31AM +0800, Yafang Shao wrote:
>>>>>>>>>> If it isn't, can you state why?
>>>>>>>>>>
>>>>>>>>>> The main difference is that you are saying it's in a container that you
>>>>>>>>>> don't control.  Your plan is to violate the control the internal
>>>>>>>>>> applications have over THP because you know better.  I'm not sure how
>>>>>>>>>> people might feel about you messing with workloads,
>>>>>>>>>
>>>>>>>>> It’s not a mess. They have the option to deploy their services on
>>>>>>>>> dedicated servers, but they would need to pay more for that choice.
>>>>>>>>> This is a two-way decision.
>>>>>>>>
>>>>>>>> This implies you want a container-level way of controlling the setting
>>>>>>>> and not a system service-level?
>>>>>>>
>>>>>>> Right. We want to control the THP per container.
>>>>>>
>>>>>> This does strike me as a reasonable usecase.
>>>>>>
>>>>>> I think there is consensus that in the long-term we want this stuff to
>>>>>> just work and truly be transparent to userspace.
>>>>>>
>>>>>> In the short-to-medium term, however, there are still quite a few
>>>>>> caveats. thp=always can significantly increase the memory footprint of
>>>>>> sparse virtual regions. Huge allocations are not as cheap and reliable
>>>>>> as we would like them to be, which for real production systems means
>>>>>> having to make workload-specifcic choices and tradeoffs.
>>>>>>
>>>>>> There is ongoing work in these areas, but we do have a bit of a
>>>>>> chicken-and-egg problem: on the one hand, huge page adoption is slow
>>>>>> due to limitations in how they can be deployed. For example, we can't
>>>>>> do thp=always on a DC node that runs arbitary combinations of jobs
>>>>>> from a wide array of services. Some might benefit, some might hurt.
>>>>>>
>>>>>> Yet, it's much easier to improve the kernel based on exactly such
>>>>>> production experience and data from real-world usecases. We can't
>>>>>> improve the THP shrinker if we can't run THP.
>>>>>>
>>>>>> So I don't see it as overriding whoever wrote the software running
>>>>>> inside the container. They don't know, and they shouldn't have to care
>>>>>> about page sizes. It's about letting admins and kernel teams get
>>>>>> started on using and experimenting with this stuff, given the very
>>>>>> real constraints right now, so we can get the feedback necessary to
>>>>>> improve the situation.
>>>>>
>>>>> Since you think it is reasonable to control THP at container-level,
>>>>> namely per-cgroup. Should we reconsider cgroup-based THP control[1]?
>>>>> (Asier cc'd)
>>>>>
>>>>> In this patchset, Yafang uses BPF to adjust THP global configs based
>>>>> on VMA, which does not look a good approach to me. WDYT?
>>>>>
>>>>>
>>>>> [1] https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutierrez.asier@huawei-partners.com/
>>>>>
>>>>> --
>>>>> Best Regards,
>>>>> Yan, Zi
>>>>
>>>> Hi,
>>>>
>>>> I believe cgroup is a better approach for containers, since this
>>>> approach can be easily integrated with the user space stack like
>>>> containerd and kubernets, which use cgroup to control system resources.
>>>
>>> The integration of BPF with containerd and Kubernetes is emerging as a
>>> clear trend.
>>>
>>>>
>>>> However, I pointed out earlier, the approach I suggested has some
>>>> flaws:
>>>> 1. Potential polution of cgroup with a big number of knobs
>>>
>>> Right, the memcg maintainers once told me that introducing a new
>>> cgroup file means committing to maintaining it indefinitely, as these
>>> interface files are treated as part of the ABI.
>>> In contrast, BPF kfuncs are considered an unstable API, giving you the
>>> flexibility to modify them later if needed.
>>>
>>>> 2. Requires configuration by the admin
>>>>
>>>> Ideally, as Matthew W. mentioned, there should be an automatic system.
>>>
>>> Take Matthew’s XFS large folio feature as an example—it was enabled
>>> automatically. A few years ago, when we upgraded to the 6.1.y stable
>>> kernel, we noticed this new feature. Since it was enabled by default,
>>> we assumed the author was confident in its stability. Unfortunately,
>>> it led to severe issues in our production environment: servers crashed
>>> randomly, and in some cases, we experienced data loss without
>>> understanding the root cause.
>>>
>>> We began disabling various kernel configurations in an attempt to
>>> isolate the issue, and eventually, the problem disappeared after
>>> disabling CONFIG_TRANSPARENT_HUGEPAGE. As a result, we released a new
>>> kernel version with THP disabled and had to restart hundreds of
>>> thousands of production servers. It was a nightmare for both us and
>>> our sysadmins.
>>>
>>> Last year, we discovered that the initial issue had been resolved by this patch:
>>> https://lore.kernel.org/stable/20241001210625.95825-1-ryncsn@gmail.com/.
>>> We backported the fix and re-enabled XFS large folios—only to face a
>>> new nightmare. One of our services began crashing sporadically with
>>> core dumps. It took us several months to trace the issue back to the
>>> re-enabled XFS large folio feature. Fortunately, we were able to
>>> disable it using livepatch, avoiding another round of mass server
>>> restarts. To this day, the root cause remains unknown. The good news
>>> is that the issue appears to be resolved in the 6.12.y stable kernel.
>>> We're still trying to bisect which commit fixed it, though progress is
>>> slow because the issue is not reliably reproducible.
>>
>> This is a very wrong attitude towards open source projects. You sounded
>> like, whether intended or not, Linux community should provide issue-free
>> kernels and is responsible for fixing all issues. But that is wrong.
>> Since you are using the kernel, you could help improve it like Kairong
>> is doing instead of waiting for others to fix the issue.
>>
>>>
>>> In theory, new features should be enabled automatically. But in
>>> practice, every new feature should come with a tunable knob. That’s a
>>> lesson we learned the hard way from this experience—and perhaps
>>> Matthew did too.
>>
>> That means new features will not get enough testing. People like you
>> will just simply disable all new features and wait for they are stable.
>> It would never come without testing and bug fixes.

We do have the concept of EXPERIMENTAL kernel configs, that are either 
expected get removed completely ("always enabled") or get turned into 
actual long-term kernel options. But yeah, it's always tricky what we 
actually want to put behind such options.

I mean, READ_ONLY_THP_FOR_FS is still around and still EXPERIMENTAL ...

Distro kernels are usually very careful about what to backport and what 
to support. Once we (working for a distro) do backport + test, we 
usually find some additional things that upstream hasn't spotted yet: in 
particular, because some workloads are only run in that form on distro 
kernels. We also ran into some issues with large folios (e.g., me 
personally with s390x KVM guests) and trying our best to fix them.

It can be quite time consuming, so I can understand that not everybody 
has the time to invest into heavy debugging, especially if it's 
extremely hard to reproduce (or even corrupts data :( ).

I agree that adding a toggle after the effects to work around issues is 
not the right approach. Introducing a EXPERIMENTAL toggle early because 
one suspects complicated interactions in a different story. It's 
absolutely not trivial to make that decision.

> 
> Pardon me?
> This discussion has taken such an unexpected turn that I don’t feel
> the need to explain what I’ve contributed to the Linux community over
> the past few years.

I'm sure Zi Yan didn't mean to insult you. I would have phrased it as:

"It's difficult to decide which toggles make sense. There is a fine line 
between adding a toggle and not getting people actually testing it to 
stabilize it vs. not adding a toggle and forcing people to test it and 
fix it/report issues."

Ideally, we'd find most issue in the RC phase or at least shortly after.

You've been active in the kernel for a long time, please don't feel like 
the community is not appreciating that.

-- 
Cheers,

David / dhildenb


