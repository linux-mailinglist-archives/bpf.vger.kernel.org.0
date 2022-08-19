Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA8D59A7E7
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 23:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiHSVnQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 17:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiHSVnK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 17:43:10 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111A5111C18
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:43:08 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id a22so5399165pfg.3
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 14:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=/LUlIl8/5rbkJ1GhT0HIpYGvpg/iLs+2Zu7ChkNbcZY=;
        b=noM6NjPmtdgPGNZpJxNJ4NTplHUPKy9WIfXxStlcvWXDRZs+iivdCrHx3TjgyXRdAC
         AMFHv549t4qk2SgUbX6S8xfkf2DU6O/2qPkS5EKdb13AAkiEBToMiuZBM6wsa8hQ3IR9
         oshhzgInuWKervtLgCDdfPqYNpa6gP1WoSS+xn3aUiK2A4BZFkyCjEqWT6le7apA1wge
         NgcQrh/rsEc3Bf1rLK8vNa7Dt3OwZVbCgxKvTq2UIII4W+bk4BWiLS/V34n1O1q0eSwN
         Y5NswloYL61b4qo8TrEpReA2+AoJMK1+lGA3/N4DN284N+ZBPt2dGdajMqdffLVwzOFB
         qlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=/LUlIl8/5rbkJ1GhT0HIpYGvpg/iLs+2Zu7ChkNbcZY=;
        b=U30Rz/aD6fhdumn+rtXL74GJv4BYTJ6CIqm3W3VkAX5Q1WuxcZdGnIdGWaCPTR5iuD
         eF3FWhsJK3dFchg7Aj4bJZk3sR7gxoU5MDie3fzvg4k/lfGADns7NGNAl346c47n6tDK
         VXLQRxZmu+nuYJhzrtv4WUJckCus/9PJnik72abHUaSGRadIcKEWEveQxFFDQVHbHdJa
         M3lJkeSkmfVkZUTep8hngPgECCoBRnzU7q9HVLLX5hm6l08Lg4EpUzEUvs5KNLQNB/Sy
         yGhVIO5+/JSQH82lwI3CfjwdSY2YLd5lUH5C1hj4Tlx/mwCq8XhCCavwBZ7Z4vh8qPIH
         NEMQ==
X-Gm-Message-State: ACgBeo3bOK5P1m5RC33f2WC8Ekl3HqOz+g5RGYFTFJ3NApF3qetLl59z
        24f8aKGlWQGOkLy07z//4pY=
X-Google-Smtp-Source: AA6agR5LcCM9K7nbcsM4+E2/yf+LAM29F8RtUacOiamCyVK/Dsdv8chGlwYQE4X191qckGVe0hZnHw==
X-Received: by 2002:a65:6385:0:b0:429:f03c:d5e with SMTP id h5-20020a656385000000b00429f03c0d5emr7817818pgv.322.1660945388255;
        Fri, 19 Aug 2022 14:43:08 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::1:c4b1])
        by smtp.gmail.com with ESMTPSA id r18-20020aa79ed2000000b0052d4cb47339sm3884576pfq.151.2022.08.19.14.43.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Aug 2022 14:43:07 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 bpf-next 09/15] bpf: Batch call_rcu callbacks instead of SLAB_TYPESAFE_BY_RCU.
Date:   Fri, 19 Aug 2022 14:42:26 -0700
Message-Id: <20220819214232.18784-10-alexei.starovoitov@gmail.com>
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

SLAB_TYPESAFE_BY_RCU makes kmem_caches non mergeable and slows down
kmem_cache_destroy. All bpf_mem_cache are safe to share across different maps
and programs. Convert SLAB_TYPESAFE_BY_RCU to batched call_rcu. This change
solves the memory consumption issue, avoids kmem_cache_destroy latency and
keeps bpf hash map performance the same.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 64 +++++++++++++++++++++++++++++++++++++++++--
 kernel/bpf/syscall.c  |  5 +++-
 2 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 22b729914afe..d765a5cb24b4 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -100,6 +100,11 @@ struct bpf_mem_cache {
 	/* count of objects in free_llist */
 	int free_cnt;
 	int low_watermark, high_watermark, batch;
+
+	struct rcu_head rcu;
+	struct llist_head free_by_rcu;
+	struct llist_head waiting_for_gp;
+	atomic_t call_rcu_in_progress;
 };
 
 struct bpf_mem_caches {
@@ -188,6 +193,45 @@ static void free_one(struct bpf_mem_cache *c, void *obj)
 		kfree(obj);
 }
 
