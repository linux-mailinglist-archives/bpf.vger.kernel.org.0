Return-Path: <bpf+bounces-54747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8DEA71665
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 13:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ABBF7A517E
	for <lists+bpf@lfdr.de>; Wed, 26 Mar 2025 12:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A9B1E51FB;
	Wed, 26 Mar 2025 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyPvISRM"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F641E1DE9
	for <bpf@vger.kernel.org>; Wed, 26 Mar 2025 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991645; cv=none; b=WiqCMw+YVsDxIOW1/WVWgiK6Trubn0srlhGEHCDzmbxg4AxBJpIomLSi2HhZhoy+adEvGxs/7RfIzflod9vxJstFNuMA81HMj67+M+wO+dwsJ6Lm7tNckF8o+ujMEkk46Yb8RdyWjXarkwgEEeWaRG20eWSu1FwQ2S58lnnH0Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991645; c=relaxed/simple;
	bh=fDGZt+SqyiAW6zCfVM1bGeXtRYL5+861efZwXKZVyjc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uzwR6y74FNxoDMzgANTTDE/84IuSAhnqfujAfzPSSCdoffTRyyk+YahF2jjL5RGB+b4ftFgee+kLfJAFFIBpkFLgl98E0g9aZZRZ2AidSiwwgxuFwzyq8Q4cmgnh5c2hxAkhskh0LOrvshl/QSm+/I5DSzVcBBlNSkUATbIOmMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OyPvISRM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742991642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fDGZt+SqyiAW6zCfVM1bGeXtRYL5+861efZwXKZVyjc=;
	b=OyPvISRM1O7N2DrDBtYUfU1M3lZNR79xAUvEcl/4733LtWFE/ooQGt5l4ftsYYRePmAYMq
	TXXTdW1DPVcyxBrHAVyjeDWm/X0dhN87OAKwCZwUMUMq8ppFK5AAz4HCQKILxJOSy1uJVx
	h0U29bxapI/uWE9vnWYLkDonSHulV5c=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-V8vwwQofM6qeH9Ifk_e6xQ-1; Wed, 26 Mar 2025 08:20:40 -0400
X-MC-Unique: V8vwwQofM6qeH9Ifk_e6xQ-1
X-Mimecast-MFC-AGG-ID: V8vwwQofM6qeH9Ifk_e6xQ_1742991639
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac37ed2b99fso603657266b.3
        for <bpf@vger.kernel.org>; Wed, 26 Mar 2025 05:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742991639; x=1743596439;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDGZt+SqyiAW6zCfVM1bGeXtRYL5+861efZwXKZVyjc=;
        b=fuVCFAMBncYEppuvINP+T74K9Jxk6DapJbZ/vMpH6lGyZTkpMdrTJ5w8lirTU3x1iM
         y4NIrjlwLOdH3mWprQ6kV1LIo73BcaQusfSRKyNbJ/qjwAVYer7ltw8siWDX+S5lU52W
         dTJpBowohYcNJ+9naPKtF+E7U1ZOIDsD+Dx5p5ri2aBKIYJzWd5R3YCBmJq1AL1wlyNj
         s4cOmPw9ELkQOYnYzhKyRehOeBc+3JaS/1NHjgKdB+tvC9KoOfIj8hkAvtJT+1av3vgC
         ncJbIdLT1GJR9UkSFxFtQ6nAdo3VYAIGDwtMcoZ6qQAoQCWZxSXNipGvemQVqnfS8H5i
         v8qg==
X-Forwarded-Encrypted: i=1; AJvYcCUA8blhn8R4z6aeFarGorDCf1M413SUGxKcmzizGe533+aWcXyW8bRT9RHOUXzMsOtECww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6zGPAdhGyqjyDLQIyADwKiVIgiYCNdDGzfQE37aVJUEeV1/k6
	4sVnfjJUsWxuHd8S0hNiTjtyqwS9r8t6n8HDY01+ce/Yn234NO3nfX2Bf/qUVcunRg517LekxPU
	0YYQH45EvLGRkNN85qceGwQlvb8cXjuAf65/8jx3KZQr/8hD8gw==
X-Gm-Gg: ASbGncth2ozqkVm6lPjJ/rAREf2Sl93MfuH2S3aYV43iUq798XV5d7kgupTQbm5Rh7a
	qqH0Vu4vqUEFp5gP5yMZ2+Xc7Pvkv5SMPJFo53DTTsLRgKfnAFrzaPziBtVYb64C6DQ0tFITjBe
	IiE6KcKJlYX7/GtTOI0gLYlGY7m/KG35XwapCTK0EZjISsbJvoUSTlGjrjFqf/dT1FD7otTgfNb
	vC8BUEgHmNkM9vnDBxHt9E+QWflMaKnVmwPnEoQcr/dTT3M0MLVwVTvIfHFWpnd9wF8dKgq6W/1
	0U6GisSARLVK/XisTNn4yu4xsvdKS+xuuuzZND/s
X-Received: by 2002:a17:906:c105:b0:ac1:fab4:a83 with SMTP id a640c23a62f3a-ac3f22aec3fmr1934592666b.25.1742991639139;
        Wed, 26 Mar 2025 05:20:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXpD8SKp1cf90maKHi6um2LlX8ejsXAgc5A98IWT9wYQriYmqy8j/0VlxO8lFqKGic1FYQjQ==
X-Received: by 2002:a17:906:c105:b0:ac1:fab4:a83 with SMTP id a640c23a62f3a-ac3f22aec3fmr1934588766b.25.1742991638698;
        Wed, 26 Mar 2025 05:20:38 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efb65701sm1003437266b.122.2025.03.26.05.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 05:20:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4474318FCA84; Wed, 26 Mar 2025 13:20:37 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mina
 Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>
Subject: Re: [PATCH net-next v3 0/3] Fix late DMA unmap crash for page pool
In-Reply-To: <20250326044855.433a0ed1@kernel.org>
References: <20250326-page-pool-track-dma-v3-0-8e464016e0ac@redhat.com>
 <20250326044855.433a0ed1@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 26 Mar 2025 13:20:37 +0100
Message-ID: <874izgq8yy.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 26 Mar 2025 09:18:37 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> This series fixes the late dma_unmap crash for page pool first reported
>> by Yonglong Liu in [0]. It is an alternative approach to the one
>> submitted by Yunsheng Lin, most recently in [1]. The first two commits
>> are small refactors of the page pool code, in preparation of the main
>> change in patch 3. See the commit message of patch 3 for the details.
>
> Doesn't apply, FWIW,

Ugh, sorry about that; rebased yesterday before reposting, but forgot to
do so this morning :/

> maybe rebase/repost after Linus pull net-next, in case something
> conflicts on the MM side

As in, you want to wait until after the merge window? Sure, can do.

-Toke


