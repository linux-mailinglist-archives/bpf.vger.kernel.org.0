Return-Path: <bpf+bounces-21208-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58467849863
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 12:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF8A1C21205
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 11:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446A51B295;
	Mon,  5 Feb 2024 11:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="maTViyZH"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8221E1B7F6;
	Mon,  5 Feb 2024 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707131126; cv=none; b=khG+ZKnaBhdLoUiW1hXYDuEexZCO9qFAMv2NMtAYvOlNyAfhp704Gg67zuq6ZQ0Iv9WXNt6UnGiO2vxUj4098PaKfS8/I6qa+dhAvHsBGzU/Nq6hzET0q9VOs3a+lQXuEQUJb04K8j6HHv7TVNcEiQzFlfwAyxItKT9sQo1abaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707131126; c=relaxed/simple;
	bh=vQ9pXrWvroiooYs41SwiRJil8dTyqvM8/gTLYDeQYJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSUYgWjVyhvvbxJA9CJiFDhP2dAR04PsM1QrPaBHCdpflZ54Bg/HGNDLU/xcthBwU8W7gSZkBABKetc9B9qs04wHo0sRxuYrRwVIbxzXVsXvlc+FWaVfp1JRL9wrAq2g9Waq2njQzSXhElqiJzpB9Sw8kqHAjqa8AMIKgPC9ZHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=maTViyZH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707131124; x=1738667124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vQ9pXrWvroiooYs41SwiRJil8dTyqvM8/gTLYDeQYJU=;
  b=maTViyZHIn0zQ3rqhi6Ur7JpQFkWl+HvKBmLCKtmOg/IfPqzAHC5oV3Z
   Tm/6T2L0evXKH9iXVtjxo5vxdKAWM/BhJfSZsaNHdflcRQYBO7ov1uzPe
   6JdoxBaC0ib4rZGq4tLF4ws6ZJYM/1EEtrVMAQh/DEpC5SJxUTZlZZZi8
   c9uW1GXdNq0hh9/r/AZd9AKd9XZGiJbEspNM2A3H34Pu+175MpDtxcydT
   j4pLS1jmAq6clp2aU5rJuGljKZrYtL/MhXc1l3MmRD+1HbGmpo7dQGnoH
   vEu8Odgd53Ht0w87wsalv+1RzPhUwFs3B2FiDAfmxN4pEbpZvAqxh+ZUm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="25945400"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="25945400"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 03:05:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5328252"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa004.fm.intel.com with ESMTP; 05 Feb 2024 03:05:20 -0800
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
Subject: [PATCH net-next v2 4/7] page_pool: make sure frag API fields don't span between cachelines
Date: Mon,  5 Feb 2024 12:04:23 +0100
Message-ID: <20240205110426.764393-5-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205110426.764393-1-aleksander.lobakin@intel.com>
References: <20240205110426.764393-1-aleksander.lobakin@intel.com>
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
 net/core/page_pool.c          |  9 +++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 76481c465375..217e73b7e4fc 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -128,12 +128,22 @@ struct page_pool_stats {
 struct page_pool {
 	struct page_pool_params_fast p;
 
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
index 4933762e5a6b..be1219816990 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -170,11 +170,20 @@ static void page_pool_producer_unlock(struct page_pool *pool,
 		spin_unlock_bh(&pool->ring.producer_lock);
 }
 
+static void page_pool_struct_check(void)
+{
+	CACHELINE_ASSERT_GROUP_MEMBER(struct page_pool, frag, frag_users);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct page_pool, frag, frag_page);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct page_pool, frag, frag_offset);
+}
+
 static int page_pool_init(struct page_pool *pool,
 			  const struct page_pool_params *params)
 {
 	unsigned int ring_qsize = 1024; /* Default */
 
+	page_pool_struct_check();
+
 	memcpy(&pool->p, &params->fast, sizeof(pool->p));
 	memcpy(&pool->slow, &params->slow, sizeof(pool->slow));
 
-- 
2.43.0


