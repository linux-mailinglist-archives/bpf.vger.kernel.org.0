Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49377667A35
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 17:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjALQB1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 11:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjALQAy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 11:00:54 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CEA64E2
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 07:53:49 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id fd15so6842335qtb.9
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 07:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHBLuOt22MmYduNrNXpPncXZaLhT6xO/3AZAghLO+28=;
        b=PFL20qpJup5OHKv9UPkTO7fFgClOp8U9dXkFVAS69SL27zMiYGmBTuMYEO0GgGywQ0
         V193glQ5i21Tw/cAkUxdMyN8zuEXZkM/mm8oX8ZYLoPWz0EWoeX1NqhCNUKoQ0wEjWYY
         CsQojYbPs+HGgxdT6CxkpJqTasLIyBCw7BrnDBw49VpR/0pX1xavKhdlPIH2loiOhbbZ
         K4g3kNIRNj3Qg/ZcZSZ2GY7YuAxuiZSwMEh+zl1GIQz2O8ge6wnA+0C4RLes/fgHs3U5
         VXhsJZBUy4FhEd+GR2eoW8qt3YKLUTFhpXRwZ4MpqkzMq7f7Dt2wJHqm5Ss1//i4Dm1A
         eJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHBLuOt22MmYduNrNXpPncXZaLhT6xO/3AZAghLO+28=;
        b=fox4bl1kwM7F7siWTn2VgzK2BLAJ/cjsc4r91Wiy7oTJDrp0h1TGZVX7PGoxxidDfW
         NtgbXui+Ovukj3bdu8xzhkT8nKuqIbGGp5uI2OPx8NE6l2fnPX319NEY56FBv9/w0Dg7
         EI8KeCm6+Uye0DDZTTDjiK3djAnJIMODhzeJg9MN4JSO5iioVQ70rxLKBLRMl5DgE74I
         isuVIdDnqxQSUCIDPQl75zTFOO9PlV3cFi/dKGFL4Txz+HBXt0pek1XQjLWiVW8bhYOW
         s1wHnHE5hVI0KFPAEdf+lvodoH3gBmQ+joQ1BbKX9bn9+jmw2yXC3/7iXUNo3f+RmQcd
         o3wA==
X-Gm-Message-State: AFqh2kpY8GvQmWRDaHvX1qVcpqdMcd1/Bvv/7AkwyUt4CW/hCB2zG1uZ
        /DtolKfd/Az6Vv9+uZF3s7o=
X-Google-Smtp-Source: AMrXdXtch+HYePOFAPhpj0/byz/XWiJclPWZEbWn/oV7C6FmuW8LQxsnkoeOAzPoqykxf8NIdgRnPQ==
X-Received: by 2002:ac8:4601:0:b0:3af:7bf6:d209 with SMTP id p1-20020ac84601000000b003af7bf6d209mr13302883qtn.45.1673538828928;
        Thu, 12 Jan 2023 07:53:48 -0800 (PST)
Received: from vultr.guest ([173.199.122.241])
        by smtp.gmail.com with ESMTPSA id l17-20020ac848d1000000b003ab43dabfb1sm9280836qtr.55.2023.01.12.07.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:53:48 -0800 (PST)
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
Subject: [RFC PATCH bpf-next v2 11/11] bpf: introduce bpf memory statistics
Date:   Thu, 12 Jan 2023 15:53:26 +0000
Message-Id: <20230112155326.26902-12-laoar.shao@gmail.com>
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

It introduces a new percpu global variable to store bpf memory
statistic. It will adds this percpu variable at bpf memory allocation
and subs this percpu variable at bpf memory freeing. A new item "BPF" is
added into /proc/meminfo to show the bpf memory statistic.

Pls. note that there're some deferred freeing, for example the
kfree_rcu(), vfree_deferred(). For these deferred freeing, the in-flight
memory may be not freed immediately after we subs them from the bpf memory
statistic. But it won't take long time to free them, so this behavior is
acceptible.

