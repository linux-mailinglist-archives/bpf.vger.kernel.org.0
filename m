Return-Path: <bpf+bounces-42306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C19399A245B
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 15:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450DE1F21826
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 13:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB491DE8BB;
	Thu, 17 Oct 2024 13:54:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E82A1DE8A1;
	Thu, 17 Oct 2024 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173256; cv=none; b=oUuDi+n1luSvke1Pj7XJmyFrCz16IVQF5SuTUeAN2hSERJQuLE9zI8gi73Y9Jl8D8A3rb3txePyOUuky8Qp+9V6IiVEwDEPLqoErM0nJQ1ER4ztqaAfZBQaVQZRjQx6++aRgNJLic2YXq2+WoyavJ9zykC5EZUXiGmdKQucbGWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173256; c=relaxed/simple;
	bh=7bUe1e2eOAXKpLfEIAo5nEVTN3A38DDPwDMm4gQM/5o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tZzzhTBXEsF4JzREIG2cxlaDrD/JzuQCJ5nNGSrS858KV7wfk+/gFnxpHWN4x7LHHHyseLxcOnbusn0ur4KQ4p4UNTpzPXdv1LTd8Uh9rU2gBG6w5Effu/ixDmw3n9rio7j6Kb8mTCAsYkaAL1f+MNLUO5mj9IwJbm8+DmsMeDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XTq5M4HnWz1T8g6;
	Thu, 17 Oct 2024 21:52:07 +0800 (CST)
Received: from dggpemf500014.china.huawei.com (unknown [7.185.36.43])
	by mail.maildlp.com (Postfix) with ESMTPS id 8FC8418009B;
	Thu, 17 Oct 2024 21:54:01 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500014.china.huawei.com
 (7.185.36.43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 17 Oct
 2024 21:54:00 +0800
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
Subject: [PATCH 2/3] xdp: Add Rx GSO hint
Date: Thu, 17 Oct 2024 21:54:29 +0800
Message-ID: <20241017135430.51655-3-tianmuyang@huawei.com>
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


