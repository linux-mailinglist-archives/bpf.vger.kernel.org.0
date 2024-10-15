Return-Path: <bpf+bounces-41905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 956D099DAD6
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 02:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B011282FBC
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 00:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228CC40BE5;
	Tue, 15 Oct 2024 00:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rxtfHGoO"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB09D482EF
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728953436; cv=none; b=QrsgJj8QSTkSP2DuaYyHgZrlCa1z7GOMl7Y/xqeDBn3XzLr83uE93w5IHEBccslaCv5wIqvEC1BGuNykH2P+sI2k144z6luPUPzM/Wqh1oFyGXhb3cQ2XCK9Z8MYk7d46pIjcbcBaKFJ+/7CY5T2y0nOiI7o8TWIUoX05zznskY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728953436; c=relaxed/simple;
	bh=/upoL42Z6ZNyGB1cgtGNjFJx2EdBVtlNuLrkFUUZNQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdnj7pCj2lcmvYt9AT5CZ3uZVc2Lyx04kJQdJTd+bdSeQELE2IXCO3RKN7pnuDmCfpE42W98lrQMEYpnnxMyyOjE+U/sQA1qRTbj1vXw6Kt3X3SkqZUN3PXwUCl5Czx5adOY96ETD3HgO6O6d51897ZUxn6nfxAm6Oh6HWyo13Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rxtfHGoO; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728953433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nupGYauT1Cbc6CF7JyzhKjHkH9w0JESf2hVHtU1nwts=;
	b=rxtfHGoOCQJGA2TjrDDA9NFIcLROKLYarT/RW0+0vACuQ5Mz6hkOnMTjv8diuRGzSoqfXf
	vbR5OJ6cZrKM3OIrtdBRkq3ZKH+mtUVjxf9+EmXtkY42QGY1puah6GoxsJp/jkbB/+eHab
	U3ZWULEKgwn9zq9mRpj3Rk6ftD9/aqE=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	kernel-team@meta.com,
	linux-mm@kvack.org
Subject: [PATCH v5 bpf-next 06/12] bpf: Add uptr support in the map_value of the task local storage.
Date: Mon, 14 Oct 2024 17:49:56 -0700
Message-ID: <20241015005008.767267-7-martin.lau@linux.dev>
In-Reply-To: <20241015005008.767267-1-martin.lau@linux.dev>
References: <20241015005008.767267-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

This patch adds uptr support in the map_value of the task local storage.

struct map_value {
	struct user_data __uptr *uptr;
};

struct {
	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
	__uint(map_flags, BPF_F_NO_PREALLOC);
	__type(key, int);
	__type(value, struct value_type);
} datamap SEC(".maps");

A new bpf_obj_pin_uptrs() is added to pin the user page and
also stores the kernel address back to the uptr for the
bpf prog to use later. It currently does not support
the uptr pointing to a user struct across two pages.

The uptr can only be stored to the task local storage by the
syscall update_elem. Meaning the uptr will not be considered
if it is provided by the bpf prog through
bpf_task_storage_get(BPF_LOCAL_STORAGE_GET_F_CREATE).
This is enforced by only calling
bpf_local_storage_update(swap_uptrs==true) in
bpf_pid_task_storage_update_elem. Everywhere else will
have swap_uptrs==false.

This will pump down to bpf_selem_alloc(swap_uptrs==true). It is
the only case that bpf_selem_alloc() will take the uptr value when
updating the newly allocated selem. bpf_obj_swap_uptrs() is added
to swap the uptr between the SDATA(selem)->data and the user provided
map_value in "void *value". bpf_obj_swap_uptrs() makes the
SDATA(selem)->data takes the ownership of the uptr and the user space
provided map_value will have NULL in the uptr.

The bpf_obj_unpin_uptrs() is called after map->ops->map_update_elem()
returning error. If the map->ops->map_update_elem has reached
a state that the local storage has taken the uptr ownership,
the bpf_obj_unpin_uptrs() will be a no op because the uptr
is NULL. A "__"bpf_obj_unpin_uptrs is added to make this
error path unpin easier such that it does not have to check
the map->record is NULL or not.

