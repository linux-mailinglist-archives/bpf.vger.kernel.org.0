Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B063649769
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 01:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiLLAhx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Dec 2022 19:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiLLAhw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Dec 2022 19:37:52 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C61F49
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 16:37:51 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id p24so10438345plw.1
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 16:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FpiiW8tlCQuBLdcxwgK57oWmDCwhuuS+u14RJYhlmk=;
        b=blDmjwOG5yBpOKGDu4OqOJfK6YDC2tIgsaA++wSa0spxRtLKgIr7tNI1/nRT1GOLtp
         kmICcOuS0tuAzHuhsh3L4tSLzOkTgZDXK8KlHTw1Zulv2p2rFKaK5DBXCtOzTWLLXLXM
         nFdtzntL+7qlYziM7IZ6Z9Eu20pf9537iCQMLsJ0nKLZ5Z4nBKTo3jKnKyTXIkZWEMWK
         uToyEoyYinHFpycXiVUdruUq96vWChVYpvMHF5dpYLdnhpth42d/gxX097KBpmpTJCFt
         EHawh4kk5/jSb54tQVSkfcXVjAF6va6Pb8fF0SIuMb5dMRpI7dzXrhcTgE9Jtr+vFpZy
         8VbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FpiiW8tlCQuBLdcxwgK57oWmDCwhuuS+u14RJYhlmk=;
        b=YQLx5qrX4tfjtQy1nb3FzFNQuyBEzbQql4Qg5AOex1rSoCW9NKtF+wOpNMLILlhWYb
         SdyxYTwIq41A6FDfMBd3ClHGIWvM+A11DxWQ23RB0pj3+Um/5WxDBiSAA+fBARfMWDH1
         lDsipYAMThfTLS34lq91pCKq8iFEghq9JCG7re6UkChZauSX4rU7fWzRmopfrmIuDB5B
         V14FgvnPiBZCm0NOcmBgpl4JzpowgT6toIBAIzkQv1Lmk6+9CBdNI4+IjPps3rWy+EJ3
         DzCUVfZrTCfB9NgL9v9PFUNAfXhCY/ZakjoIjS1Hr5O+Gqhs9MXsFXot2zALT3s/tHqe
         8xIQ==
X-Gm-Message-State: ANoB5plaPeIc+VKVD0MoRpWI/9MHahuRNhLiPDhaGQP1k3MJ1O/a/FFS
        A2xnd+SWV8w9B1sEmUoRx2w=
X-Google-Smtp-Source: AA0mqf6sGfx5c19Rrfw5tyzmw9AMZXV+iZ/hNtnw3UdNnuW5oRiZL8CBPsG6dFQMVoMUC2lhjL16RA==
X-Received: by 2002:a17:902:b58c:b0:189:184d:f0ff with SMTP id a12-20020a170902b58c00b00189184df0ffmr13651625pls.11.1670805471482;
        Sun, 11 Dec 2022 16:37:51 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7002:8c7:5400:4ff:fe3d:656a])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902e88900b00177fb862a87sm4895960plg.20.2022.12.11.16.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 16:37:50 -0800 (PST)
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
Subject: [RFC PATCH bpf-next 3/9] mm: percpu: Account active vm for percpu
Date:   Mon, 12 Dec 2022 00:37:05 +0000
Message-Id: <20221212003711.24977-4-laoar.shao@gmail.com>
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

Account percpu allocation when active vm item is set. The percpu memory
is accounted at percpu alloc and unaccount at percpu free. To record
which part of percpu chunk is enabled with active vm, we have to
allocate extra memory for this percpu chunk to record the active vm
information. This extra memory will be freed when this percpu chunk
is freed.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 mm/percpu-internal.h |  3 +++
 mm/percpu.c          | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index 70b1ea23f4d2..f56e236a2cf3 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -63,6 +63,9 @@ struct pcpu_chunk {
 	int			nr_pages;	/* # of pages served by this chunk */
 	int			nr_populated;	/* # of populated pages */
 	int                     nr_empty_pop_pages; /* # of empty populated pages */
+#ifdef CONFIG_ACTIVE_VM
+	int			*active_vm;	/* vector of activem vm items */
+#endif
 	unsigned long		populated[];	/* populated bitmap */
 };
 
