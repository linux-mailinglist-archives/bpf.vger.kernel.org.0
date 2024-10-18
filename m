Return-Path: <bpf+bounces-42388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2279A39AA
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 11:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F0EB25F27
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 09:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BFC1E2838;
	Fri, 18 Oct 2024 09:14:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A61B190486;
	Fri, 18 Oct 2024 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242863; cv=none; b=tKq/o1lW+XQ6YKwFliwdbIHPzfrgxZpJSN9zi0rncvV6958iZzHcMvdz9ZuT/ypnt382yFYbR56pn/0HChGPrcSuf6/eVex54vlopumkH1802CZbyuhF2D7c4iOkw645Vkm/I64GTxdChTIRzNNvcSlOLKJWbQwubnUTdAxQsRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242863; c=relaxed/simple;
	bh=7bUe1e2eOAXKpLfEIAo5nEVTN3A38DDPwDMm4gQM/5o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gtlzZuP0IxZa3Tgfu0R6TfUzf0uauhNNtIfYIoXq7MI5EyflhtVYwsuPkBDnRRGDyfDdWrO7lcOPuUvgvf7eIslJc/12Onc9KwhG6/ylBZEaofVS0i9PIAb5I9hPn7V2ERy+4WyIJrflBBrEf1v9gbxnqszHicrRd4+Yg8qUZvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XVJnR2c7Pz1HLFZ;
	Fri, 18 Oct 2024 17:10:03 +0800 (CST)
Received: from dggpemf500014.china.huawei.com (unknown [7.185.36.43])
	by mail.maildlp.com (Postfix) with ESMTPS id CA9471A016C;
	Fri, 18 Oct 2024 17:14:18 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500014.china.huawei.com
 (7.185.36.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 18 Oct
 2024 17:14:17 +0800
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
Subject: [PATCH bpf-next v2 2/3] xdp: Add Rx GSO hint
Date: Fri, 18 Oct 2024 17:15:01 +0800
Message-ID: <20241018091502.411513-3-tianmuyang@huawei.com>
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

This is an implementation of functionality that allows drivers to
expose GSO information to XDP.
This information includes:
  - GSO info, including GSO type and size in skb_shared_info

Signed-off-by: Muyang Tian <tianmuyang@huawei.com>
---
 Documentation/netlink/specs/netdev.yaml      |  4 ++++
 Documentation/networking/xdp-rx-metadata.rst |  3 +++
 include/net/xdp.h                            | 12 ++++++++++++
 include/uapi/linux/netdev.h                  |  3 +++
 net/core/xdp.c                               | 18 ++++++++++++++++++
 tools/include/uapi/linux/netdev.h            |  3 +++
 6 files changed, 43 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index e6045b447fc1..5beee7c8e7cf 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -62,6 +62,10 @@ definitions:
         name: csum
         doc:
           Device is capable of exposing receive packet checksum via bpf_xdp_metadata_rx_csum().
+      -
+        name: gso
+        doc:
+          Device is capable of exposing receive packet GSO via bpf_xdp_metadata_rx_gso().
   -
     type: flags
     name: xsk-flags
diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
index 6cf273b33ee6..618b9ba606e5 100644
--- a/Documentation/networking/xdp-rx-metadata.rst
+++ b/Documentation/networking/xdp-rx-metadata.rst
@@ -31,6 +31,9 @@ metadata is supported, this set will grow:
 .. kernel-doc:: net/core/xdp.c
    :identifiers: bpf_xdp_metadata_rx_csum
 
+.. kernel-doc:: net/core/xdp.c
+   :identifiers: bpf_xdp_metadata_rx_gso
+
 An XDP program can use these kfuncs to read the metadata into stack
 variables for its own consumption. Or, to pass the metadata on to other
 consumers, an XDP program can store it into the metadata area carried
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 7886658975c4..2e08f54106d3 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -412,6 +412,10 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
 			   NETDEV_XDP_RX_METADATA_CSUM, \
 			   bpf_xdp_metadata_rx_csum, \
 			   xmo_rx_csum) \
