Return-Path: <bpf+bounces-7155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BC47723D5
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 14:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188A4281320
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 12:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA1C101DE;
	Mon,  7 Aug 2023 12:25:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CE84436
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 12:25:01 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620B7E53
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 05:24:59 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bc34b32785so28032835ad.3
        for <bpf@vger.kernel.org>; Mon, 07 Aug 2023 05:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691411099; x=1692015899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzvycUSp6fj3lhy6v0s47NdlhPCC8jzqygliYQ4HaF8=;
        b=kZ3jGdcXWEZ4oyg0oP0T/xcd6VEXp/7aa/nPih+VNkFf6OkCznLwQRb9/jRzCzHOCk
         3Vi0RhO2IHMdpKPcwYMUEb2tKvyMWFfgmC83p57OWVM5GdbK7Yh3YguUZMlVEAzOmpb9
         QaYVLP38DAub6T6A99e8dHKpv5/z/3099Ssdut5thWefm6PuSyc6y5r0mED2/XGGgsiH
         q7HTKm58Nd6dnoI2I9ZF1gotW+WfkyGGGKLUwJP4EBLEGjCDhCBPYri9J4TBngYufbN6
         RmJwVW1DngJ7cVDGCf3Z/HGNPPArBcaE+fAAjSeprwM8uDvTYDbTJXU1ThQ5I23awoaU
         mr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691411099; x=1692015899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzvycUSp6fj3lhy6v0s47NdlhPCC8jzqygliYQ4HaF8=;
        b=EiV/41EOOM20/L4G/zaGhbp3yXsggXhndRFAyO+95z7/hKGDvz82ULGbMS4AoxLoko
         5zuuCWqgvN5i53ulKiDaAEULp5+4I1o7cKFC9HLmAJvzTzpH4Gzvb3iTZo5lvsWYufDw
         FjC7WD7HnNb0QtE3NAyW8Y4KQZjRnsyh4TOy+4bRAEMn9uzNW06PT3lBKH44eXUyeJxH
         ez77Wv/5vyXZhjRwsLAqodI0B5QzDOy2vZQ9h2QRtw+Ruh+VJk4hA6KX7F2ypquEmbQm
         wTTocPayFnQA2/nTj20EiF6CYyKgSE4j6A2yg5hGAZ7dbazq/l3UreTukPpBxkZ+7ISV
         LXSA==
X-Gm-Message-State: AOJu0YyboJczSJHTADecdpzXZAYJ38aHJE8XaP4mM3LCanIyJ6n8YzGl
	xzyVk9i2POqYgQg/Y16B7+Tidw==
X-Google-Smtp-Source: AGHT+IEboynI5V/8G38VpIJprkiWU7gjnmIYItz7meICAcRwBMHQ5y3CElE3+GIyHu1Z1mmgIEzXvA==
X-Received: by 2002:a17:902:e84e:b0:1b6:4bbd:c3a7 with SMTP id t14-20020a170902e84e00b001b64bbdc3a7mr8900815plg.66.1691411098793;
        Mon, 07 Aug 2023 05:24:58 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902a9ca00b001bc16bc9f5fsm6746674plr.284.2023.08.07.05.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 05:24:58 -0700 (PDT)
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
Subject: [RFC v2 Optimizing veth xsk performance 5/9] veth: use send queue tx napi to xmit xsk tx desc
Date: Mon,  7 Aug 2023 20:24:47 +0800
Message-Id: <20230807122447.85725-1-huangjie.albert@bytedance.com>
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
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

use send queue tx napi to xmit xsk tx desc

Signed-off-by: Albert Huang <huangjie.albert@bytedance.com>
---
 drivers/net/veth.c | 230 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 229 insertions(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 25faba879505..28b891dd8dc9 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -27,6 +27,8 @@
 #include <linux/bpf_trace.h>
 #include <linux/net_tstamp.h>
 #include <net/page_pool.h>
+#include <net/xdp_sock_drv.h>
+#include <net/xdp.h>
 
 #define DRV_NAME	"veth"
 #define DRV_VERSION	"1.0"
@@ -1061,6 +1063,141 @@ static int veth_poll(struct napi_struct *napi, int budget)
 	return done;
 }
 
