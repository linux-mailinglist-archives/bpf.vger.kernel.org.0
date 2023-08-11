Return-Path: <bpf+bounces-7575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B515779458
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 18:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67A91C2169A
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 16:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E6134CF5;
	Fri, 11 Aug 2023 16:20:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFF134CED;
	Fri, 11 Aug 2023 16:20:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EC592;
	Fri, 11 Aug 2023 09:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691770840; x=1723306840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ne/1/PTsQPHRdIJLnqaFI8aCCDNKyBxVh54JWoxv9yU=;
  b=gKhJByxe6S6pzE77pgd9l/sBP+uUYbaDskT5gxzmiWFKFeKx7QtlSl+u
   +GRgdWHoHAnHPMAsAqT/adZpwgYeBUj+OnBOkbCW9zbvJpdikqB2DAp5n
   D0xE5BvXbgJRCvNPWF8vBtqByC45Rjk99WfWVeALr4DPzPu5gMiJ3qrN0
   NzgpuOMeKnbSToXq7qZCkZspiqXyON7E+JfSaIf/hENpeGpdc2yoeocNf
   9eFVVGxbT5ISoD0ndztG8S3IXRibIa2cf+wjy3qyDEyw8wKdFmaGmtpN4
   bLX8hIiJ43iM5RM7FEiNE4/SsniTsSGhAdUlwQRMO1YZGFfcyonhDBYlB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="351314719"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="351314719"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 09:20:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="906501022"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="906501022"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga005.jf.intel.com with ESMTP; 11 Aug 2023 09:20:32 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 80AE7333E2;
	Fri, 11 Aug 2023 17:20:30 +0100 (IST)
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
Subject: [PATCH bpf-next v5 12/21] xdp: Add checksum hint
Date: Fri, 11 Aug 2023 18:15:00 +0200
Message-ID: <20230811161509.19722-13-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811161509.19722-1-larysa.zaremba@intel.com>
References: <20230811161509.19722-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 Documentation/networking/xdp-rx-metadata.rst |  3 +++
 include/net/xdp.h                            | 15 +++++++++++++
 kernel/bpf/offload.c                         |  2 ++
 net/core/xdp.c                               | 23 ++++++++++++++++++++
 4 files changed, 43 insertions(+)

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
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 8bb64fc76498..495c4d2a2c50 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -390,6 +390,8 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
 			   bpf_xdp_metadata_rx_hash) \
 	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_VLAN_TAG, \
 			   bpf_xdp_metadata_rx_vlan_tag) \
+	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CSUM, \
+			   bpf_xdp_metadata_rx_csum) \
 
 enum {
 #define XDP_METADATA_KFUNC(name, _) name,
@@ -447,12 +449,25 @@ enum xdp_rss_hash_type {
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
 	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, u16 *vlan_tci,
 				   __be16 *vlan_proto);
+	int	(*xmo_rx_csum)(const struct xdp_md *ctx,
+			       enum xdp_csum_status *csum_status,
+			       __wsum *csum);
 };
 
 #ifdef CONFIG_NET
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 8be340cf06f9..ee35f33a96d1 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -851,6 +851,8 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
 		p = ops->xmo_rx_hash;
 	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_VLAN_TAG))
 		p = ops->xmo_rx_vlan_tag;
+	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_CSUM))
+		p = ops->xmo_rx_csum;
 out:
 	up_read(&bpf_devs_lock);
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 856e02bb4ce6..b197287d7196 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -772,6 +772,29 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
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
-- 
2.41.0


