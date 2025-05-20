Return-Path: <bpf+bounces-58579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B53A1ABDDEE
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 16:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5953F3A3A0A
	for <lists+bpf@lfdr.de>; Tue, 20 May 2025 14:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA13824BBFF;
	Tue, 20 May 2025 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJcnYroX"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C7524C692
	for <bpf@vger.kernel.org>; Tue, 20 May 2025 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747753010; cv=none; b=HcRzZhdhOOls8Fr37FJm+leJU+hTmYh9bnYcYpWrwH6ZDHovgNixkA78GZ8F6ZGkPHrBOI7ZP8+FPCS1vHzHwxiFVcIFSKo1Q4TCz3Uo6lAkw/d8IVnRL3SXH8uhKt0MLDPYAhQd7blBQMwJ2hsj7Qp1QN+3uCJiwIgVuwfbl8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747753010; c=relaxed/simple;
	bh=2LdRJtf2yISWGWF6OV+Z2o13Y/uRPGpnWFGXEhexxxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4aVwxG4gA2hz0MrZqRNrGAcmHrC9KQy+MiuzGa64SzXjiJuvqlOjg3rlFywW6vPE0o0kGvbqxJImUAsmWlIY0g1WXhtzJjVQFY1bZWi/i/sXWhQDmKhxTLBB7DtJwUzdtfYxe5X48Ubw0ojYl2Q5THa/5uDHf3oLphrEHE0vLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QJcnYroX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747753007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hgevXuEZZW8LSKx2vHFxozeKINRQNhHwr9GnByFFOLI=;
	b=QJcnYroXT6TCC8HHILD2EqdmoK2e5dtma2SziBWm4v3vdKV8fPX7y6Ebujk0GXwdAKeIC0
	yEW3+ws3FjBPlYuAhdKloXBP1Q6KGWRYr1SL0lqvbG1iGdPIaK/BZaNDHVNVMnNR65EFeM
	ZaAk5jDb+o7nnACY41YwYGC4lajnbpY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-EgVieURjNKSjXUeR_EBlfw-1; Tue, 20 May 2025 10:56:46 -0400
X-MC-Unique: EgVieURjNKSjXUeR_EBlfw-1
X-Mimecast-MFC-AGG-ID: EgVieURjNKSjXUeR_EBlfw_1747753005
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-441c96c1977so39323255e9.0
        for <bpf@vger.kernel.org>; Tue, 20 May 2025 07:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747753005; x=1748357805;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hgevXuEZZW8LSKx2vHFxozeKINRQNhHwr9GnByFFOLI=;
        b=Y0o4Ut+8M6Evf7Qc2tvGijnI2zJrYS5Fn2TS68XcK3oX5xRr4M4VngW0eZLVJKR1IA
         0/dnArJLgPUlt4UBznepyPmUMwrDxs0/9EJ8+kamJF3nHrOHsF98aJ53jvzId1V8ZdNG
         Gz5KHlFDZqBkg/3dZUfFbyFhox4uTP5QPJhRY8FDC6RN+QlckgK1JGgvPn8GGwwRCN4B
         /eqRuNMeXLFa/+0GaHgBO77O09Ky1eWmwxOBk/xCrOle7zdG0os0CtZhcZPnbSUsuMzL
         Yj5Md/bjS4Hc3zWnUaotj9JANBgm0UzC81MQhoED2quboiUXOJRnz70b8/EKI5DQ4TFx
         YzXw==
X-Forwarded-Encrypted: i=1; AJvYcCUUzyqp0YQiAX3cptLPiLLLZ79bkZuD3CtBXg7tHtKwWABJSgX6Jo03s3XYSPGn9NF0e4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm0xsvYJBi7gfuWMDOw06xR+ktJ4p8yokVx/f/yGdiUcPZDK9e
	bnubqEhaGADsGbRuzxUrO/LbgJDPLMr+6sVmalaXd2+GE7U5/zfpUgosZi6mZJi1C/xMze1Yp2y
	otrr6GmgBUTvAVUsT3U+8q2TgS3UKhD6QUqaN/6sqzx4+KqqEe2W7Mw==
