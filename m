Return-Path: <bpf+bounces-65129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9083B1C7D5
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 16:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F57218A385F
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 14:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5F25661;
	Wed,  6 Aug 2025 14:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgoK1lV9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0262C27455
	for <bpf@vger.kernel.org>; Wed,  6 Aug 2025 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754491578; cv=none; b=rScFgCpxrOLIV3djm0uGveERpFS/gYfFy/Gafl0Gl+kx4nTS7gW52/M4zgmiJsecfL2STu56k0xJI8VX2bt1kOcFSuHtjJcUfzgRqjXKS5680nDbW/Z/JzwUVDXy6w53W3k8yJKwzwxlf9pFCdPzDWqtiNTYe0Cht/BWpaiKL/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754491578; c=relaxed/simple;
	bh=Iuci2MuZ1bMyGali4YeGIXivdM15H8fz7daKWWsjnw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a90dsUUS5ANyQr6MGPRJt0JaRbtHMmnFOoq054XJ1yP/q6CwWjrqm0UB8RnzDZNl0Bkp+sGdGtZ/rZmSjXA4rZLuwj6G0wdr3gf4D/nwzCETucDnx6nU3mJ0eIzl1qg9wvWAyDdICe+5UA7W2a7a1786p0YWFRBC56z8Z/MfLi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgoK1lV9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-459e39ee7ccso15968995e9.2
        for <bpf@vger.kernel.org>; Wed, 06 Aug 2025 07:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754491574; x=1755096374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L40ektkj4o1/Xrzvf32ztbi+rWcdI04QTPA7koSuiE0=;
        b=ZgoK1lV9Q8VVYafhtRCaxJoeNywiTrApy1N6OnfCWC3/7OWgi8RkktWttNcD5B+Nx+
         lHg4TOM5GRJGj1fAntyGGNxvoF13gTLfJrZXIvLzVM7yrfrky1xdsQ7GUcWql1f/j+Dz
         RvH2JdHnA/iXU+PZWRkJxDGRuid4/eC+lR1FM33AeHTcLvE2R2/TyF14m/FqRekqPv2l
         aTS+w61j5pwksIZhbY8s09VdmDkyjnK2qWjdaD+tD60kicrRwcDwzf0D2OLIAL5A1fiu
         Tjt8k8SVfEN/mtj3d3McJX9ZRHlmp1/xfLVHMKZSpGkuDje96423MGQLZ7oYa2VcSS17
         J+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754491574; x=1755096374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L40ektkj4o1/Xrzvf32ztbi+rWcdI04QTPA7koSuiE0=;
        b=rErgJ2XlOGyyiMhrjxUts4fNm79x/ubJ7mUd2L27z+LFLgkX/UGVIOVEEj6JQHxZUe
         AWFp+ItIvGzH1vVlx+bZnusi2JVCnP5yGqc3SccaSgytYzTLduK0N24r93vM9yKbpFFY
         SP6/aurycDSKJeRFEc7yP+OVxUgYxLrUAKPcsaVO7onGkwNQv71XPH+SY5HBftI/9dLz
         viyMq9N7cTOWbukyQXwm1TReYnvGF9zEtVwbsYVClGbPsgsKs3gzCN5J0Aoc+vTDbqYD
         9lHjzXM1n7PR+Jgq5y/p45Of/FTOyCxm89XMcivUDxZ0F3gisM4H0Bwr+GudaxDaQmi3
         8baw==
X-Gm-Message-State: AOJu0YwRsEzhfDjnWML5CC6g7Ia83YbRz9M0zgRFaD5tGamCsBmkNa31
	1AM8IlUAgKc2+mBW1KZXm+eqK4hynsqJ1w3TWu1KbFJX0af54HIw7i5dUnAeXg==
