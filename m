Return-Path: <bpf+bounces-10079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF9B7A0F7B
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 23:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D09281C6C
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 21:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E892E273C1;
	Thu, 14 Sep 2023 21:05:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE54526E29
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 21:04:59 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C2C26B2
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 14:04:59 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-573fdb618eeso1277738a12.0
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 14:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694725499; x=1695330299; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JY88GcOA/etpbruLYEM+JT5tusTRdLV0g0mY/cdkkZg=;
        b=CnM8Nz7id8vJtA9xv0zEErwRmheW82h885KNiaGDivQVA02I7GbTIDjjsu6yFm46SV
         49HZsawgnIJoceNIjfKMGb7BH277JdzhYkQzgLgTHm/2+UTGWqiK0w0+Xxfjgo87eyeu
         QGuj0fHQF2IF67m4eNGuev0MKOungbVae1APZt41QmIEqwdghAVRScLwLuvxw5TBALsS
         qHlo0IT0vSPZE5Gf/weyoE/+cO2PpopfHRUmMUk8yxRA0Oos6MmHm9TC3GHu7qHN5e7K
         ELep5kzgw9oaOKoeZDuDGZhpIVsTmGQy/lKHcovSsI4AkzExMRIKRfxz1h+0Gvamibvp
         wqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694725499; x=1695330299;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JY88GcOA/etpbruLYEM+JT5tusTRdLV0g0mY/cdkkZg=;
        b=qdkc6xI8qxS7/A/dvfFhTK7Fc4mlhYfA55+puhQqJrYpLZY/bCxFnbF6S4vzjSuxnf
         uzgBSpjxlvgUIbA0rVXYyxbyxB2JbDH0zKdWpFwatt86cea2Z22wqzTNmxL51c/daUrT
         HHbv28Ub8/gL5hG5tFNKLGOB2b8vxsDeSGFUWLT4DwBPchgBuFL1gY5tA6dP1z8CVqBx
         fYBqJmBeEBuip0k7I7Xh6N3q6RARPNzij+HL2gvZICKKJQESARF82HhxvCseZCkzirKR
         9I7QHlO9Yoz7E5yTB670xPpqqXiEdUdaZbMnyZlInksiIQt1W5ghAaAE1+rPFxzpqeFS
         OGDQ==
X-Gm-Message-State: AOJu0Yz4wORidYSnF7aSD5OlX5F1bPi1jxWumMd03bKZRqlhLWslsLsM
	jV9wNZJDESfI8At9sY7p6PG6QydXe6XtuxtzvUf71+E8lL30fAspExKZxG5E50qMZ9hH7JoyetY
	ZwtmHkB8f8NhkAxX/QPJ+xHKN6IWV3yeJj/+1gEf7prAyoHVOXg==
X-Google-Smtp-Source: AGHT+IFovq3jHj/M43xTv46pKrbsz8MjBTOkSMv/P0KMkZy9be2wuPayYcx/eSErtaFrdVJbfBGCJQ4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:d203:0:b0:577:f6aa:cc40 with SMTP id
 a3-20020a63d203000000b00577f6aacc40mr91612pgg.12.1694725498427; Thu, 14 Sep
 2023 14:04:58 -0700 (PDT)
Date: Thu, 14 Sep 2023 14:04:45 -0700
In-Reply-To: <20230914210452.2588884-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230914210452.2588884-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230914210452.2588884-3-sdf@google.com>
Subject: [PATCH bpf-next v2 2/9] xsk: add TX timestamp and TX checksum offload support
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"

This change actually defines the (initial) metadata layout
that should be used by AF_XDP userspace (xsk_tx_metadata).
The first field is flags which requests appropriate offloads,
followed by the offload-specific fields. The supported per-device
offloads are exported via netlink (new xsk-flags).

The offloads themselves are still implemented in a bit of a
framework-y fashion that's left from my initial kfunc attempt.
I'm introducing new xsk_tx_metadata_ops which drivers are
supposed to implement. The drivers are also supposed
to call xsk_tx_metadata_request/xsk_tx_metadata_complete in
the right places. Since xsk_tx_metadata_{request,_complete}
are static inline, we don't incur any extra overhead doing
indirect calls.

