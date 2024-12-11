Return-Path: <bpf+bounces-46651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C559ED388
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 18:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957091884EF5
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 17:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1503E201266;
	Wed, 11 Dec 2024 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KK7lEU8N"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEAA200BB7;
	Wed, 11 Dec 2024 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733938132; cv=none; b=NhCVvj9gHVOBRXIPfyathY2u6uy1AOjpoC73jv7Acm1TwWoitZ83D11zAHpZ620JMw6VhosXpnh+UH4C485SrbKIPrP7WNOLuJYACXbP+ZmcgQ9VXF3QJhWVaYTutWVa1lWbKa5z3hceo9jcyH6LEY5nCJOQgcYnuNXKBrEFpow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733938132; c=relaxed/simple;
	bh=hTiIfVzdQAzN245gpoI2ewyExpDiWN8oZxf82j9mqk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0R/aUkNpA0zZqB6/XILvKKB85UtHvqtWpTL4JUk+GWFRhrzKGbJYKVz/L94ZRBJG59GdJBGTMdWEr1DmkyXxM8K4f/zWJ1gKBDL5qGq7q1tXQDxgzMKviWOqX67b1P9C3xqJDP17T08IkyAEwBuR3yFl0YfVIb396h38BplIkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KK7lEU8N; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733938131; x=1765474131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hTiIfVzdQAzN245gpoI2ewyExpDiWN8oZxf82j9mqk0=;
  b=KK7lEU8N8Gn1gGLhqhwGEb/Mgk1webETEtz9xBd6nQYsTFtLS7pwQMl1
   2cVN63Y1WN2tB8WjdoIfU2HhSMptwJhOdEUu5P1ZSrAf4QQYe+tJhpn3t
   uTY2UG7giBGGMVGaoBlu2j1lZwg4ZnMFm4DXL7iR2WTtajEddBsjZ/nAE
   wZiH8Wv9jZat6Xv5Z3Ru1ahwFytlTxdoS/+I9uALtYdJEwjlZ3EFqX1/p
   vBq5Y0wSZ3OpwuSzHmsJxcIPbqgtoqK4zMJrolP30TmI1AMYTF7EK2uNW
   zsOyfHTTloZlDtwUcoyrRKV1evEO+mfYfdqvbwfQjnu0lqZY3853VBsWn
   g==;
X-CSE-ConnectionGUID: dkhO6uXVTum+9NnNlA9eXA==
X-CSE-MsgGUID: YdqoXONfQHGvdM6w4zPlfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="51859498"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="51859498"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 09:28:51 -0800
X-CSE-ConnectionGUID: +jF23o3NTgai6nnEomDi/g==
X-CSE-MsgGUID: zQf8JWCKS+maBHJgmCNvwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119122125"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa002.fm.intel.com with ESMTP; 11 Dec 2024 09:28:45 -0800
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
Subject: [PATCH net-next 03/12] xdp: make __xdp_return() MP-agnostic
Date: Wed, 11 Dec 2024 18:26:40 +0100
Message-ID: <20241211172649.761483-4-aleksander.lobakin@intel.com>
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

Currently, __xdp_return() takes pointer to the virtual memory to free
a buffer. Apart from that this sometimes provokes redundant
data <--> page conversions, taking data pointer effectively prevents
lots of XDP code to support non-page-backed buffers, as there's no
mapping for the non-host memory (data is always NULL).
Just convert it to always take netmem reference. For
xdp_return_{buff,frame*}(), this chops off one page_address() per each
frag and adds one virt_to_netmem() (same as virt_to_page()) per header
buffer. For __xdp_return() itself, it removes one virt_to_page() for
MEM_TYPE_PAGE_POOL and another one for MEM_TYPE_PAGE_ORDER0, adding
one page_address() for [not really common nowadays]
MEM_TYPE_PAGE_SHARED, but the main effect is that the abovementioned
functions won't die or memleak anymore if the frame has non-host memory
attached and will correctly free those.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/xdp.h |  4 ++--
 net/core/filter.c |  9 +++------
 net/core/xdp.c    | 47 +++++++++++++++++++----------------------------
 3 files changed, 24 insertions(+), 36 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 1c260869a353..d2089cfecefd 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -312,8 +312,8 @@ struct xdp_frame *xdp_convert_buff_to_frame(struct xdp_buff *xdp)
 	return xdp_frame;
 }
 
-void __xdp_return(void *data, enum xdp_mem_type mem_type, bool napi_direct,
-		  struct xdp_buff *xdp);
+void __xdp_return(netmem_ref netmem, enum xdp_mem_type mem_type,
+		  bool napi_direct, struct xdp_buff *xdp);
 void xdp_return_frame(struct xdp_frame *xdpf);
 void xdp_return_frame_rx_napi(struct xdp_frame *xdpf);
 void xdp_return_buff(struct xdp_buff *xdp);
diff --git a/net/core/filter.c b/net/core/filter.c
index 6c036708634b..5fea874025d3 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4125,7 +4125,7 @@ static void bpf_xdp_shrink_data_zc(struct xdp_buff *xdp, int shrink,
 
 	if (release) {
 		xsk_buff_del_tail(zc_frag);
-		__xdp_return(NULL, mem_type, false, zc_frag);
+		__xdp_return(0, mem_type, false, zc_frag);
 	} else {
 		zc_frag->data_end -= shrink;
 	}
@@ -4142,11 +4142,8 @@ static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
 		goto out;
 	}
 
