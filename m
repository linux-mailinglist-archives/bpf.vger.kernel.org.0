Return-Path: <bpf+bounces-17835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E77081331E
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 15:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0160F1F22041
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 14:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068D35B1E9;
	Thu, 14 Dec 2023 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnit4QME"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E35ABA7;
	Thu, 14 Dec 2023 14:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75964C433C7;
	Thu, 14 Dec 2023 14:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702564208;
	bh=tAGDS786YeIkN7D1mLt58+nUOMcccXrrP7pbG3Ttusk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rnit4QMEwWLtO4CEqm/kK0X402PUZ5uEDfRsHYY4EhtXbAiCURsXY/iImtwZUcmrn
	 a9OKdo1ypZ3U5TJkOQg6kI/fGSAVRGIFNcl2OJD/9qaful+ZXHckfSKHPqaUzRkXEX
	 03tyXaqhFcKguf83BOK94RhkcM50ZEUbSaP09ePXtpQJOiFuBFiX8taDnSmab9V2Gq
	 AEakFd55pgk78TeAuX404tTD0Ag3bRiEPPniQjvDIRwbfrXXlCOockSHNkWg3+eNWK
	 C3XSHhs2FvtnjTFfFQvtJ1M/Aq3VhTnpgNx5eSGHxzuLJx5y9EXhEA7phMzngrZnwQ
	 RhdGeyWbTRsQg==
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
Subject: [PATCH v5 net-next 1/3] net: introduce page_pool pointer in softnet_data percpu struct
Date: Thu, 14 Dec 2023 15:29:40 +0100
Message-ID: <b1432fc51c694f1be8daabb19773744fcee13cf1.1702563810.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702563810.git.lorenzo@kernel.org>
References: <cover.1702563810.git.lorenzo@kernel.org>
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
 include/net/page_pool/types.h   |  1 +
 net/core/dev.c                  | 39 ++++++++++++++++++++++++++++++++-
 net/core/page_pool.c            |  5 +++++
 net/core/skbuff.c               |  5 +++--
 6 files changed, 53 insertions(+), 3 deletions(-)

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
index 841e0a930bd7..6ae735804b40 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -401,4 +401,9 @@ static inline void page_pool_nid_changed(struct page_pool *pool, int new_nid)
 		page_pool_update_nid(pool, new_nid);
 }
 
+static inline void page_pool_set_cpuid(struct page_pool *pool, int cpuid)
+{
+	pool->cpuid = cpuid;
+}
+
 #endif /* _NET_PAGE_POOL_HELPERS_H */
diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 76481c465375..f63dadf2a6d4 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -128,6 +128,7 @@ struct page_pool_stats {
 struct page_pool {
 	struct page_pool_params_fast p;
 
+	int cpuid;
 	bool has_init_callback;
 
 	long frag_users;
diff --git a/net/core/dev.c b/net/core/dev.c
index 0432b04cf9b0..d600e3a6ec2c 100644
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
@@ -11670,12 +11672,33 @@ static void __init net_dev_struct_check(void)
  *
  */
 
+#define SD_PAGE_POOL_RING_SIZE	256
+static int net_sd_page_pool_alloc(struct softnet_data *sd, int cpuid)
+{
+#if IS_ENABLED(CONFIG_PAGE_POOL)
+	struct page_pool_params page_pool_params = {
+		.pool_size = SD_PAGE_POOL_RING_SIZE,
+		.nid = NUMA_NO_NODE,
+	};
+
+	sd->page_pool = page_pool_create(&page_pool_params);
+	if (IS_ERR(sd->page_pool)) {
+		sd->page_pool = NULL;
+		return -ENOMEM;
+	}
+
+	page_pool_set_cpuid(sd->page_pool, cpuid);
+#endif
+	return 0;
+}
+
 /*
  *       This is called single threaded during boot, so no need
  *       to take the rtnl semaphore.
  */
 static int __init net_dev_init(void)
 {
+	struct softnet_data *sd;
 	int i, rc = -ENOMEM;
 
 	BUG_ON(!dev_boot_phase);
@@ -11701,10 +11724,10 @@ static int __init net_dev_init(void)
 
 	for_each_possible_cpu(i) {
 		struct work_struct *flush = per_cpu_ptr(&flush_works, i);
-		struct softnet_data *sd = &per_cpu(softnet_data, i);
 
 		INIT_WORK(flush, flush_backlog);
 
+		sd = &per_cpu(softnet_data, i);
 		skb_queue_head_init(&sd->input_pkt_queue);
 		skb_queue_head_init(&sd->process_queue);
 #ifdef CONFIG_XFRM_OFFLOAD
@@ -11722,6 +11745,9 @@ static int __init net_dev_init(void)
 		init_gro_hash(&sd->backlog);
 		sd->backlog.poll = process_backlog;
 		sd->backlog.weight = weight_p;
+
+		if (net_sd_page_pool_alloc(sd, i))
+			goto out;
 	}
 
 	dev_boot_phase = 0;
@@ -11749,6 +11775,17 @@ static int __init net_dev_init(void)
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
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index dd5a72533f2b..275b8572a82b 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -178,6 +178,11 @@ static int page_pool_init(struct page_pool *pool,
 	memcpy(&pool->p, &params->fast, sizeof(pool->p));
 	memcpy(&pool->slow, &params->slow, sizeof(pool->slow));
 
+	/* It is up to the consumer to set cpuid if we are using percpu
+	 * page_pool so initialize it to an invalid value.
+	 */
+	pool->cpuid = -1;
+
 	/* Validate only known flags were used */
 	if (pool->p.flags & ~(PP_FLAG_ALL))
 		return -EINVAL;
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


