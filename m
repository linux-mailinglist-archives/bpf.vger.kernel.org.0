Return-Path: <bpf+bounces-54134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BE8A633A3
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 05:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7ED16A811
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 04:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EAD1A23B5;
	Sun, 16 Mar 2025 04:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwo5xX6D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF3D19DFAB;
	Sun, 16 Mar 2025 04:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742097972; cv=none; b=BsGts0xzn6TrZIKM4pnjkXmY7O8q0sY+suAAnd1zPFFPJhjB0evaRPyicM8ImNVr4tNN7n+iu8KDVBxG8D8cHrUW6PQdXxGq4gF5uYg1fSCDLxF3IqaZJ+/HtQDxEfeiGtZeoeFsIy2WxtDvzxJYFbzo/ghsues0T/xjya1Q07s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742097972; c=relaxed/simple;
	bh=VwAQAxwAow7TrrvxCboQzb6cYiUbz63qPyaMUR2Lneg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HlwkGzQ8oXW2Mesh3uawsmEuZqj8uTz54Y4SPLpxxhqfaAOaHwEyEwfLHX1xKI59TY4vXFfXjejm+6CCnDE1ucXk0nzUJUJ5r/Lanh+CcVtXCbjIJEqifTfZ5+mSOmgQ+0WTZmdZB5OzFUmYA+ddD4bbTNEJcqbvtnD+zU4wkEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwo5xX6D; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso2847408f8f.0;
        Sat, 15 Mar 2025 21:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742097968; x=1742702768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CF4Uk2MYBA/hkoA+QSy5dWTlz17aW/WlIb/dNVcZIBA=;
        b=fwo5xX6D5hc7ZOR1gA13/CIoA/m8pF3mnhd/Q3/FmmOri4qvbdJ8LYhhpz2tFnBQF6
         iiBeGCxc9LwBzlWjpQHtJkY3d8fEkT6E5Bc/qQkasILJGj9V6BfRK8dE4njC88r1GcHR
         BIsB0zahnEcMsbucZPy3qJxUoRlSRzTur/U+G3LGcG6PmBXHN2eAUp4IOFB5Fj1dZPM1
         sTFSctW3JgDW5NyG5FgWTrg1LkS8Xp2HYZsMBYz0XvkRGz6zof797WJAnw0zUlYhbX2g
         MYcrHnYM4aVEbUt9AYwaxM/rYyEho+Xit3hat8i3p3FctBdmx+FQvb3VTNoAE7NizkCC
         yvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742097968; x=1742702768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CF4Uk2MYBA/hkoA+QSy5dWTlz17aW/WlIb/dNVcZIBA=;
        b=LYxByxq0EcboaUrG+hRpQBtz44GBeJuOahplEGqHCf74qSKVy+b4X2RcR+i68bZ25n
         M/CZJ7HYDRGBoNDoCZNj+iH01xsTIXbNVht/I8YUBdJNq2NeZ0eQoKhbU0Q3SIOwMUAB
         bq5HJ6jECjoRQiZtUM6WRkGYnrbM6NBeoLTs055VQQk+1D7Zlo1iVv4RlRVQKaWutF30
         TJD2pnkjGNDD9o/YbJpPyA5Z/K93bYB0lSOvtJNxtNk9M9aFFCjm5MwMRxGnDUO/PkfG
         YVksqxIWz3sJ1dg1winjN0MpySTwB+u1clD0vXP8944fYU1stMDrOzFAm20tjZcBgNVk
         9Hzw==
X-Forwarded-Encrypted: i=1; AJvYcCV2NWh7ngZCX7wdKUSh2F6SlyjWXXqDTOPaTXwsRdf9ABgI5+j2HWkzzUxJRR2dko/tU6jpCAciXGhCGMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyHMAePD393kVjZ62cIbNrkb92ixAmoQtyV3o0I0X6k+woJ+Ri
	xQoIxZoanWDo3l3Mnh7l24c9zc8n/S6rDMyDC6PU6jKx/uaVMOHEH/uc+TWBsJM=
X-Gm-Gg: ASbGncuzumG0JsLVgOQccg5l/9Cnln5SSh6mBq+aibbIuyjHgV9GfKvMdRBJTypYfOX
	2AYeDbE27HZw3rCx1JXwtKOyrXCewfqk5UsbdZGQr/t8JI3HXWi4tvZsM0B3X5BwnSO70oEfHF+
	Qrci75iLCrQIEPAwAJMasVXhn3fkOopYsW/25aQS+ZkUwFUzIq5d4KaiFN8RS9JVEASkb6QpEcV
	jmAdL03tSiYLH06xGNSknpADBhmkQ1G14T11PGLdbEt+GdHS5UlkHYNi8SwgAuq9U/6abZooiMZ
	B4ZwlSIo01epkRGE3nFbxaYDGlz3f0mkRUI=
