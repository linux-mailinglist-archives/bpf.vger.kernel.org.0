Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7495A9CE2
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 18:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiIAQQe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 12:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbiIAQQa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 12:16:30 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D34B564C5
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 09:16:29 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 78so3333005pgb.13
        for <bpf@vger.kernel.org>; Thu, 01 Sep 2022 09:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=On4mfWGsobRP6ONryR+3hJNZx943vy0r81zwFWx6UsI=;
        b=T1sMyAz2k+jwEJIpB0VpRg7rB3qTe5n4xNysUkR5nSPzNQKpZqVLu36ORZ5JZNXW3O
         KS7vMyV4R316Ad1qMOO26qdItT7uQqZ+pIDqGb1SDxs66wuYb0rHPlboxJnzzbx5N7mr
         tOcW5HREfybg9yJojmiaESNXlxD+T8+PtaKYpwd8ZDF6kar1hU2035jQqnWbGWEA89E1
         U/jqPHROp1Y8pYOhYgj/KGKgxkfVD1YohXrHcGzeEKeixYMI+zV8MqoJ8LVZxN8xyzYz
         NOy5mjrQPqr/yrI+5dbrpb5hKEo+QgjGkQTURcW/IcH+j2ysWBke1z5f9tery71FnjTw
         xmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=On4mfWGsobRP6ONryR+3hJNZx943vy0r81zwFWx6UsI=;
        b=ek44Lpkv8Bsptu9E0wCqfNJ21dV36lhsXw9YyuFBwSZgicy+PU7jBVMby7NUO1soBL
         4vDolYd3+wvrp+Pu6sKTEUtWTKP8Zg1W+3NhMW8/CGq+qLJupocr47b9kv2R1saHwo5q
         wiBxxgBhya22syuxvSbU+nmOfdIRCmzhD8yIKvEhxchgUP6D6Z+0G1vbhUfF2XGSOJ77
         iMNZTlEa69JTxVmy9mmIZVl851XDU8auyZiKWbSnKwxVzbWTKNjFjeOSooKWtkPRL2tZ
         PSwzhjPeeGLicoqWGbsyiVp23abBuk7xJEqsH9K39FUwqn80cLTs22255H/PzC/JSKnM
         y5zg==
X-Gm-Message-State: ACgBeo0zPKHxMIOB09DsEbgFHfuWto20/0iNa5eGYDPKCPA3SK2lofop
        WM+q2z9zLdotGpguHmknsng=
X-Google-Smtp-Source: AA6agR5hn1NCP3rD30mFOoRnelDRFSF3qxYhNnbb2SnXTclQjNnqwkhxo3/Ihlo5427fZxzV4Jt7Yg==
X-Received: by 2002:aa7:9019:0:b0:535:fb2e:4ae9 with SMTP id m25-20020aa79019000000b00535fb2e4ae9mr31639571pfo.72.1662048988822;
        Thu, 01 Sep 2022 09:16:28 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::3:4dc5])
        by smtp.gmail.com with ESMTPSA id b14-20020aa78ece000000b0052d98fbf8f3sm13648940pfr.56.2022.09.01.09.16.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Sep 2022 09:16:28 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 10/15] bpf: Add percpu allocation support to bpf_mem_alloc.
Date:   Thu,  1 Sep 2022 09:15:42 -0700
Message-Id: <20220901161547.57722-11-alexei.starovoitov@gmail.com>
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

Extend bpf_mem_alloc to cache free list of fixed size per-cpu allocations.
Once such cache is created bpf_mem_cache_alloc() will return per-cpu objects.
bpf_mem_cache_free() will free them back into global per-cpu pool after
observing RCU grace period.
per-cpu flavor of bpf_mem_alloc is going to be used by per-cpu hash maps.

The free list cache consists of tuples { llist_node, per-cpu pointer }
Unlike alloc_percpu() that returns per-cpu pointer
the bpf_mem_cache_alloc() returns a pointer to per-cpu pointer and
bpf_mem_cache_free() expects to receive it back.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_mem_alloc.h |  2 +-
 kernel/bpf/hashtab.c          |  2 +-
 kernel/bpf/memalloc.c         | 44 +++++++++++++++++++++++++++++++----
 3 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
