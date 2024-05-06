Return-Path: <bpf+bounces-28663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D718BCB1B
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 11:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D691C21AC4
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 09:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CEF143C56;
	Mon,  6 May 2024 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XfRhX7UJ"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5473F143C40;
	Mon,  6 May 2024 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988975; cv=none; b=NP4TVfJNmdJzoJkCXp/o+zIKjryBRKOyTSJzxIgiEaP5ZNjpubUcXdYJsELyQFucMrMHvY0tBXXhCy1xNTPAkhIglC8RVIgsS3abFxB1Ps37mtzH1BieHjbMnBaDuOgEDHWaMpKrdioOYlnHr+8QHDefEV1cCVw85rn7OjVbMg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988975; c=relaxed/simple;
	bh=qar2zFEKb/MOsVrtJ0OruVspt0FTntp7o0D0HK+wH50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUDeiHSXCFIz8dT/dGDWzP49KbTO1Rb5iDCy/3vy6zLzSnMOmGciHizrwRxaLCZwfalBYSUlw6tT5m6bj59VTBVqmgCBBkVppHsEMsbPZeNPAa2EPsUzt11uD+9pltSQOT9gWTqMh/f05sZTIBMzEuqpGH7S9D3WHVt7NDdxp+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XfRhX7UJ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714988973; x=1746524973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qar2zFEKb/MOsVrtJ0OruVspt0FTntp7o0D0HK+wH50=;
  b=XfRhX7UJyPTSyPHaOPace5lQo/I/AaS2rQZHM25IJ2vTBSrzV1VqwauK
   lf/7GDDc8K/1UJ946WWMG249/8o09U9X+YOrnbDi2KrZTPCJFr2ZCZokV
   kzOAY6s6ddANGxK2EA18Cpo3+M/QS6eOBD0vDS6QI6n3xGJ/gOzRH25A5
   4pfVI+Ag6GgVbwKsAT+FLnBTZm3jq8nJiBHsGYNRQxHx0zy+fHTHQQp+a
   f5IOtw6rlLpxUkFBjmJwQYdEjLFM/9H9nmqj8lQoSmti41yf3XnzTj9+P
   O0MLavj7ZUJHHk47ar7lXbz7h7tpdQUr/783zheRSUfKV9XnmUaWaAMSe
   A==;
X-CSE-ConnectionGUID: aT8zcx/hQmuC16c0hM6jgA==
X-CSE-MsgGUID: rRtsyZ4RRomhSKEENHDwFQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="28201009"
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="28201009"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 02:49:33 -0700
X-CSE-ConnectionGUID: d/T/sPMaR9+PBabI+LBQbQ==
X-CSE-MsgGUID: EKWL4siSQjeWp1b971fA4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,258,1708416000"; 
   d="scan'208";a="58995733"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 06 May 2024 02:49:29 -0700
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
Subject: [PATCH net-next v5 4/7] page_pool: make sure frag API fields don't span between cachelines
Date: Mon,  6 May 2024 11:48:52 +0200
Message-ID: <20240506094855.12944-5-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506094855.12944-1-aleksander.lobakin@intel.com>
References: <20240506094855.12944-1-aleksander.lobakin@intel.com>
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
index 8bcc7014a61a..ecf10f9850c2 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -173,12 +173,22 @@ static void page_pool_producer_unlock(struct page_pool *pool,
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
2.45.0


