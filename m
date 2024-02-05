Return-Path: <bpf+bounces-21213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDBD8498F4
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 12:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ABFEB27155
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 11:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CEF18EB0;
	Mon,  5 Feb 2024 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4QQGKc2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE4718E29;
	Mon,  5 Feb 2024 11:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707132944; cv=none; b=M7zqSFU2qlSm8AkbtvYRAtAPvGI4CquruJPGtk7Bg/viMhCQ5kwyMCHn72qObmUJg2Yd2xDXIwQaXCPxqw/x3dVvuUvvZnYuziS0g/ajQ74NU5iicnWjLzjF0X5+WC+qzHF0rPR4hVQyQYRphJyOqT6pyf2aesvD/4/sYdWksUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707132944; c=relaxed/simple;
	bh=zG1TxOZhUAK5wcAuXan93WEIPBI/5Cwiiz9izcb2ytA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cu/2wQmIRbrY+OhlVHTu2KJrP6ZpB99PEL0t+8y4aT8L20GDbp9CvpAIBHyunaoLSw49JgVzg5b4MEG6I4w47a4NqXK+fQEt9MlxZ89jlAOtZeyICh9EN/gBCXFJ3kLu9AuROiS3pMVu5IEGZYIB/adfJ/cNujeYALoXTBORqKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4QQGKc2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEC4C433F1;
	Mon,  5 Feb 2024 11:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707132943;
	bh=zG1TxOZhUAK5wcAuXan93WEIPBI/5Cwiiz9izcb2ytA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l4QQGKc2AGkFPvG8M/JHRY0uEudv+KQ4YDGK95QM1IxspYFALoTg+sbvI+QbQQQtR
	 UzR7OdXhLt/9V/RNqD3hHSEQuJfz2NtoKHYpaaRq0S7ZAxs+qgbUsrxlNjknxrfpmw
	 No+qMQ6DRJJIc9Bl/eYrgIzfFLc0RAAU7sjPl3L1m9rKf/S0E9o4+F+4HCdQo+WlnU
	 28f94M4yz4ISSR9nbVYasvzyL+e+ubh9TqpWuAlIKsspx5gbCbVvp+vBmVDTCU/vJA
	 N6tt0KmZ5nGFGHXtF9z6B+ao/MqKIHMyr3Pj6tr6pCK0IJZTG5VtFAAsF1brcX6sCY
	 5pV9Wie5rwsMw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	toke@redhat.com,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	sdf@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	linyunsheng@huawei.com