The benefit of this scheme is as follows:
- keeps all metadata layout parsing away from driver code
- makes it easy to grep and see which drivers implement what
- don't need any extra flags to maintain to keep track of what
  offloads are implemented; if the callback is implemented - the offload
  is supported (used by netlink reporting code)

Two offloads are defined right now:
1. XDP_TX_METADATA_CHECKSUM: skb-style csum_start+csum_offset
2. XDP_TX_METADATA_TIMESTAMP: writes TX timestamp back into metadata
   area upon completion (tx_timestamp field)

The offloads are also implemented for copy mode:
1. Extra XDP_TX_METADATA_CHECKSUM_SW to trigger skb_checksum_help; this
   might be useful as a reference implementation and for testing
2. XDP_TX_METADATA_TIMESTAMP writes SW timestamp from the skb
   destructor (note I'm reusing hwtstamps to pass metadata pointer)

The struct is forward-compatible and can be extended in the future
by appending more fields.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 Documentation/netlink/specs/netdev.yaml | 20 +++++++
 include/linux/netdevice.h               | 27 +++++++++
 include/linux/skbuff.h                  | 14 ++++-
 include/net/xdp_sock.h                  | 80 +++++++++++++++++++++++++
 include/net/xdp_sock_drv.h              | 13 ++++
 include/net/xsk_buff_pool.h             |  6 ++
 include/uapi/linux/if_xdp.h             | 40 +++++++++++++
 include/uapi/linux/netdev.h             | 16 +++++
 net/core/netdev-genl.c                  | 12 +++-
 net/xdp/xsk.c                           | 39 ++++++++++++
 net/xdp/xsk_queue.h                     |  2 +-
 tools/include/uapi/linux/if_xdp.h       | 54 +++++++++++++++--
 tools/include/uapi/linux/netdev.h       | 15 +++++
 13 files changed, 330 insertions(+), 8 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 1c7284fd535b..9002b37b7676 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -42,6 +42,19 @@ name: netdev
         doc:
           This feature informs if netdev implements non-linear XDP buffer
           support in ndo_xdp_xmit callback.
+  -
+    type: flags
+    name: xsk-flags
+    render-max: true
+    entries:
+      -
+        name: tx-timestamp
+        doc:
+          HW timestamping egress packets is supported by the driver.
+      -
+        name: tx-checksum
+        doc:
+          L3 checksum HW offload is supported by the driver.
 
 attribute-sets:
   -
@@ -68,6 +81,12 @@ name: netdev
         type: u32
         checks:
           min: 1
+      -
+        name: xsk-features
+        doc: Bitmask of enabled AF_XDP features.
+        type: u64
+        enum: xsk-flags
+        enum-as-flags: true
 
 operations:
   list:
@@ -84,6 +103,7 @@ name: netdev
             - ifindex
             - xdp-features
             - xdp-zc-max-segs
+            - xsk-features
       dump:
         reply: *dev-all
     -
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0896aaa91dd7..3f02aaa30590 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1647,6 +1647,31 @@ struct net_device_ops {
 						    struct netlink_ext_ack *extack);
 };
 
