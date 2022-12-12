Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A6264976F
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 01:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiLLAiZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Dec 2022 19:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiLLAiY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Dec 2022 19:38:24 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AC62628
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 16:38:23 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so10461934pjo.3
        for <bpf@vger.kernel.org>; Sun, 11 Dec 2022 16:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuT3qM92ko5qNO6YfTKcWz9SzFB1kaIJ+qSW7zfvd0I=;
        b=gM322d7VHc70+Y+yPUkReUGDHOAeBFOhMgXzKuk0JkfN6IOXVglSZdhh4zPFpN6mUO
         +OqZNeJ1Wp4vk1UoHHU19GMs3op5YQixNEJ3LUHzTMwg5j8jEY6LqFzaEAXvRxENB/Py
         H0nGejN4Fi62x3SVbNBuFCdHJLjwJKpvQC85hWLBAGXxE05mN4E+Rn+pLN3umlHx2etJ
         0XlrD/WA5q3xQdbAEsl6N0eMr9rk1tGNN01jprIg5FztL6ELOdSLoV/5DSl0LNFakvNk
         SXcYpwXhexJxJlHYJ+6IvSy2tT2Nr2xFSlPwUyoSs307vM2Ux7y2ejgY4VlFtD7zQ2qM
         3cXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuT3qM92ko5qNO6YfTKcWz9SzFB1kaIJ+qSW7zfvd0I=;
        b=AZBq9wkUjjWeSq0emCVn6YOnb5Ut/fzpadbKcsjoUrLF6Lpy/S5EilzG+uzxcSm/FI
         gn55m1FPfsRBfC6k8d20UcxUxJOHECegwQjBVJSOk+lOtEdLCd9pt9qPEU9YbOG1aYzR
         Mjdu2IYJp8O2eXRDolQsE3IhRxGXB5RrsAHHe9THNqHhDta87XnGqce4e8rDjwaRQLGM
         zmLq8L93xBx1w0zS6cFjVkB5iulEPzWBUR+Ep2rPHJna75QtUg+mFhpWa9yM1fzYy/Tz
         AI3KPt0CQQtLSCdu+LEb4Go6MB1KnkZs1nTLonmCoXZO0ckwJvVG3yRinVC1TvuBfdfJ
         sbow==
X-Gm-Message-State: ANoB5pnebj5Nq/ZYIFWTBwI+d3B/Qhm9HKoLr+uUZb32Eyf6+yl/1HbH
        JQ55qZ0EwytSZWpu1aKwO74=
X-Google-Smtp-Source: AA0mqf7HtLLdgXzJmiQSUymEYADGmF93YA+PMZ7qB6+IJuIV4O0kni0uKc6ddVPvmjdEaBO4DiKkaQ==
X-Received: by 2002:a17:902:ea03:b0:18e:1549:9131 with SMTP id s3-20020a170902ea0300b0018e15499131mr9666025plg.23.1670805502513;
        Sun, 11 Dec 2022 16:38:22 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7002:8c7:5400:4ff:fe3d:656a])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902e88900b00177fb862a87sm4895960plg.20.2022.12.11.16.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 16:38:21 -0800 (PST)
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
Subject: [RFC PATCH bpf-next 9/9] bpf: Use active vm to account bpf map memory usage
Date:   Mon, 12 Dec 2022 00:37:11 +0000
Message-Id: <20221212003711.24977-10-laoar.shao@gmail.com>
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

The memory allocation via bpf_map_*alloc or bpf memalloc are accounted
with active vm. We only need to annotate the allocation. These memory
will automatically unaccount when they are freed.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 fs/proc/meminfo.c         |  3 +++
 include/linux/active_vm.h | 10 +++++-----
 kernel/bpf/memalloc.c     |  5 +++++
 kernel/bpf/ringbuf.c      |  8 ++++++--
 kernel/bpf/syscall.c      | 25 +++++++++++++++++++++++--
 5 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 440960110a42..efe1fbd6a80e 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -16,6 +16,7 @@
 #ifdef CONFIG_CMA
 #include <linux/cma.h>
 #endif
+#include <linux/active_vm.h>
 #include <asm/page.h>
 #include "internal.h"
 
@@ -159,6 +160,8 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 
 	arch_report_meminfo(m);
 
+	seq_printf(m,  "BPF:            %8lu kB\n",
+			active_vm_item_sum(ACTIVE_VM_BPF) >> 10);
 	return 0;
 }
 
