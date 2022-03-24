Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9966F4E6B48
	for <lists+bpf@lfdr.de>; Fri, 25 Mar 2022 00:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356385AbiCXXoM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Mar 2022 19:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356440AbiCXXnD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Mar 2022 19:43:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B69927CFB
        for <bpf@vger.kernel.org>; Thu, 24 Mar 2022 16:41:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y32-20020a25ad20000000b006339fb8e18cso4771255ybi.9
        for <bpf@vger.kernel.org>; Thu, 24 Mar 2022 16:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tLfVhuftDS2I97SfE/fCAmNEtl4mglUQ3ZiplfSvBYs=;
        b=MyneO3w2pWRzsuKRSo39wsFCCS5zIcPCI5YckBT39sTeFZG9S+TPytRRLCxdOMQEtc
         D5nxfBH76+TK3lYZ4yUPCQS9f0YU1om2bujQG2cxtvFmntFnCkBcnPw1eMMJkRv6y/Df
         j+1F3rfdUJBU4mOW+qCxNjptsyAiN8qKSZPC0Pda5rRrzCpHW9wkZyjLsbmpcT6wJmNa
         sove9I3+fQVM0td930CDd29erKq6T7P7OadZaFCu2lrdQ/bU7fZ9IECKWCboZC75amOy
         bvTCCwrwWedfp9k15QNUa3g6Hj3L5K/gYMde+a2Kz3s7bgfBwHO8rODy9KvmBoaX3rUu
         AvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tLfVhuftDS2I97SfE/fCAmNEtl4mglUQ3ZiplfSvBYs=;
        b=0yWzZki535K8ZO+7oC5Oe7XjUc2kDylbHwjR6pS9SjkDe/ns9fbBDMr+SmFQuvaMnk
         Xz3hZPqBkuRYktGNyy/Z019B16WOQ0IaGMhl1fU6PP+S5c4e46KSDZpyLJn3CMyNrNrO
         zJ8hZlrrXkWi114l0uRqoUnDfg+U4sQ6NAjz0wg4L3LeXzHQN4Pu6szQhUXdzaTqY2rJ
         HbxvV3EWIq+xB6fpDoPdnJHro0T6hWtmgHRaJb+24J6nmJ2/AFUCWWcEv5VchsV9lTh/
         x5xEM8efapiak+g9facMsu6K1JJfMxn9BQHx0djjadEth/1zk7e78ysGjOYoQ16gzTRZ
         p5HA==
X-Gm-Message-State: AOAM532/8/65p8U0HL/RWlc8FNspJoxgfvrdnltlBeAsVqKVULwNtDmq
        hlha+VD2I+E1BrgLrCd335pX8HZrWrs=
X-Google-Smtp-Source: ABdhPJxLNpRtYopxr92jZEhZzxZ72y70Ho05qx2sIUyAgsYScZUqcJs3NnNusOWUvsCblGexwTEsUEBwnzE=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:f3eb:bf7b:2da4:12c9])
 (user=haoluo job=sendgmr) by 2002:a81:517:0:b0:2e6:af62:b11 with SMTP id
 23-20020a810517000000b002e6af620b11mr7979743ywf.234.1648165289479; Thu, 24
 Mar 2022 16:41:29 -0700 (PDT)
Date:   Thu, 24 Mar 2022 16:41:22 -0700
In-Reply-To: <20220324234123.1608337-1-haoluo@google.com>
Message-Id: <20220324234123.1608337-2-haoluo@google.com>
Mime-Version: 1.0
References: <20220324234123.1608337-1-haoluo@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH RFC bpf-next 1/2] bpf: Mmapable local storage.
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     yhs@fb.com, KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some map types support mmap operation, which allows userspace to
communicate with BPF programs directly. Currently only arraymap
and ringbuf have mmap implemented.

However, in some use cases, when multiple program instances can
run concurrently, global mmapable memory can cause race. In that
case, userspace needs to provide necessary synchronizations to
coordinate the usage of mapped global data. This can be a source
of bottleneck.

It would be great to have a mmapable local storage in that case.
This patch adds that.

Mmap isn't BPF syscall, so unpriv users can also use it to
interact with maps.

