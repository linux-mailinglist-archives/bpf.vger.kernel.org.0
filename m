Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D51597884
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 23:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbiHQVFC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 17:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242282AbiHQVFB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 17:05:01 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35029AB4F6
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 14:05:00 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id a22so12485068pfg.3
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 14:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=O1bPhAvwfl8qB1dAQm/TmI1W1wAtyZwEot9xV2yHQP4=;
        b=p96ZA5x/3QjnYv8zVsscJb6pTFi92zNWwi26jxJg0QUXJD/cEBomqgcq1FWk8ylyGh
         YPrJ7RDbYIsidHVMnsqAk6OzfC00tyEKc+1ZTG3z3Mlw/Xzl5myRTMM+/46zE8L213KV
         UYvNle63ynwuAityBSNEyuEnc+vgO2OINHxoAyeltszVmb6XrK+x9sMqid/GWcoFLFeH
         5BWcHjr9Pa32CcGgO46akz1nhfOXBswtvBoRY/QMhmewRu1wb7kS8W+owKucBsYpPan7
         DMDfkETIy1FcxMJECwQj9Sd7LYt06G2rH9ML6gqXKpJNGKuaT3ngp9vEhrj4F1XrpUyj
         IE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=O1bPhAvwfl8qB1dAQm/TmI1W1wAtyZwEot9xV2yHQP4=;
        b=mya3cq1Eh7C3jValFd2OEsLGseTv3oXUlnbb+7+E1uWo3Lr9V6m5BrslRv1WLIXvHj
         Lez597+rAaNplupqPMrxqUQRR0qFQz3f+1CjfkHKtns7+h+1NCZb41Jkdc/iEB+slXpT
         UnUJ62URrKNph+zof/Jmq+DIgyiS39O8APvY8QgsTDV/qPyx4ophbEskGJeoQZBGycCM
         HmGyy5lUMWQg89hbqNpTyOvAdEdmU6dD8lcx5S1alrSYSeLABitzDtszfNS3nS08vvtf
         Re9svgzHv5jxs3AXFnsxv+n+RkwXdxmtAPMHCEsGOQ8cOLPRovKGqlQl0ImUhnfv8Rnn
         9SlQ==
X-Gm-Message-State: ACgBeo1RPDF0Tfb22TT6152k41Um2kQOtSFTWnfehAHr73baD0+uw3+V
        5iXYxy2vRPgbsdQt+zVVRzw=
X-Google-Smtp-Source: AA6agR7anURERJvTlCyw49DHRJIKlg5RjD5rEb05XJJfzLEgUv8HD2FU+zUwL4MkZmNVh1Iq1K6YAg==
X-Received: by 2002:a05:6a00:4509:b0:52d:4943:90b4 with SMTP id cw9-20020a056a00450900b0052d494390b4mr24467pfb.22.1660770299491;
        Wed, 17 Aug 2022 14:04:59 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::1:ccd6])
        by smtp.gmail.com with ESMTPSA id o11-20020a170902d4cb00b0016bd8fb1fafsm325846plg.307.2022.08.17.14.04.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Aug 2022 14:04:59 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 bpf-next 10/12] bpf: Add percpu allocation support to bpf_mem_alloc.
Date:   Wed, 17 Aug 2022 14:04:17 -0700
Message-Id: <20220817210419.95560-11-alexei.starovoitov@gmail.com>
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
index 3c1d15fd052a..bf20c45002fe 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -598,7 +598,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 				goto free_prealloc;
 		}
 	} else {
-		err = bpf_mem_alloc_init(&htab->ma, htab->elem_size);
+		err = bpf_mem_alloc_init(&htab->ma, htab->elem_size, false);
 		if (err)
 			goto free_map_locked;
 	}
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index ae4cdc9493c3..633e7eb9ba62 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -105,6 +105,7 @@ struct bpf_mem_cache {
 	atomic_t free_cnt_nmi;
 	/* flag to refill nmi list too */
 	bool refill_nmi_list;
+	bool percpu;
 	int low_watermark, high_watermark, batch;
 
 	struct rcu_head rcu;
@@ -141,6 +142,19 @@ static void *__alloc(struct bpf_mem_cache *c, int node)
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
 
@@ -213,6 +227,12 @@ static void alloc_bulk_nmi(struct bpf_mem_cache *c, int cnt, int node)
 
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
@@ -382,21 +402,30 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
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
@@ -409,14 +438,19 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size)
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

