Return-Path: <bpf+bounces-65620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE03CB26159
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 11:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8263B1030
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 09:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB602E92AC;
	Thu, 14 Aug 2025 09:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdNHMX1K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EF11A9F94;
	Thu, 14 Aug 2025 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755164495; cv=none; b=MTYXp1KvVTtVk3qzD5HbbNgomZcI1laAZ+8wOggIibhk2WSN0Ymd7PAvxyaWYH5GAbPt71/DdlMdr6TdJRl6N88p0vXTxzQeOoURuinHex0iwLPjXeVHV1U0g+pngHemhvHx9gnP32YRT8QX3mCCoF8HNGjH0CQ6fFgefEcjO/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755164495; c=relaxed/simple;
	bh=fqWw6Rlkb6iW5fYfJR1lVN007rszHDAUsQ5oLmIgy/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p88OMIUVGIJ6n2ye3pMy9AcU9ILxo1OxNWHkHdJcguseoqbSCGktNOKtuaWhpge3QbQBty0v20wI/M1WPoFr7iV6xn9gX0W5xMaTw/Vj95DeAzkxNz23S5YrLTQ3DBsGgcuArrrtGZcZdpHwmW5zQ54zupp1e64uwdRNoV/W3is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdNHMX1K; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b0bd237so5753915e9.2;
        Thu, 14 Aug 2025 02:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755164492; x=1755769292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mfVsnps5PF16eK/6Z6rbqgY0AeNAHzhL7ZogriCupsE=;
        b=WdNHMX1KzEEAylfU/Dya/2xOa3nxCBrjaVnGtOPiX9yf+Ib0r1jt3DSx3XbKFBJRY3
         BgYQNh/8s2zevQPbORjzt1Fzwn62qw/eTL6XgIgUlQyz26RWjvQ/LSyruP9HBVHqXGER
         HrB5guwvkSZtsqLHpVZYTVvDnd27qONC4xsFs0zU14pXKv7+8BudIw/gD7SPjWQUmpLb
         dWOTjz8523FCxf+ZFO8KyQIRKjgxgSQaPvaTwP5KHfYLhvdk6MZn4+jRCVZlbPcE1w5P
         t84QEbtlZNgTwGb+pvDDgjvK69T4vgTS/SdmjxDmXvHaXnZzDDYKWoFqGNSAG/U3ICNv
         fvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755164492; x=1755769292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mfVsnps5PF16eK/6Z6rbqgY0AeNAHzhL7ZogriCupsE=;
        b=qUHuyWe02uAb8mVgt0osRhA2aDAGggFB/wQzcWSULcAuzdRCbIqBUMGC59Y7ofGPCK
         N2EC1zVyvdTYHh0paatuvJShQSgSCp5MVWUZbMqxlE6705suGKYjnEiJUhET+jLIkX/L
         Ox+n68kG64B9tktSl4I/Im4O6MgiQEk9BvuI65snhKtGAK6eVEa4gjn4wt+OtiRsCtJo
         Do4nZvcS4/061bbnrFie9fyflhH4YwQydJZADk3vGNYQuFM5HgfhK52ZC4QKCw8au2Pf
         OsHWcHPp+7t587wHnPdqK7flzTg4cOYan8IZ+RC+VGvtkNTyq1SF+k6kW3ZDMsrPT8Pe
         a+Rw==
X-Forwarded-Encrypted: i=1; AJvYcCU0kjEf6iEtjZCvdajw6BIw9N/1i5NK2ZaITCxUU5k5odEyZhoX64QL+f9rTeQ95gFWQk40kdIOsTqOn83c@vger.kernel.org, AJvYcCUhSqEee1nzkkSZPEVUIm9056/35MmKw1w0G7jl7GVhC36OrCNz1kJUm0EtxZupAicVyfots7Dm@vger.kernel.org, AJvYcCUzIf11/JK+OxteUyNnNuxa6MDXsGQ7zAgI85AosVmIQ47j41Pi9buf27uhwZfnXk48tzUAuLDDXthC9w==@vger.kernel.org, AJvYcCUzhSGVJGk5mTYUtyn5/a2bYVFGqBaKTQ8qMn7XGtR1n7ARiX2YEUYzSbEmiV1kEE+Rz3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxexseO+QNzdo8NW7uKOnExUh2P1u65km9GICzTudkSAvJ0WSdQ
	qURPKQyuxh93tT9hgCojHNr4cgmDVqeiBy+pNLo8YyukR/cwtjtB/3xN