-	if (release) {
-		struct page *page = skb_frag_page(frag);
-
-		__xdp_return(page_address(page), mem_type, false, NULL);
-	}
+	if (release)
+		__xdp_return(skb_frag_netmem(frag), mem_type, false, NULL);
 
 out:
 	return release;
diff --git a/net/core/xdp.c b/net/core/xdp.c
index d367571c5838..f1165a35411b 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -430,27 +430,25 @@ EXPORT_SYMBOL_GPL(xdp_rxq_info_attach_page_pool);
  * is used for those calls sites.  Thus, allowing for faster recycling
  * of xdp_frames/pages in those cases.
  */
-void __xdp_return(void *data, enum xdp_mem_type mem_type, bool napi_direct,
-		  struct xdp_buff *xdp)
+void __xdp_return(netmem_ref netmem, enum xdp_mem_type mem_type,
+		  bool napi_direct, struct xdp_buff *xdp)
 {
-	struct page *page;
-
 	switch (mem_type) {
 	case MEM_TYPE_PAGE_POOL:
-		page = virt_to_head_page(data);
+		netmem = netmem_compound_head(netmem);
 		if (napi_direct && xdp_return_frame_no_direct())
 			napi_direct = false;
 		/* No need to check ((page->pp_magic & ~0x3UL) == PP_SIGNATURE)
 		 * as mem->type knows this a page_pool page
 		 */
-		page_pool_put_full_page(page->pp, page, napi_direct);
+		page_pool_put_full_netmem(netmem_get_pp(netmem), netmem,
+					  napi_direct);
 		break;
 	case MEM_TYPE_PAGE_SHARED:
-		page_frag_free(data);
+		page_frag_free(__netmem_address(netmem));
 		break;
 	case MEM_TYPE_PAGE_ORDER0:
-		page = virt_to_page(data); /* Assumes order0 page*/
-		put_page(page);
+		put_page(__netmem_to_page(netmem));
 		break;
 	case MEM_TYPE_XSK_BUFF_POOL:
 		/* NB! Only valid from an xdp_buff! */
@@ -466,38 +464,34 @@ void __xdp_return(void *data, enum xdp_mem_type mem_type, bool napi_direct,
 void xdp_return_frame(struct xdp_frame *xdpf)
 {
 	struct skb_shared_info *sinfo;
-	int i;
 
 	if (likely(!xdp_frame_has_frags(xdpf)))
 		goto out;
 
 	sinfo = xdp_get_shared_info_from_frame(xdpf);
-	for (i = 0; i < sinfo->nr_frags; i++) {
-		struct page *page = skb_frag_page(&sinfo->frags[i]);
+	for (u32 i = 0; i < sinfo->nr_frags; i++)
+		__xdp_return(skb_frag_netmem(&sinfo->frags[i]), xdpf->mem_type,
+			     false, NULL);
 
-		__xdp_return(page_address(page), xdpf->mem_type, false, NULL);
-	}
 out:
-	__xdp_return(xdpf->data, xdpf->mem_type, false, NULL);
+	__xdp_return(virt_to_netmem(xdpf->data), xdpf->mem_type, false, NULL);
 }
 EXPORT_SYMBOL_GPL(xdp_return_frame);
 
 void xdp_return_frame_rx_napi(struct xdp_frame *xdpf)
 {
 	struct skb_shared_info *sinfo;
-	int i;
 
 	if (likely(!xdp_frame_has_frags(xdpf)))
 		goto out;
 
 	sinfo = xdp_get_shared_info_from_frame(xdpf);
-	for (i = 0; i < sinfo->nr_frags; i++) {
-		struct page *page = skb_frag_page(&sinfo->frags[i]);
+	for (u32 i = 0; i < sinfo->nr_frags; i++)
+		__xdp_return(skb_frag_netmem(&sinfo->frags[i]), xdpf->mem_type,
+			     true, NULL);
 
-		__xdp_return(page_address(page), xdpf->mem_type, true, NULL);
-	}
 out:
-	__xdp_return(xdpf->data, xdpf->mem_type, true, NULL);
+	__xdp_return(virt_to_netmem(xdpf->data), xdpf->mem_type, true, NULL);
 }
 EXPORT_SYMBOL_GPL(xdp_return_frame_rx_napi);
 
@@ -544,20 +538,17 @@ EXPORT_SYMBOL_GPL(xdp_return_frame_bulk);
 void xdp_return_buff(struct xdp_buff *xdp)
 {
 	struct skb_shared_info *sinfo;
-	int i;
 
 	if (likely(!xdp_buff_has_frags(xdp)))
 		goto out;
 
 	sinfo = xdp_get_shared_info_from_buff(xdp);
-	for (i = 0; i < sinfo->nr_frags; i++) {
-		struct page *page = skb_frag_page(&sinfo->frags[i]);
+	for (u32 i = 0; i < sinfo->nr_frags; i++)
+		__xdp_return(skb_frag_netmem(&sinfo->frags[i]),
+			     xdp->rxq->mem.type, true, xdp);
 
-		__xdp_return(page_address(page), xdp->rxq->mem.type, true,
-			     xdp);
-	}
 out:
-	__xdp_return(xdp->data, xdp->rxq->mem.type, true, xdp);
+	__xdp_return(virt_to_netmem(xdp->data), xdp->rxq->mem.type, true, xdp);
 }
 EXPORT_SYMBOL_GPL(xdp_return_buff);
 
-- 
2.47.1