BPF_F_LOCK is not supported when the map_value has uptr.
This can be revisited later if there is a use case. A similar
swap_uptrs idea can be considered.

The final bit is to do unpin_user_page in the bpf_obj_free_fields().
The earlier patch has ensured that the bpf_obj_free_fields() has
gone through the rcu gp when needed.

Cc: linux-mm@kvack.org
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf.h            | 20 +++++++
 kernel/bpf/bpf_local_storage.c |  7 ++-
 kernel/bpf/bpf_task_storage.c  |  5 +-
 kernel/bpf/syscall.c           | 99 ++++++++++++++++++++++++++++++++--
 4 files changed, 124 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cdd0a891ce55..7bf1627019fc 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -424,6 +424,7 @@ static inline void bpf_obj_init_field(const struct btf_field *field, void *addr)
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 	case BPF_KPTR_PERCPU:
+	case BPF_UPTR:
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -512,6 +513,25 @@ static inline void copy_map_value_long(struct bpf_map *map, void *dst, void *src
 	bpf_obj_memcpy(map->record, dst, src, map->value_size, true);
 }
 
+static inline void bpf_obj_swap_uptrs(const struct btf_record *rec, void *dst, void *src)
+{
+	unsigned long *src_uptr, *dst_uptr;
+	const struct btf_field *field;
+	int i;
+
+	if (!btf_record_has_field(rec, BPF_UPTR))
+		return;
+
+	for (i = 0, field = rec->fields; i < rec->cnt; i++, field++) {
+		if (field->type != BPF_UPTR)
+			continue;
+
+		src_uptr = src + field->offset;
+		dst_uptr = dst + field->offset;
+		swap(*src_uptr, *dst_uptr);
+	}
+}
+
 static inline void bpf_obj_memzero(struct btf_record *rec, void *dst, u32 size)
 {
 	u32 curr_off = 0;
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index ca871be1c42d..7e6a0af0afc1 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -99,9 +99,12 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 	}
 
 	if (selem) {
-		if (value)
+		if (value) {
+			/* No need to call check_and_init_map_value as memory is zero init */
 			copy_map_value(&smap->map, SDATA(selem)->data, value);
-		/* No need to call check_and_init_map_value as memory is zero init */
+			if (swap_uptrs)
+				bpf_obj_swap_uptrs(smap->map.record, SDATA(selem)->data, value);
+		}
 		return selem;
 	}
 
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 45dc3ca334d3..09705f9988f3 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -129,6 +129,9 @@ static long bpf_pid_task_storage_update_elem(struct bpf_map *map, void *key,
 	struct pid *pid;
 	int fd, err;
 
+	if ((map_flags & BPF_F_LOCK) && btf_record_has_field(map->record, BPF_UPTR))
+		return -EOPNOTSUPP;
+
 	fd = *(int *)key;
 	pid = pidfd_get_pid(fd, &f_flags);
 	if (IS_ERR(pid))
@@ -147,7 +150,7 @@ static long bpf_pid_task_storage_update_elem(struct bpf_map *map, void *key,
 	bpf_task_storage_lock();
 	sdata = bpf_local_storage_update(
 		task, (struct bpf_local_storage_map *)map, value, map_flags,
-		false, GFP_ATOMIC);
+		true, GFP_ATOMIC);
 	bpf_task_storage_unlock();
 
 	err = PTR_ERR_OR_ZERO(sdata);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 694dbbeb0eb5..eb2b25fc1fa6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -155,6 +155,82 @@ static void maybe_wait_bpf_programs(struct bpf_map *map)
 		synchronize_rcu();
 }
 
