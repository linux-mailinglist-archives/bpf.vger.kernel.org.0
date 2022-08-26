Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE965A1F0D
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 04:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244846AbiHZCpO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 22:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244896AbiHZCpL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 22:45:11 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB4929833
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:45:06 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id io24so458157plb.1
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 19:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=2T6kqT/PBUwvMDQLZRxHusAqO091+bGHkILYJZTplhw=;
        b=DUYXaz7496TnWGpAvKl9hy0sER9sYMgoaJ36QXmlvNPpivD2z17fLd/JKKUcNy0qmD
         Ps326UW/a/iDhTNaeG/Re/e0+8kcfd0mqISUCuY0HOuxdY8SQ6mj9DUAaCAM1TO2XE4V
         nK7JDFduix6BHOPIRRAgTazCVWK5S3qQ9Tc0EfaQ19hVJCVjSVdJe3ZoaOBy8+UoM3Z8
         /NG6Sk51M1ZyGdWoVUn0zybcEeqWsC9Uz+J+CvqCtDl5oVNJ2yHeqc2S8lOv58kA59x/
         fik7BvTFnUjP2OFWs1Pgl6mtM6eUCCkU/zTi+ak32ZO9KwrXFnG+VThy7mmM/5+OJ1bW
         i2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=2T6kqT/PBUwvMDQLZRxHusAqO091+bGHkILYJZTplhw=;
        b=aNbNaFKGoUsG8kHRLL9XgcmwZJcP5WCqWBYO2rPnk/f4S9b8na4iNk5IFtHsoIc8RJ
         MUkIVeIroXt5n3B84TlNGIaqK/UDarFYE4gh8GY0vHatBCg4m4379uIfaWik5KUptWPR
         y+R/WMbXiJT3AE02Gr4GuzYMGQuqKesje1+M9VWf7Z73LAV8ZaOcoyc9ZIcBxzzK6qav
         eFxi1/nkpaqyT59ixQffmQM47h3G9ZYGxcybFzXui3fDa18wUPmitDdjo189aqGZKwXX
         VUNl8E2cmi+hHEyzZGFnqLcUxeWH+1fLEUCJYG+MdaEBPbTR1+JN5MeSMM6f5sH/z2AZ
         16PA==
X-Gm-Message-State: ACgBeo3LjEqh/QmT9fonQvEtbQC9u5cQm/GjEzmqYbStKA0RHcba0+T3
        AwRJ+8Ti7L28a+RZJ8KlgnjwaUY0ksQ=
X-Google-Smtp-Source: AA6agR7c7N+NtA1xf1XKhKVANdoaBkj2X29ztifg8T7kAAuAOrZJHVQOBfblEuR90mdmwtqS6pztTg==
X-Received: by 2002:a17:902:6542:b0:172:95d8:a777 with SMTP id d2-20020a170902654200b0017295d8a777mr1725023pln.61.1661481905538;
        Thu, 25 Aug 2022 19:45:05 -0700 (PDT)
Received: from macbook-pro-3.dhcp.thefacebook.com ([2620:10d:c090:400::5:15dc])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b0017292073839sm271265plr.178.2022.08.25.19.45.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Aug 2022 19:45:05 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 08/15] bpf: Adjust low/high watermarks in bpf_mem_cache
Date:   Thu, 25 Aug 2022 19:44:23 -0700
Message-Id: <20220826024430.84565-9-alexei.starovoitov@gmail.com>
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

The same low/high watermarks for every bucket in bpf_mem_cache consume
significant amount of memory. Preallocating 64 elements of 4096 bytes each in
the free list is not efficient. Make low/high watermarks and batching value
dependent on element size. This change brings significant memory savings.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 50 +++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index c1817f14c25a..775c38132c4d 100644
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
@@ -216,7 +209,7 @@ static void free_bulk(struct bpf_mem_cache *c)
 		if (IS_ENABLED(CONFIG_PREEMPT_RT))
 			local_irq_restore(flags);
 		free_one(c, llnode);
-	} while (cnt > (HIGH_WATERMARK + LOW_WATERMARK) / 2);
+	} while (cnt > (c->high_watermark + c->low_watermark) / 2);
 
 	/* and drain free_llist_extra */
 	llist_for_each_safe(llnode, t, llist_del_all(&c->free_llist_extra))
@@ -230,12 +223,12 @@ static void bpf_mem_refill(struct irq_work *work)
 
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
 
@@ -244,9 +237,38 @@ static void notrace irq_work_raise(struct bpf_mem_cache *c)
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
@@ -388,7 +410,7 @@ static void notrace *unit_alloc(struct bpf_mem_cache *c)
 
 	WARN_ON(cnt < 0);
 
-	if (cnt < LOW_WATERMARK)
+	if (cnt < c->low_watermark)
 		irq_work_raise(c);
 	return llnode;
 }
@@ -421,7 +443,7 @@ static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
 	local_dec(&c->active);
 	local_irq_restore(flags);
 
-	if (cnt > HIGH_WATERMARK)
+	if (cnt > c->high_watermark)
 		/* free few objects from current cpu into global kmalloc pool */
 		irq_work_raise(c);
 }
-- 
2.30.2

