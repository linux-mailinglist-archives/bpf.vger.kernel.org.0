Return-Path: <bpf+bounces-42055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 469FB99F069
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604251C22F78
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 14:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C711F667B;
	Tue, 15 Oct 2024 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f78NLDAv"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CC51F6662;
	Tue, 15 Oct 2024 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004113; cv=none; b=IQu2cP/xPn9Mhf1IaceeGIHGgyPD4ocVbEDK7jxSO0BiDuW0vnxzHYrAnfw98IbXwNLLju9v0hmDHfkbo1oM8iBXeFXiCcrWN3LobsAXju57S1EqOP63fLjO82vSRt4xvoB7WON/ATJ51EYx8KDm5EVo4KPJWGKa1a2VDAvtfOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004113; c=relaxed/simple;
	bh=/gctQdUEewnRTVuJWXcDaAlDObqdn8l7tktFSa9j3Wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gT9oa6Km9CqS1TeNKaQkVG+tAbPPL+QHJhHqBqYnk2eRjLoDrAokOq6y2qVXpeeNo9fWENxufYKAUmc1zQr4wcq86szN73qVa9YRGFehXBK5DHNvw3zzQ2aSpHW/wcEyTHTkCw3kaS+/c0nszFlL+ReYbCtksZnCXj3YznH19Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f78NLDAv; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729004112; x=1760540112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/gctQdUEewnRTVuJWXcDaAlDObqdn8l7tktFSa9j3Wk=;
  b=f78NLDAvTbmdlq8u2Y66eL03wqVCmNawtB4fbwvIWwknnRFSZyRh4WsO
   fP6Njru4sGpmYCqyS0CSxkW9sJzRceqG5VVIi1+Pk8vXMHNfZv+6arYX2
   QzJeVjXbByaqr4f8kiR5TuzBsza3NUH+6xhFWsSmJX7Y7yrdPolf6oyqa
   xAZYidgZR9Hz1OYF/ZKzr+FyZcBg0fWidC9qeezuiJ4U+9mwGGXS0/6BY
   9xS/X1foBwXu6JYjvwSiT3UOlLkS2FnyCtWJHdCVyCaUJxQysl0u1erI+
   DzN4LM4aN8/b+LN1pNSuKDY6emBJXwN9FfJl57kpGVd90kVbw8K+o3fT2
   A==;
X-CSE-ConnectionGUID: mkoEHbN0SSuzuicZTf5nQg==
X-CSE-MsgGUID: IidBYkM4S++fDsQ1Kbu8EQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="31277661"
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="31277661"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 07:55:11 -0700
X-CSE-ConnectionGUID: jzk0pDF5Sba5iOrjSQ+Sag==
X-CSE-MsgGUID: Gr7oNpzMRUGXae6zIH9Uhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82723149"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa003.jf.intel.com with ESMTP; 15 Oct 2024 07:55:08 -0700
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
Subject: [PATCH net-next v2 14/18] xsk: make xsk_buff_add_frag really add a frag via __xdp_buff_add_frag()
Date: Tue, 15 Oct 2024 16:53:46 +0200
Message-ID: <20241015145350.4077765-15-aleksander.lobakin@intel.com>
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

Currently, xsk_buff_add_frag() only adds a frag to the pool linked list,
not doing anything with the &xdp_buff. The drivers do that manually and
the logic is the same.
Make it really add an skb frag, just like xdp_buff_add_frag() does that,
and freeing frags on error if needed. This allows to remove repeating
code from i40e and ice and not add the same code again and again.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/xdp_sock_drv.h                 | 18 ++++++++++--
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 30 ++------------------
 drivers/net/ethernet/intel/ice/ice_xsk.c   | 32 ++--------------------
 3 files changed, 20 insertions(+), 60 deletions(-)

diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index f3175a5d28f7..6aae95b83645 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -136,11 +136,21 @@ static inline void xsk_buff_free(struct xdp_buff *xdp)
 	xp_free(xskb);
 }
 
