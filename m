Return-Path: <bpf+bounces-28798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D829E8BE0E0
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 13:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED0F288AF6
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 11:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121C2152511;
	Tue,  7 May 2024 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gNnOOk4O"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD9E1509A6;
	Tue,  7 May 2024 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715080869; cv=none; b=IW3ro6VkkZLgw4t0lXNnFInIynjyDSx6C6zL0aC0v6wFxsF4wId23GplF/sstJ0/Q4o7Ch4KG9oIxpctn8L+UznyaQU4cR5+Vw7ks7yqHg9vdPb1QOnZaDk5DeCOB3tpyUYo6S4DwFlcI0yGbIhybE/DehknxgsgcMxBUKeNqHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715080869; c=relaxed/simple;
	bh=pPjOmoGB1bP3KCmhZNkK82WrHmeex0b7tnniXY6txY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=exjJ+hkgbaO7+7ja9G6gHDCPKyJORrwiKo1fWp1Fsui+dwEQv9gGIqIBS7HCnRr65cB1IhthNoOFGQPTHe4iNEhkZ3uK/CjpuBnHqupEDU0cDCi5w6u5dTZy+m7PSx+13JwrU9xBY2svnQXskhQmgc19IkHCR0wozdsyFI591uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gNnOOk4O; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715080867; x=1746616867;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pPjOmoGB1bP3KCmhZNkK82WrHmeex0b7tnniXY6txY4=;
  b=gNnOOk4OTAt2mQhFRvzA693a2PlKcxgOgGxMoZ7P7zvByaJsXibY1D4O
   tPHdun4gOvNMOaq/acLdFm04/vHbvaZiVfoJJrqjR6bsHpZ1J+NBA74rB
   AivCcHFdb+CJ7xQ1RRMYq9PTYFejfTJxFVR5gj2w59UspkZiQ48TzxTgq
   mDuQi+VgzNHZLGNEBr3EYKZNUUyPMpeG7RglaLaGXZSf3iC6AvyjW/1gY
   biFaiIM13EEkGbZBwX3WUklvOJC13zGeDskzfWFQE+qEcd9wU2VdVpOsU
   uDYsdAlpKbn9GHXcJbchCBpGMTE2bIxbjkeMmLLxsU7uQLpIWMpMPCbXs
   Q==;
X-CSE-ConnectionGUID: xkmsKLI2ROmOLsF8WRwqgQ==
X-CSE-MsgGUID: Mgi5XGTvTniCDV4Z4visWw==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="21472522"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="21472522"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 04:21:05 -0700
X-CSE-ConnectionGUID: YFPpVIZsROShO9PX7/STfg==
X-CSE-MsgGUID: fK6ZTZ8GRpSN2Y+Ulq9Agw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="33316303"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 07 May 2024 04:21:02 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
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
Subject: [PATCH v6 0/7] dma: skip calling no-op sync ops when possible
Date: Tue,  7 May 2024 13:20:19 +0200
Message-ID: <20240507112026.1803778-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.0
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
 net/core/page_pool.c                          |  78 ++++++++-----
 net/xdp/xsk_buff_pool.c                       |  29 +----
 22 files changed, 246 insertions(+), 133 deletions(-)

---
From v5[1]:
* rebase on top of dma-mapping/for-next;
* #6: fix compilation with !HAS_DMA;
* #7: fix nullptr deref in non-zerocopy mode.

From v4[2]:
* #6:
  * rebase on top of the latest net-next;
  * fix Page Pool compilation errors when !DMA_NEED_SYNC.

From v3[3]:
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

From v2[4]:
* #1:
  * use two tabs for indenting multi-line function prototypes (Chris);
* #2:
  * make shortcut clearing function generic and move it out of the
    SWIOTLB code (Chris);
  * remove dma_set_skip_sync(): use direct assignment during the initial
    setup, not used anywhere else (Chris);
  * commitmsg: remove "NIC" and the workaround paragraph (Chris).

From v1[5]:
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

[1] https://lore.kernel.org/netdev/20240506094855.12944-1-aleksander.lobakin@intel.com
[2] https://lore.kernel.org/netdev/20240423135832.2271696-1-aleksander.lobakin@intel.com
[3] https://lore.kernel.org/netdev/20240214162201.4168778-1-aleksander.lobakin@intel.com
[4] https://lore.kernel.org/netdev/20240205110426.764393-1-aleksander.lobakin@intel.com
[5] https://lore.kernel.org/netdev/20240126135456.704351-1-aleksander.lobakin@intel.com
-- 
2.45.0


