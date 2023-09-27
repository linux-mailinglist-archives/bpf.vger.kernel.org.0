Return-Path: <bpf+bounces-10933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12E07AFD4C
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 09:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B2B9E2833D4
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 07:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBE51D554;
	Wed, 27 Sep 2023 07:58:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D5D1CF82;
	Wed, 27 Sep 2023 07:58:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD5A136;
	Wed, 27 Sep 2023 00:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695801500; x=1727337500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iMDvO6bV3YqkOZBbCUGWaOGi0KIr7By3myaSfQLHOq4=;
  b=TTlCgsSHsGMWLBcfe0yY4W5YPjiHt4y3exBk5Mhb3dsUlx8r6l/Anf45
   25YuCsf8v+EHTl8s+Wqsz7f7iCR+bytOrj4yMHP/fPNdYKjyawj08lyX7
   1bCZsycY/xBQ/z8jBmw5n/0bjkRJnQMqR4N/AMivbCaxMo4NsbRU3usBC
   3BvYEsJQOroAt94Nwu4zVVP6ebF2l68fsYJ4qivVrkYY+ctM/oWfI10lS
   +k9Ery17cjN1RWgeGS8J3ZHJqF0HiDq5ZaTflCLp6st9/38lqEcht7qw/
   dXiV4s7ErtjrP5+6TKCwPItLcycXyGTjBigFzNC6VYYZZL6FZKZZDrULY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="366818082"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="366818082"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 00:58:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="725714044"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="725714044"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga006.jf.intel.com with ESMTP; 27 Sep 2023 00:58:12 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A5F4A7EAC2;
	Wed, 27 Sep 2023 08:58:09 +0100 (IST)
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
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [RFC bpf-next v2 12/24] xdp: Add checksum hint
Date: Wed, 27 Sep 2023 09:51:12 +0200
Message-ID: <20230927075124.23941-13-larysa.zaremba@intel.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement functionality that enables drivers to expose to XDP code checksum
information that consists of:

- Checksum status - 2 non-exlusive flags:
  - XDP_CHECKSUM_VERIFIED indicating HW has validated the checksum
    (corresponding to CHECKSUM_UNNECESSARY in sk_buff)
  - XDP_CHECKSUM_COMPLETE signifies the validity of the second argument
    (corresponding to CHECKSUM_COMPLETE in sk_buff)
- Checksum, calculated over the entire packet, valid if the second flag is
  set

Acked-by: Stanislav Fomichev <sdf@google.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 Documentation/networking/xdp-rx-metadata.rst |  3 +++
 include/net/xdp.h                            | 17 +++++++++++++++
 include/uapi/linux/netdev.h                  |  5 ++++-
 net/core/xdp.c                               | 23 ++++++++++++++++++++
 tools/include/uapi/linux/netdev.h            |  5 ++++-
 5 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
index bb53b00d1b2c..af603568e560 100644
--- a/Documentation/networking/xdp-rx-metadata.rst
+++ b/Documentation/networking/xdp-rx-metadata.rst
@@ -26,6 +26,9 @@ metadata is supported, this set will grow:
 .. kernel-doc:: net/core/xdp.c
    :identifiers: bpf_xdp_metadata_rx_vlan_tag
 
+.. kernel-doc:: net/core/xdp.c
+   :identifiers: bpf_xdp_metadata_rx_csum
+
 An XDP program can use these kfuncs to read the metadata into stack
 variables for its own consumption. Or, to pass the metadata on to other
 consumers, an XDP program can store it into the metadata area carried
diff --git a/include/net/xdp.h b/include/net/xdp.h
index ef79f124dbcf..1dba8ab6c6ba 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -403,6 +403,10 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
 			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
 			   bpf_xdp_metadata_rx_vlan_tag, \
 			   xmo_rx_vlan_tag) \