+/*
+ * This structure defines the AF_XDP TX metadata hooks for network devices.
+ * The following hooks can be defined; unless noted otherwise, they are
+ * optional and can be filled with a null pointer.
+ *
+ * int (*tmo_request_timestamp)(void *priv)
+ *     This function is called when AF_XDP frame requested egress timestamp.
+ *
+ * int (*tmo_fill_timestamp)(void *priv)
+ *     This function is called when AF_XDP frame, that had requested
+ *     egress timestamp, received a completion. The hook needs to return
+ *     the actual HW timestamp.
+ *
+ * int (*tmo_request_checksum)(u16 csum_start, u16 csum_offset, void *priv)
+ *     This function is called when AF_XDP frame requested HW checksum
+ *     offload. csum_start indicates position where checksumming should start.
+ *     csum_offset indicates position where checksum should be stored.
+ *
+ */
+struct xsk_tx_metadata_ops {
+	void	(*tmo_request_timestamp)(void *priv);
+	u64	(*tmo_fill_timestamp)(void *priv);
+	void	(*tmo_request_checksum)(u16 csum_start, u16 csum_offset, void *priv);
+};
+
 /**
  * enum netdev_priv_flags - &struct net_device priv_flags
  *
@@ -1835,6 +1860,7 @@ enum netdev_ml_priv_type {
  *	@netdev_ops:	Includes several pointers to callbacks,
  *			if one wants to override the ndo_*() functions
  *	@xdp_metadata_ops:	Includes pointers to XDP metadata callbacks.
+ *	@xsk_tx_metadata_ops:	Includes pointers to AF_XDP TX metadata callbacks.
  *	@ethtool_ops:	Management operations
  *	@l3mdev_ops:	Layer 3 master device operations
  *	@ndisc_ops:	Includes callbacks for different IPv6 neighbour
@@ -2091,6 +2117,7 @@ struct net_device {
 	unsigned long long	priv_flags;
 	const struct net_device_ops *netdev_ops;
 	const struct xdp_metadata_ops *xdp_metadata_ops;
+	const struct xsk_tx_metadata_ops *xsk_tx_metadata_ops;
 	int			ifindex;
 	unsigned short		gflags;
 	unsigned short		hard_header_len;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 4174c4b82d13..444d35dcd690 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -566,6 +566,15 @@ struct ubuf_info_msgzc {
 int mm_account_pinned_pages(struct mmpin *mmp, size_t size);
 void mm_unaccount_pinned_pages(struct mmpin *mmp);
 
+/* Preserve some data across TX submission and completion.
+ *
+ * Note, this state is stored in the driver. Extending the layout
+ * might need some special care.
+ */
+struct xsk_tx_metadata_compl {
+	__u64 *tx_timestamp;
+};
+
 /* This data is invariant across clones and lives at
  * the end of the header data, ie. at skb->end.
  */
@@ -578,7 +587,10 @@ struct skb_shared_info {
 	/* Warning: this field is not always filled in (UFO)! */
 	unsigned short	gso_segs;
 	struct sk_buff	*frag_list;
-	struct skb_shared_hwtstamps hwtstamps;
+	union {
+		struct skb_shared_hwtstamps hwtstamps;
+		struct xsk_tx_metadata_compl xsk_meta;
+	};
 	unsigned int	gso_type;
 	u32		tskey;
 
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 10993a05d220..c438c614a8d0 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -90,6 +90,74 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
 int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp);
 void __xsk_map_flush(void);
 
