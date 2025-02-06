Return-Path: <bpf+bounces-50653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 378FEA2A685
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC3B162FD5
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 10:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF7A231A5D;
	Thu,  6 Feb 2025 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kt9zc2jb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4D5231A21;
	Thu,  6 Feb 2025 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839307; cv=none; b=EZtXKKlI23AETpa5UmO96Z8BEDZlKhYA55oS+rZjEOVGH+AMelGXwaIavO/0Zu/3guF2W6vwJD8+7H7Um5+rbs4+FVx9q0MNtatXzDjsYPW5cm0vOLj3F0DajTCrHeBZGZmqkuy5ctl3PCj0i+7YUKqjLLUbFkXFJKPJNncyFnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839307; c=relaxed/simple;
	bh=PXV2g5jkXA6M5CNQXPC4dpfD1jgCcit6rNK1L4ARIdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RT6PxBLsIdE6Yg/y8nVvb4NMes9NcEob0oplxI4qUQuaBRfw3VjzgrUp/WrT3SVclNlfOnv5tnXW0OAR6LxLsY8suHfZjqRj+LOjJJS28Vi8PVXVxGm5OqOdUVL58n1zrjofuPHEqvN18D3OcQZLSiiCl0WT3oMAkvPU0efq0Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kt9zc2jb; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-436202dd730so4840235e9.2;
        Thu, 06 Feb 2025 02:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738839303; x=1739444103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pV8Sn3/Wzf2u35L7Uf0fdtRf3raefbZ3DCYUjKqcPwY=;
        b=Kt9zc2jb1gjx/QbQgZgfRSDsl9Vp/PWVXZ+Lw/Dqidrdf4iGnl3sYtnzlSA0TLiRuL
         t1/Xa2CNeUzNiMGhs+yphpu65S/0QYZKonJudr0pDN7yl0u4OSOe14tfJDsIXggrSRih
         PbzB2/B4oH/8LhbrIJe1lcyvI1OKKR9t8cZ5BM7OYwtRlQKt36RP/PnTmjvWrNqz4N7o
         Cme5RmSmG82mxKwmkMTQ6HQkmwcYMcRD65liMX1oG/f2UTr1YdkI45N30EcN2YlFvYuz
         Zs+B6jYDNoQQ+qqlWHgWiKCQk0NI/3ialqgBRobwnDhtjF6LzmSt27u3j2u/OwHxrSXv
         rZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839303; x=1739444103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pV8Sn3/Wzf2u35L7Uf0fdtRf3raefbZ3DCYUjKqcPwY=;
        b=a0qiSyZqApKloUDdS8DTNOWX7HfkQl3qAl6lexytF2Sq9SyXOR9Lb50VguyCYPCTS/
         GDLoSqWkvnlqYwoFbuqYe7GQZWcmLvZJJMWRIVeAWu6vSveX64v2IIJRr0svwxC2kNRX
         gBRhMyUlKcCcuad96MO2BZw1gpI6oxgkSTvh4mxXxeXH28pgHoJZlHu7EQ6+ccIBy3v9
         08iFYZ/ovHH/JghzZhaqIajVRgFGYebuH9KmYxvaZh8lpxpfJwwIf2XKHkpzZviwiqG6
         6lOIv+VGoRBigh95h7rYkQAMWGC0KSMrJ2wajwa8txfGSt/T+gCehcqNexeSGiTI+mZQ
         jBXA==
X-Forwarded-Encrypted: i=1; AJvYcCU9QNE8eHKP7SI2ccG+aLXtWXdIjBQfIwXeiNCunOSBbLo7Mpdpe1OuxhjPpfNCE3UsTPzKEBhV4c3VQ18=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfTm+HzkY3KzHwDhazBAw359wWdbZjlMmGYHHHf0QmPVl7jyPj
	68AIXrX6/rxfw9hIgVB/MUKASwrP0xxCppU/5mXPoCNUPUYKq6yfqaV6hICuLaU=
