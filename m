Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4916B5AB9F2
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 23:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiIBVME (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Sep 2022 17:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiIBVMD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Sep 2022 17:12:03 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA1BDF4FE
        for <bpf@vger.kernel.org>; Fri,  2 Sep 2022 14:12:01 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id c66so3051495pfc.10
        for <bpf@vger.kernel.org>; Fri, 02 Sep 2022 14:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=TNRfuwjqb+LO+kCM/Gb16FKn3hCFhHeYDMKUUqgmZJU=;
        b=mUxeRFBjujyis+Oaqckkc+Lfw3tvqmjSQQaa9XEhJefD1zM9ot961+hcJnTVarStvu
         vOgf+8whE9N/pIhGsOwoRvu4z75yZlh7ppOXENTADsYN461+8hJOvqVs0YHr+o20aK3V
         vjjltMqDFAZP2PP2fBm/wiEvpg/xGXioyWGTgUjCDZ76R2ShBw7jvn7k6sbaNkYnjj65
         vcUQlyvUk7+7yxMdCw3cPhSbV1+yBHCl01/wcbozp1b8rJ1Xn6FLz+H9ymdfIWOypI4x
         ymajU7G6+gW96jJsGr7AapONB+oaj2BTe19Skoi1jHt9APVBnyamdP2wz/c8x2zOAHP4
         cb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TNRfuwjqb+LO+kCM/Gb16FKn3hCFhHeYDMKUUqgmZJU=;
        b=ubIlNuFs14fW2oz+nHdEYzzYEZkCqeES+bYG22Wdb4reYSv0+CXkH1lSwfYiZ5aKc0
         /rAUFE764WAEVBmBSPX+BXT0ocpoTA0CcpzlveMa5h5GG4K/NZzF39YUFWv5NADcOt4Q
         voNV2CU9b3/Q3NF8LKWr00k/HvBqLhDZJW0MGj7EbekqyIGQkzOs/omMjG0ALSIao2v6
         lnDE46JiHk8+X+UtNC+qTv/nGyqli6tOrL3FMAjN/DCQr4/oW1jwzq5Oq7qLxhp3LCp/
         fszDy4EudqslfwIjMl0QuB6rkeebj2IKEmWoAHhlwM0fPA06Qp6pLU0pWBMHbmatnoh0
         F7ug==
X-Gm-Message-State: ACgBeo1ouB17QwWwwyV4g9dglGDLhoa4CqnS+58sTpnFARkUV4covXtK
        9vP3U22N5/AkjPKR3aPFG3I=
X-Google-Smtp-Source: AA6agR6oG9yBLI5jQxAMQ6eReXxNUFt9PmBKK9JLSdg7raR8jc1au4n4apR6oJwGTu+n1V7+P2v/6w==
X-Received: by 2002:a05:6a00:1393:b0:536:5b8a:c35b with SMTP id t19-20020a056a00139300b005365b8ac35bmr39009212pfg.5.1662153121244;
        Fri, 02 Sep 2022 14:12:01 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::c978])
        by smtp.gmail.com with ESMTPSA id e16-20020aa798d0000000b005360da6b26bsm2221360pfm.159.2022.09.02.14.11.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Sep 2022 14:12:00 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 bpf-next 16/16] bpf: Optimize rcu_barrier usage between hash map and bpf_mem_alloc.
Date:   Fri,  2 Sep 2022 14:10:58 -0700
Message-Id: <20220902211058.60789-17-alexei.starovoitov@gmail.com>
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

User space might be creating and destroying a lot of hash maps. Synchronous
rcu_barrier-s in a destruction path of hash map delay freeing of hash buckets
and other map memory and may cause artificial OOM situation under stress.
Optimize rcu_barrier usage between bpf hash map and bpf_mem_alloc:
- remove rcu_barrier from hash map, since htab doesn't use call_rcu
  directly and there are no callback to wait for.
- bpf_mem_alloc has call_rcu_in_progress flag that indicates pending callbacks.
  Use it to avoid barriers in fast path.
- When barriers are needed copy bpf_mem_alloc into temp structure
  and wait for rcu barrier-s in the worker to let the rest of
  hash map freeing to proceed.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_mem_alloc.h |  2 +
 kernel/bpf/hashtab.c          |  6 +--
 kernel/bpf/memalloc.c         | 80 ++++++++++++++++++++++++++++-------
 3 files changed, 69 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf_mem_alloc.h b/include/linux/bpf_mem_alloc.h
index 653ed1584a03..3e164b8efaa9 100644
--- a/include/linux/bpf_mem_alloc.h
+++ b/include/linux/bpf_mem_alloc.h
@@ -3,6 +3,7 @@
 #ifndef _BPF_MEM_ALLOC_H
 #define _BPF_MEM_ALLOC_H
 #include <linux/compiler_types.h>
+#include <linux/workqueue.h>
 
 struct bpf_mem_cache;
 struct bpf_mem_caches;
