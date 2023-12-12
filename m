Return-Path: <bpf+bounces-17501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB93680E89D
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 11:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8CC1F2194E
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 10:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1EE59534;
	Tue, 12 Dec 2023 10:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GahLo541"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C8B59175;
	Tue, 12 Dec 2023 10:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F84C433C7;
	Tue, 12 Dec 2023 10:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702375603;
	bh=fbBvwBFzC4WHsNGAhvyafDC64z3noMhHKnx2LNaUewk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GahLo541S1biMa23RQJrbW13Wy+W924fwRLsMk+Is/r1DtI2jx5nJVMTRmL4xV61C
	 90aTDK29SymjGpYezvsvYdWh8iN2l/VlKNSVgoYvlIyp7LH2mm6CZuLuGu4PHFmOFs
	 Oa2YkUeRAjimtGp6cUM0Ltn0CgjgbCLBkGEXps7XPuoKDrNAxFxAu4ZK1GuKLBQH7s
	 /bF60h/eusG2Q5QGVkbVH/HoAuhPOcyFZefxh2fCDEfPB9lORZDnu+s9fM1Rx+j/Kz
	 VDOonrfcBPLgms62qoeuyFe0wLiQVQ6JVnO+EuDr8EfuR4YnFSJhh2w7SXAlnt61ue
	 CM8HYBaIEhZ4Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	hawk@kernel.org,
	toke@redhat.com,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	sdf@google.com
Subject: [PATCH v4 net-next 1/3] net: introduce page_pool pointer in softnet_data percpu struct
Date: Tue, 12 Dec 2023 11:06:13 +0100
Message-ID: <2a267c8f331996de0e26568472c45fe78eb67e1d.1702375338.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702375338.git.lorenzo@kernel.org>
References: <cover.1702375338.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allocate percpu page_pools in softnet_data.
Moreover add cpuid filed in page_pool struct in order to recycle the
page in the page_pool "hot" cache if napi_pp_put_page() is running on
the same cpu.
This is a preliminary patch to add xdp multi-buff support for xdp running
in generic mode.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/linux/netdevice.h       |  1 +
 include/net/page_pool/helpers.h |  5 +++++
 include/net/page_pool/types.h   |  2 +-
 net/core/dev.c                  | 28 +++++++++++++++++++++++++++-
 net/core/skbuff.c               |  5 +++--
 5 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1b935ee341b4..30b6a3f601fe 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3319,6 +3319,7 @@ struct softnet_data {
 	int			defer_count;
 	int			defer_ipi_scheduled;
 	struct sk_buff		*defer_list;
+	struct page_pool	*page_pool;
 	call_single_data_t	defer_csd;
 };
 
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 7dc65774cde5..b0da1fdb62dc 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -393,4 +393,9 @@ static inline void page_pool_nid_changed(struct page_pool *pool, int new_nid)
 		page_pool_update_nid(pool, new_nid);
 }
 
+static inline void page_pool_set_cpuid(struct page_pool *pool, int cpuid)
+{
+	pool->cpuid = cpuid;
+}
+
 #endif /* _NET_PAGE_POOL_HELPERS_H */
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index ac286ea8ce2d..75396f107b20 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -127,7 +127,7 @@ struct page_pool_stats {
 
 struct page_pool {
 	struct page_pool_params_fast p;
-
+	int cpuid;
 	bool has_init_callback;
 
 	long frag_users;
diff --git a/net/core/dev.c b/net/core/dev.c
index 0432b04cf9b0..4c3d82fcf5b5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -153,6 +153,8 @@
 #include <linux/prandom.h>
 #include <linux/once_lite.h>
 #include <net/netdev_rx_queue.h>
+#include <net/page_pool/types.h>
+#include <net/page_pool/helpers.h>
 
 #include "dev.h"
 #include "net-sysfs.h"
@@ -11670,12 +11672,14 @@ static void __init net_dev_struct_check(void)
  *
  */
 
+#define SD_PAGE_POOL_RING_SIZE	256
 /*
  *       This is called single threaded during boot, so no need
  *       to take the rtnl semaphore.
  */
 static int __init net_dev_init(void)
 {
+	struct softnet_data *sd;
 	int i, rc = -ENOMEM;
 
 	BUG_ON(!dev_boot_phase);
@@ -11701,10 +11705,14 @@ static int __init net_dev_init(void)
 
 	for_each_possible_cpu(i) {
 		struct work_struct *flush = per_cpu_ptr(&flush_works, i);
-		struct softnet_data *sd = &per_cpu(softnet_data, i);
+		struct page_pool_params page_pool_params = {
+			.pool_size = SD_PAGE_POOL_RING_SIZE,
+			.nid = NUMA_NO_NODE,
+		};
 
 		INIT_WORK(flush, flush_backlog);
 
+		sd = &per_cpu(softnet_data, i);
 		skb_queue_head_init(&sd->input_pkt_queue);
 		skb_queue_head_init(&sd->process_queue);
 #ifdef CONFIG_XFRM_OFFLOAD
@@ -11722,6 +11730,13 @@ static int __init net_dev_init(void)
 		init_gro_hash(&sd->backlog);
 		sd->backlog.poll = process_backlog;
 		sd->backlog.weight = weight_p;
+
+		sd->page_pool = page_pool_create(&page_pool_params);
+		if (IS_ERR(sd->page_pool)) {
+			sd->page_pool = NULL;
+			goto out;
+		}
+		page_pool_set_cpuid(sd->page_pool, i);
 	}
 
 	dev_boot_phase = 0;
@@ -11749,6 +11764,17 @@ static int __init net_dev_init(void)
 	WARN_ON(rc < 0);
 	rc = 0;
 out:
+	if (rc < 0) {
+		for_each_possible_cpu(i) {
+			sd = &per_cpu(softnet_data, i);
+			if (!sd->page_pool)
+				continue;
+
+			page_pool_destroy(sd->page_pool);
+			sd->page_pool = NULL;
+		}
+	}
+
 	return rc;
 }
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b157efea5dea..4bc0a7f98241 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -918,9 +918,10 @@ bool napi_pp_put_page(struct page *page, bool napi_safe)
 	 */
 	if (napi_safe || in_softirq()) {
 		const struct napi_struct *napi = READ_ONCE(pp->p.napi);
+		unsigned int cpuid = smp_processor_id();
 
-		allow_direct = napi &&
-			READ_ONCE(napi->list_owner) == smp_processor_id();
+		allow_direct = napi && READ_ONCE(napi->list_owner) == cpuid;
+		allow_direct |= (pp->cpuid == cpuid);
 	}
 
 	/* Driver set this to memory recycling info. Reset it on recycle.
-- 
2.43.0


