Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CBB5A9CE7
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 18:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbiIAQQv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 12:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiIAQQt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 12:16:49 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9183AB00
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 09:16:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y141so17936962pfb.7
        for <bpf@vger.kernel.org>; Thu, 01 Sep 2022 09:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=RA+4cm8zTpkfrIIbrm6JTzVBZhwl0jvK9mFgoA+gZ08=;
        b=WTDm9cN/MTqNosWApeqoRFwUMxQyt6sycnu78tWJQwstlz38nDKFyySWLHO5dKtET9
         4whPCzAXqPRoMzIO7LkjN7mboj4noKPcK3mtoyJZKOAHNRduA+pxxbXKYq4pylv3DC2D
         mUa++3IXnukgBwpjXSjjvKLRIAPuKSkEGicExeqt/pFAaDNOQ/cesXm8ap3N9cGxUYHT
         c0qCevyjPJ0QJzYL44H4cdsleZyICbOJD09gGzrI/KDcjEgIUkMX19uDF6kMNglQAZ1W
         5S/UZujb2eQshskl3Ty1i52u49DXD0MFQ0yetcSKHuZePNX0J2zqR5KRv7Gu9oh2Uj7A
         q73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=RA+4cm8zTpkfrIIbrm6JTzVBZhwl0jvK9mFgoA+gZ08=;
        b=g6oiaUwt9LzF2+Dj+JAuckLhXjsSieCoK4I4nDs6LVapFD5/Q8DoTqUPrK3UJsSFlD
         XiCeHGVQMfdjDkx5l5S5cMXTqXH9m5I9Ci6dZBxKo4EsmwnABHZN0jkvU3urL1P9wTK0
         t8TeNgxktLCarcBovqbNzykt1EjaiSuPnXx1CqM4zhIdHNMa+8P1KvAO9YI4LWrgMDvn
         FwpcQs4DMITBbzcX/sL3HqIEtlndINoJ2t4ntcZ53EAhXzu1Q3VjeRobBYAQ4WIlsBdH
         gnbD9PI5Xp7qMRFQhWCYOKc1yoiXlxD2PQEVZSqg3BMrcDoeAkqscRwlKMRz0G6EJ3l9
         uBfA==
X-Gm-Message-State: ACgBeo0OhJ+GAeh8boxJn9Fm/9gE5wMC4pQDI49hi1WteahJg2YgwVVd
        6ETvHRKZ0VVgiNcJrlb0gGo=
X-Google-Smtp-Source: AA6agR6S/k89hEnQD77ag437aMY6R0fRShGYmVk3f/U2AnuECyQjbGfyShiEGwHyyEams6FPoNEAwQ==
X-Received: by 2002:a63:69c7:0:b0:41c:590a:62dc with SMTP id e190-20020a6369c7000000b0041c590a62dcmr25912489pgc.388.1662049007352;
        Thu, 01 Sep 2022 09:16:47 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::3:4dc5])
        by smtp.gmail.com with ESMTPSA id x18-20020aa78f12000000b0053788e9f865sm13448812pfr.21.2022.09.01.09.16.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Sep 2022 09:16:46 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 15/15] bpf: Remove usage of kmem_cache from bpf_mem_cache.
Date:   Thu,  1 Sep 2022 09:15:47 -0700
Message-Id: <20220901161547.57722-16-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901161547.57722-1-alexei.starovoitov@gmail.com>
References: <20220901161547.57722-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

For bpf_mem_cache based hash maps the following stress test:
for (i = 1; i <= 512; i <<= 1)
  for (j = 1; j <= 1 << 18; j <<= 1)
    fd = bpf_map_create(BPF_MAP_TYPE_HASH, NULL, i, j, 2, 0);
