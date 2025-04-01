Return-Path: <bpf+bounces-55064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EDDA77825
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 11:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F693A9AB0
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 09:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECC51EFFA6;
	Tue,  1 Apr 2025 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLeg8oeR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC6F1E885A;
	Tue,  1 Apr 2025 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501031; cv=none; b=cAXe/UT89ppN9bVsVKBOZTeOMzXwVzqSUlkUJ5mV5B3yEk7d2BW38tguxM4gpjl8LyU4RLzHRHSWl3vBd5yV779gtq5dEg/jP0Y20Z1xC0bFnavjX3E+L/24qVw9otdFKoDbUQzly1KqvnSlVZ6VR6xBSYyiL+CfpfDjRCG8xA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501031; c=relaxed/simple;
	bh=mN+r3l5BYppqbDPFz2ZI1YzWoeXFkdVVAuPHlsbw2ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=os6tpVZBpJ9QMfpomqymCbEVwo9rUFJiEkxxErPVPAX02NW87Mtny2BVHptxugeb83ib6M70S+eDuxiJoMDoymVR+B6gKm5L4L2L7VNL/aGBW8OhkWzCdvZOwvFl631kiJ+o0mq/qmQdUyIrSwX+5M7XTf+QU7CRGslN9W8yNNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLeg8oeR; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac289147833so903397366b.2;
        Tue, 01 Apr 2025 02:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743501028; x=1744105828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N+JLssv1AK7cF3bk55PwbvYVlA9DmcWtt6kaFg+hOt4=;
        b=ZLeg8oeRSZOnvT7MyvQ68djit/GWbyzs8WH5RvQ2u9Ls/Yrxs5txedWakTWxpJa8y4
         +LOpWrjj4Vk4heUdZnjOBpI0TXHtcMofS3jj2QzM58ugTxilPNW7WvYI66m6VDW0eo2I
         /JdkDcBMktmK1u4i4fj7UvP0kizLu2KEiO3qSPAbdje2dg/WrAQxKuf3/gu6Nj+syzAt
         CscxzTHuT/5fNmrhylpWMaa/8/JDUX7/9E/K7tm22atFFqPcTOqNTdIsF7McVWk5VNrd
         pvbImhZ+tes4+1WZwnJoe+DIxu5UmwzFe62c+R7gFhQJLHAr5LGLlDPrLfv9Rgo2ybyu
         s5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743501028; x=1744105828;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N+JLssv1AK7cF3bk55PwbvYVlA9DmcWtt6kaFg+hOt4=;
        b=cwOiPi69gKmBEEiHnFH4IiHDdFrY54GgGlAkCFJolZKM1xiTmtyFw9kykRAmny/iSQ
         0NvkOEoMZ7sEAs+yzC+IlZOo6KByhacitg66jiAcO8fGsLBmRsPS7aABkKMIj4nPG4q8
         6ACnGm261lZ8kXKH9NY5/1D0npvhIJRGJ2pTOwO7fHvs0Mjbcts6zQdQTJSRfj/aYfcL
         IdAEXUdbr8aYyyzTweFLV1O/J9jBcNjfxb9AfQ1zdIkkB6duAT212q22mYiHmKW+sf78
         faJfjjyMwZbYnm7BMuu3qhjAoPzoPy3BQm4Q83wR0/NaPvX6k0TexjcNazZuhnMgEssF
         xxfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4gYVPi3YLk8MgmQz7yLdm+R1iTxmjgtRajTwfLJueSLZU3nEIz5ap73yDcbpYDee44t33tvdhrGAUvQ==@vger.kernel.org, AJvYcCVqVLMiKN1QTx12f8AYPy2lke/Z6+aoUnoeEdXA5XoCjwc4AFMEaloHX0vs8zux7fTVHwg=@vger.kernel.org, AJvYcCWx3kWMIVCn3djxzANax+vn2kr85gPQ9WZWIqQu3ldz15o3JwZAPyMffi2oLRJPjKKfjUt9Im8w@vger.kernel.org