diff --git a/include/linux/active_vm.h b/include/linux/active_vm.h
index 21f9aaca12c4..e26edfb3654e 100644
--- a/include/linux/active_vm.h
+++ b/include/linux/active_vm.h
@@ -2,6 +2,11 @@
 #ifndef __INCLUDE_ACTIVE_VM_H
 #define __INCLUDE_ACTIVE_VM_H
 
+enum active_vm_item {
+	ACTIVE_VM_BPF = 1,
+	NR_ACTIVE_VM_ITEM = ACTIVE_VM_BPF,
+};
+
 #ifdef CONFIG_ACTIVE_VM
 #include <linux/jump_label.h>
 #include <linux/preempt.h>
@@ -18,11 +23,6 @@ static inline bool active_vm_enabled(void)
 	return true;
 }
 
-enum active_vm_item {
-	DUMMY_ITEM = 1,
-	NR_ACTIVE_VM_ITEM = DUMMY_ITEM,
-};
-
 struct active_vm_stat {
 	long stat[NR_ACTIVE_VM_ITEM];
 };
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index ebcc3dd0fa19..403ae0d83241 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -7,6 +7,8 @@
 #include <linux/bpf_mem_alloc.h>
 #include <linux/memcontrol.h>
 #include <asm/local.h>
+#include <linux/page_ext.h>
+#include <linux/active_vm.h>
 
 /* Any context (including NMI) BPF specific memory allocator.
  *
@@ -165,11 +167,13 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 {
 	struct mem_cgroup *memcg = NULL, *old_memcg;
 	unsigned long flags;
+	int old_active_vm;
 	void *obj;
 	int i;
 
 	memcg = get_memcg(c);
 	old_memcg = set_active_memcg(memcg);
+	old_active_vm = active_vm_item_set(ACTIVE_VM_BPF);
 	for (i = 0; i < cnt; i++) {
 		/*
 		 * free_by_rcu is only manipulated by irq work refill_work().
@@ -209,6 +213,7 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 		if (IS_ENABLED(CONFIG_PREEMPT_RT))
 			local_irq_restore(flags);
 	}
+	active_vm_item_set(old_active_vm);
 	set_active_memcg(old_memcg);
 	mem_cgroup_put(memcg);
 }
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 3264bf509c68..7575f078eb34 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -11,6 +11,7 @@
 #include <linux/kmemleak.h>
 #include <uapi/linux/btf.h>
 #include <linux/btf_ids.h>
+#include <linux/active_vm.h>
 
 #define RINGBUF_CREATE_FLAG_MASK (BPF_F_NUMA_NODE)
 
@@ -107,16 +108,18 @@ static struct page **bpf_ringbuf_pages_alloc(int nr_meta_pages,
 {
 	int nr_pages = nr_meta_pages + nr_data_pages;
 	struct page **pages, *page;
+	int old_active_vm;
 	int array_size;
 	int i;
 
+	old_active_vm = active_vm_item_set(ACTIVE_VM_BPF);
 	array_size = (nr_meta_pages + 2 * nr_data_pages) * sizeof(*pages);
 	pages = bpf_map_area_alloc(array_size, numa_node);
 	if (!pages)
 		goto err;
 
 	for (i = 0; i < nr_pages; i++) {
-		page = alloc_pages_node(numa_node, flags, 0);
+		page = alloc_pages_node(numa_node, flags | __GFP_ACCOUNT, 0);
 		if (!page) {
 			nr_pages = i;
 			goto err_free_pages;
@@ -125,12 +128,13 @@ static struct page **bpf_ringbuf_pages_alloc(int nr_meta_pages,
 		if (i >= nr_meta_pages)
 			pages[nr_data_pages + i] = page;
 	}
-
+	active_vm_item_set(old_active_vm);
 	return pages;
 
 err_free_pages:
 	bpf_ringbuf_pages_free(pages, nr_pages);
 err:
+	active_vm_item_set(old_active_vm);
 	return NULL;
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c38875d6aea4..92572d4a09fb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -35,6 +35,8 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/memcontrol.h>
 #include <linux/trace_events.h>
+#include <linux/page_ext.h>
+#include <linux/active_vm.h>
 
 #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
 			  (map)->map_type == BPF_MAP_TYPE_CGROUP_ARRAY || \
@@ -312,11 +314,14 @@ static void *__bpf_map_area_alloc(u64 size, int numa_node, bool mmapable)
 	const gfp_t gfp = __GFP_NOWARN | __GFP_ZERO | __GFP_ACCOUNT;
 	unsigned int flags = 0;
 	unsigned long align = 1;
+	int old_active_vm;
 	void *area;
+	void *ptr;
 
 	if (size >= SIZE_MAX)
 		return NULL;
 
+	old_active_vm = active_vm_item_set(ACTIVE_VM_BPF);
 	/* kmalloc()'ed memory can't be mmap()'ed */
 	if (mmapable) {
 		BUG_ON(!PAGE_ALIGNED(size));
@@ -325,13 +330,17 @@ static void *__bpf_map_area_alloc(u64 size, int numa_node, bool mmapable)
 	} else if (size <= (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER)) {
 		area = kmalloc_node(size, gfp | GFP_USER | __GFP_NORETRY,
 				    numa_node);
-		if (area != NULL)
+		if (area != NULL) {
+			active_vm_item_set(old_active_vm);
 			return area;
+		}
 	}
 