X-Gm-Gg: ASbGncttQZUudnsUaiVp2jwj9hLEgb4VPD5o5Smv/joQCEn+YY1rYxbPvjf8Rx6xLMn
	8IvlqUINnZDirCx+EP0cBIYKN94j2Se/ou+QvkTMSqjiR/Gug+Z4x2g0irEnk8x4pHHf278drY6
	a8JbOkB/1oYEeN4djDuifMc0ZNzF9vxYqxcCDH7/FnhOehrJHvVl1Fe0GH8kB2/ZMhD64KiQ+mC
	W/zp4SGVrBv0QpF2elJ1k+eOVxSl5sRQGoJ7VLiLT+pHFD+J/wm4xn6iGlun0JtNlpghquP2SJ6
	9JPc2mh1WYx+6lOhlJiALRkD5u1w0BmFF3ExnMo936v1/69FlWDMBN354K1i6R3S7E6KSwPXf9p
	+coWFmSP0xKEQCCH6te0Az6oUzcjy9Ww01JqKA3o39UXilw==
X-Google-Smtp-Source: AGHT+IHBe3UbzHGADMZbxm6C1MQMCttafmz3pDCs0fFtOpYQDzgStuK34BlZw62Cf2j8jvkUuST0pA==
X-Received: by 2002:a05:600c:3b93:b0:459:d780:3604 with SMTP id 5b1f17b1804b1-45a1b605845mr18547955e9.3.1755164491690;
        Thu, 14 Aug 2025 02:41:31 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::26f? ([2620:10d:c092:600::1:7acd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6be10esm15261205e9.3.2025.08.14.02.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 02:41:30 -0700 (PDT)
Message-ID: <e8d33a38-6465-432a-9c28-25f2689e95da@gmail.com>
Date: Thu, 14 Aug 2025 10:42:47 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next v3] mm, page_pool: introduce a new page type
 for page pool in page type
To: Jakub Kicinski <kuba@kernel.org>
Cc: Byungchul Park <byungchul@sk.com>, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, kernel_team@skhynix.com, harry.yoo@oracle.com,
 ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 ilias.apalodimas@linaro.org, willy@infradead.org, brauner@kernel.org,
 kas@kernel.org, yuzhao@google.com, usamaarif642@gmail.com,
 baolin.wang@linux.alibaba.com, almasrymina@google.com, toke@redhat.com,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org, sfr@canb.auug.org.au,
 linux-mm@kvack.org, netdev@vger.kernel.org
References: <20250729110210.48313-1-byungchul@sk.com>
 <20250813060901.GA9086@system.software.com>
 <6bbf6ca2-0c46-43b7-82d8-b990f01ae5dd@gmail.com>
 <20250813075212.051b5178@kernel.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250813075212.051b5178@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/25 15:52, Jakub Kicinski wrote:
> On Wed, 13 Aug 2025 12:18:56 +0100 Pavel Begunkov wrote:
>> It should go to net, there will be enough of conflicts otherwise.
>> mm maintainers, do you like it as a shared branch or can it just
>> go through the net tree?
> 
> Looks like this is 100% in mm, and the work is not urgent at all.

There is a slight dependency in rc1, but we should be able to
massage it to be mm only.

> So I'm happy for Andrew to take this, and dependent patches (if any)
> can come in the next cycle.

Yeah, good option. It'd be a good idea to cut the diff down to
avoid removing the relevant mm page state checks until the next
cycle.
  >> @@ -1379,9 +1376,11 @@ __always_inline bool free_pages_prepare(struct page *page,
>>    		mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
>>    		folio->mapping = NULL;
>>    	}
>> -	if (unlikely(page_has_type(page)))
>> +	if (unlikely(page_has_type(page))) {
>> +		WARN_ON_ONCE(PageNet_pp(page));
> 
> I guess my ask to add a comment here got ignored?

It's an old patch attached as a point of reference. Any actual submission
surely will need to follow up on the reviews.

-- 
Pavel Begunkov