X-Gm-Gg: ASbGnctyCtNi2yzBhRnNstCWUmVM80MTrKQ9gmrRDE0iSkcQXJ+aTQxtCVdXESOob/5
	+v8rrzZlwxxlQj5+5/p3JTd5iaMJHey64BwZru2mdQEnGvpJxk+NWCZm5eRbf7WYqOqUNtApVkv
	LpQ6uDK3GS3K97Fs0FpRKgqhvili4rMgs7OTTGXj08fTKAKVGshi/SAs1eAKfGwr0fNALai3701
	3Inuc+2y3XUAepFTDOlOkhDZ1AJr+uJcLm9OhhLnWoooQG45JlltJ5SVYY2WUA2dQCskqaaOVZj
	Rb+Qmw==
X-Google-Smtp-Source: AGHT+IF1B76+1ynE7+9dQEBX3L/iUxR6t+WoOTyxAKlHsKCxtnZ617dC5+DYUZ8gZKTRoQgB1NYv6Q==
X-Received: by 2002:a05:600c:310b:b0:434:eb86:aeca with SMTP id 5b1f17b1804b1-4390d43401bmr53989535e9.10.1738839303346;
        Thu, 06 Feb 2025 02:55:03 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:73::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391da965a6sm15547985e9.6.2025.02.06.02.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 02:55:02 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 19/26] bpf: Convert hashtab.c to rqspinlock
Date: Thu,  6 Feb 2025 02:54:27 -0800
Message-ID: <20250206105435.2159977-20-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206105435.2159977-1-memxor@gmail.com>
References: <20250206105435.2159977-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10973; h=from:subject; bh=PXV2g5jkXA6M5CNQXPC4dpfD1jgCcit6rNK1L4ARIdA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnpJRmPzcSKNTT0EqqnnkfrvBHcqC+gjliccdRPRLE gq5UTVWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ6SUZgAKCRBM4MiGSL8Ryk5KD/ 9ctjNzhAOgMhJSDZVpv3j4of82O3Xfa/GeQWEsteAu7YzSYq9AIIE3HFCAgpILNT3t5B88CX2Ed1lP x7dqTeC9Uk0p5aenpsjKIaVczLP6xpR/qmVo4I6h57OW1szo7kfpJPwNod+b01Lsjd/4XhfiP0XMTP G76JN02zA8AGTVzvJ8vGj1QdFNU9+tF03KJXh+Ai+Hy7bM/zZZnTDzBA7JGwE5Z3ySRB16mRXmSVLz CLGdo2Vx6qHCLVgZYsnC2f8JFgFXNNkkEcIDSP7o4OaZzrAd8KLs4rj30sgypf6XlKOaZP0cMAh97R rv9OgrXJGSWzBydhJ2Yo/U9qlaChNMWunq075WSaiww/hRbinOWydGQIl0BjHkhOsKVhBVaUhJT7mH 11W6qKAuXa0BEPoRunMVTqW01R4v/bj+YfT4PH+kIRjtYpePc7WvEnxYYr3HAhgiEiOzRNYV/nz7i1 6Qxz8MOJnYfqv5lWb482r1sfm0F+njVMg5corGbZpFCvMJMAbVl7JlJWn3KBt/rsn852KjsX0vk+KT Y4I+fnWdHm6XJ+zLmMdJjxipaCf42YtN3jaFQn/AfCmYRCm/oAaqCIpx1s2cTQi5Kpy0J3M4iGCVSm IfffEEuYwarej+1RmRfEc7KsRdw9g1C3XN/mK0+uQ97QaolvQ1fpjm1VZIXg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Convert hashtab.c from raw_spinlock to rqspinlock, and drop the hashed
per-cpu counter crud from the code base which is no longer necessary.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/hashtab.c | 102 ++++++++++++++-----------------------------
 1 file changed, 32 insertions(+), 70 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 4a9eeb7aef85..9b394e147967 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -16,6 +16,7 @@
 #include "bpf_lru_list.h"
 #include "map_in_map.h"
 #include <linux/bpf_mem_alloc.h>