-	return __vmalloc_node_range(size, align, VMALLOC_START, VMALLOC_END,
+	ptr = __vmalloc_node_range(size, align, VMALLOC_START, VMALLOC_END,
 			gfp | GFP_KERNEL | __GFP_RETRY_MAYFAIL, PAGE_KERNEL,
 			flags, numa_node, __builtin_return_address(0));
+	active_vm_item_set(old_active_vm);
+	return ptr;
 }
 
 void *bpf_map_area_alloc(u64 size, int numa_node)
@@ -445,11 +454,14 @@ void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
 			   int node)
 {
 	struct mem_cgroup *memcg, *old_memcg;
+	int old_active_vm;
 	void *ptr;
 
 	memcg = bpf_map_get_memcg(map);
 	old_memcg = set_active_memcg(memcg);
+	old_active_vm = active_vm_item_set(ACTIVE_VM_BPF);
 	ptr = kmalloc_node(size, flags | __GFP_ACCOUNT, node);
+	active_vm_item_set(old_active_vm);
 	set_active_memcg(old_memcg);
 	mem_cgroup_put(memcg);
 
@@ -459,11 +471,14 @@ void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
 void *bpf_map_kzalloc(const struct bpf_map *map, size_t size, gfp_t flags)
 {
 	struct mem_cgroup *memcg, *old_memcg;
+	int old_active_vm;
 	void *ptr;
 
 	memcg = bpf_map_get_memcg(map);
 	old_memcg = set_active_memcg(memcg);
+	old_active_vm = active_vm_item_set(ACTIVE_VM_BPF);
 	ptr = kzalloc(size, flags | __GFP_ACCOUNT);
+	active_vm_item_set(old_active_vm);
 	set_active_memcg(old_memcg);
 	mem_cgroup_put(memcg);
 
@@ -474,11 +489,14 @@ void *bpf_map_kvcalloc(struct bpf_map *map, size_t n, size_t size,
 		       gfp_t flags)
 {
 	struct mem_cgroup *memcg, *old_memcg;
+	int old_active_vm;
 	void *ptr;
 
 	memcg = bpf_map_get_memcg(map);
 	old_memcg = set_active_memcg(memcg);
+	old_active_vm = active_vm_item_set(ACTIVE_VM_BPF);
 	ptr = kvcalloc(n, size, flags | __GFP_ACCOUNT);
+	active_vm_item_set(old_active_vm);
 	set_active_memcg(old_memcg);
 	mem_cgroup_put(memcg);
 
@@ -490,10 +508,13 @@ void __percpu *bpf_map_alloc_percpu(const struct bpf_map *map, size_t size,
 {
 	struct mem_cgroup *memcg, *old_memcg;
 	void __percpu *ptr;
+	int old_active_vm;
 
 	memcg = bpf_map_get_memcg(map);
 	old_memcg = set_active_memcg(memcg);
+	old_active_vm = active_vm_item_set(ACTIVE_VM_BPF);
 	ptr = __alloc_percpu_gfp(size, align, flags | __GFP_ACCOUNT);
+	active_vm_item_set(old_active_vm);
 	set_active_memcg(old_memcg);
 	mem_cgroup_put(memcg);
 
-- 
2.30.1 (Apple Git-130)

