Return-Path: <bpf+bounces-37394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B116A955142
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 21:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3C3F1C22B18
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 19:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7DD1C4618;
	Fri, 16 Aug 2024 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDYFuVMb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F253A1C3F34
	for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723835544; cv=none; b=PnRiRygmRYWKO4dmA+AuUHP6AKq7LNbVdMUJsYuGcMaT1FGav10sqUUwnQ5QF3rwmeEz56H+4XhrL3ICYbuYPKMj4UwOMNgRk3B+90g2FhLv1mOvyXCOOMV+QSsEsed6Eoyqa2rJl2UTtGu5ZO5lxUHQ/SLyFK+EyF7FHrCwAJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723835544; c=relaxed/simple;
	bh=8OfILoANnlA4uWJ3TonOkQifBlaYhK4kGVLvAMy/JGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hZIlJoDBHSGcd2igXDP+1bBdi25mtTNpLvLRg0RiQ3Pkr0vChQSXiHL+LmZq03frttyJxO3tBlByiX8gRMbhPmZXlo+CiDG6v4h2N0JB3x8WCO6g5GX7xXUuzbrE13ahGc8Rdp3qNt7Fi4Oh53lC2X/Q6LBhEeNTCs/G080yn/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDYFuVMb; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-66c7aeac627so26274837b3.1
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 12:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723835542; x=1724440342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/I8iBRqpMYf74wgXxhVFGCiJEuxAMdQwnIxNEYMw1s=;
        b=FDYFuVMbm+zMS+vh9tLkp5MZ7NSVTmfQx01v1V0W5VJ5KKt2We4sih7RePEZK5kPvE
         Vt9KLkUAs1rcchAcYYVHKyOlGJEfZMvTRCWHeOGBl54FaBhSbsTinoefgihArUUthheA
         QkTlFiA8ALsCu/tbcR0w1e60hOK0wt3vok6d/jCjtoPPC5Us9ubT6mnq1LNVfpM1dWOD
         45nUVycaX0aelrDr5H5WFot2kuXcKwpys0qbNH3rXfKIq9aFrUs7Cd+piWgrhciEnFCW
         0daSY7EkxG4FSpL6R8xjnKITCB+DYn5UBkimG8sFFU8W/65F+sNyFuHJl/rDM+zcFXJE
         V09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723835542; x=1724440342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/I8iBRqpMYf74wgXxhVFGCiJEuxAMdQwnIxNEYMw1s=;
        b=eF4ZORy2so8EHdwiMTp6HmYfpdh8eLkRfjTQz1uT0hs1jAtvYT0Knomi9llDSNK0wl
         VT4npaMgyzZAaj5t6amtptVXGrazZdKuYxEC4R0rl4ukDSMFQX2erYa97JsJlGc/c43d
         OZlvmviZgyj66BasClsUjWHo3UOUaSJIf4/s7r4yeZpELJEwNMJBrtesDnGV47Hzh43v
         CYhdSM2D1NHni9EjXAHmn6c1aMecNoecS3Nw5Bb2M8Z+VZxyuSg/i6PREoIQpttT/U0V
         ewlmxFCTITOBARh3gWVocGs4Jw5ThDo23kDMz2kyjkplMxjmBabaBigFGEznkdaTX9o0
         ryBg==
X-Gm-Message-State: AOJu0Ywla7AoBvE/0mmYjt6pVUh8WxtiavyV41uMFQAYcjvR3PSDxMuE
	hfeTrBMgdoxm8YSyrk8E+EdsZlLLTT9yS/L1xsfwwSUosTIeDraC0T/A+oXw
X-Google-Smtp-Source: AGHT+IHq4RA32ay93U1en6x8yYxt+dO0XGSRDyCHucRhFjmHGef+aIi+zyUNHVN/Mpu4qS4awr/g1w==
X-Received: by 2002:a05:690c:4183:b0:66a:843c:4c58 with SMTP id 00721157ae682-6b1bb75e74bmr42271967b3.34.1723835541912;
        Fri, 16 Aug 2024 12:12:21 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:ca12:c8db:5571:aa13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9cd7a50dsm7233327b3.94.2024.08.16.12.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 12:12:21 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>,
	linux-mm@kvack.org
