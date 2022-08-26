Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF7D5A1F0F
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 04:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244872AbiHZCpQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 22:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244841AbiHZCpP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 22:45:15 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F8648EB0
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:45:13 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y141so311766pfb.7
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=YZHKbeH8DnXbWPWBMsdiPtaW1ZKeFO8TVBseUASZqVM=;
        b=GpjL7fUxJMG0/zA4mo4xdTv/r1CC2MmWh8AC7pNBP0L30+xpxMGnp4gJg5hUbUSh8M
         PcxqY9cJV/NHV5jRouSevPYwJYvQ4zOPwihjyQfO2HzyBPXNThjHHoQR8c9xD0MtGvLU
         wKmGX9d5HDh2hDH83P3Msz5LMSj+aCBlspPN/m3oW/sW8bA7KNFeqX5KlaH1WgBXvuG0
         xnPYL3d65t6kcG+D32p2p9/17oXtt+70XGAc1o07dDv96/CXktZRxDH3EzrllrlLk22P
         LeXXSPWSITd5r0wv9l9CvxvEwPFKZAtdqnO6Q6+Eqn4DFXAd9l3+sMQ/ZVDzZKXuNTO8
         UDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=YZHKbeH8DnXbWPWBMsdiPtaW1ZKeFO8TVBseUASZqVM=;
        b=GKgbu/J5+Qx/q9HxO1ZiCll9aoMmwqb1oI5DovNZjUytFJ71L7YH9X4reO4Sdt6yzS
         h6Z/ziVsZAXYOZbT8GmR8OLW+UBpCWwbliec4IGWyOltvXrG4QUHrZ4PebNlhZWDVHHi
         c2l8y0XJdPCXcq8R03cqAskOS4UJAcfqAUDBc3SuD1A3zjdGyRKDhvA1SXfuF4as0ZHU
         IB8Up/q6eJeymjdMGDSiA5+5DIkpKNShv03FS7sH6OSxF6Sopfkspc/KjiyPeYZLzw78
         ufIYXKZGoO3HeP3d6Ue4Ja6mvD7EVQdncI9+ykHIEfbmxU2YUBHvQj5AW9w5I3nKlmOW
         Dc/w==
X-Gm-Message-State: ACgBeo3pbP94ygvoDruSDXoGAe/DUJghnimuYaPadUvuLH4/AhKLBCCZ
        xo6hiaEq3YsmHKeOcIFmNpc=
X-Google-Smtp-Source: AA6agR5TGr1wZaD3/psfDBLsZ0Te84G7Qc7MK5kymK0o3fuFIppuFSKhzWWIbyXSWXW5VL+Banlqog==
X-Received: by 2002:a63:e412:0:b0:41d:9c6a:7e with SMTP id a18-20020a63e412000000b0041d9c6a007emr1577624pgi.575.1661481913392;
        Thu, 25 Aug 2022 19:45:13 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:15dc])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090a154100b001fac90ead43sm430265pja.29.2022.08.25.19.45.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Aug 2022 19:45:12 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 10/15] bpf: Add percpu allocation support to bpf_mem_alloc.
Date:   Thu, 25 Aug 2022 19:44:25 -0700
Message-Id: <20220826024430.84565-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
References: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
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
index 299ab98f9811..8daa1132d43c 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -594,7 +594,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 				goto free_prealloc;
 		}
 	} else {
-		err = bpf_mem_alloc_init(&htab->ma, htab->elem_size);
+		err = bpf_mem_alloc_init(&htab->ma, htab->elem_size, false);
 		if (err)
 			goto free_map_locked;
 	}
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 6a252d495f6c..54455a64699b 100644
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
 
@@ -188,6 +202,12 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 
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
@@ -328,21 +348,30 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
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
@@ -355,14 +384,19 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size)
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

