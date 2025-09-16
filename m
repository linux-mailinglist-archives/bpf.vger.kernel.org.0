Return-Path: <bpf+bounces-68579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EF4B7DE19
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39F0325129
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 23:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F272F360D;
	Tue, 16 Sep 2025 23:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHZQbYIU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC8A2D373E
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065833; cv=none; b=D8MzKBm0fxok2ABENxJSsZc4Q2sbwvqt9rt9S8tF94sdZUGXT8yQRrQYtO5JYwm5zA7fNHYmTikGhH3V/AWtYenxCooubvtFZxEbznOmz16YPTh6DUs43yLatnLO7PyNrY/Hylz227VkM7MnAKRBSUsy4bQMIxUM8rrkE9d79jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065833; c=relaxed/simple;
	bh=1PBwqiERpPpwCLNWLCv2b1Gu2cDrGKVfmhyGAMrXPjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNmT7BEqB8uInIbZ5ZN/Zha51b55S7yaKG+TCzHjgo7p439OtdxWJFrhT6SKa46rjZ29P1KCD9NcXU1Jn4WM5IxEzdlIkWX/b7xpMGfmHU9g3/NPo/GQYNkHxzL5Jfb1GvWFRp6vKmNXtVfa++I2xJ7FCcZnQgccaDlGsu8t/wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHZQbYIU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45f2c9799a3so20295395e9.0
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 16:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758065829; x=1758670629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Esud4oIa7XhIH8TNl38bVUzBqVeyGX6MssyIhHqgj6U=;
        b=RHZQbYIUwxlE0qcbuRQwkc5rWoDt5IOXXC7czKvzlfZI7Xxe0iO3PDj9/hLP3tZdOV
         4+a0LJvut7ZTSisb7LvuTpHTiW3vRMVW6wRoRZvWyKw0YYbdy6+IenIg3NukbAiBDrb2
         g+m8lVQmUJ0fRq7JSzRHllk52Zfj9W9jLNifpCfrsZeNljPgjxKNeANTX3mM5xNU0dVv
         Ms54rEtZrNEsHEwv/k9FfC2eYIF6RoGr/FfAwS1QZQ4erz/nEoZ9MbvzsomyXeXgYRfW
         7K2ruQ+KP3G/LXG6tRnzxK6QWqZxP08j2JzmHwg148fDy+K3dLcmRmsLQrcFWrU1iGJe
         Q8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758065829; x=1758670629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Esud4oIa7XhIH8TNl38bVUzBqVeyGX6MssyIhHqgj6U=;
        b=vFdGVnoGb8k3fymUdLK47VJ6i84ih7EBB/cxxOV3A1PvgCCkyRe1WjbJKvbqcIWa68
         sqqo6RguSvIOJlsfzy4va8bdCSJZvtuVkoIVHISga8LFVOWvq5nAjSV7Q2w59cs1v6TR
         tPeIhSuSQidcl1JYrYiJEgHWoAGww6Paw61d1gKJAn45OCIqUlgZMq11BX4UIZVbo65W
         W0jUuQc+d+b3Xbk1JQrfelpcghlfmiDiGSo7jBTqHmJuf6hoO7Z59otKUgGOL1kIZC5f
         r1IBK+RHTCBIVMwOS5hS3o0Ww8VgvYdO24MCiDJ87EW/6CMbcC/30dJugVmiom30dXtv
         NfPA==
X-Gm-Message-State: AOJu0YxVcMCY9+F99wfjcKYoTAwuKLAorya9RdTjf/p1th36IxsKxUU1
	2kzhpHzJUG5ooiSkx839+1+fDwGIj4JZWztwjj2EY1R6JAmdT5J/+L58a7irBQ==
X-Gm-Gg: ASbGncvQmH/9e+5tgw1In208BcXXo4yWEVnoA60RnBUOPs3ktAKC3JG85E0qOblDr8c
	liTOFezT+TrT+rMl0xl4UgyOAcnX2TF3YL5W6Uus6y0XFxD4HBYumbZWF1hsVhb6oZEdiRtI0nK
	K9zFtBGZ1kr2vgRPRzfjzUGqYkz3FFsTBxJI7Ru5FRmE/PUTlZTEkd52cl0tLG6hn9+q+M9VPCQ
	8iFeE+VbzG5xciLU4YOODbAceVTEMTBJmUsdzfyEsREbfJD8+avQjKSMcsHgPIMoqgcp6Ogk4Xp
	25iw0UVtjqAdY5F4BbQieqR0A/1dE/Cqa1FgYVRF5DZct/bIdMiAu4HctEHC6467nq+1di/nBbE
	WcAXBg7CxdSHYlCQngMPSkk3juw94I8Aw