+#include <asm/rqspinlock.h>
 
 #define HTAB_CREATE_FLAG_MASK						\
 	(BPF_F_NO_PREALLOC | BPF_F_NO_COMMON_LRU | BPF_F_NUMA_NODE |	\
@@ -78,7 +79,7 @@
  */
 struct bucket {
 	struct hlist_nulls_head head;
-	raw_spinlock_t raw_lock;
+	rqspinlock_t raw_lock;
 };
 
 #define HASHTAB_MAP_LOCK_COUNT 8
@@ -104,8 +105,6 @@ struct bpf_htab {
 	u32 n_buckets;	/* number of hash buckets */
 	u32 elem_size;	/* size of each element in bytes */
 	u32 hashrnd;
-	struct lock_class_key lockdep_key;
-	int __percpu *map_locked[HASHTAB_MAP_LOCK_COUNT];
 };
 
 /* each htab element is struct htab_elem + key + value */
@@ -140,45 +139,26 @@ static void htab_init_buckets(struct bpf_htab *htab)
 
 	for (i = 0; i < htab->n_buckets; i++) {
 		INIT_HLIST_NULLS_HEAD(&htab->buckets[i].head, i);
-		raw_spin_lock_init(&htab->buckets[i].raw_lock);
-		lockdep_set_class(&htab->buckets[i].raw_lock,
-					  &htab->lockdep_key);
+		raw_res_spin_lock_init(&htab->buckets[i].raw_lock);
 		cond_resched();
 	}
 }
 
-static inline int htab_lock_bucket(const struct bpf_htab *htab,
-				   struct bucket *b, u32 hash,
-				   unsigned long *pflags)
+static inline int htab_lock_bucket(struct bucket *b, unsigned long *pflags)
 {
 	unsigned long flags;
+	int ret;
 
-	hash = hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets - 1);
-
-	preempt_disable();
-	local_irq_save(flags);
-	if (unlikely(__this_cpu_inc_return(*(htab->map_locked[hash])) != 1)) {
-		__this_cpu_dec(*(htab->map_locked[hash]));
-		local_irq_restore(flags);
-		preempt_enable();
-		return -EBUSY;
-	}
-
-	raw_spin_lock(&b->raw_lock);
+	ret = raw_res_spin_lock_irqsave(&b->raw_lock, flags);
+	if (ret)
+		return ret;
 	*pflags = flags;
-
 	return 0;
 }
 
-static inline void htab_unlock_bucket(const struct bpf_htab *htab,
-				      struct bucket *b, u32 hash,
-				      unsigned long flags)
+static inline void htab_unlock_bucket(struct bucket *b, unsigned long flags)
 {
-	hash = hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets - 1);
-	raw_spin_unlock(&b->raw_lock);
-	__this_cpu_dec(*(htab->map_locked[hash]));
-	local_irq_restore(flags);
-	preempt_enable();
+	raw_res_spin_unlock_irqrestore(&b->raw_lock, flags);
 }
 
 static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node);
@@ -483,14 +463,12 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	bool percpu_lru = (attr->map_flags & BPF_F_NO_COMMON_LRU);
 	bool prealloc = !(attr->map_flags & BPF_F_NO_PREALLOC);
 	struct bpf_htab *htab;
-	int err, i;
+	int err;
 
 	htab = bpf_map_area_alloc(sizeof(*htab), NUMA_NO_NODE);
 	if (!htab)
 		return ERR_PTR(-ENOMEM);
 
