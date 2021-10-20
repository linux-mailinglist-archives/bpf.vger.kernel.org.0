Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FC9435476
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 22:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhJTUUa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 16:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhJTUUa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 16:20:30 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA14C06161C;
        Wed, 20 Oct 2021 13:18:15 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id kk10so3302544pjb.1;
        Wed, 20 Oct 2021 13:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vbSLdA5BeyrPjgTgiYcsKfpAqPAtA25K47UBY8eUAAM=;
        b=JKGX7GB1LT9erI3J35P3Ax1hsz/rSWqt0KglJP9T5G9G64yBhRmlnEn/TVSXpfkwdF
         j/hc59I7zmlNzPSAfuQpkVfZedVU+bc/iXn+mzRejS9k8ZhELWksJqh5T7v4F7xL7s74
         maf6vXhzKdCM6Da52j1+ySZmAdhnZ7cjwVDBfrgf7hUKOlo4NEVlwqJF5lkvjLXEeSYb
         3NLMHF3MCVSSsunRN9rdABJ1/5hL6JU40GjgmsbN360E78HdjlFVVqpoCrF3SxpM4bjK
         vQYWP556KEeoGOe3bSwa4hIpAgojicvqe2X9WUgYUI9ouii4joPAzX6biZsf9kx5E5zA
         i7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vbSLdA5BeyrPjgTgiYcsKfpAqPAtA25K47UBY8eUAAM=;
        b=DR5VLIpfN6nCYQqB3gJUxTWBWKb5+esG9482Nn9t2bmHWRqCdfbzvxqRGJVhCilPvA
         nly+rQkuUU91a8j1LTFMcoZxzTOUerK07dCTU9iGumfJnELQMSXtjwwfyrtSBJ2go9/q
         RS3OpWFoXFsUMzNL+0yAWGbiD2vHozzH9KrN6FMKQh7WnYQ/YK078PGgPfNJcs/zLKUv
         Z3bylwXJyB6lJJrQz7cgtxSvKXfwJqnqCpwsTJ2ZqMKMMOUDJnhbf8ehUPlnOo+uclv/
         Rn6MHagBGCher93u3RU3zl3ZxfpF58s49wDJxRKbK7w5PRFgsBVpUBcuk+tsWr9eG8nS
         ceXA==
X-Gm-Message-State: AOAM530G1PKODWJjryk376LjcIwzEKm00R9ettmpwaspOBkTVRQ8QFcy
        qBFrOS6OFbGmExtwiOtF5nI2cTsSrttzmA==
X-Google-Smtp-Source: ABdhPJy6OmpK4poVG5s5M76Foqpx6dgZZSVhFUcvl7CxozARawOfC0Yn/NwTg0be4DfZjWsoZQXzfA==
X-Received: by 2002:a17:90b:4f8a:: with SMTP id qe10mr1180339pjb.27.1634761094762;
        Wed, 20 Oct 2021 13:18:14 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id u11sm3540804pfg.2.2021.10.20.13.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 13:18:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 20 Oct 2021 10:18:13 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     bpf@vger.kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] bpf: Implement prealloc for task_local_storage
Message-ID: <YXB5hWFCzJDISnrK@slm.duckdns.org>
References: <YXB5Mec4ahxXRx8K@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXB5Mec4ahxXRx8K@slm.duckdns.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From 5e3ad0d4a0b0732e7ebe035582d282ab752397ed Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Wed, 20 Oct 2021 08:56:53 -1000

task_local_storage currently does not support pre-allocation and the memory
is allocated on demand using the GFP_ATOMIC mask. While atomic allocations
succeed most of the time and the occasional failures aren't a problem for
many use-cases, there are some which can benefit from reliable allocations -
e.g. tracking acquisitions and releases of specific resources to root cause
long-term reference leaks.

Prealloc semantics for task_local_storage:

* When a prealloc map is created, the map's elements for all existing tasks
  are allocated.

* Afterwards, whenever a new task is forked, it automatically allocates the
  elements for the existing preallocated maps.