Below is the output,
$ grep BPF /proc/meminfo
BPF:              358 kB

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 fs/proc/meminfo.c     |  4 +++
 include/linux/bpf.h   | 92 +++++++++++++++++++++++++++++++++++++++++++++++----
 kernel/bpf/memalloc.c | 19 ++++++++++-
 kernel/bpf/ringbuf.c  |  4 +++
 kernel/bpf/syscall.c  | 39 ++++++++++++++++++++--
 5 files changed, 149 insertions(+), 9 deletions(-)

diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 4409601..5b67331 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -16,6 +16,7 @@
 #ifdef CONFIG_CMA
 #include <linux/cma.h>
 #endif
+#include <linux/bpf.h>
 #include <asm/page.h>
 #include "internal.h"
 
@@ -159,6 +160,9 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 
 	arch_report_meminfo(m);
 
+	seq_printf(m,  "BPF:            %8lu kB\n",
+			bpf_mem_stat_sum() >> 10);
+
 	return 0;
 }
 
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 17c218e..add307e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1869,23 +1869,71 @@ int  generic_map_delete_batch(struct bpf_map *map,
 struct bpf_map *bpf_map_get_curr_or_next(u32 *id);
 struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
 
+struct bpf_mem_stat {
+	long stat;
+};
+
+DECLARE_PER_CPU(struct bpf_mem_stat, bpfmm);
+
+static inline void bpf_mem_stat_add(size_t cnt)
+{
+	this_cpu_add(bpfmm.stat, cnt);
+}
+
+static inline void bpf_mem_stat_sub(size_t cnt)
+{
+	this_cpu_sub(bpfmm.stat, cnt);
+}
+
+static inline long bpf_mem_stat_sum(void)
+{
+	struct bpf_mem_stat *this;
+	long sum = 0;
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		this = &per_cpu(bpfmm, cpu);
+		sum += this->stat;
+	}
+
+	return sum;
+}
 
 static inline void bpf_map_kfree(const void *ptr)
 {
+	size_t sz = ksize_full(ptr);
+
+	if (sz)
+		bpf_mem_stat_sub(sz);
 	kfree(ptr);
 }
 
 static inline void bpf_map_kvfree(const void *ptr)
 {
+	size_t sz = kvsize(ptr);
+
+	if (sz)
+		bpf_mem_stat_sub(sz);
 	kvfree(ptr);
 }
 
 static inline void bpf_map_free_percpu(void __percpu *ptr)
 {
+	size_t sz = percpu_size(ptr);
+
+	if (sz)
+		bpf_mem_stat_sub(sz);
 	free_percpu(ptr);
 }
 
