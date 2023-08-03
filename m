Return-Path: <bpf+bounces-6867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC88976EC00
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 16:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1521C215B5
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 14:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF482419D;
	Thu,  3 Aug 2023 14:07:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F74121D57
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 14:07:13 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD53212D
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 07:07:08 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bb893e6365so6855305ad.2
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 07:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691071628; x=1691676428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2IExsisHLl5wetq8sgZJvv6YFTcLdIhC4TMC2ESGVY=;
        b=Oo5SDTLnzyXY8qDJYDdgxiSm5KInG31WNp+6s7Aw/7vgUIpls7XV7PDYHeze+UBg5n
         DNl2lunWdtdOaDHXuIxE5JrJyhPZkrGSa5Td1Oqf49qpwWw8PUrIhrB7fyBHyv9odtE/
         2qhsRMSNlJy/L5ER8K/Vh3MdsTTXMR3Gnygwt5BAmPJvMOF3dflvGX+gQaOJXTqq16QM
         P5ltuB+AVoHAG8A95Q946y5BIfsKc/I92jLgMKQ0AYzhnBfHhIGGNmOqSujdFbxrxmja
         ioZjmD0Md1lh9M3POXnCgEhPxjLWOm1sgM3OhCN/Kk0TToqHwyEuF4xyR9Y7y+KH8Otp
         jFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071628; x=1691676428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/2IExsisHLl5wetq8sgZJvv6YFTcLdIhC4TMC2ESGVY=;
        b=CQn9CVMsLPP657foD1P8IpRueZybwHq3wQHSA9ZGnZjrPy72Ob4zaaFCuSs9exR3+g
         Yr2fEu1K+j96Bll5jJ047r3lV7N2TF/AbBTPIVLzXcCvuQd07hywRn0whtTEDBr9FapZ
         TB/c65baTq02358v7NdhoP6LQq1XlyfIszYIEKdwMsY4twmj2Zxzzb7c6y9vfJngunuH
         jGQENZ9+lx4+jW2Ktba7rUDlnN6ZqkoIN7W+2z5WByKIFXC/e/Y1hZt0bryEPn/HaWYX
         yZS3lzUJSI3mjUTJWC9445obAvP4yRfKcUYVvI9SaYjOaC3PditAfY0tLxU9DlnJTYvk
         VBtQ==
X-Gm-Message-State: ABy/qLYDfGq6eTSUS8ERP/SRMTKYvA9KQU8BrOb88WHyfU/C9DW7eHoE
	MI2wniszGbMYTDxVvQhmXIUxjc62mBn5l7c4dCV+zw==
X-Google-Smtp-Source: APBJJlGM8RoAE6cD3VioW4CUSFeL+hHwLfuzL1GJ4xLv4TINBL02vq+XY8MB4/1oSJTMpPWFx/47lg==
X-Received: by 2002:a17:902:ea08:b0:1bb:893e:5df5 with SMTP id s8-20020a170902ea0800b001bb893e5df5mr22673401plg.34.1691071627752;
        Thu, 03 Aug 2023 07:07:07 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2001:c10:ff04:0:1000::8])
        by smtp.gmail.com with ESMTPSA id ji11-20020a170903324b00b001b8a897cd26sm14367485plb.195.2023.08.03.07.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:07:07 -0700 (PDT)
From: "huangjie.albert" <huangjie.albert@bytedance.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: "huangjie.albert" <huangjie.albert@bytedance.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Kees Cook <keescook@chromium.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path))
Subject: [RFC Optimizing veth xsk performance 10/10] veth: af_xdp tx batch support for ipv4 udp
Date: Thu,  3 Aug 2023 22:04:36 +0800
Message-Id: <20230803140441.53596-11-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230803140441.53596-1-huangjie.albert@bytedance.com>
References: <20230803140441.53596-1-huangjie.albert@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
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

Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
---
 drivers/net/veth.c | 264 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 249 insertions(+), 15 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index e4f1a8345f42..b0dbd21089c8 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -29,6 +29,7 @@
 #include <net/page_pool.h>
 #include <net/xdp_sock_drv.h>
 #include <net/xdp.h>