+static void unpin_uptr_kaddr(void *kaddr)
+{
+	if (kaddr)
+		unpin_user_page(virt_to_page(kaddr));
+}
+
+static void __bpf_obj_unpin_uptrs(struct btf_record *rec, u32 cnt, void *obj)
+{
+	const struct btf_field *field;
+	void **uptr_addr;
+	int i;
+
+	for (i = 0, field = rec->fields; i < cnt; i++, field++) {
+		if (field->type != BPF_UPTR)
+			continue;
+
+		uptr_addr = obj + field->offset;
+		unpin_uptr_kaddr(*uptr_addr);
+	}
+}
+
+static void bpf_obj_unpin_uptrs(struct btf_record *rec, void *obj)
+{
+	if (!btf_record_has_field(rec, BPF_UPTR))
+		return;
+
+	__bpf_obj_unpin_uptrs(rec, rec->cnt, obj);
+}
+
+static int bpf_obj_pin_uptrs(struct btf_record *rec, void *obj)
+{
+	const struct btf_field *field;
+	const struct btf_type *t;
+	unsigned long start, end;
+	struct page *page;
+	void **uptr_addr;
+	int i, err;
+
+	if (!btf_record_has_field(rec, BPF_UPTR))
+		return 0;
+
+	for (i = 0, field = rec->fields; i < rec->cnt; i++, field++) {
+		if (field->type != BPF_UPTR)
+			continue;
+
+		uptr_addr = obj + field->offset;
+		start = *(unsigned long *)uptr_addr;
+		if (!start)
+			continue;
+
+		t = btf_type_by_id(field->kptr.btf, field->kptr.btf_id);
+		if (check_add_overflow(start, t->size, &end)) {
+			err = -EFAULT;
+			goto unpin_all;
+		}
+
+		/* The uptr's struct cannot span across two pages */
+		if ((start & PAGE_MASK) != (end & PAGE_MASK)) {
+			err = -EOPNOTSUPP;
+			goto unpin_all;
+		}
+
+		err = pin_user_pages_fast(start, 1, FOLL_LONGTERM | FOLL_WRITE, &page);
+		if (err != 1)
+			goto unpin_all;
+
+		*uptr_addr = page_address(page) + offset_in_page(start);
+	}
+
+	return 0;
+
+unpin_all:
+	__bpf_obj_unpin_uptrs(rec, i, obj);
+	return err;
+}
+
 static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
 				void *key, void *value, __u64 flags)
 {
@@ -199,9 +275,14 @@ static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
 		   map->map_type == BPF_MAP_TYPE_BLOOM_FILTER) {
 		err = map->ops->map_push_elem(map, value, flags);
 	} else {
-		rcu_read_lock();
-		err = map->ops->map_update_elem(map, key, value, flags);
-		rcu_read_unlock();
+		err = bpf_obj_pin_uptrs(map->record, value);
+		if (!err) {
+			rcu_read_lock();
+			err = map->ops->map_update_elem(map, key, value, flags);
+			rcu_read_unlock();
+			if (err)
+				bpf_obj_unpin_uptrs(map->record, value);
+		}
 	}
 	bpf_enable_instrumentation();
 
@@ -716,6 +797,10 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 				field->kptr.dtor(xchgd_field);
 			}
 			break;
+		case BPF_UPTR:
+			/* The caller ensured that no one is using the uptr */
+			unpin_uptr_kaddr(*(void **)field_ptr);
+			break;
 		case BPF_LIST_HEAD:
 			if (WARN_ON_ONCE(rec->spin_lock_off < 0))
 				continue;
@@ -1107,7 +1192,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 
 	map->record = btf_parse_fields(btf, value_type,
 				       BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD |
-				       BPF_RB_ROOT | BPF_REFCOUNT | BPF_WORKQUEUE,
+				       BPF_RB_ROOT | BPF_REFCOUNT | BPF_WORKQUEUE | BPF_UPTR,
 				       map->value_size);
 	if (!IS_ERR_OR_NULL(map->record)) {
 		int i;
@@ -1163,6 +1248,12 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 					goto free_map_tab;
 				}
 				break;
+			case BPF_UPTR:
+				if (map->map_type != BPF_MAP_TYPE_TASK_STORAGE) {
+					ret = -EOPNOTSUPP;
+					goto free_map_tab;
+				}
+				break;
 			case BPF_LIST_HEAD:
 			case BPF_RB_ROOT:
 				if (map->map_type != BPF_MAP_TYPE_HASH &&
-- 
2.43.5


