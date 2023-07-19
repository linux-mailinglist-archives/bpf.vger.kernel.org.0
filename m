Return-Path: <bpf+bounces-5366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C246A759DD1
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 20:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78623280EE1
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 18:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6680D2515A;
	Wed, 19 Jul 2023 18:42:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3850225142;
	Wed, 19 Jul 2023 18:42:12 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E06F0;
	Wed, 19 Jul 2023 11:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689792130; x=1721328130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/hy01mUDNGKPXqLie/et7WI4r9iBpmhGHohLP6yGG2o=;
  b=e1OBE0wMUFqjVrbeILEqONjj1KsCsB9h/gqp5f5qxoubL5X9+wIoIxiI
   yOH0vvprtHJ6khIiNN5AwM4hliKvajzfxlluyINkFCeQIga7Sr+do/ydC
   yvHwBqAnXSFQ8iRGPBhR1OX8jq/OXpsCAIA9Pn3+hP6/9DDLmFqRvd+4t
   /RZihZiWNm2vdfrVkYqYW1W1jJiJFGOElOcQsecj/eGJTLmBrQYr6x6rH
   C+KZzMZTyqPyLfx5RNbaFCOBkiXCXoCw899SNwz9j8Guex+XWxPWNwLzN
   x0bRyipsUT/h4bdJ2U45XyohnnnHRepnXhLv7Bcurs/0UUVyDNcJj8ayg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="356504805"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="356504805"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 11:42:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="674405771"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="674405771"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga003.jf.intel.com with ESMTP; 19 Jul 2023 11:42:05 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 4D04535816;
	Wed, 19 Jul 2023 19:42:04 +0100 (IST)
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
Subject: [PATCH bpf-next v3 12/21] xdp: Add checksum hint
Date: Wed, 19 Jul 2023 20:37:25 +0200
Message-ID: <20230719183734.21681-13-larysa.zaremba@intel.com>
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

Implement functionality that enables drivers to expose to XDP code checksum
information that consists of:

- Checksum status - bitfield that consists of
  - number of consecutive validated checksums. This is almost the same as
    csum_level in skb, but starts with 1. Enum names for those bits still
    use checksum level concept, so it is less confusing for driver
    developers.
  - Is checksum partial? This bit cannot coexist with any other
  - Is there a complete checksum available?
- Additional checksum data, a union of:
  - checksum start and offset, if checksum is partial
  - complete checksum, if available

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 Documentation/networking/xdp-rx-metadata.rst |  3 ++
 include/linux/netdevice.h                    |  3 ++
 include/net/xdp.h                            | 46 ++++++++++++++++++++
 kernel/bpf/offload.c                         |  2 +
 net/core/xdp.c                               | 23 ++++++++++
 5 files changed, 77 insertions(+)

diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
index ea6dd79a21d3..7f056a44f682 100644
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
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1749f4f75c64..4f6da36ac123 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1660,6 +1660,9 @@ struct xdp_metadata_ops {
 			       enum xdp_rss_hash_type *rss_type);
 	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, u16 *vlan_tci,
 				   __be16 *vlan_proto);
+	int	(*xmo_rx_csum)(const struct xdp_md *ctx,
+			       enum xdp_csum_status *csum_status,
+			       union xdp_csum_info *csum_info);
 };
 
 /**
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 89c58f56ffc6..2b7a7d678ff4 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -391,6 +391,8 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
 			   bpf_xdp_metadata_rx_hash) \
 	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_VLAN_TAG, \
 			   bpf_xdp_metadata_rx_vlan_tag) \
+	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CSUM, \
+			   bpf_xdp_metadata_rx_csum) \
 
 enum {
 #define XDP_METADATA_KFUNC(name, _) name,
@@ -448,6 +450,50 @@ enum xdp_rss_hash_type {
 	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
 };
 
+union xdp_csum_info {
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
+
+	/* Checksum, calculated over the whole packet.
+	 * Available, if ``status & XDP_CHECKSUM_COMPLETE``.
+	 */
+	u32 checksum;
+};
+
+enum xdp_csum_status {
+	/* HW had parsed several transport headers and validated their
+	 * checksums, same as ``CHECKSUM_UNNECESSARY`` in ``sk_buff``.
+	 * 3 least significat bytes contain number of consecutive checksum,
+	 * starting with the outermost, reported by hardware as valid.
+	 * ``sk_buff`` checksum level (``csum_level``) notation is provided
+	 * for driver developers.
+	 */
+	XDP_CHECKSUM_VALID_LVL0		= 1,	/* 1 outermost checksum */
+	XDP_CHECKSUM_VALID_LVL1		= 2,	/* 2 outermost checksums */
+	XDP_CHECKSUM_VALID_LVL2		= 3,	/* 3 outermost checksums */
+	XDP_CHECKSUM_VALID_LVL3		= 4,	/* 4 outermost checksums */
+	XDP_CHECKSUM_VALID_NUM_MASK	= GENMASK(2, 0),
+	XDP_CHECKSUM_VALID		= XDP_CHECKSUM_VALID_NUM_MASK,
+
+	/* Occurs if packet is sent virtually (between Linux VMs / containers)
+	 * This status cannot coexist with any other.
+	 * Refer to ``csum_start`` and ``csum_offset`` in ``xdp_csum_info``
+	 * for more information.
+	 */
+	XDP_CHECKSUM_PARTIAL	= BIT(3),
+
+	/* Checksum, calculated over the entire packet is provided */
+	XDP_CHECKSUM_COMPLETE	= BIT(4),
+};
+
 #ifdef CONFIG_NET
 u32 bpf_xdp_metadata_kfunc_id(int id);
 bool bpf_dev_bound_kfunc_id(u32 btf_id);
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 986e7becfd42..f60a6add5273 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -850,6 +850,8 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
 		p = ops->xmo_rx_hash;
 	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_VLAN_TAG))
 		p = ops->xmo_rx_vlan_tag;
+	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_CSUM))
+		p = ops->xmo_rx_csum;
 out:
 	up_read(&bpf_devs_lock);
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 8b55419d332e..d4ea54046afc 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -772,6 +772,29 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
 	return -EOPNOTSUPP;
 }
 
+/**
+ * bpf_xdp_metadata_rx_csum - Get checksum status with additional info.
+ * @ctx: XDP context pointer.
+ * @csum_status: Destination for checksum status.
+ * @csum_info: Destination for complete checksum or partial checksum offset.
+ *
+ * Status (@csum_status) is a bitfield that informs, what checksum
+ * processing was performed. Additional results of such processing,
+ * such as complete checksum or partial checksum offsets,
+ * are passed as info (@csum_info).
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-EOPNOTSUPP`` : device driver doesn't implement kfunc
+ * * ``-ENODATA``    : Checksum status is unknown
+ */
+__bpf_kfunc int bpf_xdp_metadata_rx_csum(const struct xdp_md *ctx,
+					 enum xdp_csum_status *csum_status,
+					 union xdp_csum_info *csum_info)
+{
+	return -EOPNOTSUPP;
+}
+
 __diag_pop();
 
 BTF_SET8_START(xdp_metadata_kfunc_ids)
-- 
2.41.0


