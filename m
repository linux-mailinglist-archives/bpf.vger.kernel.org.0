Return-Path: <bpf+bounces-46658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB619ED3A5
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 18:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D529188C38A
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 17:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C5B20B812;
	Wed, 11 Dec 2024 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4ccC4Nz"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9861207A39;
	Wed, 11 Dec 2024 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733938167; cv=none; b=g8ccGwgXaTPhQnsWQWQZKIZPdETQj8kMh4mDSSaRjZ0LUtkxfQUSX0FxZ7s/5sbRn1jMfs5CfEdSxJ7aVSK8CAMPeFNz+owsoDiqbftcKbTVIuCTqXRuzDe1VhgXp3r5q84nGRQJr2KsHfB/aoUsk9bDWFw1+4wgtdNkC+C7H4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733938167; c=relaxed/simple;
	bh=WYUMYW1SB8Xt0LN/LVRR3OBaayXs3+auaJsIGlgXPRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmYMe0nKISE1qD2AkLW//eVvsKe7QZ0UHIozfGSTcI6+SgGquz1Wi8aBQrDkiu+MOz+nxYAiIGWzLzwJNoNUoVXLmXTzSPjzJ2R6KlQsoPMAm0xxfkM5D8XLss3ehmo2LSwnpKTjXFicbM9RLDyk/+KoRSNqY3Op7Uw0697+zfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z4ccC4Nz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733938166; x=1765474166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WYUMYW1SB8Xt0LN/LVRR3OBaayXs3+auaJsIGlgXPRk=;
  b=Z4ccC4Nzuc+icGIlYJNnsQD/aSXvxO4dQYSqYJMQObLTsByA5I3qcHQt
   +5dwk9h7ru60aUn5bggeLm1yqcOCjYjS0zjIBhoRw2WOb2yspdViI/QQb
   mqTMcB2IEikXd6isu4jQgkswlGH6PlzGnjIOYR5ycII1PKZZbHrMIGytM
   87QdR13Mc2Iz1rOqdUMnWRqoVVyt8HwG7cby7QHq6ifP0VDh5QhuilD5e
   WQkFdqarrWXwLhj+dtMyvbfiVqFRQB4z+lozSkzyM7tniC96tNEdU38ll
   pOC8RX4kV5w9bB3MD57trujg+QlN+2BgBQx+iQbMbjCxLNfz7zaf0dKmM
   Q==;
X-CSE-ConnectionGUID: ZsOi6dfLRE2GkcUDSd8uuQ==
X-CSE-MsgGUID: cQlKKoS9RZqGxdEh6jiWNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="51859681"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="51859681"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 09:29:26 -0800
X-CSE-ConnectionGUID: XX/qovBlTdGDKj6EhB1Seg==
X-CSE-MsgGUID: ve/RU88CQDuYSF1lRAXDRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119122386"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa002.fm.intel.com with ESMTP; 11 Dec 2024 09:29:20 -0800
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
Subject: [PATCH net-next 10/12] skbuff: allow 2-4-argument skb_frag_dma_map()
Date: Wed, 11 Dec 2024 18:26:47 +0100
Message-ID: <20241211172649.761483-11-aleksander.lobakin@intel.com>
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

skb_frag_dma_map(dev, frag, 0, skb_frag_size(frag), DMA_TO_DEVICE)
is repeated across dozens of drivers and really wants a shorthand.
Add a macro which will count args and handle all possible number
from 2 to 5. Semantics:

skb_frag_dma_map(dev, frag) ->
__skb_frag_dma_map(dev, frag, 0, skb_frag_size(frag), DMA_TO_DEVICE)

skb_frag_dma_map(dev, frag, offset) ->
__skb_frag_dma_map(dev, frag, offset, skb_frag_size(frag) - offset,
		   DMA_TO_DEVICE)

skb_frag_dma_map(dev, frag, offset, size) ->
__skb_frag_dma_map(dev, frag, offset, size, DMA_TO_DEVICE)

skb_frag_dma_map(dev, frag, offset, size, dir) ->
__skb_frag_dma_map(dev, frag, offset, size, dir)

No object code size changes for the existing callers. Users passing
less arguments also won't have bigger size comparing to the full
equivalent call.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/skbuff.h | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 8bcf14ae6789..bb2b751d274a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3682,7 +3682,7 @@ static inline void skb_frag_page_copy(skb_frag_t *fragto,
 bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t prio);
 
 /**
- * skb_frag_dma_map - maps a paged fragment via the DMA API
+ * __skb_frag_dma_map - maps a paged fragment via the DMA API
  * @dev: the device to map the fragment to
  * @frag: the paged fragment to map
  * @offset: the offset within the fragment (starting at the
@@ -3692,15 +3692,36 @@ bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t prio);
  *
  * Maps the page associated with @frag to @device.
  */
-static inline dma_addr_t skb_frag_dma_map(struct device *dev,
-					  const skb_frag_t *frag,
-					  size_t offset, size_t size,
-					  enum dma_data_direction dir)
+static inline dma_addr_t __skb_frag_dma_map(struct device *dev,
+					    const skb_frag_t *frag,
+					    size_t offset, size_t size,
+					    enum dma_data_direction dir)
 {
 	return dma_map_page(dev, skb_frag_page(frag),
 			    skb_frag_off(frag) + offset, size, dir);
 }
 
+#define skb_frag_dma_map(dev, frag, ...)				\
+	CONCATENATE(_skb_frag_dma_map,					\
+		    COUNT_ARGS(__VA_ARGS__))(dev, frag, ##__VA_ARGS__)
+
+#define __skb_frag_dma_map1(dev, frag, offset, uf, uo) ({		\
+	const skb_frag_t *uf = (frag);					\
+	size_t uo = (offset);						\
+									\
+	__skb_frag_dma_map(dev, uf, uo, skb_frag_size(uf) - uo,		\
+			   DMA_TO_DEVICE);				\
+})
+#define _skb_frag_dma_map1(dev, frag, offset)				\
+	__skb_frag_dma_map1(dev, frag, offset, __UNIQUE_ID(frag_),	\
+			    __UNIQUE_ID(offset_))
+#define _skb_frag_dma_map0(dev, frag)					\
+	_skb_frag_dma_map1(dev, frag, 0)
+#define _skb_frag_dma_map2(dev, frag, offset, size)			\
+	__skb_frag_dma_map(dev, frag, offset, size, DMA_TO_DEVICE)
+#define _skb_frag_dma_map3(dev, frag, offset, size, dir)		\
+	__skb_frag_dma_map(dev, frag, offset, size, dir)
+
 static inline struct sk_buff *pskb_copy(struct sk_buff *skb,
 					gfp_t gfp_mask)
 {
-- 
2.47.1


