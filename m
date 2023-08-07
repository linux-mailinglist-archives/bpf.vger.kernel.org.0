Return-Path: <bpf+bounces-7157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B627723E0
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 14:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B762812BB
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 12:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF35101EE;
	Mon,  7 Aug 2023 12:26:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E3C4436
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 12:26:29 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C98B128
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 05:26:27 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686b9964ae2so3025676b3a.3
        for <bpf@vger.kernel.org>; Mon, 07 Aug 2023 05:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691411186; x=1692015986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VNxERTokHn2QOzCO7nu1QH5j2GU8N7cGLZ9USDe1a7I=;
        b=UxOEpaG2o+xqx/J3NAFr9T/TXCrWhWtpPYaNl+rxWd6X06ltJfGQuZyB+mySSCYSOH
         OiBmgM1AndvMiLctAaeJGlS8Nn3YPNEnH3rXxClTohGrSXieLByWmK064JmlnmJzTOJt
         KKYC0h4iWIwAua6np92zxX6F9LG30TlbRT7XV2GLSrzz8L4quPJ4kcYB9PUWUwGLrzSX
         UQEdcqd9F687AKaceiRKcM9L7hxt5agKkQbKQkV8TKJO6EnR3PMkUHEJ825nfROlZeJR
         lXSUzwtEqxNLlKTYMCZ04bZkxWvNoAVqgwpuJvFols1+9RpvLvplwJyVfgpJxmcOSges
         /0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691411186; x=1692015986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNxERTokHn2QOzCO7nu1QH5j2GU8N7cGLZ9USDe1a7I=;
        b=Yb6Zg505Bx260BldfoXMw8T4OjpqoY0GCBs1RKmJP745ZZlVGFl+Xysb2RpAI8+JIw
         dZ2Up5j1wv04YEPnzX1E6rlHwyp9syjTT0FqQu0V+MmucexPQrEyk0XNX+j33L9VjLr8
         K+U821/1X3DQdtjX74P3QbhG5MYQ5fWYzRITuEHsWfAUM+KR26rV4TcfAk8C15AZqNFR
         fM/HTIcn3GPcJik8MAW1FovqS3SsFVIUjR5Fc6lIMKRUpOSK/de6MVFMI3xazVQJX/bW
         Xk928vRuNX8yzxRAfHoYSRRtZpHkPnsMZ22B6ZcrpH4ujjTpreVAtrJtidcYa3GIPulI
         C35g==
X-Gm-Message-State: AOJu0YxU5namwuu7rmsZvKmbMgyvFxqN8X7y9SZsdXMgiJ9gKhnxJ71N
	8KMCJ6bTWz54jIOydVOyvmbW5Q==
X-Google-Smtp-Source: AGHT+IGkLvXck+BgnTaLCKmOThWuPtHwOWLg4xPo4gzumYuiSTN4y35ZcW1uUAKYtat1ZPHip9hoIg==
X-Received: by 2002:a05:6a00:a17:b0:666:b0e7:10ea with SMTP id p23-20020a056a000a1700b00666b0e710eamr9238745pfh.31.1691411186600;
        Mon, 07 Aug 2023 05:26:26 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2408:8656:30f8:e020::b])
        by smtp.gmail.com with ESMTPSA id v19-20020aa78093000000b00672401787c6sm6060354pff.109.2023.08.07.05.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:26:25 -0700 (PDT)
From: Albert Huang <huangjie.albert@bytedance.com>
To: 
Cc: Albert Huang <huangjie.albert@bytedance.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path))
Subject: [RFC v2 Optimizing veth xsk performance 8/9] veth: af_xdp tx batch support for ipv4 udp
Date: Mon,  7 Aug 2023 20:26:17 +0800
Message-Id: <20230807122617.85882-1-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230807120434.83644-1-huangjie.albert@bytedance.com>
References: <20230807120434.83644-1-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

A typical topology is shown below:
veth<--------veth-peer
        1       |
                |2
                |
              bridge<------->eth0(such as mlnx5 NIC)

If you use af_xdp to send packets from veth to a physical NIC,
it needs to go through some software paths, so we can refer to
the implementation of kernel GSO. When af_xdp sends packets out
from veth, consider aggregating packets and send a large packet
from the veth virtual NIC to the physical NIC.

performance:(test weth libxdp lib)
AF_XDP without batch : 480 Kpps (with ksoftirqd 100% cpu)
AF_XDP  with   batch : 1.5 Mpps (with ksoftirqd 15% cpu)

