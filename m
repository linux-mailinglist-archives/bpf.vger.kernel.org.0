Return-Path: <bpf+bounces-12058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 337E97C73D6
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 19:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F141C211F1
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 17:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33A6347CB;
	Thu, 12 Oct 2023 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V39jBwi0"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B3C38FBF;
	Thu, 12 Oct 2023 17:12:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13D0C6;
	Thu, 12 Oct 2023 10:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697130774; x=1728666774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kL2PfFepj60i0wQrFR87PfBnK0PjV7k76VV5tK2oWAk=;
  b=V39jBwi0TjMJvCPJMOgUxR+pldx09b41z5Dtmc8mQLr35Fp0I/y/gqow
   TlXrpFRwgza36zdN51+bRXpSK4fxo9CusxHPVFdZfrMR6ouKtegIDu8Sz
   Fq6+FfCXy00bx2yVU7yK2e2Sh5uyqanNbgHmxe1JbhKrmbNvRdz5S5sV1
   SCTxdxyzvBzVLUEIvrv6OEpsjgOYVF/FZya/D9mKtrMEn6pVYwvUr63zQ
   i+Fe7aeER/KYOmojbRWuigMhGn0hJOZxmqYlmyXXc+LV0QDmJcTQ4hZTk
   EcZMlEfIUrXITAUiOZTvs91xEpQVInKif5Qt0opbC4AUiJoO3KXd1yRFJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="416027701"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="416027701"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 10:12:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="783774053"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="783774053"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga008.jf.intel.com with ESMTP; 12 Oct 2023 10:12:11 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id E248533E95;
	Thu, 12 Oct 2023 18:12:08 +0100 (IST)
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
	Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>,
	Saeed Mahameed <saeedm@mellanox.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH bpf-next v6 08/18] xdp: Add VLAN tag hint
Date: Thu, 12 Oct 2023 19:05:14 +0200
Message-ID: <20231012170524.21085-9-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012170524.21085-1-larysa.zaremba@intel.com>
References: <20231012170524.21085-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
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


