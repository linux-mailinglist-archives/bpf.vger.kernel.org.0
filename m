Return-Path: <bpf+bounces-59129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56695AC62D2
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 09:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 055E51681B9
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 07:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7707B244695;
	Wed, 28 May 2025 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FB+mTpCf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560BE1367;
	Wed, 28 May 2025 07:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748416794; cv=none; b=gbPEm0fP0Z/LL9MCDB21Pg7+FjMCi/Rj8HXS5KVd0c1/fT7x7Zzahzr8fQ+ZWzwTdtdHwiT3t8aZq8F7jzt2PAO5NOUy7ukphxBWez0E3Fk/2DKfyi+ROuCOp54n0xukIFKGgOLYEuUHY3Ev0rkkirlr1ZS7F65SVF1JQMn/Lgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748416794; c=relaxed/simple;
	bh=ntMPcjZr9Pm033gu7Fx/HPiDio0i+/tdgt6pURKOm3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6AzwIi/EEPINIewO4UBGkPAD1gH8wY6jWwEoeRLlLMSWfdjFPb1CwnUVmyJlKUUnUOpSiaMKH9eflT3LcouWpREqmO6vpW23+uYNN9y2tGQ9s6LNdlR4WfS9cNlG6yqatKZXJ1wBEB96H76MSYhwuOfZaSmWADzlA3DK5+Z3xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FB+mTpCf; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso756682966b.0;
        Wed, 28 May 2025 00:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748416790; x=1749021590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OUbnFWv1f37Ta+BVjxPt8pmoACrgGpNv4OYgueKntrw=;
        b=FB+mTpCfdRvwEn1BlHrIVHbShcpMMUmFr6tI6TGzrSEJ59tlIB897ZiAH+fRNBYV4r
         yZtcxXqa/vmE7KTEf55H5ZdS/G5fgUYYs1hlGaxPu83NR+eSSRHCAvBzv+HbRQYsR9xC
         Gc7gd1fla9AcvALJhEgFLlKIibWodgprLTjOvTfyUXetovUej3Q1c0Ml9vH+rI/Ua/Ea
         7YKbG8LL7R2OAc8wRvsIQv+hCRr/w1nur5Y8yd7DxRNGZaxT59dg7keKsCgssHgwmpaD
         tNh8x72NGXp1P4iU6A3mFiDZxwM+lgAmbQVKKj7yyqGqJ10fagGG4YyymQm4pFNgxeW/
         4OZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748416790; x=1749021590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OUbnFWv1f37Ta+BVjxPt8pmoACrgGpNv4OYgueKntrw=;
        b=IGFX9P/KDK01l754Dxig8VSc4rLfAIRZ5/LO1ImlESVtdqdonANfZJO0PbUdLMwAE8
         iziT7p3FvZ/30OMe08sHWdm8te7A5xPpcs06XBDImztHvDP0cZf0/VYuyMD6zgaUCaXb
         +YzdfRYVMAa8tZWPnwoEIGwwMV+WbBITCP78vfzC09a1+DrrkvdKvLQ2wMWtKC8WT81I
         SQKoIz7RhyplmGSYRI0ZMTnVvVCpMBFKN1VhOe9/9IPdIJ14Zzd12v3rA3BZV+vZAHcT
         D9NYhzhkgsfXo6A5BCuRYxaKrZXReBpM5mujuK1GogrMJjjS5lldzf6uxlI+l2/wjE1B
         Ll1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYVwMYO4KVbW3+957pXKxizbiePZN4RiOkUruL9c4YZEtDpd80vYvsjmPh6kZBeQ7y3f8=@vger.kernel.org, AJvYcCVzvc54lxEiA5dYECfEGbxAMUkzj6vvtoclAtW9Hlmd4NHQ1DIjgdjynv1/E/i6RhGKHynIvzAl@vger.kernel.org, AJvYcCXKZZ1WGMtpdQD+uSQzg9//Ho/mdZ5e3ZSNjildIogi2OBMU2Ms6HZP9PZg9ss8Y5C3ZV5IgzB4NAKF09DG@vger.kernel.org, AJvYcCXU6x0mBro9pOZjX3U7TXOQ4Sk2X+NKgQnb3wSWVA6ncqxbLktPkCKPlgmukSyD3m1D/HmsweiozODNRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgU1QrPRCTt64/HuuGXR/Ujwr2Dkk812nc537mDTdgQ0ti2j0+
	9QL0ie8/ygoWP2Whg6InVgNWD381Q+eZiMcSuRsRXqNLxCQxXXD/cOM+
