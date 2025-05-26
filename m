Return-Path: <bpf+bounces-58948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E318FAC4329
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 18:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD34E16DD1B
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 16:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF95212B0C;
	Mon, 26 May 2025 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BX/EhLl3"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F7B3D994
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748278284; cv=none; b=f1yu2GjlXXqzlfi3p/L4j07AgfKpGc6rC9V3aPvGaiauIJCRx9eGgsBFq/MpYOGOwPD1GA0CjjvebXk0sbZFT8U4FLDK/hCmIjkNx5k5DbLdjOYv4qHwwxWeW46HhttEpiIRyoUNgErsjcVPoUcphnN7kNvNKUfzbj1G/wgzsWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748278284; c=relaxed/simple;
	bh=tCIuEakbIQj5oLRTwLq9J6Ftdl+qVlJpbbUQ9FD4nys=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G7UH61/8+Ob0w5smSPIIVH0WiseM/VrQcDb5s39IcvpTKGgz12cyawlyCw6MybZJrZxvVDXfric3OslslipN5mM7bb/4bx6ZyjNMa6uAGHK/vLSg8b1gB0xPzHKP/Iex8u5WgarpdQ6xUrRewXxnBxIsw+zeBt9/FM5sFqPaa14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BX/EhLl3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748278278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Pt0PsQgJt4/lxryx6602VdxSImBuyo3qMFiTm0v54CY=;
	b=BX/EhLl3vIOI7MwsL5NjDiCMLjiwIH1ViZ6IxSaNSJfRZ67zS2EeQcTeLBiGj5kcTO8nUJ
	lwdeuUQ7V7KKe1c++w7A3TLx/KakkfWnrkgtmU0XmoZRjuyfN2LalEYhvTrOPahfF/5QRm
	PztIFiYLMSG3vkEYIK8878EcIuvmqjs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-TU_QYi8GPFi0iJaMurynMA-1; Mon, 26 May 2025 12:51:15 -0400
X-MC-Unique: TU_QYi8GPFi0iJaMurynMA-1
X-Mimecast-MFC-AGG-ID: TU_QYi8GPFi0iJaMurynMA_1748278274
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43ceeaf1524so10986985e9.1
        for <bpf@vger.kernel.org>; Mon, 26 May 2025 09:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748278274; x=1748883074;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pt0PsQgJt4/lxryx6602VdxSImBuyo3qMFiTm0v54CY=;
        b=HIMI2znQgImqJbLa4L3yCnoIZDgCMvh5bz+y4CoODnhSHcHpCMZO5dWAthlBLy5oNn
         4hvQnvzEVRWSBGUwq04wmGYRy9/JtAMzSYJXANz1RrmnilaI7tScHkym4Y/2Stx4tuA2
         RuocNmiJ5+rsCwfjQASK4PtwmTB5MIMynEYfouRo6jqdoygZNljLox5zCwKbJxpUyYrO
         u7qPG2DHfTmbtbyOAGRjy7CX86pFtawPvanZ4wi/a+DcGR9Tlam1Bwdg9/tvCnEZQaA+
         W+3UdTdJi9T4B7dujvt3ya4yHWrxqZkRwJ1AD1Vy6i1GnvoLIi0RfzyzwgaCF/4CmyOV
         VgZA==
X-Forwarded-Encrypted: i=1; AJvYcCW8+q0+DZjX6F6AFeVR89Uy2D6xFLISjFMpNLZeuGNZWo9VRWfZqL41SwT/sJlv65qBTvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlqmbGJZHnupLEiDgUswl39D1LQ99j4gnuEYQktyAaFDKT/gnO
	vsiCQKqhQi5cHmgwZQNPI9qmei25hqEoyzDDPJlFdPq/BYeXBKMyc89VONz2wCdJYzttfRLtA0i
	824yDvAVE7QfD/mT6OtRnpQkwYUNyXDen864lK35XRi+SYD0GCV5Tqw==
X-Gm-Gg: ASbGncsklLcMsR2+zQGCJCTtHRfXojdc+pYp3nNp5qBfE/7xSwoPrGfrCdNUIa00T6u
	rL20ujHbMgG3AlTtmoj03jv6i3ksBmyW2QsdBQE8m6OJ670pWOf/4dltvYlpZl3P3TDDcmFkkMJ
	ifOMGCFD9MzKKe9opAe0dalmeFKdeDvq+A9aNYYE7BmY3HqVjCXPheHr7k8/uhrHOgmmBKlMf1o
	I4exXvcV0RhpXW6HRNtGxwNU7OH09m5NOk6ZSlt47l9ZHnwM4Lf8Vls65bnzo85CemzC/j4GmEW
	GIyInDY4hUl3756bUXxndciBq2HCfc/3qybx5pXL+ZIesqJThaklZCT4y1QmXLW+Fgb3xNp0hj7
	9NsVAdpH6wq5LVPXwAgGAKfaVpSahvYaTma62yL4=
X-Received: by 2002:a05:600c:6216:b0:439:5f04:4f8d with SMTP id 5b1f17b1804b1-44c92770e88mr84636065e9.12.1748278274324;
        Mon, 26 May 2025 09:51:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXt9nDrZgNZtP+pHIWOWU1D+4RJZD+/TopQY6T7CE1xEmxjK5rTn9bjGJqk1+uO46Z5FTLrA==