@@ -10,6 +11,7 @@ struct bpf_mem_caches;
 struct bpf_mem_alloc {
 	struct bpf_mem_caches __percpu *caches;
 	struct bpf_mem_cache __percpu *cache;
+	struct work_struct work;
 };
 
 int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index a77b9c4a4e48..0fe3f136cbbe 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1546,10 +1546,10 @@ static void htab_map_free(struct bpf_map *map)
 	 * There is no need to synchronize_rcu() here to protect map elements.
 	 */
 
-	/* some of free_htab_elem() callbacks for elements of this map may
-	 * not have executed. Wait for them.
+	/* htab no longer uses call_rcu() directly. bpf_mem_alloc does it
+	 * underneath and is reponsible for waiting for callbacks to finish
+	 * during bpf_mem_alloc_destroy().
 	 */
-	rcu_barrier();
 	if (!htab_is_prealloc(htab)) {
 		delete_all_elements(htab);
 	} else {
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 38fbd15c130a..5cc952da7d41 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -414,10 +414,9 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 {
 	struct llist_node *llnode, *t;
 
-	/* The caller has done rcu_barrier() and no progs are using this
-	 * bpf_mem_cache, but htab_map_free() called bpf_mem_cache_free() for
-	 * all remaining elements and they can be in free_by_rcu or in
-	 * waiting_for_gp lists, so drain those lists now.
+	/* No progs are using this bpf_mem_cache, but htab_map_free() called
+	 * bpf_mem_cache_free() for all remaining elements and they can be in
+	 * free_by_rcu or in waiting_for_gp lists, so drain those lists now.
 	 */
 	llist_for_each_safe(llnode, t, __llist_del_all(&c->free_by_rcu))
 		free_one(c, llnode);
@@ -429,42 +428,91 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
 		free_one(c, llnode);
 }
 
+static void free_mem_alloc_no_barrier(struct bpf_mem_alloc *ma)
+{
+	free_percpu(ma->cache);
+	free_percpu(ma->caches);
+	ma->cache = NULL;
+	ma->caches = NULL;
+}
+
+static void free_mem_alloc(struct bpf_mem_alloc *ma)
+{
+	/* waiting_for_gp lists was drained, but __free_rcu might
+	 * still execute. Wait for it now before we freeing percpu caches.
+	 */
+	rcu_barrier_tasks_trace();
+	rcu_barrier();
+	free_mem_alloc_no_barrier(ma);
+}
+
+static void free_mem_alloc_deferred(struct work_struct *work)
+{
+	struct bpf_mem_alloc *ma = container_of(work, struct bpf_mem_alloc, work);
+
+	free_mem_alloc(ma);
+	kfree(ma);
+}
+
+static void destroy_mem_alloc(struct bpf_mem_alloc *ma, int rcu_in_progress)
+{
+	struct bpf_mem_alloc *copy;
+
+	if (!rcu_in_progress) {
+		/* Fast path. No callbacks are pending, hence no need to do
+		 * rcu_barrier-s.
+		 */
+		free_mem_alloc_no_barrier(ma);
+		return;
+	}
+
+	copy = kmalloc(sizeof(*ma), GFP_KERNEL);
+	if (!copy) {
+		/* Slow path with inline barrier-s */
+		free_mem_alloc(ma);
+		return;
+	}
+
+	/* Defer barriers into worker to let the rest of map memory to be freed */
+	copy->cache = ma->cache;
+	ma->cache = NULL;
+	copy->caches = ma->caches;
+	ma->caches = NULL;
+	INIT_WORK(&copy->work, free_mem_alloc_deferred);
+	queue_work(system_unbound_wq, &copy->work);
+}
+
 void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
 {
 	struct bpf_mem_caches *cc;
 	struct bpf_mem_cache *c;
-	int cpu, i;
+	int cpu, i, rcu_in_progress;
 
 	if (ma->cache) {
+		rcu_in_progress = 0;
 		for_each_possible_cpu(cpu) {
 			c = per_cpu_ptr(ma->cache, cpu);
 			drain_mem_cache(c);
+			rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
 		}
 		/* objcg is the same across cpus */
 		if (c->objcg)
 			obj_cgroup_put(c->objcg);
-		/* c->waiting_for_gp list was drained, but __free_rcu might
-		 * still execute. Wait for it now before we free 'c'.
-		 */
-		rcu_barrier_tasks_trace();
-		rcu_barrier();
-		free_percpu(ma->cache);
-		ma->cache = NULL;
+		destroy_mem_alloc(ma, rcu_in_progress);
 	}
 	if (ma->caches) {
+		rcu_in_progress = 0;
 		for_each_possible_cpu(cpu) {
 			cc = per_cpu_ptr(ma->caches, cpu);
 			for (i = 0; i < NUM_CACHES; i++) {
 				c = &cc->cache[i];
 				drain_mem_cache(c);
+				rcu_in_progress += atomic_read(&c->call_rcu_in_progress);
 			}
 		}
 		if (c->objcg)
 			obj_cgroup_put(c->objcg);
-		rcu_barrier_tasks_trace();
-		rcu_barrier();
-		free_percpu(ma->caches);
-		ma->caches = NULL;
+		destroy_mem_alloc(ma, rcu_in_progress);
 	}
 }
 
-- 
2.30.2

