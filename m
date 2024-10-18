Return-Path: <bpf+bounces-42389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B6F9A39AE
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 11:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF16283433
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 09:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547241E32B2;
	Fri, 18 Oct 2024 09:14:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC481E2303;
	Fri, 18 Oct 2024 09:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242865; cv=none; b=sLo2w8Bnyus+qpcMvBYPwn2/++x+ykSO77/L9/NIzu4vmqviZtqZF+vNslR1L8jePSOm9qiiST84CD6tVNOwnmGAintE8yeqZ5QPK5+gfBWNUMGf6cvraL3TJpTU3+qU2Re3hqMO+mZ68oQtB67Gu7cg4CejPkN1Xt+0x/TDZfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242865; c=relaxed/simple;
	bh=ObmZm9SWgwAXOCoJix+m53ErQSZCmmvZ/mzHD2RA8gU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CA3tgiq1vLGvO8UDpTNgByD8lXG9bcIoEYOdQpDqMhOyUtCXDwLXj9NuZuBa+lv5+uYfAT8gO5Cu8IeEuY/94kQKjqOvT32TrZlQx5m28i/oP2hUl2k2lzZNDFIb70Wx2zgqtMRTRSS71plgf2yRF+oUDpKxCHnk5w8B1kIw1OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XVJrt42MKz1SC9k;
	Fri, 18 Oct 2024 17:13:02 +0800 (CST)
Received: from dggpemf500014.china.huawei.com (unknown [7.185.36.43])
	by mail.maildlp.com (Postfix) with ESMTPS id D1D621A016C;
	Fri, 18 Oct 2024 17:14:19 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500014.china.huawei.com
 (7.185.36.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 18 Oct
 2024 17:14:18 +0800
From: Muyang Tian <tianmuyang@huawei.com>
To: <bpf@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>, Magnus Karlsson
	<magnus.karlsson@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<yanan@huawei.com>, <xiesongyang@huawei.com>, <wuchangye@huawei.com>,
	<liuxin350@huawei.com>, <zhangmingyi5@huawei.com>, <liwei883@huawei.com>,
	<tianmuyang@huawei.com>
Subject: [PATCH bpf-next v2 3/3] xsk: Add Tx GSO type and size offload support
Date: Fri, 18 Oct 2024 17:15:02 +0800
Message-ID: <20241018091502.411513-4-tianmuyang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241018091502.411513-1-tianmuyang@huawei.com>
References: <20241018091502.411513-1-tianmuyang@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf500014.china.huawei.com (7.185.36.43)

This change extends the xsk_tx_metadata struct with
GSO type and size fields.
A new offload XDP_TX_METADATA_GSO is defined, which
offloads gso_type and gso_size in skb_shared_info to XDP.

Signed-off-by: Muyang Tian <tianmuyang@huawei.com>
---
 Documentation/netlink/specs/netdev.yaml |  4 ++++
 include/net/xdp_sock.h                  |  8 ++++++++
 include/net/xdp_sock_drv.h              |  1 +
 include/uapi/linux/if_xdp.h             | 11 +++++++++++
 include/uapi/linux/netdev.h             |  2 ++
 net/xdp/xsk.c                           |  5 +++++
 tools/include/uapi/linux/if_xdp.h       | 11 +++++++++++
 tools/include/uapi/linux/netdev.h       |  2 ++
 8 files changed, 44 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 5beee7c8e7cf..f4aa04eba54c 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -78,6 +78,10 @@ definitions:
         name: tx-checksum
         doc:
           L3 checksum HW offload is supported by the driver.
+      -
+        name: tx-gso
+        doc:
+          GSO type and size is supported by the driver.
   -
     name: queue-type
     type: enum
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index bfe625b55d55..e5acb27c3e07 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -110,11 +110,14 @@ struct xdp_sock {
  *     indicates position where checksumming should start.
  *     csum_offset indicates position where checksum should be stored.
  *
+ * void (*tmo_request_gso)(u32 gso_type, u16 gso_size, void *priv)
+ *     Called when AF_XDP frame requested GSO info.
  */
 struct xsk_tx_metadata_ops {
 	void	(*tmo_request_timestamp)(void *priv);
 	u64	(*tmo_fill_timestamp)(void *priv);
 	void	(*tmo_request_checksum)(u16 csum_start, u16 csum_offset, void *priv);
+	void	(*tmo_request_gso)(u32 gso_type, u16 gso_size, void *priv);
 };
 
 #ifdef CONFIG_XDP_SOCKETS
@@ -170,6 +173,11 @@ static inline void xsk_tx_metadata_request(const struct xsk_tx_metadata *meta,
 		if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM)
 			ops->tmo_request_checksum(meta->request.csum_start,
 						  meta->request.csum_offset, priv);
+
+	if (ops->tmo_request_gso)
+		if (meta->flags & XDP_TXMD_FLAGS_GSO)
+			ops->tmo_request_gso(meta->request.gso_type,
+						  meta->request.gso_size, priv);
 }
 
 /**
diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 0a5dca2b2b3f..b192dab2b835 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -198,6 +198,7 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
 #define XDP_TXMD_FLAGS_VALID ( \
 		XDP_TXMD_FLAGS_TIMESTAMP | \
 		XDP_TXMD_FLAGS_CHECKSUM | \
+		XDP_TXMD_FLAGS_GSO | \
 	0)
 
 static inline bool xsk_buff_valid_tx_metadata(struct xsk_tx_metadata *meta)
diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index 42ec5ddaab8d..c3ea368bf613 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -127,6 +127,11 @@ struct xdp_options {
  */
 #define XDP_TXMD_FLAGS_CHECKSUM			(1 << 1)
 
+/* Request transmit GSO info. GSO type and size are communicated via
+ * csum_start and csum_offset fields of struct xsk_tx_metadata.
+ */
+#define XDP_TXMD_FLAGS_GSO				(1 << 2)
+
 /* AF_XDP offloads request. 'request' union member is consumed by the driver
  * when the packet is being transmitted. 'completion' union member is
  * filled by the driver when the transmit completion arrives.
@@ -142,6 +147,12 @@ struct xsk_tx_metadata {
 			__u16 csum_start;
 			/* Offset from csum_start where checksum should be stored. */
 			__u16 csum_offset;
+
+			/* XDP_TXMD_FLAGS_GSO */
+			/* Identical to skb_shared_info.gso_type*/
+			__u32 gso_type;
+			/* Identical to skb_shared_info.gso_size*/
+			__u16 gso_size;
 		} request;
 
 		struct {
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 1e711d6a4c6b..bd175afb3c6b 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -65,10 +65,12 @@ enum netdev_xdp_rx_metadata {
  *   by the driver.
  * @NETDEV_XSK_FLAGS_TX_CHECKSUM: L3 checksum HW offload is supported by the
  *   driver.
+ * @NETDEV_XSK_FLAGS_TX_GSO: GSO type and size is supported by the driver.
  */
 enum netdev_xsk_flags {
 	NETDEV_XSK_FLAGS_TX_TIMESTAMP = 1,
 	NETDEV_XSK_FLAGS_TX_CHECKSUM = 2,
+	NETDEV_XSK_FLAGS_TX_GSO = 4,
 };
 
 enum netdev_queue_type {
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 1140b2a120ca..5a19edfce16c 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -745,6 +745,11 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 						goto free_err;
 				}
 			}
+
+			if (meta->flags & XDP_TXMD_FLAGS_GSO) {
+				skb_shinfo(skb)->gso_type = meta->request.gso_type;
+				skb_shinfo(skb)->gso_size = meta->request.gso_size;
+			}
 		}
 	}
 
diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index 2f082b01ff22..5714d0be8c53 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -127,6 +127,11 @@ struct xdp_options {
  */
 #define XDP_TXMD_FLAGS_CHECKSUM			(1 << 1)
 
+/* Request transmit GSO info. GSO type and size are communicated via
+ * csum_start and csum_offset fields of struct xsk_tx_metadata.
+ */
+#define XDP_TXMD_FLAGS_GSO				(1 << 2)
+
 /* AF_XDP offloads request. 'request' union member is consumed by the driver
  * when the packet is being transmitted. 'completion' union member is
  * filled by the driver when the transmit completion arrives.
@@ -142,6 +147,12 @@ struct xsk_tx_metadata {
 			__u16 csum_start;
 			/* Offset from csum_start where checksum should be stored. */
 			__u16 csum_offset;
+
+			/* XDP_TXMD_FLAGS_GSO */
+			/* Identical to skb_shared_info.gso_type*/
+			__u32 gso_type;
+			/* Identical to skb_shared_info.gso_size*/
+			__u16 gso_size;
 		} request;
 
 		struct {
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 1e711d6a4c6b..bd175afb3c6b 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -65,10 +65,12 @@ enum netdev_xdp_rx_metadata {
  *   by the driver.
  * @NETDEV_XSK_FLAGS_TX_CHECKSUM: L3 checksum HW offload is supported by the
  *   driver.
+ * @NETDEV_XSK_FLAGS_TX_GSO: GSO type and size is supported by the driver.
  */
 enum netdev_xsk_flags {
 	NETDEV_XSK_FLAGS_TX_TIMESTAMP = 1,
 	NETDEV_XSK_FLAGS_TX_CHECKSUM = 2,
+	NETDEV_XSK_FLAGS_TX_GSO = 4,
 };
 
 enum netdev_queue_type {
-- 
2.41.0


