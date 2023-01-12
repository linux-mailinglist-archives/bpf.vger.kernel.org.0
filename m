Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3FF667A30
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 17:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjALQBW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 11:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbjALQAu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 11:00:50 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C546436
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 07:53:44 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id v14so16767851qtq.3
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 07:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBH19B7tt8c2ZqgTL5MGs4kQ+EgYdVrIXT4FgqCf58E=;
        b=V5AonCl6GtoPHEQDYaUYetOY7qBor5eB4wJnYjHi6v81IJ6LFl63Vb7qTQ6fZ62GmJ
         FZ3VHrJc1gdN1TOHjP2hoB35KssqBdVaaZbEQZ/E5zivkI0c5eo7XBU1gZCICr7Fpmmx
         tK8mbPvFPAdW5NE9w07N1Eta2988UZDI9ppynyPtdFQ5OYtkpv0D4+CkEJpBYNYN+qyQ
         uuqqCAyOCmPlXT/hg59VPHxvJMezaeIia6wBeOewTU0JIGj73v/uGM99APwnJyPb1MAa
         6tlQS2nILNzaj0VNoUnSKxnsveyfjiyJpOyMNF4QnV3ia2uczbf/7pWYoLPwNbm+KQcS
         i0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBH19B7tt8c2ZqgTL5MGs4kQ+EgYdVrIXT4FgqCf58E=;
        b=ubCJJVfszDabdCVoX9hC/8S9QICGAzxCX6irL1PhQzkQgAx/HlRyPkgKXEzDBi8Cae
         z2sbSEZN/V8iSObfcV9fPbMarjsghpvG8436yh63sYAfhA2RZp0FaLFFmYRWs6kdsKBr
         jGrAC8zSh+2SSETdxtUOQPIMuBxYcOyPvd88q/JGJC9cAKWwIF1B3fsTd7UpgTcqHdV6
         hpJyWDhyRT9Toe5oOr4LmZ+9bakCSWKSI3c46Rp63FypRwjMM3meF/3ymzaHENkgcmZb
         b78d+JuKr8DJeJusuttLlknLRZfR4A3vnnzuTPmLQt9YUq1YU//IRjTubfZ/YIyVb6aW
         OEKQ==
X-Gm-Message-State: AFqh2kq+Py74Ju+76aUlO818qYjVzAhF5nuYsOt76eOkWmDCRhVj7pOv
        QXgKFJUrrfVkZe+HSIGsfKU=
X-Google-Smtp-Source: AMrXdXunMQbXCe3PjTlqR622vY/D62Blbxfq9VYi3TCPRza8jAekLqfz3F3c2jSj1Xlfyg52SWyWbw==
X-Received: by 2002:ac8:7957:0:b0:3ad:903d:3ed4 with SMTP id r23-20020ac87957000000b003ad903d3ed4mr19548488qtt.59.1673538823178;
        Thu, 12 Jan 2023 07:53:43 -0800 (PST)
Received: from vultr.guest ([173.199.122.241])
        by smtp.gmail.com with ESMTPSA id l17-20020ac848d1000000b003ab43dabfb1sm9280836qtr.55.2023.01.12.07.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:53:42 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     42.hyeyoo@gmail.com, vbabka@suse.cz, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, tj@kernel.org, dennis@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next v2 07/11] bpf: introduce new helpers bpf_ringbuf_pages_{alloc,free}
