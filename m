Return-Path: <bpf+bounces-21004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 499B1846A7A
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 09:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B07D4B2113C
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 08:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E63482C3;
	Fri,  2 Feb 2024 08:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQUN801D"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64368481BF;
	Fri,  2 Feb 2024 08:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861633; cv=none; b=CmE9wybsoVZIbngKT489n2e/fW7KZmwSdgdueOB54PxvjrHRdC9yyTn5knMc6zxA2UEmprhFcnIMuChkeJauh6lUTT7aAizDiGvTaiJLIy1Lp9IqtyFQHBoejJ6FzaKJCk92YT/OsKlNnCLUMgxSocu4F9trgu20lXEWr5cLBLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861633; c=relaxed/simple;
	bh=vDAZg1Lb18JrmMYisnrrwiWl0i5LH2gCVJqDo6CgiDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OxuWCKsEnCZrcqfE2uwCS/kz88l/bvexR/aHpT/L1WD+f/c0rC4zdf48FXqoQbU2XxcVoIZ8vPbznYHlyeQahhE2S3beTJB4diIz5ZaEjMjLY0rfM8VzvZG5wcEF39N3TXxsFjN9cuQWV5iMTbRRjNA+pC7G0y1IbCETxejshAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQUN801D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8917EC433C7;
	Fri,  2 Feb 2024 08:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706861632;
	bh=vDAZg1Lb18JrmMYisnrrwiWl0i5LH2gCVJqDo6CgiDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQUN801Dh1xe4IEPodiXvbbQTo/RuTtOz5rRqfnUmwYIb21Dj+8jVIEi5uE744Gcq
	 Z3yrQHXbzxq1JDP6vwLewPfsua1mF1Kiw8R+4trGDj3PiZa/ooWD52T8avxhrm2ctJ
	 qsEmX8hAPg5gbb9rG9W4OlDmnuZ2QO5yFhklrUJK0jyR7bKNIehpTWc/nTdygTzCWB
	 xiLcKVhBpA6xPf29HRxlwZISi4CY5GatObNbDfKhkUTXWXDybxV/oh1XSEC8gjCdAp
	 SEX2QxrRYdx8XmAvP9u/9ef6MJ1QVCNuHam47FoE1NoxJ+K+EyAmhlUxTLohjfgWPT
	 5cPzg8sFiB2Iw==
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
Subject: [PATCH v7 net-next 1/4] net: add generic percpu page_pool allocator
Date: Fri,  2 Feb 2024 09:12:44 +0100
Message-ID: <1d34b717f8f842b9c3e9f70f0e8ffd245a5d2460.1706861261.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706861261.git.lorenzo@kernel.org>
References: <cover.1706861261.git.lorenzo@kernel.org>
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
index b53b9c94de40..5a100360389f 100644
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
@@ -11691,6 +11699,27 @@ static void __init net_dev_struct_check(void)
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
@@ -11743,6 +11772,9 @@ static int __init net_dev_init(void)
 		init_gro_hash(&sd->backlog);
 		sd->backlog.poll = process_backlog;
 		sd->backlog.weight = weight_p;
+
+		if (net_page_pool_create(i))
+			goto out;
 	}
 
 	dev_boot_phase = 0;
@@ -11770,6 +11802,19 @@ static int __init net_dev_init(void)
 	WARN_ON(rc < 0);
 	rc = 0;
 out:
+	if (rc < 0) {
+		for_each_possible_cpu(i) {
+			struct page_pool *pp_ptr;
+
+			pp_ptr = per_cpu_ptr(system_page_pool, i);
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


