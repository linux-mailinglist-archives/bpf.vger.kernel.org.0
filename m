Return-Path: <bpf+bounces-72313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA31C0D722
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 13:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 500CA4EDAAB
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 12:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B2730E0EF;
	Mon, 27 Oct 2025 12:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EWJE4PI3"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F63301716;
	Mon, 27 Oct 2025 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567275; cv=none; b=WP/xTaXJJGoVkC1sUdMJkkaYQJ5XWUKPFWfqh5PlglyRmpAFSv8MIP9gceop3gR+TYs8TCNDDljLcamzdNKePXhp6bHzEVUVfyhUchjVbDpqLiH75L7vWsYEic/n4SGlJqvaK8eK2wHlBHjfPraMQDhR278KhKO1MYCiuF0mvBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567275; c=relaxed/simple;
	bh=kZrtExYjHEUufmmxd9gUEfamXxEmFlwNPWcLp0VTimQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bYaMiLdwCsJFPGuRAouxil5OmrPQnCXxlYOqfPrkuXgzuGJzGuQJP9k7Wl3eU6MLVSsPbXVL+lM3N2HONP7FUtkRFh3lOmY0vd4MjYhTIhyRNwKZbJ7l0kIigZSatzsq/F9jI9vcqr8Zs5m2wBPl/I9nb89xLxETYYNbRmg7Ids=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EWJE4PI3; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761567274; x=1793103274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kZrtExYjHEUufmmxd9gUEfamXxEmFlwNPWcLp0VTimQ=;
  b=EWJE4PI3QPzUY1IT6EPIiOMOepuMYkghpukA1HQbvu1lGQUt/GjrBjmB
   okibf4veh1aMrdBjcp6480WVEZq4i7u1tzueHXet5WtbkZgF4tH9zdoft
   rnvsd/ARxDsNgH3HZPL+ZhMIwchdZ2e9RECFjvUqgjDYMV5crywFWuPkP
   sEJmBXGwZS6jKlq2hadRfymxSOKW5zrDZOfBAKPQzpT66kfN+RueDahDM
   Qiogb+EW0jUc5doBjvt49tm/UAaY5JFL0uq+j5doUoPsuZiKIyvTN4b+T
   XFO2HaehfEdbU3+WJsenX57MVRcSAyfgrwH/kEIDwP9SLGhXE6LaRjmoY
   A==;
X-CSE-ConnectionGUID: 4sfcqwT4ST+n5qVfVtYspA==
X-CSE-MsgGUID: JAXKZ0RmT3eNNQF5vjNB7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63532359"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="63532359"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 05:13:27 -0700
X-CSE-ConnectionGUID: OGkivFu6RDqRDrKb2tYpKw==
X-CSE-MsgGUID: 0BttM1cKQaG033ollPg0Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="184923471"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa006.fm.intel.com with ESMTP; 27 Oct 2025 05:13:23 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	aleksander.lobakin@intel.com,
	ilias.apalodimas@linaro.org,
	toke@redhat.com,
	lorenzo@kernel.org,
	kuba@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Octavian Purdila <tavip@google.com>
Subject: [PATCH v4 bpf 1/2] xdp: introduce xdp_convert_skb_to_buff()
Date: Mon, 27 Oct 2025 13:13:17 +0100
Message-Id: <20251027121318.2679226-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20251027121318.2679226-1-maciej.fijalkowski@intel.com>
References: <20251027121318.2679226-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, generic XDP hook uses xdp_rxq_info from netstack Rx queues
which do not have its XDP memory model registered. There is a case when
XDP program calls bpf_xdp_adjust_tail() BPF helper, which in turn
releases underlying memory. This happens when it consumes enough amount
of bytes and when XDP buffer has fragments. For this action the memory
model knowledge passed to XDP program is crucial so that core can call
suitable function for freeing/recycling the page.

For netstack queues it defaults to MEM_TYPE_PAGE_SHARED (0) due to lack
of mem model registration. The problem we're fixing here is when kernel
copied the skb to new buffer backed by system's page_pool and XDP buffer
is built around it. Then when bpf_xdp_adjust_tail() calls
__xdp_return(), it acts incorrectly due to mem type not being set to
MEM_TYPE_PAGE_POOL and causes a page leak.

