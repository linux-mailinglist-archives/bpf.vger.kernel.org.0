Return-Path: <bpf+bounces-42304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 717409A2453
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 15:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3EC1F2171C
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 13:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93F41DE4E2;
	Thu, 17 Oct 2024 13:54:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A101DDC38;
	Thu, 17 Oct 2024 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173249; cv=none; b=oHHgVDzXiWBlqZxR8x8gQHwyRtYFjCqSHE/Hj8oMl2uQrPogO9rrOKW7Uue0aUIeGRLnBd5tLBGRMDoOcvbAynlZ94vASBc9QlyYnkIf7c40wVsbt8KB3SxU/PIK6tOqLAXlbDbIyouksGV0ulKA48vkpeGKBn1J5En0I8SOAyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173249; c=relaxed/simple;
	bh=qFfimvYCTg1f4s+WPYMqLgC9uLTOD1oJ4p92PTq9tLM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LPx+KOl7RcpJHMtjzLCzVr1aPsNUCZI478PXl3+6PGbLvG+yYEcv+w49R/Z8a5cz2cvwJwhsN51bT/GpfADdomkqhQcagkbsvZy0wzIOfJXXxTpdh0GLEEL8go7W1plWDBNtIzByIVnOZBX/JYJn+Ho9/3bEMTnRIpaUzygOmII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XTq6f6zzrzQrgt;
	Thu, 17 Oct 2024 21:53:14 +0800 (CST)
Received: from dggpemf500014.china.huawei.com (unknown [7.185.36.43])
	by mail.maildlp.com (Postfix) with ESMTPS id 900171400D4;
	Thu, 17 Oct 2024 21:54:00 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500014.china.huawei.com
 (7.185.36.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 17 Oct
 2024 21:53:59 +0800
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
Subject: [PATCH 1/3] xdp: Add Rx checksum hint
Date: Thu, 17 Oct 2024 21:54:28 +0800
Message-ID: <20241017135430.51655-2-tianmuyang@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241017135430.51655-1-tianmuyang@huawei.com>
References: <20241017135430.51655-1-tianmuyang@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf500014.china.huawei.com (7.185.36.43)

This is an implementation of functionality that allows drivers
to expose checksum information to XDP.
This information includes:
- Checksum info, a union of
  - complete checksum, if checksum is complete
  - skb-style checksum start and offset, if checksum is partial
- Checksum status, an enum which is the same as skb checksums in
  skbuff.h, identical to sk_buff.ip_summed

Signed-off-by: Muyang Tian <tianmuyang@huawei.com>
---
 Documentation/netlink/specs/netdev.yaml      |  4 +++
 Documentation/networking/xdp-rx-metadata.rst |  3 ++
 include/net/xdp.h                            | 38 ++++++++++++++++++++
 include/uapi/linux/netdev.h                  |  3 ++
 net/core/xdp.c                               | 23 ++++++++++++
 tools/include/uapi/linux/netdev.h            |  3 ++
 6 files changed, 74 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 08412c279297..e6045b447fc1 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -58,6 +58,10 @@ definitions:
         name: vlan-tag
         doc:
           Device is capable of exposing receive packet VLAN tag via bpf_xdp_metadata_rx_vlan_tag().
+      -
+        name: csum
+        doc:
+          Device is capable of exposing receive packet checksum via bpf_xdp_metadata_rx_csum().
   -
     type: flags
     name: xsk-flags
diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
index a6e0ece18be5..6cf273b33ee6 100644
--- a/Documentation/networking/xdp-rx-metadata.rst
+++ b/Documentation/networking/xdp-rx-metadata.rst
@@ -28,6 +28,9 @@ metadata is supported, this set will grow:
 .. kernel-doc:: net/core/xdp.c
    :identifiers: bpf_xdp_metadata_rx_vlan_tag
 
+.. kernel-doc:: net/core/xdp.c
+   :identifiers: bpf_xdp_metadata_rx_csum
+
 An XDP program can use these kfuncs to read the metadata into stack
 variables for its own consumption. Or, to pass the metadata on to other
 consumers, an XDP program can store it into the metadata area carried
diff --git a/include/net/xdp.h b/include/net/xdp.h
index e6770dd40c91..7886658975c4 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -408,6 +408,10 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
 			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
 			   bpf_xdp_metadata_rx_vlan_tag, \
 			   xmo_rx_vlan_tag) \