+static void __free_rcu(struct rcu_head *head)
+{
+	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
+	struct llist_node *llnode = llist_del_all(&c->waiting_for_gp);
+	struct llist_node *pos, *t;
+
+	llist_for_each_safe(pos, t, llnode)
+		free_one(c, pos);
+	atomic_set(&c->call_rcu_in_progress, 0);
+}
+
+static void enque_to_free(struct bpf_mem_cache *c, void *obj)
+{
+	struct llist_node *llnode = obj;
+
+	/* bpf_mem_cache is a per-cpu object. Freeing happens in irq_work.
+	 * Nothing races to add to free_by_rcu list.
+	 */
+	__llist_add(llnode, &c->free_by_rcu);
+}
+
+static void do_call_rcu(struct bpf_mem_cache *c)
+{
+	struct llist_node *llnode, *t;
+
+	if (atomic_xchg(&c->call_rcu_in_progress, 1))
+		return;
+
+	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp));
+	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_by_rcu))
+		/* There is no concurrent __llist_add(waiting_for_gp) access.
+		 * It doesn't race with llist_del_all either.
+		 * But there could be two concurrent llist_del_all(waiting_for_gp):
+		 * from __free_rcu() and from drain_mem_cache().
+		 */
+		__llist_add(llnode, &c->waiting_for_gp);
+	call_rcu(&c->rcu, __free_rcu);
+}
+
 static void free_bulk(struct bpf_mem_cache *c)
 {
 	struct llist_node *llnode, *t;
@@ -207,12 +251,13 @@ static void free_bulk(struct bpf_mem_cache *c)
 		local_dec(&c->active);
 		if (IS_ENABLED(CONFIG_PREEMPT_RT))
 			local_irq_restore(flags);
-		free_one(c, llnode);
+		enque_to_free(c, llnode);
 	} while (cnt > (c->high_watermark + c->low_watermark) / 2);
 
 	/* and drain free_llist_extra */
 	llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra))
-		free_one(c, llnode);
+		enque_to_free(c, llnode);
+	do_call_rcu(c);
 }
 
 static void bpf_mem_refill(struct irq_work *work)
@@ -298,7 +343,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size)
 			return -ENOMEM;
 		size += LLIST_NODE_SZ; /* room for llist_node */
 		snprintf(buf, sizeof(buf), "bpf-%u", size);
-		kmem_cache = kmem_cache_create(buf, size, 8, SLAB_TYPESAFE_BY_RCU, NULL);
+		kmem_cache = kmem_cache_create(buf, size, 8, 0, NULL);
 		if (!kmem_cache) {
 			free_percpu(pc);
 			return -ENOMEM;
@@ -340,6 +385,15 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 {
 	struct llist_node *llnode, *t;
 
+	/* The caller has done rcu_barrier() and no progs are using this
+	 * bpf_mem_cache, but htab_map_free() called bpf_mem_cache_free() for
+	 * all remaining elements and they can be in free_by_rcu or in
+	 * waiting_for_gp lists, so drain those lists now.
+	 */
+	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_by_rcu))
+		free_one(c, llnode);
+	llist_for_each_safe(llnode, t, llist_del_all(&c->waiting_for_gp))
+		free_one(c, llnode);
 	llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist))
 		free_one(c, llnode);
 	llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra))
@@ -361,6 +415,10 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 		kmem_cache_destroy(c->kmem_cache);
 		if (c->objcg)
 			obj_cgroup_put(c->objcg);
+		/* c->waiting_for_gp list was drained, but __free_rcu might
+		 * still execute. Wait for it now before we free 'c'.
+		 */
+		rcu_barrier();
 		free_percpu(ma->cache);
 		ma->cache = NULL;
 	}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a4d40d98428a..850270a72350 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -638,7 +638,10 @@ static void __bpf_map_put(struct bpf_map *map, bool do_idr_lock)
 		bpf_map_free_id(map, do_idr_lock);
 		btf_put(map->btf);
 		INIT_WORK(&map->work, bpf_map_free_deferred);
-		schedule_work(&map->work);
+		/* Avoid spawning kworkers, since they all might contend
+		 * for the same mutex like slab_mutex.
+		 */
+		queue_work(system_unbound_wq, &map->work);
 	}
 }
 
-- 
2.30.2

