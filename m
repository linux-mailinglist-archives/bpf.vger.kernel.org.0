Return-Path: <bpf+bounces-5361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 488E9759DB8
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 20:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79AC61C2114B
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 18:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6701022EE8;
	Wed, 19 Jul 2023 18:42:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FA922EE2;
	Wed, 19 Jul 2023 18:42:06 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747BCF0;
	Wed, 19 Jul 2023 11:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689792124; x=1721328124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lDrcEf1d8u/SFTIzsv+xhK8e87x0bE3WJg0tPDQPAPE=;
  b=UZfE4WF4uUWdgJH7r3Yps0WAhvUIV67Kch/M5ZLQM8zDWGCG95+IkZ1m
   4ewDANYqkjDo+TmMFeL7fetAb4qFSW4EVF+hECGzuCMfGzr9cWzQ4s7C6
   TW/zF9ohnlmNIZKrog60qR8BUyAWTG1rP4DJ7wB1kJjmiK2NWTAW7iP45
   zYsJFIpwZ+K6CaDAXY4opXmD6eix8k+xuU1MFWFXHu4udB5P9RYVDLSxJ
   ZCb8GtsO29Hyb6x1xIpq+OXb9XQDS83xX+BwSrjvtj1AGkY1KvjpMTYGR
   xaebchmyKeTOvLRVlthz27SgXHJl66FyPeGH1tX+o5ZFbiMKJkgZlN+l2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="356504777"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="356504777"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 11:42:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="674405739"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="674405739"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga003.jf.intel.com with ESMTP; 19 Jul 2023 11:41:59 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 123D735816;
	Wed, 19 Jul 2023 19:41:58 +0100 (IST)
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
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v3 09/21] xdp: Add VLAN tag hint
Date: Wed, 19 Jul 2023 20:37:22 +0200
Message-ID: <20230719183734.21681-10-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719183734.21681-1-larysa.zaremba@intel.com>
References: <20230719183734.21681-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement functionality that enables drivers to expose VLAN tag
to XDP code.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 Documentation/networking/xdp-rx-metadata.rst |  8 ++++-
 include/linux/netdevice.h                    |  2 ++
 include/net/xdp.h                            |  2 ++
 kernel/bpf/offload.c                         |  2 ++
 net/core/xdp.c                               | 34 ++++++++++++++++++++
 5 files changed, 47 insertions(+), 1 deletion(-)

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
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b828c7a75be2..1749f4f75c64 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1658,6 +1658,8 @@ struct xdp_metadata_ops {
 	int	(*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timestamp);
 	int	(*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
 			       enum xdp_rss_hash_type *rss_type);
+	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, u16 *vlan_tci,
+				   __be16 *vlan_proto);
 };
 
 /**
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 6381560efae2..89c58f56ffc6 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -389,6 +389,8 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
 			   bpf_xdp_metadata_rx_timestamp) \
 	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_HASH, \
 			   bpf_xdp_metadata_rx_hash) \
+	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_VLAN_TAG, \
+			   bpf_xdp_metadata_rx_vlan_tag) \
 
 enum {
 #define XDP_METADATA_KFUNC(name, _) name,
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 8a26cd8814c1..986e7becfd42 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -848,6 +848,8 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
 		p = ops->xmo_rx_timestamp;
 	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_HASH))
 		p = ops->xmo_rx_hash;
+	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_VLAN_TAG))
+		p = ops->xmo_rx_vlan_tag;
 out:
 	up_read(&bpf_devs_lock);
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 8362130bf085..8b55419d332e 100644
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


