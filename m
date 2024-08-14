Return-Path: <bpf+bounces-37147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1923951318
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 05:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566BA2836C1
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 03:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E317644C6C;
	Wed, 14 Aug 2024 03:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIbC0hMf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C992E3FBA5
	for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 03:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723606221; cv=none; b=MtuTWOCm2gtlWI59LQWdP01Osefmb3ed42n3girSJMYgBkgfzl3zg1vNEMq95Laul9r9c5wVJnDVzjUOWcwhxoPbitZrygCcfApV5CltnnP0D5/p63bC4u3rz4pee9ZCF0p9tmdikX4qIhTdB03cS+cfuW/U3L6vZeewPS+WZY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723606221; c=relaxed/simple;
	bh=TxXltHGbAB9FV5PI/f1qTCaWCXoT6t9TOXMrIAoxN4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oRtYnJgHJz8JoP7w+Y4/TyVjkiqZYXWtUJhMc25fZBsidFQg2lJV72vDZrIwRNpHpRPXuHQB+Yz4wGFPhXMDZSkuc5LWtVo0z73WJ+AtQu+olU1ZNZPXxn7UkopO9QrGaLfZry+LxBuWJ0hGQ08Gew6um4rz9zV1C8WXndrywIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIbC0hMf; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-699d8dc6744so4169757b3.0
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 20:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723606219; x=1724211019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WlaZ8Qk4gImq5cOnYJqxcFCkNXR6u9I92jjLqb+PSo=;
        b=JIbC0hMfRpBqhfnmjOBlZLlRo7K9EOloGdD+p5pKc1zz/DnxIvzJTQTf38zfkRSUAF
         c2KuNfDhYrNvqr7nyzaoEM4eqw2q0WnzCGcGg04VggJ/A6ObXogu+/ycYJybU02r3V73
         mket2GHrzKwMVOh1L2jTPZHNlu6bFNELLn7tv12+4U2BeaOhNM+alNyHIvEEv+0vwBX7
         RHU7ZySYnTWnDQxN1JGFTq3GRvJd1AlJcdUK2LcNHOay0tHXFTnApbasI2AZDdVjGri8
         z8m2jkhON2sGmqEMOH0VnMDwPw7EyP89Id3ur9VS8ddWXpgZHYBcXbflB47hdZVwBR9x
         Da2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723606219; x=1724211019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WlaZ8Qk4gImq5cOnYJqxcFCkNXR6u9I92jjLqb+PSo=;
        b=RZqkpQb4NsS0spnf0DAtTFF5Rk6Eu16x5kZkkCdVeH3V6A/6bnLO0fqzJT5du7HFLn
         OUKcn3I9v6N2uN0vmNNu0y5s60Ec6PYQiaiUTtwGXqrQKqgkILb97H9g9WFl2pAct96d
         uwqT/Rlw+ckvsoEb+MIym+Ka0GrDXl//UTwLO6H8uw7h15ZgIjA0Nqfi0kgCZVxG0/3d
         7m8J6Wvun4974rLwuJnCJKmUkP0HfkTQz5JEWSx0buFUjdDUxhUP5nhjCp8lMlUiV07I
         2x/7fVE65kTHtv7aQ6kFF3ApUoPwtoA9W81TKIMBnOic2R+jvblQcjqlJHerGvcRtv3j
         m/lg==
X-Gm-Message-State: AOJu0YweIo2GG4jZ/nufNxIfALyxbhZSzC86fVutRkso/6XS7tUMSGCr
	CfHJjOD6IyT5JNe8D6Ki7r91t5mJyKR6jeo9ccBF/mJ9wxFErsbXmvCddu1S
X-Google-Smtp-Source: AGHT+IG5ACL4Q/2MmoPXNV2oWkutSyNCViq3kQcmU5wjEwc7tftN0jDn9wF8InfAfMMzhsDH58rX8w==
X-Received: by 2002:a05:690c:dd5:b0:65f:8d14:d37d with SMTP id 00721157ae682-6ad19995235mr5406827b3.1.1723606217949;
        Tue, 13 Aug 2024 20:30:17 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:3c23:99cc:16a9:8b68])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6a0a451b597sm15109587b3.117.2024.08.13.20.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 20:30:17 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>,
	linux-mm@kvack.org
Subject: [RFC bpf-next v3 4/7] bpf: add helper functions of pinning and converting BPF_UPTR.
Date: Tue, 13 Aug 2024 20:30:07 -0700
Message-Id: <20240814033010.2980635-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814033010.2980635-1-thinker.li@gmail.com>
References: <20240814033010.2980635-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The helper functions manage uptrs in BPF map values from userspace. These
uptrs point to user memory, so we must pin and convert them into kernel
address space for BPF programs to access them in the kernel. These helper
functions will be utilized by the upcoming patches.

To access uptrs in BPF programs, they are pinned using
pin_user_pages_fast(), but the conversion to kernel addresses is actually
done by page_address(). The uptrs can be unpinned using unpin_user_pages().

Currently, the memory block pointed to by a uptr must reside in a single
memory page, as crossing multiple pages is not supported.

Cc: linux-mm@kvack.org
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h  |  30 ++++++++++
 kernel/bpf/helpers.c |  20 +++++++
 kernel/bpf/syscall.c | 132 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 182 insertions(+)

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
index fed4a2145f81..d504f5eb955a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -155,6 +155,138 @@ static void maybe_wait_bpf_programs(struct bpf_map *map)
 		synchronize_rcu();
 }
 
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
 static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
 				void *key, void *value, __u64 flags)
 {
-- 
2.34.1


