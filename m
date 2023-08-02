Return-Path: <bpf+bounces-6644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919DA76C188
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 02:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5318281CAA
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 00:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B366710F1;
	Wed,  2 Aug 2023 00:33:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4527E;
	Wed,  2 Aug 2023 00:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96B8C433CC;
	Wed,  2 Aug 2023 00:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690936383;
	bh=l86gxSWc1Jd3rASRkcoIDFwYTDgTfik1ANL2zHDwlL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MSwPg8SXcMgJi1H1+B6j50OXaqZgfKu4HJVRkEku+eI2fjAEzQ1AQvMBBUPm3Nt/S
	 1qw4UKFct6dq4i2tLWVDYId40ZmA1b23DNQY+XRbOEnA439S16J+o1gcoAvinxWxHq
	 VGAkcMcOnAgTh3rbVd02mAvHR7upHEaV3b5yzbviraJcvLnIcAcVPz2r0m6jO6E3/J
	 1j8tUuIr0dlXZehD6NvvvT1rzQE/837KWuV/LMCtPKKe+1Y6def5g5Qn9R1Y0DoIWa
	 2kNZ+P5yMHNefiQCaw8a9OLVh37TKgmgtYzQfJSuVE4TivRifbeWmw6160WqjFVSle
	 at6e1v4UfL49Q==
From: Jakub Kicinski <kuba@kernel.org>
To: ast@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	hawk@kernel.org,
	amritha.nambiar@intel.com,
	aleksander.lobakin@intel.com,
	Jakub Kicinski <kuba@kernel.org>,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	gregkh@linuxfoundation.org,
	wangyufen@huawei.com,
	virtualization@lists.linux-foundation.org
Subject: [PATCH bpf-next 2/3] net: move struct netdev_rx_queue out of netdevice.h
Date: Tue,  1 Aug 2023 17:32:45 -0700
Message-ID: <20230802003246.2153774-3-kuba@kernel.org>
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

struct netdev_rx_queue is touched in only a few places
and having it defined in netdevice.h brings in the dependency
on xdp.h, because struct xdp_rxq_info gets embedded in
struct netdev_rx_queue.

In prep for removal of xdp.h from netdevice.h move all
the netdev_rx_queue stuff to a new header.

We could technically break the new header up to avoid
the sysfs.h include but it's so rarely included it
doesn't seem to be worth it at this point.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: mst@redhat.com
CC: jasowang@redhat.com
CC: xuanzhuo@linux.alibaba.com
CC: ast@kernel.org
CC: daniel@iogearbox.net
CC: andrii@kernel.org
CC: martin.lau@linux.dev
CC: song@kernel.org
CC: yonghong.song@linux.dev
CC: john.fastabend@gmail.com
CC: kpsingh@kernel.org
CC: sdf@google.com
CC: haoluo@google.com
CC: jolsa@kernel.org
CC: bjorn@kernel.org
CC: magnus.karlsson@intel.com
CC: maciej.fijalkowski@intel.com
CC: jonathan.lemon@gmail.com
CC: hawk@kernel.org
CC: gregkh@linuxfoundation.org
CC: wangyufen@huawei.com
CC: virtualization@lists.linux-foundation.org
CC: bpf@vger.kernel.org
---
 drivers/net/virtio_net.c      |  1 +
 include/linux/netdevice.h     | 44 -----------------------------
 include/net/netdev_rx_queue.h | 53 +++++++++++++++++++++++++++++++++++
 net/bpf/test_run.c            |  1 +
 net/core/dev.c                |  1 +
 net/core/net-sysfs.c          |  1 +
 net/xdp/xsk.c                 |  1 +
 7 files changed, 58 insertions(+), 44 deletions(-)
 create mode 100644 include/net/netdev_rx_queue.h

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0db14f6b87d3..5bcfd69333ea 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -22,6 +22,7 @@
 #include <net/route.h>
 #include <net/xdp.h>
 #include <net/net_failover.h>
+#include <net/netdev_rx_queue.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3800d0479698..5563c8a210b5 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -782,32 +782,6 @@ bool rps_may_expire_flow(struct net_device *dev, u16 rxq_index, u32 flow_id,
 #endif
 #endif /* CONFIG_RPS */
 