With af_xdp batch, the libxdp user-space program reaches a bottleneck.
Therefore, the softirq did not reach the limit.

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 drivers/net/veth.c | 408 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 387 insertions(+), 21 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index ac78d6a87416..70489d017b51 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -29,6 +29,7 @@
 #include <net/page_pool.h>
 #include <net/xdp_sock_drv.h>
 #include <net/xdp.h>
+#include <net/udp.h>
 
 #define DRV_NAME	"veth"
 #define DRV_VERSION	"1.0"
@@ -103,6 +104,23 @@ struct veth_xdp_tx_bq {
 	unsigned int count;
 };
 
+struct veth_batch_tuple {
+	__u8	protocol;
+	__be32	saddr;
+	__be32	daddr;
+	__be16	source;
+	__be16	dest;
+	__be16	batch_size;
+	__be16	batch_segs;
+	bool    batch_enable;
+	bool    batch_flush;
+};
+
+struct veth_seg_info {
+	u32 segs;
+	u64 desc[] ____cacheline_aligned_in_smp;
+};
+
 /*
  * ethtool interface
  */
@@ -1078,11 +1096,340 @@ static struct sk_buff *veth_build_skb(void *head, int headroom, int len,
 	return skb;
 }
 
+static void veth_xsk_destruct_skb(struct sk_buff *skb)
+{
+	struct skb_shared_info *si = skb_shinfo(skb);
+	struct xsk_buff_pool *pool = (struct xsk_buff_pool *)si->destructor_arg_xsk_pool;
+	struct veth_seg_info *seg_info = (struct veth_seg_info *)si->destructor_arg;
+	unsigned long flags;
+	u32 index = 0;
+	u64 addr;
+
+	/* release cq */
+	spin_lock_irqsave(&pool->cq_lock, flags);
+	for (index = 0; index < seg_info->segs; index++) {
+		addr = (u64)(long)seg_info->desc[index];
+		xsk_tx_completed_addr(pool, addr);
+	}
+	spin_unlock_irqrestore(&pool->cq_lock, flags);
+
+	kfree(seg_info);
+	si->destructor_arg = NULL;
+	si->destructor_arg_xsk_pool = NULL;
+}
+
+static struct sk_buff *veth_build_gso_head_skb(struct net_device *dev,
+					       char *buff, u32 tot_len,
+					       u32 headroom, u32 iph_len,
+					       u32 th_len)
+{
+	struct sk_buff *skb = NULL;
+	int err = 0;
+
+	skb = alloc_skb(tot_len, GFP_KERNEL);
+	if (unlikely(!skb))
+		return NULL;
+
+	/* header room contains the eth header */
+	skb_reserve(skb, headroom - ETH_HLEN);
+	skb_put(skb, ETH_HLEN + iph_len + th_len);
+	skb_shinfo(skb)->gso_segs = 0;
+
+	err = skb_store_bits(skb, 0, buff, ETH_HLEN + iph_len + th_len);
+	if (unlikely(err)) {
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	skb->protocol = eth_type_trans(skb, dev);
+	skb->network_header = skb->mac_header + ETH_HLEN;
+	skb->transport_header = skb->network_header + iph_len;
+	skb->ip_summed = CHECKSUM_PARTIAL;
+
+	return skb;
+}
+
+/* only ipv4 udp match
+ * to do: tcp and ipv6
+ */
+static inline bool veth_segment_match(struct veth_batch_tuple *tuple,
+				      struct iphdr *iph, struct udphdr *udph)
+{
+	if (tuple->protocol == iph->protocol &&
+	    tuple->saddr == iph->saddr &&
+		tuple->daddr == iph->daddr &&
+		tuple->source == udph->source &&
+		tuple->dest == udph->dest &&
+		tuple->batch_size == ntohs(udph->len)) {
+		tuple->batch_flush = false;
+		return true;
+	}
+
+	tuple->batch_flush = true;
+	return false;
+}
+
+static inline void veth_tuple_init(struct veth_batch_tuple *tuple,
+				   struct iphdr *iph, struct udphdr *udph)
+{
+	tuple->protocol = iph->protocol;
+	tuple->saddr = iph->saddr;
+	tuple->daddr = iph->daddr;
+	tuple->source = udph->source;
+	tuple->dest = udph->dest;
+	tuple->batch_flush = false;
+	tuple->batch_size = ntohs(udph->len);
+	tuple->batch_segs = 0;
+}
+
+static inline bool veth_batch_ip_check_v4(struct iphdr *iph, u32 len)
+{
+	if (len <= (ETH_HLEN + sizeof(*iph)))
+		return false;
+
+	if (iph->ihl < 5 || iph->version != 4 || len < (iph->ihl * 4 + ETH_HLEN))
+		return false;
+
+	return true;
+}
+
+static struct sk_buff *veth_build_skb_batch_udp(struct net_device *dev,
+						struct xsk_buff_pool *pool,
+						struct xdp_desc *desc,
+						struct veth_batch_tuple *tuple,
+						struct sk_buff *prev_skb)
+{
+	u32 hr, len, ts, index, iph_len, th_len, data_offset, data_len, tot_len;
+	struct veth_seg_info *seg_info;
+	void *buffer;
+	struct udphdr *udph;
+	struct iphdr *iph;
+	struct sk_buff *skb;
+	struct page *page;
+	u32 seg_len = 0;
+	int hh_len = 0;
+	u64 addr;
+
+	addr = desc->addr;
+	len = desc->len;
+
+	/* l2 reserved len */
+	hh_len = LL_RESERVED_SPACE(dev);
+	hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(hh_len));
+
+	/* data points to eth header */
+	buffer = (unsigned char *)xsk_buff_raw_get_data(pool, addr);
+
+	iph = (struct iphdr *)(buffer + ETH_HLEN);
+	iph_len = iph->ihl * 4;
+
+	udph = (struct udphdr *)(buffer + ETH_HLEN + iph_len);
+	th_len = sizeof(struct udphdr);
+
+	if (tuple->batch_flush)
+		veth_tuple_init(tuple, iph, udph);
+
+	ts = pool->unaligned ? len : pool->chunk_size;
+
+	data_offset = offset_in_page(buffer) + ETH_HLEN + iph_len + th_len;
+	data_len = len - (ETH_HLEN + iph_len + th_len);
+
+	/* head is null or this is a new 5 tuple */
+	if (!prev_skb || !veth_segment_match(tuple, iph, udph)) {
+		tot_len = hr + iph_len + th_len;
+		skb = veth_build_gso_head_skb(dev, buffer, tot_len, hr, iph_len, th_len);
+		if (!skb) {
+			/* to do: handle here for skb */
+			return NULL;
+		}
+
+		/* store information for gso */
+		seg_len = struct_size(seg_info, desc, MAX_SKB_FRAGS);
+		seg_info = kmalloc(seg_len, GFP_KERNEL);
+		if (!seg_info) {
+			/* to do */
+			kfree_skb(skb);
+			return NULL;
+		}
+	} else {
+		skb = prev_skb;
+		skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4 | SKB_GSO_PARTIAL;
+		skb_shinfo(skb)->gso_size = data_len;
+		skb->ip_summed = CHECKSUM_PARTIAL;
+
+		/* max segment is MAX_SKB_FRAGS */
+		if (skb_shinfo(skb)->gso_segs >= MAX_SKB_FRAGS - 1)
+			tuple->batch_flush = true;
+
+		seg_info = (struct veth_seg_info *)skb_shinfo(skb)->destructor_arg;
+	}
+
+	/* offset in umem pool buffer */
+	addr = buffer - pool->addrs;
+
+	/* get the page of the desc */
+	page = pool->umem->pgs[addr >> PAGE_SHIFT];
+
+	/* in order to avoid to get freed by kfree_skb */
+	get_page(page);
+
+	/* desc.data can not hold in two */
+	skb_fill_page_desc(skb, skb_shinfo(skb)->gso_segs, page, data_offset, data_len);
+
+	skb->len += data_len;
+	skb->data_len += data_len;
+	skb->truesize += ts;
+	skb->dev = dev;
+
+	/* later we will support gso for this */
+	index = skb_shinfo(skb)->gso_segs;
+	seg_info->desc[index] = desc->addr;
+	seg_info->segs = ++index;
+	skb_shinfo(skb)->gso_segs++;
+
+	skb_shinfo(skb)->destructor_arg = (void *)(long)seg_info;
+	skb_shinfo(skb)->destructor_arg_xsk_pool = (void *)(long)pool;
+	skb->destructor = veth_xsk_destruct_skb;
+
+	/* to do:
+	 *  add skb to sock. may be there is no need to do for this
+	 *  and this might be multiple xsk sockets involved, so it's
+	 *  difficult to determine which socket is sending the data.
+	 *  refcount_add(ts, &xs->sk.sk_wmem_alloc);
+	 */
+	return skb;
+}
+
+static inline struct sk_buff *veth_build_skb_def(struct net_device *dev,
+						 struct xsk_buff_pool *pool, struct xdp_desc *desc)
+{
+	struct sk_buff *skb = NULL;
+	struct page *page;
+	void *buffer;
+	void *vaddr;
+
+	page = dev_alloc_page();
+	if (!page)
+		return NULL;
+
+	buffer = (unsigned char *)xsk_buff_raw_get_data(pool, desc->addr);
+
+	vaddr = page_to_virt(page);
+	memcpy(vaddr + pool->headroom, buffer, desc->len);
+	skb = veth_build_skb(vaddr, pool->headroom, desc->len, PAGE_SIZE);
+	if (!skb) {
+		put_page(page);
+		return NULL;
+	}
+
+	skb->protocol = eth_type_trans(skb, dev);
+
+	return skb;
+}
+
+/* To call the following function, the following conditions must be met:
+ * 1.The data packet must be a standard Ethernet data packet
+ * 2. Data packets support batch sending
+ */
+static inline struct sk_buff *veth_build_skb_batch_v4(struct net_device *dev,
+						      struct xsk_buff_pool *pool,
+						      struct xdp_desc *desc,
+						      struct veth_batch_tuple *tuple,
+						      struct sk_buff *prev_skb)
+{
+	struct iphdr *iph;
+	void *buffer;
+	u64 addr;
+
+	addr = desc->addr;
+	buffer = (unsigned char *)xsk_buff_raw_get_data(pool, addr);
+	iph = (struct iphdr *)(buffer + ETH_HLEN);
+	if (!veth_batch_ip_check_v4(iph, desc->len))
+		goto normal;
+
+	switch (iph->protocol) {
+	case IPPROTO_UDP:
+		return veth_build_skb_batch_udp(dev, pool, desc, tuple, prev_skb);
+	default:
+		break;
+	}
+normal:
+	tuple->batch_enable = false;
+	return veth_build_skb_def(dev, pool, desc);
+}
+
+/* Zero copy needs to meet the following conditions：
+ * 1. The data content of tx desc must be within one page
+ * 2、the tx desc must support batch xmit, which seted by userspace
+ */
+static inline bool veth_batch_desc_check(void *buff, u32 len)
+{
+	u32 offset;
+
+	offset = offset_in_page(buff);
+	if (PAGE_SIZE - offset < len)
+		return false;
+
+	return true;
+}
+
+/* here must be a ipv4 or ipv6 packet */
+static inline struct sk_buff *veth_build_skb_batch(struct net_device *dev,
+						   struct xsk_buff_pool *pool,
+						   struct xdp_desc *desc,
+						   struct veth_batch_tuple *tuple,
+						   struct sk_buff *prev_skb)
+{
+	const struct ethhdr *eth;
+	void *buffer;
+
+	buffer = xsk_buff_raw_get_data(pool, desc->addr);
+	if (!veth_batch_desc_check(buffer, desc->len))
+		goto normal;
+
+	eth = (struct ethhdr *)buffer;
+	switch (ntohs(eth->h_proto)) {
+	case ETH_P_IP:
+		tuple->batch_enable = true;
+		return veth_build_skb_batch_v4(dev, pool, desc, tuple, prev_skb);
+	/* to do: not support yet, just build skb, no batch */
+	case ETH_P_IPV6:
+		fallthrough;
+	default:
+		break;
+	}
+
+normal:
+	tuple->batch_flush = false;
+	tuple->batch_enable = false;
+	return veth_build_skb_def(dev, pool, desc);
+}
+
+/* just support ipv4 udp batch
+ * to do: ipv4 tcp and ipv6
+ */
+static inline void veth_skb_batch_checksum(struct sk_buff *skb)
+{
+	struct iphdr *iph = ip_hdr(skb);
+	struct udphdr *uh = udp_hdr(skb);
+	int ip_tot_len = skb->len;
+	int udp_len = skb->len - (skb->transport_header - skb->network_header);
+
+	iph->tot_len = htons(ip_tot_len);
+	ip_send_check(iph);
+	uh->len = htons(udp_len);
+	uh->check = 0;
+
+	udp4_hwcsum(skb, iph->saddr, iph->daddr);
+}
+
 static int veth_xsk_tx_xmit(struct veth_sq *sq, struct xsk_buff_pool *xsk_pool, int budget)
 {
 	struct veth_priv *priv, *peer_priv;
 	struct net_device *dev, *peer_dev;
+	struct veth_batch_tuple tuple;
 	struct veth_stats stats = {};
+	struct sk_buff *prev_skb = NULL;
 	struct sk_buff *skb = NULL;
 	struct veth_rq *peer_rq;
 	struct xdp_desc desc;
@@ -1093,24 +1440,23 @@ static int veth_xsk_tx_xmit(struct veth_sq *sq, struct xsk_buff_pool *xsk_pool,
 	peer_dev = priv->peer;
 	peer_priv = netdev_priv(peer_dev);
 
-	/* todo: queue index must set before this */
+	/* queue_index set in napi enable
+	 * to do:may be we should select rq by 5-tuple or hash
+	 */
 	peer_rq = &peer_priv->rq[sq->queue_index];
 
+	memset(&tuple, 0, sizeof(tuple));
+
 	/* set xsk wake up flag, to do: where to disable */
 	if (xsk_uses_need_wakeup(xsk_pool))
 		xsk_set_tx_need_wakeup(xsk_pool);
 
 	while (budget-- > 0) {
 		unsigned int truesize = 0;
-		struct page *page;
-		void *vaddr;
-		void *addr;
 
 		if (!xsk_tx_peek_desc(xsk_pool, &desc))
 			break;
 
-		addr = xsk_buff_raw_get_data(xsk_pool, desc.addr);
-
 		/* can not hold all data in a page */
 		truesize =  SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 		truesize += desc.len + xsk_pool->headroom;
@@ -1120,30 +1466,50 @@ static int veth_xsk_tx_xmit(struct veth_sq *sq, struct xsk_buff_pool *xsk_pool,
 			break;
 		}
 
-		page = dev_alloc_page();
-		if (!page) {
+		skb = veth_build_skb_batch(peer_dev, xsk_pool, &desc, &tuple, prev_skb);
+		if (!skb) {
+			stats.rx_drops++;
 			xsk_tx_completed_addr(xsk_pool, desc.addr);
-			stats.xdp_drops++;
-			break;
+			if (prev_skb != skb) {
+				napi_gro_receive(&peer_rq->xdp_napi, prev_skb);
+				prev_skb = NULL;
+			}
+			continue;
 		}
-		vaddr = page_to_virt(page);
-
-		memcpy(vaddr + xsk_pool->headroom, addr, desc.len);
-		xsk_tx_completed_addr(xsk_pool, desc.addr);
 
-		skb = veth_build_skb(vaddr, xsk_pool->headroom, desc.len, PAGE_SIZE);
-		if (!skb) {
-			put_page(page);
-			stats.xdp_drops++;
-			break;
+		if (!tuple.batch_enable) {
+			xsk_tx_completed_addr(xsk_pool, desc.addr);
+			/* flush the prev skb first to avoid out of order */
+			if (prev_skb != skb && prev_skb) {
+				veth_skb_batch_checksum(prev_skb);
+				napi_gro_receive(&peer_rq->xdp_napi, prev_skb);
+				prev_skb = NULL;
+			}
+			napi_gro_receive(&peer_rq->xdp_napi, skb);
+			skb = NULL;
+		} else {
+			if (prev_skb && tuple.batch_flush) {
+				veth_skb_batch_checksum(prev_skb);
+				napi_gro_receive(&peer_rq->xdp_napi, prev_skb);
+				if (prev_skb == skb)
+					prev_skb = skb = NULL;
+				else
+					prev_skb = skb;
+			} else {
+				prev_skb = skb;
+			}
 		}
-		skb->protocol = eth_type_trans(skb, peer_dev);
-		napi_gro_receive(&peer_rq->xdp_napi, skb);
 
 		stats.xdp_bytes += desc.len;
 		done++;
 	}
 
+	/* means there is a skb need to send to peer_rq (batch)*/
+	if (skb) {
+		veth_skb_batch_checksum(skb);
+		napi_gro_receive(&peer_rq->xdp_napi, skb);
+	}
+
 	/* release, move consumer，and wakeup the producer */
 	if (done) {
 		napi_schedule(&peer_rq->xdp_napi);
-- 
2.20.1


