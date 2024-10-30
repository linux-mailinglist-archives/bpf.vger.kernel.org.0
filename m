Return-Path: <bpf+bounces-43574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8350B9B69A8
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 17:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E701C20D3B
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 16:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4E4217649;
	Wed, 30 Oct 2024 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iw0M3HWV"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE9EC8EB;
	Wed, 30 Oct 2024 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307220; cv=none; b=jPBot090PlorACMsYAAy632m7F+j4dq/YlKbU8u6uPGQfypD7RnCfmbtgJIyEFgumMSMeq2B8UAQjeLID5YAZiqCLEO+bqs6HIqZkInI08DXvfPMpRx03+HF1lRfsQNYG1FTcMRqn6ZVW2o0ZRFjy+WlLceoMzH8BBmS3pIuaxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307220; c=relaxed/simple;
	bh=Qr9BUNxVx/dNeidNF5Cxp+463dNZVgIk1Id0iaaVbCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfIkowDGeG/9nvZRFhHW8GILdLf4b7nerMQwWXzwOPSti+GHjXGDy7GAdUZsUXF6Qv7OYpopO9EbDyvcVPNHn+YX/rXPBS4fGSeCsjAa7rFlyecr7oJBmJMMVlk8ld0IZmZ7KJxarz3STwS53furEf2Z1T3AH3v4biChrxIU8rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iw0M3HWV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730307219; x=1761843219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qr9BUNxVx/dNeidNF5Cxp+463dNZVgIk1Id0iaaVbCs=;
  b=iw0M3HWV5IJARMpFm/X1oAvbaQ603P2tzvZnHKTdDkebbjQJBbJCoHpZ
   QX9ZqKG6Sh4Fus2SgKXSLq9nFnoWn71e+YY1yInbcrt6JvQLPZkLQvMks
   S3iv0mXujEGb1StgdiTUUkDliurxhZ05GrT0vCtgmcfaYiUdsW0hPL2R0
   ahEepMAgZY8ygnf9il9aNVswYhkrCpQnssvrWqU7MHNuY/dkTm4vfkZY9
   ddq4utBL1zk5w0VIni+UuNNm7CDTnSOkXsuCIgWPuSWrAb5Z+lK/b5Q4c
   3OqpsuxtROp8DI/mVIin6ndUA0r+TUoW3F4n0XA1orfM6xxIYM5EJKDQZ
   Q==;
X-CSE-ConnectionGUID: 11/10e8FTXWVSG2kecQYgQ==
X-CSE-MsgGUID: Jz5HzJ6DTOy6EZ/bfg5F3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="41389597"
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="41389597"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 09:53:38 -0700
X-CSE-ConnectionGUID: L5r7TuvrQOqy8PzClKGb2g==
X-CSE-MsgGUID: sIg1e6rmQ3eItvwn2jkwTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,245,1725346800"; 
   d="scan'208";a="87524461"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 30 Oct 2024 09:53:34 -0700
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
Subject: [PATCH net-next v3 02/18] skbuff: allow 2-4-argument skb_frag_dma_map()
Date: Wed, 30 Oct 2024 17:51:45 +0100
Message-ID: <20241030165201.442301-3-aleksander.lobakin@intel.com>
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
2.47.0


