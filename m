Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36485A9CE0
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 18:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbiIAQQ3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 12:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbiIAQQX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 12:16:23 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148A14E639
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 09:16:22 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q9so16828612pgq.6
        for <bpf@vger.kernel.org>; Thu, 01 Sep 2022 09:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=stV/ngTHq+LHFGpY9e6rDntSPSEwS4lPScETgTMBjXo=;
        b=N6MyjSlUzDJXtv02JyeOM6PHW2NDlQPTGiwUe7cfo3qpz42kBT6sYf1iq26y6kyKyt
         nCS3jsdcqHTGW1sh9WIFdLLA8KM/TtvRqxy3KTsz53xi2OVL1OVBU4LkkX40UTGZ1Yt9
         0UhMKYQS2GvFUF8qipNQ4Z49U8b96MyKK9BuPE3AtJc2awn922LeeD+BrYWMlfKRgHqO
         kWilN2QLxazIJsZiZOHe/eX4OkpzncV+yCPxKOfEuR/H2HK5ENlLzthTwkp5mhmq8cpE
         BMTagos3Ot94+cFo4VD9vGvUsnSLe8bjOLsNbIkBM6/FB7w3RkbSY7k0ubNWffMtSsc0
         GSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=stV/ngTHq+LHFGpY9e6rDntSPSEwS4lPScETgTMBjXo=;
        b=v2cYyDuHfX7OCvctnsyrh6I8fa4yBWDfyl+rELVME5Pii4zk4jzcEQLsFa78QTkq0J
         QdYUheRYb0ZUCVwMF6G8BSDtL2i3xMTjhEhFCWwSrBu94gzQHe63UjXzzzm8nwWunKf9
         6zxG6t/ELLnnCYGdFmMjle/gSSISpDpiDvMkH94qskufc+eX1TFBZM3dIs+WFdUl7euV
         cCq5wnTOnEMrrqU9f0vxrdG9DoU9+pFY5lU3J6vML8J2LASxk701Q0jf4mfCh5VbYSdb
         5ik5nYv2fMX6C5176BZZTt1FJliObGNX0W2wWcUZtVq6Lbk209JlCBMSm5QR9PuCCbhI
         NNeg==
X-Gm-Message-State: ACgBeo3ni72MM8KPCbdyfbFAInIdYKlItzgXG1I3CrfpMsjzlyUBe+aA
        zF8jpiV71qyVxbD1fYlk6ZwqjwgqJx4=
X-Google-Smtp-Source: AA6agR6N+kwEacwX/Xi3d7DB0C3hqfgJH90/m/qMwZy3J8A/foJmL9UmJsCRglp5PIMqw7aKkFEp/g==
X-Received: by 2002:a05:6a00:234f:b0:525:1f7c:f2bf with SMTP id j15-20020a056a00234f00b005251f7cf2bfmr32144184pfj.14.1662048981457;
        Thu, 01 Sep 2022 09:16:21 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::3:4dc5])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903244500b0016d9d6d05f7sm11890994pls.273.2022.09.01.09.16.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Sep 2022 09:16:20 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 bpf-next 08/15] bpf: Adjust low/high watermarks in bpf_mem_cache
Date:   Thu,  1 Sep 2022 09:15:40 -0700
Message-Id: <20220901161547.57722-9-alexei.starovoitov@gmail.com>
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

The same low/high watermarks for every bucket in bpf_mem_cache consume
significant amount of memory. Preallocating 64 elements of 4096 bytes each in
the free list is not efficient. Make low/high watermarks and batching value
dependent on element size. This change brings significant memory savings.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 50 +++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index da0721f8c28f..7e5df6866d92 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -100,6 +100,7 @@ struct bpf_mem_cache {
 	int unit_size;
 	/* count of objects in free_llist */
 	int free_cnt;
+	int low_watermark, high_watermark, batch;
 };
 
 struct bpf_mem_caches {
@@ -118,14 +119,6 @@ static struct llist_node notrace *__llist_del_first(struct llist_head *head)
 	return entry;
 }
 
