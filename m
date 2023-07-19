Return-Path: <bpf+bounces-5295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6458E7596D7
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 15:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950B01C20E05
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 13:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B6123BC6;
	Wed, 19 Jul 2023 13:25:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72A914AAD;
	Wed, 19 Jul 2023 13:25:21 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4C71711;
	Wed, 19 Jul 2023 06:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689773119; x=1721309119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ynZasLn0qCuM1L0RnwhiOdUamKLLx9Bei1CLhw9Dd50=;
  b=OJG17zOxwiR2E4x+RFFvbkDatFIxJPztv1Yb7hgrZ2fnmHUrMAffnS3v
   5NXR/N8s5w+jtP2Gr+Lp48Dgmmuhq+i+bme/dznCYmE1yXgXu4hhZWFq9
   3yxmNs9T7AcHErCMpC/k8dxjRdbDG12ksJhBSsdd+ayMXNhQx60TnndfQ
   QRswW2u8xZP7v+JVL1S6mbcBeZGAByx7LI/7/FCqVchEBInlyIW4MMLg3
   FwiyPZqitI1dQkbaV8BBMV4PJHdcKMiW4Iyp8JbzrsZqsCYsoKmg4aVuN
   ZHB8tFUd+vdUZkOtIddDD68qi2HUrr5kHto56+LOh8Tm5VvvS89NteJXv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="363920609"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="363920609"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 06:25:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="717978102"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="717978102"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga007.jf.intel.com with ESMTP; 19 Jul 2023 06:25:01 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: netdev@vger.kernel.org,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	toke@kernel.org,
	kuba@kernel.org,
	horms@kernel.org,
	tirthendu.sarkar@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v7 bpf-next 10/24] xsk: add new netlink attribute dedicated for ZC max frags
Date: Wed, 19 Jul 2023 15:24:07 +0200
Message-Id: <20230719132421.584801-11-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230719132421.584801-1-maciej.fijalkowski@intel.com>
References: <20230719132421.584801-1-maciej.fijalkowski@intel.com>
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

Introduce new netlink attribute NETDEV_A_DEV_XDP_ZC_MAX_SEGS that will
carry maximum fragments that underlying ZC driver is able to handle on
TX side. It is going to be included in netlink response only when driver
supports ZC. Any value higher than 1 implies multi-buffer ZC support on
underlying device.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 Documentation/netlink/specs/netdev.yaml | 6 ++++++
 include/linux/netdevice.h               | 1 +
 include/uapi/linux/netdev.h             | 1 +
 net/core/dev.c                          | 1 +
 net/core/netdev-genl.c                  | 8 ++++++++
 tools/include/uapi/linux/netdev.h       | 1 +
 tools/lib/bpf/libbpf.h                  | 3 ++-
 tools/lib/bpf/netlink.c                 | 5 +++++
 8 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index b99e7ffef7a1..e41015310a6e 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -62,6 +62,12 @@ attribute-sets:
         type: u64
         enum: xdp-act
         enum-as-flags: true
+      -
+        name: xdp_zc_max_segs
+        doc: max fragment count supported by ZC driver
+        type: u32
+        checks:
+          min: 1
 
 operations:
   list:
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b828c7a75be2..b12477ea4032 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2250,6 +2250,7 @@ struct net_device {
 #define GRO_MAX_SIZE		(8 * 65535u)
 	unsigned int		gro_max_size;
 	unsigned int		gro_ipv4_max_size;
+	unsigned int		xdp_zc_max_segs;
 	rx_handler_func_t __rcu	*rx_handler;
 	void __rcu		*rx_handler_data;
 
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 639524b59930..bf71698a1e82 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -41,6 +41,7 @@ enum {
 	NETDEV_A_DEV_IFINDEX = 1,
 	NETDEV_A_DEV_PAD,
 	NETDEV_A_DEV_XDP_FEATURES,
+	NETDEV_A_DEV_XDP_ZC_MAX_SEGS,
 
 	__NETDEV_A_DEV_MAX,
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
diff --git a/net/core/dev.c b/net/core/dev.c
index d6e1b786c5c5..dd4f114a7cbf 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10613,6 +10613,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	dev_net_set(dev, &init_net);
 
 	dev->gso_max_size = GSO_LEGACY_MAX_SIZE;
+	dev->xdp_zc_max_segs = 1;
 	dev->gso_max_segs = GSO_MAX_SEGS;
 	dev->gro_max_size = GRO_LEGACY_MAX_SIZE;
 	dev->gso_ipv4_max_size = GSO_LEGACY_MAX_SIZE;
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index a4270fafdf11..65ef4867fc49 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -25,6 +25,14 @@ netdev_nl_dev_fill(struct net_device *netdev, struct sk_buff *rsp,
 		return -EINVAL;
 	}
 
+	if (netdev->xdp_features & NETDEV_XDP_ACT_XSK_ZEROCOPY) {
+		if (nla_put_u32(rsp, NETDEV_A_DEV_XDP_ZC_MAX_SEGS,
+				netdev->xdp_zc_max_segs)) {
+			genlmsg_cancel(rsp, hdr);
+			return -EINVAL;
+		}
+	}
+
 	genlmsg_end(rsp, hdr);
 
 	return 0;
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 639524b59930..bf71698a1e82 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -41,6 +41,7 @@ enum {
 	NETDEV_A_DEV_IFINDEX = 1,
 	NETDEV_A_DEV_PAD,
 	NETDEV_A_DEV_XDP_FEATURES,
+	NETDEV_A_DEV_XDP_ZC_MAX_SEGS,
 
 	__NETDEV_A_DEV_MAX,
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 10642ad69d76..674e5788eb10 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1105,9 +1105,10 @@ struct bpf_xdp_query_opts {
 	__u32 skb_prog_id;	/* output */
 	__u8 attach_mode;	/* output */
 	__u64 feature_flags;	/* output */
+	__u32 xdp_zc_max_segs;	/* output */
 	size_t :0;
 };
-#define bpf_xdp_query_opts__last_field feature_flags
+#define bpf_xdp_query_opts__last_field xdp_zc_max_segs
 
 LIBBPF_API int bpf_xdp_attach(int ifindex, int prog_fd, __u32 flags,
 			      const struct bpf_xdp_attach_opts *opts);
diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
index 84dd5fa14905..090bcf6e3b3d 100644
--- a/tools/lib/bpf/netlink.c
+++ b/tools/lib/bpf/netlink.c
@@ -45,6 +45,7 @@ struct xdp_id_md {
 
 struct xdp_features_md {
 	int ifindex;
+	__u32 xdp_zc_max_segs;
 	__u64 flags;
 };
 
@@ -421,6 +422,9 @@ static int parse_xdp_features(struct nlmsghdr *nh, libbpf_dump_nlmsg_t fn,
 		return NL_CONT;
 
 	md->flags = libbpf_nla_getattr_u64(tb[NETDEV_A_DEV_XDP_FEATURES]);
+	if (tb[NETDEV_A_DEV_XDP_ZC_MAX_SEGS])
+		md->xdp_zc_max_segs =
+			libbpf_nla_getattr_u32(tb[NETDEV_A_DEV_XDP_ZC_MAX_SEGS]);
 	return NL_DONE;
 }
 
@@ -493,6 +497,7 @@ int bpf_xdp_query(int ifindex, int xdp_flags, struct bpf_xdp_query_opts *opts)
 		return libbpf_err(err);
 
 	opts->feature_flags = md.flags;
+	opts->xdp_zc_max_segs = md.xdp_zc_max_segs;
 
 skip_feature_flags:
 	return 0;
-- 
2.34.1


