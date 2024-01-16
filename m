Return-Path: <bpf+bounces-19573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 608FE82E990
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 07:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09031284E39
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 06:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EBE11721;
	Tue, 16 Jan 2024 06:28:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1451111BF;
	Tue, 16 Jan 2024 06:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W-l5T6f_1705386526;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W-l5T6f_1705386526)
          by smtp.aliyun-inc.com;
          Tue, 16 Jan 2024 14:28:47 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
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
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next 4/5] virtio_net: move core structures to virtio_net.h
Date: Tue, 16 Jan 2024 14:28:41 +0800
Message-Id: <20240116062842.67874-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240116062842.67874-1-xuanzhuo@linux.alibaba.com>
References: <20240116062842.67874-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: aa067ad3645b
Content-Transfer-Encoding: 8bit

Move some core structures (send_queue, receive_queue, virtnet_info)
definitions and the relative structures definitions into the
virtio_net.h file.

That will be used by the other c code files.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio/main.c       | 203 +------------------------------
 drivers/net/virtio/virtio_net.h | 207 ++++++++++++++++++++++++++++++++
 2 files changed, 209 insertions(+), 201 deletions(-)
 create mode 100644 drivers/net/virtio/virtio_net.h

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 53ce986a88c0..d7c685cf164f 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -6,7 +6,6 @@
 //#define DEBUG
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
-#include <linux/ethtool.h>
 #include <linux/module.h>
 #include <linux/virtio.h>
 #include <linux/virtio_net.h>
@@ -16,7 +15,6 @@
 #include <linux/if_vlan.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
-#include <linux/average.h>
 #include <linux/filter.h>
 #include <linux/kernel.h>
 #include <linux/dim.h>
@@ -25,6 +23,8 @@
 #include <net/net_failover.h>
 #include <net/netdev_rx_queue.h>
 
+#include "virtio_net.h"
+
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
 
@@ -48,13 +48,6 @@ module_param(napi_tx, bool, 0644);
 
 #define VIRTIO_XDP_FLAG	BIT(0)
 
