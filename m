Return-Path: <bpf+bounces-41427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 261D2996FFC
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 17:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9230281AD1
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 15:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934401E5016;
	Wed,  9 Oct 2024 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XbR9+z8D"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912F01E47D5;
	Wed,  9 Oct 2024 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487749; cv=none; b=ph5Qs6Au9oH2uvG1O7P9q7KGMvhLHGLQA9BQIuVOvqr8QurtwT8TP5pBlr+OftPuzvlXgO2u3oAsHAvPsJ+NV4vddlGPFacle4pYe5lXPzxsuW+jGaJzBG3xpGeNgBnAMsG+QCj16kNCZqiKwni4G9AgTAOKjLmH8Du+Nq3f7h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487749; c=relaxed/simple;
	bh=VunDVl3Xvc8ika62yCC+qV1MgWuofkp3d7WaFC9Lmxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJG0Vz6xNeFbvKdIJIMkJhjCyCl/0q5ycYYUVtRHYKzg4VUJ9xXvMVdOiaBFjSl6bU7UkpezrLwIeZAToh8JHQHea/kXkTNJrZxhHcO1SeeVkWDRBRMr8Ms2w6k4ODBSYCAuFKxuqmzXDTaGSkRFY+FDIqBWbL1Rd2SWEZURZtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XbR9+z8D; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728487747; x=1760023747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VunDVl3Xvc8ika62yCC+qV1MgWuofkp3d7WaFC9Lmxo=;
  b=XbR9+z8D9T76gVixGVCYzTR3YDUc5/tn8XmnVws9dCMd5fZJWXTYhe42
   ep8grAps/4lNqwpZra0SK2gpsw3GjyWLjeexi8QGC38t3YGKH+863MmCk
   nuHEYCmQr7xIYA2IpPKgjX09RujOT6GIpgoRr3YfZN7NBaQpGcuKp2UdZ
   xdGMO95fxsEuQRcy0nr72o5NzsvoXOZkEmJMiBz/mKgtxZeTPU1zzfUxI
   MHNpTPmMq9loLgoIgqT0GQBEKYgo9Y4OPD4fE8HAnC5q3lVQPlXdDA0a4
   +dEaAdnUss335/gnfNiJmETFYar4IeCkW11P3iLEn86j18a+1yC2FEo8x
   Q==;
X-CSE-ConnectionGUID: KCW3s/rfRY+rRHFBscAHcA==
X-CSE-MsgGUID: gRB4Oht6SUOIFTMDIQErfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27675769"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="27675769"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 08:29:07 -0700
X-CSE-ConnectionGUID: twTZ2VspRM2xMsYfNNpIKg==
X-CSE-MsgGUID: mNJLdASlRLqeKSCA9IgeKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="81305970"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 09 Oct 2024 08:29:03 -0700
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
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 08/18] page_pool: make page_pool_put_page_bulk() actually handle array of pages
Date: Wed,  9 Oct 2024 17:27:46 +0200
Message-ID: <20241009152756.3113697-9-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009152756.3113697-1-aleksander.lobakin@intel.com>
References: <20241009152756.3113697-1-aleksander.lobakin@intel.com>
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
index fae6305e2123..f99fbe9bf5a5 100644
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
index 72d2bd22bc40..4b2ff5a280bb 100644
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
2.46.2


