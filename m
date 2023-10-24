Return-Path: <bpf+bounces-13166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FD27D5D74
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 23:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2A7281B38
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 21:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4664292E;
	Tue, 24 Oct 2023 21:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="I6JlckQb"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736D73D399;
	Tue, 24 Oct 2023 21:49:21 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C002E8;
	Tue, 24 Oct 2023 14:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=MQA9i1cYkB4siX0B1yRIHyP9wEi/b42iovcQ976zAgk=; b=I6JlckQb3m97P2pxp2H5HDEvSD
	0Ikjwbl33F2o+mYYeu34twytTS6P7s3d3TYrSbbG3Y7zJ3qVAeTY8kbUdmQiVd5LHd+6opHixc4xy
	9iwOM6I/pxVKUra1ISed5vwyC7JQfRBT9uvEhKQB99S0oNGQt7M3ZfB7uQNiKTiETyBm0lpW8MfuD
	gayJUoHu6j9luu61edj4mUZ7cWV9TPuCDRjey1BI+xVhRGiPwI8wM5oeqAYGTZVO+E9dSRtWBl2dc
	7MfL7ZSsK38oYqZ8rf/21Ma52Nh0PTL2yDqkmuWkMFUb43eG5QuvCTYmZpgPtYVfn+MGxpyq7vJPp
	Cq7QQvJQ==;
Received: from 40.248.197.178.dynamic.dsl-lte-bonding.zhbmb00p-msn.res.cust.swisscom.ch ([178.197.248.40] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvPGy-0001kn-GP; Tue, 24 Oct 2023 23:49:12 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	martin.lau@linux.dev,
	razor@blackwall.org,
	ast@kernel.org,
	andrii@kernel.org,
	john.fastabend@gmail.com,
	sdf@google.com,
	toke@kernel.org,
	kuba@kernel.org,
	andrew@lunn.ch,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v4 2/7] tools: Sync if_link uapi header
Date: Tue, 24 Oct 2023 23:48:59 +0200
Message-Id: <20231024214904.29825-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231024214904.29825-1-daniel@iogearbox.net>
References: <20231024214904.29825-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27071/Tue Oct 24 09:43:50 2023)
X-Spam-Level: *