X-Gm-Gg: ASbGncv+cNgeQY/BocoIccFuN1oNmcPzXiouER6WZc9ABVqUeKQtqE5asw3dvXDaqgP
	AcnVjBBsYNd7kPtPN3s27MehzFziCxGTeytznvUzw849F7MC8jy8whLlul5Ogc6XcuKoBkNesxi
	BRaRMKJ3eUqNLg1NZ3LfoR+wIfZFbYJINtMx4DAMiPPWhqmGgcIwXAmgD4WrUpW/+8a/zAPU4d3
	IFxe2ISSMD2vMNNLJnhF4TtguWBaYf3hs7aBwUkgvLcHnkg1Zmcvp2LfjxM37V0RmPH8TvwHubh
	hGRdxSZPhq9osKyywfavmIpTS6MYbqEpiJ2wXrmMfRyepUWGiq4Wm4uFt64eEP0=
X-Google-Smtp-Source: AGHT+IF8u/oWlE6nDqmRdBTJqi0N5ZpxlTVC/BaksAktgdabSWc2dFiSy583FQXlAFD49z4UcobfKw==
X-Received: by 2002:a17:907:3fa3:b0:ad1:e4e9:6b4f with SMTP id a640c23a62f3a-ad8a1f31b03mr95247266b.36.1748416790119;
        Wed, 28 May 2025 00:19:50 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::6f? ([2620:10d:c092:600::1:c447])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad8a1a1322fsm58712266b.80.2025.05.28.00.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 00:19:49 -0700 (PDT)
Message-ID: <187e12ce-7e25-4fe0-871d-170f22125f8e@gmail.com>
Date: Wed, 28 May 2025 08:21:00 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/18] mm, netmem: remove the page pool members in struct
 page
To: Mina Almasry <almasrymina@google.com>
Cc: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, ilias.apalodimas@linaro.org,
 harry.yoo@oracle.com, hawk@kernel.org, akpm@linux-foundation.org,
 davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch,
 toke@redhat.com, tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 vishal.moola@gmail.com
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-19-byungchul@sk.com>
 <CAHS8izM-ee5C8W2D2x9ChQz667PQEaYFOtgKZcFCMT4HRHL0fQ@mail.gmail.com>
 <20250526013744.GD74632@system.software.com>
 <cae26eaa-66cf-4d1f-ae13-047fb421824a@gmail.com>
 <20250527010226.GA19906@system.software.com>
 <651351db-e3ec-4944-8db5-e63290a578e8@gmail.com>
 <CAHS8izNYmWTgb+QDA72RYAQaFC15Tfc59tK3Q2d670gHyyKJNQ@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izNYmWTgb+QDA72RYAQaFC15Tfc59tK3Q2d670gHyyKJNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/25 18:38, Mina Almasry wrote:
...>>>> struct netmem_desc *page_to_netmem_desc(struct page *page)
>>>> {
>>>>       return &page->netmem_desc;
>>>
>>> page will not have any netmem things in it after this, that matters.
>>
>> Ok, the question is where are you going to stash the fields?
>> We still need space to store them. Are you going to do the
>> indirection mm folks want?
>>
> 
> I think I see some confusion here. I'm not sure indirection is what mm
> folks want. The memdesc effort has already been implemented for zpdesc

To the best of my knowledge, it is. What you're looking at should be
a temporary state before all other users are converted, after which
mm will shrink the page in a single patch / small series.

> and ptdesc[1], and the approach they did is very different from this
> series. zpdesc and ptdesc have created a struct that mirrors the
> entirety of struct page, not a subfield of struct page with
> indirection:
> 
> https://elixir.bootlin.com/linux/v6.14.3/source/mm/zpdesc.h#L29
> 
> I'm now a bit confused, because the code changes in this series do not
> match the general approach that zpdesc and ptdesc have done.

In my estimation, the only bits that mm needs for a clean final
patch is a new struct with use case specific fields (i.e. netmem_desc),
a helper converting a page to it, and that everyone uses the helper
to access the fields. I'd argue a temporary placeholder in struct
page is an easier approach than separate overlays, but either is
fine to me.

> Byungchul, is the deviation in approach from zpdesc and ptdecs
> intentional? And if so why? Should we follow the zpdesc and ptdesc
> lead and implement a new struct that mirrors the entirety of struct
> page?
> 
> [1] https://kernelnewbies.org/MatthewWilcox/Memdescs/Path

-- 
Pavel Begunkov