+/**
+ *  xsk_tx_metadata_to_compl - Save enough relevant metadata information
+ *  to perform tx completion in the future.
+ *  @meta: pointer to AF_XDP metadata area
+ *  @compl: pointer to output struct xsk_tx_metadata_to_compl
+ *
+ *  This function should be called by the networking device when
+ *  it prepares AF_XDP egress packet. The value of @compl should be stored
+ *  and passed to xsk_tx_metadata_complete upon TX completion.
+ */
+static inline void xsk_tx_metadata_to_compl(struct xsk_tx_metadata *meta,
+					    struct xsk_tx_metadata_compl *compl)
+{
+	if (!meta)
+		return;
+
+	if (meta->flags & XDP_TX_METADATA_TIMESTAMP)
+		compl->tx_timestamp = &meta->completion.tx_timestamp;
+	else
+		compl->tx_timestamp = NULL;
+}
+
+/**
+ *  xsk_tx_metadata_request - Evaluate AF_XDP TX metadata at submission
+ *  and call appropriate xsk_tx_metadata_ops operation.
+ *  @meta: pointer to AF_XDP metadata area
+ *  @ops: pointer to struct xsk_tx_metadata_ops
+ *  @priv: pointer to driver-private aread
+ *
+ *  This function should be called by the networking device when
+ *  it prepares AF_XDP egress packet.
+ */
+static inline void xsk_tx_metadata_request(const struct xsk_tx_metadata *meta,
+					   const struct xsk_tx_metadata_ops *ops,
+					   void *priv)
+{
+	if (!meta)
+		return;
+
+	if (ops->tmo_request_timestamp)
+		if (meta->flags & XDP_TX_METADATA_TIMESTAMP)
+			ops->tmo_request_timestamp(priv);
+
+	if (ops->tmo_request_checksum)
+		if (meta->flags & XDP_TX_METADATA_CHECKSUM)
+			ops->tmo_request_checksum(meta->csum_start, meta->csum_offset, priv);
+}
+
+/**
+ *  xsk_tx_metadata_complete - Evaluate AF_XDP TX metadata at completion
+ *  and call appropriate xsk_tx_metadata_ops operation.
+ *  @compl: pointer to completion metadata produced from xsk_tx_metadata_to_compl
+ *  @ops: pointer to struct xsk_tx_metadata_ops
+ *  @priv: pointer to driver-private aread
+ *
+ *  This function should be called by the networking device upon
+ *  AF_XDP egress completion.
+ */
+static inline void xsk_tx_metadata_complete(struct xsk_tx_metadata_compl *compl,
+					    const struct xsk_tx_metadata_ops *ops,
+					    void *priv)
+{
+	if (!compl)
+		return;
+
+	*compl->tx_timestamp = ops->tmo_fill_timestamp(priv);
+}
+
 #else
 
 static inline int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp)
@@ -106,6 +174,18 @@ static inline void __xsk_map_flush(void)
 {
 }
 
+static inline void xsk_tx_metadata_request(struct xsk_tx_metadata *meta,
+					   const struct xsk_tx_metadata_ops *ops,
+					   void *priv)
+{
+}
+
+static inline void xsk_tx_metadata_complete(struct xsk_tx_metadata_comp *compl,
+					    const struct xsk_tx_metadata_ops *ops,
+					    void *priv)
+{
+}
+
 #endif /* CONFIG_XDP_SOCKETS */
 
 #endif /* _LINUX_XDP_SOCK_H */
diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 1f6fc8c7a84c..e2558ac3e195 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -165,6 +165,14 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
 	return xp_raw_get_data(pool, addr);
 }
 
+static inline struct xsk_tx_metadata *xsk_buff_get_metadata(struct xsk_buff_pool *pool, u64 addr)
+{
+	if (!pool->tx_metadata_len)
+		return NULL;
+
+	return xp_raw_get_data(pool, addr) - pool->tx_metadata_len;
+}
+
 static inline void xsk_buff_dma_sync_for_cpu(struct xdp_buff *xdp, struct xsk_buff_pool *pool)
 {
 	struct xdp_buff_xsk *xskb = container_of(xdp, struct xdp_buff_xsk, xdp);
@@ -324,6 +332,11 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
 	return NULL;
 }
 
+static inline struct xsk_tx_metadata *xsk_buff_get_metadata(struct xsk_buff_pool *pool, u64 addr)
+{
+	return NULL;
+}
+
 static inline void xsk_buff_dma_sync_for_cpu(struct xdp_buff *xdp, struct xsk_buff_pool *pool)
 {
 }
diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
index 1985ffaf9b0c..97f5cc10d79e 100644
--- a/include/net/xsk_buff_pool.h
+++ b/include/net/xsk_buff_pool.h
@@ -33,6 +33,7 @@ struct xdp_buff_xsk {
 };
 
 #define XSK_CHECK_PRIV_TYPE(t) BUILD_BUG_ON(sizeof(t) > offsetofend(struct xdp_buff_xsk, cb))
+#define XSK_TX_COMPL_FITS(t) BUILD_BUG_ON(sizeof(struct xsk_tx_metadata_compl) > sizeof(t))
 
 struct xsk_dma_map {
 	dma_addr_t *dma_pages;
@@ -234,4 +235,9 @@ static inline u64 xp_get_handle(struct xdp_buff_xsk *xskb)
 	return xskb->orig_addr + (offset << XSK_UNALIGNED_BUF_OFFSET_SHIFT);
 }
 