+	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CSUM, \
+			   NETDEV_XDP_RX_METADATA_CSUM, \
+			   bpf_xdp_metadata_rx_csum, \
+			   xmo_rx_csum) \
 
 enum xdp_rx_metadata {
 #define XDP_METADATA_KFUNC(name, _, __, ___) name,
@@ -460,12 +464,25 @@ enum xdp_rss_hash_type {
 	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
 };
 
+enum xdp_csum_status {
+	/* HW had parsed headers and validated the outermost checksum,
+	 * same as ``CHECKSUM_UNNECESSARY`` in ``sk_buff``.
+	 */
+	XDP_CHECKSUM_VERIFIED		= BIT(0),
+
+	/* Checksum, calculated over the entire packet is provided */
+	XDP_CHECKSUM_COMPLETE		= BIT(1),
+};
+
 struct xdp_metadata_ops {
 	int	(*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timestamp);
 	int	(*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
 			       enum xdp_rss_hash_type *rss_type);
 	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, __be16 *vlan_proto,
 				   u16 *vlan_tci);
+	int	(*xmo_rx_csum)(const struct xdp_md *ctx,
+			       enum xdp_csum_status *csum_status,
+			       __wsum *csum);
 };
 
 #ifdef CONFIG_NET
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 661f603e3e43..ef477d7391e2 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -46,14 +46,17 @@ enum netdev_xdp_act {
  *   hash via bpf_xdp_metadata_rx_hash().
  * @NETDEV_XDP_RX_METADATA_VLAN_TAG: Device is capable of exposing stripped
  *   receive VLAN tag (proto and TCI) via bpf_xdp_metadata_rx_vlan_tag().
+ * @NETDEV_XDP_RX_METADATA_CSUM: Device is capable of exposing receive checksum
+     information via bpf_xdp_metadata_rx_csum().
  */
 enum netdev_xdp_rx_metadata {
 	NETDEV_XDP_RX_METADATA_TIMESTAMP = 1,
 	NETDEV_XDP_RX_METADATA_HASH = 2,
 	NETDEV_XDP_RX_METADATA_VLAN_TAG = 4,
+	NETDEV_XDP_RX_METADATA_CSUM = 8,
 
 	/* private: */
-	NETDEV_XDP_RX_METADATA_MASK = 7,
+	NETDEV_XDP_RX_METADATA_MASK = 15,
 };
 
 enum {
diff --git a/net/core/xdp.c b/net/core/xdp.c
index fb87925b3dc3..9e6fc52b3dca 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -771,6 +771,29 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
 	return -EOPNOTSUPP;
 }
 
+/**
+ * bpf_xdp_metadata_rx_csum - Get checksum status with additional info.
+ * @ctx: XDP context pointer.
+ * @csum_status: Destination for checksum status.
+ * @csum: Destination for complete checksum.
+ *
+ * Status (@csum_status) is a bitfield that informs, what checksum
+ * processing was performed. If ``XDP_CHECKSUM_COMPLETE`` in status is set,
+ * second argument (@csum) contains a checksum, calculated over the entire
+ * packet.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-EOPNOTSUPP`` : device driver doesn't implement kfunc
+ * * ``-ENODATA``    : Checksum status is unknown
+ */
+__bpf_kfunc int bpf_xdp_metadata_rx_csum(const struct xdp_md *ctx,
+					 enum xdp_csum_status *csum_status,
+					 __wsum *csum)
+{
+	return -EOPNOTSUPP;
+}
+
 __diag_pop();
 
 BTF_SET8_START(xdp_metadata_kfunc_ids)
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 661f603e3e43..ef477d7391e2 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -46,14 +46,17 @@ enum netdev_xdp_act {
  *   hash via bpf_xdp_metadata_rx_hash().
  * @NETDEV_XDP_RX_METADATA_VLAN_TAG: Device is capable of exposing stripped
  *   receive VLAN tag (proto and TCI) via bpf_xdp_metadata_rx_vlan_tag().
+ * @NETDEV_XDP_RX_METADATA_CSUM: Device is capable of exposing receive checksum
+     information via bpf_xdp_metadata_rx_csum().
  */
 enum netdev_xdp_rx_metadata {
 	NETDEV_XDP_RX_METADATA_TIMESTAMP = 1,
 	NETDEV_XDP_RX_METADATA_HASH = 2,
 	NETDEV_XDP_RX_METADATA_VLAN_TAG = 4,
+	NETDEV_XDP_RX_METADATA_CSUM = 8,
 
 	/* private: */
-	NETDEV_XDP_RX_METADATA_MASK = 7,
+	NETDEV_XDP_RX_METADATA_MASK = 15,
 };
 
 enum {
-- 
2.41.0


