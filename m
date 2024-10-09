Return-Path: <bpf+bounces-41421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E51996FE6
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 17:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32287B20C2A
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 15:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24E91E2617;
	Wed,  9 Oct 2024 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HL0EAieX"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054701E2608;
	Wed,  9 Oct 2024 15:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487725; cv=none; b=qmnyIczrlADfSFHrbiGsLIG8PUDemcFN/fC0t+H4DRUaEanYYOxn43fH/Br4iRMAGIGqpdGh5ixdJTO6CiAKUgpRp3pBvGsFJE6QlfIerAUub+Rt9HsjzosRbs/enribdTbNG2dDc/hhzNcAVFW7IcoMZol/75QXIIPzqiZyDLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487725; c=relaxed/simple;
	bh=ZKDYFn+g+Ra1PvQZ5saw4hzUQ5ZvAp4H0Pn6ZIu1nUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRLjw8AgrxgRG/ePJa7DtuAm9dixqx1WKl7v56AqBGWAAbhptXJlPeQRPC2uq5ULZLf7EnC2Ksc87PFD+fUJlt3L7+H22U+sYC//oCZAH2yrW1VqNAt6tOHCRsKE7jNu2RZLa+4Jhyx5tV2EtmpOsCw+usgRrQn/JN7VE57MwaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HL0EAieX; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728487724; x=1760023724;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZKDYFn+g+Ra1PvQZ5saw4hzUQ5ZvAp4H0Pn6ZIu1nUc=;
  b=HL0EAieXL5LQXZf7BVgyq8NZ8C1bzeJkBHJ8Nhfc3BRrYrggacBoDBQS
   kz+O59wutKC4jaWyb+J7VXqgksE30cOS9JV8TvwfFLtBcc+9vWOr1FP9f
   +sA9vy43NSPOk+xZuKAxTVQJv67WgGCgiGTKpcUAvU2dlFxTWK2F9FPDw
   +sFIkAaaVdxRXYWKExyFDiLYmqZUGW+myGL0Rj2IHAgpn2hL/FuWXNBAh
   08w8oVM/1gpmRoEta+I1rsuR3yVssVmhWgCMXFgNuX3ygnNV+LXz5hvd+
   zyi2Qf7aKs1HMGGpJB3Ic3Gz5zBI79qytF07YXuw83L4YWVzYu1hE1l8Q
   Q==;
X-CSE-ConnectionGUID: BJJbXelcSMWOHH5ol7TFXw==
X-CSE-MsgGUID: 5JBiDZwkStiV3qOd1U/bew==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27675691"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="27675691"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 08:28:43 -0700
X-CSE-ConnectionGUID: Sh+BYIEWRqKzNiNuBl8j9g==
X-CSE-MsgGUID: DlLgyHCoQqGKK0vJi6IRHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="81305802"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 09 Oct 2024 08:28:39 -0700
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
Subject: [PATCH net-next 02/18] skbuff: allow 2-4-argument skb_frag_dma_map()
Date: Wed,  9 Oct 2024 17:27:40 +0200
Message-ID: <20241009152756.3113697-3-aleksander.lobakin@intel.com>
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
index 3d297669efcf..4a07bb3bcec6 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3637,7 +3637,7 @@ static inline void skb_frag_page_copy(skb_frag_t *fragto,
 bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t prio);
 
 /**
- * skb_frag_dma_map - maps a paged fragment via the DMA API
+ * __skb_frag_dma_map - maps a paged fragment via the DMA API
  * @dev: the device to map the fragment to
  * @frag: the paged fragment to map
  * @offset: the offset within the fragment (starting at the
@@ -3647,15 +3647,36 @@ bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t prio);
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