+	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_GSO, \
+			   NETDEV_XDP_RX_METADATA_GSO, \
+			   bpf_xdp_metadata_rx_gso, \
+			   xmo_rx_gso) \
 
 enum xdp_rx_metadata {
 #define XDP_METADATA_KFUNC(name, _, __, ___) name,
@@ -501,6 +505,13 @@ union xdp_csum_info {
 	};
 };
 
+struct xdp_gso_info {
+	/* GSO info in skb_shared_info */
+
+	unsigned int	gso_type;
+	unsigned short	gso_size;
+};
+
 struct xdp_metadata_ops {
 	int	(*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timestamp);
 	int	(*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
@@ -509,6 +520,7 @@ struct xdp_metadata_ops {
 				   u16 *vlan_tci);
 	int (*xmo_rx_csum)(const struct xdp_md *ctx, enum xdp_csum_status *csum_status,
 				   union xdp_csum_info *csum_info);
+	int	(*xmo_rx_gso)(const struct xdp_md *ctx, struct xdp_gso_info *gso_info);
 };
 
 #ifdef CONFIG_NET
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index a969b25529a3..1e711d6a4c6b 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -48,12 +48,15 @@ enum netdev_xdp_act {
  *   packet VLAN tag via bpf_xdp_metadata_rx_vlan_tag().
  * @NETDEV_XDP_RX_METADATA_CSUM: Device is capable of exposing receive packet
  *   checksum via bpf_xdp_metadata_rx_csum().
+ * @NETDEV_XDP_RX_METADATA_GSO: Device is capable of exposing receive packet
+ *   GSO via bpf_xdp_metadata_rx_gso().
  */
 enum netdev_xdp_rx_metadata {
 	NETDEV_XDP_RX_METADATA_TIMESTAMP = 1,
 	NETDEV_XDP_RX_METADATA_HASH = 2,
 	NETDEV_XDP_RX_METADATA_VLAN_TAG = 4,
 	NETDEV_XDP_RX_METADATA_CSUM = 8,
+	NETDEV_XDP_RX_METADATA_GSO = 16,
 };
 
 /**
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 583e00d3580a..983440e2b3bf 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -789,6 +789,24 @@ __bpf_kfunc int bpf_xdp_metadata_rx_csum(const struct xdp_md *ctx,
 	return -EOPNOTSUPP;
 }
 
+/**
+ * bpf_xdp_metadata_rx_gso - Read XDP frame GSO info.
+ * @ctx: XDP context pointer.
+ * @gso_info: Destination pointer for GSO info.
+ *
+ * Info (@gso_info) includes GSO type and size from skb_shared_info.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-EOPNOTSUPP`` : means device driver doesn't implement kfunc
+ * * ``-ENODATA``    : means no GSO info available for this frame
+ */
+__bpf_kfunc int bpf_xdp_metadata_rx_gso(const struct xdp_md *ctx,
+					 struct xdp_gso_info *gso_info)
+{
+	return -EOPNOTSUPP;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(xdp_metadata_kfunc_ids)
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index a969b25529a3..1e711d6a4c6b 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -48,12 +48,15 @@ enum netdev_xdp_act {
  *   packet VLAN tag via bpf_xdp_metadata_rx_vlan_tag().
  * @NETDEV_XDP_RX_METADATA_CSUM: Device is capable of exposing receive packet
  *   checksum via bpf_xdp_metadata_rx_csum().
+ * @NETDEV_XDP_RX_METADATA_GSO: Device is capable of exposing receive packet
+ *   GSO via bpf_xdp_metadata_rx_gso().
  */
 enum netdev_xdp_rx_metadata {
 	NETDEV_XDP_RX_METADATA_TIMESTAMP = 1,
 	NETDEV_XDP_RX_METADATA_HASH = 2,
 	NETDEV_XDP_RX_METADATA_VLAN_TAG = 4,
 	NETDEV_XDP_RX_METADATA_CSUM = 8,
+	NETDEV_XDP_RX_METADATA_GSO = 16,
 };
 
 /**
-- 
2.41.0