-/* RX packet size EWMA. The average packet size is used to determine the packet
- * buffer size when refilling RX rings. As the entire RX ring may be refilled
- * at once, the weight is chosen so that the EWMA will be insensitive to short-
- * term, transient changes in packet size.
- */
-DECLARE_EWMA(pkt_len, 0, 64)
-
 #define VIRTNET_DRIVER_VERSION "1.0.0"
 
 static const unsigned long guest_offloads[] = {
@@ -80,28 +73,6 @@ struct virtnet_stat_desc {
 	size_t offset;
 };
 
-struct virtnet_sq_stats {
-	struct u64_stats_sync syncp;
-	u64_stats_t packets;
-	u64_stats_t bytes;
-	u64_stats_t xdp_tx;
-	u64_stats_t xdp_tx_drops;
-	u64_stats_t kicks;
-	u64_stats_t tx_timeouts;
-};
-
-struct virtnet_rq_stats {
-	struct u64_stats_sync syncp;
-	u64_stats_t packets;
-	u64_stats_t bytes;
-	u64_stats_t drops;
-	u64_stats_t xdp_packets;
-	u64_stats_t xdp_tx;
-	u64_stats_t xdp_redirects;
-	u64_stats_t xdp_drops;
-	u64_stats_t kicks;
-};
-
 #define VIRTNET_SQ_STAT(m)	offsetof(struct virtnet_sq_stats, m)
 #define VIRTNET_RQ_STAT(m)	offsetof(struct virtnet_rq_stats, m)
 
@@ -128,91 +99,6 @@ static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
 #define VIRTNET_SQ_STATS_LEN	ARRAY_SIZE(virtnet_sq_stats_desc)
 #define VIRTNET_RQ_STATS_LEN	ARRAY_SIZE(virtnet_rq_stats_desc)
 
-struct virtnet_interrupt_coalesce {
-	u32 max_packets;
-	u32 max_usecs;
-};
-
-/* The dma information of pages allocated at a time. */
-struct virtnet_rq_dma {
-	dma_addr_t addr;
-	u32 ref;
-	u16 len;
-	u16 need_sync;
-};
-
-/* Internal representation of a send virtqueue */
-struct send_queue {
-	/* Virtqueue associated with this send _queue */
-	struct virtqueue *vq;
-
-	/* TX: fragments + linear part + virtio header */
-	struct scatterlist sg[MAX_SKB_FRAGS + 2];
-
-	/* Name of the send queue: output.$index */
-	char name[16];
-
-	struct virtnet_sq_stats stats;
-
-	struct virtnet_interrupt_coalesce intr_coal;
-
-	struct napi_struct napi;
-
-	/* Record whether sq is in reset state. */
-	bool reset;
-};
-
-/* Internal representation of a receive virtqueue */
-struct receive_queue {
-	/* Virtqueue associated with this receive_queue */
-	struct virtqueue *vq;
-
-	struct napi_struct napi;
-
-	struct bpf_prog __rcu *xdp_prog;
-
-	struct virtnet_rq_stats stats;
-
-	/* The number of rx notifications */
-	u16 calls;
-
-	/* Is dynamic interrupt moderation enabled? */
-	bool dim_enabled;
-
-	/* Dynamic Interrupt Moderation */
-	struct dim dim;
-
-	u32 packets_in_napi;
-
-	struct virtnet_interrupt_coalesce intr_coal;
-
-	/* Chain pages by the private ptr. */
-	struct page *pages;
-
-	/* Average packet length for mergeable receive buffers. */
-	struct ewma_pkt_len mrg_avg_pkt_len;
-
-	/* Page frag for packet buffer allocation. */
-	struct page_frag alloc_frag;
-
-	/* RX: fragments + linear part + virtio header */
-	struct scatterlist sg[MAX_SKB_FRAGS + 2];
-
-	/* Min single buffer size for mergeable buffers case. */
-	unsigned int min_buf_len;
-
-	/* Name of this receive queue: input.$index */
-	char name[16];
-
-	struct xdp_rxq_info xdp_rxq;
-
-	/* Record the last dma info to free after new pages is allocated. */
-	struct virtnet_rq_dma *last_dma;
-
-	/* Do dma by self */
-	bool do_dma;
-};
-
 /* This structure can contain rss message with maximum settings for indirection table and keysize
  * Note, that default structure that describes RSS configuration virtio_net_rss_config
  * contains same info but can't handle table values.
@@ -246,91 +132,6 @@ struct control_buf {
 	struct virtio_net_ctrl_coal_vq coal_vq;
 };
 
-struct virtnet_info {
-	struct virtio_device *vdev;
-	struct virtqueue *cvq;
-	struct net_device *dev;
-	struct send_queue *sq;
-	struct receive_queue *rq;
-	unsigned int status;
-
-	/* Max # of queue pairs supported by the device */
-	u16 max_queue_pairs;
-
-	/* # of queue pairs currently used by the driver */
-	u16 curr_queue_pairs;
-
-	/* # of XDP queue pairs currently used by the driver */
-	u16 xdp_queue_pairs;
-
-	/* xdp_queue_pairs may be 0, when xdp is already loaded. So add this. */
-	bool xdp_enabled;
-
-	/* I like... big packets and I cannot lie! */
-	bool big_packets;
-
-	/* number of sg entries allocated for big packets */
-	unsigned int big_packets_num_skbfrags;
-
-	/* Host will merge rx buffers for big packets (shake it! shake it!) */
-	bool mergeable_rx_bufs;
-
-	/* Host supports rss and/or hash report */
-	bool has_rss;
-	bool has_rss_hash_report;
-	u8 rss_key_size;
-	u16 rss_indir_table_size;
-	u32 rss_hash_types_supported;
-	u32 rss_hash_types_saved;
-
-	/* Has control virtqueue */
-	bool has_cvq;
-
-	/* Host can handle any s/g split between our header and packet data */
-	bool any_header_sg;
-
-	/* Packet virtio header size */
-	u8 hdr_len;
-
-	/* Work struct for delayed refilling if we run low on memory. */
-	struct delayed_work refill;
-
-	/* Is delayed refill enabled? */
-	bool refill_enabled;
-
-	/* The lock to synchronize the access to refill_enabled */
-	spinlock_t refill_lock;
-
-	/* Work struct for config space updates */
-	struct work_struct config_work;
-
-	/* Does the affinity hint is set for virtqueues? */
-	bool affinity_hint_set;
-
-	/* CPU hotplug instances for online & dead */
-	struct hlist_node node;
-	struct hlist_node node_dead;
-
-	struct control_buf *ctrl;
-
-	/* Ethtool settings */
-	u8 duplex;
-	u32 speed;
-
-	/* Is rx dynamic interrupt moderation enabled? */
-	bool rx_dim_enabled;
-
-	/* Interrupt coalescing settings */
-	struct virtnet_interrupt_coalesce intr_coal_tx;
-	struct virtnet_interrupt_coalesce intr_coal_rx;
-
-	unsigned long guest_offloads;
-	unsigned long guest_offloads_capable;
-
-	/* failover when STANDBY feature enabled */
-	struct failover *failover;
-};
-
 struct padded_vnet_hdr {
 	struct virtio_net_hdr_v1_hash hdr;
 	/*
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
new file mode 100644
index 000000000000..902ccde10133
--- /dev/null
+++ b/drivers/net/virtio/virtio_net.h
@@ -0,0 +1,207 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __VIRTIO_NET_H__
+#define __VIRTIO_NET_H__
+
+#include <linux/ethtool.h>
+#include <linux/average.h>
+
+/* RX packet size EWMA. The average packet size is used to determine the packet
+ * buffer size when refilling RX rings. As the entire RX ring may be refilled
+ * at once, the weight is chosen so that the EWMA will be insensitive to short-
+ * term, transient changes in packet size.
+ */
+DECLARE_EWMA(pkt_len, 0, 64)
+
+struct virtnet_sq_stats {
+	struct u64_stats_sync syncp;
+	u64_stats_t packets;
+	u64_stats_t bytes;
+	u64_stats_t xdp_tx;
+	u64_stats_t xdp_tx_drops;
+	u64_stats_t kicks;
+	u64_stats_t tx_timeouts;
+};
+
+struct virtnet_rq_stats {
+	struct u64_stats_sync syncp;
+	u64_stats_t packets;
+	u64_stats_t bytes;
+	u64_stats_t drops;
+	u64_stats_t xdp_packets;
+	u64_stats_t xdp_tx;
+	u64_stats_t xdp_redirects;
+	u64_stats_t xdp_drops;
+	u64_stats_t kicks;
+};
+
+struct virtnet_interrupt_coalesce {
+	u32 max_packets;
+	u32 max_usecs;
+};
+
+/* The dma information of pages allocated at a time. */
+struct virtnet_rq_dma {
+	dma_addr_t addr;
+	u32 ref;
+	u16 len;
+	u16 need_sync;
+};
+
+/* Internal representation of a send virtqueue */
+struct send_queue {
+	/* Virtqueue associated with this send _queue */
+	struct virtqueue *vq;
+
+	/* TX: fragments + linear part + virtio header */
+	struct scatterlist sg[MAX_SKB_FRAGS + 2];
+
+	/* Name of the send queue: output.$index */
+	char name[16];
+
+	struct virtnet_sq_stats stats;
+
+	struct virtnet_interrupt_coalesce intr_coal;
+
+	struct napi_struct napi;
+
+	/* Record whether sq is in reset state. */
+	bool reset;
+};
+
+/* Internal representation of a receive virtqueue */
+struct receive_queue {
+	/* Virtqueue associated with this receive_queue */
+	struct virtqueue *vq;
+
+	struct napi_struct napi;
+
+	struct bpf_prog __rcu *xdp_prog;
+
+	struct virtnet_rq_stats stats;
+
+	/* The number of rx notifications */
+	u16 calls;
+
+	/* Is dynamic interrupt moderation enabled? */
+	bool dim_enabled;
+
+	/* Dynamic Interrupt Moderation */
+	struct dim dim;
+
+	u32 packets_in_napi;
+
+	struct virtnet_interrupt_coalesce intr_coal;
+
+	/* Chain pages by the private ptr. */
+	struct page *pages;
+
+	/* Average packet length for mergeable receive buffers. */
+	struct ewma_pkt_len mrg_avg_pkt_len;
+
+	/* Page frag for packet buffer allocation. */
+	struct page_frag alloc_frag;
+
+	/* RX: fragments + linear part + virtio header */
+	struct scatterlist sg[MAX_SKB_FRAGS + 2];
+
+	/* Min single buffer size for mergeable buffers case. */
+	unsigned int min_buf_len;
+
+	/* Name of this receive queue: input.$index */
+	char name[16];
+
+	struct xdp_rxq_info xdp_rxq;
+
+	/* Record the last dma info to free after new pages is allocated. */
+	struct virtnet_rq_dma *last_dma;
+
+	/* Do dma by self */
+	bool do_dma;
+};
+
+struct virtnet_info {
+	struct virtio_device *vdev;
+	struct virtqueue *cvq;
+	struct net_device *dev;
+	struct send_queue *sq;
+	struct receive_queue *rq;
+	unsigned int status;
+
+	/* Max # of queue pairs supported by the device */
+	u16 max_queue_pairs;
+
+	/* # of queue pairs currently used by the driver */
+	u16 curr_queue_pairs;
+
+	/* # of XDP queue pairs currently used by the driver */
+	u16 xdp_queue_pairs;
+
+	/* xdp_queue_pairs may be 0, when xdp is already loaded. So add this. */
+	bool xdp_enabled;
+
+	/* I like... big packets and I cannot lie! */
+	bool big_packets;
+
+	/* number of sg entries allocated for big packets */
+	unsigned int big_packets_num_skbfrags;
+
+	/* Host will merge rx buffers for big packets (shake it! shake it!) */
+	bool mergeable_rx_bufs;
+
+	/* Host supports rss and/or hash report */
+	bool has_rss;
+	bool has_rss_hash_report;
+	u8 rss_key_size;
+	u16 rss_indir_table_size;
+	u32 rss_hash_types_supported;
+	u32 rss_hash_types_saved;
+
+	/* Has control virtqueue */
+	bool has_cvq;
+
+	/* Host can handle any s/g split between our header and packet data */
+	bool any_header_sg;
+
+	/* Packet virtio header size */
+	u8 hdr_len;
+
+	/* Work struct for delayed refilling if we run low on memory. */
+	struct delayed_work refill;
+
+	/* Is delayed refill enabled? */
+	bool refill_enabled;
+
+	/* The lock to synchronize the access to refill_enabled */
+	spinlock_t refill_lock;
+
+	/* Work struct for config space updates */
+	struct work_struct config_work;
+
+	/* Does the affinity hint is set for virtqueues? */
+	bool affinity_hint_set;
+
+	/* CPU hotplug instances for online & dead */
+	struct hlist_node node;
+	struct hlist_node node_dead;
+
+	struct control_buf *ctrl;
+
+	/* Ethtool settings */
+	u8 duplex;
+	u32 speed;
+
+	/* Is rx dynamic interrupt moderation enabled? */
+	bool rx_dim_enabled;
+
+	/* Interrupt coalescing settings */
+	struct virtnet_interrupt_coalesce intr_coal_tx;
+	struct virtnet_interrupt_coalesce intr_coal_rx;
+
+	unsigned long guest_offloads;
+	unsigned long guest_offloads_capable;
+
+	/* failover when STANDBY feature enabled */
+	struct failover *failover;
+};
+#endif
-- 
2.32.0.3.g01195cf9f