-#define BATCH 48
-#define LOW_WATERMARK 32
-#define HIGH_WATERMARK 96
-/* Assuming the average number of elements per bucket is 64, when all buckets
- * are used the total memory will be: 64*16*32 + 64*32*32 + 64*64*32 + ... +
- * 64*4096*32 ~ 20Mbyte
- */
-
 static void *__alloc(struct bpf_mem_cache *c, int node)
 {
 	/* Allocate, but don't deplete atomic reserves that typical
@@ -220,7 +213,7 @@ static void free_bulk(struct bpf_mem_cache *c)
 		if (IS_ENABLED(CONFIG_PREEMPT_RT))
 			local_irq_restore(flags);
 		free_one(c, llnode);
-	} while (cnt > (HIGH_WATERMARK + LOW_WATERMARK) / 2);
+	} while (cnt > (c->high_watermark + c->low_watermark) / 2);
 
 	/* and drain free_llist_extra */
 	llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra))
@@ -234,12 +227,12 @@ static void bpf_mem_refill(struct irq_work *work)
 
 	/* Racy access to free_cnt. It doesn't need to be 100% accurate */
 	cnt = c->free_cnt;
-	if (cnt < LOW_WATERMARK)
+	if (cnt < c->low_watermark)
 		/* irq_work runs on this cpu and kmalloc will allocate
 		 * from the current numa node which is what we want here.
 		 */
-		alloc_bulk(c, BATCH, NUMA_NO_NODE);
-	else if (cnt > HIGH_WATERMARK)
+		alloc_bulk(c, c->batch, NUMA_NO_NODE);
+	else if (cnt > c->high_watermark)
 		free_bulk(c);
 }
 
@@ -248,9 +241,38 @@ static void notrace irq_work_raise(struct bpf_mem_cache *c)
 	irq_work_queue(&c->refill_work);
 }
 
+/* For typical bpf map case that uses bpf_mem_cache_alloc and single bucket
+ * the freelist cache will be elem_size * 64 (or less) on each cpu.
+ *
+ * For bpf programs that don't have statically known allocation sizes and
+ * assuming (low_mark + high_mark) / 2 as an average number of elements per
+ * bucket and all buckets are used the total amount of memory in freelists
+ * on each cpu will be:
+ * 64*16 + 64*32 + 64*64 + 64*96 + 64*128 + 64*196 + 64*256 + 32*512 + 16*1024 + 8*2048 + 4*4096
+ * == ~ 116 Kbyte using below heuristic.
+ * Initialized, but unused bpf allocator (not bpf map specific one) will
+ * consume ~ 11 Kbyte per cpu.
+ * Typical case will be between 11K and 116K closer to 11K.
+ * bpf progs can and should share bpf_mem_cache when possible.
+ */
+
 static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
 {
 	init_irq_work(&c->refill_work, bpf_mem_refill);
+	if (c->unit_size <= 256) {
+		c->low_watermark = 32;
+		c->high_watermark = 96;
+	} else {
+		/* When page_size == 4k, order-0 cache will have low_mark == 2
+		 * and high_mark == 6 with batch alloc of 3 individual pages at
+		 * a time.
+		 * 8k allocs and above low == 1, high == 3, batch == 1.
+		 */
+		c->low_watermark = max(32 * 256 / c->unit_size, 1);
+		c->high_watermark = max(96 * 256 / c->unit_size, 3);
+	}
+	c->batch = max((c->high_watermark - c->low_watermark) / 4 * 3, 1);
+
 	/* To avoid consuming memory assume that 1st run of bpf
 	 * prog won't be doing more than 4 map_update_elem from
 	 * irq disabled region
@@ -392,7 +414,7 @@ static void notrace *unit_alloc(struct bpf_mem_cache *c)
 
 	WARN_ON(cnt < 0);
 
-	if (cnt < LOW_WATERMARK)
+	if (cnt < c->low_watermark)
 		irq_work_raise(c);
 	return llnode;
 }
@@ -425,7 +447,7 @@ static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
 	local_dec(&c->active);
 	local_irq_restore(flags);
 
-	if (cnt > HIGH_WATERMARK)
+	if (cnt > c->high_watermark)
 		/* free few objects from current cpu into global kmalloc pool */
 		irq_work_raise(c);
 }
-- 
2.30.2

