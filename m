Return-Path: <bpf+bounces-72917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F7DC1D929
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 23:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09C5A4E3CCC
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 22:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B08431D378;
	Wed, 29 Oct 2025 22:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BBbCWhc+"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6E731A7F3;
	Wed, 29 Oct 2025 22:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761776006; cv=none; b=t9nSQuwN13xHeipdvgtaAF6DmBjHCY58lBq0zKgVOBRWEO2V7bB19y2VTGYmJ5mebpzMxSarjQLsOA1a+vGdKxyDJmgDUnUG4dpKRqrh9p4pXX30+1yshLMCalApZbIYKCP8ampBb6hPLNjaGJWoiqwnoxmDUEABPMpXD345mh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761776006; c=relaxed/simple;
	bh=ftYO1OIX4JMgjyoMgDRntiMe+EeWXx0jCXgBSiaO9eo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnPaI5qqC/dwpUb86KMKwy+cUO+zyARslVPI4t1yQ20EVTfobGXabAXR/K08z7QfRDFriJsSmoWmSOn36qHuP+dY5PYlZiHtcJPXrMDoENmzYyW0TgNBgUJCcg91Dmeh9kgnzMzJvw3FFqSp67bUtjAujSDO0CSu75Kzsfuwj7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BBbCWhc+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761776005; x=1793312005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ftYO1OIX4JMgjyoMgDRntiMe+EeWXx0jCXgBSiaO9eo=;
  b=BBbCWhc+WcUC17kud8MYB99lWzU1OqWCI2SOB7eQyZWDHeSOHqV++1UT
   8ItDuHGH3hnKr/4Dz+l0Fj2BrxDFr7vwbhstt0kWQb/77govV0StRe5sQ
   QcHZHh/ryYCI2Z8KxkuAG0+e++lZzC0R6+A9FZ3tv95yzxGi3wNa8jlkk
   cQsXEk7PK3xv04LU480j3cdq6c+qDIMO9fe44X7aWJ7/QzmM45QaEnJyW
   /1kszRPkgqgYg5VEw/WM/E7qD9drX/95vMYf+5JxwHkkYrVKy51+q22vK
   9kxk6CsvgPdWTyK9J1NnV0qNPBvKokc6QUmDq/Fy40vlaFSmxnQYX7nre
   Q==;
X-CSE-ConnectionGUID: GesuagSERoeWXJSBYKz2sQ==
X-CSE-MsgGUID: qzu8nvbjRCOrrvKGcHGC5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63820768"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="63820768"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 15:13:25 -0700
X-CSE-ConnectionGUID: irebUADoTQyCwS6e+OaZAw==
X-CSE-MsgGUID: QVSODTxUTcGnDk2fyMi9rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="216643393"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa001.fm.intel.com with ESMTP; 29 Oct 2025 15:13:22 -0700
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
Subject: [PATCH v5 bpf 1/2] xdp: introduce xdp_convert_skb_to_buff()
Date: Wed, 29 Oct 2025 23:13:14 +0100
Message-Id: <20251029221315.2694841-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20251029221315.2694841-1-maciej.fijalkowski@intel.com>
References: <20251029221315.2694841-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Co-developed-by: Octavian Purdila <tavip@google.com>
Signed-off-by: Octavian Purdila <tavip@google.com> # whole analysis, testing, initiating a fix
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # commit msg and proposed more robust fix
---
 include/net/xdp.h | 25 +++++++++++++++++++++++++
 net/core/dev.c    | 25 ++++---------------------
 2 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index aa742f413c35..be7cc2eb956d 100644
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
+	xdp->rxq->mem.type = skb->pp_recycle ? MEM_TYPE_PAGE_POOL :
+					       MEM_TYPE_PAGE_SHARED;
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


