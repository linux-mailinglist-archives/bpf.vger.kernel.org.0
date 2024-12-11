Return-Path: <bpf+bounces-46657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 383A99ED39E
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 18:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40A91884F0D
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 17:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EEC209668;
	Wed, 11 Dec 2024 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W36KrReO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC0A1FF611;
	Wed, 11 Dec 2024 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733938165; cv=none; b=AzBS7uLT5Jdf/dpHZYenU4z1KoUjsFENejnheC+DdG1pqHJBB3d/QJvd7WdhXQxx3ApJgsel1yMuR26uma+p3pvyQyWCJrlR/HacB0UjigQ5l3fm84XQe6lBOVHjDvlXyDdlh4vnkNMo6vDf2PXXm5Sg0a7n+AA3hx/OGeA/auU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733938165; c=relaxed/simple;
	bh=Mzh5PvWdAWrhD20G+Z/0QHFjHx3XB3ES4Wu24RLMMF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d31yM+MNm3/RKjIUj4mp4Vk8J9eA+tuXM+dCMlsHhmscc1pYMy2jGNmIOeCVdAfi8S90MHHJwc9zKS/5p9FzyAU1Oma7EnpksXFs9Kv+aIt0AAY+gnW34LgUq1s0OI3O3uUbToSuOXF/nEt7ol2aIIfFJcw1YF+ydJAj/bLP3y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W36KrReO; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733938164; x=1765474164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mzh5PvWdAWrhD20G+Z/0QHFjHx3XB3ES4Wu24RLMMF8=;
  b=W36KrReOsfqcDgHkYLjVyTyXEcnUBBNvdeVSE+Cns9RXLiGV1zkEWcBG
   h9r5cBx/KASHlgPRXsdXVCVCbE3U/AQPJqqAHbwgdPEbELqaiqTnFeAu+
   HOuLjm4Zt2/yGukIvo0wSjL4lSC1zYucDb5m5jwb0bVqxm6YQKCR30HVT
   /er3vafmm/4ncTQVgVog9/aEuGe3zRUoOVdNbG84V31nkjeiuvl9R2Fs0
   JAg8Y9Cc0z83jpFEl0vQf+O1aUAJNLkoB7VLTDUoiKyIWUfthA+IsPXMu
   e//dz5fENPjMNDTl9DP6+/saTJbYzbETSlYiRtB9xNyzxwSGkOMDtBtrq
   g==;
X-CSE-ConnectionGUID: VpDTzVl1SV+ESU0/loOpkA==
X-CSE-MsgGUID: BmC8msgNRcaTW0XFhi6fQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="51859655"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="51859655"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 09:29:21 -0800
X-CSE-ConnectionGUID: myHfyw3uSAOPluvrbhRfIg==
X-CSE-MsgGUID: TDOizA4FTKqhh9ve6cEVdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119122363"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa002.fm.intel.com with ESMTP; 11 Dec 2024 09:29:15 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jason Baron <jbaron@akamai.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Nathan Chancellor <nathan@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 09/12] page_pool: add a couple of netmem counterparts
Date: Wed, 11 Dec 2024 18:26:46 +0100
Message-ID: <20241211172649.761483-10-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211172649.761483-1-aleksander.lobakin@intel.com>
References: <20241211172649.761483-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the following Page Pool netmem wrappers to be able to implement
an MP-agnostic driver:

* page_pool{,_dev}_alloc_best_fit_netmem()

Same as page_pool{,_dev}_alloc(). Make the latter a wrapper around
the new helper (as a page is always a netmem, but not vice versa).
'page_pool_alloc_netmem' is already busy, hence '_best_fit' (which
also says what the helper tries to do).

* page_pool_dma_sync_for_cpu_netmem()

Same as page_pool_dma_sync_for_cpu(). Performs DMA sync only if
the netmem comes from the host.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/helpers.h | 46 ++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 26caa2c20912..d75d10678958 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -115,22 +115,22 @@ static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
 	return page_pool_alloc_frag(pool, offset, size, gfp);
 }
 
-static inline struct page *page_pool_alloc(struct page_pool *pool,
-					   unsigned int *offset,
-					   unsigned int *size, gfp_t gfp)
+static inline netmem_ref
+page_pool_alloc_best_fit_netmem(struct page_pool *pool, unsigned int *offset,
+				unsigned int *size, gfp_t gfp)
 {
 	unsigned int max_size = PAGE_SIZE << pool->p.order;
-	struct page *page;
+	netmem_ref netmem;
 
 	if ((*size << 1) > max_size) {
 		*size = max_size;
 		*offset = 0;
-		return page_pool_alloc_pages(pool, gfp);
+		return page_pool_alloc_netmem(pool, gfp);
 	}
 
-	page = page_pool_alloc_frag(pool, offset, *size, gfp);
-	if (unlikely(!page))
-		return NULL;
+	netmem = page_pool_alloc_frag_netmem(pool, offset, *size, gfp);
+	if (unlikely(!netmem))
+		return 0;
 
 	/* There is very likely not enough space for another fragment, so append
 	 * the remaining size to the current fragment to avoid truesize
@@ -141,7 +141,25 @@ static inline struct page *page_pool_alloc(struct page_pool *pool,
 		pool->frag_offset = max_size;
 	}
 
-	return page;
+	return netmem;
+}
+
+static inline netmem_ref
+page_pool_dev_alloc_best_fit_netmem(struct page_pool *pool,
+				    unsigned int *offset,
+				    unsigned int *size)
+{
+	gfp_t gfp = GFP_ATOMIC | __GFP_NOWARN;
+
+	return page_pool_alloc_best_fit_netmem(pool, offset, size, gfp);
+}
+
+static inline struct page *page_pool_alloc(struct page_pool *pool,
+					   unsigned int *offset,
+					   unsigned int *size, gfp_t gfp)
+{
+	return netmem_to_page(page_pool_alloc_best_fit_netmem(pool, offset,
+							      size, gfp));
 }
 
 /**
@@ -440,6 +458,16 @@ static inline void page_pool_dma_sync_for_cpu(const struct page_pool *pool,
 				      page_pool_get_dma_dir(pool));
 }
 
+static inline void
+page_pool_dma_sync_for_cpu_netmem(const struct page_pool *pool,
+				  netmem_ref netmem, u32 offset,
+				  u32 dma_sync_size)
+{
+	if (!netmem_is_net_iov(netmem))
+		page_pool_dma_sync_for_cpu(pool, netmem_to_page(netmem),
+					   offset, dma_sync_size);
+}
+
 static inline bool page_pool_put(struct page_pool *pool)
 {
 	return refcount_dec_and_test(&pool->user_cnt);
-- 
2.47.1