X-Google-Smtp-Source: AGHT+IG/cybe/X/vKmWywaeOPxKG+ExqzgfSAMkufyXQIte9dsBNmp17N0O0pQGVtXSWVe9+PQcBvQ==
X-Received: by 2002:a5d:64a2:0:b0:38f:28dc:ec23 with SMTP id ffacd0b85a97d-3971d23799cmr10157067f8f.19.1742097967532;
        Sat, 15 Mar 2025 21:06:07 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:48::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb9d7sm10695515f8f.89.2025.03.15.21.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:06:07 -0700 (PDT)
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
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 19/25] bpf: Convert hashtab.c to rqspinlock
Date: Sat, 15 Mar 2025 21:05:35 -0700
Message-ID: <20250316040541.108729-20-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250316040541.108729-1-memxor@gmail.com>
References: <20250316040541.108729-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11131; h=from:subject; bh=VwAQAxwAow7TrrvxCboQzb6cYiUbz63qPyaMUR2Lneg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn1k3eGs+bJjtEdeiJjw+Cd9PjBR7SOiQpae9Vzm/W Hk3IcQyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ9ZN3gAKCRBM4MiGSL8RymFdD/ 4guFTOgG2ezQtX/qNWMi70RSbmgFndzWKODlNByC2n50hmYhhX9QlUKP+tsvZw793omMVa4G7ivzR8 dj195Z7rzAQlMEA+Y2fHGnBQqQWjPQhXQk2bQ1Mvvs4/C/zBpkrWLeXIrs3l4L0VhKDvg+nTGxmJGQ 5pe6Dz+d15FajBJ5NTRVGVX6/BLShHrT3NpUFLx1iGqGO6ilzcz0SKrJXuIX1thW1XMvRbyacIxc8d c4rraPbRxMyYAuYdgHX6O2iJCeDXsVnlCJ9w4YSuWCUoiRrt8AF+73hKjEtO7yhk59ZCUsvojBLWQ6 7OaL3u0YLBcxSyG4OsaCu27eyiDMBSYTJQVfjnq63hJ00wz+6TReX4DDpYAn/KUjeQLxVBgjJ2HRYh JMe4RZjVlfiK51f7sGm9Oy5JzPDbkpQSBBg9DDeMWd+aOkMDTzERynTnkWImFKroy/83XrcICnFQDC uSy6RpJt69kFqYBIjZ3E6vOhQOsNPO2Yrf53s+utbaMKhRLyMdMWYrgSiP2r0CSyFlpEWI3ZWhW9WF mfskIl0ctWP39nXAdkW/yj8vNd3DeBVAAoWJp35wU3L1cBjMrTAyXac4M8lv5Ua+lc7vYEe85mI1ry qx+it9Hd826i/HpocK9iaHfGwuWdtF0b2JNeAuwKceiyeIVeKMW5ebSgsc3w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Convert hashtab.c from raw_spinlock to rqspinlock, and drop the hashed
per-cpu counter crud from the code base which is no longer necessary.

Closes: https://lore.kernel.org/bpf/675302fd.050a0220.2477f.0004.GAE@google.com
Closes: https://lore.kernel.org/bpf/000000000000b3e63e061eed3f6b@google.com
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/hashtab.c | 102 ++++++++++++++-----------------------------
 1 file changed, 32 insertions(+), 70 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 877298133fda..5a5adc66b8e2 100644
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
@@ -820,7 +786,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 	b = __select_bucket(htab, tgt_l->hash);
 	head = &b->head;
 
-	ret = htab_lock_bucket(htab, b, tgt_l->hash, &flags);
+	ret = htab_lock_bucket(b, &flags);
 	if (ret)
 		return false;
 
@@ -831,7 +797,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 			break;
 		}
 
-	htab_unlock_bucket(htab, b, tgt_l->hash, flags);
+	htab_unlock_bucket(b, flags);
 
 	if (l == tgt_l)
 		check_and_free_fields(htab, l);
@@ -1150,7 +1116,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		 */
 	}
 
-	ret = htab_lock_bucket(htab, b, hash, &flags);
+	ret = htab_lock_bucket(b, &flags);
 	if (ret)
 		return ret;
 
@@ -1201,7 +1167,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 			check_and_free_fields(htab, l_old);
 		}
 	}
-	htab_unlock_bucket(htab, b, hash, flags);
+	htab_unlock_bucket(b, flags);
 	if (l_old) {
 		if (old_map_ptr)
 			map->ops->map_fd_put_ptr(map, old_map_ptr, true);
@@ -1210,7 +1176,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	}
 	return 0;
 err:
-	htab_unlock_bucket(htab, b, hash, flags);
+	htab_unlock_bucket(b, flags);
 	return ret;
 }
 
@@ -1257,7 +1223,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	copy_map_value(&htab->map,
 		       l_new->key + round_up(map->key_size, 8), value);
 
-	ret = htab_lock_bucket(htab, b, hash, &flags);
+	ret = htab_lock_bucket(b, &flags);
 	if (ret)
 		goto err_lock_bucket;
 
@@ -1278,7 +1244,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	ret = 0;
 
 err:
-	htab_unlock_bucket(htab, b, hash, flags);
+	htab_unlock_bucket(b, flags);
 
 err_lock_bucket:
 	if (ret)
@@ -1315,7 +1281,7 @@ static long __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
-	ret = htab_lock_bucket(htab, b, hash, &flags);
+	ret = htab_lock_bucket(b, &flags);
 	if (ret)
 		return ret;
 
@@ -1340,7 +1306,7 @@ static long __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
 	}
 	ret = 0;
 err:
-	htab_unlock_bucket(htab, b, hash, flags);
+	htab_unlock_bucket(b, flags);
 	return ret;
 }
 
@@ -1381,7 +1347,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 			return -ENOMEM;
 	}
 
-	ret = htab_lock_bucket(htab, b, hash, &flags);
+	ret = htab_lock_bucket(b, &flags);
 	if (ret)
 		goto err_lock_bucket;
 
@@ -1405,7 +1371,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 	}
 	ret = 0;
 err:
-	htab_unlock_bucket(htab, b, hash, flags);
+	htab_unlock_bucket(b, flags);
 err_lock_bucket:
 	if (l_new) {
 		bpf_map_dec_elem_count(&htab->map);
@@ -1447,7 +1413,7 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
-	ret = htab_lock_bucket(htab, b, hash, &flags);
+	ret = htab_lock_bucket(b, &flags);
 	if (ret)
 		return ret;
 
@@ -1457,7 +1423,7 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
 	else
 		ret = -ENOENT;
 
-	htab_unlock_bucket(htab, b, hash, flags);
+	htab_unlock_bucket(b, flags);
 
 	if (l)
 		free_htab_elem(htab, l);
@@ -1483,7 +1449,7 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
-	ret = htab_lock_bucket(htab, b, hash, &flags);
+	ret = htab_lock_bucket(b, &flags);
 	if (ret)
 		return ret;
 
@@ -1494,7 +1460,7 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 	else
 		ret = -ENOENT;
 
-	htab_unlock_bucket(htab, b, hash, flags);
+	htab_unlock_bucket(b, flags);
 	if (l)
 		htab_lru_push_free(htab, l);
 	return ret;
@@ -1561,7 +1527,6 @@ static void htab_map_free_timers_and_wq(struct bpf_map *map)
 static void htab_map_free(struct bpf_map *map)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
-	int i;
 
 	/* bpf_free_used_maps() or close(map_fd) will trigger this map_free callback.
 	 * bpf_free_used_maps() is called after bpf prog is no longer executing.
@@ -1586,9 +1551,6 @@ static void htab_map_free(struct bpf_map *map)
 	bpf_mem_alloc_destroy(&htab->ma);
 	if (htab->use_percpu_counter)
 		percpu_counter_destroy(&htab->pcount);
-	for (i = 0; i < HASHTAB_MAP_LOCK_COUNT; i++)
-		free_percpu(htab->map_locked[i]);
-	lockdep_unregister_key(&htab->lockdep_key);
 	bpf_map_area_free(htab);
 }
 
@@ -1631,7 +1593,7 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
-	ret = htab_lock_bucket(htab, b, hash, &bflags);
+	ret = htab_lock_bucket(b, &bflags);
 	if (ret)
 		return ret;
 
@@ -1668,7 +1630,7 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 	hlist_nulls_del_rcu(&l->hash_node);
 
 out_unlock:
-	htab_unlock_bucket(htab, b, hash, bflags);
+	htab_unlock_bucket(b, bflags);
 
 	if (l) {
 		if (is_lru_map)
@@ -1790,7 +1752,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	head = &b->head;
 	/* do not grab the lock unless need it (bucket_cnt > 0). */
 	if (locked) {
-		ret = htab_lock_bucket(htab, b, batch, &flags);
+		ret = htab_lock_bucket(b, &flags);
 		if (ret) {
 			rcu_read_unlock();
 			bpf_enable_instrumentation();
@@ -1813,7 +1775,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 		/* Note that since bucket_cnt > 0 here, it is implicit
 		 * that the locked was grabbed, so release it.
 		 */
-		htab_unlock_bucket(htab, b, batch, flags);
+		htab_unlock_bucket(b, flags);
 		rcu_read_unlock();
 		bpf_enable_instrumentation();
 		goto after_loop;
@@ -1824,7 +1786,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 		/* Note that since bucket_cnt > 0 here, it is implicit
 		 * that the locked was grabbed, so release it.
 		 */
-		htab_unlock_bucket(htab, b, batch, flags);
+		htab_unlock_bucket(b, flags);
 		rcu_read_unlock();
 		bpf_enable_instrumentation();
 		kvfree(keys);
@@ -1887,7 +1849,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 		dst_val += value_size;
 	}
 
-	htab_unlock_bucket(htab, b, batch, flags);
+	htab_unlock_bucket(b, flags);
 	locked = false;
 
 	while (node_to_free) {
-- 
2.47.1