+static struct sk_buff *veth_build_skb(void *head, int headroom, int len,
+				      int buflen)
+{
+	struct sk_buff *skb;
+
+	skb = build_skb(head, buflen);
+	if (!skb)
+		return NULL;
+
+	skb_reserve(skb, headroom);
+	skb_put(skb, len);
+
+	return skb;
+}
+
+static int veth_xsk_tx_xmit(struct veth_sq *sq, struct xsk_buff_pool *xsk_pool, int budget)
+{
+	struct veth_priv *priv, *peer_priv;
+	struct net_device *dev, *peer_dev;
+	struct veth_stats stats = {};
+	struct sk_buff *skb = NULL;
+	struct veth_rq *peer_rq;
+	struct xdp_desc desc;
+	int done = 0;
+
+	dev = sq->dev;
+	priv = netdev_priv(dev);
+	peer_dev = priv->peer;
+	peer_priv = netdev_priv(peer_dev);
+
+	/* todo: queue index must set before this */
+	peer_rq = &peer_priv->rq[sq->queue_index];
+
+	/* set xsk wake up flag, to do: where to disable */
+	if (xsk_uses_need_wakeup(xsk_pool))
+		xsk_set_tx_need_wakeup(xsk_pool);
+
+	while (budget-- > 0) {
+		unsigned int truesize = 0;
+		struct page *page;
+		void *vaddr;
+		void *addr;
+
+		if (!xsk_tx_peek_desc(xsk_pool, &desc))
+			break;
+
+		addr = xsk_buff_raw_get_data(xsk_pool, desc.addr);
+
+		/* can not hold all data in a page */
+		truesize =  SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+		truesize += desc.len + xsk_pool->headroom;
+		if (truesize > PAGE_SIZE) {
+			xsk_tx_completed_addr(xsk_pool, desc.addr);
+			stats.xdp_drops++;
+			break;
+		}
+
+		page = dev_alloc_page();
+		if (!page) {
+			xsk_tx_completed_addr(xsk_pool, desc.addr);
+			stats.xdp_drops++;
+			break;
+		}
+		vaddr = page_to_virt(page);
+
+		memcpy(vaddr + xsk_pool->headroom, addr, desc.len);
+		xsk_tx_completed_addr(xsk_pool, desc.addr);
+
+		skb = veth_build_skb(vaddr, xsk_pool->headroom, desc.len, PAGE_SIZE);
+		if (!skb) {
+			put_page(page);
+			stats.xdp_drops++;
+			break;
+		}
+		skb->protocol = eth_type_trans(skb, peer_dev);
+		napi_gro_receive(&peer_rq->xdp_napi, skb);
+
+		stats.xdp_bytes += desc.len;
+		done++;
+	}
+
+	/* release, move consumer，and wakeup the producer */
+	if (done) {
+		napi_schedule(&peer_rq->xdp_napi);
+		xsk_tx_release(xsk_pool);
+	}
+
+	u64_stats_update_begin(&sq->stats.syncp);
+	sq->stats.vs.xdp_packets += done;
+	sq->stats.vs.xdp_bytes += stats.xdp_bytes;
+	sq->stats.vs.xdp_drops += stats.xdp_drops;
+	u64_stats_update_end(&sq->stats.syncp);
+
+	return done;
+}
+
+static int veth_poll_tx(struct napi_struct *napi, int budget)
+{
+	struct veth_sq *sq = container_of(napi, struct veth_sq, xdp_napi);
+	struct xsk_buff_pool *pool;
+	int done = 0;
+
+	sq->xsk.last_cpu = smp_processor_id();
+
+	/* xmit for tx queue */
+	rcu_read_lock();
+	pool = rcu_dereference(sq->xsk.pool);
+	if (pool)
+		done  = veth_xsk_tx_xmit(sq, pool, budget);
+
+	rcu_read_unlock();
+
+	if (done < budget) {
+		/* if done < budget, the tx ring is no buffer */
+		napi_complete_done(napi, done);
+	}
+
+	return done;
+}
+
+static int veth_napi_add_tx(struct net_device *dev)
+{
+	struct veth_priv *priv = netdev_priv(dev);
+	int i;
+
+	for (i = 0; i < dev->real_num_rx_queues; i++) {
+		struct veth_sq *sq = &priv->sq[i];
+
+		netif_napi_add(dev, &sq->xdp_napi, veth_poll_tx);
+		napi_enable(&sq->xdp_napi);
+	}
+
+	return 0;
+}
+
 static int veth_create_page_pool(struct veth_rq *rq)
 {
 	struct page_pool_params pp_params = {
@@ -1153,6 +1290,19 @@ static void veth_napi_del_range(struct net_device *dev, int start, int end)
 	}
 }
 