index 804733070f8d..653ed1584a03 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -12,7 +12,7 @@ struct bpf_mem_alloc {
 	struct bpf_mem_cache __percpu *cache;
 };
 
-int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size);
+int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu);
 void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma);
 
 /* kmalloc/kfree equivalent: */
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 0d888a90a805..70b02ff4445e 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -607,7 +607,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 				goto free_prealloc;
 		}
 	} else {
-		err = bpf_mem_alloc_init(&htab->ma, htab->elem_size);
+		err = bpf_mem_alloc_init(&htab->ma, htab->elem_size, false);
 		if (err)
 			goto free_map_locked;
 	}
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 2d553f91e8ab..967ccd02ecb8 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -101,6 +101,7 @@ struct bpf_mem_cache {
 	/* count of objects in free_llist */
 	int free_cnt;
 	int low_watermark, high_watermark, batch;
+	bool percpu;
 
 	struct rcu_head rcu;
 	struct llist_head free_by_rcu;
@@ -133,6 +134,19 @@ static void *__alloc(struct bpf_mem_cache *c, int node)
 	 */
 	gfp_t flags = GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT;
 
+	if (c->percpu) {
+		void **obj = kmem_cache_alloc_node(c->kmem_cache, flags, node);
+		void *pptr = __alloc_percpu_gfp(c->unit_size, 8, flags);
+
+		if (!obj || !pptr) {
+			free_percpu(pptr);
+			kfree(obj);
+			return NULL;
+		}
+		obj[1] = pptr;
+		return obj;
+	}
+
 	if (c->kmem_cache)
 		return kmem_cache_alloc_node(c->kmem_cache, flags, node);
 
@@ -193,6 +207,12 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 
 static void free_one(struct bpf_mem_cache *c, void *obj)
 {
+	if (c->percpu) {
+		free_percpu(((void **)obj)[1]);
+		kmem_cache_free(c->kmem_cache, obj);
+		return;
+	}
+
 	if (c->kmem_cache)
 		kmem_cache_free(c->kmem_cache, obj);
 	else
@@ -332,21 +352,30 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
  * kmalloc/kfree. Max allocation size is 4096 in this case.
  * This is bpf_dynptr and bpf_kptr use case.
  */
-int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size)
+int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 {
 	static u16 sizes[NUM_CACHES] = {96, 192, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096};
 	struct bpf_mem_caches *cc, __percpu *pcc;
 	struct bpf_mem_cache *c, __percpu *pc;
-	struct kmem_cache *kmem_cache;
+	struct kmem_cache *kmem_cache = NULL;
 	struct obj_cgroup *objcg = NULL;
 	char buf[32];
-	int cpu, i;
+	int cpu, i, unit_size;
 
 	if (size) {
 		pc = __alloc_percpu_gfp(sizeof(*pc), 8, GFP_KERNEL);
 		if (!pc)
 			return -ENOMEM;
-		size += LLIST_NODE_SZ; /* room for llist_node */
+
+		if (percpu) {
+			unit_size = size;
+			/* room for llist_node and per-cpu pointer */
+			size = LLIST_NODE_SZ + sizeof(void *);
+		} else {
+			size += LLIST_NODE_SZ; /* room for llist_node */
+			unit_size = size;
+		}
+
 		snprintf(buf, sizeof(buf), "bpf-%u", size);
 		kmem_cache = kmem_cache_create(buf, size, 8, 0, NULL);
 		if (!kmem_cache) {
@@ -359,14 +388,19 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size)
 		for_each_possible_cpu(cpu) {
 			c = per_cpu_ptr(pc, cpu);
 			c->kmem_cache = kmem_cache;
-			c->unit_size = size;
+			c->unit_size = unit_size;
 			c->objcg = objcg;
+			c->percpu = percpu;
 			prefill_mem_cache(c, cpu);
 		}
 		ma->cache = pc;
 		return 0;
 	}
 
+	/* size == 0 && percpu is an invalid combination */
+	if (WARN_ON_ONCE(percpu))
+		return -EINVAL;
+
 	pcc = __alloc_percpu_gfp(sizeof(*cc), 8, GFP_KERNEL);
 	if (!pcc)
 		return -ENOMEM;
-- 
2.30.2

