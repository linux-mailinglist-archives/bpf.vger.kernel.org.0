Return-Path: <bpf+bounces-20390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2D183DB39
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 14:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA599291154
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 13:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6341B96F;
	Fri, 26 Jan 2024 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GgwJmQ2g"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE99D1B955;
	Fri, 26 Jan 2024 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706277355; cv=none; b=nrFgEUXjSmc5gCSbJGzllf2ylhd6yECDLuP4SapIYJhon+JZ+/EOnPjU7aF5uHQHewB8r/F60lRFBlYgPbedJNFpFAHZxAmQ4asvRAnGt0AMBeUOPoWgRpzS5w9UcTOytQATcCZMC7h4b1so3VoLCiSYNX3pOiTRmIOULMRGZqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706277355; c=relaxed/simple;
	bh=imVjlmmk3YaSrnGHNgfVdxJTZcpjli9usBMpCEom9t8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AHFPjEO0nujdGmjuy76JkD85ZjKjMu479ahW+kODmePv4hcXJcEuX/bu9Etoq4IKV0rUrKoQhYM4EegqO4yhwdiIIeRlWY6NNKsa+DS1jQEfDBtsDu/t6oAapmAbn0D6edgPqI5ualuTeQEsvXI/XOUDnhvfoFiKjgrM1IOy8lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GgwJmQ2g; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706277354; x=1737813354;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=imVjlmmk3YaSrnGHNgfVdxJTZcpjli9usBMpCEom9t8=;
  b=GgwJmQ2ge/TptGQGtLvgssofIs7/MImcTQj7eqOaaiGMmYPRUeyYSOGY
   7vtpIjTWsFxzRwAcvmrRm2sMKARTio1iRt6Ut/53hwSl5HanlGkpmSiJJ
   Q+s6suqqk2XJkLjIOWBSvwy9kjqR3MZ2qpjQ5p6Hy/uWLPltHSkesWiWE
   efojdEUvt8KZJ736OGRXl8A1PvH2ftuZ8B94dBosk5/6gKvwEK4apvebf
   l0QOaJE2vBXIar/HpG8Zi64FcagKGVfoIcKTb1uYmuLTe8J5kSeyW5tC4
   ZJ7rUYX8ZgH4GcVOJbNoRBuFm6XG81+LtEMz6aiiPpgFZDsykUksXd7RN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15998390"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15998390"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 05:55:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="821142817"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="821142817"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2024 05:55:47 -0800
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/7] dma: skip calling no-op sync ops when possible
Date: Fri, 26 Jan 2024 14:54:49 +0100
Message-ID: <20240126135456.704351-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
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

* #1 adds stub inlines to be able to skip DMA sync ops or even compile
     them out when not needed.
* #2 adds the generic shortcut and enables it for direct DMA.
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

Alexander Lobakin (5):
  dma: compile-out DMA sync op calls when not used
  page_pool: make sure frag API fields don't span between cachelines
  page_pool: don't use driver-set flags field directly
  page_pool: check for DMA sync shortcut earlier
  xsk: use generic DMA sync shortcut instead of a custom one

Eric Dumazet (2):
  dma: avoid expensive redundant calls for sync operations
  iommu/dma: avoid expensive indirect calls for sync operations

 kernel/dma/Kconfig                            |   4 +
 include/net/page_pool/types.h                 |  21 +++-
 include/linux/device.h                        |   5 +
 include/linux/dma-map-ops.h                   |  17 +++
 include/linux/dma-mapping.h                   | 100 +++++++++++++-----
 include/net/xdp_sock_drv.h                    |   7 +-
 include/net/xsk_buff_pool.h                   |  13 +--
 drivers/base/dd.c                             |   2 +
 drivers/iommu/dma-iommu.c                     |   1 +
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
 kernel/dma/mapping.c                          |  60 ++++++++---
 kernel/dma/swiotlb.c                          |  14 +++
 net/core/page_pool.c                          |  67 +++++++-----
 net/xdp/xsk_buff_pool.c                       |  29 +----
 23 files changed, 237 insertions(+), 125 deletions(-)

-- 
2.43.0


