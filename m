Return-Path: <bpf+bounces-63381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA190B06963
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 00:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E893A5638A9
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 22:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC11F2D0275;
	Tue, 15 Jul 2025 22:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IS5qDo7b"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A93341AA
	for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 22:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752619427; cv=none; b=B5rz4bzIBoxDuRUmpdx4Bbk1gNGQv7XK1XNILGPekOZ0hS6Vpn+W1Jjz31UKbdBmbthO1KaSyY03XRXGqUCBuEIolJk/hIIm/RmHGZDKBWDR9c0MxycXYlyWnhKWmwi7YQGrIILR2tt4b2asnxLp3QNQn4ms78iq3CV7LQJSJP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752619427; c=relaxed/simple;
	bh=ESYTcCc9r6M80f5HN5DqPogPt/7YWGkViSrzr87DJHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDE6tDtEM6vN1oHrOSsXe+QMbCcZ7tL31lP86uDMWpxi6C68xiqgNPm6hB0K9MWfoaXVG+Y82Hsb0Uq7U7sxTsy0ta2pSbWZ3Cgbp55C+E9ZtgEocheVJ4OxNqT/0aRJj2kzCRrLpN/9ZL2o9PlDQAjgtt9j5GGz+4DKVEtAgLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IS5qDo7b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752619424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8jrrfPd3sKTC7j+572MDh5BuKujCFnIWZJNyLYNArnk=;
	b=IS5qDo7bLANvjDxE78BMbLkU7dF08Wonvu4aqKcKdfP0DovwouuyS4XrZnFwmARVEVmwCJ
	izesd6omUM6ZxgVVeJKLOydosu5CgRLIH7ydGDXM9oLMe4rK4e/fA5L/uPkFh7pvNr1Zwt
	CUKHvnpfbLT4V15Ahm5qyya3Px5kX+s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-Yrd1Fp7hNZa5h4JjYfOonA-1; Tue, 15 Jul 2025 18:42:25 -0400
X-MC-Unique: Yrd1Fp7hNZa5h4JjYfOonA-1
X-Mimecast-MFC-AGG-ID: Yrd1Fp7hNZa5h4JjYfOonA_1752619345
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a503f28b09so169908f8f.0
        for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 15:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752619345; x=1753224145;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jrrfPd3sKTC7j+572MDh5BuKujCFnIWZJNyLYNArnk=;
        b=RSBjD9zKdHlm/JVAfvzRz8uT1no6c4DMRH5jOEWudkIXC83QuFnqTHyMDtsO6e3Ttj
         ZKP1mO7lI67dIlIXKY/bW8lyj4o50YeEBFhgswcnq+lsJ9WqKRUIrRa3TSHquxYlb9og
         wCQzQyF6NYQ+/3ckq2YBUQZ0FmlZmWG/ULXDvU9fwtP2PyGU/L6O5ZntH9LSvQbQwJUt
         J39uaIn8l6svcp7J5AdJijGltXOvENTK7g9t75ncE2V39kwOmTUPhX5Lw1nMcoBEGi9K
         GzBf4XKBlLOCGLLupOmuUpEK+awQHjLQBkkDOkh4LZbsQMx/+qdYNtVPZc6wE0LT0ZZo
         7zkQ==
X-Gm-Message-State: AOJu0YwUXPLpatg+ZvVNysq308n0TUc9JaJTBlPRTkAGy0WPQzbzWPCx
	nKmsOL9ob8GNfXbHEE1Gla4NnbJJKVuR9tEcdllYcBAIkII8SauaBIzugesEm8iRiKlHUsCkGv3
	JTNVwGnmsA4VEz29Cz5f4RkibqYfL/PQePm4U4Ydh76pjkhg8dW9Iqg==
X-Gm-Gg: ASbGncvjRfpkFuveRhAYxFUP7n8ZVnSS19T54iE1y+2X6SgBnQ/HRH52KC9xzAPBR8S
	TXQLM8hxuMm+lcWokWjsjhuIPCVDB92SQ3PDe32Dq4tPfA51n4yloibmGiDqP2EsqPC7VS7dJoS
	izWBcOvtcC6MFGLEVgd+XYPfrg+MiAFBKE20F9OLujgDPfbr5zjZ9aVz0YRirxoYMth/sshvS0N
	rGGNd6qj9HKORM8YhCwUosFguEmoIJ5vI4y4eHFirQB00mH8pcL8VsuJyQa5tyanLUU9BAxsBgc
	YRJgKmVPsRSrWbk+rgcVHFOCVTcCNx/0GfbNOlPxv6FcQaNnMCb0+WsCFhxRTelYj/QymffIeZj
	ZhGuUcPvyrha0uQYtD5fGu2L1DKSVvqxHmb3otD4U3zXtgeQeYlgfK0gEsBfAJ7hhqM4=