X-Gm-Gg: ASbGncsMGg5gfxSkZSfq2CeNBOQjW15XpM3moXJLCPzDO1Kr+JcXAphp4nDxLyg0JCg
	+0LgKCIJdrZHfbyzYj8mfwJODAD1Pmg0ahsI1exp82tPvHnu+tFC/WKBcqQXCOEAr9v2izr4z1w
	ySasy//REMLl7FA+9d+8k9HpbI0+aUSzU7W3Gbyww/gxB2yJj+24Sb/O5dzv91KmkbsmuogFUJT
	oEKwbTxIDwdN0LPFVIBXT9LvuKgQhNJCJms76CzFaIN/Hjg8/bKfh8NAc0NdUn3J+yFXp3rxQ/o
	66MH66w4ydxKbh8Ocrbp9Zur0+MkPKgPmZB2Uw8Lytqc3mqamysYqu0Z04/ga0OO3ZV6RhRaK/T
	vLlbanHeSuHErokcYjG27wF+ZDzfvOb6EXIGfv0o=
X-Received: by 2002:a05:600c:3e10:b0:43d:3df:42d8 with SMTP id 5b1f17b1804b1-442fefd780fmr140403385e9.6.1747753005167;
        Tue, 20 May 2025 07:56:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9tBLuIgp6b3rpJtD1JwfZWf8l7EqKb1g3XEWVXooTfTkNPJt6ZsPzG6SUzyVX2E2AJBNpGg==
X-Received: by 2002:a05:600c:3e10:b0:43d:3df:42d8 with SMTP id 5b1f17b1804b1-442fefd780fmr140403045e9.6.1747753004818;
        Tue, 20 May 2025 07:56:44 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:7c00:a95e:ac49:f2ad:ab84? (p200300d82f287c00a95eac49f2adab84.dip0.t-ipconnect.de. [2003:d8:2f28:7c00:a95e:ac49:f2ad:ab84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b29619sm36408515e9.7.2025.05.20.07.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 07:56:44 -0700 (PDT)
Message-ID: <ead86239-0e0f-4c69-801f-af5667f163de@redhat.com>
Date: Tue, 20 May 2025 16:56:43 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
To: Matthew Wilcox <willy@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Usama Arif <usamaarif642@gmail.com>, Yafang Shao <laoar.shao@gmail.com>,
 Nico Pache <npache@redhat.com>, akpm@linux-foundation.org, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org,
 gutierrez.asier@huawei-partners.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, bpf@vger.kernel.org, linux-mm@kvack.org
References: <20250520060504.20251-1-laoar.shao@gmail.com>
 <CAA1CXcD=P8tBASK1X=+2=+_RANi062X8QMsi632MjPh=dkuD9Q@mail.gmail.com>
 <CALOAHbDbcdBZb_4mCpr4S81t8EBtDeSQ2OVSOH6qLNC-iYMa4A@mail.gmail.com>
 <aCx_Ngyjl3oOwJKG@casper.infradead.org>
 <CALOAHbDUmad6nHnW755P8VYf+Pk=DogW0gMH4G73TwvKodW54A@mail.gmail.com>
 <2345b8b9-b084-4661-8b55-61fd7fc7de57@lucifer.local>
 <82f7bca5-384f-41e5-a0fc-0e1e8e260607@gmail.com>
 <a3dfae27-2372-47b7-bc67-49a0c5be422b@lucifer.local>
 <aCyU7Q2DhPPF3Oau@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <aCyU7Q2DhPPF3Oau@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.05.25 16:42, Matthew Wilcox wrote:
> On Tue, May 20, 2025 at 03:35:49PM +0100, Lorenzo Stoakes wrote:
>> I agree global settings are not fine-grained enough, but 'sys admins refuse
>> to do X so we want to ignore what they do' is... really not right at all.
> 
> Oh, we do that all the time,  Leave the interface around but document
> it's now a no-op.  For example, file-backed memory ignores the THP
> settings completely.
IIRC, it never honored it. Like shmem it also never honored it an 
instead used it's own toggle (not sure what to think about that ...).

-- 
Cheers,

David / dhildenb


