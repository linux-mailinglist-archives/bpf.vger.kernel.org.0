Return-Path: <bpf+bounces-5822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DAD761987
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 15:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF41028171A
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 13:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FD81F19B;
	Tue, 25 Jul 2023 13:15:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FCE1F18F;
	Tue, 25 Jul 2023 13:15:44 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC824E3;
	Tue, 25 Jul 2023 06:15:39 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R9HWy5HtTzLnwq;
	Tue, 25 Jul 2023 21:13:02 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 21:15:36 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Eric Dumazet <edumazet@google.com>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team
	<linux-imx@nxp.com>, Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad
	<hkelam@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Felix Fietkau <nbd@nbd.name>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Shayne
 Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Kalle
 Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, <linux-rdma@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH net-next v2] page_pool: split types and declarations from page_pool.h
Date: Tue, 25 Jul 2023 21:12:55 +0800
Message-ID: <20230725131258.31306-1-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Split types and pure function declarations from page_pool.h
and add them in page_pool/types.h, so that C sources can
include page_pool.h and headers should generally only include
page_pool/types.h as suggested by jakub.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
---
V2: Move from page_pool_types.h to page_pool/types.h, fix
    some typo and alphabetic sorting.
---
 MAINTAINERS                                   |   1 +
 drivers/net/ethernet/engleder/tsnep_main.c    |   1 +
 drivers/net/ethernet/freescale/fec_main.c     |   1 +
 .../marvell/octeontx2/nic/otx2_common.c       |   1 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   1 +
 .../ethernet/mellanox/mlx5/core/en/params.c   |   1 +
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |   1 +
 drivers/net/wireless/mediatek/mt76/mt76.h     |   1 +
 include/linux/skbuff.h                        |   2 +-
 include/net/page_pool.h                       | 192 +----------------
 include/net/page_pool/types.h                 | 193 ++++++++++++++++++
 11 files changed, 206 insertions(+), 189 deletions(-)
 create mode 100644 include/net/page_pool/types.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d0553ad37865..1dbfe7fcb10e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16016,6 +16016,7 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	Documentation/networking/page_pool.rst
 F:	include/net/page_pool.h
+F:	include/net/page_pool_types.h
 F:	include/trace/events/page_pool.h
 F:	net/core/page_pool.c
 
diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 079f9f6ae21a..934b890ba2ab 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -28,6 +28,7 @@
 #include <linux/iopoll.h>
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
+#include <net/page_pool.h>
 #include <net/xdp_sock_drv.h>
 
 #define TSNEP_RX_OFFSET (max(NET_SKB_PAD, XDP_PACKET_HEADROOM) + NET_IP_ALIGN)
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 03ac7690b5c4..68b79bda632a 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -38,6 +38,7 @@
 #include <linux/in.h>
 #include <linux/ip.h>
 #include <net/ip.h>
+#include <net/page_pool.h>
 #include <net/selftests.h>
 #include <net/tso.h>
 #include <linux/tcp.h>
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 8cdd92dd9762..d4f1baf0f987 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -7,6 +7,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/pci.h>
+#include <net/page_pool.h>
 #include <net/tso.h>
 #include <linux/bitfield.h>
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 9551b422622a..8807e40b1174 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -16,6 +16,7 @@
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <linux/bitfield.h>
+#include <net/page_pool.h>
 
 #include "otx2_reg.h"
 #include "otx2_common.h"
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 5ce28ff7685f..0f152f14165b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -6,6 +6,7 @@
 #include "en/port.h"
 #include "en_accel/en_accel.h"
 #include "en_accel/ipsec.h"
+#include <net/page_pool.h>
 #include <net/xdp_sock_drv.h>
 
 static u8 mlx5e_mpwrq_min_page_shift(struct mlx5_core_dev *mdev)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 40589cebb773..16038c23b7d8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -35,6 +35,7 @@
 #include "en/xdp.h"
 #include "en/params.h"
 #include <linux/bitfield.h>
+#include <net/page_pool.h>
 
 int mlx5e_xdp_max_mtu(struct mlx5e_params *params, struct mlx5e_xsk_param *xsk)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 6b07b8fafec2..95c16f11d156 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -15,6 +15,7 @@
 #include <linux/average.h>
 #include <linux/soc/mediatek/mtk_wed.h>
 #include <net/mac80211.h>