X-Received: by 2002:a05:6000:1a8b:b0:3b2:e0ad:758c with SMTP id ffacd0b85a97d-3b609520267mr3717783f8f.3.1752619344733;
        Tue, 15 Jul 2025 15:42:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnlRzvOEtukBVdMWGytCygRYjVCMdVNmxJOnB5Cah/D20aa5NuV/jX9OOiO9VGkCts+Jllog==
X-Received: by 2002:a05:6000:1a8b:b0:3b2:e0ad:758c with SMTP id ffacd0b85a97d-3b609520267mr3717764f8f.3.1752619344270;
        Tue, 15 Jul 2025 15:42:24 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4900:2c24:4e20:1f21:9fbd? (p200300d82f2849002c244e201f219fbd.dip0.t-ipconnect.de. [2003:d8:2f28:4900:2c24:4e20:1f21:9fbd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e820e4asm3077205e9.23.2025.07.15.15.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 15:42:23 -0700 (PDT)
Message-ID: <b2fc85fb-1c7b-40ab-922b-9351114aa994@redhat.com>
Date: Wed, 16 Jul 2025 00:42:22 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/5] mm, bpf: BPF based THP adjustment
To: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com,
 gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: bpf@vger.kernel.org, linux-mm@kvack.org
References: <20250608073516.22415-1-laoar.shao@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <20250608073516.22415-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.06.25 09:35, Yafang Shao wrote:

Sorry for not replying earlier, I was caught up with all other stuff.

I still consider this a very interesting approach, although I think we 
should think more about what a reasonable policy would look like 
medoium-term (in particular, multiple THP sizes, not always falling back 
to small pages if it means splitting excessively in the buddy etc.)

> Background
> ----------
> 
> We have consistently configured THP to "never" on our production servers
> due to past incidents caused by its behavior:
> 
> - Increased memory consumption
>    THP significantly raises overall memory usage.
> 
> - Latency spikes
>    Random latency spikes occur due to more frequent memory compaction
>    activity triggered by THP.
> 
> - Lack of Fine-Grained Control
>    THP tuning knobs are globally configured, making them unsuitable for
>    containerized environments. When different workloads run on the same
>    host, enabling THP globally (without per-workload control) can cause
>    unpredictable behavior.
> 
> Due to these issues, system administrators remain hesitant to switch to
> "madvise" or "always" modes—unless finer-grained control over THP
> behavior is implemented.
> 
> New Motivation
> --------------
> 
> We have now identified that certain AI workloads achieve substantial
> performance gains with THP enabled. However, we’ve also verified that some
> workloads see little to no benefit—or are even negatively impacted—by THP.
> 
> In our Kubernetes environment, we deploy mixed workloads on a single server
> to maximize resource utilization. Our goal is to selectively enable THP for
> services that benefit from it while keeping it disabled for others. This
> approach allows us to incrementally enable THP for additional services and
> assess how to make it more viable in production.
> 
> Proposed Solution
> -----------------
> 
> To enable fine-grained control over THP behavior, we propose dynamically
> adjusting THP policies using BPF. This approach allows per-workload THP
> tuning, providing greater flexibility and precision.
> 
> The BPF-based THP adjustment mechanism introduces two new APIs for granular
> policy control:
> 
> - THP allocator
> 
>    int (*allocator)(unsigned long vm_flags, unsigned long tva_flags);
> 
>    The BPF program returns either THP_ALLOC_CURRENT or THP_ALLOC_KHUGEPAGED,
>    indicating whether THP allocation should be performed synchronously
>    (current task) or asynchronously (khugepaged).
> 
>    The decision is based on the current task context, VMA flags, and TVA
>    flags.

I think we should go one step further and actually get advises about the 
orders (THP sizes) to use. It might be helpful if the program would have 
access to system stats, to make an educated decision.

Given page fault information and system information, the program could 
then decide which orders to try to allocate.

That means, one would query during page faults and during khugepaged, 
which order one should try -- compared to our current approach of "start 
with the largest order that is enabled and fits".

> 
> - THP reclaimer
> 
>    int (*reclaimer)(bool vma_madvised);
> 
>    The BPF program returns either RECLAIMER_CURRENT or RECLAIMER_KSWAPD,
>    determining whether memory reclamation is handled by the current task or
>    kswapd.

Not sure about that, will have to look into the details.

But what could be interesting is deciding how to deal with underutilized 
THPs: for now we will try replacing zero-filled pages by the shared 
zeropage during a split. *maybe* some workloads could benefit from ... 
not doing that, and instead optimize the split.

Will maybe be a bit more trick, though.


-- 
Cheers,

David / dhildenb


