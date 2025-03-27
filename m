Return-Path: <bpf+bounces-54803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A97A72E01
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 11:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F02231785F8
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 10:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ED320FA94;
	Thu, 27 Mar 2025 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CSMGnTZ9"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6972B1A5B96
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743072278; cv=none; b=kYyH9ZqjgQV9UVkWikYVQB1RNEirAC833VxXoTh1+nLVW3gEiIBL7FdrKop8cGnHZnMzqQWHF5Sqr2sua9DlttT2esxcGvEFiqp4mpsScvaTYdlwOxE5r+1e4gRYfYhLATdhzciriwZK+E186wj58bR3vZfFWROSgo2o7nlu3QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743072278; c=relaxed/simple;
	bh=Z1z2oQX6GVOmFSouXE51dlABKEyLBAbiPyOzdqPu3W8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DpfSo9J7hgPKmD9o33fXrZk6vpdcAESeg3IGUbJtSn9GjyJgL9lBA9pSrzg+rcTvPAifBRAOM8G+rghJ2vmBQDHd3/dgxweooL6/CT6TL78OLtXrHn2oC6uXq0fiRpXvtj07EP0vxtTZVSWScxswFJX8BUd4Qy5oPHbyUT/s90Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CSMGnTZ9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743072275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WyWvRzluSiEXBBT2a7VCBlnyJ21GZtU6y+n9uBuHn7I=;
	b=CSMGnTZ9VuyQ76IDRW7vUBrpvzB0h+6iV9Rrkr3vmJvZrGNS5X1mdfnpqCmCTcZs0q8lIU
	QCmvAd0iRAniHsKi2c7bB2dMFCFWYXAYhPZ/jRXGMcTPCu2vuFc5TkqXcZ8AhuhcNoSOGF
	HjS2z7GkF8jEL9zGrEAytN92pcA5nn0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-lg0S-s4xNnCb3ZfU9ZEcSA-1; Thu, 27 Mar 2025 06:44:34 -0400
X-MC-Unique: lg0S-s4xNnCb3ZfU9ZEcSA-1
X-Mimecast-MFC-AGG-ID: lg0S-s4xNnCb3ZfU9ZEcSA_1743072273
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5e82ed0f826so874058a12.0
        for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 03:44:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743072273; x=1743677073;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WyWvRzluSiEXBBT2a7VCBlnyJ21GZtU6y+n9uBuHn7I=;
        b=A38pRzhqxK3wbeneT7OzXK4f/r9sj52R6ExltitAEPJcjzMU0wU7Q9QQwHWWh3wY6f
         CiW0XCBgkMrAk1TV5EAsfDvJRAmPOEK32pBg+bmwmPIuKBu4EjCvyYISIBEKBxxNj/hc
         DHyo3qrBzklKs0ZwVIds++Trau1QmGXnbImGP6SyH5RF2QvXoXpKqDRZL0+8iwIY8nZz
         0a+syD0VLvMSi1LKddWxepQj+/FAAHhh/N8xQT5oIj39bRhpjE0Bu9gIsUka4PXK+NaH
         mHd7owIE7WdbTFYECwcOSiomD4MRTnRsS/XvJBa152UClFtfDCnjWJm03X9u7vLSoXIR
         pl2g==
X-Forwarded-Encrypted: i=1; AJvYcCWuSWeEn70xLHtJTSQoW1JQP5nv238gxuUI5Bd5uUU2Q/54qsC1xhp5rB7hF2X3EXoNxpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT5NJEc3t0l9guUyihDD7WnCdP5O1Uv4NFWiFXfb4y+y8uL0G0
	FZhF+KzGrqinshA+vHX9Hz4ZASaG+1MwJNiHyXLLSgOkr/EZH7HA+B3KDb9yp48dALvV2+1t2eS
	nH0ob3R7r/AC8dofTCFkgSH1I5iBYWat91wMasfe8XSjdvAEDRQ==
X-Gm-Gg: ASbGnctWQ1mrwD6lppbUSAewtN2HhpJlZMtv1edturdDBFtdPbInEKdKSCYHL07e675
	QK7EAdLGPWwL/JUzZQCk1l87SLmSkmbLqPwX5P2V4dr4ap9fhDrYdI8CBbCBSR9z7rjRo+W56IY
	Y012b+RuY7/QESQsKDg+SMEKSyMpJQaeONocfEYrkevnyNhWVkPRHKQmPsNBsIQI95zIUe1h9Yl
	8D1MyRGDodOvjKYMFySj/tQuOpP5AXU6kDGm/ZZlH1H1zZfOd4AhL6b5yY29wg/xCtm1vzZRkJh
	kLYyWTAHLE7FMGteV+35FVKEMMhNKjKuMbPYLWnI
