Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A93E5AB9EA
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 23:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiIBVLh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Sep 2022 17:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiIBVLh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 17:11:37 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318E9D91C9
        for <bpf@vger.kernel.org>; Fri,  2 Sep 2022 14:11:36 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h188so2937573pgc.12
        for <bpf@vger.kernel.org>; Fri, 02 Sep 2022 14:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Sd1n9vsZ5EUML56NQRA7na2eSwXiAznN5BvSCeGf4jc=;
        b=FFwxyrYnvWCyhFpmMpEDS2jIBMnTz36dJ0TKA/Kr3TsANM4z2PT6xDhup/Aa5922Ey
         IqU9Og4DEl2i6COz6fyUYcwKG1wTKTIpj7kmV27g1tZic4We4PAEM8sU2F9ARt5I5I3W
         nOhB/rOQQJ00pxdc/+JiEc7yNA1nRZcDeRhil82kQS/3LDvedEgb/5GEYpVnxMEvHvyU
         spfjWhIJ6y8D4txvS2Rlv9rWbX4VPm1yfDXQUPOCJIMZPnMGhv0mAuutt5Fpb2BWWAxR
         6v5FJi38ywtJyLEUGWCPdu5veu0FFY4Y53RKVZMkOTzlTVLK4qHQwstxXthl+GxGYaUL
         I2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Sd1n9vsZ5EUML56NQRA7na2eSwXiAznN5BvSCeGf4jc=;
        b=kLLQBR0FZ6zIav6NTMVzr6B7xjTCwLW3JXhsyFmJDBeMX1KcwxP6V1UGcvBGpf7VVw
         NctnIqDT0LjNC3q+QxLGywFzWrDt/yP2GU/b5eKcveASKSzvzUZ4yX+4w2tAXyiOfhLn
         sjKYW/4uq5pIVn5jNF7mWgeAXUoQILDlmK7+UYRTROmOwclXc8OlcvnnUFM+E71mkfCx
         RPzfuMX9CbmrQMiDoDDQzQorEKh5Qm5DyWoPMRYQnTlpP6w/QmGKHzUxaWpryX0gHWQe
         GySzhOG676L5YbxqjJqeidhgASHbpk7R6hF8Do+54gJF/9hicqhaQ5KVt8cZMBX7MDtR
         i+LA==
X-Gm-Message-State: ACgBeo0Lk8NBR5gNgGyy6aGYeqBKOxwe/ImSNHRyVAzehoB3flnIH8XQ
        J3vE4f9wYBqbzdPhKhX3/pU=
X-Google-Smtp-Source: AA6agR7zm2Fu+VEBkC8swnpomAV0NgCT5uIBkP+JnFg/9kk9RW1cMzm4EY6q71QYrmAQmUJ9/UNfzA==
X-Received: by 2002:a63:395:0:b0:42b:80a2:7ad2 with SMTP id 143-20020a630395000000b0042b80a27ad2mr30288190pgd.194.1662153095621;
        Fri, 02 Sep 2022 14:11:35 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::c978])
        by smtp.gmail.com with ESMTPSA id t128-20020a628186000000b0052d50e14f1dsm2307178pfd.78.2022.09.02.14.11.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Sep 2022 14:11:35 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 09/16] bpf: Batch call_rcu callbacks instead of SLAB_TYPESAFE_BY_RCU.
Date:   Fri,  2 Sep 2022 14:10:51 -0700
Message-Id: <20220902211058.60789-10-alexei.starovoitov@gmail.com>
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

SLAB_TYPESAFE_BY_RCU makes kmem_caches non mergeable and slows down
kmem_cache_destroy. All bpf_mem_cache are safe to share across different maps
and programs. Convert SLAB_TYPESAFE_BY_RCU to batched call_rcu. This change
solves the memory consumption issue, avoids kmem_cache_destroy latency and
keeps bpf hash map performance the same.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 65 +++++++++++++++++++++++++++++++++++++++++--
 kernel/bpf/syscall.c  |  5 +++-
 2 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 7e5df6866d92..5d8648a01b5c 100644
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
@@ -379,6 +437,7 @@ void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 		}
 		if (c->objcg)
 			obj_cgroup_put(c->objcg);
+		rcu_barrier();
 		free_percpu(ma->caches);
 		ma->caches = NULL;
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

