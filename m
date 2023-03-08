Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D96A6AFF58
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 08:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCHHA2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 02:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjCHHAY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 02:00:24 -0500
Received: from out-58.mta1.migadu.com (out-58.mta1.migadu.com [IPv6:2001:41d0:203:375::3a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60568A218E
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 23:00:21 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678258819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=351ZpZlhM7SutkaPfgU8DOPT+9VscI+yMj1ri9KaRVg=;
        b=p64eOYda806ukkfDcc5T2MoUSRvLdCOaY/Fsb957m3LHrFs0YtE3lac0lGNzKQxgqqWtmw
        2uiykq4sbMvYegRbSf1IdncEAEPs/PmmpY/eIOqubGZAE4V/2Bk7cPi6GX0B/KbFOk/I5d
        qwwDtApHozMMMxnm2ym15i/Z82zP6mU=
From:   Martin KaFai Lau <martin.lau@linux.dev>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
Subject: [PATCH v2 bpf-next 12/17] bpf: Add a few bpf mem allocator functions
Date:   Tue,  7 Mar 2023 22:59:31 -0800
Message-Id: <20230308065936.1550103-13-martin.lau@linux.dev>
In-Reply-To: <20230308065936.1550103-1-martin.lau@linux.dev>
References: <20230308065936.1550103-1-martin.lau@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 kernel/bpf/memalloc.c         | 42 +++++++++++++++++++++++++++--------
 2 files changed, 35 insertions(+), 9 deletions(-)

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
index 5fcdacbb8439..2b78eed27c9c 100644
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
@@ -676,3 +674,29 @@ void notrace bpf_mem_cache_free(struct bpf_mem_alloc *ma, void *ptr)
 
 	unit_free(this_cpu_ptr(ma->cache), ptr);
 }
+
+void bpf_mem_cache_raw_free(void *ptr)
+{
+	kfree(ptr - LLIST_NODE_SZ);
+}
+
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

