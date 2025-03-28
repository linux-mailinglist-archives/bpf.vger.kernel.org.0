Return-Path: <bpf+bounces-54854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CD4A749A9
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 13:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09507189A127
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 12:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DB421B8F7;
	Fri, 28 Mar 2025 12:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwB5nudJ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AE121ADB9
	for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 12:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743164365; cv=none; b=cu6Lck+ewtU8kYwlgI8sog9s/S4spWE5I7KQDm/3EkSPxp+/hU3NElZvmLyWAeT6xwkXjInb3m9zpV9oCW3SAxFQbUSGN6C7O1D6cSk4KfYsbhJ8QZXQ/GJUq6R/KNukpTg+3mNSosY4WtZK30IBX0xRSw8EcJxxIpYglc4Fpeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743164365; c=relaxed/simple;
	bh=/hMtCMIMtDNnFFdvhLcexuO+Yqt2I6uJhhOrr7EDOh4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EThBmmyeYMsSgaK2KZvzKdHfG0BzVpOtgaTawbneATILIipFzfBcShTlqkIbgX8tufE0K9E/ur6AeuUJs1qrxo6RXFJpHnyrx9fud0dnYAF1T0MpVwukbMrziDstLg03IeQnHEeieF0f9lh0b7LT2ksgubufeQmht6ev+Hf5wmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TwB5nudJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743164362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FBsI3PcyVwGsbuzOR/tW+kxB5J9W8FFZwhDeFg/Emi0=;
	b=TwB5nudJcBhtWbMHNTHUo/hfkwfD0kEl0NQEAnzT61wo+gedWtDnmXm+8QBctO05U9Yd0i
	yjw7l6SwLhYArmTrqtp8fyYFFjOILESUnE3S/OPbWX16SWjOWSAtTpHyrTQ63R/vBP45C5
	ZNmxKswJdpDT4FzyNS5sH/GbCWwo8N8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-b6FWPBqLN4q7cxeai0WKxw-1; Fri, 28 Mar 2025 08:19:21 -0400
X-MC-Unique: b6FWPBqLN4q7cxeai0WKxw-1
X-Mimecast-MFC-AGG-ID: b6FWPBqLN4q7cxeai0WKxw_1743164360
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac21697a8ebso192537766b.1
        for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 05:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743164360; x=1743769160;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FBsI3PcyVwGsbuzOR/tW+kxB5J9W8FFZwhDeFg/Emi0=;
        b=YDSoowMxe/AwNt27Xb7wfxZyV2Bgzn/80L9xrvI+RUUsimxreEeu7ZzNcwbdDKAGoM
         yzQ1e+CHbtbVCVTkaVlSDTYZrkZ7mevC436fF8gonuCGxhScwG5/+8Tu4SCryxF3eGkU
         iiFOHZPp7FxMq2A+hOI1m63G3i05mgdo7/Jnuf/yArMkrA+7OqY25MdtdRELTq/2MrJs
         KswiuWk8wxgmPOwlCnq432HPI2jce6CF8t5OT8NWEamXI4shBKxc3GUAQjhOmNntQDxy
         BiEFYrQmNaMkaICYLoPZy+l1q22Xuq4mY37GmJM1Q4jdz4JN1eQdaEsVS6YRa+GDxAfE
         Yrgg==
X-Forwarded-Encrypted: i=1; AJvYcCWIXxOT70s8FPiVeWbk3GhJGXSMxT4DNP3OmRVCp8vKuIWE+2NCPmO63TV/hwTnm8uvRvk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0niW9TnPq1amL194Eg2ePWbDnzKG5Z02qkE6N8W2AUTRcMFJu
	U5RmRIV3mgPPKa4Z+EUn4G+BPFg5Ybp/4Sm2Xy+h1RkCcmEBUl8E1fgPtK1kY8t7JJafD9zSVua
	a7E0Dks/9Kee6eXseLT9I0NraWUkYW2ycFcsJ6dUZg4ff4ojGkg==
