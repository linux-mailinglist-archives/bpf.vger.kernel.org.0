Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D84B64976C
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 01:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiLLAiJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Dec 2022 19:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiLLAiI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Dec 2022 19:38:08 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76836B490
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 16:38:07 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id s7so10424961plk.5
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 16:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7mLIzH9QGa/Vp7L1frOgw2MpIN2USRO4iU649EtnEc=;
        b=QwHnrYU5dlXPi4mKazfawl3O2vLOVNWdtMU7R0MIhOaiv6hPJkTBBHO24XgIPdO/Gf
         9na56WI++Cb+a/hnv0W5d43A4c9pZsDP0T6C2ZZl5O2bTxtqze9EQPUi7+XEuVneB6jT
         kticj3IJQ4XUgA+Z1YDssULNPsBFCtJzYxLaHCITVnk6zPI61pwxHeuvswRzdZilRwc0
         G8WrVsH3guWmfGM4IyiM+dMvuNvxlqlKIxYxIRRqC/yJpCDsrbeCXRRYbki05brj76EA
         queFVstoRXm+39NEjEKp+U/sBWNt4j/jCl8AAQzPQO6p0E07EggCIzSsaOAdHCHnNxpH
         bSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7mLIzH9QGa/Vp7L1frOgw2MpIN2USRO4iU649EtnEc=;
        b=rQLqAN3ItPKvU545rIaugrjc6qlOlkeSUBajU8gWfQqBV0+qdp/ZDWaxA7+Afxv4bH
         JiMtFuCr1O+icW3jlzwYgcxqIXXbkiuM9W6nFxqXbyzfWxgwOYZsnnK6zQ1vgCOBYXLe
         m8RIdHpSTwQEc987yyYRglyZ+BR5OehWCsgGn0iz25sW0Rr3i4q1A626T0dJK8A7yKQY
         +fChXy6QkEtBYriJtYbWWrQEpJHdfRvs9cfmZV2xeYjMy+5Ae9JtetrmWxMFN5ZvMG8i
         Ujd2GRO8BMt0uIYRYAuh+nHMtPh947ORnU+QoSfC+kBiO8NjfVKC/qT0cTJtPVDwfH4n
         4mWQ==
X-Gm-Message-State: ANoB5pnhZ/32yEN3Ji0FjH48vw5ellQ66fU5px0nEQgTUJVINMmFV5Cs
        FRxu7EVm0sZw2q+Rnur6lgw=
X-Google-Smtp-Source: AA0mqf5z6xRPI9ZAMyGtUx6mm4rODaDI03F7bbR1btk/8oT+AjpT7zlHoWOWr51yN5JyyqN1xQqw+g==
X-Received: by 2002:a17:902:ab54:b0:189:6bda:e98f with SMTP id ij20-20020a170902ab5400b001896bdae98fmr13586506plb.58.1670805486992;
        Sun, 11 Dec 2022 16:38:06 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7002:8c7:5400:4ff:fe3d:656a])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902e88900b00177fb862a87sm4895960plg.20.2022.12.11.16.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 16:38:06 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        dennis@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 6/9] bpf: Introduce new helpers bpf_ringbuf_pages_{alloc,free}
Date:   Mon, 12 Dec 2022 00:37:08 +0000
Message-Id: <20221212003711.24977-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221212003711.24977-1-laoar.shao@gmail.com>
References: <20221212003711.24977-1-laoar.shao@gmail.com>
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
 kernel/bpf/ringbuf.c | 71 +++++++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 24 deletions(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 80f4b4d88aaf..3264bf509c68 100644
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
2.30.1 (Apple Git-130)

