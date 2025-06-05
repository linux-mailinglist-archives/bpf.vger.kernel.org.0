Return-Path: <bpf+bounces-59796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7F4ACF8A3
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 22:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7FE1894940
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 20:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BF727D77D;
	Thu,  5 Jun 2025 20:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brPlE76X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FC417548;
	Thu,  5 Jun 2025 20:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749154495; cv=none; b=IBk4K7A0iJT5m9I2cTN7cfRzaY2E01mHwXmN7yfBv5HFghN/S9gplR6OCRl6poDsIj1+BWkjUDb4OLEMN+3GJ8bzNYjSbue+oPUC72nonAwlJCBwOI9YJcgHqnSArzT4zCxlonPz9+jLzrFZrSPjrPct+y1LfM/FlUjADxUzYGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749154495; c=relaxed/simple;
	bh=k2Q0O9UQ45RQ36LfMj7Bdv+5YX5+XlaWPgX7rs7Tix0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSxUZrWpi5avJIJSwfyRbVexmm3pO/6CdMyRXxxYH/MTsWtm3FC3YxT6Y0YArqqP7d0MRVMv9UqKepPQg7gHGBwKvABpm4dgDqV6JXGc6daXz0XEHMXPhGm/zsT6GzrK1E4iCz0RyZNthR8D4ytJKhpzj1zYCUENCSbU1skx08g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brPlE76X; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so11888895e9.1;
        Thu, 05 Jun 2025 13:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749154491; x=1749759291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f+cjUMM/AEqKNUgpKT4nzaOOhbvSaoi3UBoC5zwm/Gw=;
        b=brPlE76X144Jhoaarg43T2KSiFFR/rNZAoERd7cldT6gPzXtcBGJ8s0Xom2t3rkTkb
         wnZhYSjlH940uVXofIWbdD+qHnl8nl3DeN4Ppu3G3xoyaBVcCpIPBUzLw5rgsKoXMAlI
         gDDI+7iQcMJ2C//5NPwWN8Jl/N+OuXIK9sQd0CDG9siM5V8WUc15dHAILBiGfxAMFS20
         zmYUwOtxrQ0XwiESmA31mh4jXAR+qgX0sYhAL1fyxTTxBMcS8XyT5cbrM86rp7qxqUe9
         I/hcCoxQE5jIdrZJl1q7Rg/oR4uUx2NI+yfaquJrdrd3lSTRkqmmm7UliJPjAvEubqwW
         Bftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749154491; x=1749759291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+cjUMM/AEqKNUgpKT4nzaOOhbvSaoi3UBoC5zwm/Gw=;
        b=Qbz1iYX4D33ez58u9mbzytcQL5d/6eDKr03t8Ra2FOspT7JmdBF10Ke2E6L3yGWcJv
         sCQ7RqHyWhm7/qEwCqdCNzaiI/fVejr9y8lLvtO+xVcfj040caSntCerkLjF2PkWU6g3
         wV9Cz0PxL59jAS3p7/ajQDxs9LA1Q0JgzQEBHjKpHfdR+y1yEm8+wsEi7MwBVmYtF5XT
         ugYDXTUun12Mx+uYivmjNU1XAIPVUIzWdW70SLGVJVgnhu20xIrWV1D463vvNYERIYQg
         Rb4oUjzFp1PSor4hWy2mmESb4l9s3fiJulrN7uP7FFPQr9sCvIT7e5PR8fPvzZKMSPCt
         qMkA==
X-Forwarded-Encrypted: i=1; AJvYcCUB02rJu44s9l/fQhCPq4VvaEjS9vsYfbQOQeN7to4tiUTOMh9AbRImFEIzpy3V3Gqt4iv6wsru@vger.kernel.org, AJvYcCV4v0hX7alnDSWj20L9NG/CYmZJmRnwXEpHhe/ygZHNLw0tbU/gS4578Zy+mrCHHIlFqbFDCx8xmx/pSpyh@vger.kernel.org, AJvYcCVoNIGqLRG4e+5fOnfmYyror9qvJd7NghOdKdl7rpYc0264NB9p/Nnpt2G413OaNroMVXsz7LLYGoRjuA==@vger.kernel.org, AJvYcCVyddUP/vTXVjqym4CBePUs4lQi/5bm8OwgmyY4iLpp5je2RL5CoMAZNKmLZ/kuHYnbgR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3gOu1PIpYEnf7X0MC0DYp8C6XJ57txTf4sZ2HUTYRyzpjMhDz
	ojzZuiCWM5Co5A2l1V57TVGB+mEYxnrqTAcpzG6baQpJ0BwqTLNstF65
