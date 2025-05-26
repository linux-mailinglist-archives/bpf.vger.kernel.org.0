Return-Path: <bpf+bounces-58927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5503AC3B57
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 10:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2361C3B72A8
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 08:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09B31E492D;
	Mon, 26 May 2025 08:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAwgPeYl"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1601126BFF
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 08:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748247251; cv=none; b=JWE+qnXyvmlixuqMDsm1/3ox8HspjAgCf7P2GrnxpSGa07y5cdFSvwdYFm+UllGbjQBUsfNQ/2AoXSTsG0wM5o9m74oT30O3jb/UvVGKHcV37YddeQBHuvpUdaj9nQfwsOD1Xs05JXrE7FkROSjqr4HKykI3pX6aapA5iO3lKac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748247251; c=relaxed/simple;
	bh=tWFY+pg/7wQ1iaRT39mESIRyZVC4IrD0X3pjSyRxvVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwDJYTR/XBsUV0sFfjhh48s6i9PlxNp9kOeo7EiA7uAKVLM7gl8LrbduWWqCl038cVjwDFMDn15jIByw9wqbIU9JrhGqogym3XZB9ob0G8J2uEBUTv2QCIzEwfU4bdjsIsVZQ+kp2F7C00WxHZ+9Y6KNNPBqyeVZfUUq7eU2mfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NAwgPeYl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748247248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CyPxOExGuZuHt7Uj8mb4KmjcOADgn7z7PFJ+Tr4yO/k=;
	b=NAwgPeYlVN6x1PX+vF8nODzVcQiBnR7W87gZorHpq2HyErfiPQsaQsVlE1K4FXdI9rISDF
	r+y2QqlJjuaZUuQ1rCmV2/FhQtdhIL3IFwbm0yyj/wTt0oeez7YdvxRYA0II7tjEp0gkRw
	uad8gA6vipkAvWOcUteDl/WWQH20Y4A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-RhdEz7qfNlaF1D_hJso_yQ-1; Mon, 26 May 2025 04:14:05 -0400
X-MC-Unique: RhdEz7qfNlaF1D_hJso_yQ-1
X-Mimecast-MFC-AGG-ID: RhdEz7qfNlaF1D_hJso_yQ_1748247244
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4dcfb3bbcso147888f8f.1
        for <bpf@vger.kernel.org>; Mon, 26 May 2025 01:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748247244; x=1748852044;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CyPxOExGuZuHt7Uj8mb4KmjcOADgn7z7PFJ+Tr4yO/k=;
        b=D+UVCHtQCuhJv6KtdUlAOWQ9s9ma2+oJqh4nmPxY3/1kmersNO8rGKNJxdjLuhi14O
         ckwY/Q9iiCtTFU0JGIawX/3b5PFrBKW3pjd1WwkGpQyROHfVGVoBw1xFpq98eNIRzGT0
         UAf+yYhHjB/dZvBfPAlFBo6ooWpRqbiycQCqcgIyTgvZ1Dfd5JmroG+gVdnoEp9HeVnk
         Z1gwh/5sc96DMNgJMWCIAAAG+GNsIs3QDK168nc0sHf5zuj0DmsOOLMS/7ofXA946wOQ
         rN1Tank9ibS/z/HKL9Aof+76RiT6tvwueO4AWarMbu8TkJGZMnLHj4LsypAdHEHaNqc3
         V0Vw==
X-Gm-Message-State: AOJu0Yxo+ogMmNisAOzzqbTAwv+BOiW1UgCMFF4CMSraLa/AtvDPuAp+
	EYoXQVDjuPWhrUZci+LvjJtf+bhk/ZD9YhBONj0Kxg7wk3w6txLXpKC1GcTTy5YEh+JzW4QWein
	H61U0LONemx59R7KyNvTKBJZQnJetCYs9a8OVe++AjuMUEMQ/t4zhWw==
X-Gm-Gg: ASbGncvTP9FxjFLvIPRlOR88x9X7SebYybU/hJP7OkKhZFoiqXacVjNn4gcpVeGeIyv
	lKW4unVIUqZKf4sjZyWWt2bnpAdMh//2oh/cxQBE2nIUi86VsBOLxghlsnB+Kr6JU5nlJE4+mSa
	4aupxRPQxVejqRGvyd5cGJQfUhHk7TwXwGy9mfbggmhdAY621rBc4ev6snJuYkD+hUnP5kuS7r1
	syZ/LjIxAPA64mrQ8RI7Z93jnP5/IO9rlTNw9OZCr16WD4OAVlqqJJrdPfWvjGHv5wBDM5S8gOb
	552kaklWmP2THvr+jpofDPIQhh3zoCwj2lakir4KOP3gyHFR1c0/MXj0KnJx2Q/PnbzyTAZAy9L
	6tcsxYmKNWHYnnyQGZ4AG7kpSISuTAePAAuGJaWg=
X-Received: by 2002:a05:6000:310f:b0:3a4:d939:62e6 with SMTP id ffacd0b85a97d-3a4d9396416mr1914765f8f.51.1748247244382;
        Mon, 26 May 2025 01:14:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn3oVw/lC5SQ1DDXnWrc1jkhDWr3Ylarfxu3lcyO4dUuWDX4ju/pAOH4k9TpodQaaBatQUdA==
X-Received: by 2002:a05:6000:310f:b0:3a4:d939:62e6 with SMTP id ffacd0b85a97d-3a4d9396416mr1914734f8f.51.1748247243979;
        Mon, 26 May 2025 01:14:03 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f19:6500:e1c1:8216:4c25:efe4? (p200300d82f196500e1c182164c25efe4.dip0.t-ipconnect.de. [2003:d8:2f19:6500:e1c1:8216:4c25:efe4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4ce458830sm6499970f8f.14.2025.05.26.01.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 01:14:03 -0700 (PDT)
Message-ID: <7d8a9a5c-e0ef-4e36-9e1d-1ef8e853aed4@redhat.com>
Date: Mon, 26 May 2025 10:14:02 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
To: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com,
 gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: bpf@vger.kernel.org, linux-mm@kvack.org
References: <20250520060504.20251-1-laoar.shao@gmail.com>
 <CALOAHbDPF+Mxqwh+5ScQFCyEdiz1ghNbgxJKAqmBRDeAZfe3sA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CALOAHbDPF+Mxqwh+5ScQFCyEdiz1ghNbgxJKAqmBRDeAZfe3sA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> Hi all,
> 
> Let’s summarize the current state of the discussion and identify how
> to move forward.
> 
> - Global-Only Control is Not Viable
> We all seem to agree that a global-only control for THP is unwise. In
> practice, some workloads benefit from THP while others do not, so a
> one-size-fits-all approach doesn’t work.
> 
> - Should We Use "Always" or "Madvise"?
> I suspect no one would choose 'always' in its current state. ;)

IIRC, RHEL9 has the default set to "always" for a long time.

I guess it really depends on how different the workloads are that you 
are running on the same machine.

 > Both Lorenzo and David propose relying on the madvise mode. However,> 
since madvise is an unprivileged userspace mechanism, any user can
> freely adjust their THP policy. This makes fine-grained control
> impossible without breaking userspace compatibility—an undesirable
> tradeoff.

If required, we could look into a "sealing" mechanism, that would 
essentially lock modification attempts performed by the process (i.e., 
MADV_HUGEPAGE).

The could be added on top of the current proposals that are flying 
around, and could be done e.g., per-process.

-- 
Cheers,

David / dhildenb