To synchronize against concurrent forks, CONFIG_BPF_SYSCALL now enables
CONFIG_THREADGROUP_RWSEM and prealloc task_local_storage creation path
write-locks threadgroup_rwsem, and the rest of the implementation is
straight-forward.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/bpf.h                           |   6 +
 include/linux/bpf_local_storage.h             |  12 ++
 kernel/bpf/Kconfig                            |   1 +
 kernel/bpf/bpf_local_storage.c                | 112 ++++++++++----
 kernel/bpf/bpf_task_storage.c                 | 138 +++++++++++++++++-
 kernel/fork.c                                 |   8 +-
 .../bpf/prog_tests/task_local_storage.c       | 101 +++++++++++++
 .../selftests/bpf/progs/task_ls_prealloc.c    |  15 ++
 8 files changed, 361 insertions(+), 32 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/task_ls_prealloc.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d604c8251d88..7f9e5dea0660 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1673,6 +1673,7 @@ struct bpf_prog *bpf_prog_by_id(u32 id);
 struct bpf_link *bpf_link_by_id(u32 id);
 
 const struct bpf_func_proto *bpf_base_func_proto(enum bpf_func_id func_id);
+int bpf_task_storage_fork(struct task_struct *task);
 void bpf_task_storage_free(struct task_struct *task);
 bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
 const struct btf_func_model *
@@ -1882,6 +1883,11 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 	return NULL;
 }
 
+static inline int bpf_task_storage_fork(struct task_struct *p)
+{
+	return 0;
+}
+
 static inline void bpf_task_storage_free(struct task_struct *task)
 {
 }
diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 24496bc28e7b..bbb4cedbd2b2 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -51,6 +51,12 @@ struct bpf_local_storage_map {
 	u32 bucket_log;
 	u16 elem_size;
 	u16 cache_idx;
+	/* Maps with prealloc need to be tracked and allocated when a new
+	 * containing object is created. The following node can be used to keep
+	 * track of the prealloc maps. Outside of initializing the field, the
+	 * shared local_storage code doesn't use it directly.
+	 */
+	struct list_head prealloc_node;
 };
 
 struct bpf_local_storage_data {
@@ -118,6 +124,7 @@ void bpf_local_storage_cache_idx_free(struct bpf_local_storage_cache *cache,
 
 /* Helper functions for bpf_local_storage */
 int bpf_local_storage_map_alloc_check(union bpf_attr *attr);
+int bpf_local_storage_prealloc_map_alloc_check(union bpf_attr *attr);
 
 struct bpf_local_storage_map *bpf_local_storage_map_alloc(union bpf_attr *attr);
 
@@ -158,6 +165,11 @@ bpf_local_storage_alloc(void *owner,
 			struct bpf_local_storage_elem *first_selem);
 
 struct bpf_local_storage_data *
+__bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
+			   void *value, u64 map_flags,
+			   struct bpf_local_storage **local_storage_prealloc,
+			   struct bpf_local_storage_elem **selem_prealloc);
+struct bpf_local_storage_data *
 bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 			 void *value, u64 map_flags);
 
diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index a82d6de86522..4d816664026f 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -29,6 +29,7 @@ config BPF_SYSCALL
 	select IRQ_WORK
 	select TASKS_TRACE_RCU
 	select BINARY_PRINTF
+	select THREADGROUP_RWSEM
 	select NET_SOCK_MSG if NET
 	default n
 	help
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index b305270b7a4b..0a6bf3e4bbcd 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -258,24 +258,13 @@ static int check_flags(const struct bpf_local_storage_data *old_sdata,
 	return 0;
 }
 