X-Received: by 2002:a05:6402:430c:b0:5ec:cc90:b126 with SMTP id 4fb4d7f45d1cf-5ed8e5a5d7dmr2920444a12.19.1743072272764;
        Thu, 27 Mar 2025 03:44:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxY9QVIO/VsgSyaKIBh62Jyrq8IaKt0cDmXoin9ToYvgK/LxQKcrJwZ0uLZmyq2x9mCaJPWQ==
X-Received: by 2002:a05:6402:430c:b0:5ec:cc90:b126 with SMTP id 4fb4d7f45d1cf-5ed8e5a5d7dmr2920405a12.19.1743072272282;
        Thu, 27 Mar 2025 03:44:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcce36d66sm10908646a12.0.2025.03.27.03.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 03:44:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id AC5B618FCBF9; Thu, 27 Mar 2025 11:44:30 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v4 0/3] Fix late DMA unmap crash for page pool
Date: Thu, 27 Mar 2025 11:44:10 +0100
Message-Id: <20250327-page-pool-track-dma-v4-0-b380dc6706d0@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPor5WcC/23NQQ6CMBAF0KuYrq1pZ0pRV97DuKhlkEZpSWkIh
 nB3G+ICI8s/P//NxHqKjnp23k0s0uB6F3wOar9jtjH+QdxVOTMQUAiUgncm37oQXjxFY5+8ag0
 XiIAKjdKCWF52kWo3LuqVeUrc05jYLTeN61OI7+XdIJf+K6tNeZBccAsSqChNqSxcIlWNSQcb2
 gUcYIVAsY1ARqREult5UrrGPwTXiN5GMCNHUloJqUkY+4PM8/wBzpEw+UsBAAA=
X-Change-ID: 20250310-page-pool-track-dma-0332343a460e
To: "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Mina Almasry <almasrymina@google.com>, 
 Yonglong Liu <liuyonglong@huawei.com>, 
 Yunsheng Lin <linyunsheng@huawei.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-mm@kvack.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 Qiuling Ren <qren@redhat.com>, Yuying Ma <yuma@redhat.com>
X-Mailer: b4 0.14.2

This series fixes the late dma_unmap crash for page pool first reported
by Yonglong Liu in [0]. It is an alternative approach to the one
submitted by Yunsheng Lin, most recently in [1]. The first two commits
are small refactors of the page pool code, in preparation of the main
change in patch 3. See the commit message of patch 3 for the details.

-Toke

[0] https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/
[1] https://lore.kernel.org/r/20250307092356.638242-1-linyunsheng@huawei.com

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
Changes in v4:
- Rebase on net-next
- Collect tags
- Link to v3: https://lore.kernel.org/r/20250326-page-pool-track-dma-v3-0-8e464016e0ac@redhat.com

Changes in v3:
- Use a full-width bool for pp->dma_sync instead of a full unsigned
  long (in patch 2), and leave pp->dma_sync_cpu alone.

- Link to v2: https://lore.kernel.org/r/20250325-page-pool-track-dma-v2-0-113ebc1946f3@redhat.com

Changes in v2:
- Always leave two bits at the top of pp_magic as zero, instead of one

- Add an rcu_read_lock() around __page_pool_dma_sync_for_device()

- Add a comment in poison.h with a reference to the bitmask definition

- Add a longer description of the logic of the bitmask definitions to
  the comment in types.h, and a summary of the security implications of
  using the pp_magic field to the commit message of patch 3

- Collect Mina's Reviewed-by and Yonglong's Tested-by tags

- Link to v1: https://lore.kernel.org/r/20250314-page-pool-track-dma-v1-0-c212e57a74c2@redhat.com

---
Toke Høiland-Jørgensen (3):
      page_pool: Move pp_magic check into helper functions
      page_pool: Turn dma_sync into a full-width bool field
      page_pool: Track DMA-mapped pages and unmap them when destroying the pool

 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 +-
 include/linux/poison.h                           |  4 ++
 include/net/page_pool/types.h                    | 65 ++++++++++++++++++-
 mm/page_alloc.c                                  |  9 +--
 net/core/netmem_priv.h                           | 33 +++++++++-
 net/core/page_pool.c                             | 81 ++++++++++++++++++++----
 net/core/skbuff.c                                | 16 +----
 net/core/xdp.c                                   |  4 +-
 8 files changed, 176 insertions(+), 40 deletions(-)
---
base-commit: 1a9239bb4253f9076b5b4b2a1a4e8d7defd77a95
change-id: 20250310-page-pool-track-dma-0332343a460e


