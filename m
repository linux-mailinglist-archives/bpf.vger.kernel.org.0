Return-Path: <bpf+bounces-44757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB659C7710
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 16:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E322889E0
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 15:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC242022C9;
	Wed, 13 Nov 2024 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVMclotY"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ED4158522;
	Wed, 13 Nov 2024 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511510; cv=none; b=BGUZemlLwWlVFNql820d6dNa2qo8rWnZimd++Qtyu1tha90N8Eb37yH6x7Q+HlCpDcKJz2tK+6C7whAhpc3sg8L3E+1CuJ2WqmaCkTVhgAkWrsv+8PtmLs70FBD3PUmwG5RHMb+hP45+7U/B+AOEZiPKDSGMK36lb5FRMA4oDRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511510; c=relaxed/simple;
	bh=G9wdCAxSGj86lUodGQ8o8qxRQC4hzinCVagT2d9noyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IuA5Bfi0R2SaHNDbkwr3A8QK0MWjBKp6bmnRsQhATmoB97ajwjrjbCugIe0NeGZRy+pGTSABO/K+zfVMdMvoTPVnC2fzgX9jaZRrnPNP05lYOxkD/XL4XwSZwrxrp5CeLMt8fEhS0kzAAZCI33Fq6lN65ntYgR0K9aQxlcZhO+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eVMclotY; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731511509; x=1763047509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G9wdCAxSGj86lUodGQ8o8qxRQC4hzinCVagT2d9noyw=;
  b=eVMclotYsgww/DTyux7j8J5ngOS9IGGkjq4iz34Auw7zqlgG1Ymupx4r
   DM3dqd3kTd8BoWgWZG+dQuvi4OS3mwNQ5/73pbxnt+ieGZeHHTYqGsGZh
   Vbv8X4DdAPZj+WWFnea28YawpL/T9VoPliNVJomG6WJscub4tKV509phF
   wQ3ttKV35HdtG0Dfe5iifjLi4fEPJbY+JdC/3NAKTNr1F1wEqjlnygzVO
   viyrG5dN8ASVMythPfqjkkR8tDU5GCbkHPt0i5RloyV6g1hU6Jcoz8+ta
   Z1VqY9Os6uaAI0RV+r3hmvZ+x7hLAWpUnLoEb24Y24w2huDCHal5F9oCo
   g==;
X-CSE-ConnectionGUID: gLmaieO2T7i6uR55cLSkow==
X-CSE-MsgGUID: vj7d0Eg7ReSzzhL3r5WzYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42799251"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="42799251"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 07:25:08 -0800
X-CSE-ConnectionGUID: TwYL1ZtOS5+I/TS6sWgYXw==
X-CSE-MsgGUID: 1KYQAKgHTS++xHDiOPRbYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="118726844"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 13 Nov 2024 07:25:04 -0800
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
Subject: [PATCH net-next v5 02/19] skbuff: allow 2-4-argument skb_frag_dma_map()
Date: Wed, 13 Nov 2024 16:24:25 +0100
Message-ID: <20241113152442.4000468-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
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
index 58009fa66102..c212c1dad461 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3674,7 +3674,7 @@ static inline void skb_frag_page_copy(skb_frag_t *fragto,
 bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t prio);
 
 /**
- * skb_frag_dma_map - maps a paged fragment via the DMA API
+ * __skb_frag_dma_map - maps a paged fragment via the DMA API
  * @dev: the device to map the fragment to
  * @frag: the paged fragment to map
  * @offset: the offset within the fragment (starting at the
@@ -3684,15 +3684,36 @@ bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t prio);
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
2.47.0


