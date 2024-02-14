Return-Path: <bpf+bounces-21987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D5D854E13
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 17:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73D11C22A34
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 16:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DFA612D5;
	Wed, 14 Feb 2024 16:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ctzg4LqY"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9960D612C1;
	Wed, 14 Feb 2024 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927780; cv=none; b=fWZ5opUfZEFL8stLMRcvUBC11qqP31X1DqgvkC5YEobcwhfALaLyaQg3rlGPUpuxidCnKbFhWRlDqTjMLUQnKxkYYhRVU9Lykg6KoJHvbpk9CkHiZQc1MFazznyhrN8jaecBQeE7fMrW31bzav+OD4elVP5YbtQnlBO13v2NqWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927780; c=relaxed/simple;
	bh=2jYWs6cVfcBDrhRNnxCoaJhB0s1tUX2UFowyoAY2brs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlzF1/Y2NNmX+07zv8oHCieFRfLHCFEm3xUZDF/7lO2UFNGDhwXkca5etvuwUtt6QQy6TXUH5Z7wYF1o+HaCXzPOSmEdsVu2hhQ73jqXL6YN4By/TINvRitPT7CGdIheQXxu7GXa+heEVfQxHTjKAYJ7A8FbU/bpRUj3Mvc8QMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ctzg4LqY; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707927778; x=1739463778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2jYWs6cVfcBDrhRNnxCoaJhB0s1tUX2UFowyoAY2brs=;
  b=Ctzg4LqYepotQaI30P7e9QCC/QcFQ9Wv0O17xfPz+2ELGyOeAF33Oa7U
   e1f80RrFykaFwkDWfoc8Kjy21JnHC+JkKZJzmlTsiGwOg+GcWaVO/MgmK
   gRlhLa+YGsEVChke0L3ADtIT9Eq/tD1yoTO/DF+NGl5fYwIdVnc+ZxAxV
   Zd0Jk3oo57yhAzbbvM9IrrG6NZyN6EL8lfgl+Al1+XhCGEzSCGBOGPNCS
   k1CNM1J/h8I2UIxK9vZlsIjbTAsRaYPJHqYBkyk5feEwC1knw7dtcRcLx
   CsUKsQ8Qy8dT91nS672v54uVqgQ2W+gQFinA5saE2NqEvMd7hSh/scm5o
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="5755588"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="5755588"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 08:22:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="26400020"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa002.fm.intel.com with ESMTP; 14 Feb 2024 08:22:54 -0800
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
Subject: [PATCH net-next v3 4/7] page_pool: make sure frag API fields don't span between cachelines
Date: Wed, 14 Feb 2024 17:21:58 +0100
Message-ID: <20240214162201.4168778-5-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214162201.4168778-1-aleksander.lobakin@intel.com>
References: <20240214162201.4168778-1-aleksander.lobakin@intel.com>
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
index 3828396ae60c..b2b93bec7bce 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -129,12 +129,22 @@ struct page_pool {
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
index 89c835fcf094..3c464852e228 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -170,12 +170,21 @@ static void page_pool_producer_unlock(struct page_pool *pool,
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
 			  const struct page_pool_params *params,
 			  int cpuid)
 {
 	unsigned int ring_qsize = 1024; /* Default */
 
+	page_pool_struct_check();
+
 	memcpy(&pool->p, &params->fast, sizeof(pool->p));
 	memcpy(&pool->slow, &params->slow, sizeof(pool->slow));
 
-- 
2.43.0


