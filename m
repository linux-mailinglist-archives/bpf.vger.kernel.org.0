Return-Path: <bpf+bounces-55062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752C6A777B9
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 11:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001A816AE4F
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 09:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2591EF0B2;
	Tue,  1 Apr 2025 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZcTsZy1i"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EC21EF081
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 09:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499663; cv=none; b=iUCwid4YBJ03VCU/YO3j/uqMFbvxc5GL1sGUYLk5ZttPgpOmukqTSfi0wJnNWWOUGbD7TIEuAzauE4uj9QwjJtXogBoJ7YSO2PzCQ1Vqm6bK4r5udk7zJyU/V2CiZNHjZDn3NpkvD1/jtJM35ZVaUpD8T/uk1xVgk86ZyIeqSuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499663; c=relaxed/simple;
	bh=RVh2BP0zNXztVGW8aRee7AQCaUaVGwZPjcv6NQH5Dtg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KinF9qDdNMYtCCTn91ilySLm+of1WEpXxrjWF/QDkXTVrG3a6vEETxfOUj/DmBaqqTKjlsX2FzLX7h1Cb9IZmlL+F5EzYKPu1/5vyyj1GgVJkxCVGZtTI8FpOil7haC6dxteAGVqgxIs6bGWZSJXCvcMvvfKQbc+A0qdDeI2rEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZcTsZy1i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743499657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1ZiwmWlfT5msBPwsaS4TsFciafSUxtrnbKJoha2W67Q=;
	b=ZcTsZy1iiEXV0aD5Iirkcx09+Bh4V+wmFb0Kgmf2k5XAzbbwJE0qRPnjyIGr/8eStCqMKz
	VMBtW8fxwwZjDV6ZMd9y3PDj8cT9G8EMxW1amvE+NmPoP6cACktc1t5fgGW2b2oiGBlm5u
	C7MIIDJJ9BS+Zwp3/cOJkUIa9V1iKuw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-DaMO6H4KNwOmw6HP1uqYcw-1; Tue, 01 Apr 2025 05:27:30 -0400
X-MC-Unique: DaMO6H4KNwOmw6HP1uqYcw-1
X-Mimecast-MFC-AGG-ID: DaMO6H4KNwOmw6HP1uqYcw_1743499650
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5e72c1bf151so5718964a12.3
        for <bpf@vger.kernel.org>; Tue, 01 Apr 2025 02:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743499649; x=1744104449;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ZiwmWlfT5msBPwsaS4TsFciafSUxtrnbKJoha2W67Q=;
        b=Lw1grBUWvt95UoLrzRLIedky34DaajcyarSx4YAgz1AwTQjGZfXzfl+YV/LVDiP9Lo
         TSzkfw8+ZrvqjMR+UPa+B5sQwNrosDN0jLzX38aPaipGT+zOAXAEHDl2UcdsyJgQT3Oz
         jJD/eNjGeLt2oahJLDjd2sSJGHJ1ocuW+Z8Z0ab6Kcv59nqCfVmpG1tOfGPSgWiRs5sZ
         e8IjKokuLe7q5Kp+vK3pjk6/yvknzvnDSTFl+F/CBkahay77yiDFNrTgfAbjmh3eswEE
         ADtb2UxIybddbZPT6eB21NX42WWcE/GQCO3vaJBBysYAEtxt+ZeuW6AI5CuNomHFyTEK
         ZNrw==
X-Forwarded-Encrypted: i=1; AJvYcCXz3weKAEWJEtER249vmku2TybryCvwN3l0rfDs6tmaPhjLiMtZEufswLC8wZ7EdcO5RBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq0LcKf/VpSx22/1WhJ7PMn89NoutH+2gHZwacAfj2TRrQbih3
	AptGYpkQ7U4pylMdlwNQjrRHlN6dQClzZH8kP4l50gmAjy8Fu9JmlV1tE6pqvWXgkqyw9LJ2avo
	QO1KjJFHdbKN1imChzuPOFeoWUg5+t2R9lMtnghQMyD2jJXR/MQ==
X-Gm-Gg: ASbGnct5MCktfj2MMN3z7vRurCCJHGPrHsj7uOewSru3+7HLOxM8vhSDCd9OqVgg5BZ
	DrLTvAl8DmAg0qlSwd8PIt49vtziwNxGR1vbfWsxiQ8mwo9odNxDh1g5vYyTEvKTQ+o7yrhab/9
	SAvigcKWoFGEB3Zwn7pSSF64VFqIkU1QCy5i/9IdFtSu0DGXRbkbNkXGdYsm+3zZroY880rn0Hy
	StDh6Xfvr1ERLXkA1EAA8ReqI0fJMRtWPP/ulB8pj9TtuSxqHQof2xnPqUfSWPVx4FPidYzFKYW
	4LQ1x3EIubTP
X-Received: by 2002:a05:6402:278f:b0:5e1:8604:9a2d with SMTP id 4fb4d7f45d1cf-5edfcc04fd5mr9820814a12.4.1743499649604;
        Tue, 01 Apr 2025 02:27:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUGsT6plXzO/A1LVcdoXRQcUcCcBW0zBrJ/EkRGpYDjtXu+hVn+0Ib/LtdHGE/4da71LQe5w==
X-Received: by 2002:a05:6402:278f:b0:5e1:8604:9a2d with SMTP id 4fb4d7f45d1cf-5edfcc04fd5mr9820775a12.4.1743499648927;
        Tue, 01 Apr 2025 02:27:28 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16aae2fsm6755282a12.4.2025.04.01.02.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 02:27:27 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 81DF318FD267; Tue, 01 Apr 2025 11:27:26 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v6 0/2] Fix late DMA unmap crash for page pool
Date: Tue, 01 Apr 2025 11:27:17 +0200
Message-Id: <20250401-page-pool-track-dma-v6-0-8b83474870d4@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHWx62cC/23NwU7EIBAG4FfZcBYzzACtnnwP44GFqSW6paGkW
 bPpu0saDzXl+M+f/5uHWDhHXsTr5SEyr3GJaarBPl2EH930yTKGmgUCGiAFcnb1Nqf0LUt2/ku
 Gm5NAhKTJaQss6nLOPMT7rr6LiYuc+F7ER23GuJSUf/Z3q9r7P1k35VVJkB4Vsulcpz2+ZQ6jK
 88+3XZwxQOCpo1gRZQivnr1ou1AJ4SOiG0jVJGetdWgLIPzJ0Qfka6N6IpcqYfgbQc2wAkxR6R
 vI6YixgCgG2xPLvxDtm37BdksqQjVAQAA
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