X-Gm-Message-State: AOJu0YwMj298PzkJMIw2qBSdU5wRvSov9IdZ3h0IK8hcetw0JPG/NKsD
	3glUiyjjsiUrJF95VyQLDmnfNmXbTmcwTiqSBnw7X5eSbHEWTzHU
X-Gm-Gg: ASbGnctJtMrBH4qK7LwNLKrzjpMgJOQi8k82p5xX2PTkrNqlmVcC0pASf1py03QYCGs
	Jv7jV2SIUHBXIce8fAR/Lzf5fnTOPwnjBI9HcmdflgLSgRHPI6/G5KaEfkY/tC4BTawFCKGamZF
	CChnSlMDin7up/sjVsU+TEt9SDNcP50ECBNkei7Zt7QTiWbvr8ChV+b/ailJLmsoyAj/O+NAmSi
	qAXJ8+hO9yqXGt6RcvFS+8g/MqlvjFMPCH+3HwZJL2CCBsMTpZoJCoyGb+RYW80vAN8ey1Xbulz
	e8+BvDrRkJzODMBgdig9MxXRZhYX969BqjnPUhcroUn7VB5MbkIcW2uuRJQg+T19hk0=
X-Google-Smtp-Source: AGHT+IGh2DypmZ+QSXfEisjKopl7DmAwPz9kLZ/RHhdI/lnARU+4Ncn1lxWa8OzglpQ3F99FmoTtsg==
X-Received: by 2002:a17:907:86a6:b0:ac2:29c7:8622 with SMTP id a640c23a62f3a-ac738c6f07emr1290856566b.54.1743501027938;
        Tue, 01 Apr 2025 02:50:27 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::83? ([2620:10d:c092:600::1:2418])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71922bf79sm737733166b.35.2025.04.01.02.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 02:50:27 -0700 (PDT)
Message-ID: <6d1e3c98-e28e-4d30-bff5-1dada745f722@gmail.com>
Date: Tue, 1 Apr 2025 10:51:46 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
To: Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Mina Almasry <almasrymina@google.com>, Yonglong Liu
 <liuyonglong@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
 Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org, linux-mm@kvack.org,
 Qiuling Ren <qren@redhat.com>, Yuying Ma <yuma@redhat.com>
References: <20250328-page-pool-track-dma-v5-0-55002af683ad@redhat.com>
 <20250328-page-pool-track-dma-v5-2-55002af683ad@redhat.com>
 <aaf31c50-9b57-40b7-bbd7-e19171370563@intel.com>
 <7488e6cf-e68b-4404-aaa9-f4892b2ff94b@redhat.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <7488e6cf-e68b-4404-aaa9-f4892b2ff94b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/1/25 09:56, Paolo Abeni wrote:
> On 3/31/25 6:35 PM, Alexander Lobakin wrote:
>> From: Toke Høiland-Jørgensen <toke@redhat.com>
>> Date: Fri, 28 Mar 2025 13:19:09 +0100
>>
>>> When enabling DMA mapping in page_pool, pages are kept DMA mapped until
>>> they are released from the pool, to avoid the overhead of re-mapping the
>>> pages every time they are used. This causes resource leaks and/or
>>> crashes when there are pages still outstanding while the device is torn
>>> down, because page_pool will attempt an unmap through a non-existent DMA
>>> device on the subsequent page return.
>>
>> [...]
>>
>>> @@ -173,10 +212,10 @@ struct page_pool {
>>>   	int cpuid;
>>>   	u32 pages_state_hold_cnt;
>>>   
>>> -	bool has_init_callback:1;	/* slow::init_callback is set */
>>> +	bool dma_sync;			/* Perform DMA sync for device */
>>
>> Have you seen my comment under v3 (sorry but I missed that there was v4
>> already)? Can't we just test the bit atomically?
> 
> My understanding is that to make such operation really atomic, we will
> need to access all the other bits within the same bitfield with atomic
> bit ops, leading to a significant code churn (and possibly some overhead).
> 
> I think that using a full bool field is a better option.

I agree, it's better not to overcomplicate a fix, and we can always
return to it later.

-- 
Pavel Begunkov