-/* This structure contains an instance of an RX queue. */
-struct netdev_rx_queue {
-	struct xdp_rxq_info		xdp_rxq;
-#ifdef CONFIG_RPS
-	struct rps_map __rcu		*rps_map;
-	struct rps_dev_flow_table __rcu	*rps_flow_table;
-#endif
-	struct kobject			kobj;
-	struct net_device		*dev;
-	netdevice_tracker		dev_tracker;
-
-#ifdef CONFIG_XDP_SOCKETS
-	struct xsk_buff_pool            *pool;
-#endif
-} ____cacheline_aligned_in_smp;
-
-/*
- * RX queue sysfs structures and functions.
- */
-struct rx_queue_attribute {
-	struct attribute attr;
-	ssize_t (*show)(struct netdev_rx_queue *queue, char *buf);
-	ssize_t (*store)(struct netdev_rx_queue *queue,
-			 const char *buf, size_t len);
-};
-
 /* XPS map type and offset of the xps map within net_device->xps_maps[]. */
 enum xps_map_type {
 	XPS_CPUS = 0,
@@ -3828,24 +3802,6 @@ static inline int netif_set_real_num_rx_queues(struct net_device *dev,
 int netif_set_real_num_queues(struct net_device *dev,
 			      unsigned int txq, unsigned int rxq);
 
-static inline struct netdev_rx_queue *
-__netif_get_rx_queue(struct net_device *dev, unsigned int rxq)
-{
-	return dev->_rx + rxq;
-}
-
-#ifdef CONFIG_SYSFS
-static inline unsigned int get_netdev_rx_queue_index(
-		struct netdev_rx_queue *queue)
-{
-	struct net_device *dev = queue->dev;
-	int index = queue - dev->_rx;
-
-	BUG_ON(index >= dev->num_rx_queues);
-	return index;
-}
-#endif
-
 int netif_get_num_default_rss_queues(void);
 
 void dev_kfree_skb_irq_reason(struct sk_buff *skb, enum skb_drop_reason reason);
diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
new file mode 100644
index 000000000000..cdcafb30d437
--- /dev/null
+++ b/include/net/netdev_rx_queue.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_NETDEV_RX_QUEUE_H
+#define _LINUX_NETDEV_RX_QUEUE_H
+
+#include <linux/kobject.h>
+#include <linux/netdevice.h>
+#include <linux/sysfs.h>
+#include <net/xdp.h>
+
+/* This structure contains an instance of an RX queue. */
+struct netdev_rx_queue {
+	struct xdp_rxq_info		xdp_rxq;
+#ifdef CONFIG_RPS
+	struct rps_map __rcu		*rps_map;
+	struct rps_dev_flow_table __rcu	*rps_flow_table;
+#endif
+	struct kobject			kobj;
+	struct net_device		*dev;
+	netdevice_tracker		dev_tracker;
+
+#ifdef CONFIG_XDP_SOCKETS
+	struct xsk_buff_pool            *pool;
+#endif
+} ____cacheline_aligned_in_smp;
+
+/*
+ * RX queue sysfs structures and functions.
+ */
+struct rx_queue_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct netdev_rx_queue *queue, char *buf);
+	ssize_t (*store)(struct netdev_rx_queue *queue,
+			 const char *buf, size_t len);
+};
+
+static inline struct netdev_rx_queue *
+__netif_get_rx_queue(struct net_device *dev, unsigned int rxq)
+{
+	return dev->_rx + rxq;
+}
+
+#ifdef CONFIG_SYSFS
+static inline unsigned int
+get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
+{
+	struct net_device *dev = queue->dev;
+	int index = queue - dev->_rx;
+
+	BUG_ON(index >= dev->num_rx_queues);
+	return index;
+}
+#endif
+#endif
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 7d47f53f20c1..4ed68141d9a3 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -21,6 +21,7 @@
 #include <linux/sock_diag.h>
 #include <linux/netfilter.h>
 #include <net/xdp.h>
+#include <net/netdev_rx_queue.h>
 #include <net/netfilter/nf_bpf_link.h>
 
 #define CREATE_TRACE_POINTS
diff --git a/net/core/dev.c b/net/core/dev.c
index 8e7d0cb540cd..1fee2372b633 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -151,6 +151,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/prandom.h>
 #include <linux/once_lite.h>
+#include <net/netdev_rx_queue.h>
 
 #include "dev.h"
 #include "net-sysfs.h"
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 15e3f4606b5f..fccaa5bac0ed 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -23,6 +23,7 @@
 #include <linux/of.h>
 #include <linux/of_net.h>
 #include <linux/cpu.h>
+#include <net/netdev_rx_queue.h>
 
 #include "dev.h"
 #include "net-sysfs.h"
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 4f1e0599146e..82aaec1b079f 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -25,6 +25,7 @@
 #include <linux/vmalloc.h>
 #include <net/xdp_sock_drv.h>
 #include <net/busy_poll.h>
+#include <net/netdev_rx_queue.h>
 #include <net/xdp.h>
 
 #include "xsk_queue.h"
-- 
2.41.0