Subject: [PATCH v8 net-next 1/4] net: add generic percpu page_pool allocator
Date: Mon,  5 Feb 2024 12:35:12 +0100
Message-ID: <1b7af9f7bac0d144e3fd44dc62320763349e728b.1707132752.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707132752.git.lorenzo@kernel.org>
References: <cover.1707132752.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce generic percpu page_pools allocator.
Moreover add page_pool_create_percpu() and cpuid filed in page_pool struct
in order to recycle the page in the page_pool "hot" cache if
napi_pp_put_page() is running on the same cpu.
This is a preliminary patch to add xdp multi-buff support for xdp running
in generic mode.

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Reviewed-by: Toke Hoiland-Jorgensen <toke@redhat.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/page_pool/types.h |  3 +++
 net/core/dev.c                | 45 +++++++++++++++++++++++++++++++++++
 net/core/page_pool.c          | 23 ++++++++++++++----
 net/core/skbuff.c             |  5 ++--
 4 files changed, 70 insertions(+), 6 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 76481c465375..3828396ae60c 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -128,6 +128,7 @@ struct page_pool_stats {
 struct page_pool {
 	struct page_pool_params_fast p;
 
+	int cpuid;
 	bool has_init_callback;
 
 	long frag_users;
@@ -203,6 +204,8 @@ struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
 struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
 				  unsigned int size, gfp_t gfp);
 struct page_pool *page_pool_create(const struct page_pool_params *params);
+struct page_pool *page_pool_create_percpu(const struct page_pool_params *params,
+					  int cpuid);
 
 struct xdp_mem_info;
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 27ba057d06c4..235421d313c3 100644
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
@@ -450,6 +452,12 @@ static RAW_NOTIFIER_HEAD(netdev_chain);
 DEFINE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
 EXPORT_PER_CPU_SYMBOL(softnet_data);
 
+/* Page_pool has a lockless array/stack to alloc/recycle pages.
+ * PP consumers must pay attention to run APIs in the appropriate context
+ * (e.g. NAPI context).
+ */
+static DEFINE_PER_CPU_ALIGNED(struct page_pool *, system_page_pool);
+
 #ifdef CONFIG_LOCKDEP
 /*
  * register_netdevice() inits txq->_xmit_lock and sets lockdep class
@@ -11697,6 +11705,27 @@ static void __init net_dev_struct_check(void)
  *
  */
 
+/* We allocate 256 pages for each CPU if PAGE_SHIFT is 12 */
+#define SYSTEM_PERCPU_PAGE_POOL_SIZE	((1 << 20) / PAGE_SIZE)
+
+static int net_page_pool_create(int cpuid)
+{
+#if IS_ENABLED(CONFIG_PAGE_POOL)
+	struct page_pool_params page_pool_params = {
+		.pool_size = SYSTEM_PERCPU_PAGE_POOL_SIZE,
+		.nid = NUMA_NO_NODE,
+	};
+	struct page_pool *pp_ptr;
+
+	pp_ptr = page_pool_create_percpu(&page_pool_params, cpuid);
+	if (IS_ERR(pp_ptr))
+		return -ENOMEM;
+
+	per_cpu(system_page_pool, cpuid) = pp_ptr;
+#endif
+	return 0;
+}
+
 /*
  *       This is called single threaded during boot, so no need
  *       to take the rtnl semaphore.
@@ -11749,6 +11778,9 @@ static int __init net_dev_init(void)
 		init_gro_hash(&sd->backlog);
 		sd->backlog.poll = process_backlog;
 		sd->backlog.weight = weight_p;
+
+		if (net_page_pool_create(i))
+			goto out;
 	}
 
 	dev_boot_phase = 0;
@@ -11776,6 +11808,19 @@ static int __init net_dev_init(void)
 	WARN_ON(rc < 0);
 	rc = 0;
 out:
+	if (rc < 0) {
+		for_each_possible_cpu(i) {
+			struct page_pool *pp_ptr;
+
+			pp_ptr = per_cpu(system_page_pool, i);
+			if (!pp_ptr)
+				continue;
+
+			page_pool_destroy(pp_ptr);
+			per_cpu(system_page_pool, i) = NULL;
+		}
+	}
+
 	return rc;
 }
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 4933762e5a6b..89c835fcf094 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -171,13 +171,16 @@ static void page_pool_producer_unlock(struct page_pool *pool,
 }
 
 static int page_pool_init(struct page_pool *pool,
-			  const struct page_pool_params *params)
+			  const struct page_pool_params *params,
+			  int cpuid)
 {
 	unsigned int ring_qsize = 1024; /* Default */
 
 	memcpy(&pool->p, &params->fast, sizeof(pool->p));
 	memcpy(&pool->slow, &params->slow, sizeof(pool->slow));
 
+	pool->cpuid = cpuid;
+
 	/* Validate only known flags were used */
 	if (pool->p.flags & ~(PP_FLAG_ALL))
 		return -EINVAL;
@@ -253,10 +256,12 @@ static void page_pool_uninit(struct page_pool *pool)
 }
 
 /**
- * page_pool_create() - create a page pool.
+ * page_pool_create_percpu() - create a page pool for a given cpu.
  * @params: parameters, see struct page_pool_params
+ * @cpuid: cpu identifier
  */
-struct page_pool *page_pool_create(const struct page_pool_params *params)
+struct page_pool *
+page_pool_create_percpu(const struct page_pool_params *params, int cpuid)
 {
 	struct page_pool *pool;
 	int err;
@@ -265,7 +270,7 @@ struct page_pool *page_pool_create(const struct page_pool_params *params)
 	if (!pool)
 		return ERR_PTR(-ENOMEM);
 
-	err = page_pool_init(pool, params);
+	err = page_pool_init(pool, params, cpuid);
 	if (err < 0)
 		goto err_free;
 
@@ -282,6 +287,16 @@ struct page_pool *page_pool_create(const struct page_pool_params *params)
 	kfree(pool);
 	return ERR_PTR(err);
 }
+EXPORT_SYMBOL(page_pool_create_percpu);
+
+/**
+ * page_pool_create() - create a page pool
+ * @params: parameters, see struct page_pool_params
+ */
+struct page_pool *page_pool_create(const struct page_pool_params *params)
+{
+	return page_pool_create_percpu(params, -1);
+}
 EXPORT_SYMBOL(page_pool_create);
 
 static void page_pool_return_page(struct page_pool *pool, struct page *page);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index edbbef563d4d..9e5eb47b4025 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -923,9 +923,10 @@ bool napi_pp_put_page(struct page *page, bool napi_safe)
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