+static inline bool xp_tx_metadata_enabled(const struct xsk_buff_pool *pool)
+{
+	return pool->tx_metadata_len > 0;
+}
+
 #endif /* XSK_BUFF_POOL_H_ */
diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index 2ecf79282c26..ecfd67988283 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -106,6 +106,43 @@ struct xdp_options {
 #define XSK_UNALIGNED_BUF_ADDR_MASK \
 	((1ULL << XSK_UNALIGNED_BUF_OFFSET_SHIFT) - 1)
 
+/* Request transmit timestamp. Upon completion, put it into tx_timestamp
+ * field of struct xsk_tx_metadata.
+ */
+#define XDP_TX_METADATA_TIMESTAMP		(1 << 0)
+
+/* Request transmit checksum offload. Checksum start position and offset
+ * are communicated via csum_start and csum_offset fields of struct
+ * xsk_tx_metadata.
+ */
+#define XDP_TX_METADATA_CHECKSUM		(1 << 1)
+
+/* Force checksum calculation in software. Can be used for testing or
+ * working around potential HW issues. This option causes performance
+ * degradation and only works in XDP_COPY mode.
+ */
+#define XDP_TX_METADATA_CHECKSUM_SW		(1 << 2)
+
+struct xsk_tx_metadata {
+	union {
+		struct {
+			__u32 flags;
+
+			/* XDP_TX_METADATA_CHECKSUM */
+
+			/* Offset from desc->addr where checksumming should start. */
+			__u16 csum_start;
+			/* Offset from csum_start where checksum should be stored. */
+			__u16 csum_offset;
+		};
+
+		struct {
+			/* XDP_TX_METADATA_TIMESTAMP */
+			__u64 tx_timestamp;
+		} completion;
+	};
+};
+
 /* Rx/Tx descriptor */
 struct xdp_desc {
 	__u64 addr;
@@ -122,4 +159,7 @@ struct xdp_desc {
  */
 #define XDP_PKT_CONTD (1 << 0)
 
+/* TX packet carries valid metadata. */
+#define XDP_TX_METADATA (1 << 1)
+
 #endif /* _LINUX_IF_XDP_H */
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index c1634b95c223..138e467a09d6 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -38,11 +38,27 @@ enum netdev_xdp_act {
 	NETDEV_XDP_ACT_MASK = 127,
 };
 
+/**
+ * enum netdev_xsk_flags
+ * @NETDEV_XSK_FLAGS_TX_TIMESTAMP: HW timestamping egress packets is supported
+ *   by the driver.
+ * @NETDEV_XSK_FLAGS_TX_CHECKSUM: L3 checksum HW offload is supported by the
+ *   driver.
+ */
+enum netdev_xsk_flags {
+	NETDEV_XSK_FLAGS_TX_TIMESTAMP = 1,
+	NETDEV_XSK_FLAGS_TX_CHECKSUM = 2,
+
+	/* private: */
+	NETDEV_XSK_FLAGS_MASK = 3,
+};
+
 enum {
 	NETDEV_A_DEV_IFINDEX = 1,
 	NETDEV_A_DEV_PAD,
 	NETDEV_A_DEV_XDP_FEATURES,
 	NETDEV_A_DEV_XDP_ZC_MAX_SEGS,
+	NETDEV_A_DEV_XSK_FEATURES,
 
 	__NETDEV_A_DEV_MAX,
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index c1aea8b756b6..2821546e08de 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -12,15 +12,25 @@ static int
 netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
 		   const struct genl_info *info)
 {
+	u64 xsk_flags = 0;
 	void *hdr;
 
 	hdr = genlmsg_iput(rsp, info);
 	if (!hdr)
 		return -EMSGSIZE;
 
+	if (netdev->xsk_tx_metadata_ops) {
+		if (netdev->xsk_tx_metadata_ops->tmo_fill_timestamp)
+			xsk_flags |= NETDEV_XSK_FLAGS_TX_TIMESTAMP;
+		if (netdev->xsk_tx_metadata_ops->tmo_request_checksum)
+			xsk_flags |= NETDEV_XSK_FLAGS_TX_CHECKSUM;
+	}
+
 	if (nla_put_u32(rsp, NETDEV_A_DEV_IFINDEX, netdev->ifindex) ||
 	    nla_put_u64_64bit(rsp, NETDEV_A_DEV_XDP_FEATURES,
-			      netdev->xdp_features, NETDEV_A_DEV_PAD)) {
+			      netdev->xdp_features, NETDEV_A_DEV_PAD) ||
+	    nla_put_u64_64bit(rsp, NETDEV_A_DEV_XSK_FEATURES,
+			      xsk_flags, NETDEV_A_DEV_PAD)) {
 		genlmsg_cancel(rsp, hdr);
 		return -EINVAL;
 	}
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 5e479869ede1..44cc4f8560d3 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -543,6 +543,13 @@ static u32 xsk_get_num_desc(struct sk_buff *skb)
 
 static void xsk_destruct_skb(struct sk_buff *skb)
 {
+	struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
+
+	if (compl->tx_timestamp) {
+		/* sw completion timestamp, not a real one */
+		*compl->tx_timestamp = ktime_get_tai_fast_ns();
+	}
+
 	xsk_cq_submit_locked(xdp_sk(skb->sk), xsk_get_num_desc(skb));
 	sock_wfree(skb);
 }
@@ -627,8 +634,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 				     struct xdp_desc *desc)
 {
+	struct xsk_tx_metadata *meta = NULL;
 	struct net_device *dev = xs->dev;
 	struct sk_buff *skb = xs->skb;
+	bool first_frag = false;
 	int err;
 
 	if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
@@ -659,6 +668,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 				kfree_skb(skb);
 				goto free_err;
 			}
+
+			first_frag = true;
 		} else {
 			int nr_frags = skb_shinfo(skb)->nr_frags;
 			struct page *page;
@@ -681,12 +692,40 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 			skb_add_rx_frag(skb, nr_frags, page, 0, len, 0);
 		}
+
+		if (first_frag && desc->options & XDP_TX_METADATA) {
+			if (unlikely(xs->pool->tx_metadata_len == 0)) {
+				err = -EINVAL;
+				goto free_err;
+			}
+
+			meta = buffer - xs->pool->tx_metadata_len;
+
+			if (meta->flags & XDP_TX_METADATA_CHECKSUM) {
+				if (unlikely(meta->csum_start + meta->csum_offset +
+					     sizeof(__sum16) > len)) {
+					err = -EINVAL;
+					goto free_err;
+				}
+
+				skb->csum_start = hr + meta->csum_start;
+				skb->csum_offset = meta->csum_offset;
+				skb->ip_summed = CHECKSUM_PARTIAL;
+
+				if (unlikely(meta->flags & XDP_TX_METADATA_CHECKSUM_SW)) {
+					err = skb_checksum_help(skb);
+					if (err)
+						goto free_err;
+				}
+			}
+		}
 	}
 
 	skb->dev = dev;
 	skb->priority = xs->sk.sk_priority;
 	skb->mark = READ_ONCE(xs->sk.sk_mark);
 	skb->destructor = xsk_destruct_skb;
