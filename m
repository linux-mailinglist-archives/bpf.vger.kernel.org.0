Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3A6597897
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 23:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242256AbiHQVE4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 17:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbiHQVEy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 17:04:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B719DAB4E5
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 14:04:52 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g18so4599211pju.0
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 14:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=CqItYD5FIMTqL735q4RzdfGMBe2ezI24gvr9zo137dQ=;
        b=Ix9FtXEe9O4LvS7HxcGkD5ryZ2d6IEyvzm7T6nS9/vzVIg/95jivgmzzrBZiPu66sM
         soKCJQl5rIWYyIaq5MpE/lKVfQag3/Y2ba6VUNViE9RQeWAsXw2dsU5h7G4BxoJuG9aw
         WyIKdjqeevpmNB9AJXLlJj1w9NS9STwKDKv51GCEOPvPeYruzfEdqpxq0RN50WIywKuN
         kzdXCFmZO9coSK1kES9iFKyi1J4LO+P/jt3ywKeWfigT+wGdI227haKBDCFaTV4aYe43
         JHs/GxZEzz/veMVyJiZTWepRCTYKoyURcXfDXSslxoxoF7uksYU+wvJC8vrqkX5S6mcf
         wzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=CqItYD5FIMTqL735q4RzdfGMBe2ezI24gvr9zo137dQ=;
        b=H9qWpliPlyFBuDvSDPD7B91V/Y/yHJX8Vvy+o0NbfdDtgyabtxU1OUafLozWLwvNq7
         S3dl/zFvKr9W9GyhvW4vBgqeTVWtJVbNvlVXBXiDX1zzkeNPz7qQ7KMke2MEuhc3cvYl
         FKgbMXu0hcsGlkVDW4hETWpjdrKq+M+crHgR5J5ii26nHIWuBqmzNw8KpqecjaC1F+IE
         /6gGxtUkdcCpZ07xGLhUxNjpuNxo31Sa+SIcmgmRUYe+8p543L0Rbo+KvBaqLxNUAXzu
         KxokEhANm/wUbjaU+jwzNTesMzY7/lUioJxalvJMHDFsGZzzveVe1Ah8kJiwUFOQHQPm
         csUw==
X-Gm-Message-State: ACgBeo0cyJWpaGw3gl13RqdpYds5wEtglmL/Ba5QzQgwwbE2unnh2rbs
        yhZMTkPtLj+UGGh4jo6DomE=
X-Google-Smtp-Source: AA6agR4qqQ/vAvMyyxhIFskV/Nf8U14xtKT5zSR0M/4ctfttbF7UcUwMENRPo8U4t7RHZZCr57WBsw==
X-Received: by 2002:a17:90a:a08:b0:1fa:b43d:68cf with SMTP id o8-20020a17090a0a0800b001fab43d68cfmr4873035pjo.41.1660770292085;
        Wed, 17 Aug 2022 14:04:52 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:500::1:ccd6])
        by smtp.gmail.com with ESMTPSA id x7-20020a628607000000b0053554e0e950sm149572pfd.147.2022.08.17.14.04.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Aug 2022 14:04:51 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, tj@kernel.org,
        memxor@gmail.com, delyank@fb.com, linux-mm@kvack.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 bpf-next 08/12] bpf: Adjust low/high watermarks in bpf_mem_cache
Date:   Wed, 17 Aug 2022 14:04:15 -0700
Message-Id: <20220817210419.95560-9-alexei.starovoitov@gmail.com>
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

