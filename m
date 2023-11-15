Return-Path: <bpf+bounces-15110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEF67ECA01
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 18:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95320280F81
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 17:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793743A8DE;
	Wed, 15 Nov 2023 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f8cWNdqF"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36B8196;
	Wed, 15 Nov 2023 09:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700070891; x=1731606891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0QrHAmgs0t4o+uwe+40C+imHbH5/gXughQmVyFR8EFg=;
  b=f8cWNdqFeLDyqinHSvsA0Qcj2P/8im4o6beBbe/7Deyse6C6wk+EcI+E
   BN9lwwvNaByNfqL0hlATa6RF18Z09mobKeVcBYa6XNd8jHxeq58ls9zVD
   Bzi5JXJ06qsVzfwqaQiKMLVKdveTw49WtH8Gjrm5EnwTuujaWjtFoY6ub
   FZvLJNCnuMaxMVjiu0bltdr7FpjURgvkanqKWjDI5YMDLKs07gUmW5UfI
   XLxNZqUsYrMVFkrH11cwUY4JOEWMi88Rmz3vBaIhoeHoSh5d7qjpsfqDY
   59FKVIMhOifHXVVnZC2bT/D3jswfZ21be9ocqhsbYP+YgxBQJI7rhnqL5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="422020565"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="422020565"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 09:54:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="12842647"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 15 Nov 2023 09:54:45 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id E6E633581F;
	Wed, 15 Nov 2023 17:54:42 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>,
	xdp-hints@xdp-project.net,
	netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Tariq Toukan <tariqt@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf-next v7 09/18] xdp: Add VLAN tag hint
Date: Wed, 15 Nov 2023 18:52:51 +0100
Message-ID: <20231115175301.534113-10-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115175301.534113-1-larysa.zaremba@intel.com>
References: <20231115175301.534113-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement functionality that enables drivers to expose VLAN tag
to XDP code.

VLAN tag is represented by 2 variables:
- protocol ID, which is passed to bpf code in BE
- VLAN TCI, in host byte order

Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 Documentation/netlink/specs/netdev.yaml      |  4 +++
 Documentation/networking/xdp-rx-metadata.rst |  8 ++++-
 include/net/xdp.h                            |  6 ++++
 include/uapi/linux/netdev.h                  |  5 ++-
 net/core/xdp.c                               | 33 ++++++++++++++++++++
 tools/include/uapi/linux/netdev.h            |  5 ++-
 tools/net/ynl/generated/netdev-user.c        |  1 +
 7 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 14511b13f305..32d619285c5e 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -55,6 +55,10 @@ definitions:
         name: hash
         doc:
           Device is capable of exposing receive packet hash via bpf_xdp_metadata_rx_hash().
+      -
+        name: vlan-tag
+        doc:
+          Device is capable of exposing receive packet VLAN tag via bpf_xdp_metadata_rx_vlan_tag().
 
 attribute-sets:
   -
diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
index 205696780b78..bb53b00d1b2c 100644
--- a/Documentation/networking/xdp-rx-metadata.rst
+++ b/Documentation/networking/xdp-rx-metadata.rst
@@ -18,7 +18,13 @@ Currently, the following kfuncs are supported. In the future, as more
 metadata is supported, this set will grow:
 
 .. kernel-doc:: net/core/xdp.c
-   :identifiers: bpf_xdp_metadata_rx_timestamp bpf_xdp_metadata_rx_hash
+   :identifiers: bpf_xdp_metadata_rx_timestamp
+
+.. kernel-doc:: net/core/xdp.c
+   :identifiers: bpf_xdp_metadata_rx_hash
+
+.. kernel-doc:: net/core/xdp.c
+   :identifiers: bpf_xdp_metadata_rx_vlan_tag
 
 An XDP program can use these kfuncs to read the metadata into stack
 variables for its own consumption. Or, to pass the metadata on to other
diff --git a/include/net/xdp.h b/include/net/xdp.h
index eb77040b4825..ef79f124dbcf 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -399,6 +399,10 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
 			   NETDEV_XDP_RX_METADATA_HASH, \
 			   bpf_xdp_metadata_rx_hash, \
 			   xmo_rx_hash) \
