Return-Path: <bpf+bounces-27881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF238B2F16
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 05:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53DC61F216BE
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 03:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4645278C9D;
	Fri, 26 Apr 2024 03:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oYTYBjmO"
X-Original-To: bpf@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EC277F15;
	Fri, 26 Apr 2024 03:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714102778; cv=none; b=st+uPiE7A5od/FqBbA6i3f4p7gp9yCdKgEhlbeQ4lA98pavAUynTgL5UEp72fIr6wibB7BB8HHUY/0NoP7xgrIBL3TQBuOFh7u38NIFwwWC20580tPtRP7ydOo5eBPl9klhncC5H6BIJbYKg65mFwxOde1Y8D2F+XEIv5RUAO3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714102778; c=relaxed/simple;
	bh=TodF9TeWMpxYPKN93QRWe7nG2Pyh1EhsKHXuleHLSnA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sfx2qRh4FSGzhLNMKV6nZ9sU1YFusWK8BJ9OpgRYyEgrArlno0WNR5jwx4sZ8cKkx4JsS/LyuWtN39ZamoMLdOWKeECVj/p1rw2vMswGVy09dAUIgkOCBRq10ga3iIskaxly8pD+SF7lC22QEhLyvud8oJbaO/wQvGwGYaK6KXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oYTYBjmO; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714102774; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=//wF16EoJK4cWrREf4HMlhdqrpAHbS60oTEaoobU9Xs=;
	b=oYTYBjmO/vi7cEFjbwNfOiXeYqjdgzmOlBwHfJtLkpZNiAxOFICwoKg4a0fZty1zw2IP/d/OULf/IFB9yaTR2yvnB0tWoRGYtmb3wjZy+pf9pFy6fF2o0ONWvXV/l2OV62TKdY5KQDSvqa75oUISY7q9tCsH8kUXjqClBv7sVvw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W5Hk9cZ_1714102771;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5Hk9cZ_1714102771)
          by smtp.aliyun-inc.com;
          Fri, 26 Apr 2024 11:39:32 +0800
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
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v7 2/8] virtio_net: introduce device stats feature and structures
Date: Fri, 26 Apr 2024 11:39:22 +0800
Message-Id: <20240426033928.77778-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240426033928.77778-1-xuanzhuo@linux.alibaba.com>
References: <20240426033928.77778-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 435b736161fa
Content-Transfer-Encoding: 8bit

The virtio-net device stats spec:

https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82

We introduce the relative feature and structures.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 include/uapi/linux/virtio_net.h | 143 ++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index cc65ef0f3c3e..ac9174717ef1 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -56,6 +56,7 @@
 #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
+#define VIRTIO_NET_F_DEVICE_STATS 50	/* Device can provide device-level statistics. */
 #define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notification coalescing */
 #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */
 #define VIRTIO_NET_F_GUEST_USO4	54	/* Guest can handle USOv4 in. */
@@ -406,4 +407,146 @@ struct  virtio_net_ctrl_coal_vq {
 	struct virtio_net_ctrl_coal coal;
 };
 