-	lockdep_register_key(&htab->lockdep_key);
-
 	bpf_map_init_from_attr(&htab->map, attr);
 
 	if (percpu_lru) {
@@ -536,15 +514,6 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 	if (!htab->buckets)
 		goto free_elem_count;
 
-	for (i = 0; i < HASHTAB_MAP_LOCK_COUNT; i++) {
-		htab->map_locked[i] = bpf_map_alloc_percpu(&htab->map,
-							   sizeof(int),
-							   sizeof(int),
-							   GFP_USER);
-		if (!htab->map_locked[i])
-			goto free_map_locked;
-	}
-
 	if (htab->map.map_flags & BPF_F_ZERO_SEED)
 		htab->hashrnd = 0;
 	else
@@ -607,15 +576,12 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
 free_map_locked:
 	if (htab->use_percpu_counter)
 		percpu_counter_destroy(&htab->pcount);
-	for (i = 0; i < HASHTAB_MAP_LOCK_COUNT; i++)
-		free_percpu(htab->map_locked[i]);
 	bpf_map_area_free(htab->buckets);
 	bpf_mem_alloc_destroy(&htab->pcpu_ma);
 	bpf_mem_alloc_destroy(&htab->ma);
 free_elem_count:
 	bpf_map_free_elem_count(&htab->map);
 free_htab:
-	lockdep_unregister_key(&htab->lockdep_key);
 	bpf_map_area_free(htab);
 	return ERR_PTR(err);
 }
@@ -817,7 +783,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 	b = __select_bucket(htab, tgt_l->hash);
 	head = &b->head;
 
-	ret = htab_lock_bucket(htab, b, tgt_l->hash, &flags);
+	ret = htab_lock_bucket(b, &flags);
 	if (ret)
 		return false;
 
@@ -828,7 +794,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 			break;
 		}
 
-	htab_unlock_bucket(htab, b, tgt_l->hash, flags);
+	htab_unlock_bucket(b, flags);
 
 	if (l == tgt_l)
 		check_and_free_fields(htab, l);
@@ -1147,7 +1113,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		 */
 	}
 
-	ret = htab_lock_bucket(htab, b, hash, &flags);
+	ret = htab_lock_bucket(b, &flags);
 	if (ret)
 		return ret;
 
@@ -1198,7 +1164,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 			check_and_free_fields(htab, l_old);
 		}
 	}
-	htab_unlock_bucket(htab, b, hash, flags);
+	htab_unlock_bucket(b, flags);
 	if (l_old) {
 		if (old_map_ptr)
 			map->ops->map_fd_put_ptr(map, old_map_ptr, true);
@@ -1207,7 +1173,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	}
 	return 0;
 err:
-	htab_unlock_bucket(htab, b, hash, flags);
+	htab_unlock_bucket(b, flags);
 	return ret;
 }
 
@@ -1254,7 +1220,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	copy_map_value(&htab->map,
 		       l_new->key + round_up(map->key_size, 8), value);
 
-	ret = htab_lock_bucket(htab, b, hash, &flags);
+	ret = htab_lock_bucket(b, &flags);
 	if (ret)
 		goto err_lock_bucket;
 
@@ -1275,7 +1241,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	ret = 0;
 
 err:
-	htab_unlock_bucket(htab, b, hash, flags);
+	htab_unlock_bucket(b, flags);
 
 err_lock_bucket:
 	if (ret)
@@ -1312,7 +1278,7 @@ static long __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
-	ret = htab_lock_bucket(htab, b, hash, &flags);
+	ret = htab_lock_bucket(b, &flags);
 	if (ret)
 		return ret;
 
@@ -1337,7 +1303,7 @@ static long __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
 	}
 	ret = 0;
 err:
-	htab_unlock_bucket(htab, b, hash, flags);
+	htab_unlock_bucket(b, flags);
 	return ret;
 }
 
@@ -1378,7 +1344,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 			return -ENOMEM;
 	}
 
-	ret = htab_lock_bucket(htab, b, hash, &flags);
+	ret = htab_lock_bucket(b, &flags);
 	if (ret)
 		goto err_lock_bucket;
 
@@ -1402,7 +1368,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 	}
 	ret = 0;
 err:
