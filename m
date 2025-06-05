Return-Path: <bpf+bounces-59797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6592ACF8BE
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 22:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665BE179CF0
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 20:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C269D27E7DF;
	Thu,  5 Jun 2025 20:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeyA6d63"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC2F27C163;
	Thu,  5 Jun 2025 20:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749155183; cv=none; b=p3FQkINz63XuijgJorR8QmSHqRMIkP+QhwFUUXsWCvjr1JoI3RZ44Y4Mktj1e5p/gCGcvW3zujZew6OixSzMsFbLuop+3PMZj41BE/rLDxPjn3V26SbRseXjRfG9GjDq4ZcnTIFShoCqgtYDgErb5+P0yBql53q5DHnuzeTeWEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749155183; c=relaxed/simple;
	bh=fYciFyOdVG/nTMsy/FRr5xrC0jXrQA6oYaa97AL118w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CqwEOanpo4j2GbpW2IRkUrjja1YqQFqGgAGfAIN/swdHcohm+/1kjFwW9fiTisn/0d0UWZVfFIK10jjZeR+jF2/CXJDrHgT7kGQLC/Ev1iFqPt8HLpE99uPOIOeiyL2GQ5poV4nsPNGrjzmHd0eIEwFWwwphHnp+YwnnwZZTxgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeyA6d63; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-442e9c00bf4so11592535e9.3;
        Thu, 05 Jun 2025 13:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749155179; x=1749759979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ziYA5HNk/3b+C572WPNtkL1FIpx+25jD8CPAOz0v7y8=;
        b=eeyA6d63Y1HctD2tTRx+5uRycmq3G+rjUXZx4zcU5SxcnC782tOMN2+rjhqCgCbZdm
         gAs9oV8SfQSEVd3Up/jFsITiMFntDvu5A5sY1zcpu4uPDZo8Nmmb1QSpEhqlIgj6076/
         PW0Ns6wDb6aF70Qgl+R477wYVoTIGNbXkeRXlZZfpC0GCxriLQc9WCzyieoHMZw0JQ5m
         YgqcHzNf16cNjcnAULy7T6USrnrNIm4C6W/xWAhDh1RD39/uJzL0P6AJaZKK8qcCR/62
         4DSKzUwHrgSyGMSUUoclvLN2gbZwWQdlmX21mP/pz6k3/l6RjtFX5WlIInbFHbPclwPY
         QblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749155179; x=1749759979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ziYA5HNk/3b+C572WPNtkL1FIpx+25jD8CPAOz0v7y8=;
        b=MYpSliLcdd7tMEmOfVkIJa88SMjpih5alC6qKkQ9c1VYq9B4kxGxmBKZwAFy1nAWeK
         sgrGOX5lfb8BxYUCJ8m5qX44+6W3QPpqvR2wXV0GAv4dNmQfgqLd4OuEXlPi10MuG4e1
         d5XAI1e4wG9HsTa03mRUkvvVutHsNOx4QHWIJsqZ7843+bt1E8FCxwUo7q25KEAGymF8
         QtynAjQTDJcTAyHf6yECmXvo5rFNGxV0dkPU4IBP6GLS4vx+QZ/wW8aAcxX6TLgmvtzQ
         2kvdzVxq4bnZakWsJASgo1tpwa0H/JseX7cbfIF42Hhj24yJWsLA+cuiKmmlISVLm/70
         Q6gw==
X-Forwarded-Encrypted: i=1; AJvYcCUPtMQbuIFq6p+UASc1rvBQuzUiUROcUZY6tLsAQQi4UAWnLdfMG4OoQKIMVOqcEYr9lgVjlvYoWtAE5g==@vger.kernel.org, AJvYcCVLUKT8sNPc1m/GXysqtTMTY8u6EIwQEQWnw4/p0pMV/ukY9YT45EsAix5MrVRXPW/ys78HxwzwLvRMXme+@vger.kernel.org, AJvYcCWC/Ij45qw8iGPJFGwryqnkA3NIpLQk11UmNS8tdP0u2S2941DvSbejyMqKbcT0Tj3PdIekAM5W@vger.kernel.org, AJvYcCXWPbk5hIuspLIQY3cSIRJM8/cXQB+CJagmMdlfNm8unFmFw20P6TJTrWjmZm2PukHa4WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZazRkbuG6CTVP2cixmgWdNHFfONlk5lPpGwxjpKyepLVPulKC
	oXBwOzuEium7rssqvTewaVHqHmZCvWIvQJspLeUvn7805r4mn6glCFDZ
X-Gm-Gg: ASbGncsa6mmoN1Dow3Jbuyu8ZuFijCNGwQVwfF5y8Hm4v/9h+O4AqOKq8X8/mXptuvv
	mtJt4Qe2l17MaqmZjmD4wMA0kA1mbanOgXM5ndzocxNeHb5UpaEcQxp5ZEN3jgVsKOMnhJ/FEWN
	1+qocyyCJYiCi6Sqeba6D0ip2j0d5tzgvZoNwVStkEfnQd1GYDuno2L6QVI5eJWx0ajGekqvVmG
	5dQYGZEX0LSzihMKUA3MYOb17ccWJnZMfZNIA2jy5BZbgHI0zqcZFwIZm5QCf4v9HcTq6NeO5nu
	LR+joHyMIAUQHrFeomMfc/lUZOM3cKN+Y/cKDSkquV+zKGRpGyyMOB1Ne8A2kA==