+#include <net/page_pool.h>
 #include "util.h"
 #include "testmode.h"
 
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index faaba050f843..864c51c95ac4 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -32,7 +32,7 @@
 #include <linux/if_packet.h>
 #include <linux/llist.h>
 #include <net/flow.h>
-#include <net/page_pool.h>
+#include <net/page_pool/types.h>
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 #include <linux/netfilter/nf_conntrack_common.h>
 #endif
diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index f1d5cc1fa13b..dd70474c67cc 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -29,107 +29,9 @@
 #ifndef _NET_PAGE_POOL_H
 #define _NET_PAGE_POOL_H
 
-#include <linux/mm.h> /* Needed by ptr_ring */
-#include <linux/ptr_ring.h>
-#include <linux/dma-direction.h>
-
-#define PP_FLAG_DMA_MAP		BIT(0) /* Should page_pool do the DMA
-					* map/unmap
-					*/
-#define PP_FLAG_DMA_SYNC_DEV	BIT(1) /* If set all pages that the driver gets
-					* from page_pool will be
-					* DMA-synced-for-device according to
-					* the length provided by the device
-					* driver.
-					* Please note DMA-sync-for-CPU is still
-					* device driver responsibility
-					*/
-#define PP_FLAG_PAGE_FRAG	BIT(2) /* for page frag feature */
-#define PP_FLAG_ALL		(PP_FLAG_DMA_MAP |\
-				 PP_FLAG_DMA_SYNC_DEV |\
-				 PP_FLAG_PAGE_FRAG)
-
-/*
- * Fast allocation side cache array/stack
- *
- * The cache size and refill watermark is related to the network
- * use-case.  The NAPI budget is 64 packets.  After a NAPI poll the RX
- * ring is usually refilled and the max consumed elements will be 64,
- * thus a natural max size of objects needed in the cache.
- *
- * Keeping room for more objects, is due to XDP_DROP use-case.  As
- * XDP_DROP allows the opportunity to recycle objects directly into
- * this array, as it shares the same softirq/NAPI protection.  If
- * cache is already full (or partly full) then the XDP_DROP recycles
- * would have to take a slower code path.
- */
-#define PP_ALLOC_CACHE_SIZE	128
-#define PP_ALLOC_CACHE_REFILL	64
-struct pp_alloc_cache {
-	u32 count;
-	struct page *cache[PP_ALLOC_CACHE_SIZE];
-};
-
-struct page_pool_params {
-	unsigned int	flags;
-	unsigned int	order;
-	unsigned int	pool_size;
-	int		nid;  /* Numa node id to allocate from pages from */
-	struct device	*dev; /* device, for DMA pre-mapping purposes */
-	struct napi_struct *napi; /* Sole consumer of pages, otherwise NULL */
-	enum dma_data_direction dma_dir; /* DMA mapping direction */
-	unsigned int	max_len; /* max DMA sync memory size */
-	unsigned int	offset;  /* DMA addr offset */
-	void (*init_callback)(struct page *page, void *arg);
-	void *init_arg;
-};
-
-#ifdef CONFIG_PAGE_POOL_STATS
-struct page_pool_alloc_stats {
-	u64 fast; /* fast path allocations */
-	u64 slow; /* slow-path order 0 allocations */
-	u64 slow_high_order; /* slow-path high order allocations */
-	u64 empty; /* failed refills due to empty ptr ring, forcing
-		    * slow path allocation
-		    */
-	u64 refill; /* allocations via successful refill */
-	u64 waive;  /* failed refills due to numa zone mismatch */
-};
-
-struct page_pool_recycle_stats {
-	u64 cached;	/* recycling placed page in the cache. */
-	u64 cache_full; /* cache was full */
-	u64 ring;	/* recycling placed page back into ptr ring */
-	u64 ring_full;	/* page was released from page-pool because
-			 * PTR ring was full.
-			 */
-	u64 released_refcnt; /* page released because of elevated
-			      * refcnt
-			      */
-};
-
-/* This struct wraps the above stats structs so users of the
- * page_pool_get_stats API can pass a single argument when requesting the
- * stats for the page pool.
- */
-struct page_pool_stats {
-	struct page_pool_alloc_stats alloc_stats;
-	struct page_pool_recycle_stats recycle_stats;
-};
-
-int page_pool_ethtool_stats_get_count(void);
-u8 *page_pool_ethtool_stats_get_strings(u8 *data);
-u64 *page_pool_ethtool_stats_get(u64 *data, void *stats);
-
-/*
- * Drivers that wish to harvest page pool stats and report them to users
- * (perhaps via ethtool, debugfs, or another mechanism) can allocate a
- * struct page_pool_stats call page_pool_get_stats to get stats for the specified pool.
- */
-bool page_pool_get_stats(struct page_pool *pool,
-			 struct page_pool_stats *stats);
-#else
+#include <net/page_pool/types.h>
 