diff --git a/mm/percpu.c b/mm/percpu.c
index 27697b2429c2..05858981ed4a 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -98,6 +98,7 @@
 #include <trace/events/percpu.h>
 
 #include "percpu-internal.h"
+#include "active_vm.h"
 
 /*
  * The slots are sorted by the size of the biggest continuous free area.
@@ -1398,6 +1399,9 @@ static struct pcpu_chunk * __init pcpu_alloc_first_chunk(unsigned long tmp_addr,
 #ifdef CONFIG_MEMCG_KMEM
 	/* first chunk is free to use */
 	chunk->obj_cgroups = NULL;
+#endif
+#ifdef CONFIG_ACTIVE_VM
+	chunk->active_vm = NULL;
 #endif
 	pcpu_init_md_blocks(chunk);
 
@@ -1476,6 +1480,14 @@ static struct pcpu_chunk *pcpu_alloc_chunk(gfp_t gfp)
 	}
 #endif
 
+#ifdef CONFIG_ACTIVE_VM
+	if (active_vm_enabled()) {
+		chunk->active_vm = pcpu_mem_zalloc(pcpu_chunk_map_bits(chunk) *
+								sizeof(int), gfp);
+		if (!chunk->active_vm)
+			goto active_vm_fail;
+	}
+#endif
 	pcpu_init_md_blocks(chunk);
 
 	/* init metadata */
@@ -1483,6 +1495,12 @@ static struct pcpu_chunk *pcpu_alloc_chunk(gfp_t gfp)
 
 	return chunk;
 
+#ifdef CONFIG_ACTIVE_VM
+active_vm_fail:
+#ifdef CONFIG_MEMCG_KMEM
+	pcpu_mem_free(chunk->obj_cgroups);
+#endif
+#endif
 #ifdef CONFIG_MEMCG_KMEM
 objcg_fail:
 	pcpu_mem_free(chunk->md_blocks);
@@ -1501,6 +1519,9 @@ static void pcpu_free_chunk(struct pcpu_chunk *chunk)
 {
 	if (!chunk)
 		return;
+#ifdef CONFIG_ACTIVE_VM
+	pcpu_mem_free(chunk->active_vm);
+#endif
 #ifdef CONFIG_MEMCG_KMEM
 	pcpu_mem_free(chunk->obj_cgroups);
 #endif
@@ -1890,6 +1911,17 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 
 	pcpu_memcg_post_alloc_hook(objcg, chunk, off, size);
 
+#ifdef CONFIG_ACTIVE_VM
+	if (active_vm_enabled() && chunk->active_vm && (gfp & __GFP_ACCOUNT)) {
+		int item = active_vm_item();
+
+		if (item > 0) {
+			chunk->active_vm[off >> PCPU_MIN_ALLOC_SHIFT] = item;
+			active_vm_item_add(item, size);
+		}
+	}
+#endif
+
 	return ptr;
 
 fail_unlock:
@@ -2283,6 +2315,17 @@ void free_percpu(void __percpu *ptr)
 
 	pcpu_memcg_free_hook(chunk, off, size);
 
+#ifdef CONFIG_ACTIVE_VM
+	if (active_vm_enabled() && chunk->active_vm) {
+		int item = chunk->active_vm[off >> PCPU_MIN_ALLOC_SHIFT];
+
+		if (item > 0) {
+			active_vm_item_sub(item, size);
+			chunk->active_vm[off >> PCPU_MIN_ALLOC_SHIFT] = 0;
+		}
+	}
+#endif
+
 	/*
 	 * If there are more than one fully free chunks, wake up grim reaper.
 	 * If the chunk is isolated, it may be in the process of being
-- 
2.30.1 (Apple Git-130)