X-Google-Smtp-Source: AGHT+IEQKdgJ+yBlCmq313HWyJi8MKwe0ZhZefu46HwpijquuDpy56UFySftqQ0mr5S2uC/fiW9I5g==
X-Received: by 2002:a05:600c:6749:b0:450:cc3d:6a03 with SMTP id 5b1f17b1804b1-452013fd6c0mr8637935e9.7.1749155178354;
        Thu, 05 Jun 2025 13:26:18 -0700 (PDT)
Received: from [192.168.8.100] ([148.252.145.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532464e7fsm133755f8f.96.2025.06.05.13.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 13:26:17 -0700 (PDT)
Message-ID: <ec924af7-1330-4220-97be-1171ef6ffc75@gmail.com>
Date: Thu, 5 Jun 2025 21:27:41 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 03/18] page_pool: use netmem alloc/put APIs in
 __page_pool_alloc_page_order()
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
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-4-byungchul@sk.com>
 <29f2c375-65e3-4d22-8274-552653222f8d@gmail.com>
 <CAHS8izMb23eaav-Fz50sefuS8BhF7as7=BX+Sv1wj01+0n6tMg@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izMb23eaav-Fz50sefuS8BhF7as7=BX+Sv1wj01+0n6tMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/5/25 20:39, Mina Almasry wrote:
> On Thu, Jun 5, 2025 at 3:25 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> On 6/4/25 03:52, Byungchul Park wrote:
>>> Use netmem alloc/put APIs instead of page alloc/put APIs and make it
>>> return netmem_ref instead of struct page * in
>>> __page_pool_alloc_page_order().
>>>
>>> Signed-off-by: Byungchul Park <byungchul@sk.com>
>>> Reviewed-by: Mina Almasry <almasrymina@google.com>
>>> ---
>>>    net/core/page_pool.c | 26 +++++++++++++-------------
>>>    1 file changed, 13 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>>> index 4011eb305cee..523354f2db1c 100644
>>> --- a/net/core/page_pool.c
>>> +++ b/net/core/page_pool.c
>>> @@ -518,29 +518,29 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, gfp_t g
>>>        return false;
>>>    }
>>>
>>> -static struct page *__page_pool_alloc_page_order(struct page_pool *pool,
>>> -                                              gfp_t gfp)
>>> +static netmem_ref __page_pool_alloc_page_order(struct page_pool *pool,
>>> +                                            gfp_t gfp)
>>>    {
>>> -     struct page *page;
>>> +     netmem_ref netmem;
>>>
>>>        gfp |= __GFP_COMP;
>>> -     page = alloc_pages_node(pool->p.nid, gfp, pool->p.order);
>>> -     if (unlikely(!page))
>>> -             return NULL;
>>> +     netmem = alloc_netmems_node(pool->p.nid, gfp, pool->p.order);
>>> +     if (unlikely(!netmem))
>>> +             return 0;
>>>
>>> -     if (pool->dma_map && unlikely(!page_pool_dma_map(pool, page_to_netmem(page), gfp))) {
>>> -             put_page(page);
>>> -             return NULL;
>>> +     if (pool->dma_map && unlikely(!page_pool_dma_map(pool, netmem, gfp))) {
>>> +             put_netmem(netmem);
>>
>> It's a bad idea to have {put,get}_netmem in page pool's code, it has a
>> different semantics from what page pool expects for net_iov. I.e.
>> instead of releasing the netmem and allowing it to be reallocated by
>> page pool, put_netmem(niov) will drop a memory provider reference and
>> leak the net_iov. Depending on implementation it might even underflow
>> mp refs if a net_iov is ever passed here.
>>
> 
> Hmm, put_netmem (I hope) is designed and implemented to do the right
> thing no matter what netmem you pass it (and it needs to, because we
> can't predict what netmem will be passed to it):
> 
> - For non-pp pages, it drops a page ref.
> - For pp pages, it drops a pp ref.
> - For non-pp net_iovs (devmem TX), it drops a net_iov ref (which for
> devmem net_iovs is a binding ref)
> - For pp net_iovs, it drops a niov->pp ref (the same for both iouring
> and devmem).

void put_netmem(netmem_ref netmem)
{
	struct net_iov *niov;

	if (netmem_is_net_iov(netmem)) {
		niov = netmem_to_net_iov(netmem);
		if (net_is_devmem_iov(niov))
			net_devmem_put_net_iov(netmem_to_net_iov(netmem));
		return;
	}

	put_page(netmem_to_page(netmem));
}
EXPORT_SYMBOL(put_netmem);

void net_devmem_put_net_iov(struct net_iov *niov)
{
	net_devmem_dmabuf_binding_put(net_devmem_iov_binding(niov));
}

Am I looking at an outdated version? for devmem net_iov it always puts
the binding and not niov refs, and it's always does put_page for pages.
And it'd also silently ignore io_uring. And we're also patching early
alloc/init failures in this series, so gauging if it's pp or non-pp
originated struct page might be dangerous and depend on init order. We
don't even need to think about all that if we continue to use put_page,
which is why I think it's a much better option.


> In my estimation using it should be safe to use put_netmem here, but
> I'm not opposed to reverting to put_page here, since we're sure it's a
> page in this call path anyway.
> 

-- 
Pavel Begunkov