X-Received: by 2002:a05:600c:6216:b0:439:5f04:4f8d with SMTP id 5b1f17b1804b1-44c92770e88mr84635835e9.12.1748278273870;
        Mon, 26 May 2025 09:51:13 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f19:6500:e1c1:8216:4c25:efe4? (p200300d82f196500e1c182164c25efe4.dip0.t-ipconnect.de. [2003:d8:2f19:6500:e1c1:8216:4c25:efe4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4c9cd023csm8858992f8f.10.2025.05.26.09.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 09:51:13 -0700 (PDT)
Message-ID: <3b792576-6189-4f53-b47f-95875181a656@redhat.com>
Date: Mon, 26 May 2025 18:51:12 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 hannes@cmpxchg.org, usamaarif642@gmail.com,
 gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
 linux-mm@kvack.org
References: <20250520060504.20251-1-laoar.shao@gmail.com>
 <CALOAHbDPF+Mxqwh+5ScQFCyEdiz1ghNbgxJKAqmBRDeAZfe3sA@mail.gmail.com>
 <7d8a9a5c-e0ef-4e36-9e1d-1ef8e853aed4@redhat.com>
 <CALOAHbB-KQ4+z-Lupv7RcxArfjX7qtWcrboMDdT4LdpoTXOMyw@mail.gmail.com>
 <c983ffa8-cd14-47d4-9430-b96acedd989c@redhat.com>
 <yzpyagsqw4ryk63zfu3vxvjvrfxldbxm7wx2a3th7okidf7rwv@zsoyiwqtshfc>
 <pzuye3fkj6fj2riyzipqj7u4plwg6sjm2nyw4jkqi57u3g2yp5@jmvn5z2g5i7x>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <pzuye3fkj6fj2riyzipqj7u4plwg6sjm2nyw4jkqi57u3g2yp5@jmvn5z2g5i7x>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26.05.25 17:54, Liam R. Howlett wrote:
> * Liam R. Howlett <Liam.Howlett@oracle.com> [250526 10:54]:
>> * David Hildenbrand <david@redhat.com> [250526 06:49]:
>>> On 26.05.25 11:37, Yafang Shao wrote:
>>>> On Mon, May 26, 2025 at 4:14 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>>> Hi all,
>>>>>>
>>>>>> Let’s summarize the current state of the discussion and identify how
>>>>>> to move forward.
>>>>>>
>>>>>> - Global-Only Control is Not Viable
>>>>>> We all seem to agree that a global-only control for THP is unwise. In
>>>>>> practice, some workloads benefit from THP while others do not, so a
>>>>>> one-size-fits-all approach doesn’t work.
>>>>>>
>>>>>> - Should We Use "Always" or "Madvise"?
>>>>>> I suspect no one would choose 'always' in its current state. ;)
>>>>>
>>>>> IIRC, RHEL9 has the default set to "always" for a long time.
>>>>
>>>> good to know.
>>>>
>>>>>
>>>>> I guess it really depends on how different the workloads are that you
>>>>> are running on the same machine.
>>>>
>>>> Correct. If we want to enable THP for specific workloads without
>>>> modifying the kernel, we must isolate them on dedicated servers.
>>>> However, this approach wastes resources and is not an acceptable
>>>> solution.
>>>>
>>>>>
>>>>>    > Both Lorenzo and David propose relying on the madvise mode. However,>
>>>>> since madvise is an unprivileged userspace mechanism, any user can
>>>>>> freely adjust their THP policy. This makes fine-grained control
>>>>>> impossible without breaking userspace compatibility—an undesirable
>>>>>> tradeoff.
>>>>>
>>>>> If required, we could look into a "sealing" mechanism, that would
>>>>> essentially lock modification attempts performed by the process (i.e.,
>>>>> MADV_HUGEPAGE).
>>>>
>>>> If we don’t introduce a new THP mode and instead rely solely on
>>>> madvise, the "sealing" mechanism could either violate the intended
>>>> semantics of madvise(), or simply break madvise() entirely, right?
>>>
>>> We would have to be a bit careful, yes.
>>>
>>> Errors from MADV_HUGEPAGE/MADV_NOHUGEPAGE are often ignored, because these
>>> options also fail with -EINVAL on kernels without THP support.
>>>
>>> Ignoring MADV_NOHUGEPAGE can be problematic with userfaultfd.
>>>
>>> What you likely really want to do is seal when you configured
>>> MADV_NOHUGEPAGE to be the default, and fail MADV_HUGEPAGE later.
> 
> I am also not entirely sure how sealing a non-existing vma would work.
> We'd have to seal the default flags, but sealing is one way and this
> surely shouldn't be one way?

You probably have  mseal() in mind. Just like we wouldn't be using 
madvise(), we also wouldn't be using mseal().

It could be a simple mctrl()/whatever option/flag to set the default and 
no longer allow changing the default and per-VMA flags, unless 
CAP_SYS_ADMIN or sth like that.

-- 
Cheers,

David / dhildenb


