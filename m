Return-Path: <bpf+bounces-6862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9560476EBD5
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 16:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B3F228221E
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 14:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493A924164;
	Thu,  3 Aug 2023 14:06:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E8A23BFA
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 14:06:27 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29F2469A
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 07:06:09 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8b2b60731so6874785ad.2
        for <bpf@vger.kernel.org>; Thu, 03 Aug 2023 07:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691071568; x=1691676368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldmbgmFCPgTqW2fPQLY5TbtgDmSxsPryWGSwRaZKrPQ=;
        b=fgb+z1UHH51nnAt8NwEDrRzGqf1c0PuIYH3dTKXFyhE9MPizHTukjzM/X6LgJi8uwz
         zjSph5k0AUXsRkWV2F2Ci7jSTppkWbcDuQeH0adRzCeJdiI8gCyc7V11IBEWdPn2YOd5
         txT7HJzEQZu+rpfM+KM9HIvR1Ijdh+0QasGlgWWUmXH1wsPh3ur4qjiHRwzvsYWqGL6V
         jGgNY2rZdZ3/jJzDn6ovpYavvEw/9n5UJxh22VGbCGZ1XBlQQPoHubgF5bUkbJaCS8dj
         VIS0HHCiFUUO9K0iGt2GVI0tQ5THSmrMh71g0ExCpLKJRWJHu2y1TSjI337RTIBh5VBy
         Wqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071568; x=1691676368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldmbgmFCPgTqW2fPQLY5TbtgDmSxsPryWGSwRaZKrPQ=;
        b=O5RBtBYEAS4SnhpARSL3F53xoMv4HLr3kp2lvNo6msFgfI8GnjiDNTQMTytrNRCaG3
         9kRMfVJ4vobB3kL0JDgeQ2gWfFwPUEKKfGqnaJDnTT0K4haZV5JXfB7B2P3YaESmbmES
         sz9Vv0r0G3v5j7vptRRbBRdeA18wvMOr9tFqSCKF4kzKQC4uipumY5+EWLfR5KgsbVj3
         qJNVZuzNmtwfEv0qxRZCineEyJjK/d05EOy2nAwJiKO7y/60GYRyStUI1+mxZnTkUekV
         4a/fSPHhN+t+KdojMbzMr/tEgN222rmYG5t6N7GNpbwRPSGIdIgH5bopkCulq50fKoYZ
         JHWA==
X-Gm-Message-State: ABy/qLY4u6X4uTQVQOAi5OSpHeZUWO6s2ds5CxboDE/3pW1rKqKQfDSH
	3+fIwnmMTpoSJNI8nqnRgbUJ5w==
X-Google-Smtp-Source: APBJJlEA3L6q3zQI/3gCKshzrzY08HPMuOIT+b6ya61ZrKbTkkVkNjwAzY46zwqr+lQnEuvfOxbG9w==
X-Received: by 2002:a17:902:d2cd:b0:1bc:239:a7e3 with SMTP id n13-20020a170902d2cd00b001bc0239a7e3mr15632332plc.44.1691071568602;
        Thu, 03 Aug 2023 07:06:08 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([2001:c10:ff04:0:1000::8])
        by smtp.gmail.com with ESMTPSA id ji11-20020a170903324b00b001b8a897cd26sm14367485plb.195.2023.08.03.07.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:06:08 -0700 (PDT)
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
	Kees Cook <keescook@chromium.org>,
	Menglong Dong <imagedong@tencent.com>,
	Richard Gobert <richardbgobert@gmail.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path))
Subject: [RFC Optimizing veth xsk performance 05/10] veth: use send queue tx napi to xmit xsk tx desc
Date: Thu,  3 Aug 2023 22:04:31 +0800
Message-Id: <20230803140441.53596-6-huangjie.albert@bytedance.com>
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
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
---
 drivers/net/veth.c | 265 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 264 insertions(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 63c3ebe4c5d0..944761807ca4 100644
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
@@ -1061,6 +1063,176 @@ static int veth_poll(struct napi_struct *napi, int budget)
 	return done;
 }
 