-#define bpf_map_kfree_rcu(ptr, rhf...) kvfree_rcu(ptr, ## rhf)
+#define bpf_map_kfree_rcu(ptr, rhf...)			\
+do {											\
+	size_t sz = kvsize(ptr);					\
+												\
+	if (sz)										\
+		bpf_mem_stat_sub(sz);					\
+	kvfree_rcu(ptr, ## rhf);					\
+} while (0)
 
 #ifdef CONFIG_MEMCG_KMEM
 void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
@@ -1901,26 +1949,54 @@ void __percpu *bpf_map_alloc_percpu(const struct bpf_map *map, size_t size,
 bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
 		     int node)
 {
-	return kmalloc_node(size, flags, node);
+	void *ptr;
+	size_t sz;
+
+	ptr = kmalloc_node(size, flags, node);
+	sz = ksize_full(ptr);
+	if (sz)
+		bpf_mem_stat_add(sz);
+	return ptr;
 }
 
 static inline void *
 bpf_map_kzalloc(const struct bpf_map *map, size_t size, gfp_t flags)
 {
-	return kzalloc(size, flags);
+	void *ptr;
+	size_t sz;
+
+	ptr = kzalloc(size, flags);
+	sz = ksize_full(ptr);
+	if (sz)
+		bpf_mem_stat_add(sz);
+	return ptr;
 }
 
 static inline void *
 bpf_map_kvcalloc(struct bpf_map *map, size_t n, size_t size, gfp_t flags)
 {
-	return kvcalloc(n, size, flags);
+	void *ptr;
+	size_t sz;
+
+	ptr = kvcalloc(n, size, flags);
+	sz = kvsize(ptr);
+	if (sz)
+		bpf_mem_stat_add(sz);
+	return ptr;
 }
 
 static inline void __percpu *
 bpf_map_alloc_percpu(const struct bpf_map *map, size_t size, size_t align,
 		     gfp_t flags)
 {
-	return __alloc_percpu_gfp(size, align, flags);
+	void *ptr;
+	size_t sz;
+
+	ptr = __alloc_percpu_gfp(size, align, flags);
+	sz = percpu_size(ptr);
+	if (sz)
+		bpf_mem_stat_add(sz);
+	return ptr;
 }
 #endif
 
@@ -2461,6 +2537,11 @@ static inline void bpf_prog_inc_misses_counter(struct bpf_prog *prog)
 static inline void bpf_cgrp_storage_free(struct cgroup *cgroup)
 {
 }
+
+static inline long bpf_mem_stat_sum(void)
+{
+	return 0;
+}
 #endif /* CONFIG_BPF_SYSCALL */
 
 void __bpf_free_used_btfs(struct bpf_prog_aux *aux,
@@ -2886,5 +2967,4 @@ static inline bool type_is_alloc(u32 type)
 {
 	return type & MEM_ALLOC;
 }
-
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index ebcc3dd..4e35f287 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -129,6 +129,8 @@ static void *__alloc(struct bpf_mem_cache *c, int node)
 	 * want here.
 	 */
 	gfp_t flags = GFP_NOWAIT | __GFP_NOWARN | __GFP_ACCOUNT;
+	void *ptr;
+	size_t sz;
 
 	if (c->percpu_size) {
 		void **obj = kmalloc_node(c->percpu_size, flags, node);
@@ -140,10 +142,18 @@ static void *__alloc(struct bpf_mem_cache *c, int node)
 			return NULL;
 		}
 		obj[1] = pptr;
+		sz = ksize_full(obj);
+		sz += percpu_size(pptr);
+		if (sz)
+			bpf_mem_stat_add(sz);
 		return obj;
 	}
 
-	return kmalloc_node(c->unit_size, flags, node);
+	ptr = kmalloc_node(c->unit_size, flags, node);
+	sz = ksize_full(ptr);
+	if (sz)
+		bpf_mem_stat_add(sz);
+	return ptr;
 }
 
 static struct mem_cgroup *get_memcg(const struct bpf_mem_cache *c)
