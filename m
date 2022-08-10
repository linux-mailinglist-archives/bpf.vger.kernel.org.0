Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EF158F16E
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 19:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbiHJRSr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 13:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiHJRS3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 13:18:29 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73777832DE;
        Wed, 10 Aug 2022 10:18:11 -0700 (PDT)
Received: from pwmachine.numericable.fr (85-170-37-153.rev.numericable.fr [85.170.37.153])
        by linux.microsoft.com (Postfix) with ESMTPSA id 313C7210CB09;
        Wed, 10 Aug 2022 10:18:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 313C7210CB09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1660151890;
        bh=3kiPsqUPtso+NNqIgTkQ85tKAvMJGntQbjjUHjVcF7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dB94HTgoM6vLToCJMc+xWK/jUYegFT21uB7xqzT78FYU/qz7ZES9fGtXM+3spSy0b
         Lf53z+KnmjBeyuCAd5XsXljNylV3loy61Fb8vnKU2vXq+nTt5S7cA98KA5P0dFvQOz
         imsaV8vkx9EXUkEAkYNxdZd3bSvoXElAGG6BIx00=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Francis Laniel <flaniel@linux.microsoft.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Geliang Tang <geliang.tang@suse.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [RFC PATCH v1 1/3] bpf: Make ring buffer overwritable.
Date:   Wed, 10 Aug 2022 19:16:52 +0200
Message-Id: <20220810171702.74932-2-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810171702.74932-1-flaniel@linux.microsoft.com>
References: <20220810171702.74932-1-flaniel@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

By default, BPF ring buffer are size bounded, when producers already filled the
buffer, they need to wait for the consumer to get those data before adding new
ones.
In terms of API, bpf_ringbuf_reserve() returns NULL if the buffer is full.

This patch permits making BPF ring buffer overwritable.
When producers already wrote as many data as the buffer size, they will begin to
over write existing data, so the oldest will be replaced.
As a result, bpf_ringbuf_reserve() never returns NULL.

Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
---
 include/uapi/linux/bpf.h |  3 +++
 kernel/bpf/ringbuf.c     | 51 +++++++++++++++++++++++++++++++---------
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ef78e0e1a754..19c7039265d8 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1226,6 +1226,9 @@ enum {

 /* Create a map that is suitable to be an inner map with dynamic max entries */
 	BPF_F_INNER_MAP		= (1U << 12),
+
+/* Create an over writable BPF_RINGBUF */
+	BFP_F_RB_OVER_WRITABLE	= (1U << 13),
 };

 /* Flags for BPF_PROG_QUERY. */
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index ded4faeca192..e2d907df4989 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -12,7 +12,7 @@
 #include <uapi/linux/btf.h>
 #include <linux/btf_ids.h>

-#define RINGBUF_CREATE_FLAG_MASK (BPF_F_NUMA_NODE)
+#define RINGBUF_CREATE_FLAG_MASK (BPF_F_NUMA_NODE | BFP_F_RB_OVER_WRITABLE)

 /* non-mmap()'able part of bpf_ringbuf (everything up to consumer page) */
 #define RINGBUF_PGOFF \
@@ -37,6 +37,8 @@ struct bpf_ringbuf {
 	u64 mask;
 	struct page **pages;
 	int nr_pages;
+	__u8 over_writable: 1,
+	     __reserved:    7;
 	spinlock_t spinlock ____cacheline_aligned_in_smp;
 	/* Consumer and producer counters are put into separate pages to allow
 	 * mapping consumer page as r/w, but restrict producer page to r/o.
@@ -127,7 +129,12 @@ static void bpf_ringbuf_notify(struct irq_work *work)
 	wake_up_all(&rb->waitq);
 }

-static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node)
+static inline bool is_over_writable(struct bpf_ringbuf *rb)
+{
+	return !!rb->over_writable;
+}
+
+static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node, __u32 flags)
 {
 	struct bpf_ringbuf *rb;

@@ -142,6 +149,7 @@ static struct bpf_ringbuf *bpf_ringbuf_alloc(size_t data_sz, int numa_node)
 	rb->mask = data_sz - 1;
 	rb->consumer_pos = 0;
 	rb->producer_pos = 0;
+	rb->over_writable = !!(flags & BFP_F_RB_OVER_WRITABLE);

 	return rb;
 }
@@ -170,7 +178,7 @@ static struct bpf_map *ringbuf_map_alloc(union bpf_attr *attr)

 	bpf_map_init_from_attr(&rb_map->map, attr);

-	rb_map->rb = bpf_ringbuf_alloc(attr->max_entries, rb_map->map.numa_node);
+	rb_map->rb = bpf_ringbuf_alloc(attr->max_entries, rb_map->map.numa_node, attr->map_flags);
 	if (!rb_map->rb) {
 		kfree(rb_map);
 		return ERR_PTR(-ENOMEM);
@@ -244,11 +252,15 @@ static int ringbuf_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)

 static unsigned long ringbuf_avail_data_sz(struct bpf_ringbuf *rb)
 {
-	unsigned long cons_pos, prod_pos;
+	unsigned long cons_pos, prod_pos, diff;

 	cons_pos = smp_load_acquire(&rb->consumer_pos);
 	prod_pos = smp_load_acquire(&rb->producer_pos);
-	return prod_pos - cons_pos;
+	diff = prod_pos - cons_pos;
+
+	if (is_over_writable(rb) && diff > rb->mask)
+		return rb->mask;
+	return diff;
 }

 static __poll_t ringbuf_map_poll(struct bpf_map *map, struct file *filp,
@@ -327,12 +339,29 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 	prod_pos = rb->producer_pos;
 	new_prod_pos = prod_pos + len;

-	/* check for out of ringbuf space by ensuring producer position
-	 * doesn't advance more than (ringbuf_size - 1) ahead
-	 */
-	if (new_prod_pos - cons_pos > rb->mask) {
-		spin_unlock_irqrestore(&rb->spinlock, flags);
-		return NULL;
+	if (!is_over_writable(rb)) {
+		/* check for out of ringbuf space by ensuring producer position
+		 * doesn't advance more than (ringbuf_size - 1) ahead
+		 */
+		if (new_prod_pos - cons_pos > rb->mask) {
+			spin_unlock_irqrestore(&rb->spinlock, flags);
+			return NULL;
+		}
+	} else {
+		/*
+		 * Data length is already rounded to be divisible by 8, but in
+		 * the case of over writing buffer we need to round it again.
+		 * Indeed, when the producer position will cross the buffer
+		 * size, it is possible new position will not be divisible by
+		 * buffer size.
+		 * For example, if len is 520 and buffer size is 4096, then the
+		 * next position after 4096 is 4160.
+		 * This is a problem as it will impede us to over write data
+		 * (4160 & 4095 = 64 which is different from 0).
+		 * So by substracting the modulo of len, we are able to over
+		 * write existing data.
+		 */
+		new_prod_pos -= (new_prod_pos & rb->mask) % len;
 	}

 	hdr = (void *)rb->data + (prod_pos & rb->mask);
--
2.25.1