+#ifndef CONFIG_PAGE_POOL_STATS
 static inline int page_pool_ethtool_stats_get_count(void)
 {
 	return 0;
@@ -144,72 +46,7 @@ static inline u64 *page_pool_ethtool_stats_get(u64 *data, void *stats)
 {
 	return data;
 }
-
-#endif
-
-struct page_pool {
-	struct page_pool_params p;
-
-	struct delayed_work release_dw;
-	void (*disconnect)(void *);
-	unsigned long defer_start;
-	unsigned long defer_warn;
-
-	u32 pages_state_hold_cnt;
-	unsigned int frag_offset;
-	struct page *frag_page;
-	long frag_users;
-
-#ifdef CONFIG_PAGE_POOL_STATS
-	/* these stats are incremented while in softirq context */
-	struct page_pool_alloc_stats alloc_stats;
-#endif
-	u32 xdp_mem_id;
-
-	/*
-	 * Data structure for allocation side
-	 *
-	 * Drivers allocation side usually already perform some kind
-	 * of resource protection.  Piggyback on this protection, and
-	 * require driver to protect allocation side.
-	 *
-	 * For NIC drivers this means, allocate a page_pool per
-	 * RX-queue. As the RX-queue is already protected by
-	 * Softirq/BH scheduling and napi_schedule. NAPI schedule
-	 * guarantee that a single napi_struct will only be scheduled
-	 * on a single CPU (see napi_schedule).
-	 */
-	struct pp_alloc_cache alloc ____cacheline_aligned_in_smp;
-
-	/* Data structure for storing recycled pages.
-	 *
-	 * Returning/freeing pages is more complicated synchronization
-	 * wise, because free's can happen on remote CPUs, with no
-	 * association with allocation resource.
-	 *
-	 * Use ptr_ring, as it separates consumer and producer
-	 * effeciently, it a way that doesn't bounce cache-lines.
-	 *
-	 * TODO: Implement bulk return pages into this structure.
-	 */
-	struct ptr_ring ring;
-
-#ifdef CONFIG_PAGE_POOL_STATS
-	/* recycle stats are per-cpu to avoid locking */
-	struct page_pool_recycle_stats __percpu *recycle_stats;
 #endif
-	atomic_t pages_state_release_cnt;
-
-	/* A page_pool is strictly tied to a single RX-queue being
-	 * protected by NAPI, due to above pp_alloc_cache. This
-	 * refcnt serves purpose is to simplify drivers error handling.
-	 */
-	refcount_t user_cnt;
-
-	u64 destroy_cnt;
-};
-
-struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
 
 static inline struct page *page_pool_dev_alloc_pages(struct page_pool *pool)
 {
@@ -218,9 +55,6 @@ static inline struct page *page_pool_dev_alloc_pages(struct page_pool *pool)
 	return page_pool_alloc_pages(pool, gfp);
 }
 
-struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
-				  unsigned int size, gfp_t gfp);
-
 static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
 						    unsigned int *offset,
 						    unsigned int size)
@@ -239,20 +73,7 @@ inline enum dma_data_direction page_pool_get_dma_dir(struct page_pool *pool)
 	return pool->p.dma_dir;
 }
 
-bool page_pool_return_skb_page(struct page *page, bool napi_safe);
-
-struct page_pool *page_pool_create(const struct page_pool_params *params);
-
-struct xdp_mem_info;
-
-#ifdef CONFIG_PAGE_POOL
-void page_pool_unlink_napi(struct page_pool *pool);
-void page_pool_destroy(struct page_pool *pool);
-void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
-			   struct xdp_mem_info *mem);
-void page_pool_put_page_bulk(struct page_pool *pool, void **data,
-			     int count);
-#else
+#ifndef CONFIG_PAGE_POOL
 static inline void page_pool_unlink_napi(struct page_pool *pool)
 {
 }
@@ -261,6 +82,7 @@ static inline void page_pool_destroy(struct page_pool *pool)
 {
 }
 