X-Gm-Gg: ASbGncvEp/4NusFH+8qJDjVJVv2xog6j3eC0e1t5KIKT78AhgWnwfEc4gC9GZs4NWPK
	bZro5/nO+8oCsGKD+TCqKr690Nj+wvKZRxlunvkLDmX/ewj9vYOlALSVJLlJMVIh0MlNyjQ1x5Z
	dErkvTHlT2uGqjZER3gCrVQ7E+Y+FlNgHchqG86R+GYlKmSz+aONzynzs2Q4goNbfQOzkklZp3t
	gf2V64e1bWOQUGvxqkgtD7Sbbk8C1HCJTFo5UqIWuwuTJoUOQc201iR1khhtRKAWUn5O8GKGKiG
	BYqxd7Gg3SlwXrKEv+6D2A5qOyYSOXiCjvL7ZD6iWJyttv6oklLV5x5+tD2zlsUY0H62ljHfhur
	u2FuquEooW/k=
X-Google-Smtp-Source: AGHT+IFKktslwfTe/gO5OUv7x8RQsHIjeHLLH2RIhecXdkdsc0jB5H/63ZiMLggK6pGdeRhoCpGyVw==
X-Received: by 2002:a05:600c:474e:b0:43d:fa59:af97 with SMTP id 5b1f17b1804b1-459e70fb72fmr26523225e9.32.1754491573857;
        Wed, 06 Aug 2025 07:46:13 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::7:ba0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e586a011sm56738785e9.19.2025.08.06.07.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 07:46:13 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next 1/4] bpf: bpf task work plumbing
Date: Wed,  6 Aug 2025 15:45:21 +0100
Message-ID: <20250806144554.576706-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250806144554.576706-1-mykyta.yatsenko5@gmail.com>
References: <20250806144554.576706-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

This patch adds necessary plumbing in verifier, syscall and maps to
support handling new kfunc bpf_task_work_schedule and kernel structure
bpf_task_work. The idea is similar to how we already handle bpf_wq and
bpf_timer.
verifier changes validate calls to bpf_task_work_schedule to make sure
it is safe and expected invariants hold.
btf part is required to detect bpf_task_work structure inside map value
and store its offset, which will be used in the next patch to calculate
key and value addresses.
arraymap and hashtab changes are needed to handle freeing of the
bpf_task_work: run code needed to deinitialize it, for example cancel
task_work callback if possible.
The use of bpf_task_work and proper implementation for kfuncs are
introduced in the next patch.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/linux/bpf.h            |  11 +++
 include/uapi/linux/bpf.h       |   4 +
 kernel/bpf/arraymap.c          |   8 +-
 kernel/bpf/btf.c               |  15 ++++
 kernel/bpf/hashtab.c           |  22 ++++--
 kernel/bpf/helpers.c           |  45 +++++++++++
 kernel/bpf/syscall.c           |  23 +++++-
 kernel/bpf/verifier.c          | 131 ++++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/bpf.h |   4 +
 9 files changed, 247 insertions(+), 16 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f9cd2164ed23..cb83ba0eaed5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -206,6 +206,7 @@ enum btf_field_type {
 	BPF_WORKQUEUE  = (1 << 10),
 	BPF_UPTR       = (1 << 11),
 	BPF_RES_SPIN_LOCK = (1 << 12),
+	BPF_TASK_WORK  = (1 << 13),
 };
 
 typedef void (*btf_dtor_kfunc_t)(void *);
@@ -245,6 +246,7 @@ struct btf_record {
 	int timer_off;
 	int wq_off;
 	int refcount_off;
+	int task_work_off;
 	struct btf_field fields[];
 };
 
@@ -340,6 +342,8 @@ static inline const char *btf_field_type_name(enum btf_field_type type)
 		return "bpf_rb_node";
 	case BPF_REFCOUNT:
 		return "bpf_refcount";
+	case BPF_TASK_WORK:
+		return "bpf_task_work";
 	default:
 		WARN_ON_ONCE(1);
 		return "unknown";
@@ -378,6 +382,8 @@ static inline u32 btf_field_type_size(enum btf_field_type type)
 		return sizeof(struct bpf_rb_node);
 	case BPF_REFCOUNT:
 		return sizeof(struct bpf_refcount);
+	case BPF_TASK_WORK:
+		return sizeof(struct bpf_task_work);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -410,6 +416,8 @@ static inline u32 btf_field_type_align(enum btf_field_type type)
 		return __alignof__(struct bpf_rb_node);
 	case BPF_REFCOUNT:
 		return __alignof__(struct bpf_refcount);