+#include <net/udp.h>
 
 #define DRV_NAME	"veth"
 #define DRV_VERSION	"1.0"
@@ -103,6 +104,18 @@ struct veth_xdp_tx_bq {
 	unsigned int count;
 };
 
+struct veth_gso_tuple {
+	__u8	protocol;
+	__be32	saddr;
+	__be32	daddr;
+	__be16	source;
+	__be16	dest;
+	__be16	gso_size;
+	__be16	gso_segs;
+	bool gso_enable;
+	bool gso_flush;
+};
+
 struct veth_seg_info {
 	u32 segs;
 	u64 desc[] ____cacheline_aligned_in_smp;
@@ -650,6 +663,84 @@ static int veth_xdp_tx(struct veth_rq *rq, struct xdp_buff *xdp,
 	return 0;
 }
 
+static struct sk_buff *veth_build_gso_head_skb(struct net_device *dev, char *buff, u32 tot_len, u32 headroom, u32 iph_len, u32 th_len)
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
+
+	skb_put(skb, ETH_HLEN + iph_len + th_len);
+
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
+static inline bool gso_segment_match(struct veth_gso_tuple *gso_tuple, struct iphdr *iph, struct udphdr *udph)
+{
+	if (gso_tuple->protocol == iph->protocol &&
+		gso_tuple->saddr == iph->saddr &&
+		gso_tuple->daddr == iph->daddr &&
+		gso_tuple->source == udph->source &&
+		gso_tuple->dest == udph->dest &&
+		gso_tuple->gso_size == ntohs(udph->len))
+	{
+		gso_tuple->gso_flush = false;
+		return true;
+	} else {
+		gso_tuple->gso_flush = true;
+		return false;
+	}
+}
+
+static inline void gso_tuple_init(struct veth_gso_tuple *gso_tuple, struct iphdr *iph, struct udphdr *udph)
+{
+	gso_tuple->protocol = iph->protocol;
+	gso_tuple->saddr = iph->saddr;
+	gso_tuple->daddr = iph->daddr;
+	gso_tuple->source = udph->source;
+	gso_tuple->dest = udph->dest;
+	gso_tuple->gso_flush = false;
+	gso_tuple->gso_size = ntohs(udph->len);
+	gso_tuple->gso_segs = 0;
+}
+
+/* only ipv4 udp support gso now */
+static inline bool ip_hdr_gso_check(unsigned char *buff, u32 len)
+{
+	struct iphdr *iph;
+
+	if (len <= (ETH_HLEN + sizeof(*iph)))
+		return false;
+
+	iph = (struct iphdr *)(buff + ETH_HLEN);
+
+	/*
+	 * check for ip headers, if the data support gso
+	 */
+	if (iph->ihl < 5 || iph->version != 4 || len < (iph->ihl * 4 + ETH_HLEN) || iph->protocol != IPPROTO_UDP)
+		return false;
+
+	return true;
+}
+
 static struct sk_buff *veth_build_skb(void *head, int headroom, int len,
 				      int buflen)
 {
@@ -686,8 +777,8 @@ static void veth_xsk_destruct_skb(struct sk_buff *skb)
 	skb_shinfo(skb)->destructor_arg_xsk_pool = NULL;
 }
 
-static struct sk_buff *veth_build_skb_zerocopy(struct net_device *dev, struct xsk_buff_pool *pool,
-					      struct xdp_desc *desc)
+static struct sk_buff *veth_build_skb_zerocopy_normal(struct net_device *dev,
+		struct xsk_buff_pool *pool, struct xdp_desc *desc)
 {
 	struct veth_seg_info *seg_info;
 	struct sk_buff *skb;
@@ -698,45 +789,133 @@ static struct sk_buff *veth_build_skb_zerocopy(struct net_device *dev, struct xs
 	int headroom;
 	u64 addr;
 	u32 index;
-
 	addr = desc->addr;
 	len = desc->len;
 	buffer = xsk_buff_raw_get_data(pool, addr);
 	ts = pool->unaligned ? len : pool->chunk_size;
-
 	headroom = offset_in_page(buffer);
-
 	/* offset in umem pool buffer */
 	addr = buffer - pool->addrs;
-
 	/* get the page of the desc */
 	page = pool->umem->pgs[addr >> PAGE_SHIFT];
-
 	/* in order to avoid to get freed by kfree_skb */
 	get_page(page);
-
 	hard_start = page_to_virt(page);
-
 	skb = veth_build_skb(hard_start, headroom, len, ts);
 	seg_info = (struct veth_seg_info *)kmalloc(struct_size(seg_info, desc, MAX_SKB_FRAGS), GFP_KERNEL);
 	if (!seg_info)
 	{
 		printk("here must to deal with\n");
 	}
-
 	/* later we will support gso for this */
 	index = skb_shinfo(skb)->gso_segs;
 	seg_info->desc[index] = desc->addr;
 	seg_info->segs = ++index;
-
 	skb->truesize += ts;
 	skb->dev = dev;
 	skb_shinfo(skb)->destructor_arg = (void *)(long)seg_info;
 	skb_shinfo(skb)->destructor_arg_xsk_pool = (void *)(long)pool;
 	skb->destructor = veth_xsk_destruct_skb;
-
 	/* set the mac header */
 	skb->protocol = eth_type_trans(skb, dev);
+	/* to do, add skb to sock. may be there is no need to do for this
+	*  refcount_add(ts, &xs->sk.sk_wmem_alloc);
+	*/
+	return skb;
+}
+
+static struct sk_buff *veth_build_skb_zerocopy_gso(struct net_device *dev, struct xsk_buff_pool *pool,
+					      struct xdp_desc *desc, struct veth_gso_tuple *gso_tuple, struct sk_buff *prev_skb)
+{
+	u32 hr, len, ts, index, iph_len, th_len, data_offset, data_len, tot_len;
+	struct veth_seg_info *seg_info;
+	void *buffer;
+	struct udphdr *udph;
+	struct iphdr *iph;
+	struct sk_buff *skb;
+	struct page *page;
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
+	if (gso_tuple->gso_flush)
+		gso_tuple_init(gso_tuple, iph, udph);
+
+	ts = pool->unaligned ? len : pool->chunk_size;
+
+	data_offset = offset_in_page(buffer) + ETH_HLEN + iph_len + th_len;
+	data_len = len - (ETH_HLEN + iph_len + th_len);
+
+	/* head is null or this is a new 5 tuple */
+	if (NULL == prev_skb || !gso_segment_match(gso_tuple, iph, udph)) {
+		tot_len = hr + iph_len + th_len;
+		skb = veth_build_gso_head_skb(dev, buffer, tot_len, hr, iph_len, th_len);
+		if (!skb) {
+			/* to do: handle here for skb */
+			return NULL;
+		}
+
+		/* store information for gso */
+		seg_info = (struct veth_seg_info *)kmalloc(struct_size(seg_info, desc, MAX_SKB_FRAGS), GFP_KERNEL);
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
+		if(skb_shinfo(skb)->gso_segs >= MAX_SKB_FRAGS - 1) {
+			gso_tuple->gso_flush = true;
+		}
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
+	/* desc.data can not hold in two   */
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
 
 	/* to do, add skb to sock. may be there is no need to do for this
 	*  refcount_add(ts, &xs->sk.sk_wmem_alloc);
@@ -744,6 +923,22 @@ static struct sk_buff *veth_build_skb_zerocopy(struct net_device *dev, struct xs
 	return skb;
 }
 
+static inline struct sk_buff *veth_build_skb_zerocopy(struct net_device *dev, struct xsk_buff_pool *pool,
+					      struct xdp_desc *desc, struct veth_gso_tuple *gso_tuple, struct sk_buff *prev_skb)
+{
+	void *buffer;
+
+	buffer = xsk_buff_raw_get_data(pool, desc->addr);
+	if (ip_hdr_gso_check(buffer, desc->len)) {
+		gso_tuple->gso_enable = true;
+		return veth_build_skb_zerocopy_gso(dev, pool, desc, gso_tuple, prev_skb);
+	} else {
+		gso_tuple->gso_flush = false;
+		gso_tuple->gso_enable = false;
+		return veth_build_skb_zerocopy_normal(dev, pool, desc);
+	}
+}
+
 static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
 					  struct xdp_frame *frame,
 					  struct veth_xdp_tx_bq *bq,
@@ -1176,16 +1371,33 @@ static inline bool buffer_in_page(void *buffer, u32 len)
 	}
 }
 
+static inline void veth_skb_gso_check_update(struct sk_buff *skb)
+{
+	struct iphdr *iph = ip_hdr(skb);
+	struct udphdr *uh = udp_hdr(skb);
+	int ip_tot_len = skb->len;
+	int udp_len = skb->len - (skb->transport_header - skb->network_header);
+	iph->tot_len = htons(ip_tot_len);
+	ip_send_check(iph);
+	uh->len = htons(udp_len);
+	uh->check = 0;
+
+	/* udp4 checksum update */
+	udp4_hwcsum(skb, iph->saddr, iph->daddr);
+}
+
 static int veth_xsk_tx_xmit(struct veth_sq *sq, struct xsk_buff_pool *xsk_pool, int budget)
 {
 	struct veth_priv *priv, *peer_priv;
 	struct net_device *dev, *peer_dev;
+	struct veth_gso_tuple gso_tuple;
 	struct veth_rq *peer_rq;
 	struct veth_stats peer_stats = {};
 	struct veth_stats stats = {};
 	struct veth_xdp_tx_bq bq;
 	struct xdp_desc desc;
 	void *xdpf;
+	struct sk_buff *prev_skb = NULL;
 	struct sk_buff *skb = NULL;
 	bool zc = xsk_pool->umem->zc;
 	u32 xsk_headroom = xsk_pool->headroom;
@@ -1200,6 +1412,8 @@ static int veth_xsk_tx_xmit(struct veth_sq *sq, struct xsk_buff_pool *xsk_pool,
 	/* todo: queue index must set before this */
 	peer_rq = &peer_priv->rq[sq->queue_index];
 
+	memset(&gso_tuple, 0, sizeof(gso_tuple));
+
 	/* set xsk wake up flag, to do: where to disable */
 	if (xsk_uses_need_wakeup(xsk_pool))
 		xsk_set_tx_need_wakeup(xsk_pool);
@@ -1279,12 +1493,26 @@ static int veth_xsk_tx_xmit(struct veth_sq *sq, struct xsk_buff_pool *xsk_pool,
 			/* no need to copy address for af+xdp */
 			p_frame = veth_xdp_rcv_one(peer_rq, p_frame, &bq, &peer_stats);
 			if (p_frame) {
-				skb = veth_build_skb_zerocopy(peer_dev, xsk_pool, &desc);
-				if (skb) {
+				skb = veth_build_skb_zerocopy(peer_dev, xsk_pool, &desc, &gso_tuple, prev_skb);
+				if (!gso_tuple.gso_enable) {
 					napi_gro_receive(&peer_rq->xdp_napi, skb);
 					skb = NULL;
 				} else {
-					xsk_tx_completed_addr(xsk_pool, desc.addr);
+					if (prev_skb && gso_tuple.gso_flush) {
+						veth_skb_gso_check_update(prev_skb);
+						napi_gro_receive(&peer_rq->xdp_napi, prev_skb);
+
+						if (prev_skb == skb) {
+							skb = NULL;
+							prev_skb = NULL;
+						} else {
+							prev_skb = skb;
+						}
+					} else if (NULL == skb){
+						xsk_tx_completed_addr(xsk_pool, desc.addr);
+					} else {
+						prev_skb = skb;
+					}
 				}
 			}
 		} else {
@@ -1308,6 +1536,12 @@ static int veth_xsk_tx_xmit(struct veth_sq *sq, struct xsk_buff_pool *xsk_pool,
 		done++;
 	}
 
+	/* gso skb */
+	if (NULL!=skb) {
+		veth_skb_gso_check_update(skb);
+		napi_gro_receive(&peer_rq->xdp_napi, skb);
+	}
+
 	/* release, move consumer，and wakeup the producer */
 	if (done) {
 		napi_schedule(&peer_rq->xdp_napi);
-- 
2.20.1


