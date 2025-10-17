Return-Path: <bpf+bounces-71214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E533BE9347
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 16:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1CDD19A0A9F
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 14:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A315032C95B;
	Fri, 17 Oct 2025 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="faJ38qhh"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832272F691D;
	Fri, 17 Oct 2025 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711490; cv=none; b=knd3P7HpEnwzNwmAD/oZmS1UiUfmC9YUQV77eWHUiZ/AUjzDZZjB0ltFSmT5+YSP23viCs8yBG5cusfjbasDTGebQBY2j0qNWyf4PE6SiQ18HYzTG7xVCjoleyiT74N8MnztNUs0H3wFm+yrIj0ZxL2w2pau8yPvxmWAV777+OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711490; c=relaxed/simple;
	bh=7Y6F4kqj2dNrNnUp3rdoafp9+vq7dXhvE2/npV8n2co=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QEDq4pT89lNA9zxuNhJEGlJJ1SO/deHuhn1+Q23mnU1FeANjZweCvIoADLvBlKBnNxcQ3aKdmhopiHREAe6Ll63yRHNHxZvcZsMLFRBbVqFkyXiTLJGzwekPBp0gqvGKJZtov2olGY/4qkl23s6BS4rULETIC7wxStV5zajRALw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=faJ38qhh; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760711489; x=1792247489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Y6F4kqj2dNrNnUp3rdoafp9+vq7dXhvE2/npV8n2co=;
  b=faJ38qhhiM3vr1kb3gQKK+gymNOuT+6XCzD0mih9y0GYBTaT2Bxpvq4q
   9hJyEzqAbHxq40K06c+y1GHidYdn1FWSIXY2nDy6DUS4CEfg4GX9DjaLD
   duZs1rQqLmjEJP1RbsqbX1kW6NZjDvx+ijN1B54Vy1yrmkQfrHiLEJv6e
   Wp2iqaORmkjqqzKOw34GG65qpcHCqBPkIigImw4A19z6btLsl2P+0Zocx
   Yk1ZTi4ux82esxMRBP9T17PacG6Tqp/wPwNtcaiAjARhH11iXWo0VMJ69
   +2lOukcbh5KwVXGar2u2VUu8aAe9GQQJM6tk7v9dVTgr5J+JbsPwWrpk0
   g==;
X-CSE-ConnectionGUID: 2Q5RnhjDQ2OI9SOJb1AU8Q==
X-CSE-MsgGUID: wxI5WSlaTh+PcvZXbjUdUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="73208027"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="73208027"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 07:31:28 -0700
X-CSE-ConnectionGUID: hqgR7Cu/S7OpjmSoNnsHkQ==
X-CSE-MsgGUID: Sev4K3DvTY613zjbMeioLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="213717402"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa001.fm.intel.com with ESMTP; 17 Oct 2025 07:31:25 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	toke@redhat.com,
	lorenzo@kernel.org,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	andrii@kernel.org,
	stfomichev@gmail.com,
	aleksander.lobakin@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Octavian Purdila <tavip@google.com>
Subject: [PATCH v2 bpf 1/2] xdp: update xdp_rxq_info's mem type in XDP generic hook
Date: Fri, 17 Oct 2025 16:31:02 +0200
Message-Id: <20251017143103.2620164-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20251017143103.2620164-1-maciej.fijalkowski@intel.com>
References: <20251017143103.2620164-1-maciej.fijalkowski@intel.com>
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
 include/net/xdp.h | 31 +++++++++++++++++++++++++++++++
 net/core/dev.c    | 25 ++++---------------------
 2 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c35..51f3321e4f94 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -384,6 +384,37 @@ struct sk_buff *xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					 struct net_device *dev);
 struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf);
 
+static inline
+void xdp_convert_skb_to_buff(struct sk_buff *skb, struct xdp_buff *xdp,
+			     struct xdp_rxq_info *xdp_rxq)
+{
+	u32 frame_sz, mac_len;
+	void *hard_start;
+
+	/* The XDP program wants to see the packet starting at the MAC
+	 * header.
+	 */
+	mac_len = skb->data - skb_mac_header(skb);
+	hard_start = skb->data - skb_headroom(skb);
+
+	/* SKB "head" area always have tailroom for skb_shared_info */
+	frame_sz = skb_end_pointer(skb) - skb->head;
+	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	xdp_init_buff(xdp, frame_sz, xdp_rxq);
+	xdp_prepare_buff(xdp, hard_start, skb_headroom(skb) - mac_len,
+			 skb_headlen(skb) + mac_len, true);
+
+	if (skb_is_nonlinear(skb)) {
+		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
+		xdp_buff_set_frags_flag(xdp);
+	} else {
+		xdp_buff_clear_frags_flag(xdp);
+	}
+
+	xdp->rxq->mem.type = page_pool_page_is_pp(virt_to_page(xdp->data)) ?
+				MEM_TYPE_PAGE_POOL : MEM_TYPE_PAGE_SHARED;
+}
+
 static inline
 void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
 			       struct xdp_buff *xdp)
diff --git a/net/core/dev.c b/net/core/dev.c
index a64cef2c537e..3d607dce292b 100644
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


