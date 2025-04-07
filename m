Return-Path: <bpf+bounces-55417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AC7A7E799
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 19:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39AA3A4D47
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 16:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA9321171D;
	Mon,  7 Apr 2025 16:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bmWFM/ab"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA09C2144D9
	for <bpf@vger.kernel.org>; Mon,  7 Apr 2025 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744044928; cv=none; b=HlxYJyT0mRhDBmvm47VPLs0j0Wco+j4jWiC+A6muwd4JD7XWdoEgizE0XGBn/PglUj4BqpXwe3+VzFrbcX+qGuVrBD0+vsGwuVgLyNPlQKQzdOCeoFF76jibLw66OZ4jhuFbRFEwVE/abUihkwOwKLd5KEdxOGdSWsIWK4i3zy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744044928; c=relaxed/simple;
	bh=jcM1KJ+oTG6JfJgmjgcHeZbwHhXSOTSj3tWy8VIS6b4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E4jdzy548rYlaCt6XlOpSU4O45Hx2zgMm7Y6u/kc1+lKH+iTK1vnXPE4JPdY0/EypNQnovz0RAwY7nSNnM+sSYqno9RQP/FE3hQQAUGLwqBOqJLFLwfjk+6PZMs0Tu9dukAipeOO4iYFNPMJ1oPm5r6uQ+1DxH17O9uGYOAWJcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bmWFM/ab; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744044924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qYhbBJcaD1ygP+VeRMfirZ7ESTAhBwWp2EEunASyCrc=;
	b=bmWFM/abAQi5ZZbOt6PU3xV0Qe2kHqOnmftxJlyrE5raksVZHhNwT7nVvVbf83Y44NPmEi
	/qAmxNaVtKuTF1DIEJYky1LZn2U0d+OcMNPndm6CQzePBqaGdYAq8STzBEi6HBKEzNYnqC
	kf4WLFPu99wu5hqgTdXyqjWW6SgPHR8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-18qYq7NSMbSEGW_omTgbUA-1; Mon, 07 Apr 2025 12:55:23 -0400
X-MC-Unique: 18qYq7NSMbSEGW_omTgbUA-1
X-Mimecast-MFC-AGG-ID: 18qYq7NSMbSEGW_omTgbUA_1744044922
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-549aec489c5so2303364e87.0
        for <bpf@vger.kernel.org>; Mon, 07 Apr 2025 09:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744044922; x=1744649722;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qYhbBJcaD1ygP+VeRMfirZ7ESTAhBwWp2EEunASyCrc=;
        b=Wam8YPwBl0g7DrfnsVd6KfaWJp5k8EYCkprDCMHPHF59Xxmj/GiS2iTF7msZlVtDQf
         776cj+P0yPJ9XK+uPc1yjAGfG8lPHZ01bZc83Od3LkLdYnYHOaUdt6ddvHGCxBpE/aMm
         c8FGa+iJte92wN9Wi9+7W62pzyQJ8Yw0O6SbuhDxg8wwaq5p3W731tTjX0Mwb3GUUrK6
         zmvCnjK0EGcfbyiULPiwaUVQkI24wqxr4FRRCYK69+SeUG0ULjnHpwW4FNPh4/YPqibK
         gWIsGRmeJI/PqzuJ86vCNuiMDhikjlS89D9r8ONLL9tvbkUnIdHs/ZMalk5JEuP3YUtn
         yOyA==
X-Forwarded-Encrypted: i=1; AJvYcCX1XYeO71p7gbe9mYlqPM/tTSdKj2AcqNalQazl2HcfsG5FigdJeimeqahBZGX6rYDgg8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9p9+qgijHYtukiX989S6NfwwnOm0yqp7Tn1e2a9RD2ar6xax3
	+s2ODbnYC3SgO/PC4cjtwRXfSRoLG1XyhvUAAQNbqfxuJWA9L9w0pjlFzeMJcDYJysDHXaouaIG
	2YRSX7r2taZf0J4MAYWsPUpVoFkJuYw42ikRoz3NZ20JTkA1Qbg==
