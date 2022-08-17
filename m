Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C835978B1
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 23:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242287AbiHQVE7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 17:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbiHQVE6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 17:04:58 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E295AB422
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 14:04:56 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id s36-20020a17090a69a700b001faad0a7a34so2925434pjj.4
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 14:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=eC2rtkVbVwNuBSQ3V1/X4MqvRMlFh39VvvUQCY2nUqM=;
        b=ZODVqnfokgzR6xAOLe1TR5kgjT+E1Py99cY5RCQvlvoxhbEJsXhjwpvdDEW7mEhEMi
         EQel2tKcUTK+YTD80kM9f2qh3socQ5OOtAQPa8YG55jVh1J4ITLcjY/hJY/LFye8V00S
         QAqlvB7HR5ZWoM17s5K1pZGKJzsgTbD+dbKJt7WVCuW4yMiq390J/0ZiGxPpJ+b+4ulr
         4T8tvQ4ukZrlU4ypzs98d2gXeQB13zXMW/vgCPWkwEjRuoXKvg4D7O2xBQkYrj/VVDxP
         yXHmc5q5YaPLtpzugqED2ETClH9M5SWrHUaCOtlWKEKTNM0GrEmQyCfLZa4CW+zngrEq
         XO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=eC2rtkVbVwNuBSQ3V1/X4MqvRMlFh39VvvUQCY2nUqM=;
        b=V9GpUns5yOJmO0s5VLlbd3hlnZoGgvxmHGq1fc1ytdbSmXyPfKE5HcXZd14342/kFS
         DegS6eTlnfNPP+ZtMbpFF3IMv32nX6CiSnT0HPMPr94/3okgMIe1lPkHKG9tUfK+FPPe
         qcHa9FpNXzAvdMDNt5jCwdEKPXBliURQ7w2+hvuSWLvMXMYn1wca1sB+hQcxBzpu5cfo
         YE5qet2a39XOJwhjCayR+MDlrCgT4w7kV/X90aIdh8vLtfVYCQbYhZGAAZOKpYaR45SB
         q8G5CP3XYnLgoh2MopXq5s1UihPilHbQubjPWqE5Wboe91PO5cGOR/9E67CTZt5XM8/X
         dTXg==
X-Gm-Message-State: ACgBeo257a8/20/0Q4746UDfBHIjnSIa8Y0JGe/1uRrTc02ETil58MJg
        GizX3yyfv8Ef0beXNWMJAE4=
X-Google-Smtp-Source: AA6agR6igdPjlVXHt861XtWddd3bEdvSscIUU3Taah7nMW3P5IM4zXUDgmqGFd5YcSA2Iaf7izwODA==
X-Received: by 2002:a17:90b:350d:b0:1f4:f6a5:a281 with SMTP id ls13-20020a17090b350d00b001f4f6a5a281mr5386216pjb.99.1660770295857;
        Wed, 17 Aug 2022 14:04:55 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::1:ccd6])
        by smtp.gmail.com with ESMTPSA id i16-20020a056a00005000b0052d82ce65a9sm11309230pfk.143.2022.08.17.14.04.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Aug 2022 14:04:55 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 bpf-next 09/12] bpf: Batch call_rcu callbacks instead of SLAB_TYPESAFE_BY_RCU.
Date:   Wed, 17 Aug 2022 14:04:16 -0700
Message-Id: <20220817210419.95560-10-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220817210419.95560-1-alexei.starovoitov@gmail.com>
References: <20220817210419.95560-1-alexei.starovoitov@gmail.com>
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
 kernel/bpf/memalloc.c | 58 ++++++++++++++++++++++++++++++++++++++++---
 kernel/bpf/syscall.c  |  5 +++-
 2 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index be8262f5c9ec..ae4cdc9493c3 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -106,6 +106,11 @@ struct bpf_mem_cache {
 	/* flag to refill nmi list too */
 	bool refill_nmi_list;
 	int low_watermark, high_watermark, batch;
+
+	struct rcu_head rcu;
+	struct llist_head free_by_rcu;
+	struct llist_head waiting_for_gp;
+	atomic_t call_rcu_in_progress;
 };
 
 struct bpf_mem_caches {
@@ -214,6 +219,39 @@ static void free_one(struct bpf_mem_cache *c, void *obj)
 		kfree(obj);
 }
 
+static void __free_rcu(struct rcu_head *head)
+{
+	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu);
+	struct llist_node *llnode = __llist_del_all(&c->waiting_for_gp);
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
+	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_by_rcu))
+		__llist_add(llnode, &c->waiting_for_gp);
+	call_rcu(&c->rcu, __free_rcu);
+}
+
 static void free_bulk(struct bpf_mem_cache *c)
 {
 	struct llist_node *llnode;
@@ -230,8 +268,9 @@ static void free_bulk(struct bpf_mem_cache *c)
 			cnt = 0;
 		if (IS_ENABLED(CONFIG_PREEMPT_RT))
 			local_irq_restore(flags);
-		free_one(c, llnode);
+		enque_to_free(c, llnode);
 	} while (cnt > (c->high_watermark + c->low_watermark) / 2);
+	do_call_rcu(c);
 }
 
 static void free_bulk_nmi(struct bpf_mem_cache *c)
@@ -245,8 +284,9 @@ static void free_bulk_nmi(struct bpf_mem_cache *c)
 			cnt = atomic_dec_return(&c->free_cnt_nmi);
 		else
 			cnt = 0;
-		free_one(c, llnode);
+		enque_to_free(c, llnode);
 	} while (cnt > (c->high_watermark + c->low_watermark) / 2);
+	do_call_rcu(c);
 }
 
 static void bpf_mem_refill(struct irq_work *work)
@@ -358,7 +398,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size)
 			return -ENOMEM;
 		size += LLIST_NODE_SZ; /* room for llist_node */
 		snprintf(buf, sizeof(buf), "bpf-%u", size);
-		kmem_cache = kmem_cache_create(buf, size, 8, SLAB_TYPESAFE_BY_RCU, NULL);
+		kmem_cache = kmem_cache_create(buf, size, 8, 0, NULL);
 		if (!kmem_cache) {
 			free_percpu(pc);
 			return -ENOMEM;
@@ -400,6 +440,18 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 {
 	struct llist_node *llnode;
 
+	/* The caller has done rcu_barrier() and no progs are using this
+	 * bpf_mem_cache, but htab_map_free() called bpf_mem_cache_free() for
+	 * all remaining elements and they can be in free_by_rcu or in
+	 * waiting_for_gp lists, so drain accumulating free_by_rcu list and
+	 * optionally wait for callbacks to finish.
+	 */
+	while ((llnode = __llist_del_first(&c->free_by_rcu)))
+		free_one(c, llnode);
+	if (atomic_xchg(&c->call_rcu_in_progress, 1))
+		rcu_barrier();
+	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp));
+
 	while ((llnode = llist_del_first(&c->free_llist_nmi)))
 		free_one(c, llnode);
 	while ((llnode = __llist_del_first(&c->free_llist)))
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 83c7136c5788..eeef64b27683 100644
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

