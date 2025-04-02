Return-Path: <bpf+bounces-55161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 437E9A790C0
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 16:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763CB167C68
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 14:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB9A23AE84;
	Wed,  2 Apr 2025 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TKQtfFEh"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5EA23875A
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743603049; cv=none; b=fFzbJ82m8QV6RKkmnBZXJ69q/nOUzsIf/7sN0KgR+kq4nyDu5FhAqlGgOST5OMoFQ7ebre45eY2DJmmd2XtUeaeL55lqzvmIkSUt6ApOs1GqSJFrF6CV2YOB52SbaoYxyIr4lcXhlh4DBftliQPwp5o/2VXv1L7pqTp9KIa9A78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743603049; c=relaxed/simple;
	bh=4sVBulip3fTqdwge65Je6X4en2Uqs3ted+bv/OrEtiY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Oo6KnoroHst9tZw6kKVNGIROtA9+68DY9s1oa5/6PQH9Bct3Sl36mR7Q0cwqi84lX0ALflVkYU4HUg9k408sH1t6qk5CuJqb1l5vDi1D894mcvYpZ6MLLuQ396apQ0xHGr+ETNKkinE0TiPurCSguk+d7CKD/SF02SRjU4grrr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TKQtfFEh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743603046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MbKTHiaLmAweSAwT0igRmFjsf2YylXp8ikC2EQZZfqY=;
	b=TKQtfFEheo/nPKjj7a8uPAgHf6JRkbtoyzaaSwr6M6AE716pLNQMrNtZ59D2ywWK4Iyyh+
	pLC5S5Quo/R2OgPbZnJhzJDFhdlyAYxldiwLaBN2ul+Ra7lBcAGOG1Ee1+Xoxo0sy7V2dI
	8tFUzValUd5Wr7gHWAzZ652czSx1wRk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-4owQku-zPEO1DVavEMPK8w-1; Wed, 02 Apr 2025 10:10:43 -0400
X-MC-Unique: 4owQku-zPEO1DVavEMPK8w-1
X-Mimecast-MFC-AGG-ID: 4owQku-zPEO1DVavEMPK8w_1743603042
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5499c383444so3787108e87.2
        for <bpf@vger.kernel.org>; Wed, 02 Apr 2025 07:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743603041; x=1744207841;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MbKTHiaLmAweSAwT0igRmFjsf2YylXp8ikC2EQZZfqY=;
        b=ORNb/UCWqhoCw3pBtYZgkDismNi0K9PXOILunDi9GZ71DjDtqJlNMXUi6Br/5qXfXW
         RpVwdQPz73l9y6HWGDAK6r2s+xSNstDvND0UAfthYCt08m7uEouRF8CoQHOW2xlRdeOV
         9UVOITwLvVEsqzbBQdUHRmARiNFqaKkN0K7rmI39fnvv6uTNwwu5H6JcR5zmT+tDz35R
         nDl5fzGophj25rH0zERXLBeR+0/P8/9STXrOVAjDVRomxwzFPjf9mVEy+8yWCJnSguyG
         YQKQq0Jqt5uAAuMiIVeb+8+UEflhsyp18Bg/6rKwoBWYmUr1U13998OWFrBKkrqGVrhY
         Atyg==
X-Forwarded-Encrypted: i=1; AJvYcCWxkY+puewCphXsLKGhwA3NL1WB1iQujd6pF6CRKaB3EjPkQFK7hi0AznA9SrFvrugdz3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YydKbWAuI8Z/LX96m0BGSN25/6PS7rmthUGB6KmOj8IavcJEUry
	Px0uiISjkAtO6pjmCDe/MMji6RDPATJdNtQ221BPWnU+CC1O+MA0tzf36ZYHGca+QIAfpuawpy3
	ZnZ2M3QsVWKbA8w6cXn2yQIV5JgwJq+weHPfrTWVl8sMW48TNzg==
X-Gm-Gg: ASbGncvyicQZpROH4PocI9hpsQ8hgKeS2Yjw7kOcNh4sfUjtoAFsZ19hSQ1UulEyV0m
	Bm7/xDhk2W10gtmQ4WJzBzO2PSEnDqjP51XN5Uz52plbgq/83Drs/GP6EH8JPtzTqrHDNBjxwRq
	F+iTVHauazGkHgdFnG656FH1M0odpsjVXlNvAG4e/7WlPzOs1nyl87qMIka2jd1RXa/dYbfIT/j
	ixnKzdXi5B3MCw52TmrDikHt0gyKMlqoVnxbEDw3P39yZYbRMoA/GrIMTv3fvO7ZsspXy5GPQQc
	MBFCikApWKQu
X-Received: by 2002:a05:6512:1386:b0:545:8a1:5379 with SMTP id 2adb3069b0e04-54b111242bbmr5823782e87.43.1743603041552;
        Wed, 02 Apr 2025 07:10:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMxC2U1r1cpFgYr/EJLzybppo1QongF+LooghSXPmyLtE3Ffn5xOTN3LHvx9mbOxE4Ua83cw==
X-Received: by 2002:a05:6512:1386:b0:545:8a1:5379 with SMTP id 2adb3069b0e04-54b111242bbmr5823766e87.43.1743603041173;
        Wed, 02 Apr 2025 07:10:41 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b0e703fa4sm1433452e87.169.2025.04.02.07.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 07:10:40 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8BCB118FD3EA; Wed, 02 Apr 2025 16:10:39 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Mina Almasry <almasrymina@google.com>,
 Yonglong Liu <liuyonglong@huawei.com>, Yunsheng Lin
 <linyunsheng@huawei.com>, Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>, Yuying Ma
 <yuma@redhat.com>
Subject: Re: [PATCH net-next v6 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
In-Reply-To: <2c5821c8-0ba5-42a3-bcdd-330d8ef736d0@gmail.com>
References: <20250401-page-pool-track-dma-v6-0-8b83474870d4@redhat.com>
 <20250401-page-pool-track-dma-v6-2-8b83474870d4@redhat.com>
 <3e0eb1fa-b501-4573-be9f-3d8e52593f75@gmail.com> <87jz82n7j3.fsf@toke.dk>
 <2c5821c8-0ba5-42a3-bcdd-330d8ef736d0@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 02 Apr 2025 16:10:39 +0200
Message-ID: <87ecyamz6o.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pavel Begunkov <asml.silence@gmail.com> writes:

>>>> +	if (err) {
>>>> +		WARN_ONCE(1, "couldn't track DMA mapping, please report to netdev@");
>>>
>>> That can happen with enough memory pressure, I don't think
>>> it should be a warning. Maybe some pr_info?
>> 
>> So my reasoning here was that this code is only called in the alloc
>> path, so if we're under memory pressure, the page allocation itself
>> should fail before the xarray alloc does. And if it doesn't (i.e., if
>> the use of xarray itself causes allocation failures), we really want to
>> know about it so we can change things. Hence the loud warning.
>
> There is a gap between allocations, one doesn't guarantee
> another. I'd say the mental test here is whether we can reasonably
> cause it from user space (including by abusive users), because crash
> on warning setups exist, and it'll let you know about itself too
> loudly, when it could've been tolerated just fine. Not going to
> insist though.

Right, I do see what you mean - it's not guaranteed to be coupled.
However, my feeling is nonetheless that it's better for this to be loud
to weed out any new issues that may arise from this, so I'm inclined to
keep it as-is.

-Toke