-static inline void xsk_buff_add_frag(struct xdp_buff *xdp)
+static inline bool xsk_buff_add_frag(struct xdp_buff *head,
+				     struct xdp_buff *xdp)
 {
-	struct xdp_buff_xsk *frag = container_of(xdp, struct xdp_buff_xsk, xdp);
+	const void *data = xdp->data;
+	struct xdp_buff_xsk *frag;
+
+	if (!__xdp_buff_add_frag(head, virt_to_page(data),
+				 offset_in_page(data), xdp->data_end - data,
+				 xdp->frame_sz, false))
+		return false;
 
+	frag = container_of(xdp, struct xdp_buff_xsk, xdp);
 	list_add_tail(&frag->list_node, &frag->pool->xskb_list);
+
+	return true;
 }
 
 static inline struct xdp_buff *xsk_buff_get_frag(const struct xdp_buff *first)
@@ -357,8 +367,10 @@ static inline void xsk_buff_free(struct xdp_buff *xdp)
 {
 }
 
-static inline void xsk_buff_add_frag(struct xdp_buff *xdp)
+static inline bool xsk_buff_add_frag(struct xdp_buff *head,
+				     struct xdp_buff *xdp)
 {
+	return false;
 }
 
 static inline struct xdp_buff *xsk_buff_get_frag(const struct xdp_buff *first)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 4e885df789ef..e28f1905a4a0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -395,32 +395,6 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
 	WARN_ON_ONCE(1);
 }
 
-static int
-i40e_add_xsk_frag(struct i40e_ring *rx_ring, struct xdp_buff *first,
-		  struct xdp_buff *xdp, const unsigned int size)
-{
-	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(first);
-
-	if (!xdp_buff_has_frags(first)) {
-		sinfo->nr_frags = 0;
-		sinfo->xdp_frags_size = 0;
-		xdp_buff_set_frags_flag(first);
-	}
-
-	if (unlikely(sinfo->nr_frags == MAX_SKB_FRAGS)) {
-		xsk_buff_free(first);
-		return -ENOMEM;
-	}
-
-	__skb_fill_page_desc_noacc(sinfo, sinfo->nr_frags++,
-				   virt_to_page(xdp->data_hard_start),
-				   XDP_PACKET_HEADROOM, size);
-	sinfo->xdp_frags_size += size;
-	xsk_buff_add_frag(xdp);
-
-	return 0;
-}
-
 /**
  * i40e_clean_rx_irq_zc - Consumes Rx packets from the hardware ring
  * @rx_ring: Rx ring
@@ -486,8 +460,10 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 
 		if (!first)
 			first = bi;
-		else if (i40e_add_xsk_frag(rx_ring, first, bi, size))
+		else if (!xsk_buff_add_frag(first, bi)) {
+			xsk_buff_free(first);
 			break;
+		}
 
 		if (++next_to_process == count)
 			next_to_process = 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 334ae945d640..8975d2971bc3 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -801,35 +801,6 @@ ice_run_xdp_zc(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 	return result;
 }
 
-static int
-ice_add_xsk_frag(struct ice_rx_ring *rx_ring, struct xdp_buff *first,
-		 struct xdp_buff *xdp, const unsigned int size)
-{
-	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(first);
-
-	if (!size)
-		return 0;
-
-	if (!xdp_buff_has_frags(first)) {
-		sinfo->nr_frags = 0;
-		sinfo->xdp_frags_size = 0;
-		xdp_buff_set_frags_flag(first);
-	}
-
-	if (unlikely(sinfo->nr_frags == MAX_SKB_FRAGS)) {
-		xsk_buff_free(first);
-		return -ENOMEM;
-	}
-
-	__skb_fill_page_desc_noacc(sinfo, sinfo->nr_frags++,
-				   virt_to_page(xdp->data_hard_start),
-				   XDP_PACKET_HEADROOM, size);
-	sinfo->xdp_frags_size += size;
-	xsk_buff_add_frag(xdp);
-
-	return 0;
-}
-
 /**
  * ice_clean_rx_irq_zc - consumes packets from the hardware ring
  * @rx_ring: AF_XDP Rx ring
@@ -895,7 +866,8 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
 
 		if (!first) {
 			first = xdp;
-		} else if (ice_add_xsk_frag(rx_ring, first, xdp, size)) {
+		} else if (likely(size) && !xsk_buff_add_frag(first, xdp)) {
+			xsk_buff_free(first);
 			break;
 		}
 
-- 
2.46.2


