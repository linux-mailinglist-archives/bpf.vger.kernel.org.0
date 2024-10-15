Return-Path: <bpf+bounces-42043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3061199F03E
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D531C22AB8
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 14:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D711EF08D;
	Tue, 15 Oct 2024 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VzDfeK5z"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3261D5159;
	Tue, 15 Oct 2024 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004063; cv=none; b=CbaFjsqn1ZZqLHCLyiZNebSQEGK176sVG/V+dTpY6Jwz7sSLomHjU0E1vH9tM0qJETCHEZ6HMQZM90wAmIygBtyy394P3KVWXVXzBPLzsTobYNsD6rRLyjR6ajXRmJVX+1uROYyMcOwkT7ziQOSERJO2P28QQ6uISJyaj0wEAtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004063; c=relaxed/simple;
	bh=fvL+wbT3+sbiRRPRxSq70GK72WAXKB5l+R9CcGE2oxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ql7ogkhc1OYFmjVJP+Qv+lpBd/N0kQ2b7JyP8v+nJSvkVFC7U0xf/F1FpO2jm+br9BhqWk0oGAbug7QwCi5z4yWKrinH5PLigPJnfJE+aXTeMGKivJnah658dXJY1B2wX7YJn02I9Nah6Vvsv2uzLOdgBNTeTiiE9nUFWv6p6nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VzDfeK5z; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729004062; x=1760540062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fvL+wbT3+sbiRRPRxSq70GK72WAXKB5l+R9CcGE2oxA=;
  b=VzDfeK5z9rSBRLEWTiOOLKRbnpI9Y2pSI5mre3iRjlMPtGoPs5HwQMMZ
   l/a3vYsSpmnn79C6bQUmNcEYSme2neLuNySfjUF0Oj8W3/SAML79VYrRP
   AfOrP6Mcoinsno85ocNd5IgZ3oRz5BDrh+N5HfqNZiYmuAFHrUGgZOn8r
   qVbXhxJ8VZPjYEB25DekdqWYeUMSwN29JK1eyQBl5sauAJ3ito0mZShaD
   bvQ5oFE1ZF1ZPyBMOxtgjTFbBFUmTSxhFJqeJRE2lzm40UbS7UiSYhLik
   4zkJ5H8MyxsLx2NJlSPUH31ZOuJgYN8m/SMjjfjc5Ln/P8SISPhRQ62Mr
   A==;
X-CSE-ConnectionGUID: txZDTbehRvyRNMtHB4PW9A==
X-CSE-MsgGUID: eHtJVNVrR1yao7D4a9e7LQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="31277462"
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="31277462"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 07:54:21 -0700
X-CSE-ConnectionGUID: wv345NLsST2WVS+97BxkWA==
X-CSE-MsgGUID: FwZes+DHQ9e74O3xiH8F6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82723042"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa003.jf.intel.com with ESMTP; 15 Oct 2024 07:54:18 -0700
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
Subject: [PATCH net-next v2 02/18] skbuff: allow 2-4-argument skb_frag_dma_map()
Date: Tue, 15 Oct 2024 16:53:34 +0200
Message-ID: <20241015145350.4077765-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
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
index 48f1e0fa2a13..f187a2415fb8 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3642,7 +3642,7 @@ static inline void skb_frag_page_copy(skb_frag_t *fragto,
 bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t prio);
 
 /**
- * skb_frag_dma_map - maps a paged fragment via the DMA API
+ * __skb_frag_dma_map - maps a paged fragment via the DMA API
  * @dev: the device to map the fragment to
  * @frag: the paged fragment to map
  * @offset: the offset within the fragment (starting at the
@@ -3652,15 +3652,36 @@ bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t prio);
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
2.46.2


