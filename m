Return-Path: <bpf+bounces-3899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC36746211
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 20:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0C2280E50
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 18:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F88134CC;
	Mon,  3 Jul 2023 18:17:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D99134B2;
	Mon,  3 Jul 2023 18:17:28 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA97010C1;
	Mon,  3 Jul 2023 11:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688408230; x=1719944230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ktMi6lJAwBBbJnnBXbkagW0jsZL48sRSbaC3HQUwtCE=;
  b=jqRnATbgPz4tiZ6AG8daDL3W2ZcWqlZMs/KckNsq8aE/Ak6fI9y90T/4
   JCyDdz5Y9t92PnaB6U4EFCI60aXl6ZqT94rXxYz84IEZuLNqK933hg1Nu
   VamLMiau9sSYxzCuajbUtV9/pO4RDnzGolHXwJk77+rl8fP4jDBieJvNz
   odiGqbLP5eDFp+pCX9i5zdj828k/stD3j0TcVrF6JR0jkM7n/pzi37ujY
   5qy6OmtuB7+YboVJUp5Po/7r08jmoxs35dtENZ82UtOsGK2qyw3C81kvi
   QkXrt+HD6hsDWkkBAvrwPXjL/ITR+pJKET+5xx5Beu+FGivWE9BUqjFDD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="393682673"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="393682673"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 11:17:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="892615142"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="892615142"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga005.jf.intel.com with ESMTP; 03 Jul 2023 11:17:04 -0700
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 06A6A35833;
	Mon,  3 Jul 2023 19:17:02 +0100 (IST)
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
Subject: [PATCH bpf-next v2 12/20] xdp: Add checksum level hint
Date: Mon,  3 Jul 2023 20:12:18 +0200
Message-ID: <20230703181226.19380-13-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703181226.19380-1-larysa.zaremba@intel.com>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
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
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement functionality that enables drivers to expose to XDP code,
whether checksums was checked and on what level.

Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 Documentation/networking/xdp-rx-metadata.rst |  3 +++
 include/linux/netdevice.h                    |  1 +
 include/net/xdp.h                            |  2 ++
 kernel/bpf/offload.c                         |  2 ++
 net/core/xdp.c                               | 21 ++++++++++++++++++++
 5 files changed, 29 insertions(+)

diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
index ea6dd79a21d3..4ec6ddfd2a52 100644
--- a/Documentation/networking/xdp-rx-metadata.rst
+++ b/Documentation/networking/xdp-rx-metadata.rst
@@ -26,6 +26,9 @@ metadata is supported, this set will grow:
 .. kernel-doc:: net/core/xdp.c
    :identifiers: bpf_xdp_metadata_rx_vlan_tag
 
+.. kernel-doc:: net/core/xdp.c
+   :identifiers: bpf_xdp_metadata_rx_csum_lvl
+
 An XDP program can use these kfuncs to read the metadata into stack
 variables for its own consumption. Or, to pass the metadata on to other
 consumers, an XDP program can store it into the metadata area carried
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 4fa4380e6d89..569563687172 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1660,6 +1660,7 @@ struct xdp_metadata_ops {
 			       enum xdp_rss_hash_type *rss_type);
 	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, u16 *vlan_tag,
 				   __be16 *vlan_proto);
+	int	(*xmo_rx_csum_lvl)(const struct xdp_md *ctx, u8 *csum_level);
 };
 
 /**
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 89c58f56ffc6..61ed38fa79d1 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -391,6 +391,8 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
 			   bpf_xdp_metadata_rx_hash) \
 	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_VLAN_TAG, \
 			   bpf_xdp_metadata_rx_vlan_tag) \
+	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CSUM_LVL, \
+			   bpf_xdp_metadata_rx_csum_lvl) \
 
 enum {
 #define XDP_METADATA_KFUNC(name, _) name,
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 986e7becfd42..a133fb775f49 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -850,6 +850,8 @@ void *bpf_dev_bound_resolve_kfunc(struct bpf_prog *prog, u32 func_id)
 		p = ops->xmo_rx_hash;
 	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_VLAN_TAG))
 		p = ops->xmo_rx_vlan_tag;
+	else if (func_id == bpf_xdp_metadata_kfunc_id(XDP_METADATA_KFUNC_RX_CSUM_LVL))
+		p = ops->xmo_rx_csum_lvl;
 out:
 	up_read(&bpf_devs_lock);
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index f6262c90e45f..c666d3e0a26c 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -758,6 +758,27 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx, u16 *vlan
 	return -EOPNOTSUPP;
 }
 
+/**
+ * bpf_xdp_metadata_rx_csum_lvl - Get depth at which HW has checked the checksum.
+ * @ctx: XDP context pointer.
+ * @csum_level: Return value pointer.
+ *
+ * In case of success, csum_level contains depth of the last verified checksum.
+ * If only the outermost checksum was verified, csum_level is 0, if both
+ * encapsulation and inner transport checksums were verified, csum_level is 1,
+ * and so on.
+ * For more details, refer to csum_level field in sk_buff.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-EOPNOTSUPP`` : device driver doesn't implement kfunc
+ * * ``-ENODATA``    : Checksum was not validated
+ */
+__bpf_kfunc int bpf_xdp_metadata_rx_csum_lvl(const struct xdp_md *ctx, u8 *csum_level)
+{
+	return -EOPNOTSUPP;
+}
+
 __diag_pop();
 
 BTF_SET8_START(xdp_metadata_kfunc_ids)
-- 
2.41.0


