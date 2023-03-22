Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B524D6C5900
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 22:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCVVxB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 17:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCVVw7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 17:52:59 -0400
Received: from out-57.mta0.migadu.com (out-57.mta0.migadu.com [91.218.175.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE97F3402F
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 14:52:56 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679521974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1oGbsoGwMaJ2ec80nkSOd8WqYZjcYZz3yrzXtXdvj8Y=;
        b=jcnMF06/YctZQtHeA3VvVc2Qy1RbQerkaIAkFQxAVoR0av9sZRDi5Y9hsKz0FxKy0e5QEK
        /1QjY56uNsVBVXTvEE03tXHHROaAgwKPbDz6no8G5ThLIo4ZuVradnRjioqwyAYHEG9rWI
        bwJf6KkZO4P6FrfZfhInG2P7RcN1tMU=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Subject: [PATCH v3 bpf-next 1/5] bpf: Add a few bpf mem allocator functions
Date:   Wed, 22 Mar 2023 14:52:42 -0700
Message-Id: <20230322215246.1675516-2-martin.lau@linux.dev>
In-Reply-To: <20230322215246.1675516-1-martin.lau@linux.dev>
References: <20230322215246.1675516-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch adds a few bpf mem allocator functions which will
be used in the bpf_local_storage in a later patch.

bpf_mem_cache_alloc_flags(..., gfp_t flags) is added. When the
flags == GFP_KERNEL, it will fallback to __alloc(..., GFP_KERNEL).
bpf_local_storage knows its running context is sleepable (GFP_KERNEL)
and provides a better guarantee on memory allocation.

bpf_local_storage has some uncommon cases that its selem
cannot be reused immediately. It handles its own
rcu_head and goes through a rcu_trace gp and then free it.
bpf_mem_cache_raw_free() is added for direct free purpose
without leaking the LLIST_NODE_SZ internal knowledge.
During free time, the 'struct bpf_mem_alloc *ma' is no longer
available. However, the caller should know if it is
percpu memory or not and it can call different raw_free functions.
bpf_local_storage does not support percpu value, so only
the non-percpu 'bpf_mem_cache_raw_free()' is added in
this patch.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf_mem_alloc.h |  2 ++
 kernel/bpf/memalloc.c         | 59 +++++++++++++++++++++++++++++------
 2 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
index a7104af61ab4..3929be5743f4 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -31,5 +31,7 @@ void bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr);
 /* kmem_cache_alloc/free equivalent: */
 void *bpf_mem_cache_alloc(struct bpf_mem_alloc *ma);
 void bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr);
+void bpf_mem_cache_raw_free(void *ptr);
+void *bpf_mem_cache_alloc_flags(struct bpf_mem_alloc *ma, gfp_t flags);
 
 #endif /* _BPF_MEM_ALLOC_H */
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 5fcdacbb8439..410637c225fb 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -121,15 +121,8 @@ static struct llist_node notrace *__llist_del_first(struct llist_head *head)
 	return entry;
 }
 
-static void *__alloc(struct bpf_mem_cache *c, int node)
+static void *__alloc(struct bpf_mem_cache *c, int node, gfp_t flags)
 {
-	/* Allocate, but don't deplete atomic reserves that typical
-	 * GFP_ATOMIC would do. irq_work runs on this cpu and kmalloc
-	 * will allocate from the current numa node which is what we
-	 * want here.
-	 */
-	gfp_t flags = GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT;
-
 	if (c->percpu_size) {
 		void **obj = kmalloc_node(c->percpu_size, flags, node);
 		void *pptr = __alloc_percpu_gfp(c->unit_size, 8, flags);
@@ -185,7 +178,12 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 		 */
 		obj = __llist_del_first(&c->free_by_rcu);
 		if (!obj) {
-			obj = __alloc(c, node);
+			/* Allocate, but don't deplete atomic reserves that typical
+			 * GFP_ATOMIC would do. irq_work runs on this cpu and kmalloc
+			 * will allocate from the current numa node which is what we
+			 * want here.
+			 */
+			obj = __alloc(c, node, GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT);
 			if (!obj)
 				break;
 		}
@@ -676,3 +674,46 @@ void notrace bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr)
 
 	unit_free(this_cpu_ptr(ma->cache), ptr);
 }
+
+/* Directly does a kfree() without putting 'ptr' back to the free_llist
+ * for reuse and without waiting for a rcu_tasks_trace gp.
+ * The caller must first go through the rcu_tasks_trace gp for 'ptr'
+ * before calling bpf_mem_cache_raw_free().
+ * It could be used when the rcu_tasks_trace callback does not have
+ * a hold on the original bpf_mem_alloc object that allocated the
+ * 'ptr'. This should only be used in the uncommon code path.
+ * Otherwise, the bpf_mem_alloc's free_llist cannot be refilled
+ * and may affect performance.
+ */
+void bpf_mem_cache_raw_free(void *ptr)
+{
+	if (!ptr)
+		return;
+
+	kfree(ptr - LLIST_NODE_SZ);
+}
+
+/* When flags == GFP_KERNEL, it signals that the caller will not cause
+ * deadlock when using kmalloc. bpf_mem_cache_alloc_flags() will use
+ * kmalloc if the free_llist is empty.
+ */
+void notrace *bpf_mem_cache_alloc_flags(struct bpf_mem_alloc *ma, gfp_t flags)
+{
+	struct bpf_mem_cache *c;
+	void *ret;
+
+	c = this_cpu_ptr(ma->cache);
+
+	ret = unit_alloc(c);
+	if (!ret && flags == GFP_KERNEL) {
+		struct mem_cgroup *memcg, *old_memcg;
+
+		memcg = get_memcg(c);
+		old_memcg = set_active_memcg(memcg);
+		ret = __alloc(c, NUMA_NO_NODE, GFP_KERNEL | __GFP_NOWARN | __GFP_ACCOUNT);
+		set_active_memcg(old_memcg);
+		mem_cgroup_put(memcg);
+	}
+
+	return !ret ? NULL : ret + LLIST_NODE_SZ;
+}
-- 
2.34.1

