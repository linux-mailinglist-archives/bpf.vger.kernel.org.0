Return-Path: <bpf+bounces-11895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 231647C4ED0
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 11:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B02D1C20FF0
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 09:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35891EA7D;
	Wed, 11 Oct 2023 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE0B1DDD1;
	Wed, 11 Oct 2023 09:27:50 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB837B0;
	Wed, 11 Oct 2023 02:27:48 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VtwJVgi_1697016465;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VtwJVgi_1697016465)
          by smtp.aliyun-inc.com;
          Wed, 11 Oct 2023 17:27:46 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH vhost 15/22] virtio_net: xsk: tx: support wakeup
Date: Wed, 11 Oct 2023 17:27:21 +0800
Message-Id: <20231011092728.105904-16-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 7e791d85ef9e
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

xsk wakeup is used to trigger the logic for xsk xmit by xsk framework or
user.

Virtio-Net does not support to actively generate an interruption, so it
tries to trigger tx NAPI on the tx interrupt cpu.

Consider the effect of cache. When interrupt triggers, it is
generally fixed on a CPU. It is better to start TX Napi on the same
CPU.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c       |  3 ++
 drivers/net/virtio/virtio_net.h |  8 +++++
 drivers/net/virtio/xsk.c        | 57 +++++++++++++++++++++++++++++++++
 drivers/net/virtio/xsk.h        |  1 +
 4 files changed, 69 insertions(+)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 87bed583b6c4..a0a735c7aa32 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -2072,6 +2072,8 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 		return 0;
 	}
 
+	sq->xsk.last_cpu = smp_processor_id();
+
 	txq = netdev_get_tx_queue(vi->dev, index);
 	__netif_tx_lock(txq, raw_smp_processor_id());
 	virtqueue_disable_cb(sq->vq);
@@ -3776,6 +3778,7 @@ static const struct net_device_ops virtnet_netdev = {
 	.ndo_vlan_rx_kill_vid = virtnet_vlan_rx_kill_vid,
 	.ndo_bpf		= virtnet_xdp,
 	.ndo_xdp_xmit		= virtnet_xdp_xmit,
+	.ndo_xsk_wakeup         = virtnet_xsk_wakeup,
 	.ndo_features_check	= passthru_features_check,
 	.ndo_get_phys_port_name	= virtnet_get_phys_port_name,
 	.ndo_set_features	= virtnet_set_features,
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index 58eb7a46c489..3e114360cc8a 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -101,6 +101,14 @@ struct virtnet_sq {
 		struct xsk_buff_pool __rcu *pool;
 
 		dma_addr_t hdr_dma_address;
+
+		u32 last_cpu;
+		struct __call_single_data csd;
+
+		/* The lock to prevent the repeat of calling
+		 * smp_call_function_single_async().
+		 */
+		spinlock_t ipi_lock;
 	} xsk;
 };
 
diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
index a96e23ad577e..cce746301758 100644
--- a/drivers/net/virtio/xsk.c
+++ b/drivers/net/virtio/xsk.c
@@ -115,6 +115,60 @@ bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
 	return sent == budget;
 }
 
+static void virtnet_remote_napi_schedule(void *info)
+{
+	struct virtnet_sq *sq = info;
+
+	virtnet_vq_napi_schedule(&sq->napi, sq->vq);
+}
+
+static void virtnet_remote_raise_napi(struct virtnet_sq *sq)
+{
+	u32 last_cpu, cur_cpu;
+
+	last_cpu = sq->xsk.last_cpu;
+	cur_cpu = get_cpu();
+
+	/* On remote cpu, softirq will run automatically when ipi irq exit. On
+	 * local cpu, smp_call_xxx will not trigger ipi interrupt, then softirq
+	 * cannot be triggered automatically. So Call local_bh_enable after to
+	 * trigger softIRQ processing.
+	 */
+	if (last_cpu == cur_cpu) {
+		local_bh_disable();
+		virtnet_vq_napi_schedule(&sq->napi, sq->vq);
+		local_bh_enable();
+	} else {
+		if (spin_trylock(&sq->xsk.ipi_lock)) {
+			smp_call_function_single_async(last_cpu, &sq->xsk.csd);
+			spin_unlock(&sq->xsk.ipi_lock);
+		}
+	}
+
+	put_cpu();
+}
+
+int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct virtnet_sq *sq;
+
+	if (!netif_running(dev))
+		return -ENETDOWN;
+
+	if (qid >= vi->curr_queue_pairs)
+		return -EINVAL;
+
+	sq = &vi->sq[qid];
+
+	if (napi_if_scheduled_mark_missed(&sq->napi))
+		return 0;
+
+	virtnet_remote_raise_napi(sq);
+
+	return 0;
+}
+
 static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct virtnet_rq *rq,
 				    struct xsk_buff_pool *pool)
 {
@@ -244,6 +298,9 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 
 	sq->xsk.hdr_dma_address = hdr_dma;
 
+	INIT_CSD(&sq->xsk.csd, virtnet_remote_napi_schedule, sq);
+	spin_lock_init(&sq->xsk.ipi_lock);
+
 	return 0;
 
 err_sq:
diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
index 73ca8cd5308b..1bd19dcda649 100644
--- a/drivers/net/virtio/xsk.h
+++ b/drivers/net/virtio/xsk.h
@@ -17,4 +17,5 @@ static inline void *virtnet_xsk_to_ptr(u32 len)
 int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp);
 bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
 		      int budget);
+int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag);
 #endif
-- 
2.32.0.3.g01195cf9f