+	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CSUM, \
+			   NETDEV_XDP_RX_METADATA_CSUM, \
+			   bpf_xdp_metadata_rx_csum, \
+			   xmo_rx_csum) \
 
 enum xdp_rx_metadata {
 #define XDP_METADATA_KFUNC(name, _, __, ___) name,
@@ -465,12 +469,46 @@ enum xdp_rss_hash_type {
 	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
 };
 
+enum xdp_csum_status {
+	/* The following enums are the same as skb checksums in skbuff.h, refer to
+	 * DOC: skb checksums for more details.
+	 */
+
+	XDP_CHECKSUM_NONE = 0,
+	XDP_CHECKSUM_UNNECESSARY = 1,
+	/* Checksum, calculated over the entire packet is provided, as ``csum`` in
+	 * ``xdp_csum_info``.
+	 */
+	XDP_CHECKSUM_COMPLETE = 2,
+	/* Refer to ``csum_start`` and ``csum_offset`` in ``xdp_csum_info`` for more information. */
+	XDP_CHECKSUM_PARTIAL = 3,
+};
+
+union xdp_csum_info {
+	/* Checksum, calculated over the whole packet.
+	 * Available, if ``status & XDP_CHECKSUM_COMPLETE``.
+	 */
+	__wsum csum;
+	/* Checksum referred to by ``csum_start + csum_offset`` is considered
+	 * valid, but was never calculated, TX device has to do this,
+	 * starting from csum_start packet byte.
+	 * Any preceding checksums are also considered valid.
+	 * Available, if ``status == XDP_CHECKSUM_PARTIAL``.
+	 */
+	struct {
+		u16 csum_start;
+		u16 csum_offset;
+	};
+};
+
 struct xdp_metadata_ops {
 	int	(*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timestamp);
 	int	(*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
 			       enum xdp_rss_hash_type *rss_type);
 	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, __be16 *vlan_proto,
 				   u16 *vlan_tci);
+	int (*xmo_rx_csum)(const struct xdp_md *ctx, enum xdp_csum_status *csum_status,
+				   union xdp_csum_info *csum_info);
 };
 
 #ifdef CONFIG_NET
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 7c308f04e7a0..a969b25529a3 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -46,11 +46,14 @@ enum netdev_xdp_act {
  *   hash via bpf_xdp_metadata_rx_hash().
  * @NETDEV_XDP_RX_METADATA_VLAN_TAG: Device is capable of exposing receive
  *   packet VLAN tag via bpf_xdp_metadata_rx_vlan_tag().
+ * @NETDEV_XDP_RX_METADATA_CSUM: Device is capable of exposing receive packet
+ *   checksum via bpf_xdp_metadata_rx_csum().
  */
 enum netdev_xdp_rx_metadata {
 	NETDEV_XDP_RX_METADATA_TIMESTAMP = 1,
 	NETDEV_XDP_RX_METADATA_HASH = 2,
 	NETDEV_XDP_RX_METADATA_VLAN_TAG = 4,
+	NETDEV_XDP_RX_METADATA_CSUM = 8,
 };
 
 /**
diff --git a/net/core/xdp.c b/net/core/xdp.c
index bcc5551c6424..583e00d3580a 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -766,6 +766,29 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
 	return -EOPNOTSUPP;
 }
 
+/**
+ * bpf_xdp_metadata_rx_csum - Read XDP frame checksum status and info.
+ * @ctx: XDP context pointer.
+ * @csum_status: Destination pointer for checksum status.
+ * @csum_info: Destination pointer for complete checksum or partial checksum offset.
+ *
+ * Status (@csum_status) is an enum that informs what checksum processing was
+ * performed, same as sk_buff.ip_summed. Additional results of such processing,
+ * such as complete checksum or partial checksum offsets, are passed as
+ * info (@csum_info).
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-EOPNOTSUPP`` : means device driver doesn't implement kfunc
+ * * ``-ENODATA``    : means checksum status is unknown for this frame
+ */
+__bpf_kfunc int bpf_xdp_metadata_rx_csum(const struct xdp_md *ctx,
+					 enum xdp_csum_status *csum_status,
+					 union xdp_csum_info *csum_info)
+{
+	return -EOPNOTSUPP;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(xdp_metadata_kfunc_ids)
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 7c308f04e7a0..a969b25529a3 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -46,11 +46,14 @@ enum netdev_xdp_act {
  *   hash via bpf_xdp_metadata_rx_hash().
  * @NETDEV_XDP_RX_METADATA_VLAN_TAG: Device is capable of exposing receive
  *   packet VLAN tag via bpf_xdp_metadata_rx_vlan_tag().
+ * @NETDEV_XDP_RX_METADATA_CSUM: Device is capable of exposing receive packet
+ *   checksum via bpf_xdp_metadata_rx_csum().
  */
 enum netdev_xdp_rx_metadata {
 	NETDEV_XDP_RX_METADATA_TIMESTAMP = 1,
 	NETDEV_XDP_RX_METADATA_HASH = 2,
 	NETDEV_XDP_RX_METADATA_VLAN_TAG = 4,
+	NETDEV_XDP_RX_METADATA_CSUM = 8,
 };
 
 /**
-- 
2.41.0


