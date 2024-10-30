Return-Path: <bpf+bounces-43580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A52E9B69CE
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 17:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31F01F21B0C
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 16:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFE221B443;
	Wed, 30 Oct 2024 16:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+VZ1G2a"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13B0217448;
	Wed, 30 Oct 2024 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307245; cv=none; b=aLILdBgQ2WXxBXe/v0FMC538Pt56/V+RMnu3A09cXDXLOE+AG6ncGX2g7BJD/GoPjtDUy5LSYzKM93WQEwrKA33n/WoBL23cK7Qesqug7DpsJIcsjUM/TTVNVgritl8fPqEF2seWd4OTdQkhCbl5/LVjnD34use3WDurok0hXFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307245; c=relaxed/simple;
	bh=yEOnlTPFJcCSbb6Xd341xaD9pSZB20IAYtSOShEAm+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQ9pfiwVq7gHztcklnyOtqFmlCKrUhPSoxOmAm3VwHf/2Lu5TyigiimWPmvCu+W6u1nL/0EIoHQqqrU/fc1LJPSX95WWupZITSJo1p3GK2bHIgU8y63aMJ76VdoOjj3Dou0fhY8vKqSajj2r7L22EWJQhOwF8pZLFjCXEOnJKGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+VZ1G2a; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730307243; x=1761843243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yEOnlTPFJcCSbb6Xd341xaD9pSZB20IAYtSOShEAm+w=;
  b=R+VZ1G2a2qXfwM/0hqeRmR+SYpwNXkDqP/7pF/IrmxV3WxY7JAB8FiFT
   HKIfJyrkzlHnnBIQrOVQJi/P9o7K5Y8eSW20Foi5c2JqYVN/aC1JL0Pkg
   zCpAlGNIItqAH1PTo8lLeErR56vDK4w9jDFV06nFfDfWRxyHx1LqbYpI9
   bs9ccFr508APTvVXJCn92OWMPL1QaEeoEErx2O1OIIMiJdM/PGqNySF3+
   8ppaSbY9ZdMGXdg7LTKjZY3nvCUPPC7HJP1cgWcVO+Ea4S1ZIaHx9EtSM
   v/DIB8i1wHIJaIwXXqPTU15Pevj1llAs8f+ne95P5+zCAOuF2ap+EsU+6
   g==;
X-CSE-ConnectionGUID: kBZpTYQVSXqwbm00pgAGnQ==
X-CSE-MsgGUID: STHB9DVJTLSJiDO9vTCmwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="41389714"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="41389714"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 09:54:03 -0700
X-CSE-ConnectionGUID: 7/RZ87VnRRiWNxW8OmPKLQ==
X-CSE-MsgGUID: KS4itE4CQVuSiFbtgPT1YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="87524509"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 30 Oct 2024 09:53:59 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 08/18] page_pool: make page_pool_put_page_bulk() actually handle array of pages
Date: Wed, 30 Oct 2024 17:51:51 +0100
Message-ID: <20241030165201.442301-9-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030165201.442301-1-aleksander.lobakin@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, page_pool_put_page_bulk() indeed takes an array of pointers
to the data, not pages, despite the name. As one side effect, when
you're freeing frags from &skb_shared_info, xdp_return_frame_bulk()
converts page pointers to virtual addresses and then
page_pool_put_page_bulk() converts them back.
Make page_pool_put_page_bulk() actually handle array of pages. Pass
frags directly and use virt_to_page() when freeing xdpf->data, so that
the PP core will then get the compound head and take care of the rest.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/types.h | 8 ++++----
 include/net/xdp.h             | 2 +-
 net/core/page_pool.c          | 6 +++---
 net/core/xdp.c                | 4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index c022c410abe3..6c1be99a5959 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -259,8 +259,8 @@ void page_pool_disable_direct_recycling(struct page_pool *pool);
 void page_pool_destroy(struct page_pool *pool);
 void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
 			   const struct xdp_mem_info *mem);
-void page_pool_put_page_bulk(struct page_pool *pool, void **data,
-			     int count);
+void page_pool_put_page_bulk(struct page_pool *pool, struct page **data,
+			     u32 count);
 #else
 static inline void page_pool_destroy(struct page_pool *pool)
 {
@@ -272,8 +272,8 @@ static inline void page_pool_use_xdp_mem(struct page_pool *pool,
 {
 }
 
-static inline void page_pool_put_page_bulk(struct page_pool *pool, void **data,
-					   int count)
+static inline void page_pool_put_page_bulk(struct page_pool *pool,
+					   struct page **data, u32 count)
 {
 }
 #endif
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 3e748bb916d3..4416cd4b5086 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -194,7 +194,7 @@ xdp_frame_is_frag_pfmemalloc(const struct xdp_frame *frame)
 struct xdp_frame_bulk {
 	int count;
 	void *xa;
-	void *q[XDP_BULK_QUEUE_SIZE];
+	struct page *q[XDP_BULK_QUEUE_SIZE];
 };
 
 static __always_inline void xdp_frame_bulk_init(struct xdp_frame_bulk *bq)
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index a813d30d2135..ad219206ee8d 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -854,8 +854,8 @@ EXPORT_SYMBOL(page_pool_put_unrefed_page);
  * Please note the caller must not use data area after running
  * page_pool_put_page_bulk(), as this function overwrites it.
  */
-void page_pool_put_page_bulk(struct page_pool *pool, void **data,
-			     int count)
+void page_pool_put_page_bulk(struct page_pool *pool, struct page **data,
+			     u32 count)
 {
 	int i, bulk_len = 0;
 	bool allow_direct;
@@ -864,7 +864,7 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 	allow_direct = page_pool_napi_local(pool);
 
 	for (i = 0; i < count; i++) {
-		netmem_ref netmem = page_to_netmem(virt_to_head_page(data[i]));
+		netmem_ref netmem = page_to_netmem(compound_head(data[i]));
 
 		/* It is not the last user for the page frag case */
 		if (!page_pool_is_last_ref(netmem))
diff --git a/net/core/xdp.c b/net/core/xdp.c
index bd2aa340baad..779e646f347b 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -556,12 +556,12 @@ void xdp_return_frame_bulk(struct xdp_frame *xdpf,
 		for (i = 0; i < sinfo->nr_frags; i++) {
 			skb_frag_t *frag = &sinfo->frags[i];
 
-			bq->q[bq->count++] = skb_frag_address(frag);
+			bq->q[bq->count++] = skb_frag_page(frag);
 			if (bq->count == XDP_BULK_QUEUE_SIZE)
 				xdp_flush_frame_bulk(bq);
 		}
 	}
-	bq->q[bq->count++] = xdpf->data;
+	bq->q[bq->count++] = virt_to_page(xdpf->data);
 }
 EXPORT_SYMBOL_GPL(xdp_return_frame_bulk);
 
-- 
2.47.0