+	case BPF_TASK_WORK:
+		return __alignof__(struct bpf_task_work);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -441,6 +449,7 @@ static inline void bpf_obj_init_field(const struct btf_field *field, void *addr)
 	case BPF_KPTR_REF:
 	case BPF_KPTR_PERCPU:
 	case BPF_UPTR:
+	case BPF_TASK_WORK:
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -577,6 +586,7 @@ void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
 			   bool lock_src);
 void bpf_timer_cancel_and_free(void *timer);
 void bpf_wq_cancel_and_free(void *timer);
+void bpf_task_work_cancel_and_free(void *timer);
 void bpf_list_head_free(const struct btf_field *field, void *list_head,
 			struct bpf_spin_lock *spin_lock);
 void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
@@ -2391,6 +2401,7 @@ struct btf_record *btf_record_dup(const struct btf_record *rec);
 bool btf_record_equal(const struct btf_record *rec_a, const struct btf_record *rec_b);
 void bpf_obj_free_timer(const struct btf_record *rec, void *obj);
 void bpf_obj_free_workqueue(const struct btf_record *rec, void *obj);
+void bpf_obj_free_task_work(const struct btf_record *rec, void *obj);
 void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
 void __bpf_obj_drop_impl(void *p, const struct btf_record *rec, bool percpu);
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 233de8677382..e444d9f67829 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7418,6 +7418,10 @@ struct bpf_timer {
 	__u64 __opaque[2];
 } __attribute__((aligned(8)));
 
+struct bpf_task_work {
+	__u64 __opaque[16];
+} __attribute__((aligned(8)));
+
 struct bpf_wq {
 	__u64 __opaque[2];
 } __attribute__((aligned(8)));
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 3d080916faf9..4130d8e76dff 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -431,7 +431,7 @@ static void *array_map_vmalloc_addr(struct bpf_array *array)
 	return (void *)round_down((unsigned long)array, PAGE_SIZE);
 }
 
-static void array_map_free_timers_wq(struct bpf_map *map)
+static void array_map_free_internal_structs(struct bpf_map *map)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
 	int i;
@@ -439,12 +439,14 @@ static void array_map_free_timers_wq(struct bpf_map *map)
 	/* We don't reset or free fields other than timer and workqueue
 	 * on uref dropping to zero.
 	 */
-	if (btf_record_has_field(map->record, BPF_TIMER | BPF_WORKQUEUE)) {
+	if (btf_record_has_field(map->record, BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK)) {
 		for (i = 0; i < array->map.max_entries; i++) {
 			if (btf_record_has_field(map->record, BPF_TIMER))
 				bpf_obj_free_timer(map->record, array_map_elem_ptr(array, i));
 			if (btf_record_has_field(map->record, BPF_WORKQUEUE))
 				bpf_obj_free_workqueue(map->record, array_map_elem_ptr(array, i));
+			if (btf_record_has_field(map->record, BPF_TASK_WORK))
+				bpf_obj_free_task_work(map->record, array_map_elem_ptr(array, i));
 		}
 	}
 }
@@ -783,7 +785,7 @@ const struct bpf_map_ops array_map_ops = {
 	.map_alloc = array_map_alloc,
 	.map_free = array_map_free,
 	.map_get_next_key = array_map_get_next_key,
-	.map_release_uref = array_map_free_timers_wq,
+	.map_release_uref = array_map_free_internal_structs,
 	.map_lookup_elem = array_map_lookup_elem,
 	.map_update_elem = array_map_update_elem,
 	.map_delete_elem = array_map_delete_elem,
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0aff814cb53a..c66f9c6dfc48 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3527,6 +3527,15 @@ static int btf_get_field_type(const struct btf *btf, const struct btf_type *var_
 			goto end;
 		}
 	}
+	if (field_mask & BPF_TASK_WORK) {
+		if (!strcmp(name, "bpf_task_work")) {
+			if (*seen_mask & BPF_TASK_WORK)
+				return -E2BIG;
+			*seen_mask |= BPF_TASK_WORK;
+			type = BPF_TASK_WORK;
+			goto end;
+		}
+	}
 	field_mask_test_name(BPF_LIST_HEAD, "bpf_list_head");
 	field_mask_test_name(BPF_LIST_NODE, "bpf_list_node");
 	field_mask_test_name(BPF_RB_ROOT,   "bpf_rb_root");
