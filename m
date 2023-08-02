Return-Path: <bpf+bounces-6645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7BD76C18A
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 02:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468822813ED
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 00:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0C21396;
	Wed,  2 Aug 2023 00:33:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA117E;
	Wed,  2 Aug 2023 00:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AA1C433B6;
	Wed,  2 Aug 2023 00:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690936384;
	bh=Wlch2sI+yqlch/sZ5epjwgMCgxxtXXoxKq6bHwxtmKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GtXb6J6anqT7O/CNatKlhwVefKlphKE4o1EV+4Iv19ajhwAjryuBEg2EXdB5IXKjY
	 Jv3rv+8waoj2AYlrtq/kUADKtBrc6cX7EChpMsPVW7AN5yZjDZaogGMtH4H9l1mGQJ
	 2OdV8jSZy7i8bn9QC6GURnfzsRODt6ZJoBMXvzEEl4ZYXC0XFT/jdrsGuftqSDFC5n
	 82QtnIQSUEL/DQWek8bc7jT4gDATChnCN1wHASAB4QZsGTh+qA1oKZ1zclR63arWxG
	 wDR1o/EMcoR8HW8U7CKKvjUcEuC9EzY2Kr86pJPKeN4nLuR0AH2FWe2bRlbU0LJ+HA
	 5jBOo6q9ZAJ+A==
From: Jakub Kicinski <kuba@kernel.org>
To: ast@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	hawk@kernel.org,
	amritha.nambiar@intel.com,
	aleksander.lobakin@intel.com,
	Jakub Kicinski <kuba@kernel.org>,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Subject: [PATCH bpf-next 3/3] net: invert the netdevice.h vs xdp.h dependency
Date: Tue,  1 Aug 2023 17:32:46 -0700
Message-ID: <20230802003246.2153774-4-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802003246.2153774-1-kuba@kernel.org>
References: <20230802003246.2153774-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xdp.h is far more specific and is included in only 67 other
files vs netdevice.h's 1538 include sites.
Make xdp.h include netdevice.h, instead of the other way around.
This decreases the incremental allmodconfig builds size when
xdp.h is touched from 5947 to 662 objects.

Move bpf_prog_run_xdp() to xdp.h, seems appropriate and filter.h
is a mega-header in its own right so it's nice to avoid xdp.h
getting included there as well.

The only unfortunate part is that the typedef for xdp_features_t
has to move to netdevice.h, since its embedded in struct netdevice.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: ast@kernel.org
CC: daniel@iogearbox.net
CC: john.fastabend@gmail.com
CC: andrii@kernel.org
CC: martin.lau@linux.dev
CC: song@kernel.org
CC: yonghong.song@linux.dev
CC: kpsingh@kernel.org
CC: sdf@google.com
CC: haoluo@google.com
CC: jolsa@kernel.org
CC: hawk@kernel.org
CC: bpf@vger.kernel.org
---
 include/linux/filter.h     | 17 -----------------
 include/linux/netdevice.h  | 11 ++++-------
 include/net/busy_poll.h    |  1 +
 include/net/xdp.h          | 27 ++++++++++++++++++++++++---
 include/trace/events/xdp.h |  1 +
 kernel/bpf/btf.c           |  1 +
 kernel/bpf/offload.c       |  1 +
 kernel/bpf/verifier.c      |  1 +
 8 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index f5eabe3fa5e8..2d6fe30bad5f 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -774,23 +774,6 @@ DECLARE_STATIC_KEY_FALSE(bpf_master_redirect_enabled_key);
 
 u32 xdp_master_redirect(struct xdp_buff *xdp);
 
-static __always_inline u32 bpf_prog_run_xdp(const struct bpf_prog *prog,
-					    struct xdp_buff *xdp)
-{
-	/* Driver XDP hooks are invoked within a single NAPI poll cycle and thus
-	 * under local_bh_disable(), which provides the needed RCU protection
-	 * for accessing map entries.
-	 */
-	u32 act = __bpf_prog_run(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
-
-	if (static_branch_unlikely(&bpf_master_redirect_enabled_key)) {
-		if (act == XDP_TX && netif_is_bond_slave(xdp->rxq->dev))
-			act = xdp_master_redirect(xdp);
-	}
-
-	return act;
-}
-
 void bpf_prog_change_xdp(struct bpf_prog *prev_prog, struct bpf_prog *prog);
 
 static inline u32 bpf_prog_insn_size(const struct bpf_prog *prog)
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5563c8a210b5..d8ed85183fe4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -40,7 +40,6 @@
 #include <net/dcbnl.h>
 #endif
 #include <net/netprio_cgroup.h>
-#include <net/xdp.h>
 
 #include <linux/netdev_features.h>
 #include <linux/neighbour.h>
@@ -76,8 +75,12 @@ struct udp_tunnel_nic_info;
 struct udp_tunnel_nic;
 struct bpf_prog;
 struct xdp_buff;
+struct xdp_frame;
+struct xdp_metadata_ops;
 struct xdp_md;
 
+typedef u32 xdp_features_t;
+
 void synchronize_net(void);
 void netdev_set_default_ethtool_ops(struct net_device *dev,
 				    const struct ethtool_ops *ops);
@@ -1628,12 +1631,6 @@ struct net_device_ops {
 						  bool cycles);
 };
 
