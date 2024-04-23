Return-Path: <bpf+bounces-27544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387FE8AE8D2
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 15:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C56CB21A55
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 13:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4661F13774E;
	Tue, 23 Apr 2024 13:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dfi2uLq2"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CD3136E16;
	Tue, 23 Apr 2024 13:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880731; cv=none; b=T7kcZ2rrHcoy72jT+RMrFag/0PqnM32B8o6RToVSMuM/DqQ8M3HTIN1vSXI8ECULuVSlyWQda+WdDXU1h9dGp2bcaF5pf1TURrN9uN8E/aPiIUPzeFbG8gCJre4H3in6N6MMijA6Zc3pgCjTg4fOA6cipz/wa+KbpCzUkFFPlZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880731; c=relaxed/simple;
	bh=PM4hKVCgLViTlEhxGEmFa37oVZWQvC3vlHhtyjhGMvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tNfQVUvjfHoAgWfsa0evPQ8cZp5uhp6te+75nKM8QYusyU8kNrGA8Dr1VyVmDi7j0wrCVvKZXxqOB6eFtushca3gUREnZqCqUkZVMEpx0yba89pzIDxHvTyjSOy4iT/qHBvLhoMphbGN/hrMepZ+58QpiK49Pee5L0sg95RpTe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dfi2uLq2; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713880730; x=1745416730;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PM4hKVCgLViTlEhxGEmFa37oVZWQvC3vlHhtyjhGMvA=;
  b=dfi2uLq288Zmbcqgo/fAuud0TuOT1tc4CNcWBAR5MsldW0QYQl7fiQFH
   hnah70cS4YJk1bfvl1vkcSi6j9a86k300A1geJKPdh+4yybJ6AvdoUg2c
   e82dRfe/eP6IHp9iCVgnaNi9C2rgV2ARZAF1413DOldlCi6qzpqqnfp9j
   gth8BTF+ffI65M5kN9+8Mvwsc0AnUN8dF4kP4hL7EebLtcCYcI79aa37F
   sRg5Pm5fW8n6fUcQEUgpurREssyhiwsl2qu526zM1Cis5as0aiEYpxUVc
   3bsLwWbrahfYRs4mHjQZQ5CS8mADQrq4ysHRWfvXubofv5dg+7sI3PTY0
   w==;
X-CSE-ConnectionGUID: 4iQ6PcLLSTyEciMdK/uoZw==
X-CSE-MsgGUID: 6NVhk/ogTdK/Od/1CGbhGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="26921426"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="26921426"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:58:49 -0700
X-CSE-ConnectionGUID: If+xOyfqRgibg6Xjd3xxdg==
X-CSE-MsgGUID: Rz+XMKpcS8KsUB23qWigbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24431745"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa008.fm.intel.com with ESMTP; 23 Apr 2024 06:58:45 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 0/7] dma: skip calling no-op sync ops when possible
Date: Tue, 23 Apr 2024 15:58:25 +0200
Message-ID: <20240423135832.2271696-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series grew from Eric's idea and patch at [0]. The idea of using the
shortcut for direct DMA as well belongs to Chris.

When an architecture doesn't need DMA synchronization and the buffer is
not an SWIOTLB buffer, most of times the kernel and the drivers end up
calling DMA sync operations for nothing.
Even when DMA is direct, this involves a good non-inline call ladder and
eats a bunch of CPU time. With IOMMU, this results in calling indirect
calls on hotpath just to check what is already known and return.
XSk is been using a custom shortcut for that for quite some time.
I recently wanted to introduce a similar one for Page Pool. Let's combine
all this into one generic shortcut, which would cover all DMA sync ops
and all types of DMA (direct, IOMMU, ...).

* #1 adds stub inlines to be able to compile DMA sync ops out when not
     needed.
* #2 adds generic shortcut and enables it for direct DMA.
* #3 adds ability to skip DMA syncs behind an IOMMU.
* #4-5 are just cleanups for Page Pool to avoid merge conflicts in future.
* #6 checks for the shortcut as early as possible in the Page Pool code to
     make sure no cycles wasted.
* #7 replaces XSk's shortcut with the generic one.

On 100G NIC, the result is +3-5% for direct DMA and +10-11% for IOMMU.
As a bonus, XSk core now allows batched buffer allocations for IOMMU
setups.
If the shortcut is not available on some system, there should be no
visible performance regressions.