@@ -3693,6 +3702,7 @@ static int btf_find_field_one(const struct btf *btf,
 	case BPF_LIST_NODE:
 	case BPF_RB_NODE:
 	case BPF_REFCOUNT:
+	case BPF_TASK_WORK:
 		ret = btf_find_struct(btf, var_type, off, sz, field_type,
 				      info_cnt ? &info[0] : &tmp);
 		if (ret < 0)
@@ -3985,6 +3995,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 	rec->timer_off = -EINVAL;
 	rec->wq_off = -EINVAL;
 	rec->refcount_off = -EINVAL;
+	rec->task_work_off = -EINVAL;
 	for (i = 0; i < cnt; i++) {
 		field_type_size = btf_field_type_size(info_arr[i].type);
 		if (info_arr[i].off + field_type_size > value_size) {
@@ -4050,6 +4061,10 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 		case BPF_LIST_NODE:
 		case BPF_RB_NODE:
 			break;
+		case BPF_TASK_WORK:
+			WARN_ON_ONCE(rec->task_work_off >= 0);
+			rec->task_work_off = rec->fields[i].offset;
+			break;
 		default:
 			ret = -EFAULT;
 			goto end;
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 71f9931ac64c..207ad4823b5b 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -215,7 +215,7 @@ static bool htab_has_extra_elems(struct bpf_htab *htab)
 	return !htab_is_percpu(htab) && !htab_is_lru(htab) && !is_fd_htab(htab);
 }
 
-static void htab_free_prealloced_timers_and_wq(struct bpf_htab *htab)
+static void htab_free_prealloced_internal_structs(struct bpf_htab *htab)
 {
 	u32 num_entries = htab->map.max_entries;
 	int i;
@@ -233,6 +233,9 @@ static void htab_free_prealloced_timers_and_wq(struct bpf_htab *htab)
 		if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
 			bpf_obj_free_workqueue(htab->map.record,
 					       htab_elem_value(elem, htab->map.key_size));
+		if (btf_record_has_field(htab->map.record, BPF_TASK_WORK))
+			bpf_obj_free_task_work(htab->map.record,
+					       htab_elem_value(elem, htab->map.key_size));
 		cond_resched();
 	}
 }
@@ -1490,7 +1493,7 @@ static void delete_all_elements(struct bpf_htab *htab)
 	}
 }
 
-static void htab_free_malloced_timers_and_wq(struct bpf_htab *htab)
+static void htab_free_malloced_internal_structs(struct bpf_htab *htab)
 {
 	int i;
 
@@ -1508,22 +1511,25 @@ static void htab_free_malloced_timers_and_wq(struct bpf_htab *htab)
 			if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
 				bpf_obj_free_workqueue(htab->map.record,
 						       htab_elem_value(l, htab->map.key_size));
+			if (btf_record_has_field(htab->map.record, BPF_TASK_WORK))
+				bpf_obj_free_task_work(htab->map.record,
+						       htab_elem_value(l, htab->map.key_size));
 		}
 		cond_resched_rcu();
 	}
 	rcu_read_unlock();
 }
 
-static void htab_map_free_timers_and_wq(struct bpf_map *map)
+static void htab_map_free_internal_structs(struct bpf_map *map)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 
 	/* We only free timer and workqueue on uref dropping to zero */
-	if (btf_record_has_field(htab->map.record, BPF_TIMER | BPF_WORKQUEUE)) {
+	if (btf_record_has_field(htab->map.record, BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK)) {
 		if (!htab_is_prealloc(htab))
-			htab_free_malloced_timers_and_wq(htab);
+			htab_free_malloced_internal_structs(htab);
 		else
-			htab_free_prealloced_timers_and_wq(htab);
+			htab_free_prealloced_internal_structs(htab);
 	}
 }
 