+static void veth_napi_del_tx(struct net_device *dev)
+{
+	struct veth_priv *priv = netdev_priv(dev);
+	int i;
+
+	for (i = 0; i < dev->real_num_rx_queues; i++) {
+		struct veth_sq *sq = &priv->sq[i];
+
+		napi_disable(&sq->xdp_napi);
+		__netif_napi_del(&sq->xdp_napi);
+	}
+}
+
 static void veth_napi_del(struct net_device *dev)
 {
 	veth_napi_del_range(dev, 0, dev->real_num_rx_queues);
@@ -1360,7 +1510,7 @@ static void veth_set_xdp_features(struct net_device *dev)
 		struct veth_priv *priv_peer = netdev_priv(peer);
 		xdp_features_t val = NETDEV_XDP_ACT_BASIC |
 				     NETDEV_XDP_ACT_REDIRECT |
-				     NETDEV_XDP_ACT_RX_SG;
+				     NETDEV_XDP_ACT_RX_SG | NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
 		if (priv_peer->_xdp_prog || veth_gro_requested(peer))
 			val |= NETDEV_XDP_ACT_NDO_XMIT |
@@ -1737,11 +1887,89 @@ static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 	return err;
 }
 
+static int veth_xsk_pool_enable(struct net_device *dev, struct xsk_buff_pool *pool, u16 qid)
+{
+	struct veth_priv *peer_priv;
+	struct veth_priv *priv = netdev_priv(dev);
+	struct net_device *peer_dev = priv->peer;
+	int err = 0;
+
+	if (qid >= dev->real_num_tx_queues)
+		return -EINVAL;
+
+	if (!peer_dev)
+		return -EINVAL;
+
+	/* no dma, so we just skip dma skip in xsk zero copy */
+	pool->dma_check_skip = true;
+
+	peer_priv = netdev_priv(peer_dev);
+
+	/* enable peer tx xdp here, this side
+	 * xdp is enable by veth_xdp_set
+	 * to do: we need to check whther this side is already enable xdp
+	 * maybe it do not have xdp prog
+	 */
+	if (!(peer_priv->_xdp_prog) && (!veth_gro_requested(peer_dev))) {
+		/*  peer should enable napi*/
+		err = veth_napi_enable(peer_dev);
+		if (err)
+			return err;
+	}
+
+	/* Here is already protected by rtnl_lock, so rcu_assign_pointer
+	 * is safe.
+	 */
+	rcu_assign_pointer(priv->sq[qid].xsk.pool, pool);
+
+	veth_napi_add_tx(dev);
+
+	return err;
+}
+
+static int veth_xsk_pool_disable(struct net_device *dev, u16 qid)
+{
+	struct veth_priv *peer_priv;
+	struct veth_priv *priv = netdev_priv(dev);
+	struct net_device *peer_dev = priv->peer;
+	int err = 0;
+
+	if (qid >= dev->real_num_tx_queues)
+		return -EINVAL;
+
+	if (!peer_dev)
+		return -EINVAL;
+
+	peer_priv = netdev_priv(peer_dev);
+
+	/* to do: this may be failed */
+	if (!(peer_priv->_xdp_prog) && (!veth_gro_requested(peer_dev))) {
+		/*  disable peer napi */
+		veth_napi_del(peer_dev);
+	}
+
+	veth_napi_del_tx(dev);
+
+	rcu_assign_pointer(priv->sq[qid].xsk.pool, NULL);
+	return err;
+}
+
+/* this  is for setup xdp */
+static int veth_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp)
+{
+	if (xdp->xsk.pool)
+		return veth_xsk_pool_enable(dev, xdp->xsk.pool, xdp->xsk.queue_id);
+	else
+		return veth_xsk_pool_disable(dev, xdp->xsk.queue_id);
+}
+
 static int veth_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 {
 	switch (xdp->command) {
 	case XDP_SETUP_PROG:
 		return veth_xdp_set(dev, xdp->prog, xdp->extack);
+	case XDP_SETUP_XSK_POOL:
+		return veth_xsk_pool_setup(dev, xdp);
 	default:
 		return -EINVAL;
 	}
-- 
2.20.1