Subject: [RFC bpf-next v4 4/6] bpf: pin, translate, and unpin __uptr from syscalls.
Date: Fri, 16 Aug 2024 12:12:11 -0700
Message-Id: <20240816191213.35573-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816191213.35573-1-thinker.li@gmail.com>
References: <20240816191213.35573-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a user program updates a map value, every uptr will be pinned and
translated to an address in the kernel. This process is initiated by
calling bpf_map_update_elem() from user programs.

To access uptrs in BPF programs, they are pinned using
pin_user_pages_fast(), but the conversion to kernel addresses is actually
done by page_address(). The uptrs can be unpinned using unpin_user_pages().

Currently, the memory block pointed to by a uptr must reside in a single
memory page, as crossing multiple pages is not supported. uptr is only
supported by task storage maps and can only be set by user programs through
syscalls.

When the value of an uptr is overwritten or destroyed, the memory pointed
to by the old value must be unpinned. This is ensured by calling
bpf_obj_uptrcpy() and copy_map_uptr_locked() when updating map value and by
bpf_obj_free_fields() when destroying map value.

Cc: linux-mm@kvack.org
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h            |  30 ++++++
 kernel/bpf/bpf_local_storage.c |  23 ++++-
 kernel/bpf/helpers.c           |  20 ++++
 kernel/bpf/syscall.c           | 172 ++++++++++++++++++++++++++++++++-
 4 files changed, 237 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 954e476b5605..886c818ff555 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -477,6 +477,8 @@ static inline void bpf_long_memcpy(void *dst, const void *src, u32 size)
 		data_race(*ldst++ = *lsrc++);
 }
 
+void bpf_obj_unpin_uptr(const struct btf_field *field, void *addr);
+
 /* copy everything but bpf_spin_lock, bpf_timer, and kptrs. There could be one of each. */
 static inline void bpf_obj_memcpy(struct btf_record *rec,
 				  void *dst, void *src, u32 size,
@@ -503,6 +505,34 @@ static inline void bpf_obj_memcpy(struct btf_record *rec,
 	memcpy(dst + curr_off, src + curr_off, size - curr_off);
 }
 
+static inline void bpf_obj_uptrcpy(struct btf_record *rec,
+				   void *dst, void *src)
+{
+	int i;
+
+	if (IS_ERR_OR_NULL(rec))
+		return;
+
+	for (i = 0; i < rec->cnt; i++) {
+		u32 next_off = rec->fields[i].offset;
+		void *addr;
+
+		if (rec->fields[i].type == BPF_UPTR) {
+			/* Unpin old address.
+			 *
+			 * Alignments are guaranteed by btf_find_field_one().
+			 */
+			addr = *(void **)(dst + next_off);
+			if (addr)
+				bpf_obj_unpin_uptr(&rec->fields[i], addr);
+
+			*(void **)(dst + next_off) = *(void **)(src + next_off);
+		}
+	}
+}
+
+void copy_map_uptr_locked(struct bpf_map *map, void *dst, void *src, bool lock_src);
+
 static inline void copy_map_value(struct bpf_map *map, void *dst, void *src)
 {
 	bpf_obj_memcpy(map->record, dst, src, map->value_size, false);
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index c938dea5ddbf..2fafad53b9d9 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -99,8 +99,11 @@ bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
 	}
 
 	if (selem) {
-		if (value)
+		if (value) {
 			copy_map_value(&smap->map, SDATA(selem)->data, value);
+			if (smap->map.map_type == BPF_MAP_TYPE_TASK_STORAGE)
+				bpf_obj_uptrcpy(smap->map.record, SDATA(selem)->data, value);
+		}
 		/* No need to call check_and_init_map_value as memory is zero init */
 		return selem;
 	}
@@ -575,8 +578,13 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		if (err)
 			return ERR_PTR(err);
 		if (old_sdata && selem_linked_to_storage_lockless(SELEM(old_sdata))) {
-			copy_map_value_locked(&smap->map, old_sdata->data,
-					      value, false);
+			if (smap->map.map_type == BPF_MAP_TYPE_TASK_STORAGE &&
+			    btf_record_has_field(smap->map.record, BPF_UPTR))
+				copy_map_uptr_locked(&smap->map, old_sdata->data,
+						     value, false);
+			else
+				copy_map_value_locked(&smap->map, old_sdata->data,
+						      value, false);
 			return old_sdata;
 		}
 	}