@@ -2255,7 +2261,7 @@ const struct bpf_map_ops htab_map_ops = {
 	.map_alloc = htab_map_alloc,
 	.map_free = htab_map_free,
 	.map_get_next_key = htab_map_get_next_key,
-	.map_release_uref = htab_map_free_timers_and_wq,
+	.map_release_uref = htab_map_free_internal_structs,
 	.map_lookup_elem = htab_map_lookup_elem,
 	.map_lookup_and_delete_elem = htab_map_lookup_and_delete_elem,
 	.map_update_elem = htab_map_update_elem,
@@ -2276,7 +2282,7 @@ const struct bpf_map_ops htab_lru_map_ops = {
 	.map_alloc = htab_map_alloc,
 	.map_free = htab_map_free,
 	.map_get_next_key = htab_map_get_next_key,
-	.map_release_uref = htab_map_free_timers_and_wq,
+	.map_release_uref = htab_map_free_internal_structs,
 	.map_lookup_elem = htab_lru_map_lookup_elem,
 	.map_lookup_and_delete_elem = htab_lru_map_lookup_and_delete_elem,
 	.map_lookup_elem_sys_only = htab_lru_map_lookup_elem_sys,
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6b4877e85a68..322ffcaedc38 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3703,8 +3703,53 @@ __bpf_kfunc int bpf_strstr(const char *s1__ign, const char *s2__ign)
 	return bpf_strnstr(s1__ign, s2__ign, XATTR_SIZE_MAX);
 }
 
+typedef void (*bpf_task_work_callback_t)(struct bpf_map *, void *, void *);
+
+/**
+ * bpf_task_work_schedule_signal - Schedule BPF callback using task_work_add with TWA_SIGNAL mode
+ * @task: Task struct for which callback should be scheduled
+ * @tw: Pointer to the bpf_task_work struct, to use by kernel internally for bookkeeping
+ * @map__map: bpf_map which contains bpf_task_work in one of the values
+ * @callback: pointer to BPF subprogram to call
+ * @aux__prog: user should pass NULL
+ *
+ * Return: 0 if task work has been scheduled successfully, negative error code otherwise
+ */
+__bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task,
+					      struct bpf_task_work *tw,
+					      struct bpf_map *map__map,
+					      bpf_task_work_callback_t callback,
+					      void *aux__prog)
+{
+	return 0;
+}
+
+/**
+ * bpf_task_work_schedule_resume - Schedule BPF callback using task_work_add with TWA_RESUME or
+ * TWA_NMI_CURRENT mode if scheduling for the current task in the NMI
+ * @task: Task struct for which callback should be scheduled
+ * @tw: Pointer to the bpf_task_work struct, to use by kernel internally for bookkeeping
+ * @map__map: bpf_map which contains bpf_task_work in one of the values
+ * @callback: pointer to BPF subprogram to call
+ * @aux__prog: user should pass NULL
+ *
+ * Return: 0 if task work has been scheduled successfully, negative error code otherwise
+ */
+__bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task,
+					      struct bpf_task_work *tw,
+					      struct bpf_map *map__map,
+					      bpf_task_work_callback_t callback,
+					      void *aux__prog)
+{
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
+void bpf_task_work_cancel_and_free(void *val)
+{
+}
+
 BTF_KFUNCS_START(generic_btf_ids)
 #ifdef CONFIG_CRASH_DUMP
 BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e63039817af3..73f801751280 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -670,6 +670,7 @@ void btf_record_free(struct btf_record *rec)
 		case BPF_TIMER:
 		case BPF_REFCOUNT:
 		case BPF_WORKQUEUE:
+		case BPF_TASK_WORK:
 			/* Nothing to release */
 			break;
 		default:
@@ -723,6 +724,7 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
 		case BPF_TIMER:
 		case BPF_REFCOUNT:
 		case BPF_WORKQUEUE:
+		case BPF_TASK_WORK:
 			/* Nothing to acquire */
 			break;
 		default:
@@ -781,6 +783,13 @@ void bpf_obj_free_workqueue(const struct btf_record *rec, void *obj)
 	bpf_wq_cancel_and_free(obj + rec->wq_off);
 }
 