X-Gm-Gg: ASbGnct/QBrJuaGKftpbcWAujhs+pBTH0YK8saCStuemRbh8ZQd8U4P3IP+X43gVdlf
	1P1BjKSvMd5OG4TnBs+TGvWRxsjsAw+FBVomSFUIo9YMXRGsCU6dtCAWGMB+IPJwHEt70jwycsp
	YOTD5zXeoTlPBzZznhNmaoFm0hX1/U5RdpasKEST9WodRDgxf3Cnx1uH9BvaQa8uirUuIqwiK4o
	1HKHWrznTUvCQdQMdQYLHnU6VCjkWtAvL2kJj2av7PJYcqt0zJDiDguBuuP+DqZ6sDZt2WGxq+t
	adcvuzSiW/Vo
X-Received: by 2002:a05:6512:108a:b0:549:8ed4:fb4c with SMTP id 2adb3069b0e04-54c297d170cmr2857136e87.24.1744044921945;
        Mon, 07 Apr 2025 09:55:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvNfOjhckEBLi3/as3JzwcR8acC1aLA6tON5wKoCSB+e2g7g/r0YG+F8AMVZXdzdvP+sGGxQ==
X-Received: by 2002:a05:6512:108a:b0:549:8ed4:fb4c with SMTP id 2adb3069b0e04-54c297d170cmr2857106e87.24.1744044921502;
        Mon, 07 Apr 2025 09:55:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e5ab48bsm1342106e87.33.2025.04.07.09.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 09:55:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 49D3119918D8; Mon, 07 Apr 2025 18:55:19 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v8 0/2] Fix late DMA unmap crash for page pool
Date: Mon, 07 Apr 2025 18:53:27 +0200
Message-Id: <20250407-page-pool-track-dma-v8-0-da9500d4ba21@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAgD9GcC/3XRzU7EIBAH8FfZcBYzMMPHevI9jAcKU7fRbRvaN
 Gs2fXexMbGmePwzmR8McxcT544n8XS6i8xLN3VDX4J/OIl4Cf0byy6VLDRoA6hAjqGcjcPwIec
 c4rtM1yABUSNhIAssSueYue1um/oiep5lz7dZvJbKpZvmIX9u1y1qq//IVJUXJUFGrTQbFxxF/
 Zw5XcL8GIfrBi56h2hTR3RBlEJuojqTbfGA4B6xdQQL4pksgbIMIR4Q2iOujlBBGvSQonVgExw
 Qs0d8HTEFMQZAh9Z6DOmA2F+kvLaO2O9xGo/kyDtIdEDcHvlnO64gISG1YM/lc/0fZF3XL52Y9
 KpfAgAA
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
Changes in v8:
- Move defines to mm.h
- Keep pp->dma_sync as 1-bit wide
- Unset pp->dma_addr on id alloc failure
- Rebase on -rc1
- Link to v7: https://lore.kernel.org/r/20250404-page-pool-track-dma-v7-0-ad34f069bc18@redhat.com

Changes in v7:
- Change WARN_ON logic if xarray alloc fails
- Don't leak xarray ID if page_pool_set_dma_addr_netmem() fails
- Unconditionally init xarray in page_pool_init()
- Rebase on current net-next
- Link to v6: https://lore.kernel.org/r/20250401-page-pool-track-dma-v6-0-8b83474870d4@redhat.com

Changes in v6:
- Add READ_ONCE() around both reads of pp->dma_sync
- Link to v5: https://lore.kernel.org/r/20250328-page-pool-track-dma-v5-0-55002af683ad@redhat.com

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
 include/linux/mm.h                               | 59 +++++++++++++++++
 include/linux/poison.h                           |  4 ++
 include/net/page_pool/types.h                    |  7 ++
 mm/page_alloc.c                                  |  8 +--
 net/core/netmem_priv.h                           | 33 +++++++++-
 net/core/page_pool.c                             | 81 ++++++++++++++++++++----
 net/core/skbuff.c                                | 16 +----
 net/core/xdp.c                                   |  4 +-
 9 files changed, 178 insertions(+), 38 deletions(-)
---
base-commit: 61f96e684edd28ca40555ec49ea1555df31ba619
change-id: 20250310-page-pool-track-dma-0332343a460e