Same low/high watermarks for every bucket in bpf_mem_cache consume
significant amount of memory. Preallocating 64 elements of PAGE_SIZE
to the free list is not efficient.
Make low/high watermarks and batching value depend on element size.
This change brings significant memory savings.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 64 ++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index a43630371b9f..be8262f5c9ec 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -105,6 +105,7 @@ struct bpf_mem_cache {
 	atomic_t free_cnt_nmi;
 	/* flag to refill nmi list too */
 	bool refill_nmi_list;
+	int low_watermark, high_watermark, batch;
 };
 
 struct bpf_mem_caches {
@@ -123,14 +124,6 @@ static struct llist_node notrace *__llist_del_first(struct llist_head *head)
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
 /* extra macro useful for testing by randomizing in_nmi condition */
 #define bpf_in_nmi() in_nmi()
 
@@ -238,7 +231,7 @@ static void free_bulk(struct bpf_mem_cache *c)
 		if (IS_ENABLED(CONFIG_PREEMPT_RT))
 			local_irq_restore(flags);
 		free_one(c, llnode);
-	} while (cnt > (HIGH_WATERMARK + LOW_WATERMARK) / 2);
+	} while (cnt > (c->high_watermark + c->low_watermark) / 2);
 }
 
 static void free_bulk_nmi(struct bpf_mem_cache *c)
@@ -253,7 +246,7 @@ static void free_bulk_nmi(struct bpf_mem_cache *c)
 		else
 			cnt = 0;
 		free_one(c, llnode);
-	} while (cnt > (HIGH_WATERMARK + LOW_WATERMARK) / 2);
+	} while (cnt > (c->high_watermark + c->low_watermark) / 2);
 }
 
 static void bpf_mem_refill(struct irq_work *work)
@@ -262,12 +255,12 @@ static void bpf_mem_refill(struct irq_work *work)
 	int cnt;
 
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
 
 	if (!c->refill_nmi_list)
@@ -276,9 +269,9 @@ static void bpf_mem_refill(struct irq_work *work)
 		 */
 		return;
 	cnt = atomic_read(&c->free_cnt_nmi);
-	if (cnt < LOW_WATERMARK)
-		alloc_bulk_nmi(c, BATCH, NUMA_NO_NODE);
-	else if (cnt > HIGH_WATERMARK)
+	if (cnt < c->low_watermark)
+		alloc_bulk_nmi(c, c->batch, NUMA_NO_NODE);
+	else if (cnt > c->high_watermark)
 		free_bulk_nmi(c);
 	c->refill_nmi_list = false;
 }
@@ -294,14 +287,47 @@ static void notrace irq_work_raise(struct bpf_mem_cache *c, bool in_nmi)
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
+ * + nmi's reserves
+ * 1*16 + 1*32 + 1*64 + 1*96 + 1*128 + 1*196 + 1*256 + 1*512 + 1*1024 + 1*2048 + 1*4096
+ * == ~ 122 Kbyte using below heuristic.
+ * In unlikely worst case where bpf progs used all allocations sizes from
+ * non-NMI and from NMI too: ~ 227 Kbyte per cpu.
+ * Initialized, but unused bpf allocator (not bpf map specific one) will
+ * consume ~ 19 Kbyte per cpu.
+ * Typical case will be between 19K and 122K closer to 19K.
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
 	 */
-	alloc_bulk(c, c->unit_size < 256 ? 4 : 1, cpu_to_node(cpu));
+	alloc_bulk(c, c->unit_size <= 256 ? 4 : 1, cpu_to_node(cpu));
 
 	/* NMI progs are rare. Assume they have one map_update
 	 * per prog at the very beginning.
@@ -442,7 +468,7 @@ static void notrace *unit_alloc(struct bpf_mem_cache *c)
 	}
 	WARN_ON(cnt < 0);
 
-	if (cnt < LOW_WATERMARK)
+	if (cnt < c->low_watermark)
 		irq_work_raise(c, in_nmi);
 	return llnode;
 }
@@ -471,7 +497,7 @@ static void notrace unit_free(struct bpf_mem_cache *c, void *ptr)
 	}
 	WARN_ON(cnt <= 0);
 
-	if (cnt > HIGH_WATERMARK)
+	if (cnt > c->high_watermark)
 		/* free few objects from current cpu into global kmalloc pool */
 		irq_work_raise(c, in_nmi);
 }
-- 
2.30.2

