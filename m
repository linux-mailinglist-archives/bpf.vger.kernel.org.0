Return-Path: <bpf+bounces-55395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49A7A7DCD8
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 13:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5235167AFC
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 11:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D73253B4E;
	Mon,  7 Apr 2025 11:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IP/PNmva"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF9324501D
	for <bpf@vger.kernel.org>; Mon,  7 Apr 2025 11:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744026547; cv=none; b=O0Q2U/tBJWDBAhNvaf508c+fZCg5pHIMaYC+wpTQdxaMC/weEQqrg7JOlPZaTzNvZ1S51bu/MujHpv0ZzJd0wfGHpu/DNJY6Z4ISF7xqL3sX4n52YDIwfPgxSC9zVHg9DcirqVUZLIJ9YfHGHHEwGovhGVc6NHqmK9khDofmP00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744026547; c=relaxed/simple;
	bh=wgVJYy1rEwB53P9pbmWyY7fpKJ+zxw00/Y9QE8ZKGd8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FSV8B7Y/xkc58IuvuzHFKWncPKziNX/LCROfh7mCvfOJxDPxzfyVHIOmi3LOVKqJ8dgG7U6ROtcIsDHLLC0PEhpoZCD45732AUl1LXYxtbjEGmRs2/rQmC5bAlrKplUNWMBoshD3yT1RtPGnVcFwEtw+/DuVYw4Q5aPKnrDt3+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IP/PNmva; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744026544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLDIfHFc0cnuUtNn3wFV1KRo7sfcAABFYKPb/EFAlBY=;
	b=IP/PNmvaqx/mw6kEleDTTBNxh16C8fMpVDEUVst1v7yQi+R+uAEmimmCG3KwkVwKGEJqo/
	crCiXboenx3Rk+eiuYv8rtTg8p3n2jORUp0OuC+MnhlEOuFm0SioNbU6KdgfN5CqXKlS+/
	L7nq6kd+wl8pHSE2DRnaDN6luGgpU3M=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-4-bcptNDNpa1Al3mTXeEoQ-1; Mon, 07 Apr 2025 07:49:03 -0400
X-MC-Unique: 4-bcptNDNpa1Al3mTXeEoQ-1
X-Mimecast-MFC-AGG-ID: 4-bcptNDNpa1Al3mTXeEoQ_1744026542
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-30be985454aso20640151fa.2
        for <bpf@vger.kernel.org>; Mon, 07 Apr 2025 04:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744026542; x=1744631342;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLDIfHFc0cnuUtNn3wFV1KRo7sfcAABFYKPb/EFAlBY=;
        b=DBcSBHDGhH2MxqVR3n69/SGOXxhce6R3v9LTjqsl9ulhr6PqX3HNdALHR2JvPSkaxa
         a9/Jbg0ubH6LAKOkSg/7obHLYbldxEBl5oDIDdDfwxgM6eZOgKdVAXW0XkfSs1U3JVkG
         mR0R7kv6ivhNUV85KsiKtnB6tJXi3Ynbc0Hli87MJl3G004ONhPy2w1crW5c3UTcDIc6
         sU38xjhJqs5XlRr0YBswPOsDR1tmCV1DdL2eaemoqbd/dTrwM9sG4RJXX/xJCXGVaryZ
         +y6MfNx7hUIe9Qaw2xFDgUyJNfT8Ed1znEB1DYG7226P8kdClgfxJEtregiCAuc1VuGf
         maPg==
X-Forwarded-Encrypted: i=1; AJvYcCXLCEqxy9LXGFgS5IYVGEO9CVOpbMTijXYREG1z41KRZp5jcHWqXlVmZPbgqctkgJrv/qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSC5MU5e1zTcWm+feybU3Uk9c0MLzUS9cUBwCJ+kUPyskpvNiV
	jHIFWpg2oeY+GzUgf3Tru0wFG0VXGFzH/tx9huOFPIOUqgarrfi1fl3E6TiXnPJV3k1KqV7dn2t
	3ZgrllG/3+/5P/yZ0jAvSXVwXnH5C5+N2Xl7638+NT6M80va+NQ==
X-Gm-Gg: ASbGnctOPCj12TriRMnY80kRWlDnMQiQMSds6RaEhorPkNzBp6+Z9kkKgGD9ZfjEuYE
	s4Y2o1dsM8e1eCz6sTwtkmlJ66nQ21yZ+PoUnO6fhX8w701WhZtrXxP1w34Qx2JmPPlgzvDc+7K
	8Lre1Lj2Xn9bNqt9nT4K1pwNhZvRSGk1RTP/8lLWVLfGN3tznAUiKCiv4PcgPnFaN5ekO8/03oj
	/nufDpc6GkwitfjL4q2Cc1VmT9VFCdcSp+OTfog+HUo9oFhOExyFge5m5K2n9182wLPhnf2J6H8
	RTm3Kujpp7Gm