X-Gm-Gg: ASbGncuuR89Zcr6cPA3YBMyTniv5srR20htwtYvjdIBGNgX1R/9blBPkkQgjTE3H3ZI
	6Qj6p+XVSWLZgnEeKF/W1+vdqX3dPV/gQ6x/R5eHrBrOiXuUx4RdyYuTISYNMQZYyZKzQfh3n48
	W8hEuU+ONsK7f6IWHBcZIqOu+RFwFaYSwprGIFkbhUjgE6fzSxt69YZs8rC/NNbrhKEaGofXORw
	EPPoPiupduujGfNg55PZYwMQ1sgGi+5b05lanrCzu0ufHT/miDeq9E50BVs+Fnov537Glf14y8v
	JlLOIS8QLl2B
X-Received: by 2002:a17:907:c12:b0:ac2:cae8:e153 with SMTP id a640c23a62f3a-ac6fae622b3mr773304866b.4.1743164359824;
        Fri, 28 Mar 2025 05:19:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP3NonXENFoGDvZyNLB/3DvTBmdD/0XZXIFjgnHlxwf5UEuMfTRP49tYjouTNp3FuAtJ81Hw==
X-Received: by 2002:a17:907:c12:b0:ac2:cae8:e153 with SMTP id a640c23a62f3a-ac6fae622b3mr773299366b.4.1743164359287;
        Fri, 28 Mar 2025 05:19:19 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71961f8f0sm151499566b.95.2025.03.28.05.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 05:19:18 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 86B5E18FCDC3; Fri, 28 Mar 2025 13:19:17 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v5 0/2] Fix late DMA unmap crash for page pool
Date: Fri, 28 Mar 2025 13:19:07 +0100
Message-Id: <20250328-page-pool-track-dma-v5-0-55002af683ad@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALuT5mcC/23NQW7CMBAF0Ksgr2s0npk4tKveo+rC2ENjAXHkW
 BEI5e5YEYtUZPnn6795qFFylFF97R4qyxTHmPoamo+d8p3r/0THULNCwAbIgB5cvQ0pXXTJzp9
 1uDoNREhMji2IqsshyyneFvVH9VJ0L7eifmvTxbGkfF/eTWbpXzJvypPRoD0alKZ1LXv8zhI6V
 /Y+XRdwwhWCzTaCFTGG5OjNJ9sTvSG0Ruw2QhU5CFsGYwWcf0N4jbTbCFfkSAcI3rZgA/xD5nl
 +AixwIP2QAQAA
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
submitted by Yunsheng Lin, most recently in [1]. The first commit just
wraps some tests in a helper function, in preparation of the main change
in patch 2. See the commit message of patch 2 for the details.

-Toke

[0] https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/
[1] https://lore.kernel.org/r/20250307092356.638242-1-linyunsheng@huawei.com

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
Changes in v5:
- Dereferencing pp->p.dev if pp->pma_sync is unset could lead to a
  crash, so make sure we don't do that.
- With the change above, patch 2 was just changing a single field, so
  squash it into patch 3
- Link to v4: https://lore.kernel.org/r/20250327-page-pool-track-dma-v4-0-b380dc6706d0@redhat.com

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
Toke Høiland-Jørgensen (2):
      page_pool: Move pp_magic check into helper functions
      page_pool: Track DMA-mapped pages and unmap them when destroying the pool

 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 +-
 include/linux/poison.h                           |  4 ++
 include/net/page_pool/types.h                    | 63 +++++++++++++++++-
 mm/page_alloc.c                                  |  9 +--
 net/core/netmem_priv.h                           | 33 +++++++++-
 net/core/page_pool.c                             | 82 ++++++++++++++++++++----
 net/core/skbuff.c                                | 16 +----
 net/core/xdp.c                                   |  4 +-
 8 files changed, 176 insertions(+), 39 deletions(-)
---
base-commit: 1a9239bb4253f9076b5b4b2a1a4e8d7defd77a95
change-id: 20250310-page-pool-track-dma-0332343a460e