+	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_VLAN_TAG, \
+			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
+			   bpf_xdp_metadata_rx_vlan_tag, \
+			   xmo_rx_vlan_tag) \
 
 enum xdp_rx_metadata {
 #define XDP_METADATA_KFUNC(name, _, __, ___) name,
@@ -460,6 +464,8 @@ struct xdp_metadata_ops {
 	int	(*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timestamp);
 	int	(*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
 			       enum xdp_rss_hash_type *rss_type);
+	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, __be16 *vlan_proto,
+				   u16 *vlan_tci);
 };
 
 #ifdef CONFIG_NET
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 2943a151d4f1..5437226d940d 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -44,13 +44,16 @@ enum netdev_xdp_act {
  *   timestamp via bpf_xdp_metadata_rx_timestamp().
  * @NETDEV_XDP_RX_METADATA_HASH: Device is capable of exposing receive packet
  *   hash via bpf_xdp_metadata_rx_hash().
+ * @NETDEV_XDP_RX_METADATA_VLAN_TAG: Device is capable of exposing receive
+ *   packet VLAN tag via bpf_xdp_metadata_rx_vlan_tag().
  */
 enum netdev_xdp_rx_metadata {
 	NETDEV_XDP_RX_METADATA_TIMESTAMP = 1,
 	NETDEV_XDP_RX_METADATA_HASH = 2,
+	NETDEV_XDP_RX_METADATA_VLAN_TAG = 4,
 
 	/* private: */
-	NETDEV_XDP_RX_METADATA_MASK = 3,
+	NETDEV_XDP_RX_METADATA_MASK = 7,
 };
 
 enum {
diff --git a/net/core/xdp.c b/net/core/xdp.c
index b6f1d6dab3f2..4869c1c2d8f3 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -736,6 +736,39 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash,
 	return -EOPNOTSUPP;
 }
 
+/**
+ * bpf_xdp_metadata_rx_vlan_tag - Get XDP packet outermost VLAN tag
+ * @ctx: XDP context pointer.
+ * @vlan_proto: Destination pointer for VLAN Tag protocol identifier (TPID).
+ * @vlan_tci: Destination pointer for VLAN TCI (VID + DEI + PCP)
+ *
+ * In case of success, ``vlan_proto`` contains *Tag protocol identifier (TPID)*,
+ * usually ``ETH_P_8021Q`` or ``ETH_P_8021AD``, but some networks can use
+ * custom TPIDs. ``vlan_proto`` is stored in **network byte order (BE)**
+ * and should be used as follows:
+ * ``if (vlan_proto == bpf_htons(ETH_P_8021Q)) do_something();``
+ *
+ * ``vlan_tci`` contains the remaining 16 bits of a VLAN tag.
+ * Driver is expected to provide those in **host byte order (usually LE)**,
+ * so the bpf program should not perform byte conversion.
+ * According to 802.1Q standard, *VLAN TCI (Tag control information)*
+ * is a bit field that contains:
+ * *VLAN identifier (VID)* that can be read with ``vlan_tci & 0xfff``,
+ * *Drop eligible indicator (DEI)* - 1 bit,
+ * *Priority code point (PCP)* - 3 bits.
+ * For detailed meaning of DEI and PCP, please refer to other sources.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-EOPNOTSUPP`` : device driver doesn't implement kfunc
+ * * ``-ENODATA``    : VLAN tag was not stripped or is not available
+ */
+__bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
+					     __be16 *vlan_proto, u16 *vlan_tci)
+{
+	return -EOPNOTSUPP;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_SET8_START(xdp_metadata_kfunc_ids)
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 2943a151d4f1..5437226d940d 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -44,13 +44,16 @@ enum netdev_xdp_act {
  *   timestamp via bpf_xdp_metadata_rx_timestamp().
  * @NETDEV_XDP_RX_METADATA_HASH: Device is capable of exposing receive packet
  *   hash via bpf_xdp_metadata_rx_hash().
+ * @NETDEV_XDP_RX_METADATA_VLAN_TAG: Device is capable of exposing receive
+ *   packet VLAN tag via bpf_xdp_metadata_rx_vlan_tag().
  */
 enum netdev_xdp_rx_metadata {
 	NETDEV_XDP_RX_METADATA_TIMESTAMP = 1,
 	NETDEV_XDP_RX_METADATA_HASH = 2,
+	NETDEV_XDP_RX_METADATA_VLAN_TAG = 4,
 
 	/* private: */
-	NETDEV_XDP_RX_METADATA_MASK = 3,
+	NETDEV_XDP_RX_METADATA_MASK = 7,
 };
 
 enum {
diff --git a/tools/net/ynl/generated/netdev-user.c b/tools/net/ynl/generated/netdev-user.c
index b5ffe8cd1144..4e6eb2c7baa4 100644
--- a/tools/net/ynl/generated/netdev-user.c
+++ b/tools/net/ynl/generated/netdev-user.c
@@ -48,6 +48,7 @@ const char *netdev_xdp_act_str(enum netdev_xdp_act value)
 static const char * const netdev_xdp_rx_metadata_strmap[] = {
 	[0] = "timestamp",
 	[1] = "hash",
+	[2] = "vlan-tag",
 };
 
 const char *netdev_xdp_rx_metadata_str(enum netdev_xdp_rx_metadata value)
-- 
2.41.0


