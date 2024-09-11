Return-Path: <bpf+bounces-39648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E29F4975AAF
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 21:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C7131F23F20
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 19:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1907E1B9B31;
	Wed, 11 Sep 2024 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ACZD5c4g"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40CC1B1D53;
	Wed, 11 Sep 2024 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726081839; cv=none; b=lNQLoOywJbexuCNkl0RjkehAiAXOJwWUfO/3SsgzN2jNe950d4Mohf2Gc2YxSyMogIs86hCPPm5ALLGN+t9MLVIJx9HDatzp+tVzealN/Kw5EmkUiaWduLp5uBXS0MGREPsaj7E6v81+FEUCE6Ey+obFEdb8yhYdmDyT7gkMYes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726081839; c=relaxed/simple;
	bh=YCEkIT51TrwK0bh4JcelDLbH3S0yP7B5W1Pld/8KeDc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I0fcdgB8yPv9xga+wNOwuDUlQcwZvu/kUybzzNMAF47FYK+/MR4m/pHynGllzb+QPiXIrkVNZUad7H09Lmv2bblxX1v94fH5Pi9OqKlztXo39EaqOq6u73Rt9j/VxxPwuRd2Ym0HOiARJpC+4+tyM7O6VU+gK+ZA27KzofzFYp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ACZD5c4g; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726081838; x=1757617838;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YCEkIT51TrwK0bh4JcelDLbH3S0yP7B5W1Pld/8KeDc=;
  b=ACZD5c4gwE8m0VJ4RSwFxW12Bv5qWvHaouPUwre0+rjnFjoIXHMt2P4U
   o3IAp5FFVMNNCLAfFS80mySRh++Z58byIj8uTk7Oi99g8btSkLnOS3PdS
   S4yCw8an6c1WkXYeZzKh15rpm/myHvJvxxp7Gkz5zjQz84VVY/40bS8e9
   OJKr0k3XiscW559B2OGj5gUMuPQd0Um35REQ2Vjwgkxb1uR9xpAMXIooz
   7smKr730nGyvY1yMIBxt88VXjr9ErK5H0jR+wJd7ZwYdDM9ovrPkFg/4t
   Qp2a9Fv+/O+fueF2T1venYvunVSpNRplVlxJ+QteiozhYU37rkA1SImJ8
   g==;
X-CSE-ConnectionGUID: avWY3cdnSneDLC0guMyIoQ==
X-CSE-MsgGUID: mXgL5I7oT2Cl79LVimlyrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="24773025"
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="24773025"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 12:10:37 -0700
X-CSE-ConnectionGUID: vRyB7MSKS+K412gVwohLrA==
X-CSE-MsgGUID: cRtcR8yITii3Vdkdv2iisQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="67765470"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa006.jf.intel.com with ESMTP; 11 Sep 2024 12:10:34 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com,
	Dries De Winter <ddewinter@synamedia.com>
Subject: [PATCH bpf] xsk: fix batch alloc API on non-coherent systems
Date: Wed, 11 Sep 2024 21:10:19 +0200
Message-Id: <20240911191019.296480-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cases when synchronizing DMA operations is necessary,
xsk_buff_alloc_batch() returns a single buffer instead of the requested
count. This puts the pressure on drivers that use batch API as they have
to check for this corner case on their side and take care of allocations
by themselves, which feels counter productive. Let us improve the core
by looping over xp_alloc() @max times when slow path needs to be taken.

Another issue with current interface, as spotted and fixed by Dries, was
that when driver called xsk_buff_alloc_batch() with @max == 0, for slow
path case it still allocated and returned a single buffer, which should
not happen. By introducing the logic from first paragraph we kill two
birds with one stone and address this problem as well.

Fixes: 47e4075df300 ("xsk: Batched buffer allocation for the pool")
Reported-and-tested-by: Dries De Winter <ddewinter@synamedia.com>
Co-developed-by: Dries De Winter <ddewinter@synamedia.com>
Signed-off-by: Dries De Winter <ddewinter@synamedia.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xsk_buff_pool.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 29afa880ffa0..5e2e03042ef3 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -623,20 +623,31 @@ static u32 xp_alloc_reused(struct xsk_buff_pool *pool, struct xdp_buff **xdp, u3
 	return nb_entries;
 }
 
-u32 xp_alloc_batch(struct xsk_buff_pool *pool, struct xdp_buff **xdp, u32 max)
+static u32 xp_alloc_slow(struct xsk_buff_pool *pool, struct xdp_buff **xdp,
+			 u32 max)
 {
-	u32 nb_entries1 = 0, nb_entries2;
+	int i;
 
-	if (unlikely(pool->dev && dma_dev_need_sync(pool->dev))) {
+	for (i = 0; i < max; i++) {
 		struct xdp_buff *buff;
 
-		/* Slow path */
 		buff = xp_alloc(pool);
-		if (buff)
-			*xdp = buff;
-		return !!buff;
+		if (unlikely(!buff))
+			return i;
+		*xdp = buff;
+		xdp++;
 	}
 
+	return max;
+}
+
+u32 xp_alloc_batch(struct xsk_buff_pool *pool, struct xdp_buff **xdp, u32 max)
+{
+	u32 nb_entries1 = 0, nb_entries2;
+
+	if (unlikely(pool->dev && dma_dev_need_sync(pool->dev)))
+		return xp_alloc_slow(pool, xdp, max);
+
 	if (unlikely(pool->free_list_cnt)) {
 		nb_entries1 = xp_alloc_reused(pool, xdp, max);
 		if (nb_entries1 == max)
-- 
2.34.1


