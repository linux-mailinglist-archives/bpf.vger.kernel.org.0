Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E867159A7EA
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 23:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiHSVnR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 17:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbiHSVnO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 17:43:14 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DEDFD2
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:43:12 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y4so5164030plb.2
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=MuR2M968m3Rb7scXd/K38G3WpnkvQO3q5t0rZJwN3iE=;
        b=YOv2Wy26SSHNh71HEPW9jbkpq5O9aiHT5H6SJcbnNqdMSCbM/kAYUON8ztUGyBHvk+
         tMdYJsIqz86miajmEDfXzm/GLHUyMxaqfsqMaHXmWAIbDP31WYJXwgTP81aEZg+y/kVN
         eSO6tflHFDv/a1GPm3/Up021xmuWCIC2JKV8UhxD8WHU91TWpzTnLTHOHTONyq1bBJsa
         aSPiqzj5GpabASWecdOhHL+70yUinqGR+ih6OkgDVRwhaaUbIkvmjLya1UG0EXWSm8cN
         Hm6hdBkdQLxXNu2T8L5d7m8InZ+26AC9anjhtutCBcvfn6eG+5GrCjMpchFkSS1BHmJx
         zXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=MuR2M968m3Rb7scXd/K38G3WpnkvQO3q5t0rZJwN3iE=;
        b=WzDAnePtQhFdn9ljQjMUsKtTHgE5F+TD82ISIblLxjvwFbuq9I9oueevJmDv9gwUJ4
         fJmf2CawsGUnXoshWPTOy+9ToXzsekUGqxlLSyUFRGKzaEvt/LfB9fdEWJT46jB9B7Yk
         3jZcZvDwLJw2w7Gtzg8vV/mRtqfXndYBelAqYtKpOUBNmc9D/LWyZ8rOOrgIOthBkVZx
         3Ue4MVPJZ8KHA91NlWabTSiTxUhGZqpp/CZCPkczNZTMIfKVOUxFzOZesloyZv0A62cn
         80Er3exCQAMJ26/PQJgVtIWrfFR/vGll1e/DUbzR1VAjwKFfgcfKzMYsboEz9MgAdeva
         w5Pg==
X-Gm-Message-State: ACgBeo0CZuJnOXl7fpqegHv8NHHPyRYSavpu7xq1eC3EQ3Hsp6ndx5pN
        SrQyvGs0rsFVAdk/b4DwkGY=
X-Google-Smtp-Source: AA6agR5QWH72pEQusZfgDyL322vkzz47reSqzMWcrIDa5nVAtwXw49X5SlB106HKBrWK7vLurxJmrg==
X-Received: by 2002:a17:902:e94c:b0:171:3d5d:2d00 with SMTP id b12-20020a170902e94c00b001713d5d2d00mr8969363pll.2.1660945391835;
        Fri, 19 Aug 2022 14:43:11 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::1:c4b1])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090264cf00b00172a8e628e7sm3620953pli.190.2022.08.19.14.43.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Aug 2022 14:43:11 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 10/15] bpf: Add percpu allocation support to bpf_mem_alloc.
Date:   Fri, 19 Aug 2022 14:42:27 -0700
Message-Id: <20220819214232.18784-11-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
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
index d765a5cb24b4..9e5ad7dc4dc7 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -100,6 +100,7 @@ struct bpf_mem_cache {
 	/* count of objects in free_llist */
 	int free_cnt;
 	int low_watermark, high_watermark, batch;
+	bool percpu;
 
 	struct rcu_head rcu;
 	struct llist_head free_by_rcu;
@@ -132,6 +133,19 @@ static void *__alloc(struct bpf_mem_cache *c, int node)
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
 
@@ -187,6 +201,12 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 
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
@@ -327,21 +347,30 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
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
@@ -354,14 +383,19 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size)
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

