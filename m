Return-Path: <bpf+bounces-59746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D92ACF084
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 15:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15D0179F0D
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 13:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5566424111D;
	Thu,  5 Jun 2025 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iB4FaTOI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E5923644F;
	Thu,  5 Jun 2025 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749130029; cv=none; b=jk0ttFD8ML21Xxk7zf7XRBXjc6/mW9/6tn5XIKyuKcVUnpe1hzHLVJ9zLWoL50f4sXvTphGGCCtrmVDON5qRSNBNrZlJwMnaTnPKI7z7HgoDwHgfKPckC459/ZWvDCVmGDmsR2+8JK13KhR/3HQiqGTD6I8V1APDVNjhTuIZEIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749130029; c=relaxed/simple;
	bh=6WYxkDB8bWFLBv4Z/Y9ATt9LzxPCKrcOgKpqaQmRRgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A/NZYhqfkD6XYXOyOiuqP4L9oNLjRzPGTTAQy1zKyhcgbaPevUin6Z7gcbS1uUr00g9SFawob3J+tAjme3pj5RS6/WLMtro6TlLeRATBo9scmVWhH3s+itZZClk2rdBoaAC6mxOboOtA+0R+kEklVgiER5P6mXCGgkS63AqWCng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iB4FaTOI; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so8067655e9.1;
        Thu, 05 Jun 2025 06:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749130026; x=1749734826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dc0t8LJWwMsH8u7lCLoZZlP0jO1SucXJeyDx8z9BxhY=;
        b=iB4FaTOIsv/Gc4jdn04H/sUBnexSH3qNWuVn1t1ZK9edmEJ8/F5W79Hm/wBuRCYb5t
         Ld/ny15utovSsIyy+eudXoGL1OKw+/GrPs9567nTAfJv6YxKBdSH2EubWBR+HtwAfo5U
         VcXLzGDMttcuVXh60EgLK6q2ZksnB4MqSvbO0bm1o0JsaRf7Dh9f40RNmwVyIBrZAf8z
         xmdKgL+03qk842/X0hrJeS81wWGErNjq69EwxDHHXyYEk/fktmAcP7pykMs1jKhPNgRD
         Le7ZkpYaLk59FEjd/BMLSE2L8MzQKUNCNErU0+V11KEXbI0QSsHlOPxPpBv6/zexytj8
         btTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749130026; x=1749734826;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dc0t8LJWwMsH8u7lCLoZZlP0jO1SucXJeyDx8z9BxhY=;
        b=Dhsz3GAlxubBeGPxX+FFX3eHafMI1irvQXUBQOXMNvnU1Iiadt0qNO+WRlVe4wYIYW
         PADwmoteRVYbsp8lvYN/Uqc2JzlIe93lWsn+n31GY22BUruqWMa1CylYx6u59Bod38Z5
         ZkUJ6qhH+5KsA0fIwh1PESo3aAbaK+TRyPYu+eTEEkyGYu4ZoOR7r0i3ercoVVVgU469
         O5PWpkV3mAx58g0TUUrnKtPtV5/0r14SbHhwb9G+J+FTWfwSUSSBoke0oRsgNZl0kX8V
         bwY4eHJVXcPmDyQBi9yNeGQqFee1UjVDhzj7SkVFYb2tYvevoqqeaOWP49Xvnrf5PUEI
         ggpg==