-int bpf_local_storage_alloc(void *owner,
-			    struct bpf_local_storage_map *smap,
-			    struct bpf_local_storage_elem *first_selem)
+static int bpf_local_storage_link(void *owner,
+				  struct bpf_local_storage_map *smap,
+				  struct bpf_local_storage_elem *first_selem,
+				  struct bpf_local_storage *storage)
 {
-	struct bpf_local_storage *prev_storage, *storage;
+	struct bpf_local_storage *prev_storage;
 	struct bpf_local_storage **owner_storage_ptr;
-	int err;
-
-	err = mem_charge(smap, owner, sizeof(*storage));
-	if (err)
-		return err;
-
-	storage = bpf_map_kzalloc(&smap->map, sizeof(*storage),
-				  GFP_ATOMIC | __GFP_NOWARN);
-	if (!storage) {
-		err = -ENOMEM;
-		goto uncharge;
-	}
 
 	INIT_HLIST_HEAD(&storage->list);
 	raw_spin_lock_init(&storage->lock);
@@ -299,8 +288,7 @@ int bpf_local_storage_alloc(void *owner,
 	prev_storage = cmpxchg(owner_storage_ptr, NULL, storage);
 	if (unlikely(prev_storage)) {
 		bpf_selem_unlink_map(first_selem);
-		err = -EAGAIN;
-		goto uncharge;
+		return -EAGAIN;
 
 		/* Note that even first_selem was linked to smap's
 		 * bucket->list, first_selem can be freed immediately
@@ -313,6 +301,31 @@ int bpf_local_storage_alloc(void *owner,
 	}
 
 	return 0;
+}
+
+int bpf_local_storage_alloc(void *owner,
+			   struct bpf_local_storage_map *smap,
+			   struct bpf_local_storage_elem *first_selem)
+{
+	struct bpf_local_storage *storage;
+	int err;
+
+	err = mem_charge(smap, owner, sizeof(*storage));
+	if (err)
+		return err;
+
+	storage = bpf_map_kzalloc(&smap->map, sizeof(*storage),
+				  GFP_ATOMIC | __GFP_NOWARN);
+	if (!storage) {
+		err = -ENOMEM;
+		goto uncharge;
+	}
+
+	err = bpf_local_storage_link(owner, smap, first_selem, storage);
+	if (err)
+		goto uncharge;
+
+	return 0;
 
 uncharge:
 	kfree(storage);
@@ -326,8 +339,10 @@ int bpf_local_storage_alloc(void *owner,
  * during map destruction).
  */
 struct bpf_local_storage_data *
-bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
-			 void *value, u64 map_flags)
+__bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
+			   void *value, u64 map_flags,
+			   struct bpf_local_storage **local_storage_prealloc,
+			   struct bpf_local_storage_elem **selem_prealloc)
 {
 	struct bpf_local_storage_data *old_sdata = NULL;
 	struct bpf_local_storage_elem *selem;
@@ -349,17 +364,30 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		if (err)
 			return ERR_PTR(err);
 
-		selem = bpf_selem_alloc(smap, owner, value, true);
+		if (*selem_prealloc)
+			selem = *selem_prealloc;
+		else
+			selem = bpf_selem_alloc(smap, owner, value, true);
 		if (!selem)
 			return ERR_PTR(-ENOMEM);
 
-		err = bpf_local_storage_alloc(owner, smap, selem);
+		if (*local_storage_prealloc) {
+			err = bpf_local_storage_link(owner, smap, selem,
+						     *local_storage_prealloc);
+		} else {
+			err = bpf_local_storage_alloc(owner, smap, selem);
+		}
 		if (err) {
-			kfree(selem);
-			mem_uncharge(smap, owner, smap->elem_size);
+			if (!*selem_prealloc) {
+				kfree(selem);
+				mem_uncharge(smap, owner, smap->elem_size);
+			}
 			return ERR_PTR(err);
 		}
 
+		*selem_prealloc = NULL;
+		*local_storage_prealloc = NULL;
+
 		return SDATA(selem);
 	}
 
@@ -414,10 +442,15 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	 * old_sdata will not be uncharged later during
 	 * bpf_selem_unlink_storage_nolock().
 	 */
-	selem = bpf_selem_alloc(smap, owner, value, !old_sdata);
-	if (!selem) {
-		err = -ENOMEM;
-		goto unlock_err;
+	if (*selem_prealloc) {
+		selem = *selem_prealloc;
+		*selem_prealloc = NULL;
+	} else {
+		selem = bpf_selem_alloc(smap, owner, value, !old_sdata);
+		if (!selem) {
+			err = -ENOMEM;
+			goto unlock_err;
+		}
 	}
 
 	/* First, link the new selem to the map */
@@ -442,6 +475,17 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	return ERR_PTR(err);
 }
 
+struct bpf_local_storage_data *
+bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
+			 void *value, u64 map_flags)
+{
+	struct bpf_local_storage *local_storage_prealloc = NULL;
+	struct bpf_local_storage_elem *selem_prealloc = NULL;
+
+	return __bpf_local_storage_update(owner, smap, value, map_flags,
+					  &local_storage_prealloc, &selem_prealloc);
+}
+
 u16 bpf_local_storage_cache_idx_get(struct bpf_local_storage_cache *cache)
 {
 	u64 min_usage = U64_MAX;
@@ -536,10 +580,9 @@ void bpf_local_storage_map_free(struct bpf_local_storage_map *smap,
 	kfree(smap);
 }
 
-int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
+int bpf_local_storage_prealloc_map_alloc_check(union bpf_attr *attr)
 {
 	if (attr->map_flags & ~BPF_LOCAL_STORAGE_CREATE_FLAG_MASK ||
-	    !(attr->map_flags & BPF_F_NO_PREALLOC) ||
 	    attr->max_entries ||
 	    attr->key_size != sizeof(int) || !attr->value_size ||
 	    /* Enforce BTF for userspace sk dumping */
@@ -555,6 +598,13 @@ int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
 	return 0;
 }
 
+int bpf_local_storage_map_alloc_check(union bpf_attr *attr)
+{
+	if (!(attr->map_flags & BPF_F_NO_PREALLOC))
+		return -EINVAL;
+	return bpf_local_storage_prealloc_map_alloc_check(attr);
+}
+
 struct bpf_local_storage_map *bpf_local_storage_map_alloc(union bpf_attr *attr)
 {
 	struct bpf_local_storage_map *smap;
@@ -586,6 +636,8 @@ struct bpf_local_storage_map *bpf_local_storage_map_alloc(union bpf_attr *attr)
 	smap->elem_size =
 		sizeof(struct bpf_local_storage_elem) + attr->value_size;
 
+	INIT_LIST_HEAD(&smap->prealloc_node);
+
 	return smap;
 }
 
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index ebfa8bc90892..6f8b781647f7 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -17,11 +17,15 @@
 #include <uapi/linux/btf.h>
 #include <linux/btf_ids.h>
 #include <linux/fdtable.h>
+#include <linux/sched/threadgroup_rwsem.h>
 
 DEFINE_BPF_STORAGE_CACHE(task_cache);
 
 static DEFINE_PER_CPU(int, bpf_task_storage_busy);
 
+/* Protected by threadgroup_rwsem. */
+static LIST_HEAD(prealloc_smaps);
+
 static void bpf_task_storage_lock(void)
 {
 	migrate_disable();
@@ -280,14 +284,103 @@ static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
 	return -ENOTSUPP;
 }
 
+static int task_storage_map_populate(struct bpf_local_storage_map *smap)
+{
+	struct bpf_local_storage *storage = NULL;
+	struct bpf_local_storage_elem *selem = NULL;
+	struct task_struct *p, *g;
+	int err = 0;
+
+	lockdep_assert_held(&threadgroup_rwsem);
+retry:
+	if (!storage)
+		storage = bpf_map_kzalloc(&smap->map, sizeof(*storage),
+					  GFP_USER);
+	if (!selem)
+		selem = bpf_map_kzalloc(&smap->map, smap->elem_size, GFP_USER);
+	if (!storage || !selem) {
+		err = -ENOMEM;
+		goto out_free;
+	}
+
+	rcu_read_lock();
+	bpf_task_storage_lock();
+
+	for_each_process_thread(g, p) {
+		struct bpf_local_storage_data *sdata;
+
+		/* Try inserting with atomic allocations. On failure, retry with
+		 * the preallocated ones.
+		 */
+		sdata = bpf_local_storage_update(p, smap, NULL, BPF_NOEXIST);
+
+		if (PTR_ERR(sdata) == -ENOMEM && storage && selem) {
+			sdata = __bpf_local_storage_update(p, smap, NULL,
+							   BPF_NOEXIST,
+							   &storage, &selem);
+		}
+
+		/* Check -EEXIST before need_resched() to guarantee forward
+		 * progress.
+		 */
+		if (PTR_ERR(sdata) == -EEXIST)
+			continue;
+
+		/* If requested or alloc failed, take a breather and loop back
+		 * to preallocate.
+		 */
+		if (need_resched() ||
+		    PTR_ERR(sdata) == -EAGAIN || PTR_ERR(sdata) == -ENOMEM) {
+			bpf_task_storage_unlock();
+			rcu_read_unlock();
+			cond_resched();
+			goto retry;
+		}
+
+		if (IS_ERR(sdata)) {
+			err = PTR_ERR(sdata);
+			goto out_unlock;
+		}
+	}
+out_unlock:
+	bpf_task_storage_unlock();
+	rcu_read_unlock();
+out_free:
+	if (storage)
+		kfree(storage);
+	if (selem)
+		kfree(selem);
+	return err;
+}
+
 static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
 {
 	struct bpf_local_storage_map *smap;
+	int err;
 
 	smap = bpf_local_storage_map_alloc(attr);
 	if (IS_ERR(smap))
 		return ERR_CAST(smap);
 
+	if (!(attr->map_flags & BPF_F_NO_PREALLOC)) {
+		/* We're going to exercise the regular update path to populate
+		 * the map for the existing tasks, which will call into map ops
+		 * which is normally initialized after this function returns.
+		 * Initialize it early here.
+		 */
+		smap->map.ops = &task_storage_map_ops;
+
+		percpu_down_write(&threadgroup_rwsem);
+		list_add_tail(&smap->prealloc_node, &prealloc_smaps);
+		err = task_storage_map_populate(smap);
+		percpu_up_write(&threadgroup_rwsem);
+		if (err) {
+			bpf_local_storage_map_free(smap,
+						   &bpf_task_storage_busy);
+			return ERR_PTR(err);
+		}
+	}
+
 	smap->cache_idx = bpf_local_storage_cache_idx_get(&task_cache);
 	return &smap->map;
 }
@@ -298,13 +391,20 @@ static void task_storage_map_free(struct bpf_map *map)
 
 	smap = (struct bpf_local_storage_map *)map;
 	bpf_local_storage_cache_idx_free(&task_cache, smap->cache_idx);
+
+	if (!list_empty(&smap->prealloc_node)) {
+		percpu_down_write(&threadgroup_rwsem);
+		list_del_init(&smap->prealloc_node);
+		percpu_up_write(&threadgroup_rwsem);
+	}
+
 	bpf_local_storage_map_free(smap, &bpf_task_storage_busy);
 }
 
 static int task_storage_map_btf_id;
 const struct bpf_map_ops task_storage_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
-	.map_alloc_check = bpf_local_storage_map_alloc_check,
+	.map_alloc_check = bpf_local_storage_prealloc_map_alloc_check,
 	.map_alloc = task_storage_map_alloc,
 	.map_free = task_storage_map_free,
 	.map_get_next_key = notsupp_get_next_key,
@@ -317,6 +417,42 @@ const struct bpf_map_ops task_storage_map_ops = {
 	.map_owner_storage_ptr = task_storage_ptr,
 };
 
+int bpf_task_storage_fork(struct task_struct *task)
+{
+	struct bpf_local_storage_map *smap;
+
+	percpu_rwsem_assert_held(&threadgroup_rwsem);
+
+	list_for_each_entry(smap, &prealloc_smaps, prealloc_node) {
+		struct bpf_local_storage *storage;
+		struct bpf_local_storage_elem *selem;
+		struct bpf_local_storage_data *sdata;
+
+		storage = bpf_map_kzalloc(&smap->map, sizeof(*storage),
+					  GFP_USER);
+		selem = bpf_map_kzalloc(&smap->map, smap->elem_size, GFP_USER);
+
+		rcu_read_lock();
+		bpf_task_storage_lock();
+		sdata = __bpf_local_storage_update(task, smap, NULL, BPF_NOEXIST,
+						   &storage, &selem);
+		bpf_task_storage_unlock();
+		rcu_read_unlock();
+
+		if (storage)
+			kfree(storage);
+		if (selem)
+			kfree(selem);
+
+		if (IS_ERR(sdata)) {
+			bpf_task_storage_free(task);
+			return PTR_ERR(sdata);
+		}
+	}
+
+	return 0;
+}
+
 const struct bpf_func_proto bpf_task_storage_get_proto = {
 	.func = bpf_task_storage_get,
 	.gpl_only = false,
diff --git a/kernel/fork.c b/kernel/fork.c
index 34fb9db59148..845c49c6e89b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2290,6 +2290,10 @@ static __latent_entropy struct task_struct *copy_process(
 
 	threadgroup_change_begin(current);
 
+	retval = bpf_task_storage_fork(p);
+	if (retval)
+		goto bad_fork_threadgroup_change_end;
+
 	/*
 	 * Ensure that the cgroup subsystem policies allow the new process to be
 	 * forked. It should be noted that the new process's css_set can be changed
@@ -2298,7 +2302,7 @@ static __latent_entropy struct task_struct *copy_process(
 	 */
 	retval = cgroup_can_fork(p, args);
 	if (retval)
-		goto bad_fork_threadgroup_change_end;
+		goto bad_fork_bpf_task_storage_free;
 
 	/*
 	 * From this point on we must avoid any synchronous user-space
@@ -2427,6 +2431,8 @@ static __latent_entropy struct task_struct *copy_process(
 	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
 	cgroup_cancel_fork(p, args);
+bad_fork_bpf_task_storage_free:
+	bpf_task_storage_free(p);
 bad_fork_threadgroup_change_end:
 	threadgroup_change_end(current);
 bad_fork_put_pidfd:
diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index 035c263aab1b..ad35470db991 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -5,10 +5,21 @@
 #include <unistd.h>
 #include <sys/syscall.h>   /* For SYS_xxx definitions */
 #include <sys/types.h>
+#include <sys/wait.h>
 #include <test_progs.h>
 #include "task_local_storage.skel.h"
 #include "task_local_storage_exit_creds.skel.h"
 #include "task_ls_recursion.skel.h"
+#include "task_ls_prealloc.skel.h"
+
+#ifndef __NR_pidfd_open
+#define __NR_pidfd_open 434
+#endif
+
+static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
+{
+	return syscall(__NR_pidfd_open, pid, flags);
+}
 
 static void test_sys_enter_exit(void)
 {
@@ -81,6 +92,94 @@ static void test_recursion(void)
 	task_ls_recursion__destroy(skel);
 }
 
+static int fork_prealloc_child(int *pipe_fd)
+{
+	int pipe_fds[2], pid_fd, err;
+	pid_t pid;
+
+	err = pipe(pipe_fds);
+	if (!ASSERT_OK(err, "pipe"))
+		return -1;
+
+	*pipe_fd = pipe_fds[1];
+
+	pid = fork();
+	if (pid == 0) {
+		char ch;
+		close(pipe_fds[1]);
+		read(pipe_fds[0], &ch, 1);
+		exit(0);
+	}
+
+	if (!ASSERT_GE(pid, 0, "fork"))
+		return -1;
+
+	pid_fd = sys_pidfd_open(pid, 0);
+	if (!ASSERT_GE(pid_fd, 0, "pidfd_open"))
+		return -1;
+
+	return pid_fd;
+}
+
+static void test_prealloc_elem(int map_fd, int pid_fd)
+{
+	int val, err;
+
+	err = bpf_map_lookup_elem(map_fd, &pid_fd, &val);
+	if (ASSERT_OK(err, "bpf_map_lookup_elem"))
+		ASSERT_EQ(val, 0, "elem value == 0");
+
+	val = 0xdeadbeef;
+	err = bpf_map_update_elem(map_fd, &pid_fd, &val, BPF_EXIST);
+	ASSERT_OK(err, "bpf_map_update_elem to 0xdeadbeef");
+
+	err = bpf_map_lookup_elem(map_fd, &pid_fd, &val);
+	if (ASSERT_OK(err, "bpf_map_lookup_elem"))
+		ASSERT_EQ(val, 0xdeadbeef, "elem value == 0xdeadbeef");
+}
+
+static void test_prealloc(void)
+{
+	struct task_ls_prealloc *skel = NULL;
+	int pre_pipe_fd = -1, post_pipe_fd = -1;
+	int pre_pid_fd, post_pid_fd;
+	int map_fd, err;
+
+	pre_pid_fd = fork_prealloc_child(&pre_pipe_fd);
+	if (pre_pid_fd < 0)
+		goto out;
+
+	skel = task_ls_prealloc__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		goto out;
+
+	err = task_ls_prealloc__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto out;
+
+	post_pid_fd = fork_prealloc_child(&post_pipe_fd);
+	if (post_pid_fd < 0)
+		goto out;
+
+	map_fd = bpf_map__fd(skel->maps.prealloc_map);
+	if (!ASSERT_GE(map_fd, 0, "bpf_map__fd"))
+		goto out;
+
+	test_prealloc_elem(map_fd, pre_pid_fd);
+	test_prealloc_elem(map_fd, post_pid_fd);
+out:
+	if (pre_pipe_fd >= 0)
+		close(pre_pipe_fd);
+	if (post_pipe_fd >= 0)
+		close(post_pipe_fd);
+	do {
+		err = wait4(-1, NULL, 0, NULL);
+	} while (!err);
+
+	if (skel)
+		task_ls_prealloc__destroy(skel);
+}
+
 void test_task_local_storage(void)
 {
 	if (test__start_subtest("sys_enter_exit"))
@@ -89,4 +188,6 @@ void test_task_local_storage(void)
 		test_exit_creds();
 	if (test__start_subtest("recursion"))
 		test_recursion();
+	if (test__start_subtest("prealloc"))
+		test_prealloc();
 }
diff --git a/tools/testing/selftests/bpf/progs/task_ls_prealloc.c b/tools/testing/selftests/bpf/progs/task_ls_prealloc.c
new file mode 100644
index 000000000000..8b252ee3511e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/task_ls_prealloc.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, 0);
+	__type(key, int);
+	__type(value, int);
+} prealloc_map SEC(".maps");
-- 
2.33.1