Currently the only way of allocating mmapable map area is using
vmalloc() and it's only used at map allocation time. Vmalloc()
may sleep, therefore it's not suitable for maps that may allocate
memory in an atomic context such as local storage. Local storage
uses kmalloc() with GFP_ATOMIC, which doesn't sleep. This patch
uses kmalloc() with GFP_ATOMIC as well for mmapable map area.

Allocating mmapable memory has requirment on page alignment. So we
have to deliberately allocate more memory than necessary to obtain
an address that has sdata->data aligned at page boundary. The
calculations for mmapable allocation size, and the actual
allocation/deallocation are packaged in three functions:

 - bpf_map_mmapable_alloc_size()
 - bpf_map_mmapable_kzalloc()
 - bpf_map_mmapable_kfree()

BPF local storage uses them to provide generic mmap API:

 - bpf_local_storage_mmap()

And task local storage adds the mmap callback:

 - task_storage_map_mmap()

When application calls mmap on a task local storage, it gets its
own local storage.

Overall, mmapable local storage trades off memory with flexibility
and efficiency. It brings memory fragmentation but can make programs
stateless. Therefore useful in some cases.

Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Hao Luo <haoluo@google.com>
---
 include/linux/bpf.h               |  4 ++
 include/linux/bpf_local_storage.h |  5 ++-
 kernel/bpf/bpf_local_storage.c    | 73 ++++++++++++++++++++++++++++---
 kernel/bpf/bpf_task_storage.c     | 40 +++++++++++++++++
 kernel/bpf/syscall.c              | 67 ++++++++++++++++++++++++++++
 5 files changed, 181 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bdb5298735ce..d76b8d6f91d2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1549,6 +1549,10 @@ bpf_map_alloc_percpu(const struct bpf_map *map, size_t size, size_t align,
 	return __alloc_percpu_gfp(size, align, flags);
 }
 #endif
+size_t bpf_map_mmapable_alloc_size(size_t size, size_t offset);
+void *bpf_map_mmapable_kzalloc(const struct bpf_map *map, size_t size,
+			       size_t offset, gfp_t flags);
+void bpf_map_mmapable_kfree(void *ptr);
 
 extern int sysctl_unprivileged_bpf_disabled;
 
diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 493e63258497..36dc1102ec48 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -74,7 +74,8 @@ struct bpf_local_storage_elem {
 	struct hlist_node snode;	/* Linked to bpf_local_storage */
 	struct bpf_local_storage __rcu *local_storage;
 	struct rcu_head rcu;
-	/* 8 bytes hole */
+	u32 map_flags;
+	/* 4 bytes hole */
 	/* The data is stored in another cacheline to minimize
 	 * the number of cachelines access during a cache hit.
 	 */
@@ -168,4 +169,6 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 
 void bpf_local_storage_free_rcu(struct rcu_head *rcu);
 
+int bpf_local_storage_mmap(struct bpf_local_storage_map *smap, void *data,
+			   struct vm_area_struct *vma);
 #endif /* _BPF_LOCAL_STORAGE_H */
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 01aa2b51ec4d..4dd1d7af4451 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -15,7 +15,7 @@
 #include <linux/rcupdate_trace.h>
 #include <linux/rcupdate_wait.h>
 
-#define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK (BPF_F_NO_PREALLOC | BPF_F_CLONE)
+#define BPF_LOCAL_STORAGE_CREATE_FLAG_MASK (BPF_F_NO_PREALLOC | BPF_F_CLONE | BPF_F_MMAPABLE)
 
 static struct bpf_local_storage_map_bucket *
 select_bucket(struct bpf_local_storage_map *smap,
@@ -66,13 +66,26 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 		void *value, bool charge_mem, gfp_t gfp_flags)
 {
 	struct bpf_local_storage_elem *selem;
+	struct bpf_map *map = &smap->map;
 
 	if (charge_mem && mem_charge(smap, owner, smap->elem_size))
 		return NULL;
 
-	selem = bpf_map_kzalloc(&smap->map, smap->elem_size,
-				gfp_flags | __GFP_NOWARN);
+	if (map->map_flags & BPF_F_MMAPABLE) {
+		size_t offset;
+
+		offset = offsetof(struct bpf_local_storage_elem, sdata) +
+			offsetof(struct bpf_local_storage_data, data);
+		selem = bpf_map_mmapable_kzalloc(&smap->map, offset,
+						 map->value_size,
+						 gfp_flags | __GFP_NOWARN);
+	} else {
+		selem = bpf_map_kzalloc(&smap->map, smap->elem_size,
+					gfp_flags | __GFP_NOWARN);
+	}
+
 	if (selem) {
+		selem->map_flags = map->map_flags;
 		if (value)
 			memcpy(SDATA(selem)->data, value, smap->map.value_size);
 		return selem;
@@ -92,12 +105,24 @@ void bpf_local_storage_free_rcu(struct rcu_head *rcu)
 	kfree_rcu(local_storage, rcu);
 }
 
+static void selem_mmapable_free_rcu(struct rcu_head *rcu)
+{
+	struct bpf_local_storage_elem *selem;
+
+	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
+	bpf_map_mmapable_kfree(selem);
+}
+
 static void bpf_selem_free_rcu(struct rcu_head *rcu)
 {
 	struct bpf_local_storage_elem *selem;
 
 	selem = container_of(rcu, struct bpf_local_storage_elem, rcu);
-	kfree_rcu(selem, rcu);
+	if (selem->map_flags & BPF_F_MMAPABLE) {
+		call_rcu(rcu, selem_mmapable_free_rcu);
+	} else {
+		kfree_rcu(selem, rcu);
+	}
 }
 
 /* local_storage->lock must be held and selem->local_storage == local_storage.
@@ -383,7 +408,10 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 
 		err = bpf_local_storage_alloc(owner, smap, selem, gfp_flags);
 		if (err) {
-			kfree(selem);
+			if (map_flags & BPF_F_MMAPABLE)
+				bpf_map_mmapable_kfree(selem);
+			else
+				kfree(selem);
 			mem_uncharge(smap, owner, smap->elem_size);
 			return ERR_PTR(err);
 		}
@@ -623,8 +651,17 @@ struct bpf_local_storage_map *bpf_local_storage_map_alloc(union bpf_attr *attr)
 		raw_spin_lock_init(&smap->buckets[i].lock);
 	}
 
-	smap->elem_size =
-		sizeof(struct bpf_local_storage_elem) + attr->value_size;
+	if (attr->map_flags & BPF_F_MMAPABLE) {
+		size_t offset;
+
+		offset = offsetof(struct bpf_local_storage_elem, sdata) +
+			offsetof(struct bpf_local_storage_data, data);
+		smap->elem_size = bpf_map_mmapable_alloc_size(offset,
+							      attr->value_size);
+	} else {
+		smap->elem_size =
+			sizeof(struct bpf_local_storage_elem) + attr->value_size;
+	}
 
 	return smap;
 }
@@ -645,3 +682,25 @@ int bpf_local_storage_map_check_btf(const struct bpf_map *map,
 
 	return 0;
 }
+
+int bpf_local_storage_mmap(struct bpf_local_storage_map *smap, void *data,
+			   struct vm_area_struct *vma)
+{
+	struct bpf_map *map;
+	unsigned long pfn;
+	unsigned long count;
+	unsigned long size;
+
+	map = &smap->map;
+	size = PAGE_ALIGN(map->value_size);
+	if (vma->vm_pgoff * PAGE_SIZE + (vma->vm_end - vma->vm_start) > size)
+		return -EINVAL;
+
+	if (!IS_ALIGNED((unsigned long)data, PAGE_SIZE))
+		return -EINVAL;
+
+	pfn = virt_to_phys(data) >> PAGE_SHIFT;
+	count = size >> PAGE_SHIFT;
+	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
+			       count << PAGE_SHIFT, vma->vm_page_prot);
+}
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 6638a0ecc3d2..9552b84f96db 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -307,6 +307,45 @@ static void task_storage_map_free(struct bpf_map *map)
 	bpf_local_storage_map_free(smap, &bpf_task_storage_busy);
 }
 
+static int task_storage_map_mmap(struct bpf_map *map, struct vm_area_struct *vma)
+{
+	struct bpf_local_storage_map *smap;
+	struct bpf_local_storage_data *sdata;
+	int err;
+
+	if (!(map->map_flags & BPF_F_MMAPABLE))
+		return -EINVAL;
+
+	rcu_read_lock();
+	if (!bpf_task_storage_trylock()) {
+		rcu_read_unlock();
+		return -EBUSY;
+	}
+
+	smap = (struct bpf_local_storage_map *)map;
+	sdata = task_storage_lookup(current, map, true);
+	if (sdata) {
+		err = bpf_local_storage_mmap(smap, sdata->data, vma);
+		goto unlock;
+	}
+
+	/* only allocate new storage, when the task is refcounted */
+	if (refcount_read(&current->usage)) {
+		sdata = bpf_local_storage_update(current, smap, NULL,
+						 BPF_NOEXIST, GFP_ATOMIC);
+		if (IS_ERR(sdata)) {
+			err = PTR_ERR(sdata);
+			goto unlock;
+		}
+	}
+
+	err = bpf_local_storage_mmap(smap, sdata->data, vma);
+unlock:
+	bpf_task_storage_unlock();
+	rcu_read_unlock();
+	return err;
+}
+
 static int task_storage_map_btf_id;
 const struct bpf_map_ops task_storage_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
@@ -321,6 +360,7 @@ const struct bpf_map_ops task_storage_map_ops = {
 	.map_btf_name = "bpf_local_storage_map",
 	.map_btf_id = &task_storage_map_btf_id,
 	.map_owner_storage_ptr = task_storage_ptr,
+	.map_mmap = &task_storage_map_mmap,
 };
 
 const struct bpf_func_proto bpf_task_storage_get_proto = {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index cdaa1152436a..facd6918698d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -473,6 +473,73 @@ static void bpf_map_release_memcg(struct bpf_map *map)
 }
 #endif
 
+/* Given an address 'addr', return an address A such that A + offset is
+ * page aligned. The distance between 'addr' and that page boundary
+ * (i.e. A + offset) must be >= offset + sizeof(ptr).
+ */
+static unsigned long mmapable_alloc_ret_addr(void *addr, size_t offset)
+{
+	const size_t ptr_size = sizeof(void *);
+
+	return PAGE_ALIGN((unsigned long)addr + offset + ptr_size) - offset;
+}
+
+/* Given an offset and size, return the minimal allocation size, such that it's
+ * guaranteed to contains an address where address + offset is page aligned and
+ * [address + offset, address + offset + size] is covered in the allocated area
+ */
+size_t bpf_map_mmapable_alloc_size(size_t offset, size_t size)
+{
+	const size_t ptr_size = sizeof(void *);
+
+	return offset + ptr_size + PAGE_ALIGN(size) + PAGE_SIZE;
+}
+
+/* Allocate a chunk of memory and return an address in the allocated area, such
+ * that address + offset is page aligned and address + offset + PAGE_ALIGN(size)
+ * is within the allocated area.
+ */
+void *bpf_map_mmapable_kzalloc(const struct bpf_map *map, size_t offset,
+			       size_t size, gfp_t flags)
+{
+	const size_t ptr_size = sizeof(void *);
+	size_t alloc_size;
+	void *alloc_ptr;
+	unsigned long addr, ret_addr;
+
+	if (!IS_ALIGNED(offset, ptr_size)) {
+		pr_warn("bpf_map_mmapable_kzalloc: offset (%lx) is not aligned with ptr_size (%lu)\n",
+			offset, ptr_size);
+		return NULL;
+	}
+
+	alloc_size = bpf_map_mmapable_alloc_size(offset, size);
+	alloc_ptr = bpf_map_kzalloc(map, alloc_size, flags);
+	if (!alloc_ptr)
+		return NULL;
+
+	ret_addr = mmapable_alloc_ret_addr(alloc_ptr, offset);
+
+	/* Save the raw allocation address just below the address to be returned. */
+	addr = ret_addr - ptr_size;
+	*(void **)addr = alloc_ptr;
+
+	return (void *)ret_addr;
+}
+
+/* Free the memory allocated from bpf_map_mmapable_kzalloc() */
+void bpf_map_mmapable_kfree(void *ptr)
+{
+	const size_t ptr_size = sizeof(void *);
+	unsigned long addr;
+
+	if (!IS_ALIGNED((unsigned long)ptr, ptr_size))
+		return;
+
+	addr = (unsigned long)ptr - ptr_size;
+	kfree(*(void **)addr);
+}
+
 /* called from workqueue */
 static void bpf_map_free_deferred(struct work_struct *work)
 {
-- 
2.35.1.1021.g381101b075-goog