+void bpf_obj_free_task_work(const struct btf_record *rec, void *obj)
+{
+	if (WARN_ON_ONCE(!btf_record_has_field(rec, BPF_TASK_WORK)))
+		return;
+	bpf_task_work_cancel_and_free(obj + rec->task_work_off);
+}
+
 void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 {
 	const struct btf_field *fields;
@@ -838,6 +847,9 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 				continue;
 			bpf_rb_root_free(field, field_ptr, obj + rec->spin_lock_off);
 			break;
+		case BPF_TASK_WORK:
+			bpf_task_work_cancel_and_free(field_ptr);
+			break;
 		case BPF_LIST_NODE:
 		case BPF_RB_NODE:
 		case BPF_REFCOUNT:
@@ -1234,7 +1246,8 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 
 	map->record = btf_parse_fields(btf, value_type,
 				       BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD |
-				       BPF_RB_ROOT | BPF_REFCOUNT | BPF_WORKQUEUE | BPF_UPTR,
+				       BPF_RB_ROOT | BPF_REFCOUNT | BPF_WORKQUEUE | BPF_UPTR |
+				       BPF_TASK_WORK,
 				       map->value_size);
 	if (!IS_ERR_OR_NULL(map->record)) {
 		int i;
@@ -1306,6 +1319,14 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 					goto free_map_tab;
 				}
 				break;
+			case BPF_TASK_WORK:
+				if (map->map_type != BPF_MAP_TYPE_HASH &&
+				    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
+				    map->map_type != BPF_MAP_TYPE_ARRAY) {
+					ret = -EOPNOTSUPP;
+					goto free_map_tab;
+				}
+				break;
 			default:
 				/* Fail if map_type checks are missing for a field type */
 				ret = -EOPNOTSUPP;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 399f03e62508..905dc0c5a73d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -524,9 +524,11 @@ static bool is_sync_callback_calling_function(enum bpf_func_id func_id)
 	       func_id == BPF_FUNC_user_ringbuf_drain;
 }
 
-static bool is_async_callback_calling_function(enum bpf_func_id func_id)
+static bool is_task_work_add_kfunc(u32 func_id);
+
+static bool is_async_callback_calling_function(u32 func_id)
 {
-	return func_id == BPF_FUNC_timer_set_callback;
+	return func_id == BPF_FUNC_timer_set_callback || is_task_work_add_kfunc(func_id);
 }
 
 static bool is_callback_calling_function(enum bpf_func_id func_id)
@@ -2236,6 +2238,8 @@ static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
 				reg->map_uid = reg->id;
 			if (btf_record_has_field(map->inner_map_meta->record, BPF_WORKQUEUE))
 				reg->map_uid = reg->id;
+			if (btf_record_has_field(map->inner_map_meta->record, BPF_TASK_WORK))
+				reg->map_uid = reg->id;
 		} else if (map->map_type == BPF_MAP_TYPE_XSKMAP) {
 			reg->type = PTR_TO_XDP_SOCK;
 		} else if (map->map_type == BPF_MAP_TYPE_SOCKMAP ||
@@ -8569,6 +8573,44 @@ static int process_wq_func(struct bpf_verifier_env *env, int regno,
 	return 0;
 }
 
+static int process_task_work_func(struct bpf_verifier_env *env, int regno,
+				  struct bpf_kfunc_call_arg_meta *meta)
+{
+	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_map *map = reg->map_ptr;
+	bool is_const = tnum_is_const(reg->var_off);
+	u64 val = reg->var_off.value;
+
+	if (!map->btf) {
+		verbose(env, "map '%s' has to have BTF in order to use bpf_task_work\n",
+			map->name);
+		return -EINVAL;
+	}
+	if (!btf_record_has_field(map->record, BPF_TASK_WORK)) {
+		verbose(env, "map '%s' has no valid bpf_task_work\n", map->name);
+		return -EINVAL;
+	}
+	if (map->record->task_work_off != val + reg->off) {
+		verbose(env,
+			"off %lld doesn't point to 'struct bpf_task_work' that is at %d\n",
+			val + reg->off, map->record->task_work_off);
+		return -EINVAL;
+	}
+	if (!is_const) {
+		verbose(env,
+			"bpf_task_work has to be at the constant offset\n");
+		return -EINVAL;
+	}
+	if (meta->map.ptr) {
+		verifier_bug(env, "Two map pointers in a bpf_task_work kfunc");
+		return -EFAULT;
+	}
+
+	meta->map.uid = reg->map_uid;
+	meta->map.ptr = map;
+	return 0;
+}
+
 static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 			     struct bpf_call_arg_meta *meta)
 {
@@ -10616,7 +10658,8 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		env->subprog_info[subprog].is_async_cb = true;
 		async_cb = push_async_cb(env, env->subprog_info[subprog].start,
 					 insn_idx, subprog,
-					 is_bpf_wq_set_callback_impl_kfunc(insn->imm));
+					 is_bpf_wq_set_callback_impl_kfunc(insn->imm) ||
+					 is_task_work_add_kfunc(insn->imm));
 		if (!async_cb)
 			return -EFAULT;
 		callee = async_cb->frame[0];
