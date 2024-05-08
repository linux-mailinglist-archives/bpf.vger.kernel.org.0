Return-Path: <bpf+bounces-29042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9478C8BF80B
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 10:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCFB282996
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 08:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5752A4EB42;
	Wed,  8 May 2024 08:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uAAFFqHm"
X-Original-To: bpf@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBF9446D5;
	Wed,  8 May 2024 08:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715155527; cv=none; b=KTL8QkmI9tpmdG5B9MX25QLK4B4kRVGvQW4V1bNblrmfWMUjz90Sr56hFejAcnBYEPOvPKT46m6zPAYKJ3bTkbn3H6nWzG2gDm0eVOp0Fbt9Q4IPsiD9Pw3n21w9QFw5W2duHkK2udzHGnJpnFkVaEdyCxA35YsZnvn0XzRaVag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715155527; c=relaxed/simple;
	bh=Ev2ShxPGZ7YgLYvCEkl2l3mdHo1B2kXjRScrehe1A2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qm6EvWnU8eNw7s+MXRRSVmEjegVo4PnigKkzqS0hB6KgkGMvKyNb3Ztttv2pz7Utb7HsLtgtxh4FSt1jWRuyC2t7CDVv2V4OaauXHrF7YlJZOuWbXsCny0IsdDXORPhjp47ZntY/kcM8VGzhPga2wNZk4iLP01Cts2xpRcZti+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uAAFFqHm; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715155520; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=cicme+psbEanO0XFxGf2VWOcIhWgXz+n8Dfv7vyoONA=;
	b=uAAFFqHmjO/OVStcuGWQA3nfX6F6IYpSWyi7xZaar/MrhVU+R4qGZRRd4UuOBKFvdBNTLbMjQbJiyY5xnGVB5RW9Ck4qHTmthkNTT72/ZQpkNuAtVDNcxG0pLAgdazYAZXc8GVU8b06/wPcbae19Me5kaNwLCrdrV7KiziQuCjc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W62sQf9_1715155518;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W62sQf9_1715155518)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 16:05:19 +0800
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
Subject: [PATCH net-next 2/7] virtio_net: move core structures to virtio_net.h
Date: Wed,  8 May 2024 16:05:09 +0800
Message-Id: <20240508080514.99458-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com>
References: <20240508080514.99458-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 7cdcbabd0b89
Content-Transfer-Encoding: 8bit

Move some core structures (send_queue, receive_queue, virtnet_info)
definitions and the relative structures definitions into the
virtio_net.h file.

That will be used by the other c code files.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio/virtnet.h      | 237 ++++++++++++++++++++++++++++++
 drivers/net/virtio/virtnet_main.c | 233 +----------------------------
 2 files changed, 239 insertions(+), 231 deletions(-)
 create mode 100644 drivers/net/virtio/virtnet.h

diff --git a/drivers/net/virtio/virtnet.h b/drivers/net/virtio/virtnet.h
new file mode 100644
index 000000000000..a7990eb20ab5
--- /dev/null
+++ b/drivers/net/virtio/virtnet.h
@@ -0,0 +1,237 @@
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
+	/* Used to protect dim_enabled and inter_coal */
+	struct mutex dim_lock;
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
+};
+
+/* This structure can contain rss message with maximum settings for indirection table and keysize
+ * Note, that default structure that describes RSS configuration virtio_net_rss_config
+ * contains same info but can't handle table values.
+ * In any case, structure would be passed to virtio hw through sg_buf split by parts
+ * because table sizes may be differ according to the device configuration.
+ */
+#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
+#define VIRTIO_NET_RSS_MAX_TABLE_LEN    128
+struct virtio_net_ctrl_rss {
+	u32 hash_types;
+	u16 indirection_table_mask;
+	u16 unclassified_queue;
+	u16 indirection_table[VIRTIO_NET_RSS_MAX_TABLE_LEN];
+	u16 max_tx_vq;
+	u8 hash_key_length;
+	u8 key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
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
+	struct virtio_net_ctrl_rss rss;
+
+	/* Has control virtqueue */
+	bool has_cvq;
+
+	/* Lock to protect the control VQ */
+	struct mutex cvq_lock;
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
+	/* Work struct for setting rx mode */
+	struct work_struct rx_mode_work;
+
+	/* OK to queue work setting RX mode? */
+	bool rx_mode_work_enabled;
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
+
+	u64 device_stats_cap;
+};
+#endif
diff --git a/drivers/net/virtio/virtnet_main.c b/drivers/net/virtio/virtnet_main.c
index 7c2b2b02338b..1b85ba2bba8d 100644
--- a/drivers/net/virtio/virtnet_main.c
+++ b/drivers/net/virtio/virtnet_main.c
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
@@ -26,6 +24,8 @@
 #include <net/netdev_rx_queue.h>
 #include <net/netdev_queues.h>
 
+#include "virtnet.h"
+
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
 
@@ -49,13 +49,6 @@ module_param(napi_tx, bool, 0644);
 
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
@@ -87,28 +80,6 @@ struct virtnet_sq_free_stats {
 	u64 bytes;
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
 #define VIRTNET_SQ_STAT(name, m) {name, offsetof(struct virtnet_sq_stats, m), -1}
 #define VIRTNET_RQ_STAT(name, m) {name, offsetof(struct virtnet_rq_stats, m), -1}
 
@@ -261,212 +232,12 @@ static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc_qstat[] = {
 #define VIRTNET_Q_TYPE_TX 1
 #define VIRTNET_Q_TYPE_CQ 2
 
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
-	/* Used to protect dim_enabled and inter_coal */
-	struct mutex dim_lock;
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
-};
-
-/* This structure can contain rss message with maximum settings for indirection table and keysize
- * Note, that default structure that describes RSS configuration virtio_net_rss_config
- * contains same info but can't handle table values.
- * In any case, structure would be passed to virtio hw through sg_buf split by parts
- * because table sizes may be differ according to the device configuration.
- */
-#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
-#define VIRTIO_NET_RSS_MAX_TABLE_LEN    128
-struct virtio_net_ctrl_rss {
-	u32 hash_types;
-	u16 indirection_table_mask;
-	u16 unclassified_queue;
-	u16 indirection_table[VIRTIO_NET_RSS_MAX_TABLE_LEN];
-	u16 max_tx_vq;
-	u8 hash_key_length;
-	u8 key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
-};
-
 /* Control VQ buffers: protected by the rtnl lock */
 struct control_buf {
 	struct virtio_net_ctrl_hdr hdr;
 	virtio_net_ctrl_ack status;
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
-	struct virtio_net_ctrl_rss rss;
-
-	/* Has control virtqueue */
-	bool has_cvq;
-
-	/* Lock to protect the control VQ */
-	struct mutex cvq_lock;
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
-	/* Work struct for setting rx mode */
-	struct work_struct rx_mode_work;
-
-	/* OK to queue work setting RX mode? */
-	bool rx_mode_work_enabled;
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
-
-	u64 device_stats_cap;
-};
-
 struct padded_vnet_hdr {
 	struct virtio_net_hdr_v1_hash hdr;
 	/*
-- 
2.32.0.3.g01195cf9f