@@ -607,8 +615,13 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		goto unlock;
 
 	if (old_sdata && (map_flags & BPF_F_LOCK)) {
-		copy_map_value_locked(&smap->map, old_sdata->data, value,
-				      false);
+		if (smap->map.map_type == BPF_MAP_TYPE_TASK_STORAGE &&
+		    btf_record_has_field(smap->map.record, BPF_UPTR))
+			copy_map_uptr_locked(&smap->map, old_sdata->data,
+					     value, false);
+		else
+			copy_map_value_locked(&smap->map, old_sdata->data,
+					      value, false);
 		selem = SELEM(old_sdata);
 		goto unlock;
 	}
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d02ae323996b..d588b52605b9 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -388,6 +388,26 @@ void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
 	preempt_enable();
 }
 
+/* Copy map value and uptr from src to dst, with lock_src indicating
+ * whether src or dst is locked.
+ */
+void copy_map_uptr_locked(struct bpf_map *map, void *src, void *dst,
+			  bool lock_src)
+{
+	struct bpf_spin_lock *lock;
+
+	if (lock_src)
+		lock = src + map->record->spin_lock_off;
+	else
+		lock = dst + map->record->spin_lock_off;
+	preempt_disable();
+	__bpf_spin_lock_irqsave(lock);
+	copy_map_value(map, dst, src);
+	bpf_obj_uptrcpy(map->record, dst, src);
+	__bpf_spin_unlock_irqrestore(lock);
+	preempt_enable();
+}
+
 BPF_CALL_0(bpf_jiffies64)
 {
 	return get_jiffies_64();
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index fed4a2145f81..1854aeb13ff7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -155,8 +155,140 @@ static void maybe_wait_bpf_programs(struct bpf_map *map)
 		synchronize_rcu();
 }
 