-	htab_unlock_bucket(htab, b, hash, flags);
+	htab_unlock_bucket(b, flags);
 err_lock_bucket:
 	if (l_new) {
 		bpf_map_dec_elem_count(&htab->map);
@@ -1444,7 +1410,7 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
-	ret = htab_lock_bucket(htab, b, hash, &flags);
+	ret = htab_lock_bucket(b, &flags);
 	if (ret)
 		return ret;
 
@@ -1454,7 +1420,7 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
 	else
 		ret = -ENOENT;
 
-	htab_unlock_bucket(htab, b, hash, flags);
+	htab_unlock_bucket(b, flags);
 
 	if (l)
 		free_htab_elem(htab, l);
@@ -1480,7 +1446,7 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
-	ret = htab_lock_bucket(htab, b, hash, &flags);
+	ret = htab_lock_bucket(b, &flags);
 	if (ret)
 		return ret;
 
@@ -1491,7 +1457,7 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 	else
 		ret = -ENOENT;
 
-	htab_unlock_bucket(htab, b, hash, flags);
+	htab_unlock_bucket(b, flags);
 	if (l)
 		htab_lru_push_free(htab, l);
 	return ret;
@@ -1558,7 +1524,6 @@ static void htab_map_free_timers_and_wq(struct bpf_map *map)
 static void htab_map_free(struct bpf_map *map)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
-	int i;
 
 	/* bpf_free_used_maps() or close(map_fd) will trigger this map_free callback.
 	 * bpf_free_used_maps() is called after bpf prog is no longer executing.
@@ -1583,9 +1548,6 @@ static void htab_map_free(struct bpf_map *map)
 	bpf_mem_alloc_destroy(&htab->ma);
 	if (htab->use_percpu_counter)
 		percpu_counter_destroy(&htab->pcount);
-	for (i = 0; i < HASHTAB_MAP_LOCK_COUNT; i++)
-		free_percpu(htab->map_locked[i]);
-	lockdep_unregister_key(&htab->lockdep_key);
 	bpf_map_area_free(htab);
 }
 
@@ -1628,7 +1590,7 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
-	ret = htab_lock_bucket(htab, b, hash, &bflags);
+	ret = htab_lock_bucket(b, &bflags);
 	if (ret)
 		return ret;
 
@@ -1665,7 +1627,7 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 	hlist_nulls_del_rcu(&l->hash_node);
 
 out_unlock:
-	htab_unlock_bucket(htab, b, hash, bflags);
+	htab_unlock_bucket(b, bflags);
 
 	if (l) {
 		if (is_lru_map)
@@ -1787,7 +1749,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	head = &b->head;
 	/* do not grab the lock unless need it (bucket_cnt > 0). */
 	if (locked) {
-		ret = htab_lock_bucket(htab, b, batch, &flags);
+		ret = htab_lock_bucket(b, &flags);
 		if (ret) {
 			rcu_read_unlock();
 			bpf_enable_instrumentation();
@@ -1810,7 +1772,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 		/* Note that since bucket_cnt > 0 here, it is implicit
 		 * that the locked was grabbed, so release it.
 		 */
-		htab_unlock_bucket(htab, b, batch, flags);
+		htab_unlock_bucket(b, flags);
 		rcu_read_unlock();
 		bpf_enable_instrumentation();
 		goto after_loop;
@@ -1821,7 +1783,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 		/* Note that since bucket_cnt > 0 here, it is implicit
 		 * that the locked was grabbed, so release it.
 		 */
-		htab_unlock_bucket(htab, b, batch, flags);
+		htab_unlock_bucket(b, flags);
 		rcu_read_unlock();
 		bpf_enable_instrumentation();
 		kvfree(keys);
@@ -1884,7 +1846,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 		dst_val += value_size;
 	}
 
-	htab_unlock_bucket(htab, b, batch, flags);
+	htab_unlock_bucket(b, flags);
 	locked = false;
 
 	while (node_to_free) {
-- 
2.43.5