+/*
+ * Device Statistics
+ */
+#define VIRTIO_NET_CTRL_STATS         8
+#define VIRTIO_NET_CTRL_STATS_QUERY   0
+#define VIRTIO_NET_CTRL_STATS_GET     1
+
+struct virtio_net_stats_capabilities {
+
+#define VIRTIO_NET_STATS_TYPE_CVQ       (1ULL << 32)
+
+#define VIRTIO_NET_STATS_TYPE_RX_BASIC  (1ULL << 0)
+#define VIRTIO_NET_STATS_TYPE_RX_CSUM   (1ULL << 1)
+#define VIRTIO_NET_STATS_TYPE_RX_GSO    (1ULL << 2)
+#define VIRTIO_NET_STATS_TYPE_RX_SPEED  (1ULL << 3)
+
+#define VIRTIO_NET_STATS_TYPE_TX_BASIC  (1ULL << 16)
+#define VIRTIO_NET_STATS_TYPE_TX_CSUM   (1ULL << 17)
+#define VIRTIO_NET_STATS_TYPE_TX_GSO    (1ULL << 18)
+#define VIRTIO_NET_STATS_TYPE_TX_SPEED  (1ULL << 19)
+
+	__le64 supported_stats_types[1];
+};
+
+struct virtio_net_ctrl_queue_stats {
+	struct {
+		__le16 vq_index;
+		__le16 reserved[3];
+		__le64 types_bitmap[1];
+	} stats[1];
+};
+
+struct virtio_net_stats_reply_hdr {
+#define VIRTIO_NET_STATS_TYPE_REPLY_CVQ       32
+
+#define VIRTIO_NET_STATS_TYPE_REPLY_RX_BASIC  0
+#define VIRTIO_NET_STATS_TYPE_REPLY_RX_CSUM   1
+#define VIRTIO_NET_STATS_TYPE_REPLY_RX_GSO    2
+#define VIRTIO_NET_STATS_TYPE_REPLY_RX_SPEED  3
+
+#define VIRTIO_NET_STATS_TYPE_REPLY_TX_BASIC  16
+#define VIRTIO_NET_STATS_TYPE_REPLY_TX_CSUM   17
+#define VIRTIO_NET_STATS_TYPE_REPLY_TX_GSO    18
+#define VIRTIO_NET_STATS_TYPE_REPLY_TX_SPEED  19
+	__u8 type;
+	__u8 reserved;
+	__le16 vq_index;
+	__le16 reserved1;
+	__le16 size;
+};
+
+struct virtio_net_stats_cvq {
+	struct virtio_net_stats_reply_hdr hdr;
+
+	__le64 command_num;
+	__le64 ok_num;
+};
+
+struct virtio_net_stats_rx_basic {
+	struct virtio_net_stats_reply_hdr hdr;
+
+	__le64 rx_notifications;
+
+	__le64 rx_packets;
+	__le64 rx_bytes;
+
+	__le64 rx_interrupts;
+
+	__le64 rx_drops;
+	__le64 rx_drop_overruns;
+};
+
+struct virtio_net_stats_tx_basic {
+	struct virtio_net_stats_reply_hdr hdr;
+
+	__le64 tx_notifications;
+
+	__le64 tx_packets;
+	__le64 tx_bytes;
+
+	__le64 tx_interrupts;
+
+	__le64 tx_drops;
+	__le64 tx_drop_malformed;
+};
+
+struct virtio_net_stats_rx_csum {
+	struct virtio_net_stats_reply_hdr hdr;
+
+	__le64 rx_csum_valid;
+	__le64 rx_needs_csum;
+	__le64 rx_csum_none;
+	__le64 rx_csum_bad;
+};
+
+struct virtio_net_stats_tx_csum {
+	struct virtio_net_stats_reply_hdr hdr;
+
+	__le64 tx_csum_none;
+	__le64 tx_needs_csum;
+};
+
+struct virtio_net_stats_rx_gso {
+	struct virtio_net_stats_reply_hdr hdr;
+
+	__le64 rx_gso_packets;
+	__le64 rx_gso_bytes;
+	__le64 rx_gso_packets_coalesced;
+	__le64 rx_gso_bytes_coalesced;
+};
+
+struct virtio_net_stats_tx_gso {
+	struct virtio_net_stats_reply_hdr hdr;
+
+	__le64 tx_gso_packets;
+	__le64 tx_gso_bytes;
+	__le64 tx_gso_segments;
+	__le64 tx_gso_segments_bytes;
+	__le64 tx_gso_packets_noseg;
+	__le64 tx_gso_bytes_noseg;
+};
+
+struct virtio_net_stats_rx_speed {
+	struct virtio_net_stats_reply_hdr hdr;
+
+	/* rx_{packets,bytes}_allowance_exceeded are too long. So rename to
+	 * short name.
+	 */
+	__le64 rx_ratelimit_packets;
+	__le64 rx_ratelimit_bytes;
+};
+
+struct virtio_net_stats_tx_speed {
+	struct virtio_net_stats_reply_hdr hdr;
+
+	/* tx_{packets,bytes}_allowance_exceeded are too long. So rename to
+	 * short name.
+	 */
+	__le64 tx_ratelimit_packets;
+	__le64 tx_ratelimit_bytes;
+};
+
 #endif /* _UAPI_LINUX_VIRTIO_NET_H */
-- 
2.32.0.3.g01195cf9f