+	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
 	xsk_set_destructor_arg(skb);
 
 	return skb;
diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index c74a1372bcb9..6f2d1621c992 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -137,7 +137,7 @@ static inline bool xskq_cons_read_addr_unchecked(struct xsk_queue *q, u64 *addr)
 
 static inline bool xp_unused_options_set(u32 options)
 {
-	return options & ~XDP_PKT_CONTD;
+	return options & ~(XDP_PKT_CONTD | XDP_TX_METADATA);
 }
 
 static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index 34411a2e5b6c..53ceaae10dd1 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -26,11 +26,11 @@
  */
 #define XDP_USE_NEED_WAKEUP (1 << 3)
 /* By setting this option, userspace application indicates that it can
- * handle multiple descriptors per packet thus enabling xsk core to split
+ * handle multiple descriptors per packet thus enabling AF_XDP to split
  * multi-buffer XDP frames into multiple Rx descriptors. Without this set
- * such frames will be dropped by xsk.
+ * such frames will be dropped.
  */
-#define XDP_USE_SG     (1 << 4)
+#define XDP_USE_SG	(1 << 4)
 
 /* Flags for xsk_umem_config flags */
 #define XDP_UMEM_UNALIGNED_CHUNK_FLAG (1 << 0)
@@ -106,6 +106,43 @@ struct xdp_options {
 #define XSK_UNALIGNED_BUF_ADDR_MASK \
 	((1ULL << XSK_UNALIGNED_BUF_OFFSET_SHIFT) - 1)
 
+/* Request transmit timestamp. Upon completion, put it into tx_timestamp
+ * field of union xsk_tx_metadata.
+ */
+#define XDP_TX_METADATA_TIMESTAMP		(1 << 0)
+
+/* Request transmit checksum offload. Checksum start position and offset
+ * are communicated via csum_start and csum_offset fields of union
+ * xsk_tx_metadata.
+ */
+#define XDP_TX_METADATA_CHECKSUM		(1 << 1)
+
+/* Force checksum calculation in software. Can be used for testing or
+ * working around potential HW issues. This option causes performance
+ * degradation and only works in XDP_COPY mode.
+ */
+#define XDP_TX_METADATA_CHECKSUM_SW		(1 << 2)
+
+struct xsk_tx_metadata {
+	union {
+		struct {
+			__u32 flags;
+
+			/* XDP_TX_METADATA_CHECKSUM */
+
+			/* Offset from desc->addr where checksumming should start. */
+			__u16 csum_start;
+			/* Offset from csum_start where checksum should be stored. */
+			__u16 csum_offset;
+		};
+
+		struct {
+			/* XDP_TX_METADATA_TIMESTAMP */
+			__u64 tx_timestamp;
+		} completion;
+	};
+};
+
 /* Rx/Tx descriptor */
 struct xdp_desc {
 	__u64 addr;
@@ -113,9 +150,16 @@ struct xdp_desc {
 	__u32 options;
 };
 
-/* Flag indicating packet constitutes of multiple buffers*/
+/* UMEM descriptor is __u64 */
+
+/* Flag indicating that the packet continues with the buffer pointed out by the
+ * next frame in the ring. The end of the packet is signalled by setting this
+ * bit to zero. For single buffer packets, every descriptor has 'options' set
+ * to 0 and this maintains backward compatibility.
+ */
 #define XDP_PKT_CONTD (1 << 0)
 
-/* UMEM descriptor is __u64 */
+/* TX packet carries valid metadata. */
+#define XDP_TX_METADATA (1 << 1)
 
 #endif /* _LINUX_IF_XDP_H */
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index c1634b95c223..e8fdc530dcc9 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -38,11 +38,26 @@ enum netdev_xdp_act {
 	NETDEV_XDP_ACT_MASK = 127,
 };
 
+/**
+ * enum netdev_xsk_flags
+ * @NETDEV_XSK_FLAGS_TX_TIMESTAMP: HW timestamping egress packets is supported
+ *   by the driver.
+ * @NETDEV_XSK_FLAGS_TX_CHECKSUM: L3 checksum HW offload is supported by the
+ *   driver.
+ */
+enum netdev_xsk_flags {
+	NETDEV_XSK_FLAGS_TX_TIMESTAMP = 1,
+	NETDEV_XSK_FLAGS_TX_CHECKSUM = 2,
+
+	NETDEV_XSK_FLAGS_MASK = 3,
+};
+
 enum {
 	NETDEV_A_DEV_IFINDEX = 1,
 	NETDEV_A_DEV_PAD,
 	NETDEV_A_DEV_XDP_FEATURES,
 	NETDEV_A_DEV_XDP_ZC_MAX_SEGS,
+	NETDEV_A_DEV_XSK_FEATURES,
 
 	__NETDEV_A_DEV_MAX,
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
-- 
2.42.0.459.ge4e396fd5e-goog