+static int veth_xsk_tx_xmit(struct veth_sq *sq, struct xsk_buff_pool *xsk_pool, int budget)
+{
+	struct veth_priv *priv, *peer_priv;
+	struct net_device *dev, *peer_dev;
+	struct veth_rq *peer_rq;
+	struct veth_stats peer_stats = {};
+	struct veth_stats stats = {};
+	struct veth_xdp_tx_bq bq;
+	struct xdp_desc desc;
+	void *xdpf;
+	int done = 0;
+
+	bq.count = 0;
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
+		struct xdp_frame *p_frame;
+		struct page *page;
+		void *new_addr;
+		void *addr;
+
+		/*
+		* get a desc from xsk pool
+		*/
+		if (!xsk_tx_peek_desc(xsk_pool, &desc)) {
+			break;
+		}
+
+		/*
+		* Get a xmit addr
+		* desc.addr is a offset, so we should to convert to real virtual address
+		*/
+		addr = xsk_buff_raw_get_data(xsk_pool, desc.addr);
+
+		/* can not hold all data in a page */
+		truesize =  SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) + desc.len + sizeof(struct xdp_frame);
+		if (truesize > PAGE_SIZE) {
+			stats.xdp_drops++;
+			xsk_tx_completed_addr(xsk_pool, desc.addr);
+			continue;
+		}
+
+		page = dev_alloc_page();
+		if (!page) {
+			/*
+			* error , release xdp frame and increase drops
+			*/
+			xsk_tx_completed_addr(xsk_pool, desc.addr);
+			stats.xdp_drops++;
+			break;
+		}
+		new_addr = page_to_virt(page);
+
+		p_frame = new_addr;
+		new_addr += sizeof(struct xdp_frame);
+		p_frame->data = new_addr;
+		p_frame->len = desc.len;
+
+		/* frame should change to the page size, beacause the (struct skb_shared_info)  is so large,
+		 * if we build skb in veth_xdp_rcv_one, skb->tail may larger than skb->end which could triger a skb_panic
+		 */
+		p_frame->headroom = 0;
+		p_frame->metasize = 0;
+		p_frame->frame_sz = PAGE_SIZE;
+		p_frame->flags = 0;
+		p_frame->mem.type = MEM_TYPE_PAGE_SHARED;
+		memcpy(p_frame->data, addr, p_frame->len);
+		xsk_tx_completed_addr(xsk_pool, desc.addr);
+
+		/* if peer have xdp prog, if it has ,just send to peer */
+		p_frame = veth_xdp_rcv_one(peer_rq, p_frame, &bq, &peer_stats);
+		/* if no xdp with this queue, convert to skb to xmit*/
+		if (p_frame) {
+			xdpf = p_frame;
+			veth_xdp_rcv_bulk_skb(peer_rq, &xdpf, 1, &bq, &peer_stats);
+			p_frame = NULL;
+		}
+
+		stats.xdp_bytes += desc.len;
+
+		done++;
+	}
+
+	/* release, move consumer，and wakeup the producer */
+	if (done) {
+		napi_schedule(&peer_rq->xdp_napi);
+		xsk_tx_release(xsk_pool);
+	}
+
+
+
+	/* just for peer rq */
+	if (peer_stats.xdp_tx > 0)
+		veth_xdp_flush(peer_rq, &bq);
+	if (peer_stats.xdp_redirect > 0)
+		xdp_do_flush();
+
+	/* update peer rq stats, or maybe we do not need to do this */
+	u64_stats_update_begin(&peer_rq->stats.syncp);
+	peer_rq->stats.vs.xdp_redirect += peer_stats.xdp_redirect;
+	peer_rq->stats.vs.xdp_packets += done;
+	peer_rq->stats.vs.xdp_bytes += stats.xdp_bytes;
+	peer_rq->stats.vs.xdp_drops += peer_stats.xdp_drops;
+	peer_rq->stats.vs.rx_drops += peer_stats.rx_drops;
+	peer_rq->stats.vs.xdp_tx += peer_stats.xdp_tx;
+	u64_stats_update_end(&peer_rq->stats.syncp);
+
+	/* update sq stats */
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
+	xdp_set_return_frame_no_direct();
+
+	sq->xsk.last_cpu = smp_processor_id();
+
+	/* xmit for tx queue */
+	rcu_read_lock();
+	pool = rcu_dereference(sq->xsk.pool);
+	if (pool) {
+		done  = veth_xsk_tx_xmit(sq, pool, budget);
+	}
+	rcu_read_unlock();
+
+	if (done < budget) {
+		/* if done < budget, the tx ring is no buffer */
+		napi_complete_done(napi, done);
+	}
+
+	xdp_clear_return_frame_no_direct();
+
+	return done;
+}
+
+
+static int veth_napi_add_tx(struct net_device *dev)
+{
+	struct veth_priv *priv = netdev_priv(dev);
+	int i;
+
+	for (i = 0; i < dev->real_num_rx_queues; i++) {
+		struct veth_sq *sq = &priv->sq[i];
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
@@ -1153,6 +1325,19 @@ static void veth_napi_del_range(struct net_device *dev, int start, int end)
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
@@ -1360,7 +1545,7 @@ static void veth_set_xdp_features(struct net_device *dev)
 		struct veth_priv *priv_peer = netdev_priv(peer);
 		xdp_features_t val = NETDEV_XDP_ACT_BASIC |
 				     NETDEV_XDP_ACT_REDIRECT |
-				     NETDEV_XDP_ACT_RX_SG;
+				     NETDEV_XDP_ACT_RX_SG | NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
 		if (priv_peer->_xdp_prog || veth_gro_requested(peer))
 			val |= NETDEV_XDP_ACT_NDO_XMIT |
@@ -1737,11 +1922,89 @@ static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
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
+	if(!peer_dev)
+		return -EINVAL;
+
+	/* no dma, so we just skip dma skip in xsk zero copy */
+	pool->dma_check_skip = true;
+
+	peer_priv = netdev_priv(peer_dev);
+	/*
+	*  enable peer tx xdp here, this side
+	*  xdp is enable by veth_xdp_set
+	*  to do: we need to check whther this side is already enable xdp
+	*  maybe it do not have xdp prog
+	*/
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
+	if(!peer_dev)
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