X-Gm-Gg: ASbGncsERJNBn9jFbSvMhdhjjbTKwXmhWC/RIL2Aq471uD7eCkcS7RH2aIEmAR2aOkk
	7yqGvrfHsxcOnHcnhn4qITdO5mnzbKpCprvfTqPHwnsrkxMEpAWYNqk+U01mWxbpdh+5Vh67qGY
	CP2PNDfgvkrl52HFGrLVuH0wzVuLNqYhKUI8dY6Im4Js0S9ECxCFEY+mnci2DQj1sznsaTi9Xvi
	+WXSXicpfROkmm8st9dYX2t/LBtUmHj7t9sdvVs48WhbrrRQyOTXNAKgF0zsg0a2wVHBiuGvEg1
	wPHSutujFZF7Me8RYc7bNLa61H9iTXr8XA7PXcgZmxrj/HbrGwc+jD2/WejBZZsdaEf5yEn7mfI
	ikOOXFW4=
X-Google-Smtp-Source: AGHT+IFYycvJM2i/VSYKq/XS+8nRykdaQFdAMb7xHQBYhmMNIZdyie6Xtr4zGV+6D8zpAAR7QV4waw==
X-Received: by 2002:a05:600c:1d05:b0:43b:c592:7e16 with SMTP id 5b1f17b1804b1-451f844f896mr52572425e9.3.1749154490953;
        Thu, 05 Jun 2025 13:14:50 -0700 (PDT)
Received: from [192.168.8.100] ([148.252.145.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452730b92d4sm109565e9.19.2025.06.05.13.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 13:14:50 -0700 (PDT)
Message-ID: <9138df77-fe7d-430b-a369-05453a76bdb4@gmail.com>
Date: Thu, 5 Jun 2025 21:16:12 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 18/18] page_pool: access ->pp_magic through struct
 netmem_desc in page_pool_page_is_pp()
To: Mina Almasry <almasrymina@google.com>, Harry Yoo <harry.yoo@oracle.com>
Cc: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, ilias.apalodimas@linaro.org,
 hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net,
 john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com,
 tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 vishal.moola@gmail.com
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-19-byungchul@sk.com>
 <390073b2-cc7f-4d31-a1c8-4149e884ce95@gmail.com> <aEGEM3Snkl8z8v4N@hyeyoo>
 <CAHS8izPvdKZncxARWUqUqjXgoMb2MmMy+PaYa8XCcWHCQT-CSg@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izPvdKZncxARWUqUqjXgoMb2MmMy+PaYa8XCcWHCQT-CSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/5/25 20:47, Mina Almasry wrote:
> On Thu, Jun 5, 2025 at 4:49 AM Harry Yoo <harry.yoo@oracle.com> wrote:
>>
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
>>
>>> If so, it might be better to leave the access in page_pool_page_is_pp()
>>> to be "page->pp_magic", so that once removed the build fails until
>>> the helper is fixed up to use the page->type or so.
>>
>> When we truly separate netmem from struct page, we won't have 'lru' field
>> in memdesc (because not all types of memory are on LRU list),
>> so NETMEM_DESC_ASSERT_OFFSET(lru, pp_magic) should fail.
>>
>> And then page_pool_page_is_pp() should be changed to check lower bits
>> of memdesc pointer to identify its type.
>>
> 
> Oh boy, I'm not sure that works. We already do LSB tricks with
> netmem_ref to tell what kind of ref it is. I think the LSB pointer
> tricks with netmem_ref and netmem_desc may trample each other's toes.
> I guess we'll cross that bridge when we get to it...

I believe Harry wants to tag struct page::memdesc, while
netmem is tagging the struct page pointer / net_iov.

-- 
Pavel Begunkov


