Return-Path: <bpf+bounces-55368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4D3A7C928
	for <lists+bpf@lfdr.de>; Sat,  5 Apr 2025 14:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2CFC174D93
	for <lists+bpf@lfdr.de>; Sat,  5 Apr 2025 12:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8B61E1DF7;
	Sat,  5 Apr 2025 12:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MqFnekKO"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDBA1E50E
	for <bpf@vger.kernel.org>; Sat,  5 Apr 2025 12:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743857683; cv=none; b=u4KHIJp3F8ARDlpxK2zRt7oM+87G40FGgAlgJ4qSM9KNkjdFfJ32stT5h7BeCl8lDP4e/rzYgbhDeD5n3wCp7HrpeEEKFAxmpbBrDHLcCFrXUa/Fl0sRf1YFYOZWhIOeKnsjfGOiMBqEkMumkpJ8quL9994j2+Z+Qjaqasa1KQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743857683; c=relaxed/simple;
	bh=OqPlxZ84MvDuvuYdDMJebOtv4kfa7e9q+LZcfQb1DD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TmYyW+ipONDjgXvTCR1iNhoeRMAG5xs/zKOAYv/qIcYmXO0fH/R4jRyEupkwQs9m4bF8yd5LP3XEwLxgCF8nWu1d43xNu3AAEq3TEsEBUBZ1ckuTJLvoGXdPUmrL8T61XjR6mtf1mngbyn/3KIp2apfXQWwSFc8SY8BQgO4rtZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MqFnekKO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743857680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KJSSsQi4y9qy6Jap/bBqkOsEFxIFhRATV85xzgJwngA=;
	b=MqFnekKOm32ilbyx14+18VfYjvWAuqXmUtlyiLbjfwoeeVebr5c/U0BdyylwCzoLiTiy5L
	n7DFJTf3Uu78zfPeDRFodLbYSjqICIJZf3qcJ2xmWxtCLsmNgthSQtbJ+p1OCkDz+7R772
	DvoJWImK2UR9BzA6UY4T0+bY5f74wb8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-eujP5T1gMNyVJmPqdKyERQ-1; Sat, 05 Apr 2025 08:50:04 -0400
X-MC-Unique: eujP5T1gMNyVJmPqdKyERQ-1
X-Mimecast-MFC-AGG-ID: eujP5T1gMNyVJmPqdKyERQ_1743857403
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-30bfd03cdf6so14953891fa.1
        for <bpf@vger.kernel.org>; Sat, 05 Apr 2025 05:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743857403; x=1744462203;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJSSsQi4y9qy6Jap/bBqkOsEFxIFhRATV85xzgJwngA=;
        b=wFGiaFwN2p7381/tenrOzN9ly2c9Y2MwHWBZLZ4kuM/TkrKz93LDN8oesLz62OQFlb
         7PXCKs//WnJWj0eEHS4Su3XhGDAW4ncIthbNdVj8+fah+MatIqUBiCduHkH+aogOiqqi
         qN5Y7Xoh7ZnMIK5t3NzyYfMt3Kq6AAlR7NwVbHX0LfID5eSbwSA8Lh4N00AfazwrDahS
         kOzSrKXQn4jVeh8+cps50fih+hR959uR48rvYkge64uVb+5cdigcfDhZUUVnQhS7hR/O
         86lTHqqLwV93urV80kpIgBVC9EUOOllEh2d0CWZKBkiL7nRLwOe5uKY3JTJfv9NUq9lo
         n1Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWxS4XViAqcSyjg3Wv+3aPo2UNwoVAVci3KRvHHxJwc68jacovK9j2TNvCrbDUOwrYCNVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/oOLPXnkJwkCoGRdpAy6/aG9pauLtzOwtRpZnRRVu0oMoWYc+
	zzKk8enRLErtSkqoTo75xiLRnv3xQHT/MAhZEAcc1oKHepS2iwkvxpjQ0HCoFAAKdSpMUsQdO3t
	yfc8Z5cMCjArQ6zsS2uAQUoIEjncxrB8AZz26hMKyY8nUNDEQuw==
