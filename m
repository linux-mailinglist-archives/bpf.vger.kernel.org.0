Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEAA2DC722
	for <lists+bpf@lfdr.de>; Wed, 16 Dec 2020 20:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388763AbgLPTdD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Dec 2020 14:33:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:57344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388756AbgLPTdD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Dec 2020 14:33:03 -0500
From:   Lorenzo Bianconi <lorenzo@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, brouer@redhat.com,
        lorenzo.bianconi@redhat.com, toshiaki.makita1@gmail.com
Subject: [PATCH bpf-next 1/2] net: xdp: introduce __xdp_build_skb_from_frame utility routine
Date:   Wed, 16 Dec 2020 19:38:33 +0100
Message-Id: <40b3a47fb35b06871bd280564a352b33dcf96c95.1608142960.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1608142960.git.lorenzo@kernel.org>
References: <cover.1608142960.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce __xdp_build_skb_from_frame utility routine to build
the skb from xdp_frame. Rely on __xdp_build_skb_from_frame in
cpumap code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/xdp.h   |  3 +++
 kernel/bpf/cpumap.c | 45 +--------------------------------------------
 net/core/xdp.c      | 44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 44 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 600acb307db6..da62fa20fa8a 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -145,6 +145,9 @@ void xdp_warn(const char *msg, const char *func, const int line);
 #define XDP_WARN(msg) xdp_warn(msg, __func__, __LINE__)
 
 struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp);
+struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
+					   struct sk_buff *skb,
+					   struct net_device *dev);
 
 static inline
 void xdp_convert_frame_to_buff(struct xdp_frame *frame, struct xdp_buff *xdp)
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 747313698178..49113880b82a 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -141,49 +141,6 @@ static void cpu_map_kthread_stop(struct work_struct *work)
 	kthread_stop(rcpu->kthread);
 }
 
-static struct sk_buff *cpu_map_build_skb(struct xdp_frame *xdpf,
-					 struct sk_buff *skb)
-{
-	unsigned int hard_start_headroom;
-	unsigned int frame_size;
-	void *pkt_data_start;
-
-	/* Part of headroom was reserved to xdpf */
-	hard_start_headroom = sizeof(struct xdp_frame) +  xdpf->headroom;
-
-	/* Memory size backing xdp_frame data already have reserved
-	 * room for build_skb to place skb_shared_info in tailroom.
-	 */
-	frame_size = xdpf->frame_sz;
-
-	pkt_data_start = xdpf->data - hard_start_headroom;
-	skb = build_skb_around(skb, pkt_data_start, frame_size);
-	if (unlikely(!skb))
-		return NULL;
-
-	skb_reserve(skb, hard_start_headroom);
-	__skb_put(skb, xdpf->len);
-	if (xdpf->metasize)
-		skb_metadata_set(skb, xdpf->metasize);
-
-	/* Essential SKB info: protocol and skb->dev */
-	skb->protocol = eth_type_trans(skb, xdpf->dev_rx);
-
-	/* Optional SKB info, currently missing:
-	 * - HW checksum info		(skb->ip_summed)
-	 * - HW RX hash			(skb_set_hash)
-	 * - RX ring dev queue index	(skb_record_rx_queue)
-	 */
-
-	/* Until page_pool get SKB return path, release DMA here */
-	xdp_release_frame(xdpf);
-
-	/* Allow SKB to reuse area used by xdp_frame */
-	xdp_scrub_frame(xdpf);
-
-	return skb;
-}
-
 static void __cpu_map_ring_cleanup(struct ptr_ring *ring)
 {
 	/* The tear-down procedure should have made sure that queue is
@@ -350,7 +307,7 @@ static int cpu_map_kthread_run(void *data)
 			struct sk_buff *skb = skbs[i];
 			int ret;
 
-			skb = cpu_map_build_skb(xdpf, skb);
+			skb = __xdp_build_skb_from_frame(xdpf, skb, xdpf->dev_rx);
 			if (!skb) {
 				xdp_return_frame(xdpf);
 				continue;
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 3a8c9ab4ecbe..aeb09ed0704c 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -513,3 +513,47 @@ void xdp_warn(const char *msg, const char *func, const int line)
 	WARN(1, "XDP_WARN: %s(line:%d): %s\n", func, line, msg);
 };
 EXPORT_SYMBOL_GPL(xdp_warn);
+
+struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
+					   struct sk_buff *skb,
+					   struct net_device *dev)
+{
+	unsigned int headroom, frame_size;
+	void *hard_start;
+
+	/* Part of headroom was reserved to xdpf */
+	headroom = sizeof(*xdpf) + xdpf->headroom;
+
+	/* Memory size backing xdp_frame data already have reserved
+	 * room for build_skb to place skb_shared_info in tailroom.
+	 */
+	frame_size = xdpf->frame_sz;
+
+	hard_start = xdpf->data - headroom;
+	skb = build_skb_around(skb, hard_start, frame_size);
+	if (unlikely(!skb))
+		return NULL;
+
+	skb_reserve(skb, headroom);
+	__skb_put(skb, xdpf->len);
+	if (xdpf->metasize)
+		skb_metadata_set(skb, xdpf->metasize);
+
+	/* Essential SKB info: protocol and skb->dev */
+	skb->protocol = eth_type_trans(skb, dev);
+
+	/* Optional SKB info, currently missing:
+	 * - HW checksum info		(skb->ip_summed)
+	 * - HW RX hash			(skb_set_hash)
+	 * - RX ring dev queue index	(skb_record_rx_queue)
+	 */
+
+	/* Until page_pool get SKB return path, release DMA here */
+	xdp_release_frame(xdpf);
+
+	/* Allow SKB to reuse area used by xdp_frame */
+	xdp_scrub_frame(xdpf);
+
+	return skb;
+}
+EXPORT_SYMBOL_GPL(__xdp_build_skb_from_frame);
-- 
2.29.2

