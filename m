Return-Path: <bpf+bounces-45458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2219D5E4A
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 12:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3833B1F22B1D
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 11:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E019C1DED6D;
	Fri, 22 Nov 2024 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fBhS4Exb"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9BB17E00E;
	Fri, 22 Nov 2024 11:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732275636; cv=none; b=QJXbFs6Opt/d4cV/KMbUVLc2//RrF2eyVznJN4u4V+2hli/2Esta6t1cuWxYQsWgNIQM1P35g9CaVcH9z+6x3YlIwDZZVLFaa9W1JS/rZagL7h7FQMQiZgLaQyazi+/s+tI0OL3gAu697hoU1Z/JZIlsaEBTCfSh38lQjU/P/Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732275636; c=relaxed/simple;
	bh=i6CLV1FXRfEQmnP0bc/FJIlv39wNpE+G83O2FsKArr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HK9ECLexx0krmJdZPxCjfajjVouWbK1QgriHcK2cK8Vi9r7DYM8So86mB4RnshTsj2fymxJ/U8lKLLHefIciAyV8Z7BRluQjHRizBlV4UgtwEL5ffjl6awO8hPMbOch8VR82rGdwuWppg1G4GL8hDWOxzMnzqulR0atIaIfh5yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fBhS4Exb; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732275631; x=1763811631;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i6CLV1FXRfEQmnP0bc/FJIlv39wNpE+G83O2FsKArr0=;
  b=fBhS4Exb5g2Vc+2vZ7VOgeNuDThW9YvyBkhOAoxtRkEHCUypbVWzWUsJ
   jlrIHE32ksSfP6KyFiWsnmq4WGlCw9CR8kmXL4Nv2WtH7iqgIhe105osP
   7Xez3W7hDqE0Q5jCos2xAZPx3hoAPKv3UKZ0Vpd6poi4VV7CJA+Zx1PQ5
   B/uEn98dORLLyrWYpSoVxFkzPDrY6hFjOmcLPIdaKzDeOaeRAU5xzLXRM
   7zQtNDpWD3CDOGpYKQm1krBlVInCL6CjedtbuTZn12LXnmgZOlF2RrLMt
   dB+9WUCC7dVoeCs58pViItWQK3HjgP6iLNRUezSeDLG4+NY4+dvLZE9JL
   Q==;
X-CSE-ConnectionGUID: XQo6tbalTW6xvIyI8skeTQ==
X-CSE-MsgGUID: bShtfSmfTwWoUvI/Izb+UQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="31783571"
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="31783571"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 03:40:30 -0800
X-CSE-ConnectionGUID: +DIRouKGQyG4razPmurnuw==
X-CSE-MsgGUID: RVWYirEYQtKOFB+YzOf+PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,175,1728975600"; 
   d="scan'208";a="121511166"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 22 Nov 2024 03:40:27 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id DA89228778;
	Fri, 22 Nov 2024 11:40:24 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alasdair McWilliam <alasdair.mcwilliam@outlook.com>
Subject: [PATCH bpf] xsk: always clear DMA mapping information when unmapping the pool
Date: Fri, 22 Nov 2024 12:29:09 +0100
Message-ID: <20241122112912.89881-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the umem is shared, the DMA mapping is also shared between the xsk
pools, therefore it should stay valid as long as at least 1 user remains.
However, the pool also keeps the copies of DMA-related information that are
initialized in the same way in xp_init_dma_info(), but cleared by
xp_dma_unmap() only for the last remaining pool, this causes the problems
below.

The first one is that the commit adbf5a42341f ("ice: remove af_xdp_zc_qps
bitmap") relies on pool->dev to determine the presence of a ZC pool on a
given queue, avoiding internal bookkeeping. This works perfectly fine if
the UMEM is not shared, but reliably fails otherwise as stated in the
linked report.

The second one is pool->dma_pages which is dynamically allocated and
only freed in xp_dma_unmap(), this leads to a small memory leak. kmemleak
does not catch it, but by printing the allocation results after terminating
the userspace program it is possible to see that all addresses except the
one belonging to the last detached pool are still accessible through the
kmemleak dump functionality.

Always clear the DMA mapping information from the pool and free
pool->dma_pages when unmapping the pool, so that the only difference
between results of the last remaining user's call and the ones before would
be the destruction of the DMA mapping.

Fixes: adbf5a42341f ("ice: remove af_xdp_zc_qps bitmap")
Fixes: 921b68692abb ("xsk: Enable sharing of dma mappings")
Reported-by: Alasdair McWilliam <alasdair.mcwilliam@outlook.com>
Closes: https://lore.kernel.org/PA4P194MB10056F208AF221D043F57A3D86512@PA4P194MB1005.EURP194.PROD.OUTLOOK.COM
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 net/xdp/xsk_buff_pool.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 521a2938e50a..0662d34b09ee 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -387,10 +387,9 @@ void xp_dma_unmap(struct xsk_buff_pool *pool, unsigned long attrs)
 		return;
 	}
 
-	if (!refcount_dec_and_test(&dma_map->users))
-		return;
+	if (refcount_dec_and_test(&dma_map->users))
+		__xp_dma_unmap(dma_map, attrs);
 
-	__xp_dma_unmap(dma_map, attrs);
 	kvfree(pool->dma_pages);
 	pool->dma_pages = NULL;
 	pool->dma_pages_cnt = 0;
-- 
2.43.0


