Return-Path: <bpf+bounces-54197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D13A6547B
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 15:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D7687A41F3
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 14:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA9F24889B;
	Mon, 17 Mar 2025 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6VW8HI4"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DD8245016
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223327; cv=none; b=i40dj/FqwW1k/zMukfl8XHuccqafhDWRkQrLorUBJsY2+dYkxGwDbTZqH93ZQutPRC6fatxF+FeMxBZCKj0qx3xRG/sQicvetQuQnBkoOQQfxOdyUHwUjdbEPUZOlNIC8Iz98OieqyaqxJ6+7Kjxpf/bFV9ewzyCRbNIZz6TOpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223327; c=relaxed/simple;
	bh=xNnWO/K1u8WG4XUZJxS4WUVdfdhF3mjZ+5wwJk9E/4M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qUEc+14Kv9LARl/ybPn+gu0exOu/7bHPGSABL4IDUuVVenc1e6/AwDJyatyERDSXUoR3beTmXl0qZrk4vvefeGUpaTPIPWIKMc5kVYhRaV9A09Dx5+7rhqN1yhkjcJsJFiS/UFowgObY2/bDCu0Lyg/eU4OoAedxIYimyvInmD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M6VW8HI4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742223325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xNnWO/K1u8WG4XUZJxS4WUVdfdhF3mjZ+5wwJk9E/4M=;
	b=M6VW8HI4VWEWTe/ynqN6bORakSLTwXTWIa7ZpOIF4q+WJtyNBmyIofLhGhwqSEJkDxBwj9
	Dz5BNlIUyT01shAFRD54DkqrXP1+9+BxvNbg5aswVKdjQgBukobmBQqYXZ9Ejeh5mK6huR
	rCByUPmFovAvKn0nDnf5IpCW0LtT9Hs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-mcNqMBAGPUCytxR3i1X0mQ-1; Mon, 17 Mar 2025 10:55:23 -0400
X-MC-Unique: mcNqMBAGPUCytxR3i1X0mQ-1
X-Mimecast-MFC-AGG-ID: mcNqMBAGPUCytxR3i1X0mQ_1742223322
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-54991f28058so1729514e87.3
        for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 07:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742223322; x=1742828122;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNnWO/K1u8WG4XUZJxS4WUVdfdhF3mjZ+5wwJk9E/4M=;
        b=EEsMZQ2kC82nWydrfzZYTZMs3wB/ApkqRMW/w5UDCCSOIzHT4eBwBs63JM5WqW6dJC
         DduPXfgp40/RaRK+zdK1o5SppzBQQ7F5uU8YEm4Wgues2fjoiAhazB5IS8/hk4T0W8Qb
         vwwQ9ZvLI4AGN7oAZ9rH8XWqAeQXuj1A878Kqi01/yjJJBM394Gnip3kmufa3XPPFoPh
         0XmyAsR9rSHtVBhD7ujDct4A9iu89gwFmMbW+fPW9QxOdbqRFfD1JUsPA27WwEHgGiEf
         9gj/fYcjaDzX1Y1iTHdnrn6pXPwlHHkHojCSGv3AyxbxpjzNA/YudAnZ9i6ppyeGm3qB
         Kv9w==
X-Forwarded-Encrypted: i=1; AJvYcCXUFvY3NImh3ynAYohVOZVFbTy+lePeDXGK6LzxDPQtw5kaR+5SRgn2SW0IJu/EDIjYCNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxizqL2Ufd41XOrKi1HEEcBkIVX8XjpEa4HYRq81s8Z+eIvd1g+
	zINg75TI7BdsJ+/1L+n5L/KFn91bYgv8IZkiWMMObtTn66HuFwlDmel9G4RHw6jR4jVdRi93i3R
	754zqX4YkNictXzFLV7HAajd4/eANNTz7wf4tz2w1FHMKswp5Yg==
X-Gm-Gg: ASbGnctY9ywDZEmlrKOKdQymgSMlcp/GGJDGW7Drr36Yr9wz4PzMFouOH1ztKE5RpGL
	dMa8+6a5eu9rUPGGu8M1KEHAhk5tSPyHhBDpYHu9WuKRO73vJBPwFOPQaOUOeFAX7nKe/mZPT7R
	T2AEvZ8DITO0vd+NBbomu10MmMkNxFag8D5qz8yz+AWtJtPN3mQr92HBIAzSgiBehUqccgP9lDp
	hnv4BAfARDEPXoiMwB7bNvjXo8S4c04vygchUBvlRxPhZhXtd2kPUjp63euDG10aApLCYPIplJO
	QPnL0P4sDxcY
X-Received: by 2002:a05:6512:2256:b0:545:2eca:863 with SMTP id 2adb3069b0e04-54a03cf6675mr26268e87.42.1742223322300;
        Mon, 17 Mar 2025 07:55:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkU4EGv0nYoD/ziKJsZtzUZRRSbpyRPe5/A4qyQD074afFL4/ETFCYpbFS8GyZgIxIK6weCA==
X-Received: by 2002:a05:6512:2256:b0:545:2eca:863 with SMTP id 2adb3069b0e04-54a03cf6675mr26237e87.42.1742223321810;
        Mon, 17 Mar 2025 07:55:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7a86c1sm1374403e87.21.2025.03.17.07.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 07:55:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B523218FAEC4; Mon, 17 Mar 2025 15:55:18 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yunsheng Lin <yunshenglin0825@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Mina Almasry <almasrymina@google.com>,
 Yonglong Liu <liuyonglong@huawei.com>, Yunsheng Lin
 <linyunsheng@huawei.com>, Pavel Begunkov <asml.silence@gmail.com>, Matthew
 Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH net-next 2/3] page_pool: Turn dma_sync and dma_sync_cpu
 fields into a bitmap
In-Reply-To: <b0636b00-e721-4f21-b1c5-74391a36a3be@gmail.com>
References: <20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com>
 <20250314-page-pool-track-dma-v1-2-c212e57a74c2@redhat.com>
 <b0636b00-e721-4f21-b1c5-74391a36a3be@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 17 Mar 2025 15:55:18 +0100
Message-ID: <87msdjhfl5.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yunsheng Lin <yunshenglin0825@gmail.com> writes:

> On 3/14/2025 6:10 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Change the single-bit booleans for dma_sync into an unsigned long with
>> BIT() definitions so that a subsequent patch can write them both with a
>> singe WRITE_ONCE() on teardown. Also move the check for the sync_cpu
>> side into __page_pool_dma_sync_for_cpu() so it can be disabled for
>> non-netmem providers as well.
>
> I guess this patch is for the preparation of disabling the
> page_pool_dma_sync_for_cpu() related API on teardown?
>
> It seems unnecessary that page_pool_dma_sync_for_cpu() related API need
> to be disabled on teardown as page_pool_dma_sync_for_cpu() has the same
> calling assumption as the alloc API, which is not supposed to be called
> by the drivers when page_pool_destroy() is called.

Sure, we could keep it to the dma_sync_for_dev() direction only, but
making both directions use the same variable to store the state, and
just resetting it at once, seemed simpler and more consistent.

-Toke


