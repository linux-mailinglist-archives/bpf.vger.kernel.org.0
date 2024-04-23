Return-Path: <bpf+bounces-27548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59C78AE8E3
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 16:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C6C1C21447
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 14:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5484813BC3A;
	Tue, 23 Apr 2024 13:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UzpgiwFF"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D68E13BAF4;
	Tue, 23 Apr 2024 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880756; cv=none; b=Nu7BfQNTUrSKlr8Rof45XGAt2/3Fw6pM+OFrHQeWqTJ314E2+XvGgOgVW3p9fPl8iq2Lgg8ditjDHP8AqpFrbTzJDM8idH+0lESxZxr1khKD/+CdavJpUcbY+mpXGUcvcAOvotol8SXP5PDmnt3yNndQIU/c5NtbZ7URvwTdSeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880756; c=relaxed/simple;
	bh=KxZwLxsdXCEO5MnMIk60nerc4SMVtekAOt2JOpxEhbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slxy78qsxE6A4/ucbfg1+QYuWal9SFoimQnqnekSQLHml62QJSXaYJOHNTlNsMR1XWSwXz1LH73wcIq0IwAsnNKY6d6AX2NmOwTWJ25TPxDt2FEt5e2XSj1pq/8OSW2fMHBYvGnbfb5PvQxt1fzHZroB1S9iZlwZYFa3gpQLZ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UzpgiwFF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713880756; x=1745416756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KxZwLxsdXCEO5MnMIk60nerc4SMVtekAOt2JOpxEhbc=;
  b=UzpgiwFFeCdzXH0oRZNyI/2/6DE+s82SAmPINln9tVbEW8rI1lH257Pk
   cLf8lCkHosS22JfX5R9+MmwWHHHNHoCnXXWMKq++GY7mmYz1TvhTo8xZf
   Gz3OO9F9RFG7gFQ+tMa6JcRzZLoZzq99DpAOrV/6TfaIkxlfQgEGo4m6l
   7NqUShrOBn5z4GywEA0kbTsGfXF/lbMFpLkD/d+0+NOGr8jVIkrjDaO7t
   Go5A67WvyJ0dP+Om1HAtUaIhbBc0rs1zXm9WhlzKTsBPoKDqxa5hgKgxR
   GkQFMj0vGpG4Y3towNGgw+mHhUL6XP1uPNtDU0UZ4+TVC8ctHTnL1CkXo
   w==;
X-CSE-ConnectionGUID: RHDT5Sx4TPeX/gJKsdMrbg==
X-CSE-MsgGUID: qR1C1lW/TmKsEfZtvH8dhA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="26921500"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="26921500"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:59:06 -0700
X-CSE-ConnectionGUID: x1Mx214cT7eZ9iqrw9JL8g==
X-CSE-MsgGUID: lr3UkwE+Qhm5Xy4/cXCwyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24431840"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa008.fm.intel.com with ESMTP; 23 Apr 2024 06:59:02 -0700
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
Subject: [PATCH net-next v4 4/7] page_pool: make sure frag API fields don't span between cachelines
Date: Tue, 23 Apr 2024 15:58:29 +0200
Message-ID: <20240423135832.2271696-5-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423135832.2271696-1-aleksander.lobakin@intel.com>
References: <20240423135832.2271696-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 5027ec19f104 ("net: page_pool: split the page_pool_params
into fast and slow") that made &page_pool contain only "hot" params at
the start, cacheline boundary chops frag API fields group in the middle
again.
To not bother with this each time fast params get expanded or shrunk,
let's just align them to `4 * sizeof(long)`, the closest upper pow-2 to
their actual size (2 longs + 1 int). This ensures 16-byte alignment for
the 32-bit architectures and 32-byte alignment for the 64-bit ones,
excluding unnecessary false-sharing.
::page_state_hold_cnt is used quite intensively on hotpath no matter if
frag API is used, so move it to the newly created hole in the first
cacheline.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/types.h | 12 +++++++++++-
 net/core/page_pool.c          | 10 ++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index a6ebed002216..548321f7c49d 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -130,12 +130,22 @@ struct page_pool {
 	struct page_pool_params_fast p;
 
 	int cpuid;
+	u32 pages_state_hold_cnt;
 	bool has_init_callback;
 
+	/* The following block must stay within one cacheline. On 32-bit
+	 * systems, sizeof(long) == sizeof(int), so that the block size is
+	 * ``3 * sizeof(long)``. On 64-bit systems, the actual size is
+	 * ``2 * sizeof(long) + sizeof(int)``. The closest pow-2 to both of
+	 * them is ``4 * sizeof(long)``, so just use that one for simplicity.
+	 * Having it aligned to a cacheline boundary may be excessive and
+	 * doesn't bring any good.
+	 */
+	__cacheline_group_begin(frag) __aligned(4 * sizeof(long));
 	long frag_users;
 	struct page *frag_page;
 	unsigned int frag_offset;
-	u32 pages_state_hold_cnt;
+	__cacheline_group_end(frag);
 
 	struct delayed_work release_dw;
 	void (*disconnect)(void *pool);
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 273c24429bce..35c9d61853c8 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -172,12 +172,22 @@ static void page_pool_producer_unlock(struct page_pool *pool,
 		spin_unlock_bh(&pool->ring.producer_lock);
 }
 
+static void page_pool_struct_check(void)
+{
+	CACHELINE_ASSERT_GROUP_MEMBER(struct page_pool, frag, frag_users);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct page_pool, frag, frag_page);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct page_pool, frag, frag_offset);
+	CACHELINE_ASSERT_GROUP_SIZE(struct page_pool, frag, 4 * sizeof(long));
+}
+
 static int page_pool_init(struct page_pool *pool,
 			  const struct page_pool_params *params,
 			  int cpuid)
 {
 	unsigned int ring_qsize = 1024; /* Default */
 
+	page_pool_struct_check();
+
 	memcpy(&pool->p, &params->fast, sizeof(pool->p));
 	memcpy(&pool->slow, &params->slow, sizeof(pool->slow));
 
-- 
2.44.0