+struct xdp_mem_info;
 static inline void page_pool_use_xdp_mem(struct page_pool *pool,
 					 void (*disconnect)(void *),
 					 struct xdp_mem_info *mem)
@@ -273,10 +95,6 @@ static inline void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 }
 #endif
 
-void page_pool_put_defragged_page(struct page_pool *pool, struct page *page,
-				  unsigned int dma_sync_size,
-				  bool allow_direct);
-
 /* pp_frag_count represents the number of writers who can update the page
  * either by updating skb->data or via DMA mappings for the device.
  * We can't rely on the page refcnt for that as we don't know who might be
@@ -385,8 +203,6 @@ static inline bool page_pool_put(struct page_pool *pool)
 	return refcount_dec_and_test(&pool->user_cnt);
 }
 
-/* Caller must provide appropriate safe context, e.g. NAPI. */
-void page_pool_update_nid(struct page_pool *pool, int new_nid);
 static inline void page_pool_nid_changed(struct page_pool *pool, int new_nid)
 {
 	if (unlikely(pool->p.nid != new_nid))
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
new file mode 100644
index 000000000000..1d54ba0708db
--- /dev/null
+++ b/include/net/page_pool/types.h
@@ -0,0 +1,193 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _NET_PAGE_POOL_TYPES_H
+#define _NET_PAGE_POOL_TYPES_H
+
+#include <linux/dma-direction.h>
+#include <linux/ptr_ring.h>
+
+#define PP_FLAG_DMA_MAP		BIT(0) /* Should page_pool do the DMA
+					* map/unmap
+					*/
+#define PP_FLAG_DMA_SYNC_DEV	BIT(1) /* If set all pages that the driver gets
+					* from page_pool will be
+					* DMA-synced-for-device according to
+					* the length provided by the device
+					* driver.
+					* Please note DMA-sync-for-CPU is still
+					* device driver responsibility
+					*/
+#define PP_FLAG_PAGE_FRAG	BIT(2) /* for page frag feature */
+#define PP_FLAG_ALL		(PP_FLAG_DMA_MAP |\
+				 PP_FLAG_DMA_SYNC_DEV |\
+				 PP_FLAG_PAGE_FRAG)
+
+/*
+ * Fast allocation side cache array/stack
+ *
+ * The cache size and refill watermark is related to the network
+ * use-case.  The NAPI budget is 64 packets.  After a NAPI poll the RX
+ * ring is usually refilled and the max consumed elements will be 64,
+ * thus a natural max size of objects needed in the cache.
+ *
+ * Keeping room for more objects, is due to XDP_DROP use-case.  As
+ * XDP_DROP allows the opportunity to recycle objects directly into
+ * this array, as it shares the same softirq/NAPI protection.  If
+ * cache is already full (or partly full) then the XDP_DROP recycles
+ * would have to take a slower code path.
+ */
+#define PP_ALLOC_CACHE_SIZE	128
+#define PP_ALLOC_CACHE_REFILL	64
+struct pp_alloc_cache {
+	u32 count;
+	struct page *cache[PP_ALLOC_CACHE_SIZE];
+};
+
+struct page_pool_params {
+	unsigned int	flags;
+	unsigned int	order;
+	unsigned int	pool_size;
+	int		nid;  /* Numa node id to allocate from pages from */
+	struct device	*dev; /* device, for DMA pre-mapping purposes */
+	struct napi_struct *napi; /* Sole consumer of pages, otherwise NULL */
+	enum dma_data_direction dma_dir; /* DMA mapping direction */
+	unsigned int	max_len; /* max DMA sync memory size */
+	unsigned int	offset;  /* DMA addr offset */
+	void (*init_callback)(struct page *page, void *arg);
+	void *init_arg;
+};
+
+#ifdef CONFIG_PAGE_POOL_STATS
+struct page_pool_alloc_stats {
+	u64 fast; /* fast path allocations */
+	u64 slow; /* slow-path order 0 allocations */
+	u64 slow_high_order; /* slow-path high order allocations */
+	u64 empty; /* failed refills due to empty ptr ring, forcing
+		    * slow path allocation
+		    */
+	u64 refill; /* allocations via successful refill */
+	u64 waive;  /* failed refills due to numa zone mismatch */
+};
+
+struct page_pool_recycle_stats {
+	u64 cached;	/* recycling placed page in the cache. */
+	u64 cache_full; /* cache was full */
+	u64 ring;	/* recycling placed page back into ptr ring */
+	u64 ring_full;	/* page was released from page-pool because
+			 * PTR ring was full.
+			 */
+	u64 released_refcnt; /* page released because of elevated
+			      * refcnt
+			      */
+};
+
+/* This struct wraps the above stats structs so users of the
+ * page_pool_get_stats API can pass a single argument when requesting the
+ * stats for the page pool.
+ */
+struct page_pool_stats {
+	struct page_pool_alloc_stats alloc_stats;
+	struct page_pool_recycle_stats recycle_stats;
+};
+
+int page_pool_ethtool_stats_get_count(void);
+u8 *page_pool_ethtool_stats_get_strings(u8 *data);
+u64 *page_pool_ethtool_stats_get(u64 *data, void *stats);
+
+/*
+ * Drivers that wish to harvest page pool stats and report them to users
+ * (perhaps via ethtool, debugfs, or another mechanism) can allocate a
+ * struct page_pool_stats call page_pool_get_stats to get stats for the
+ * specified pool.
+ */
+bool page_pool_get_stats(struct page_pool *pool,
+			 struct page_pool_stats *stats);
+#endif
+
+struct page_pool {
+	struct page_pool_params p;
+
+	struct delayed_work release_dw;
+	void (*disconnect)(void *);
+	unsigned long defer_start;
+	unsigned long defer_warn;
+
+	u32 pages_state_hold_cnt;
+	unsigned int frag_offset;
+	struct page *frag_page;
+	long frag_users;
+
+#ifdef CONFIG_PAGE_POOL_STATS
+	/* these stats are incremented while in softirq context */
+	struct page_pool_alloc_stats alloc_stats;
+#endif
+	u32 xdp_mem_id;
+
+	/*
+	 * Data structure for allocation side
+	 *
+	 * Drivers allocation side usually already perform some kind
+	 * of resource protection.  Piggyback on this protection, and
+	 * require driver to protect allocation side.
+	 *
+	 * For NIC drivers this means, allocate a page_pool per
+	 * RX-queue. As the RX-queue is already protected by
+	 * Softirq/BH scheduling and napi_schedule. NAPI schedule
+	 * guarantee that a single napi_struct will only be scheduled
+	 * on a single CPU (see napi_schedule).
+	 */
+	struct pp_alloc_cache alloc ____cacheline_aligned_in_smp;
+
+	/* Data structure for storing recycled pages.
+	 *
+	 * Returning/freeing pages is more complicated synchronization
+	 * wise, because free's can happen on remote CPUs, with no
+	 * association with allocation resource.
+	 *
+	 * Use ptr_ring, as it separates consumer and producer
+	 * efficiently, it a way that doesn't bounce cache-lines.
+	 *
+	 * TODO: Implement bulk return pages into this structure.
+	 */
+	struct ptr_ring ring;
+
+#ifdef CONFIG_PAGE_POOL_STATS
+	/* recycle stats are per-cpu to avoid locking */
+	struct page_pool_recycle_stats __percpu *recycle_stats;
+#endif
+	atomic_t pages_state_release_cnt;
+
+	/* A page_pool is strictly tied to a single RX-queue being
+	 * protected by NAPI, due to above pp_alloc_cache. This
+	 * refcnt serves purpose is to simplify drivers error handling.
+	 */
+	refcount_t user_cnt;
+
+	u64 destroy_cnt;
+};
+
+struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
+struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
+				  unsigned int size, gfp_t gfp);
+bool page_pool_return_skb_page(struct page *page, bool napi_safe);
+struct page_pool *page_pool_create(const struct page_pool_params *params);
+
+#ifdef CONFIG_PAGE_POOL
+void page_pool_unlink_napi(struct page_pool *pool);
+void page_pool_destroy(struct page_pool *pool);
+
+struct xdp_mem_info;
+void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
+			   struct xdp_mem_info *mem);
+void page_pool_put_page_bulk(struct page_pool *pool, void **data,
+			     int count);
+#endif
+
+void page_pool_put_defragged_page(struct page_pool *pool, struct page *page,
+				  unsigned int dma_sync_size,
+				  bool allow_direct);
+
+/* Caller must provide appropriate safe context, e.g. NAPI. */
+void page_pool_update_nid(struct page_pool *pool, int new_nid);
+
+#endif /* _NET_PAGE_POOL_H */
-- 
2.33.0