creates many kmem_cache-s that are not mergeable in debug kernels
and consume unnecessary amount of memory.
Turned out bpf_mem_cache's free_list logic does batching well,
so usage of kmem_cache for fixes size allocations doesn't bring
any performance benefits vs normal kmalloc.
Hence get rid of kmem_cache in bpf_mem_cache.
That saves memory, speeds up map create/destroy operations,
while maintains hash map update/delete performance.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 50 ++++++++++++-------------------------------
 1 file changed, 14 insertions(+), 36 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index a66bca8caddf..00757b6fb294 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -91,17 +91,13 @@ struct bpf_mem_cache {
 	 */
 	struct llist_head free_llist_extra;
 
-	/* kmem_cache != NULL when bpf_mem_alloc was created for specific
-	 * element size.
-	 */
-	struct kmem_cache *kmem_cache;
 	struct irq_work refill_work;
 	struct obj_cgroup *objcg;
 	int unit_size;
 	/* count of objects in free_llist */
 	int free_cnt;
 	int low_watermark, high_watermark, batch;
-	bool percpu;
+	int percpu_size;
 
 	struct rcu_head rcu;
 	struct llist_head free_by_rcu;
@@ -134,8 +130,8 @@ static void *__alloc(struct bpf_mem_cache *c, int node)
 	 */
 	gfp_t flags = GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT;
 
-	if (c->percpu) {
-		void **obj = kmem_cache_alloc_node(c->kmem_cache, flags, node);
+	if (c->percpu_size) {
+		void **obj = kmalloc_node(c->percpu_size, flags, node);
 		void *pptr = __alloc_percpu_gfp(c->unit_size, 8, flags);
 
 		if (!obj || !pptr) {
@@ -147,9 +143,6 @@ static void *__alloc(struct bpf_mem_cache *c, int node)
 		return obj;
 	}
 
-	if (c->kmem_cache)
-		return kmem_cache_alloc_node(c->kmem_cache, flags, node);
-
 	return kmalloc_node(c->unit_size, flags, node);
 }
 
@@ -207,16 +200,13 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 
 static void free_one(struct bpf_mem_cache *c, void *obj)
 {
-	if (c->percpu) {
+	if (c->percpu_size) {
 		free_percpu(((void **)obj)[1]);
-		kmem_cache_free(c->kmem_cache, obj);
+		kfree(obj);
 		return;
 	}
 
-	if (c->kmem_cache)
-		kmem_cache_free(c->kmem_cache, obj);
-	else
-		kfree(obj);
+	kfree(obj);
 }
 
 static void __free_rcu(struct rcu_head *head)
@@ -356,7 +346,7 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
 	alloc_bulk(c, c->unit_size <= 256 ? 4 : 1, cpu_to_node(cpu));
 }
 
-/* When size != 0 create kmem_cache and bpf_mem_cache for each cpu.
+/* When size != 0 bpf_mem_cache for each cpu.
  * This is typical bpf hash map use case when all elements have equal size.
  *
  * When size == 0 allocate 11 bpf_mem_cache-s for each cpu, then rely on
@@ -368,40 +358,29 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 	static u16 sizes[NUM_CACHES] = {96, 192, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096};
 	struct bpf_mem_caches *cc, __percpu *pcc;
 	struct bpf_mem_cache *c, __percpu *pc;
-	struct kmem_cache *kmem_cache = NULL;
 	struct obj_cgroup *objcg = NULL;
-	char buf[32];
-	int cpu, i, unit_size;
+	int cpu, i, unit_size, percpu_size = 0;
 
 	if (size) {
 		pc = __alloc_percpu_gfp(sizeof(*pc), 8, GFP_KERNEL);
 		if (!pc)
 			return -ENOMEM;
 
-		if (percpu) {
-			unit_size = size;
+		if (percpu)
 			/* room for llist_node and per-cpu pointer */
-			size = LLIST_NODE_SZ + sizeof(void *);
-		} else {
+			percpu_size = LLIST_NODE_SZ + sizeof(void *);
+		else
 			size += LLIST_NODE_SZ; /* room for llist_node */
-			unit_size = size;
-		}
+		unit_size = size;
 
-		snprintf(buf, sizeof(buf), "bpf-%u", size);
-		kmem_cache = kmem_cache_create(buf, size, 8, 0, NULL);
-		if (!kmem_cache) {
-			free_percpu(pc);
-			return -ENOMEM;
-		}
 #ifdef CONFIG_MEMCG_KMEM
 		objcg = get_obj_cgroup_from_current();
 #endif
 		for_each_possible_cpu(cpu) {
 			c = per_cpu_ptr(pc, cpu);
-			c->kmem_cache = kmem_cache;
 			c->unit_size = unit_size;
 			c->objcg = objcg;
-			c->percpu = percpu;
+			c->percpu_size = percpu_size;
 			prefill_mem_cache(c, cpu);
 		}
 		ma->cache = pc;
@@ -461,8 +440,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 			c = per_cpu_ptr(ma->cache, cpu);
 			drain_mem_cache(c);
 		}
-		/* kmem_cache and memcg are the same across cpus */
-		kmem_cache_destroy(c->kmem_cache);
+		/* objcg is the same across cpus */
 		if (c->objcg)
 			obj_cgroup_put(c->objcg);
 		/* c->waiting_for_gp list was drained, but __free_rcu might
-- 
2.30.2