X-Received: by 2002:a05:6512:230c:b0:549:38d2:f630 with SMTP id 2adb3069b0e04-54c232e27abmr3822836e87.24.1744026542004;
        Mon, 07 Apr 2025 04:49:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJhH9DwjR+yY0lREbz+MbPKUBDZMsEOgHBc/onNClHx1Rv9EuZnA4xWzVH0KsBqxu+8cjt9A==
X-Received: by 2002:a05:6512:230c:b0:549:38d2:f630 with SMTP id 2adb3069b0e04-54c232e27abmr3822825e87.24.1744026541557;
        Mon, 07 Apr 2025 04:49:01 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e672c38sm1216538e87.254.2025.04.07.04.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 04:49:00 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0B7A4199188E; Mon, 07 Apr 2025 13:49:00 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mina Almasry
 <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>, Pavel
 Begunkov <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>
Subject: Re: [PATCH net-next v7 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <f8bbfe7e-9935-4f4d-a9e8-b3547ed58112@huawei.com>
References: <20250404-page-pool-track-dma-v7-0-ad34f069bc18@redhat.com>
 <20250404-page-pool-track-dma-v7-2-ad34f069bc18@redhat.com>
 <3b933890-7ff2-4aaf-aea5-06e5889ca087@intel.com>
 <d7780007-6df7-45f0-9a08-2e6acf589a6f@intel.com> <87jz7yhix3.fsf@toke.dk>
 <f8bbfe7e-9935-4f4d-a9e8-b3547ed58112@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 07 Apr 2025 13:49:00 +0200
Message-ID: <871pu4xkcz.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yunsheng Lin <linyunsheng@huawei.com> writes:

> On 2025/4/5 20:50, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
>>=20
>>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>>> Date: Fri, 4 Apr 2025 17:55:43 +0200
>>>
>>>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>>> Date: Fri, 04 Apr 2025 12:18:36 +0200
>>>>
>>>>> When enabling DMA mapping in page_pool, pages are kept DMA mapped unt=
il
>>>>> they are released from the pool, to avoid the overhead of re-mapping =
the
>>>>> pages every time they are used. This causes resource leaks and/or
>>>>> crashes when there are pages still outstanding while the device is to=
rn
>>>>> down, because page_pool will attempt an unmap through a non-existent =
DMA
>>>>> device on the subsequent page return.
>>>>
>>>> [...]
>>>>
>>>>> -#define PP_MAGIC_MASK ~0x3UL
>>>>> +#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>>>>>=20=20
>>>>>  /**
>>>>>   * struct page_pool_params - page pool parameters
>>>>> @@ -173,10 +212,10 @@ struct page_pool {
>>>>>  	int cpuid;
>>>>>  	u32 pages_state_hold_cnt;
>>>>>=20=20
>>>>> -	bool has_init_callback:1;	/* slow::init_callback is set */
>>>>> +	bool dma_sync;			/* Perform DMA sync for device */
>>>>
>>>> Yunsheng said this change to a full bool is redundant in the v6 thread
>>>> =C2=AF\_(=E3=83=84)_/=C2=AF
>>=20
>> AFAIU, the comment was that the second READ_ONCE() when reading the
>> field was redundant, because of the rcu_read_lock(). Which may be the
>> case, but I think keeping it makes the intent of the code clearer. And
>> in any case, it has nothing to do with changing the type of the field...
>
> For changing the type of the field part, there are only two outcomes here
> when using bit field here:
> 1. The reading returns a correct value.
> 2. The reading returns a incorrect value.
>
> So the question seems to be what would possibly go wrong when the reading
> return an incorrect value when there is an additional reading under the r=
cu
> read lock and there is a rcu sync after clearing pool->dma_sync? Consider=
ing
> we only need to ensure there is no dma sync API called after rcu sync.

Okay, so your argument is basically that the barrier in rcu_read_lock()
should prevent the compiler from coalescing the two reads of the
pp->dma_sync field in page_pool_dma_sync_for_device()? And that
READ/WRITE_ONCE() are not needed for the same reason?

> And it seems data_race() can be used to mark the above reading so that KC=
SAN
> will not complain.

Where would you suggest to add those? Not sure such annotations would
improve readability relative to the current use of READ/WRITE_ONCE()?
The latter is more clear in communicating intent, I would say...

> IOW, changing the type of the field part isn't that necessary as my
> understanding.

Since changing the field doesn't change the size of the structure, I
would be inclined to keep the change for readability reasons, cf the
above.

-Toke