Sync if_link uapi header to the latest version as we need the refresher
in tooling for netkit device. Given it's been a while since the last sync
and the diff is fairly big, it has been done as its own commit.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/include/uapi/linux/if_link.h | 141 +++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index 39e659c83cfd..a0aa05a28cf2 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -211,6 +211,9 @@ struct rtnl_link_stats {
  * @rx_nohandler: Number of packets received on the interface
  *   but dropped by the networking stack because the device is
  *   not designated to receive packets (e.g. backup link in a bond).
+ *
+ * @rx_otherhost_dropped: Number of packets dropped due to mismatch
+ *   in destination MAC address.
  */
 struct rtnl_link_stats64 {
 	__u64	rx_packets;
@@ -243,6 +246,23 @@ struct rtnl_link_stats64 {
 	__u64	rx_compressed;
 	__u64	tx_compressed;
 	__u64	rx_nohandler;
+
+	__u64	rx_otherhost_dropped;
+};
+
+/* Subset of link stats useful for in-HW collection. Meaning of the fields is as
+ * for struct rtnl_link_stats64.
+ */
+struct rtnl_hw_stats64 {
+	__u64	rx_packets;
+	__u64	tx_packets;
+	__u64	rx_bytes;
+	__u64	tx_bytes;
+	__u64	rx_errors;
+	__u64	tx_errors;
+	__u64	rx_dropped;
+	__u64	tx_dropped;
+	__u64	multicast;
 };
 
 /* The struct should be in sync with struct ifmap */
@@ -350,7 +370,13 @@ enum {
 	IFLA_GRO_MAX_SIZE,
 	IFLA_TSO_MAX_SIZE,
 	IFLA_TSO_MAX_SEGS,
+	IFLA_ALLMULTI,		/* Allmulti count: > 0 means acts ALLMULTI */
+
+	IFLA_DEVLINK_PORT,
 
+	IFLA_GSO_IPV4_MAX_SIZE,
+	IFLA_GRO_IPV4_MAX_SIZE,
+	IFLA_DPLL_PIN,
 	__IFLA_MAX
 };
 
@@ -539,6 +565,12 @@ enum {
 	IFLA_BRPORT_MRP_IN_OPEN,
 	IFLA_BRPORT_MCAST_EHT_HOSTS_LIMIT,
 	IFLA_BRPORT_MCAST_EHT_HOSTS_CNT,
+	IFLA_BRPORT_LOCKED,
+	IFLA_BRPORT_MAB,
+	IFLA_BRPORT_MCAST_N_GROUPS,
+	IFLA_BRPORT_MCAST_MAX_GROUPS,
+	IFLA_BRPORT_NEIGH_VLAN_SUPPRESS,
+	IFLA_BRPORT_BACKUP_NHID,
 	__IFLA_BRPORT_MAX
 };
 #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
@@ -716,7 +748,79 @@ enum ipvlan_mode {
 #define IPVLAN_F_PRIVATE	0x01
 #define IPVLAN_F_VEPA		0x02
 
+/* Tunnel RTM header */
+struct tunnel_msg {
+	__u8 family;
+	__u8 flags;
+	__u16 reserved2;
+	__u32 ifindex;
+};
+
+/* netkit section */
+enum netkit_action {
+	NETKIT_NEXT	= -1,
+	NETKIT_PASS	= 0,
+	NETKIT_DROP	= 2,
+	NETKIT_REDIRECT	= 7,
+};
+
+enum netkit_mode {
+	NETKIT_L2,
+	NETKIT_L3,
+};
+
+enum {
+	IFLA_NETKIT_UNSPEC,
+	IFLA_NETKIT_PEER_INFO,
+	IFLA_NETKIT_PRIMARY,
+	IFLA_NETKIT_POLICY,
+	IFLA_NETKIT_PEER_POLICY,
+	IFLA_NETKIT_MODE,
+	__IFLA_NETKIT_MAX,
+};
+#define IFLA_NETKIT_MAX	(__IFLA_NETKIT_MAX - 1)
+
 /* VXLAN section */
+
+/* include statistics in the dump */
+#define TUNNEL_MSG_FLAG_STATS	0x01
+
+#define TUNNEL_MSG_VALID_USER_FLAGS TUNNEL_MSG_FLAG_STATS
+
+/* Embedded inside VXLAN_VNIFILTER_ENTRY_STATS */
+enum {
+	VNIFILTER_ENTRY_STATS_UNSPEC,
+	VNIFILTER_ENTRY_STATS_RX_BYTES,
+	VNIFILTER_ENTRY_STATS_RX_PKTS,
+	VNIFILTER_ENTRY_STATS_RX_DROPS,
+	VNIFILTER_ENTRY_STATS_RX_ERRORS,
+	VNIFILTER_ENTRY_STATS_TX_BYTES,
+	VNIFILTER_ENTRY_STATS_TX_PKTS,
+	VNIFILTER_ENTRY_STATS_TX_DROPS,
+	VNIFILTER_ENTRY_STATS_TX_ERRORS,
+	VNIFILTER_ENTRY_STATS_PAD,
+	__VNIFILTER_ENTRY_STATS_MAX
+};
+#define VNIFILTER_ENTRY_STATS_MAX (__VNIFILTER_ENTRY_STATS_MAX - 1)
+
+enum {
+	VXLAN_VNIFILTER_ENTRY_UNSPEC,
+	VXLAN_VNIFILTER_ENTRY_START,
+	VXLAN_VNIFILTER_ENTRY_END,
+	VXLAN_VNIFILTER_ENTRY_GROUP,
+	VXLAN_VNIFILTER_ENTRY_GROUP6,
+	VXLAN_VNIFILTER_ENTRY_STATS,
+	__VXLAN_VNIFILTER_ENTRY_MAX
+};
+#define VXLAN_VNIFILTER_ENTRY_MAX	(__VXLAN_VNIFILTER_ENTRY_MAX - 1)
+
+enum {
+	VXLAN_VNIFILTER_UNSPEC,
+	VXLAN_VNIFILTER_ENTRY,
+	__VXLAN_VNIFILTER_MAX
+};
+#define VXLAN_VNIFILTER_MAX	(__VXLAN_VNIFILTER_MAX - 1)
+
 enum {
 	IFLA_VXLAN_UNSPEC,
 	IFLA_VXLAN_ID,
@@ -748,6 +852,8 @@ enum {
 	IFLA_VXLAN_GPE,
 	IFLA_VXLAN_TTL_INHERIT,
 	IFLA_VXLAN_DF,
+	IFLA_VXLAN_VNIFILTER, /* only applicable with COLLECT_METADATA mode */
+	IFLA_VXLAN_LOCALBYPASS,
 	__IFLA_VXLAN_MAX
 };
 #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
@@ -781,6 +887,7 @@ enum {
 	IFLA_GENEVE_LABEL,
 	IFLA_GENEVE_TTL_INHERIT,
 	IFLA_GENEVE_DF,
+	IFLA_GENEVE_INNER_PROTO_INHERIT,
 	__IFLA_GENEVE_MAX
 };
 #define IFLA_GENEVE_MAX	(__IFLA_GENEVE_MAX - 1)
@@ -826,6 +933,8 @@ enum {
 	IFLA_GTP_FD1,
 	IFLA_GTP_PDP_HASHSIZE,
 	IFLA_GTP_ROLE,
+	IFLA_GTP_CREATE_SOCKETS,
+	IFLA_GTP_RESTART_COUNT,
 	__IFLA_GTP_MAX,
 };
 #define IFLA_GTP_MAX (__IFLA_GTP_MAX - 1)
@@ -1162,6 +1271,17 @@ enum {
 
 #define IFLA_STATS_FILTER_BIT(ATTR)	(1 << (ATTR - 1))
 
+enum {
+	IFLA_STATS_GETSET_UNSPEC,
+	IFLA_STATS_GET_FILTERS, /* Nest of IFLA_STATS_LINK_xxx, each a u32 with
+				 * a filter mask for the corresponding group.
+				 */
+	IFLA_STATS_SET_OFFLOAD_XSTATS_L3_STATS, /* 0 or 1 as u8 */
+	__IFLA_STATS_GETSET_MAX,
+};
+
+#define IFLA_STATS_GETSET_MAX (__IFLA_STATS_GETSET_MAX - 1)
+
 /* These are embedded into IFLA_STATS_LINK_XSTATS:
  * [IFLA_STATS_LINK_XSTATS]
  * -> [LINK_XSTATS_TYPE_xxx]
@@ -1179,10 +1299,21 @@ enum {
 enum {
 	IFLA_OFFLOAD_XSTATS_UNSPEC,
 	IFLA_OFFLOAD_XSTATS_CPU_HIT, /* struct rtnl_link_stats64 */
+	IFLA_OFFLOAD_XSTATS_HW_S_INFO,	/* HW stats info. A nest */
+	IFLA_OFFLOAD_XSTATS_L3_STATS,	/* struct rtnl_hw_stats64 */
 	__IFLA_OFFLOAD_XSTATS_MAX
 };
 #define IFLA_OFFLOAD_XSTATS_MAX (__IFLA_OFFLOAD_XSTATS_MAX - 1)
 
+enum {
+	IFLA_OFFLOAD_XSTATS_HW_S_INFO_UNSPEC,
+	IFLA_OFFLOAD_XSTATS_HW_S_INFO_REQUEST,		/* u8 */
+	IFLA_OFFLOAD_XSTATS_HW_S_INFO_USED,		/* u8 */
+	__IFLA_OFFLOAD_XSTATS_HW_S_INFO_MAX,
+};
+#define IFLA_OFFLOAD_XSTATS_HW_S_INFO_MAX \
+	(__IFLA_OFFLOAD_XSTATS_HW_S_INFO_MAX - 1)
+
 /* XDP section */
 
 #define XDP_FLAGS_UPDATE_IF_NOEXIST	(1U << 0)
@@ -1281,4 +1412,14 @@ enum {
 
 #define IFLA_MCTP_MAX (__IFLA_MCTP_MAX - 1)
 
+/* DSA section */
+
+enum {
+	IFLA_DSA_UNSPEC,
+	IFLA_DSA_MASTER,
+	__IFLA_DSA_MAX,
+};
+
+#define IFLA_DSA_MAX	(__IFLA_DSA_MAX - 1)
+
 #endif /* _UAPI_LINUX_IF_LINK_H */
-- 
2.34.1


