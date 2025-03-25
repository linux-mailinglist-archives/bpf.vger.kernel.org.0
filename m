Return-Path: <bpf+bounces-54691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5298DA70572
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 16:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777B016ACC2
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 15:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A320D209F40;
	Tue, 25 Mar 2025 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mc/TSHJG"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656B41922FA
	for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742917605; cv=none; b=GrWd2Lt3CqyKl2DWMJAEBFnWsGnSsRXBe1BnDvPaQEfvkI0x0oUvaFqCEoi+wP8koYmOXgjZPTBBgj2gZrWfzFpyVonJB3hmhqulAzkg2g2gSsPB5TP/2kzphRh1+3DXG918Mw2HnMzqxF8SDoLGP6Is85AMUN781A42Mm+mRr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742917605; c=relaxed/simple;
	bh=IuMa+liBH/B2Yu1mDpSq4nCTE5d0LpHwv/uosWgfnFk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cpQkheK5R6HrN1Z7JNRBJUq2L/kt3IOubHUv44G3rvRIyzKJkENkO1vhpJcMZ5Mbo8Q63Gb6sslKd+yPTpx4zXPpDu7W7Xu+y70r+o329owvy8YBJ7PPNaTj1msfDsej2yumjKnf8j8JJEVvCbFbhoL99uWIxsaaGUYStsuTX34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mc/TSHJG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742917602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y52BZ141xP1cmy6URJL9RkKym6Xlq7n0vZ3Uzut8xhY=;
	b=Mc/TSHJGZUVN0nusB1tzvIHf1gH32vtvjev00svzOOvyBIv7BK2AJyeND/qMw7obq6Mu0b
	yQhq6Bp6fc/N9ffXLPX3zX3NFgJ8Ir3s8Y6OXN+tGn+SCsW0Px4EOydeuezHmu6YOVFyzy
	YoNNZ9Ra7XlYibViJwKCmHG/HHjiDm8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-Kq3qMS1UMeSFZbA7ORplhA-1; Tue, 25 Mar 2025 11:46:40 -0400
X-MC-Unique: Kq3qMS1UMeSFZbA7ORplhA-1
X-Mimecast-MFC-AGG-ID: Kq3qMS1UMeSFZbA7ORplhA_1742917599
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-30d8de3f91eso16561221fa.3
        for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 08:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742917599; x=1743522399;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y52BZ141xP1cmy6URJL9RkKym6Xlq7n0vZ3Uzut8xhY=;
        b=flU6LxnXyRfvCb13RLB7696+JybZF7fjjF3xxVN6f6G7uU5Tejzc89wCGVNZhg7NEw
         N+HXE8IbYVgZ/cz0JKjEv+4R5qjZSopjV/PaK7ev3hN1iWK5/c1PPYYc2Ydt13Qiu3Oz
         vrNug2MGTl6CVXrl0qAMruOqOPOfysKvTzCw/0u+ntPFGIS77yI9MWBArvTpUPTzOfDH
         oHOHgEtRy/DdsxjjpHa6NGAxnzc6wZxt5Du+KP3Lm1EPNLKCCysoWunQwXfufETGUUY+
         r5WL5FDu8HMcOBJ/JB0P8PpjGWCWDRhmYm37bzg8DXwraw8vyPcL41lrYFJqJ8k1gSzX
         aRgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWur+SLYbtpBfc00fGUccN5PLDnYWqY2L2zMLWYJXYNfXDWECpWeyIbi1vYGJui+KQHWN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsB0AD8r1SnUnhr8XpMgvifhHPPNC2IY/aNUwF+KcYRy2p24SS
	lUL6G6k1kwmfJXPO98xgHM0MbQ9IPLyUP0sVXw6a1zn17RftCKWZH10Xwl0lK0CSf6hgW5dfEj/
	dtDDGJCadacrmDAnI8fZ7HsnCBdULFLgi/nCeczV0SuqDrvl5WQ==
X-Gm-Gg: ASbGnct0zwhZwDX6PXh3E1oQnwxH1SuPA4JUfAeUXGGpCOjs/kbBN4SQGSRH1cHEKqp
	WBK7JTx6g51LDFZ2GNcbBjWZRosybZOGAPH6zcuQLaDV2VWmmAn/V+P2mRd5nyoXfoOLpvFUByb
	3Y9MtYmRZjK4sWmyzo1L2+0IAnUU/jNIl/prWbkOP9UtptM8+haOXRi6x7vQMalKiVq/AqqdOW2
	3raBSSllU/bHDiusBcKHfGVWhB9UDcYmBi+vCIb3Fq2+5upUmdKPy7E3RFV+BDvP/9HuDESWfeZ
	w7BndeULB4sd
X-Received: by 2002:a2e:be8b:0:b0:308:ec50:e841 with SMTP id 38308e7fff4ca-30d7e313eedmr83894501fa.25.1742917599216;
        Tue, 25 Mar 2025 08:46:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFauRbSf+Z/aowK4ZvQrhLjDffXRTAIj3FvuTlcqi0ZO3sYX1PyxjhMIclDBh2byTqy+7m2fw==
X-Received: by 2002:a2e:be8b:0:b0:308:ec50:e841 with SMTP id 38308e7fff4ca-30d7e313eedmr83894191fa.25.1742917598512;
        Tue, 25 Mar 2025 08:46:38 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d7fe7b4sm18543751fa.53.2025.03.25.08.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 08:46:37 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C415A18FC8B6; Tue, 25 Mar 2025 16:46:36 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v2 0/3] Fix late DMA unmap crash for page pool
Date: Tue, 25 Mar 2025 16:45:41 +0100
Message-Id: <20250325-page-pool-track-dma-v2-0-113ebc1946f3@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKXP4mcC/22NwQrCMBBEf6Xs2ZVkk1rw5H9ID0u62qBNShJKp
 fTfDcWjx5nHvNkgS/KS4dpskGTx2cdQA50acCOHp6AfagZS1CqjFc5cuznGN5bE7oXDxKiMIWM
 N24sSqMs5ycOvh/UOQQoGWQv0lYw+l5g+x92iD/4z27/mRaNCR5qk7bizjm5JhpHL2cUJ+n3fv
 1Iu057BAAAA
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
      page_pool: Turn dma_sync and dma_sync_cpu fields into a bitmap
      page_pool: Track DMA-mapped pages and unmap them when destroying the pool

 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 +-
 include/linux/poison.h                           |  4 ++
 include/net/page_pool/helpers.h                  |  6 +-
 include/net/page_pool/types.h                    | 67 +++++++++++++++++-
 mm/page_alloc.c                                  |  9 +--
 net/core/devmem.c                                |  3 +-
 net/core/netmem_priv.h                           | 33 ++++++++-
 net/core/page_pool.c                             | 87 ++++++++++++++++++++----
 net/core/skbuff.c                                | 16 +----
 net/core/xdp.c                                   |  4 +-
 10 files changed, 186 insertions(+), 47 deletions(-)
---
base-commit: 45e36a8e3c17c4d50ecbc863893f253fb46ac070
change-id: 20250310-page-pool-track-dma-0332343a460e