X-Google-Smtp-Source: AGHT+IEy4fk+BFQB9bDWe6eWfbl7OYjYPVtDqqmH/pHX12XYRE0n4sznBeznMYjd7g4PNwQb0P7Big==
X-Received: by 2002:a05:6000:4013:b0:3ec:dc3d:39d1 with SMTP id ffacd0b85a97d-3ecdf9b195bmr125481f8f.6.1758065828976;
        Tue, 16 Sep 2025 16:37:08 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f325c3c29sm27568995e9.3.2025.09.16.16.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:37:08 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 5/8] bpf: bpf task work plumbing
Date: Wed, 17 Sep 2025 00:36:48 +0100
Message-ID: <20250916233651.258458-6-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916233651.258458-1-mykyta.yatsenko5@gmail.com>
References: <20250916233651.258458-1-mykyta.yatsenko5@gmail.com>
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
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf.h            |  11 ++++
 include/uapi/linux/bpf.h       |   4 ++
 kernel/bpf/arraymap.c          |   8 ++-
 kernel/bpf/btf.c               |   9 ++-
 kernel/bpf/hashtab.c           |  19 +++---
 kernel/bpf/helpers.c           |  40 ++++++++++++
 kernel/bpf/syscall.c           |  16 ++++-
 kernel/bpf/verifier.c          | 115 +++++++++++++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h |   4 ++
 9 files changed, 207 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8f6e87f0f3a8..febb4ca68401 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -206,6 +206,7 @@ enum btf_field_type {
 	BPF_WORKQUEUE  = (1 << 10),
 	BPF_UPTR       = (1 << 11),
 	BPF_RES_SPIN_LOCK = (1 << 12),
+	BPF_TASK_WORK  = (1 << 13),
 };
 
 enum bpf_cgroup_storage_type {
@@ -259,6 +260,7 @@ struct btf_record {
 	int timer_off;
 	int wq_off;
 	int refcount_off;
+	int task_work_off;
 	struct btf_field fields[];
 };
 
@@ -358,6 +360,8 @@ static inline const char *btf_field_type_name(enum btf_field_type type)
 		return "bpf_rb_node";
 	case BPF_REFCOUNT:
 		return "bpf_refcount";
+	case BPF_TASK_WORK:
+		return "bpf_task_work";
 	default:
 		WARN_ON_ONCE(1);
 		return "unknown";
@@ -396,6 +400,8 @@ static inline u32 btf_field_type_size(enum btf_field_type type)
 		return sizeof(struct bpf_rb_node);
 	case BPF_REFCOUNT:
 		return sizeof(struct bpf_refcount);
+	case BPF_TASK_WORK:
+		return sizeof(struct bpf_task_work);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -428,6 +434,8 @@ static inline u32 btf_field_type_align(enum btf_field_type type)
 		return __alignof__(struct bpf_rb_node);
 	case BPF_REFCOUNT:
 		return __alignof__(struct bpf_refcount);
+	case BPF_TASK_WORK:
+		return __alignof__(struct bpf_task_work);
 	default:
 		WARN_ON_ONCE(1);
 		return 0;
@@ -459,6 +467,7 @@ static inline void bpf_obj_init_field(const struct btf_field *field, void *addr)
 	case BPF_KPTR_REF:
 	case BPF_KPTR_PERCPU:
 	case BPF_UPTR:
+	case BPF_TASK_WORK:
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -595,6 +604,7 @@ void copy_map_value_locked(struct bpf_map *map, void *dst, void *src,
 			   bool lock_src);
 void bpf_timer_cancel_and_free(void *timer);
 void bpf_wq_cancel_and_free(void *timer);
+void bpf_task_work_cancel_and_free(void *timer);
 void bpf_list_head_free(const struct btf_field *field, void *list_head,
 			struct bpf_spin_lock *spin_lock);
 void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
@@ -2417,6 +2427,7 @@ struct btf_record *btf_record_dup(const struct btf_record *rec);
 bool btf_record_equal(const struct btf_record *rec_a, const struct btf_record *rec_b);
 void bpf_obj_free_timer(const struct btf_record *rec, void *obj);
 void bpf_obj_free_workqueue(const struct btf_record *rec, void *obj);
+void bpf_obj_free_task_work(const struct btf_record *rec, void *obj);
 void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
 void __bpf_obj_drop_impl(void *p, const struct btf_record *rec, bool percpu);
 
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 233de8677382..5b42faff9aeb 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7418,6 +7418,10 @@ struct bpf_timer {
 	__u64 __opaque[2];
 } __attribute__((aligned(8)));
 
+struct bpf_task_work {
+	__u64 __opaque;
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
index a1a9bc589518..95933d8a5fd0 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3494,7 +3494,8 @@ static int btf_get_field_type(const struct btf *btf, const struct btf_type *var_
 	} field_types[] = { { BPF_SPIN_LOCK, "bpf_spin_lock" },
 			    { BPF_RES_SPIN_LOCK, "bpf_res_spin_lock" },
 			    { BPF_TIMER, "bpf_timer" },
-			    { BPF_WORKQUEUE, "bpf_wq" }};
+			    { BPF_WORKQUEUE, "bpf_wq" },
+			    { BPF_TASK_WORK, "bpf_task_work" } };
 	int type = 0, i;
 	const char *name = __btf_name_by_offset(btf, var_type->name_off);
 	const char *field_type_name;
@@ -3677,6 +3678,7 @@ static int btf_find_field_one(const struct btf *btf,
 	case BPF_LIST_NODE:
 	case BPF_RB_NODE:
 	case BPF_REFCOUNT:
+	case BPF_TASK_WORK:
 		ret = btf_find_struct(btf, var_type, off, sz, field_type,
 				      info_cnt ? &info[0] : &tmp);
 		if (ret < 0)
@@ -3969,6 +3971,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 	rec->timer_off = -EINVAL;
 	rec->wq_off = -EINVAL;
 	rec->refcount_off = -EINVAL;
+	rec->task_work_off = -EINVAL;
 	for (i = 0; i < cnt; i++) {
 		field_type_size = btf_field_type_size(info_arr[i].type);
 		if (info_arr[i].off + field_type_size > value_size) {
@@ -4008,6 +4011,10 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 			/* Cache offset for faster lookup at runtime */
 			rec->wq_off = rec->fields[i].offset;
 			break;
+		case BPF_TASK_WORK:
+			WARN_ON_ONCE(rec->task_work_off >= 0);
+			rec->task_work_off = rec->fields[i].offset;
+			break;
 		case BPF_REFCOUNT:
 			WARN_ON_ONCE(rec->refcount_off >= 0);
 			/* Cache offset for faster lookup at runtime */
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 2319f8f8fa3e..c2fcd0cd51e5 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -223,9 +223,12 @@ static void htab_free_internal_structs(struct bpf_htab *htab, struct htab_elem *
 	if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
 		bpf_obj_free_workqueue(htab->map.record,
 				       htab_elem_value(elem, htab->map.key_size));
+	if (btf_record_has_field(htab->map.record, BPF_TASK_WORK))
+		bpf_obj_free_task_work(htab->map.record,
+				       htab_elem_value(elem, htab->map.key_size));
 }
 
-static void htab_free_prealloced_timers_and_wq(struct bpf_htab *htab)
+static void htab_free_prealloced_internal_structs(struct bpf_htab *htab)
 {
 	u32 num_entries = htab->map.max_entries;
 	int i;
@@ -1495,7 +1498,7 @@ static void delete_all_elements(struct bpf_htab *htab)
 	}
 }
 
-static void htab_free_malloced_timers_and_wq(struct bpf_htab *htab)
+static void htab_free_malloced_internal_structs(struct bpf_htab *htab)
 {
 	int i;
 
@@ -1514,16 +1517,16 @@ static void htab_free_malloced_timers_and_wq(struct bpf_htab *htab)
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
 
@@ -2255,7 +2258,7 @@ const struct bpf_map_ops htab_map_ops = {
 	.map_alloc = htab_map_alloc,
 	.map_free = htab_map_free,
 	.map_get_next_key = htab_map_get_next_key,
-	.map_release_uref = htab_map_free_timers_and_wq,
+	.map_release_uref = htab_map_free_internal_structs,
 	.map_lookup_elem = htab_map_lookup_elem,
 	.map_lookup_and_delete_elem = htab_map_lookup_and_delete_elem,
 	.map_update_elem = htab_map_update_elem,
@@ -2276,7 +2279,7 @@ const struct bpf_map_ops htab_lru_map_ops = {
 	.map_alloc = htab_map_alloc,
 	.map_free = htab_map_free,
 	.map_get_next_key = htab_map_get_next_key,
-	.map_release_uref = htab_map_free_timers_and_wq,
+	.map_release_uref = htab_map_free_internal_structs,
 	.map_lookup_elem = htab_lru_map_lookup_elem,
 	.map_lookup_and_delete_elem = htab_lru_map_lookup_and_delete_elem,
 	.map_lookup_elem_sys_only = htab_lru_map_lookup_elem_sys,
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 588bc7e36436..0fddf7d0954b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3738,8 +3738,48 @@ __bpf_kfunc int bpf_strstr(const char *s1__ign, const char *s2__ign)
 	return bpf_strnstr(s1__ign, s2__ign, XATTR_SIZE_MAX);
 }
 
+typedef int (*bpf_task_work_callback_t)(struct bpf_map *map, void *key, void *value);
+
+/**
+ * bpf_task_work_schedule_signal - Schedule BPF callback using task_work_add with TWA_SIGNAL mode
+ * @task: Task struct for which callback should be scheduled
+ * @tw: Pointer to struct bpf_task_work in BPF map value for internal bookkeeping
+ * @map__map: bpf_map that embeds struct bpf_task_work in the values
+ * @callback: pointer to BPF subprogram to call
+ * @aux__prog: user should pass NULL
+ *
+ * Return: 0 if task work has been scheduled successfully, negative error code otherwise
+ */
+__bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct bpf_task_work *tw,
+					      void *map__map, bpf_task_work_callback_t callback,
+					      void *aux__prog)
+{
+	return 0;
+}
+
+/**
+ * bpf_task_work_schedule_resume - Schedule BPF callback using task_work_add with TWA_RESUME mode
+ * @task: Task struct for which callback should be scheduled
+ * @tw: Pointer to struct bpf_task_work in BPF map value for internal bookkeeping
+ * @map__map: bpf_map that embeds struct bpf_task_work in the values
+ * @callback: pointer to BPF subprogram to call
+ * @aux__prog: user should pass NULL
+ *
+ * Return: 0 if task work has been scheduled successfully, negative error code otherwise
+ */
+__bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct bpf_task_work *tw,
+					      void *map__map, bpf_task_work_callback_t callback,
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
index 0fbfa8532c39..b099ea40532e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -672,6 +672,7 @@ void btf_record_free(struct btf_record *rec)
 		case BPF_TIMER:
 		case BPF_REFCOUNT:
 		case BPF_WORKQUEUE:
+		case BPF_TASK_WORK:
 			/* Nothing to release */
 			break;
 		default:
@@ -725,6 +726,7 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
 		case BPF_TIMER:
 		case BPF_REFCOUNT:
 		case BPF_WORKQUEUE:
+		case BPF_TASK_WORK:
 			/* Nothing to acquire */
 			break;
 		default:
@@ -783,6 +785,13 @@ void bpf_obj_free_workqueue(const struct btf_record *rec, void *obj)
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
@@ -807,6 +816,9 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 		case BPF_WORKQUEUE:
 			bpf_wq_cancel_and_free(field_ptr);
 			break;
+		case BPF_TASK_WORK:
+			bpf_task_work_cancel_and_free(field_ptr);
+			break;
 		case BPF_KPTR_UNREF:
 			WRITE_ONCE(*(u64 *)field_ptr, 0);
 			break;
@@ -1237,7 +1249,8 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 
 	map->record = btf_parse_fields(btf, value_type,
 				       BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK | BPF_TIMER | BPF_KPTR | BPF_LIST_HEAD |
-				       BPF_RB_ROOT | BPF_REFCOUNT | BPF_WORKQUEUE | BPF_UPTR,
+				       BPF_RB_ROOT | BPF_REFCOUNT | BPF_WORKQUEUE | BPF_UPTR |
+				       BPF_TASK_WORK,
 				       map->value_size);
 	if (!IS_ERR_OR_NULL(map->record)) {
 		int i;
@@ -1269,6 +1282,7 @@ static int map_check_btf(struct bpf_map *map, struct bpf_token *token,
 				break;
 			case BPF_TIMER:
 			case BPF_WORKQUEUE:
+			case BPF_TASK_WORK:
 				if (map->map_type != BPF_MAP_TYPE_HASH &&
 				    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
 				    map->map_type != BPF_MAP_TYPE_ARRAY) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e01335ef43ea..157cb7c4b756 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2236,10 +2236,10 @@ static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
 			/* transfer reg's id which is unique for every map_lookup_elem
 			 * as UID of the inner map.
 			 */
-			if (btf_record_has_field(map->inner_map_meta->record, BPF_TIMER))
-				reg->map_uid = reg->id;
-			if (btf_record_has_field(map->inner_map_meta->record, BPF_WORKQUEUE))
+			if (btf_record_has_field(map->inner_map_meta->record,
+						 BPF_TIMER | BPF_WORKQUEUE | BPF_TASK_WORK)) {
 				reg->map_uid = reg->id;
+			}
 		} else if (map->map_type == BPF_MAP_TYPE_XSKMAP) {
 			reg->type = PTR_TO_XDP_SOCK;
 		} else if (map->map_type == BPF_MAP_TYPE_SOCKMAP ||
@@ -8594,6 +8594,27 @@ static int process_wq_func(struct bpf_verifier_env *env, int regno,
 	return 0;
 }
 
+static int process_task_work_func(struct bpf_verifier_env *env, int regno,
+				  struct bpf_kfunc_call_arg_meta *meta)
+{
+	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
+	struct bpf_map *map = reg->map_ptr;
+	int err;
+
+	err = check_map_field_pointer(env, regno, BPF_TASK_WORK,
+				      offsetof(struct btf_record, task_work_off));
+	if (err)
+		return err;
+
+	if (meta->map.ptr) {
+		verifier_bug(env, "Two map pointers in a bpf_task_work helper");
+		return -EFAULT;
+	}
+	meta->map.uid = reg->map_uid;
+	meta->map.ptr = map;
+	return 0;
+}
+
 static int process_kptr_func(struct bpf_verifier_env *env, int regno,
 			     struct bpf_call_arg_meta *meta)
 {
@@ -10423,6 +10444,8 @@ typedef int (*set_callee_state_fn)(struct bpf_verifier_env *env,
 				   struct bpf_func_state *callee,
 				   int insn_idx);
 
+static bool is_task_work_add_kfunc(u32 func_id);
+
 static int set_callee_state(struct bpf_verifier_env *env,
 			    struct bpf_func_state *caller,
 			    struct bpf_func_state *callee, int insn_idx);
@@ -10641,7 +10664,8 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		env->subprog_info[subprog].is_async_cb = true;
 		async_cb = push_async_cb(env, env->subprog_info[subprog].start,
 					 insn_idx, subprog,
-					 is_bpf_wq_set_callback_impl_kfunc(insn->imm));
+					 is_bpf_wq_set_callback_impl_kfunc(insn->imm) ||
+					 is_task_work_add_kfunc(insn->imm));
 		if (!async_cb)
 			return -EFAULT;
 		callee = async_cb->frame[0];
@@ -10954,6 +10978,36 @@ static int set_rbtree_add_callback_state(struct bpf_verifier_env *env,
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
+	callee->in_async_callback_fn = true;
+	callee->callback_ret_range = retval_range(S32_MIN, S32_MAX);
+	return 0;
+}
+
 static bool is_rbtree_lock_required_kfunc(u32 btf_id);
 
 /* Are we currently verifying the callback for a rbtree helper that must
@@ -12085,6 +12139,7 @@ enum {
 	KF_ARG_RB_NODE_ID,
 	KF_ARG_WORKQUEUE_ID,
 	KF_ARG_RES_SPIN_LOCK_ID,
+	KF_ARG_TASK_WORK_ID,
 };
 
 BTF_ID_LIST(kf_arg_btf_ids)
@@ -12095,6 +12150,7 @@ BTF_ID(struct, bpf_rb_root)
 BTF_ID(struct, bpf_rb_node)
 BTF_ID(struct, bpf_wq)
 BTF_ID(struct, bpf_res_spin_lock)
+BTF_ID(struct, bpf_task_work)
 
 static bool __is_kfunc_ptr_arg_type(const struct btf *btf,
 				    const struct btf_param *arg, int type)
@@ -12143,6 +12199,11 @@ static bool is_kfunc_arg_wq(const struct btf *btf, const struct btf_param *arg)
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
@@ -12230,6 +12291,7 @@ enum kfunc_ptr_arg_type {
 	KF_ARG_PTR_TO_WORKQUEUE,
 	KF_ARG_PTR_TO_IRQ_FLAG,
 	KF_ARG_PTR_TO_RES_SPIN_LOCK,
+	KF_ARG_PTR_TO_TASK_WORK,
 };
 
 enum special_kfunc_type {
@@ -12279,6 +12341,8 @@ enum special_kfunc_type {
 	KF_bpf_res_spin_lock_irqsave,
 	KF_bpf_res_spin_unlock_irqrestore,
 	KF___bpf_trap,
+	KF_bpf_task_work_schedule_signal,
+	KF_bpf_task_work_schedule_resume,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12347,6 +12411,14 @@ BTF_ID(func, bpf_res_spin_unlock)
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
@@ -12437,6 +12509,9 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_wq(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_WORKQUEUE;
 
+	if (is_kfunc_arg_task_work(meta->btf, &args[argno]))
+		return KF_ARG_PTR_TO_TASK_WORK;
+
 	if (is_kfunc_arg_irq_flag(meta->btf, &args[argno]))
 		return KF_ARG_PTR_TO_IRQ_FLAG;
 
@@ -12780,7 +12855,8 @@ static bool is_sync_callback_calling_kfunc(u32 btf_id)
 
 static bool is_async_callback_calling_kfunc(u32 btf_id)
 {
-	return btf_id == special_kfunc_list[KF_bpf_wq_set_callback_impl];
+	return btf_id == special_kfunc_list[KF_bpf_wq_set_callback_impl] ||
+	       is_task_work_add_kfunc(btf_id);
 }
 
 static bool is_bpf_throw_kfunc(struct bpf_insn *insn)
@@ -13161,7 +13237,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				verbose(env, "pointer in R%d isn't map pointer\n", regno);
 				return -EINVAL;
 			}
-			if (meta->map.ptr && reg->map_ptr->record->wq_off >= 0) {
+			if (meta->map.ptr && (reg->map_ptr->record->wq_off >= 0 ||
+					      reg->map_ptr->record->task_work_off >= 0)) {
 				/* Use map_uid (which is unique id of inner map) to reject:
 				 * inner_map1 = bpf_map_lookup_elem(outer_map, key1)
 				 * inner_map2 = bpf_map_lookup_elem(outer_map, key2)
@@ -13176,6 +13253,12 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				 */
 				if (meta->map.ptr != reg->map_ptr ||
 				    meta->map.uid != reg->map_uid) {
+					if (reg->map_ptr->record->task_work_off >= 0) {
+						verbose(env,
+							"bpf_task_work pointer in R2 map_uid=%d doesn't match map pointer in R3 map_uid=%d\n",
+							meta->map.uid, reg->map_uid);
+						return -EINVAL;
+					}
 					verbose(env,
 						"workqueue pointer in R1 map_uid=%d doesn't match map pointer in R2 map_uid=%d\n",
 						meta->map.uid, reg->map_uid);
@@ -13214,6 +13297,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 		case KF_ARG_PTR_TO_CONST_STR:
 		case KF_ARG_PTR_TO_WORKQUEUE:
+		case KF_ARG_PTR_TO_TASK_WORK:
 		case KF_ARG_PTR_TO_IRQ_FLAG:
 		case KF_ARG_PTR_TO_RES_SPIN_LOCK:
 			break;
@@ -13507,6 +13591,15 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
@@ -13873,6 +13966,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
index 233de8677382..5b42faff9aeb 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7418,6 +7418,10 @@ struct bpf_timer {
 	__u64 __opaque[2];
 } __attribute__((aligned(8)));
 
+struct bpf_task_work {
+	__u64 __opaque;
+} __attribute__((aligned(8)));
+
 struct bpf_wq {
 	__u64 __opaque[2];
 } __attribute__((aligned(8)));
-- 
2.51.0