[0] https://lore.kernel.org/netdev/20221115182841.2640176-1-edumazet@google.com

Alexander Lobakin (7):
  dma: compile-out DMA sync op calls when not used
  dma: avoid redundant calls for sync operations
  iommu/dma: avoid expensive indirect calls for sync operations
  page_pool: make sure frag API fields don't span between cachelines
  page_pool: don't use driver-set flags field directly
  page_pool: check for DMA sync shortcut earlier
  xsk: use generic DMA sync shortcut instead of a custom one

 kernel/dma/Kconfig                            |   5 +
 include/net/page_pool/types.h                 |  25 ++++-
 include/linux/device.h                        |   4 +
 include/linux/dma-map-ops.h                   |  12 ++
 include/linux/dma-mapping.h                   | 105 +++++++++++++-----
 include/net/xdp_sock_drv.h                    |   7 +-
 include/net/xsk_buff_pool.h                   |  14 +--
 drivers/iommu/dma-iommu.c                     |   3 +-
 drivers/net/ethernet/engleder/tsnep_main.c    |   2 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-xsk.c  |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    |   2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |   2 +-
 drivers/net/ethernet/intel/igc/igc_main.c     |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |   2 +-
 .../ethernet/mellanox/mlx5/core/en/xsk/rx.c   |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   2 +-
 drivers/net/ethernet/netronome/nfp/nfd3/xsk.c |   2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   2 +-
 kernel/dma/mapping.c                          |  69 +++++++++---
 kernel/dma/swiotlb.c                          |   6 +
 net/core/page_pool.c                          |  76 ++++++++-----
 net/xdp/xsk_buff_pool.c                       |  28 +----
 22 files changed, 243 insertions(+), 133 deletions(-)

---
From v3[1]:
* #1:
  * don't prefix DMA sync ops with '__', just define them as empty inlines
    when !DMA_NEED_SYNC (Chris, Robin);
  * always select DMA_NEED_SYNC when DMA_API_DEBUG (^);
* #2:
  * don't use BIT(), keep the style consistent (^);
  * check for dma_map_ops::sync_sg_*() in dma_setup_need_sync() (^);
  * don't reset the flag in swiotlb_alloc() as it's not streaming API (^);
  * instead of 'dma_skip_sync', name the flag 'dma_need_sync' and inverse
    the logic (^);
  * setup the shortcut in dma_set_mask() (assuming every driver using DMA
    must call it on probe) (^);
  * combine dma_direct() and (ops->flags & CAN_SKIP_SYNC) checks (Robin);
* #3:
  - pick Acked-by (Robin).

From v2[2]:
* #1:
  * use two tabs for indenting multi-line function prototypes (Chris);
* #2:
  * make shortcut clearing function generic and move it out of the
    SWIOTLB code (Chris);
  * remove dma_set_skip_sync(): use direct assignment during the initial
    setup, not used anywhere else (Chris);
  * commitmsg: remove "NIC" and the workaround paragraph (Chris).

From v1[3]:
* #1:
  * use static inlines instead of macros (Chris);
  * move CONFIG_DMA_NEED_SYNC check into dma_skip_sync() (Robin);
* #2:
  * use a new dma_map_ops flag instead of new callback, assume the same
    conditions as for direct DMA are enough (Petr, Robin);
  * add more code comments to make sure the whole idea and path are
    clear (Petr, Robin, Chris);
* #2, #3: correct the Git tags and the authorship a bit.

Not addressed in v2:
* #1:
  * dma_sync_*range_*() are still wrapped, as some subsystems may want
    to call the underscored versions directly (e.g. Page Pool);
* #2:
  * the new dev->dma_skip_sync bit is still preferred over checking for
    READ_ONCE(dev->dma_uses_io_tlb) + dev_is_dma_coherent() on hotpath
    as a faster solution.

[1] https://lore.kernel.org/netdev/20240214162201.4168778-1-aleksander.lobakin@intel.com
[2] https://lore.kernel.org/netdev/20240205110426.764393-1-aleksander.lobakin@intel.com
[3] https://lore.kernel.org/netdev/20240126135456.704351-1-aleksander.lobakin@intel.com
-- 
2.44.0