-static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
-				void *key, void *value, __u64 flags)
+void bpf_obj_unpin_uptr(const struct btf_field *field, void *addr)
+{
+	struct page *pages[1];
+	u32 size, type_id;
+	int npages;
+	void *ptr;
+
+	type_id = field->kptr.btf_id;
+	btf_type_id_size(field->kptr.btf, &type_id, &size);
+	if (size == 0)
+		return;
+
+	ptr = (void *)((intptr_t)addr & PAGE_MASK);
+
+	npages = (((intptr_t)addr + size + ~PAGE_MASK) - (intptr_t)ptr) >> PAGE_SHIFT;
+	if (WARN_ON_ONCE(npages > 1))
+		return;
+
+	pages[0] = virt_to_page(ptr);
+	unpin_user_pages(pages, 1);
+}
+
+/* Unpin uptr fields in the record up to cnt */
+static void bpf_obj_unpin_uptrs_cnt(struct btf_record *rec, int cnt, void *src)
+{
+	u32 next_off;
+	void **kaddr_ptr;
+	int i;
+
+	for (i = 0; i < cnt; i++) {
+		if (rec->fields[i].type != BPF_UPTR)
+			continue;
+
+		next_off = rec->fields[i].offset;
+		kaddr_ptr = src + next_off;
+		if (*kaddr_ptr) {
+			bpf_obj_unpin_uptr(&rec->fields[i], *kaddr_ptr);
+			*kaddr_ptr = NULL;
+		}
+	}
+}
+
+/* Find all BPF_UPTR fields in the record, pin the user memory, map it
+ * to kernel space, and update the addresses in the source memory.
+ *
+ * The map value passing from userspace may contain user kptrs pointing to
+ * user memory. This function pins the user memory and maps it to kernel
+ * memory so that BPF programs can access it.
+ */
+static int bpf_obj_trans_pin_uptrs(struct btf_record *rec, void *src, u32 size)
+{
+	u32 type_id, tsz, npages, next_off;
+	void *uaddr, *kaddr, **uaddr_ptr;
+	const struct btf_type *t;
+	struct page *pages[1];
+	int i, err;
+
+	if (IS_ERR_OR_NULL(rec))
+		return 0;
+
+	if (!btf_record_has_field(rec, BPF_UPTR))
+		return 0;
+
+	for (i = 0; i < rec->cnt; i++) {
+		if (rec->fields[i].type != BPF_UPTR)
+			continue;
+
+		next_off = rec->fields[i].offset;
+		if (next_off + sizeof(void *) > size) {
+			err = -EFAULT;
+			goto rollback;
+		}
+		uaddr_ptr = src + next_off;
+		uaddr = *uaddr_ptr;
+		if (!uaddr)
+			continue;
+
+		/* Make sure the user memory takes up at most one page */
+		type_id = rec->fields[i].kptr.btf_id;
+		t = btf_type_id_size(rec->fields[i].kptr.btf, &type_id, &tsz);
+		if (!t) {
+			err = -EFAULT;
+			goto rollback;
+		}
+		if (tsz == 0) {
+			*uaddr_ptr = NULL;
+			continue;
+		}
+		npages = (((intptr_t)uaddr + tsz + ~PAGE_MASK) -
+			  ((intptr_t)uaddr & PAGE_MASK)) >> PAGE_SHIFT;
+		if (npages > 1) {
+			/* Allow only one page */
+			err = -EFAULT;
+			goto rollback;
+		}
+
+		/* Pin the user memory */
+		err = pin_user_pages_fast((intptr_t)uaddr, 1, FOLL_LONGTERM | FOLL_WRITE, pages);
+		if (err < 0)
+			goto rollback;
+
+		/* Map to kernel space */
+		kaddr = page_address(pages[0]);
+		if (unlikely(!kaddr)) {
+			WARN_ON_ONCE(1);
+			unpin_user_pages(pages, 1);
+			err = -EFAULT;
+			goto rollback;
+		}
+		*uaddr_ptr = kaddr + ((intptr_t)uaddr & ~PAGE_MASK);
+	}
+
+	return 0;
+
+rollback:
+	/* Unpin the user memory of earlier fields */
+	bpf_obj_unpin_uptrs_cnt(rec, i, src);
+
+	return err;
+}
+
+static void bpf_obj_unpin_uptrs(struct btf_record *rec, void *src)
+{
+	if (IS_ERR_OR_NULL(rec))
+		return;
+
+	if (!btf_record_has_field(rec, BPF_UPTR))
+		return;
+
+	bpf_obj_unpin_uptrs_cnt(rec, rec->cnt, src);
+}
+
+static int bpf_map_update_value_inner(struct bpf_map *map, struct file *map_file,
+				      void *key, void *value, __u64 flags)
 {
 	int err;
 
@@ -208,6 +340,29 @@ static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
 	return err;
 }
 
+static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
+				void *key, void *value, __u64 flags)
+{
+	int err;
+
+	if (map->map_type == BPF_MAP_TYPE_TASK_STORAGE) {
+		/* Pin user memory can lead to context switch, so we need
+		 * to do it before potential RCU lock.
+		 */
+		err = bpf_obj_trans_pin_uptrs(map->record, value,
+					      bpf_map_value_size(map));
+		if (err)
+			return err;
+	}
+
+	err = bpf_map_update_value_inner(map, map_file, key, value, flags);
+
+	if (err && map->map_type == BPF_MAP_TYPE_TASK_STORAGE)
+		bpf_obj_unpin_uptrs(map->record, value);
+
+	return err;
+}
+
 static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
 			      __u64 flags)
 {
@@ -714,6 +869,11 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 				field->kptr.dtor(xchgd_field);
 			}
 			break;
+		case BPF_UPTR:
+			if (*(void **)field_ptr)
+				bpf_obj_unpin_uptr(field, *(void **)field_ptr);
+			*(void **)field_ptr = NULL;
+			break;
 		case BPF_LIST_HEAD:
 			if (WARN_ON_ONCE(rec->spin_lock_off < 0))
 				continue;
@@ -1099,7 +1259,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 
 	map->record = btf_parse_fields(btf, value_type,
 				       BPF_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD |
-				       BPF_RB_ROOT | BPF_REFCOUNT | BPF_WORKQUEUE,
+				       BPF_RB_ROOT | BPF_REFCOUNT | BPF_WORKQUEUE | BPF_UPTR,
 				       map->value_size);
 	if (!IS_ERR_OR_NULL(map->record)) {
 		int i;
@@ -1155,6 +1315,12 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
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
2.34.1


