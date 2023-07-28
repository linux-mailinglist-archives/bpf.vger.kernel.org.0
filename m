Return-Path: <bpf+bounces-6239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8158E7673C9
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 19:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D291C21163
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 17:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4190C1F19D;
	Fri, 28 Jul 2023 17:44:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028D51ED5A;
	Fri, 28 Jul 2023 17:44:36 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E6010CB;
	Fri, 28 Jul 2023 10:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690566275; x=1722102275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MJ8xe6xTPNqPyGYF9RM7LDHIAEOqUx2yxjW6hFbDeVk=;
  b=m1JD+OylYKN9bj115qnRB9pZP9SfDnneeEti4F0ytJznHnizfeTxN8B4
   My8eY3P+DmVQSVrEvPzzUQ8ZEJnFGj6n9uZFA5eF1uEZBwfiigMiBNffC
   lfHjWGhm3gwLlx+fE3wxYDH2mkRyVXhx0q2tZdwA5qnAoqZhpvpW9aF6z
   hZ6epJgDTFGiOOLU6ooTUlEW/R0ii47tWM7NEZPBKbnbEMkCYLVsy8cGs
   afHuuVfQpzaUuLJ+s7AkluGU+6g8RRjXxg/pPvCYXmSTX9mjIFWI+SQcn
   dhTB5wLe6KakRPziEWAkXApStUY3HlPNkD9gOHXr18rKvJNakFWExItzm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="367530855"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="367530855"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 10:44:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="757254491"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="757254491"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga008.jf.intel.com with ESMTP; 28 Jul 2023 10:44:28 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id C38EF386B3;
	Fri, 28 Jul 2023 18:44:26 +0100 (IST)
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
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH bpf-next v4 12/21] xdp: Add checksum hint
Date: Fri, 28 Jul 2023 19:39:14 +0200
Message-ID: <20230728173923.1318596-13-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728173923.1318596-1-larysa.zaremba@intel.com>
References: <20230728173923.1318596-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 028dcc4fd02d..a950cec76945 100644
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
index 89c58f56ffc6..7e6163e5002a 100644
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
+	 * 3 least significant bytes contain number of consecutive checksums,
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