@@ -215,12 +225,19 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
 
 static void free_one(struct bpf_mem_cache *c, void *obj)
 {
+	size_t sz = ksize_full(obj);
+
 	if (c->percpu_size) {
+		sz += percpu_size(((void **)obj)[1]);
+		if (sz)
+			bpf_mem_stat_sub(sz);
 		free_percpu(((void **)obj)[1]);
 		kfree(obj);
 		return;
 	}
 
+	if (sz)
+		bpf_mem_stat_sub(sz);
 	kfree(obj);
 }
 
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 3264bf5..766c2f1 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -96,6 +96,7 @@ static void bpf_ringbuf_pages_free(struct page **pages, int nr_pages)
 {
 	int i;
 
+	bpf_mem_stat_sub(nr_pages * PAGE_SIZE);
 	for (i = 0; i < nr_pages; i++)
 		__free_page(pages[i]);
 	bpf_map_area_free(pages);
@@ -126,9 +127,12 @@ static struct page **bpf_ringbuf_pages_alloc(int nr_meta_pages,
 			pages[nr_data_pages + i] = page;
 	}
 
+	bpf_mem_stat_add(nr_pages * PAGE_SIZE);
 	return pages;
 
 err_free_pages:
+	if (nr_pages)
+		bpf_mem_stat_add(nr_pages * PAGE_SIZE);
 	bpf_ringbuf_pages_free(pages, nr_pages);
 err:
 	return NULL;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9e266e8..6ca2ceb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -46,6 +46,7 @@
 
 #define BPF_OBJ_FLAG_MASK   (BPF_F_RDONLY | BPF_F_WRONLY)
 
+DEFINE_PER_CPU(struct bpf_mem_stat, bpfmm);
 DEFINE_PER_CPU(int, bpf_prog_active);
 static DEFINE_IDR(prog_idr);
 static DEFINE_SPINLOCK(prog_idr_lock);
@@ -336,16 +337,34 @@ static void *__bpf_map_area_alloc(u64 size, int numa_node, bool mmapable)
 
 void *bpf_map_area_alloc(u64 size, int numa_node)
 {
-	return __bpf_map_area_alloc(size, numa_node, false);
+	size_t sz;
+	void *ptr;
+
+	ptr = __bpf_map_area_alloc(size, numa_node, false);
+	sz = kvsize(ptr);
+	if (sz)
+		bpf_mem_stat_add(sz);
+	return ptr;
 }
 
 void *bpf_map_area_mmapable_alloc(u64 size, int numa_node)
 {
-	return __bpf_map_area_alloc(size, numa_node, true);
+	size_t sz;
+	void *ptr;
+
+	ptr =  __bpf_map_area_alloc(size, numa_node, true);
+	sz = kvsize(ptr);
+	if (sz)
+		bpf_mem_stat_add(sz);
+	return ptr;
 }
 
 void bpf_map_area_free(void *area)
 {
+	size_t sz = kvsize(area);
+
+	if (sz)
+		bpf_mem_stat_sub(sz);
 	kvfree(area);
 }
 
@@ -446,12 +465,16 @@ void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
 {
 	struct mem_cgroup *memcg, *old_memcg;
 	void *ptr;
+	size_t sz;
 
 	memcg = bpf_map_get_memcg(map);
 	old_memcg = set_active_memcg(memcg);
 	ptr = kmalloc_node(size, flags | __GFP_ACCOUNT, node);
 	set_active_memcg(old_memcg);
 	mem_cgroup_put(memcg);
+	sz = ksize_full(ptr);
+	if (sz)
+		bpf_mem_stat_add(sz);
 
 	return ptr;
 }
@@ -460,12 +483,16 @@ void *bpf_map_kzalloc(const struct bpf_map *map, size_t size, gfp_t flags)
 {
 	struct mem_cgroup *memcg, *old_memcg;
 	void *ptr;
+	size_t sz;
 
 	memcg = bpf_map_get_memcg(map);
 	old_memcg = set_active_memcg(memcg);
 	ptr = kzalloc(size, flags | __GFP_ACCOUNT);
 	set_active_memcg(old_memcg);
 	mem_cgroup_put(memcg);
+	sz = ksize_full(ptr);
+	if (sz)
+		bpf_mem_stat_add(sz);
 
 	return ptr;
 }
@@ -475,12 +502,16 @@ void *bpf_map_kvcalloc(struct bpf_map *map, size_t n, size_t size,
 {
 	struct mem_cgroup *memcg, *old_memcg;
 	void *ptr;
+	size_t sz;
 
 	memcg = bpf_map_get_memcg(map);
 	old_memcg = set_active_memcg(memcg);
 	ptr = kvcalloc(n, size, flags | __GFP_ACCOUNT);
 	set_active_memcg(old_memcg);
 	mem_cgroup_put(memcg);
+	sz = kvsize(ptr);
+	if (sz)
+		bpf_mem_stat_add(sz);
 
 	return ptr;
 }
@@ -490,12 +521,16 @@ void __percpu *bpf_map_alloc_percpu(const struct bpf_map *map, size_t size,
 {
 	struct mem_cgroup *memcg, *old_memcg;
 	void __percpu *ptr;
+	size_t sz;
 
 	memcg = bpf_map_get_memcg(map);
 	old_memcg = set_active_memcg(memcg);
 	ptr = __alloc_percpu_gfp(size, align, flags | __GFP_ACCOUNT);
 	set_active_memcg(old_memcg);
 	mem_cgroup_put(memcg);
+	sz = percpu_size(ptr);
+	if (sz)
+		bpf_mem_stat_add(sz);
 
 	return ptr;
 }
-- 
1.8.3.1

