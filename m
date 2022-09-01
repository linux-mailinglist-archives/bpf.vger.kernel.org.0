Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229935A9CE1
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 18:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbiIAQQd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 12:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbiIAQQ2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 12:16:28 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196444D155
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 09:16:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q3so14380810pjg.3
        for <bpf@vger.kernel.org>; Thu, 01 Sep 2022 09:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=E3IIcfWIiXxIzRfH4Teq4SGpQHcE0DFK2pxedM/bi6U=;
        b=h4JxG7EHWn6gH8d4PdDXt93tPoarHykZl4ZEXHul5DEiamHC1+eXWVXNtWcikU3M4S
         2M9o16QqcAot2+Ho8M7PnCOfKMWU2MqsBz4wzI1xanRveUEM5bFZdV2M4PVys8svt++j
         8IVsqyfuf5//I6YAz8nOIsySmqUbVBWu1hnilNEott4t9BKTYuvilWJm4iv9mKE3lfVh
         JxuQKuaKEWWCBtMWvBGEVYfRMIU30sTUoybgCqTbbiDfRFtCEEhVzp9wpHAExO3y1rsF
         vez+mdNe84EtvIR/0iWjhv9rgmQMWcXD3B9V2vzZM98tNZJUTVuEimIb2GZGca5FpDXq
         jGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=E3IIcfWIiXxIzRfH4Teq4SGpQHcE0DFK2pxedM/bi6U=;
        b=180rArFkSdBvrshw/XzkXdxaVCXcQ/cnEQr9SNea/B1Ap9TKFSXJG0eMFn6xUIL6E2
         B0smbNAEQHzcBVucCCHnDrSAvAYWMP2p68WY7O2PoPg2+tqP74+/FRVyzzqv4QIdaN+M
         ugGAjy83XeP3MuJdv1nzL3J8uU7bLZ/hIaotV1dxLABsD5VaeX6OWCkFwKmfCEuL18GU
         MRH3fbEXiKXnf1if9X3HJx8HI0Bt8RJ3WplBniz62/u4nCeKrGa5B1/6IMPdrnU95Tux
         X1lLoIvo1nMxn5Cy8mQk7bNQmg6UQEFPchCjq2G3ecCLHYvRpQrg2+kEVAJHGJvyJHeT
         OPJQ==
X-Gm-Message-State: ACgBeo0VmZCUMs8l5M9sjZuAg0de/wPTgXt2mFsz4jQGc45gFhJUNCkw
        7VJUB0UQ+RmKAnlF+lD/zTA=
X-Google-Smtp-Source: AA6agR5tqpqxI4VRqofU2G1ViiKFvtf6aVOiu/vbk+25507IFBS9pJ58KZllVhU0kz66Ljt/6v0gbw==
X-Received: by 2002:a17:902:b408:b0:175:4641:ee97 with SMTP id x8-20020a170902b40800b001754641ee97mr7607531plr.140.1662048985139;
        Thu, 01 Sep 2022 09:16:25 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::3:4dc5])
        by smtp.gmail.com with ESMTPSA id 35-20020a630d63000000b0042a55fb60bbsm5455027pgn.28.2022.09.01.09.16.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Sep 2022 09:16:24 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 09/15] bpf: Batch call_rcu callbacks instead of SLAB_TYPESAFE_BY_RCU.
Date:   Thu,  1 Sep 2022 09:15:41 -0700
Message-Id: <20220901161547.57722-10-alexei.starovoitov@gmail.com>
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

SLAB_TYPESAFE_BY_RCU makes kmem_caches non mergeable and slows down
kmem_cache_destroy. All bpf_mem_cache are safe to share across different maps
and programs. Convert SLAB_TYPESAFE_BY_RCU to batched call_rcu. This change
solves the memory consumption issue, avoids kmem_cache_destroy latency and
keeps bpf hash map performance the same.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 64 +++++++++++++++++++++++++++++++++++++++++--
 kernel/bpf/syscall.c  |  5 +++-
 2 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 7e5df6866d92..2d553f91e8ab 100644
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
@@ -194,6 +199,45 @@ static void free_one(struct bpf_mem_cache *c, void *obj)
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
@@ -212,12 +256,13 @@ static void free_bulk(struct bpf_mem_cache *c)
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
@@ -303,7 +348,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size)
 			return -ENOMEM;
 		size += LLIST_NODE_SZ; /* room for llist_node */
 		snprintf(buf, sizeof(buf), "bpf-%u", size);
-		kmem_cache = kmem_cache_create(buf, size, 8, SLAB_TYPESAFE_BY_RCU, NULL);
+		kmem_cache = kmem_cache_create(buf, size, 8, 0, NULL);
 		if (!kmem_cache) {
 			free_percpu(pc);
 			return -ENOMEM;
@@ -345,6 +390,15 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
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
@@ -366,6 +420,10 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
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

