Return-Path: <bpf+bounces-53088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AFDA4C515
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 16:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1359C17323D
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 15:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F3B21481D;
	Mon,  3 Mar 2025 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZYk0jzh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCB8233D8C;
	Mon,  3 Mar 2025 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015418; cv=none; b=QGQMVXH3l2hgiQmHmXvCqAz5Xj4MvXx9+nVVppe77aqZqqGO3yj7y7lbbXOSaSyNkab1bdkJhoSqZPa+SUjGE51CN351e9iGDIXTT2UPO3ywP3ESaBgNzuMcah3f517FcGOV3bsCU/Z9rtXnXfSgbCJqFu3a+KUaWlwotFGVhbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015418; c=relaxed/simple;
	bh=4ih0G/0286de3X2HOwCgeQ8ZZwbokSdXkcTQRkadVk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h45zHW78kfpDOEQ4j+AjLBMXS1EuTQ2ZXCe7MwsYg4/OICSM/UrHvaZInmaD7XKp6B+XTu3e71cn7S/KXwlWyN+EGoIkg9glfZO6RRaJlQ8o7x/WmG7tzdeg9z4oS1f4RnLxEGFmuG0QqNbbPdOHm3cYl46R47y8zjAeEOAQW90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZYk0jzh; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4394a823036so43939805e9.0;
        Mon, 03 Mar 2025 07:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741015414; x=1741620214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jp6uG/E/DcwB9A5vS09y6QoqRf0wNeVJjI9fKDMNnPg=;
        b=MZYk0jzhbj9BL4/oHqAaDY9k0ixarFj+A9KBZzJ2IOIFajWn8p3t0oOtLcr6EQiGD/
         8yelWg8C9D18uqpR82g8AsySYnpmjw0TAegVKsCJxJPrZjSflzMd8WDh0Gsns/iwTM1t
         tNXRDY6PgLvG+/rwME7GKKM8M6o15TQOr8EGjLTsytjKJ/IaSKOqcvNqYFoaK69BwaNL
         obPgxNy24YpW+QCNRn3e5U/PBAd5TrMDV/nqFum7yr2xwFgOKgvIABMKDT418tn0nSOP
         BfcTWptL3anBd3njGDFbHtnsOrweJc0amCzLvcliCAGyMsZr8QhqjhoNNhXvuAnBMGVA
         l/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015414; x=1741620214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jp6uG/E/DcwB9A5vS09y6QoqRf0wNeVJjI9fKDMNnPg=;
        b=QlNyQJNPl+/x9pSZCO9FpJSftDTWk4zvXBFg2K4qTJnNlfCDGtOGOL0+o0gcEY+jCl
         T30hhbM5EveD53ZJX4sAiOeXgm1JmgJON0RpHc4V/DOUcv3MmNcuqVOeHa6gMcoMTkPM
         EPXN3EucYzhQXndnx/ADK0pAFyJAvdeuN27YFRDRCisA7pXJ8A6+cwsSo0tw4d1KsUs6
         zZkrvZRwCAicOGPdO1WEysaWHKzG6lc+eAfJLR5SVrduLFlEa9t97gRZaGtryRQTvTF6
         DN+zJmSMqtni4l9nvzLl9w6mAiSs7SFlgoT+j+D7cYhwmt/hfKvA2r9AnuQPden7aXwr
         M2/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU+54MumYyjdaka5MAAneN7ppSSKis4TmbU7HBCCo7QuD6gjpXpLZjQitG61QVS3RNSjEv0qai7WPE4MTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzapEr8gCGAvskdTUMUGkD90u6LLntcP8tp+ExpQtRzxhpdbjx5
	qt/gKvI3WliNV4fCF6YuUUu9g6lC/Ey6W1W9gfLnIU7TAUr44fyJ2iRKZSHcY3E=
X-Gm-Gg: ASbGncsVArEx3JCMwAEf+pwqCzfPhr5+2GvoeMODu7fAFyXsmmbjDKYsbrnnEFKzrdQ
	Z0D3z3kBlCw863LRcGE1ZE6O0M9FTcCKLIw9zPgLr+n2wdOdj/n+nkZGwBJEyqMvPv1fAGrB1U/
	m6ZVWfd0i7PcS0n1fC+6zXAzp1lZcVjmR+DGAd1M7gS9LkZ4xXKupHJsaYpPNB6quo6eM2pMF7Q
	WCYI3wzfLBtAqNJmrGkSCQIr9fJsr+a5bxJ6afOdK8xQdN9wC0Iwo5trvfL+RWZZgmfY2GNdF6a
	uhKna14cqRANBGH+7dtBCXX5HC5oVl4=
X-Google-Smtp-Source: AGHT+IEbl3LTjrdqPSH5d3kkpLqYi842EMyLleWiCvMkmyw1mm4oqWLsvTK8TF5jjGJQgV7w+8Emkg==
X-Received: by 2002:a05:600c:19ce:b0:439:99e6:2ab with SMTP id 5b1f17b1804b1-43ba6766b44mr95692715e9.28.1741015414338;
        Mon, 03 Mar 2025 07:23:34 -0800 (PST)
Received: from localhost ([2a03:2880:31ff::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bad347823sm110368705e9.0.2025.03.03.07.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:23:33 -0800 (PST)
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
Subject: [PATCH bpf-next v3 19/25] bpf: Convert hashtab.c to rqspinlock
Date: Mon,  3 Mar 2025 07:22:59 -0800
Message-ID: <20250303152305.3195648-20-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250303152305.3195648-1-memxor@gmail.com>
References: <20250303152305.3195648-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11131; h=from:subject; bh=4ih0G/0286de3X2HOwCgeQ8ZZwbokSdXkcTQRkadVk8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxcWYUEPdLFj8sZgqLb5zn7VbigpDGWSBgEbqM3XA x/fwLJeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8XFmAAKCRBM4MiGSL8Ryv8LD/ 97jXIjkq7Lj++KTQTcQoBHp5m3OgRssDYOiFDubICyCP6RJL9F3I1YPvZ3V7aYFcJJBEuTYglkhD3z vdEzq0g+0G/b/2vgbS8q/Q6tlI4W54PihyS+qwGrnVz3uJPq2Vh8nK0kcPwLJzfLzM9O0weSfEcFz3 WN5AmPXgB759SWiegOPd5FlfEdvcgoDzQHqKNy5Oc4QGYqMMxfoe1BajpDdGIKckYE1k/Q3jD4Ika7 0Ocsr3XMKJdKzWaZ0++mS0Xg1WPgVlB28K08SYP/VcJv8ymSdntzx3T2FCD5ezdoG+8lXnrnhFKkSq JPUZizhxMzGDID+hebcv5VroikizRXHUOZP+OdlHq3FVRtQcu9YmttvUI/AYkCqVIlchD1WcW7nPg3 wBl+QpZfzhAmz3RlwPTacFVnw92AeQLJ/wEgyufOlTdQkFBwITR04JWL46ibiZugmnV5nF/HRctNPR z8cV3U0H2O39bk3dQ7m7Gb17vyUwD+31Bu/9WsIU+oFd9vj3uWEWCMCk7SbIHD+lTSHwZ9j90+KCKm 2aohPllCBBFhVPuDHR3hlKDDoNV1hA1lVZZIbepftZGRQYKUeoQQdxjHTha7P81H3VVeD0xhU+HmJN uqimoBk7BWk8BQ4E3HYoNBJ1UHaIZO4UP5kjM4Il4c+PzynID4cM955BCL0A==
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
index c308300fc72f..93d45812bb6a 100644
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