X-Gm-Gg: ASbGnctk4mOqRT97Bu/BEWaVwK0vyEGDOOp7nyo3Ge5HY+Ig8DPu4Zgtp9DKqbju++d
	bgkDK7mLVsaIfwJkNt4wdJejQ8IjefZha+Z/cVBdrSWY3QNO0yICSjrkA1CSCDH2qpOKFsRK1fb
	gv2aZN3kFRlTRFDkni6NviS+mbv1R1ZCebQrQ3yVIQ3/wY8aW5gD7G6JParO2ayVz/6NofIrb+W
	+wpwqH7Pl/h5Z0AhtZgrc3H1eclCaVx7jJzLw6jQU3NGglLKAanuCeNc9Ax1yAgcvx/M/pgqvXP
	Ng9BsEchm5zY4Z9V81v9Py+s1+KvUIihgCn6GkF9
X-Received: by 2002:a2e:ab0c:0:b0:30d:694d:173b with SMTP id 38308e7fff4ca-30f165a2ea4mr10764481fa.33.1743857402896;
        Sat, 05 Apr 2025 05:50:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHB21V3mnevjJOBuKtDbkjuEQHYW7vTlUl/JuKqTWWRK9nD5+it91BDmAxcHGGPPFWJPz3EEg==
X-Received: by 2002:a2e:ab0c:0:b0:30d:694d:173b with SMTP id 38308e7fff4ca-30f165a2ea4mr10764381fa.33.1743857402525;
        Sat, 05 Apr 2025 05:50:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f031ce793sm8871321fa.107.2025.04.05.05.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 05:50:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D0AC618FD793; Sat, 05 Apr 2025 14:50:00 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mina Almasry
 <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>, Yunsheng
 Lin <linyunsheng@huawei.com>, Pavel Begunkov <asml.silence@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org, linux-mm@kvack.org,
 Qiuling Ren <qren@redhat.com>, Yuying Ma <yuma@redhat.com>
Subject: Re: [PATCH net-next v7 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <d7780007-6df7-45f0-9a08-2e6acf589a6f@intel.com>
References: <20250404-page-pool-track-dma-v7-0-ad34f069bc18@redhat.com>
 <20250404-page-pool-track-dma-v7-2-ad34f069bc18@redhat.com>
 <3b933890-7ff2-4aaf-aea5-06e5889ca087@intel.com>
 <d7780007-6df7-45f0-9a08-2e6acf589a6f@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Sat, 05 Apr 2025 14:50:00 +0200
Message-ID: <87jz7yhix3.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> Date: Fri, 4 Apr 2025 17:55:43 +0200
>
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> Date: Fri, 04 Apr 2025 12:18:36 +0200
>>=20
>>> When enabling DMA mapping in page_pool, pages are kept DMA mapped until
>>> they are released from the pool, to avoid the overhead of re-mapping the
>>> pages every time they are used. This causes resource leaks and/or
>>> crashes when there are pages still outstanding while the device is torn
>>> down, because page_pool will attempt an unmap through a non-existent DMA
>>> device on the subsequent page return.
>>=20
>> [...]
>>=20
>>> -#define PP_MAGIC_MASK ~0x3UL
>>> +#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>>>=20=20
>>>  /**
>>>   * struct page_pool_params - page pool parameters
>>> @@ -173,10 +212,10 @@ struct page_pool {
>>>  	int cpuid;
>>>  	u32 pages_state_hold_cnt;
>>>=20=20
>>> -	bool has_init_callback:1;	/* slow::init_callback is set */
>>> +	bool dma_sync;			/* Perform DMA sync for device */
>>=20
>> Yunsheng said this change to a full bool is redundant in the v6 thread
>> =C2=AF\_(=E3=83=84)_/=C2=AF

AFAIU, the comment was that the second READ_ONCE() when reading the
field was redundant, because of the rcu_read_lock(). Which may be the
case, but I think keeping it makes the intent of the code clearer. And
in any case, it has nothing to do with changing the type of the field...

-Toke


