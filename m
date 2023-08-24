Return-Path: <bpf+bounces-8506-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B537878A4
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 21:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EA051C20DED
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 19:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA17E1939A;
	Thu, 24 Aug 2023 19:34:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7861819383;
	Thu, 24 Aug 2023 19:34:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F881BF8;
	Thu, 24 Aug 2023 12:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692905653; x=1724441653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j4ddcEFEZzVRA1Vx82zjB/0dlsJ/iPuv6roie3F4TwY=;
  b=Ll7ck1BmDttaDwuUlXiv4xbm/NCbhp5H6/7aCnMX1EJf6+K0gRG5n5uf
   atDsgVUe+YcNKBIpX+QHzbV3QzJPRmBBDBrbEd5noWDV+22v6j03kGaWO
   n2uWxR4Sl2a9Jkg46VR4lFwhrwUQw7zovvw8G0uecJYB6uvvzEQLbSF2r
   QbAvCYAY50Yhn8XaifcM9F2k12e6CRCz0QdG+olJkHLFvLbj52zBt/16H
   eHCsFvHk9DiSWqGU5J7biOt5UOEUExb0UtNS2M/UIUTcbULdQwC1k8KeH
   /u3iLZtWaiZ22UrXvE5eLwnZfsyJWY9CUvqGDxGrG0JDils0AdhAMxYvy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="374516736"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="374516736"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 12:34:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="802667444"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="802667444"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga008.fm.intel.com with ESMTP; 24 Aug 2023 12:34:06 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id DD6793491F;
	Thu, 24 Aug 2023 20:34:04 +0100 (IST)
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
	Saeed Mahameed <saeedm@mellanox.com>
Subject: [RFC bpf-next 09/23] xdp: Add VLAN tag hint
Date: Thu, 24 Aug 2023 21:26:48 +0200
Message-ID: <20230824192703.712881-10-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824192703.712881-1-larysa.zaremba@intel.com>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
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

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 Documentation/networking/xdp-rx-metadata.rst |  8 ++++-
 include/net/xdp.h                            |  4 +++
 kernel/bpf/offload.c                         |  2 ++
 net/core/xdp.c                               | 34 ++++++++++++++++++++
 4 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
index 25ce72af81c2..ea6dd79a21d3 100644
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
index 1e9870d5f025..8bb64fc76498 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -388,6 +388,8 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
 			   bpf_xdp_metadata_rx_timestamp) \
 	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_HASH, \
 			   bpf_xdp_metadata_rx_hash) \
+	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_VLAN_TAG, \
+			   bpf_xdp_metadata_rx_vlan_tag) \
 
 enum {
 #define XDP_METADATA_KFUNC(name, _) name,
@@ -449,6 +451,8 @@ struct xdp_metadata_ops {
 	int	(*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timestamp);
 	int	(*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
 			       enum xdp_rss_hash_type *rss_type);
+	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, u16 *vlan_tci,
+				   __be16 *vlan_proto);
 };
 
 #ifdef CONFIG_NET
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 3e4f2ec1af06..8be340cf06f9 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -849,6 +849,8 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
 		p = ops->xmo_rx_timestamp;
 	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_HASH))
 		p = ops->xmo_rx_hash;
+	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_VLAN_TAG))
+		p = ops->xmo_rx_vlan_tag;
 out:
 	up_read(&bpf_devs_lock);
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index a70670fe9a2d..856e02bb4ce6 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -738,6 +738,40 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash,
 	return -EOPNOTSUPP;
 }
 
+/**
+ * bpf_xdp_metadata_rx_vlan_tag - Get XDP packet outermost VLAN tag
+ * @ctx: XDP context pointer.
+ * @vlan_tci: Destination pointer for VLAN TCI (VID + DEI + PCP)
+ * @vlan_proto: Destination pointer for VLAN Tag protocol identifier (TPID).
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
+					     u16 *vlan_tci,
+					     __be16 *vlan_proto)
+{
+	return -EOPNOTSUPP;
+}
+
 __diag_pop();
 
 BTF_SET8_START(xdp_metadata_kfunc_ids)
-- 
2.41.0


