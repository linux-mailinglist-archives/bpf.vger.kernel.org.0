Return-Path: <bpf+bounces-10932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FF97AFD4A
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 09:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 6BBE32835EC
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 07:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E407E1D546;
	Wed, 27 Sep 2023 07:58:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A18D1CAB1;
	Wed, 27 Sep 2023 07:58:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CE4199;
	Wed, 27 Sep 2023 00:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695801496; x=1727337496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kL2PfFepj60i0wQrFR87PfBnK0PjV7k76VV5tK2oWAk=;
  b=aNpfdsEMpKqo1qfht0oXEgfTdpho7swXlK1b1FWw4qYCleEU6V2OaK31
   zxlBbPxP/2rbsI4eNhCMJySVRGunl1KiGUhdvsphkJYca36LDYHTlHPS3
   VY9LF2pdeHSogLn1NIt918l29K9CWJSJP6fDHnysDHlEj/ELctg9VXuaT
   dwMKdd+P50gZprY21uGH2CiWVuxt5GZqQY7ey7bmGI64OUMauUP3Pus/q
   JS1N3Nod1e56nKA9yYe/h9ugkGsiGu6TBr3rcxyn8CBL8tGLLgoW7U0iv
   fZvhE1dNlXa8jx8mZb3JXEfqXt6TIx9iEdRgNhva90eXuqFojyW8VWALu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="362008538"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="362008538"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 00:58:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="752478143"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="752478143"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga007.fm.intel.com with ESMTP; 27 Sep 2023 00:58:03 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id BC04D7EAC1;
	Wed, 27 Sep 2023 08:58:00 +0100 (IST)
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
	Jesper Dangaard Brouer <brouer@redhat.com>,
	Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>,
	xdp-hints@xdp-project.net,
	netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [RFC bpf-next v2 09/24] xdp: Add VLAN tag hint
Date: Wed, 27 Sep 2023 09:51:09 +0200
Message-ID: <20230927075124.23941-10-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927075124.23941-1-larysa.zaremba@intel.com>
References: <20230927075124.23941-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement functionality that enables drivers to expose VLAN tag
to XDP code.

VLAN tag is represented by 2 variables:
- protocol ID, which is passed to bpf code in BE
- VLAN TCI, in host byte order

Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 Documentation/networking/xdp-rx-metadata.rst |  8 ++++-
 include/net/xdp.h                            |  6 ++++
 include/uapi/linux/netdev.h                  |  5 ++-
 net/core/xdp.c                               | 33 ++++++++++++++++++++
 tools/include/uapi/linux/netdev.h            |  5 ++-
 5 files changed, 54 insertions(+), 3 deletions(-)

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
index 2943a151d4f1..661f603e3e43 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -44,13 +44,16 @@ enum netdev_xdp_act {
  *   timestamp via bpf_xdp_metadata_rx_timestamp().
  * @NETDEV_XDP_RX_METADATA_HASH: Device is capable of exposing receive packet
  *   hash via bpf_xdp_metadata_rx_hash().
+ * @NETDEV_XDP_RX_METADATA_VLAN_TAG: Device is capable of exposing stripped
+ *   receive VLAN tag (proto and TCI) via bpf_xdp_metadata_rx_vlan_tag().
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
index df4789ab512d..fb87925b3dc3 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -738,6 +738,39 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash,
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
 __diag_pop();
 
 BTF_SET8_START(xdp_metadata_kfunc_ids)
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 2943a151d4f1..661f603e3e43 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -44,13 +44,16 @@ enum netdev_xdp_act {
  *   timestamp via bpf_xdp_metadata_rx_timestamp().
  * @NETDEV_XDP_RX_METADATA_HASH: Device is capable of exposing receive packet
  *   hash via bpf_xdp_metadata_rx_hash().
+ * @NETDEV_XDP_RX_METADATA_VLAN_TAG: Device is capable of exposing stripped
+ *   receive VLAN tag (proto and TCI) via bpf_xdp_metadata_rx_vlan_tag().
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
-- 
2.41.0


