Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE475A1F0E
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 04:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244868AbiHZCpP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 22:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244883AbiHZCpL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 22:45:11 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1084F3056F
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:45:10 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 12so225223pga.1
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DLuVXLyugXNmDkaT6x9Z+sGpdk504mjgrnnpI5+GSfs=;
        b=SaMjqA/EJ4sqTT4znEEVoD5upYYaeTntE/mLt70FVwVDSh7+tZje0VpRemiyFBBP5l
         y3CS7cNqz5TLZYcYMmCEmnCqg/oA3QPRiHFYU+YKQxZA8LFsNyXkHtPN+7dtIWvKhauw
         GwMpMJfvuOajU4uOnflKeksgGeG68H1zjsbaVTJePxIsykTWu5DOngeyYkMewVfe+DSW
         04JjzB161d8iEXzNg5tp2cZx676C3hXr8VfXq6Gg16CKLyMOMyI4kjjbYeJKeU6aFHzM
         3Xzu7PRyi8hl+fnM2mOq9zhM/hAQ6/VHpgFfc67Wn5sdix9TPH9mbWo2u5lR2gYETRug
         cugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DLuVXLyugXNmDkaT6x9Z+sGpdk504mjgrnnpI5+GSfs=;
        b=cR6LKXM+cIN/2o1DDZofE4yhrpNG2iBUbv5hJx8AlkkDtzZ0qBTIte2coTcMAK2obX
         QoAfz3eOyK0jTUIeWzWrwc4gkxTAsXOsmIfYS+Xb0AeudmjULfl4iTBspC7z17P4WRDV
         IEPVEizJLlhKUk79txQgr+FGJR6DbiMSyljo7tCZ9546EpmLxxbqzRL5kyGPDqrbfjvP
         LsQr4buc83xeLIucnuxahJsE23kz3BC8Opnq+OU+JiwXJS1e0OySyAScG1LIUYB/WCyh
         zFi076cCHlDl2mU55W/qaxDzGOy6S8eAv0+CpmKcrx2sFfMiWrGgHj5D5pnYfAbJagSX
         +OLQ==
X-Gm-Message-State: ACgBeo2CDHDC/eA80kGzn2prdlkFiWVlWAcTNKRu79MUYOYWho8KFc34
        70mgga+EzBfsVurXjnjztS2cxWFjhIY=
X-Google-Smtp-Source: AA6agR6hEqTs/xcMDgH3Ie5la1+xlWrCI/6kyg12tYh5U5u47HDLCZ+6/V1SYLdABwEaJrN8BGlVKw==
X-Received: by 2002:a65:60d4:0:b0:419:9871:9cf with SMTP id r20-20020a6560d4000000b00419987109cfmr1609101pgv.214.1661481909479;
        Thu, 25 Aug 2022 19:45:09 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:15dc])
        by smtp.gmail.com with ESMTPSA id k10-20020a63d10a000000b003fdc16f5de2sm293401pgg.15.2022.08.25.19.45.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Aug 2022 19:45:09 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 09/15] bpf: Batch call_rcu callbacks instead of SLAB_TYPESAFE_BY_RCU.
Date:   Thu, 25 Aug 2022 19:44:24 -0700
Message-Id: <20220826024430.84565-10-alexei.starovoitov@gmail.com>
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

SLAB_TYPESAFE_BY_RCU makes kmem_caches non mergeable and slows down
kmem_cache_destroy. All bpf_mem_cache are safe to share across different maps
and programs. Convert SLAB_TYPESAFE_BY_RCU to batched call_rcu. This change
solves the memory consumption issue, avoids kmem_cache_destroy latency and
keeps bpf hash map performance the same.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 64 +++++++++++++++++++++++++++++++++++++++++--
 kernel/bpf/syscall.c  |  5 +++-
 2 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 775c38132c4d..6a252d495f6c 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -101,6 +101,11 @@ struct bpf_mem_cache {
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
@@ -189,6 +194,45 @@ static void free_one(struct bpf_mem_cache *c, void *obj)
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
@@ -208,12 +252,13 @@ static void free_bulk(struct bpf_mem_cache *c)
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
@@ -299,7 +344,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size)
 			return -ENOMEM;
 		size += LLIST_NODE_SZ; /* room for llist_node */
 		snprintf(buf, sizeof(buf), "bpf-%u", size);
-		kmem_cache = kmem_cache_create(buf, size, 8, SLAB_TYPESAFE_BY_RCU, NULL);
+		kmem_cache = kmem_cache_create(buf, size, 8, 0, NULL);
 		if (!kmem_cache) {
 			free_percpu(pc);
 			return -ENOMEM;
@@ -341,6 +386,15 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
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
@@ -362,6 +416,10 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
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
index 4e9d4622aef7..074c901fbb4e 100644
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