-struct xdp_metadata_ops {
-	int	(*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timestamp);
-	int	(*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
-			       enum xdp_rss_hash_type *rss_type);
-};
-
 /**
  * enum netdev_priv_flags - &struct net_device priv_flags
  *
diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
index f90f0021f5f2..4dabeb6c76d3 100644
--- a/include/net/busy_poll.h
+++ b/include/net/busy_poll.h
@@ -16,6 +16,7 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/signal.h>
 #include <net/ip.h>
+#include <net/xdp.h>
 
 /*		0 - Reserved to indicate value not set
  *     1..NR_CPUS - Reserved for sender_cpu
diff --git a/include/net/xdp.h b/include/net/xdp.h
index d1c5381fc95f..4bd28c8679b8 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -6,8 +6,9 @@
 #ifndef __LINUX_NET_XDP_H__
 #define __LINUX_NET_XDP_H__
 
+#include <linux/filter.h>
 #include <linux/skbuff.h> /* skb_shared_info */
-#include <uapi/linux/netdev.h>
+#include <linux/netdevice.h>
 #include <linux/bitfield.h>
 
 /**
@@ -45,8 +46,6 @@ enum xdp_mem_type {
 	MEM_TYPE_MAX,
 };
 
-typedef u32 xdp_features_t;
-
 /* XDP flags for ndo_xdp_xmit */
 #define XDP_XMIT_FLUSH		(1U << 0)	/* doorbell signal consumer */
 #define XDP_XMIT_FLAGS_MASK	XDP_XMIT_FLUSH
@@ -443,6 +442,12 @@ enum xdp_rss_hash_type {
 	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
 };
 
+struct xdp_metadata_ops {
+	int	(*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timestamp);
+	int	(*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
+			       enum xdp_rss_hash_type *rss_type);
+};
+
 #ifdef CONFIG_NET
 u32 bpf_xdp_metadata_kfunc_id(int id);
 bool bpf_dev_bound_kfunc_id(u32 btf_id);
@@ -474,4 +479,20 @@ static inline void xdp_clear_features_flag(struct net_device *dev)
 	xdp_set_features_flag(dev, 0);
 }
 
+static __always_inline u32 bpf_prog_run_xdp(const struct bpf_prog *prog,
+					    struct xdp_buff *xdp)
+{
+	/* Driver XDP hooks are invoked within a single NAPI poll cycle and thus
+	 * under local_bh_disable(), which provides the needed RCU protection
+	 * for accessing map entries.
+	 */
+	u32 act = __bpf_prog_run(prog, xdp, BPF_DISPATCHER_FUNC(xdp));
+
+	if (static_branch_unlikely(&bpf_master_redirect_enabled_key)) {
+		if (act == XDP_TX && netif_is_bond_slave(xdp->rxq->dev))
+			act = xdp_master_redirect(xdp);
+	}
+
+	return act;
+}
 #endif /* __LINUX_NET_XDP_H__ */
diff --git a/include/trace/events/xdp.h b/include/trace/events/xdp.h
index c40fc97f9417..87d833591671 100644
--- a/include/trace/events/xdp.h
+++ b/include/trace/events/xdp.h
@@ -9,6 +9,7 @@
 #include <linux/filter.h>
 #include <linux/tracepoint.h>
 #include <linux/bpf.h>
+#include <net/xdp.h>
 
 #define __XDP_ACT_MAP(FN)	\
 	FN(ABORTED)		\
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ef9581a580e2..249657c466dd 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -29,6 +29,7 @@
 #include <net/netfilter/nf_bpf_link.h>
 
 #include <net/sock.h>
+#include <net/xdp.h>
 #include "../tools/lib/bpf/relo_core.h"
 
 /* BTF (BPF Type Format) is the meta data format which describes
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 8a26cd8814c1..3e4f2ec1af06 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -25,6 +25,7 @@
 #include <linux/rhashtable.h>
 #include <linux/rtnetlink.h>
 #include <linux/rwsem.h>
+#include <net/xdp.h>
 
 /* Protects offdevs, members of bpf_offload_netdev and offload members
  * of all progs.
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e7b1af016841..132f25dab931 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -26,6 +26,7 @@
 #include <linux/poison.h>
 #include <linux/module.h>
 #include <linux/cpumask.h>
+#include <net/xdp.h>
 
 #include "disasm.h"
 
-- 
2.41.0


