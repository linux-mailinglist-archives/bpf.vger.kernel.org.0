Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A975AB9F1
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 23:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiIBVMA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Sep 2022 17:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiIBVL7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 17:11:59 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298CDDDAAB
        for <bpf@vger.kernel.org>; Fri,  2 Sep 2022 14:11:58 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso6614803pjh.5
        for <bpf@vger.kernel.org>; Fri, 02 Sep 2022 14:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Pags8qPPfwR6EZ4x9OlF9eTDmuCtBGklMkNVzgvuBVU=;
        b=dt5/tqYKF+8sKq/fRHZyCUDdVjK+DPcHhDtZ6m/chA0Q3MJn9qFWnyvSCWK6/+3yjl
         xj4mdLcEYxjg6L6ZqvGepiFOLXhps7zRiC6QiREiOCP/Zjbnd07p3evGJYAcH6+jq8v+
         RuYHGGYvKhoTTvQZ0i8uouxsdCm2mx4r+UPg8VROTr3RNyNJgI+su8OU7tgqLd2Dse1L
         gzXtjlarLRLSKn06SqHEcD9Ck2eBH4ET3GfOXQcxYMqmG6MUNWs7hi4nzJbH/ysFNezw
         Nvv71ibCORw/xxC0vBXnr//I9BIoEITz3pyBxuPrYWRYoskO+JFYDy97INFruI9YYoWo
         p/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Pags8qPPfwR6EZ4x9OlF9eTDmuCtBGklMkNVzgvuBVU=;
        b=CjnsUdfEUuvQD8Qhn/lYo1Jvy04C0/LborG1FHRGGevCWQBpdZQ4+DD/w45h+dyhNd
         +P/TQpMgn63EtuhnSC5x2Dh8KoGsUKusB5F5ZtNnFab7RUB1OeorLE3HtTwDmMpZec/r
         EqzbxWCN6R8xJStijLwjYnIE6iV6u9xYx3vNfI3Xkm13kZyCl32Wwv+lvelN9Rw8IlZf
         Lm/zyUsAF8IcxMPcvsKjbzKYYWK1h7zZfP9TQ3BWAF8CFsadRFkKr/NXCfJ/Js9fAA1p
         hsY+kZrERPpW8gU1H6yBE8xOd+y+6Ldw/jdM8vi9Z+KkTVPaW60Mr3bXd7VgEUiyB7BS
         jlGw==
X-Gm-Message-State: ACgBeo2nCw6EkrqxQySK9w7akzxi9FswTfAbnXBZ50eClwctG36uPsV4
        eBMDXk3+wCkmg5f+puu49HY=
X-Google-Smtp-Source: AA6agR5nt/10dzw1MEiwQ0MhAY16jQplPyzoS39H0+ktckGNi7GdGsrRpdUU0PcOM1jr5LU9HCCF6Q==
X-Received: by 2002:a17:90a:e4cb:b0:1fd:9626:c7cf with SMTP id e11-20020a17090ae4cb00b001fd9626c7cfmr6945435pju.103.1662153117526;
        Fri, 02 Sep 2022 14:11:57 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::c978])
        by smtp.gmail.com with ESMTPSA id p2-20020a17090a748200b001fb0cf37db1sm5555785pjk.14.2022.09.02.14.11.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Sep 2022 14:11:57 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 15/16] bpf: Remove usage of kmem_cache from bpf_mem_cache.
Date:   Fri,  2 Sep 2022 14:10:57 -0700
Message-Id: <20220902211058.60789-16-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220902211058.60789-1-alexei.starovoitov@gmail.com>
References: <20220902211058.60789-1-alexei.starovoitov@gmail.com>
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
index 8895c016dcdb..38fbd15c130a 100644
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

