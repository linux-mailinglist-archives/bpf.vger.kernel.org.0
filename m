Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817C55AB9ED
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 23:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiIBVLl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Sep 2022 17:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiIBVLk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 17:11:40 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C532BD91C9
        for <bpf@vger.kernel.org>; Fri,  2 Sep 2022 14:11:39 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id m2so3040417pls.4
        for <bpf@vger.kernel.org>; Fri, 02 Sep 2022 14:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=reguNqpc0/tY/7LivNRuvOsyUpr9xAoESsfpxvrSB0I=;
        b=NqW7voFLIn4KDyudLyWjCqPsQS70vgg1FBUaax0Omj/X8L34xWn4m1Oqldov6DhNk1
         DRikTgVelldUt/5TYCqwiwFP+E19sogjvCN2i/r6IuFzMuPEqK5E+WCcB1T67Jxlad4Q
         /pr8kUheAuzS4wVgo3ShyTCY6NI20wgObu3tb2q11CC36WSJrbYK0O0qYCHgwRya/QyX
         WMyO+f987pMSDF/ikAHg4itsfCE5DABmyZUIEnwDHy6yO/RuFp4i0kQXCldWWuo4/uAn
         US29dVDOUcSAL+sreWvITwKwj4GZpjgmEaEHpI9b3CRy6d5KQf7J6c2JmpFHcL+XiQHR
         cAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=reguNqpc0/tY/7LivNRuvOsyUpr9xAoESsfpxvrSB0I=;
        b=zsaVObe11QbXps+nNuqzmibLbSgESM5C+8f/6UVNYv8e+VRBk0r3r1PGVDZIJAXmiE
         OrFb48AsB1lTzzs4N2OxxopmgeAi9x4Ky2+E0ACUO9VAfBLGedThA53DsPQj8RGCyqCU
         f+DH7fx3koya17DUrbaXpuSjQjlWBAmJXvYTZgNmbDZ9zvOC2eptGTM1Il5peprW7aJP
         SfBeJZL6SefKVA6NfSBPIbwNFiFJzpLAZqDRagGV5Hc8OCh/Oi5gsWCc+7MwIvkclCy0
         a8msmR5jVHbYCsi3j3SVbUgJYEMinvXSgDODG9KhlPL7vo9s6V1yhYfg3nFA3P3MHoLX
         xmeg==
X-Gm-Message-State: ACgBeo348MJZwJAO/IvVq1JMpvyfkCEjzb5KFDODjxynSwjuHjRQIT1h
        X74/092zjhKF6Vas++2xkVY6oN6/opo=
X-Google-Smtp-Source: AA6agR58oow/Qu5gcVVaFEZHA7FIbwUtgpktlxwu81c/wARfg0WqWLFJRObHjEPbcDqYMZwzmUYc2A==
X-Received: by 2002:a17:902:ccc9:b0:174:de2b:b19a with SMTP id z9-20020a170902ccc900b00174de2bb19amr24105969ple.100.1662153099200;
        Fri, 02 Sep 2022 14:11:39 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::c978])
        by smtp.gmail.com with ESMTPSA id i9-20020a170902c94900b001637529493esm2120483pla.66.2022.09.02.14.11.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Sep 2022 14:11:38 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 10/16] bpf: Add percpu allocation support to bpf_mem_alloc.
Date:   Fri,  2 Sep 2022 14:10:52 -0700
Message-Id: <20220902211058.60789-11-alexei.starovoitov@gmail.com>
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
index 5d8648a01b5c..f7b07787581b 100644
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

