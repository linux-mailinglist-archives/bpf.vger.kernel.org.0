Return-Path: <bpf+bounces-38900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FF296C41F
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 18:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D696280F13
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 16:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E0A1E00A0;
	Wed,  4 Sep 2024 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S8HgVlYj"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A461DFE14;
	Wed,  4 Sep 2024 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725467296; cv=none; b=lL4TyyhZYHZ7vPGb1pJA5J34PJ040zjE2gb64W7DK9QMe4/5+p8MJ/HjIR3tKCieTd73jjKcKhv+3bSYUBi/GvrolcYeFf8eSnXapBX+Y9uTXVE/qVdcUAEovghqkV2ChrjbSnSmPvjbAcev2IPpK3tjMUZfPe8wrysP57Ssd1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725467296; c=relaxed/simple;
	bh=/zPKFC9ohztxO9cxzrcRiMdtFGudAYQRpa9VnD8p1qc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fS6ZD6QoYisz8qWxELMATzglFVVV+vcqWPtTG8OfLzqWctV7znGjc3vNtRjW/5EWUHzdd6lxEL8GcET2v56yY/t5fFivyLIaRgSrsUC6KNrqT8YKdfgKppCNlkm/fJLEvr01uAXqNlvs4ZHEcQjGexPL/rTnuuFiNVVNQslB/VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S8HgVlYj; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725467295; x=1757003295;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/zPKFC9ohztxO9cxzrcRiMdtFGudAYQRpa9VnD8p1qc=;
  b=S8HgVlYjWSZY3HptTFSjHv6DYuIiYP/6WBaLWDwwremYa98KIrMSaUxx
   fivxgwGtfMMa5hW9Jo6xGUY64Xnsc191od0G++nlRmL/YYWmu4jaxBvJb
   2YYNg72Nywmlvlb8+Zh9wWX7wk76Q3/gfC5s4Doh8kojt146xPjiPzD8Y
   2jsofFoFbiZESsv1zWrSNyAw98kwmpxMTt5ZmF5rX3jdOfFK9HquWEbTW
   8vcLtN6JNjh7WqOVbZj9+gti0qfm7SOph2avhSbvp+sK4nP0U4JfyjzOI
   F2C7gEZOQSfIXZQYRP+y1D2YO2eN4TvDqjpQjynampvVKN3zVbGUwKySJ
   A==;
X-CSE-ConnectionGUID: SLK7lzT+QSumC5YuckI8ug==
X-CSE-MsgGUID: Qr08bKpRScScdOZqXyK+dA==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="46671816"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="46671816"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 09:28:14 -0700
X-CSE-ConnectionGUID: 53qIhRaHSZuyRBdxaVB/6w==
X-CSE-MsgGUID: L+nh0pMZQga/K6YJBqIITg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="70118492"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 04 Sep 2024 09:28:11 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	maciej.fijalkowski@intel.com
Subject: [PATCH bpf-next] xsk: bump xsk_queue::queue_empty_descs in xp_can_alloc()
Date: Wed,  4 Sep 2024 18:28:08 +0200
Message-Id: <20240904162808.249160-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have STAT_FILL_EMPTY test case in xskxceiver that tries to process
traffic with fill queue being empty which currently fails for zero copy
ice driver after it started to use xsk_buff_can_alloc() API. That is
because xsk_queue::queue_empty_descs is currently only increased from
alloc APIs and right now if driver sees that xsk_buff_pool will be
unable to provide the requested count of buffers, it bails out early,
skipping calls to xsk_buff_alloc{_batch}().

Mentioned statistic should be handled in xsk_buff_can_alloc() from the
very beginning, so let's add this logic now. Do it by open coding
xskq_cons_has_entries() and bumping queue_empty_descs in the middle when
fill queue currently has no entries.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 net/xdp/xsk_buff_pool.c | 11 ++++++++++-
 net/xdp/xsk_queue.h     |  5 -----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index c0e0204b9630..29afa880ffa0 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -656,9 +656,18 @@ EXPORT_SYMBOL(xp_alloc_batch);
 
 bool xp_can_alloc(struct xsk_buff_pool *pool, u32 count)
 {
+	u32 req_count, avail_count;
+
 	if (pool->free_list_cnt >= count)
 		return true;
-	return xskq_cons_has_entries(pool->fq, count - pool->free_list_cnt);
+	req_count = count - pool->free_list_cnt;
+
+	avail_count = xskq_cons_nb_entries(pool->fq, req_count);
+
+	if (!avail_count)
+		pool->fq->queue_empty_descs++;
+
+	return avail_count >= req_count;
 }
 EXPORT_SYMBOL(xp_can_alloc);
 
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 6f2d1621c992..406b20dfee8d 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -306,11 +306,6 @@ static inline u32 xskq_cons_nb_entries(struct xsk_queue *q, u32 max)
 	return entries >= max ? max : entries;
 }
 
-static inline bool xskq_cons_has_entries(struct xsk_queue *q, u32 cnt)
-{
-	return xskq_cons_nb_entries(q, cnt) >= cnt;
-}
-
 static inline bool xskq_cons_peek_addr_unchecked(struct xsk_queue *q, u64 *addr)
 {
 	if (q->cached_prod == q->cached_cons)
-- 
2.34.1