X-Forwarded-Encrypted: i=1; AJvYcCUFNn0/sP9nAQ5Ak6AHCHwLDumn/OHJz38hvDbJZUJR1W8P3KPKbqxNNZ0X/aD8T9n5yMtTQigv@vger.kernel.org, AJvYcCVh7jIvafKkyzvCJWJ5QuJcgeQXAZ7U8CpXmrU171NuSuvmW8i1Sf4EXMEKiiVP7Dp8uWGYkXwnpB8cefBN@vger.kernel.org, AJvYcCWLrGc7Z4GLytwj8LMYVFby77Fh4jx3P+lT9bGx6F/zne4JQbSHKYSav6wYnVdV3Tz7rC8Srs60MHzdIQ==@vger.kernel.org, AJvYcCXFLwDdyhT65xILh41TMGa5x/A1GWUps0w0fbe1ZGXgbvL0nu4Yg35KZEnBDbMQJiRUAYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMk7KuX5k4XvT+ss2qR3pPT/7yFTaMmYHOSngJdcxaPmCxXC8C
	9JziA2lcXe+ilFGqlp1EpyUCOiaO8u6/AsFAjguYEI7/FLIQBSCCI+g6
X-Gm-Gg: ASbGnctPPHI48R/jSJxgFPHs96ODp3xR/XM/p5gU1QzAhwXrmqX0n9N/5eM+fh/8hi8
	af+3FIH3vySwU/jrl1sJNJ3jPRozUhL/a91nIEhQ4bIYmDtTIud/7zRXquKZLR8OGJWhb2UdhqG
	KA51CS5cQGqV6bk6URwGdeY81RXK2ZQgu6eyL/A8tvaBGoGZaeHB5ZZpn7HCrAcSeqwVw+yevM2
	mv5fzpXwBS2vht04yhoh5t5zRbT2qPFJeFDGhRScjyKwasdbEWMfeCs20dm/k47b7MSrKkcglTz
	YkNegrFs3AgtBoAMUptJ5b9ugie+UPDG7UE0+7hpPSutiLS9y+cju6Uvu1Yxhw==
X-Google-Smtp-Source: AGHT+IFQTEpAwXkhDKcJd2Civ8ezQlDCDxM2AVWY9CCxR7LpFEe6jtx4UHnl03vBjg7BNjYYxNKBdQ==
X-Received: by 2002:a05:6000:4021:b0:3a1:fcd9:f2ff with SMTP id ffacd0b85a97d-3a51dbb3391mr5327763f8f.12.1749130026081;
        Thu, 05 Jun 2025 06:27:06 -0700 (PDT)
Received: from [192.168.8.100] ([148.252.145.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f8311ae6sm16366935e9.2.2025.06.05.06.27.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 06:27:05 -0700 (PDT)
Message-ID: <342e7df1-ea55-416f-9f4a-2712d4087b24@gmail.com>
Date: Thu, 5 Jun 2025 14:28:23 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 18/18] page_pool: access ->pp_magic through struct
 netmem_desc in page_pool_page_is_pp()
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, hawk@kernel.org, akpm@linux-foundation.org,
 davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch,
 toke@redhat.com, tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 vishal.moola@gmail.com
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-19-byungchul@sk.com>
 <390073b2-cc7f-4d31-a1c8-4149e884ce95@gmail.com> <aEGEM3Snkl8z8v4N@hyeyoo>
 <aEGKx34Zz3v4hPTK@hyeyoo>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aEGKx34Zz3v4hPTK@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/25 13:17, Harry Yoo wrote:
> On Thu, Jun 05, 2025 at 08:49:07PM +0900, Harry Yoo wrote:
>> On Thu, Jun 05, 2025 at 11:56:14AM +0100, Pavel Begunkov wrote:
>>> On 6/4/25 03:52, Byungchul Park wrote:
>>>> To simplify struct page, the effort to separate its own descriptor from
>>>> struct page is required and the work for page pool is on going.
>>>>
>>>> To achieve that, all the code should avoid directly accessing page pool
>>>> members of struct page.
>>>
>>> Just to clarify, are we leaving the corresponding struct page fields
>>> for now until the final memdesc conversion is done?
>>
>> Yes, that's correct.
> 
> Oops, looks like misread it. If by "leaving the corresponding struct page
> fields" you meant "leaving netmem fields in struct page", no.
> It'll be removed.

I see, in which case instead we might want to leave a reminder
in page_pool_page_is_pp in a form of a build warning, but the
patch looks fine either way.

-- 
Pavel Begunkov