Date:   Thu, 12 Jan 2023 15:53:22 +0000
Message-Id: <20230112155326.26902-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230112155326.26902-1-laoar.shao@gmail.com>
References: <20230112155326.26902-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allocate pages related memory into the new helper
bpf_ringbuf_pages_alloc(), then it can be handled as a single unit.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/ringbuf.c | 71 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 24 deletions(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 80f4b4d..3264bf5 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -92,6 +92,48 @@ struct bpf_ringbuf_hdr {
 	u32 pg_off;
 };
 
+static void bpf_ringbuf_pages_free(struct page **pages, int nr_pages)
+{
+	int i;
+
+	for (i = 0; i < nr_pages; i++)
+		__free_page(pages[i]);
+	bpf_map_area_free(pages);
+}
+
+static struct page **bpf_ringbuf_pages_alloc(int nr_meta_pages,
+						int nr_data_pages, int numa_node,
+						const gfp_t flags)
+{
+	int nr_pages = nr_meta_pages + nr_data_pages;
+	struct page **pages, *page;
+	int array_size;
+	int i;
+
+	array_size = (nr_meta_pages + 2 * nr_data_pages) * sizeof(*pages);
+	pages = bpf_map_area_alloc(array_size, numa_node);
+	if (!pages)
+		goto err;
+
+	for (i = 0; i < nr_pages; i++) {
+		page = alloc_pages_node(numa_node, flags, 0);
+		if (!page) {
+			nr_pages = i;
+			goto err_free_pages;
+		}
+		pages[i] = page;
+		if (i >= nr_meta_pages)
+			pages[nr_data_pages + i] = page;
+	}
+
+	return pages;
+
+err_free_pages:
+	bpf_ringbuf_pages_free(pages, nr_pages);
+err:
+	return NULL;
+}
+
 static struct bpf_ringbuf *bpf_ringbuf_area_alloc(size_t data_sz, int numa_node)
 {
 	const gfp_t flags = GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL |
@@ -99,10 +141,8 @@ static struct bpf_ringbuf *bpf_ringbuf_area_alloc(size_t data_sz, int numa_node)
 	int nr_meta_pages = RINGBUF_PGOFF + RINGBUF_POS_PAGES;
 	int nr_data_pages = data_sz >> PAGE_SHIFT;
 	int nr_pages = nr_meta_pages + nr_data_pages;
-	struct page **pages, *page;
 	struct bpf_ringbuf *rb;
-	size_t array_size;
-	int i;
+	struct page **pages;
 
 	/* Each data page is mapped twice to allow "virtual"
 	 * continuous read of samples wrapping around the end of ring
@@ -121,22 +161,11 @@ static struct bpf_ringbuf *bpf_ringbuf_area_alloc(size_t data_sz, int numa_node)
 	 * when mmap()'ed in user-space, simplifying both kernel and
 	 * user-space implementations significantly.
 	 */
-	array_size = (nr_meta_pages + 2 * nr_data_pages) * sizeof(*pages);
-	pages = bpf_map_area_alloc(array_size, numa_node);
+	pages = bpf_ringbuf_pages_alloc(nr_meta_pages, nr_data_pages,
+									numa_node, flags);
 	if (!pages)
 		return NULL;
 
-	for (i = 0; i < nr_pages; i++) {
-		page = alloc_pages_node(numa_node, flags, 0);
-		if (!page) {
-			nr_pages = i;
-			goto err_free_pages;
-		}
-		pages[i] = page;
-		if (i >= nr_meta_pages)
-			pages[nr_data_pages + i] = page;
-	}
-
 	rb = vmap(pages, nr_meta_pages + 2 * nr_data_pages,
 		  VM_MAP | VM_USERMAP, PAGE_KERNEL);
 	if (rb) {
@@ -146,10 +175,6 @@ static struct bpf_ringbuf *bpf_ringbuf_area_alloc(size_t data_sz, int numa_node)
 		return rb;
 	}
 
-err_free_pages:
-	for (i = 0; i < nr_pages; i++)
-		__free_page(pages[i]);
-	bpf_map_area_free(pages);
 	return NULL;
 }
 
@@ -219,12 +244,10 @@ static void bpf_ringbuf_free(struct bpf_ringbuf *rb)
 	 * to unmap rb itself with vunmap() below
 	 */
 	struct page **pages = rb->pages;
-	int i, nr_pages = rb->nr_pages;
+	int nr_pages = rb->nr_pages;
 
 	vunmap(rb);
-	for (i = 0; i < nr_pages; i++)
-		__free_page(pages[i]);
-	bpf_map_area_free(pages);
+	bpf_ringbuf_pages_free(pages, nr_pages);
 }
 
 static void ringbuf_map_free(struct bpf_map *map)
-- 
1.8.3.1

