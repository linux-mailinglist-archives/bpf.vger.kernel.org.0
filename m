Return-Path: <bpf+bounces-55647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42286A8409C
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 12:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89FEE3AB55C
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 10:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9483B280CEF;
	Thu, 10 Apr 2025 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXwPH7OW"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8D0280CD9
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744280470; cv=none; b=IWkQr4B/9rp0gul+o+BLsfc5Y4gT0GDLdSgbOy5h+LN2ljy79azeuGKXwwHOyC/cY18AapWFtNCrAsgdwYYy3RAoC85+RtkkCJ7Ce3dD24krDlo2KEq5fIC6bh0Q/Hp2waOJoeiJkOARkqEfIiWiuX2Hw1dI0CBqKQQIdpR/K74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744280470; c=relaxed/simple;
	bh=92JUKxqvz4DOLXtgZ9JCA4V7OtLOo0pA+kZxODRygU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S9sivUerDzPA8ksVu0zXinwMnrD1IRpuD7mz4Ta5ZUmtn3Hwy8bxC0PcMCOgGtIOwV1ooHfuy0B2OMZ2nahJtR51monpTUOW3rVaZVXbINlJdFZDdoSNsN0zbnIpG6CuroRmgI2T6P4Hlasor9Hcpc1alunZfogQQtHoWDqvWo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OXwPH7OW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744280467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gj0ddO5JcHA3x6pElFgDxfTHr6tMQmqLYvn6SHOTRag=;
	b=OXwPH7OWqdliMl6itrof34dbBdzD5kfoqfFXCZFKQOG+F0RSRUYLFhGWkeRWrxq0K2pKKe
	s+5XFRrnBcJrWS2UGAjkhgnN9omYj3Y9cKqGD/g1jwVc0Fa/y98BZLu9dH+OFcyfwwlyKd
	/6JfpRYDUGbvZpzSwrJV8miiBBbeWXE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-O8FoUT9LP5CNzGyF6-hk9Q-1; Thu, 10 Apr 2025 06:21:04 -0400
X-MC-Unique: O8FoUT9LP5CNzGyF6-hk9Q-1
X-Mimecast-MFC-AGG-ID: O8FoUT9LP5CNzGyF6-hk9Q_1744280463
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-30bf4297559so5242981fa.2
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 03:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744280463; x=1744885263;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gj0ddO5JcHA3x6pElFgDxfTHr6tMQmqLYvn6SHOTRag=;
        b=HSvRXN/pGpkQtTDSrX8nPq57koS50JeiqnPzx959Q6AoEdjxYgBOAxNmAbDeTh3ZxR
         2St8AkYWzb0u3JCmV7+BZkbsPPYrklJr9cW4JKEAo3MCCBh3Jtfm3V3I5sS8J+f04pQH
         NQafgSDl4oH0nUCLAAEOquPftGBXv+F2eY7VxwEMrSn4X5oRShsG1V+C+2Ea4PNX1HKI
         c9akuC5UmtgH2xSHIXFesiheyEb9lV7mBLCIwb6Z5/SUMRtGz+tMk+xzfN0ujfqa/1TB
         mgs0nIBlI0Bo2oGSgoenvPtUjnEZuvGKYf2SVnYR0viMQu0LnityLRsFG4t2MpZXM5WX
         7QzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUreRIfykgIYes/QwVGIAevdiTh9Ra0qwIQaiUyTBj3UBEV108rL6tiwV+WHFxbUVSX+Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkrd8NI7OE2hgOXYUtFsVw10miqQuy+JiQngR5YvRFEL2uYzrp
	oWtbWBlMesQxKVcADsnJcVUrcn+xwgHacK2jHAW/V4lsxfZCQ3Kaz7uaw/Cqh7xwfSPo9/QIAQN
	xnzmZDQzvCm58ER5ZFY2VA6fseO6c0TSs1q/aaRnB3HjR2lW+rg==
X-Gm-Gg: ASbGnctAi45AyTLFpWg8CNo7KRIPAh1FdS6rcltwU9jtQ3nvCi5/jEOmtv2pUKEhaXH
	xm7vXu+9FfyP0G9c4OjzU6JigKJhkRD24OAzocuFg+gv55ne1IXkjwsEtnA29Yps7eey3H6VcwA
	B7YKsJfxNc6OMuY8bPyL73AOfPKREZJObJZR77A/X0jdiHPBdzxVAzFt+vKa99K8zF2QByLnIe5
	maDasvof1ALj5ZKJg794FoNwFDjhCP4euEfEU6gvFYIxHsL0Il8dnCGCoYy6/tAi/dDQ1b7KWH+
	xXp72J/WsLFuV0mZoqmv96f6AeoVAPpcv6B9
X-Received: by 2002:a05:651c:1515:b0:30b:9813:b004 with SMTP id 38308e7fff4ca-3103ed4f35dmr5955721fa.34.1744280462775;
        Thu, 10 Apr 2025 03:21:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE17WxZoyH3rbLK0N6NfIbsSGtSK/hr9dYY0iDg1GJ6hNCoga/XB9dPSda2f4ZShTnw6cWIwg==
X-Received: by 2002:a05:651c:1515:b0:30b:9813:b004 with SMTP id 38308e7fff4ca-3103ed4f35dmr5955491fa.34.1744280462404;
        Thu, 10 Apr 2025 03:21:02 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f46623c2bsm4318581fa.111.2025.04.10.03.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 03:21:01 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 7F5E21992272; Thu, 10 Apr 2025 12:21:00 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Zi Yan <ziy@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mina Almasry
 <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>, Yunsheng
 Lin <linyunsheng@huawei.com>, Pavel Begunkov <asml.silence@gmail.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH net-next v9 1/2] page_pool: Move pp_magic check into
 helper functions
In-Reply-To: <D92K7SAU1A06.1APBVXB2AK2HW@nvidia.com>
References: <20250409-page-pool-track-dma-v9-0-6a9ef2e0cba8@redhat.com>
 <20250409-page-pool-track-dma-v9-1-6a9ef2e0cba8@redhat.com>
 <D92K7SAU1A06.1APBVXB2AK2HW@nvidia.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 10 Apr 2025 12:21:00 +0200
Message-ID: <877c3suxkj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Zi Yan" <ziy@nvidia.com> writes:

> On Wed Apr 9, 2025 at 6:41 AM EDT, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Since we are about to stash some more information into the pp_magic
>> field, let's move the magic signature checks into a pair of helper
>> functions so it can be changed in one place.
>>
>> Reviewed-by: Mina Almasry <almasrymina@google.com>
>> Tested-by: Yonglong Liu <liuyonglong@huawei.com>
>> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 ++--
>>  include/linux/mm.h                               | 20 +++++++++++++++++=
+++
>>  mm/page_alloc.c                                  |  8 ++------
>>  net/core/netmem_priv.h                           |  5 +++++
>>  net/core/skbuff.c                                | 16 ++--------------
>>  net/core/xdp.c                                   |  4 ++--
>>  6 files changed, 33 insertions(+), 24 deletions(-)
>>
>
> LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Great, thanks!

-Toke