@@ -10929,6 +10972,35 @@ static int set_rbtree_add_callback_state(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int set_task_work_schedule_callback_state(struct bpf_verifier_env *env,
+						 struct bpf_func_state *caller,
+						 struct bpf_func_state *callee,
+						 int insn_idx)
+{
+	struct bpf_map *map_ptr = caller->regs[BPF_REG_3].map_ptr;
+
+	/*
+	 * callback_fn(struct bpf_map *map, void *key, void *value);
+	 */
+	callee->regs[BPF_REG_1].type = CONST_PTR_TO_MAP;
+	__mark_reg_known_zero(&callee->regs[BPF_REG_1]);
+	callee->regs[BPF_REG_1].map_ptr = map_ptr;
+
+	callee->regs[BPF_REG_2].type = PTR_TO_MAP_KEY;
+	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
+	callee->regs[BPF_REG_2].map_ptr = map_ptr;
+
+	callee->regs[BPF_REG_3].type = PTR_TO_MAP_VALUE;
+	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
+	callee->regs[BPF_REG_3].map_ptr = map_ptr;
+
+	/* unused */
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
+	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
+	callee->in_callback_fn = true;
+	return 0;
+}
+
 static bool is_rbtree_lock_required_kfunc(u32 btf_id);
 
 /* Are we currently verifying the callback for a rbtree helper that must
@@ -12059,6 +12131,7 @@ enum {
 	KF_ARG_RB_NODE_ID,
 	KF_ARG_WORKQUEUE_ID,
 	KF_ARG_RES_SPIN_LOCK_ID,
+	KF_ARG_TASK_WORK_ID,
 };
 
 BTF_ID_LIST(kf_arg_btf_ids)
@@ -12069,6 +12142,7 @@ BTF_ID(struct, bpf_rb_root)
 BTF_ID(struct, bpf_rb_node)
 BTF_ID(struct, bpf_wq)
 BTF_ID(struct, bpf_res_spin_lock)
+BTF_ID(struct, bpf_task_work)
 
 static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
 				    const struct btf_param *arg, int type)
@@ -12117,6 +12191,11 @@ static bool is_kfunc_arg_wq(const struct btf *btf, const struct btf_param *arg)
 	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_WORKQUEUE_ID);
 }
 
+static bool is_kfunc_arg_task_work(const struct btf *btf, const struct btf_param *arg)
+{
+	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_TASK_WORK_ID);
+}
+
 static bool is_kfunc_arg_res_spin_lock(const struct btf *btf, const struct btf_param *arg)
 {
 	return __is_kfunc_ptr_arg_type(btf, arg, KF_ARG_RES_SPIN_LOCK_ID);
@@ -12204,6 +12283,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_WORKQUEUE,
 	KF_ARG_PTR_TO_IRQ_FLAG,
 	KF_ARG_PTR_TO_RES_SPIN_LOCK,
+	KF_ARG_PTR_TO_TASK_WORK,
 };
 
 enum special_kfunc_type {
@@ -12252,6 +12332,8 @@ enum special_kfunc_type {
 	KF_bpf_res_spin_lock_irqsave,
 	KF_bpf_res_spin_unlock_irqrestore,
 	KF___bpf_trap,
+	KF_bpf_task_work_schedule_signal,
+	KF_bpf_task_work_schedule_resume,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12318,6 +12400,14 @@ BTF_ID(func, bpf_res_spin_unlock)
 BTF_ID(func, bpf_res_spin_lock_irqsave)
 BTF_ID(func, bpf_res_spin_unlock_irqrestore)
 BTF_ID(func, __bpf_trap)
+BTF_ID(func, bpf_task_work_schedule_signal)
+BTF_ID(func, bpf_task_work_schedule_resume)
+
+static bool is_task_work_add_kfunc(u32 func_id)
+{
+	return func_id == special_kfunc_list[KF_bpf_task_work_schedule_signal] ||
+	       func_id == special_kfunc_list[KF_bpf_task_work_schedule_resume];
+}
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
@@ -12408,6 +12498,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_wq(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_WORKQUEUE;
 
+	if (is_kfunc_arg_task_work(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_TASK_WORK;
+
 	if (is_kfunc_arg_irq_flag(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_IRQ_FLAG;
 
@@ -12751,7 +12844,8 @@ static bool is_sync_callback_calling_kfunc(u32 btf_id)
 
 static bool is_async_callback_calling_kfunc(u32 btf_id)
 {
-	return btf_id == special_kfunc_list[KF_bpf_wq_set_callback_impl];
+	return btf_id == special_kfunc_list[KF_bpf_wq_set_callback_impl] ||
+	       is_task_work_add_kfunc(btf_id);
 }
 
 static bool is_bpf_throw_kfunc(struct bpf_insn *insn)
@@ -13153,6 +13247,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					return -EINVAL;
 				}
 			}
+			if (meta->map.ptr && reg->map_ptr->record->task_work_off >= 0) {
+				if (meta->map.ptr != reg->map_ptr ||
+				    meta->map.uid != reg->map_uid) {
+					verbose(env,
+						"bpf_task_work pointer in R2 map_uid=%d doesn't match map pointer in R3 map_uid=%d\n",
+						meta->map.uid, reg->map_uid);
+					return -EINVAL;
+				}
+			}
 			meta->map.ptr = reg->map_ptr;
 			meta->map.uid = reg->map_uid;
 			fallthrough;
@@ -13185,6 +13288,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 		case KF_ARG_PTR_TO_CONST_STR:
 		case KF_ARG_PTR_TO_WORKQUEUE:
+		case KF_ARG_PTR_TO_TASK_WORK:
 		case KF_ARG_PTR_TO_IRQ_FLAG:
 		case KF_ARG_PTR_TO_RES_SPIN_LOCK:
 			break;
@@ -13476,6 +13580,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			if (ret < 0)
 				return ret;
 			break;
+		case KF_ARG_PTR_TO_TASK_WORK:
+			if (reg->type != PTR_TO_MAP_VALUE) {
+				verbose(env, "arg#%d doesn't point to a map value\n", i);
+				return -EINVAL;
+			}
+			ret = process_task_work_func(env, regno, meta);
+			if (ret < 0)
+				return ret;
+			break;
 		case KF_ARG_PTR_TO_IRQ_FLAG:
 			if (reg->type != PTR_TO_STACK) {
 				verbose(env, "arg#%d doesn't point to an irq flag on stack\n", i);
@@ -13842,6 +13955,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	if (is_task_work_add_kfunc(meta.func_id)) {
+		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
+					 set_task_work_schedule_callback_state);
+		if (err) {
+			verbose(env, "kfunc %s#%d failed callback verification\n",
+				func_name, meta.func_id);
+			return err;
+		}
+	}
+
 	rcu_lock = is_kfunc_bpf_rcu_read_lock(&meta);
 	rcu_unlock = is_kfunc_bpf_rcu_read_unlock(&meta);
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 233de8677382..e444d9f67829 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7418,6 +7418,10 @@ struct bpf_timer {
 	__u64 __opaque[2];
 } __attribute__((aligned(8)));
 
+struct bpf_task_work {
+	__u64 __opaque[16];
+} __attribute__((aligned(8)));
+
 struct bpf_wq {
 	__u64 __opaque[2];
 } __attribute__((aligned(8)));
-- 
2.50.1