Pull out the existing code from bpf_prog_run_generic_xdp() that
init/prepares xdp_buff onto new helper xdp_convert_skb_to_buff() and
embed there rxq's mem_type initialization that is assigned to xdp_buff.
Make it agnostic to current skb->data position.

This problem was triggered by syzbot as well as AF_XDP test suite which
is about to be integrated to BPF CI.

Reported-by: syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6756c37b.050a0220.a30f1.019a.GAE@google.com/
Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Co-developed-by: Octavian Purdila <tavip@google.com>
Signed-off-by: Octavian Purdila <tavip@google.com> # whole analysis, testing, initiating a fix
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # commit msg and proposed more robust fix
---
 include/net/xdp.h | 25 +++++++++++++++++++++++++
 net/core/dev.c    | 25 ++++---------------------
 2 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c35..eba1c0cd5800 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -384,6 +384,31 @@ struct sk_buff *xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					 struct net_device *dev);
 struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf);
 
+static inline
+void xdp_convert_skb_to_buff(struct sk_buff *skb, struct xdp_buff *xdp,
+			     struct xdp_rxq_info *xdp_rxq)
+{
+	u32 frame_sz, pkt_len;
+
+	/* SKB "head" area always have tailroom for skb_shared_info */
+	frame_sz = skb_end_pointer(skb) - skb->head;
+	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	pkt_len =  skb_tail_pointer(skb) - skb_mac_header(skb);
+
+	xdp_init_buff(xdp, frame_sz, xdp_rxq);
+	xdp_prepare_buff(xdp, skb->head, skb->mac_header, pkt_len, true);
+
+	if (skb_is_nonlinear(skb)) {
+		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
+		xdp_buff_set_frags_flag(xdp);
+	} else {
+		xdp_buff_clear_frags_flag(xdp);
+	}
+
+	xdp->rxq->mem.type = page_pool_page_is_pp(virt_to_head_page(xdp->data)) ?
+				MEM_TYPE_PAGE_POOL : MEM_TYPE_PAGE_SHARED;
+}
+
 static inline
 void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
 			       struct xdp_buff *xdp)
diff --git a/net/core/dev.c b/net/core/dev.c
index 2acfa44927da..a71da4edc493 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5320,35 +5320,18 @@ static struct netdev_rx_queue *netif_get_rxqueue(struct sk_buff *skb)
 u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 			     const struct bpf_prog *xdp_prog)
 {
-	void *orig_data, *orig_data_end, *hard_start;
+	void *orig_data, *orig_data_end;
 	struct netdev_rx_queue *rxqueue;
 	bool orig_bcast, orig_host;
-	u32 mac_len, frame_sz;
+	u32 metalen, act, mac_len;
 	__be16 orig_eth_type;
 	struct ethhdr *eth;
-	u32 metalen, act;
 	int off;
 
-	/* The XDP program wants to see the packet starting at the MAC
-	 * header.
-	 */
+	rxqueue = netif_get_rxqueue(skb);
 	mac_len = skb->data - skb_mac_header(skb);
-	hard_start = skb->data - skb_headroom(skb);
-
-	/* SKB "head" area always have tailroom for skb_shared_info */
-	frame_sz = (void *)skb_end_pointer(skb) - hard_start;
-	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	rxqueue = netif_get_rxqueue(skb);
-	xdp_init_buff(xdp, frame_sz, &rxqueue->xdp_rxq);
-	xdp_prepare_buff(xdp, hard_start, skb_headroom(skb) - mac_len,
-			 skb_headlen(skb) + mac_len, true);
-	if (skb_is_nonlinear(skb)) {
-		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
-		xdp_buff_set_frags_flag(xdp);
-	} else {
-		xdp_buff_clear_frags_flag(xdp);
-	}
+	xdp_convert_skb_to_buff(skb, xdp, &rxqueue->xdp_rxq);
 
 	orig_data_end = xdp->data_end;
 	orig_data = xdp->data;
-- 
2.43.0


