Return-Path: <bpf+bounces-48116-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD622A04187
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7C31669CC
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC671F5419;
	Tue,  7 Jan 2025 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipNQ8hnH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD331F37DA;
	Tue,  7 Jan 2025 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258447; cv=none; b=kcmWNheNnB7Tb03SVbMzTGN590S1lEJyJ/2NIVfscyQDovqsVb7h31et5sn1Qns/jt4OswbOrtjt1iopDiXuZWE7hVRxIWNRkD7xVypCmIGmc08Q1ihfV/YrbMqnDcUifgGc9uRCGJIVxhbrslM0UPTdAwR3MsJifhv4LA5JlBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258447; c=relaxed/simple;
	bh=xdzrOKPZ2hWmwTFGQ/lfbwpf7gE6CrMOaZO+ckuikt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lO54LDwstKtz4HQud2SwniQKIsJNE0UAfADZ5gO6jMurOaOA4nDomiXtS4mhEIsj0Td2+LZc1EyrewKlzv4EfYQRP6meeSEx79GM9P2v0JvRWcgHJhh4pE2LqEk6vLPR/fIHtVbW2Q8JVNxEazRqCMvjJ6vM3z1OOBjJhi2OL/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipNQ8hnH; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-38a34e8410bso5250203f8f.2;
        Tue, 07 Jan 2025 06:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258436; x=1736863236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXPNOF/hUFV5nXz313sgiC85dPV+9kptxTXp73D/GXc=;
        b=ipNQ8hnH3kLT5pgeyfSbn0l/osd5hl2rrEr82q0HTQuGt8tb9Fny/EbPuEFKjVw8un
         rpbdzdUGm20VVDCb6dKLV8RRlWie9Dx5r6evwKT5X0k0tBxyJcbJ5QXJ0clmLeYxTgHG
         7P+/a5oS9sH+yVXpR0llbqkfb40ZjxwfuatCx3R5wuHenTV9xVCXCitZ9g+/p8frNYw2
         KLTHbIRdyymgVZjrqhOQyir1t2x3kNyEqAeXJpeEG4ep+vHPl+YXEy+ri6W+uSaDebLr
         lEyIZyEyMlDo1NWjdl2xbg8tiQnhzp+L+VAMdCaLSEfKwpAQCvbAMZmgzWpReCk1DPuh
         4Vqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258436; x=1736863236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXPNOF/hUFV5nXz313sgiC85dPV+9kptxTXp73D/GXc=;
        b=aWfomJyuLhns5UBVgvXB+IZtiXoMquBeBmb8dmFl+bi3+z5vrQHoAvoGv6V1g6GfRP
         quZMIJOVh3XW1cWp7YG2/zpRbTBECsDz9LDRlAvd7NSURX8lnPhjPiIbOY45t1OEahho
         l8dT9OknKl/V+taOhXpaeuf2GOW2TzQyg2116uayPd+SXxTPUThceDjBJWh1eT2/1bph
         o8oAyFNkzYRitsHDCl95iTuyHJlDEBrSj9oEM0RcJk3EHZG8St/pyk0cixXSD0xCZXku
         3qQy2Q9ZIxw6ikQm8YCV9j0VGhO8lF0V4Yu4DRALdInKus3HTXQATvAwCuNyR1zftLEg
         rF6w==
X-Forwarded-Encrypted: i=1; AJvYcCVmDLKNrSTCPuJJpLhE1TxMP9+q6OllmUYtvROFHiOl9djQOtCcQZlYS/k0Dk0kNgXd+ClXqF91oGzeSH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiCZaElcZA+imgasYU/5SKmoNe8h3xHAePEWEAjykfKn/mNJ5c
	lrMaa+53xXOwKD2H+Ch6Lir2HCFQK/D56g9GYtRj2QEfQyn4OECWLlPIOgcNzGm6bg==
X-Gm-Gg: ASbGncugLS73+z0B70fQGaZCPTwEtfWIJaAE8R1BXHCSGZxjrGdiiIuRPKSYZdl1AjK
	cMH52EfeHjw433muTdhFURrVMeVuehwAPxtYqJ+ZcMiYI8ctBGqVIMn9sbe8Xt1Hulhpo1jH9sb
	iClFZDXQxYEyCYGBzSfnD7MMxwVx8Sm3neg4xBuUkOQgmgmKoyRbgrrq6IRuyOkmsazlql4z9/4
	tJcZEimEChr+kSkEfLIKipHAc0hssLvJASxDtVoh5rGD/I=
X-Google-Smtp-Source: AGHT+IGLfX3le1QF9bFuhgiOYIfr3Kpec/JwVBCxhKp/J0T/5VVQWnITzhPKTHdsnojBfAiX98uvmg==
X-Received: by 2002:a05:6000:704:b0:385:ee40:2d88 with SMTP id ffacd0b85a97d-38a221f2e42mr56413347f8f.3.1736258435410;
        Tue, 07 Jan 2025 06:00:35 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:16::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e1acsm50596658f8f.68.2025.01.07.06.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 06:00:34 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 17/22] bpf: Convert hashtab.c to rqspinlock
Date: Tue,  7 Jan 2025 05:59:59 -0800
Message-ID: <20250107140004.2732830-18-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250107140004.2732830-1-memxor@gmail.com>
References: <20250107140004.2732830-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10951; h=from:subject; bh=xdzrOKPZ2hWmwTFGQ/lfbwpf7gE6CrMOaZO+ckuikt0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnfTCeMLpqDtB36p7NuDOzStRRHxvhRzx96sTrG7Gi uYck1AaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ30wngAKCRBM4MiGSL8RymsiD/ 9WQZ336g12w3rHKDIJE2I4sim5v8DwTfukkzyRWVts2f+/j05TRAVFWlP1or6MzFmH2SvxERFxUeUr O0B/FaUV1tvnu+ucGLw5OEC/8ilr1UvYo0q0HDRkMdjEki1Z/8PDUCqVXlvRKTG8Slymb/6vwGrdEa MBEx2fbp79VcwJ7wMXAZd4SPMOeeNGXqIiqgoGc3zS9FehyqHGo9OU5i0IJyEDljE3sgkwgDFVR+Mc 7CESpZHH2rmvDHihnYhMMZYQbsoU+vkekLopWrkps/MkHrop7KsWIaAc8MbtEaLVLTzFDR4KPlt+Xd n9WnjDGTaqoLEdWSfg9aUhJGY6M8iONRA0p4NWWDJkQBWuMmNXSjvB7CBg0mKsLm92hdJRm9qfa98L 0exts//aEVPGR+pAhhXWG0tu6vm7T/lW70lKH5zPFXts3Vv8R6u2dJk328avQdWQlELcKX7PxkyGgR f3K4cvS4MjKHfYxVukaOCa2Cg82azsZllfXYix22JB0amU0oW3m0UNjXmm48Yc9uytKKjt9fOVPMxT qHO+wcRF8IOvhb29Luddzsq3/HdxahLTNLYUCMK9pZQyhSnUkLu4tjE7UmYO4i8P4P8zeRu4kRuP7e GliGoEyZyao2qMk3ZzcPnhmCuhY/1FpGl0sFp9s5ivqaZdorDKqOad3yRvYA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Convert hashtab.c from raw_spinlock to rqspinlock, and drop the hashed
per-cpu counter crud from the code base which is no longer necessary.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/hashtab.c | 102 ++++++++++++++-----------------------------
 1 file changed, 32 insertions(+), 70 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 3ec941a0ea41..6812b114b811 100644
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
 
@@ -829,7 +795,7 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 			break;
 		}
 
-	htab_unlock_bucket(htab, b, tgt_l->hash, flags);
+	htab_unlock_bucket(b, flags);
 
 	return l == tgt_l;
 }
@@ -1148,7 +1114,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		 */
 	}
 
-	ret = htab_lock_bucket(htab, b, hash, &flags);
+	ret = htab_lock_bucket(b, &flags);
 	if (ret)
 		return ret;
 
@@ -1199,7 +1165,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 			check_and_free_fields(htab, l_old);
 		}
 	}
-	htab_unlock_bucket(htab, b, hash, flags);
+	htab_unlock_bucket(b, flags);
 	if (l_old) {
 		if (old_map_ptr)
 			map->ops->map_fd_put_ptr(map, old_map_ptr, true);
@@ -1208,7 +1174,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 	}
 	return 0;
 err:
-	htab_unlock_bucket(htab, b, hash, flags);
+	htab_unlock_bucket(b, flags);
 	return ret;
 }
 
@@ -1255,7 +1221,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	copy_map_value(&htab->map,
 		       l_new->key + round_up(map->key_size, 8), value);
 
-	ret = htab_lock_bucket(htab, b, hash, &flags);
+	ret = htab_lock_bucket(b, &flags);
 	if (ret)
 		goto err_lock_bucket;
 
@@ -1276,7 +1242,7 @@ static long htab_lru_map_update_elem(struct bpf_map *map, void *key, void *value
 	ret = 0;
 
 err:
-	htab_unlock_bucket(htab, b, hash, flags);
+	htab_unlock_bucket(b, flags);
 
 err_lock_bucket:
 	if (ret)
@@ -1313,7 +1279,7 @@ static long __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
-	ret = htab_lock_bucket(htab, b, hash, &flags);
+	ret = htab_lock_bucket(b, &flags);
 	if (ret)
 		return ret;
 
@@ -1338,7 +1304,7 @@ static long __htab_percpu_map_update_elem(struct bpf_map *map, void *key,
 	}
 	ret = 0;
 err:
-	htab_unlock_bucket(htab, b, hash, flags);
+	htab_unlock_bucket(b, flags);
 	return ret;
 }
 
@@ -1379,7 +1345,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 			return -ENOMEM;
 	}
 
-	ret = htab_lock_bucket(htab, b, hash, &flags);
+	ret = htab_lock_bucket(b, &flags);
 	if (ret)
 		goto err_lock_bucket;
 
@@ -1403,7 +1369,7 @@ static long __htab_lru_percpu_map_update_elem(struct bpf_map *map, void *key,
 	}
 	ret = 0;
 err:
-	htab_unlock_bucket(htab, b, hash, flags);
+	htab_unlock_bucket(b, flags);
 err_lock_bucket:
 	if (l_new) {
 		bpf_map_dec_elem_count(&htab->map);
@@ -1445,7 +1411,7 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
-	ret = htab_lock_bucket(htab, b, hash, &flags);
+	ret = htab_lock_bucket(b, &flags);
 	if (ret)
 		return ret;
 
@@ -1455,7 +1421,7 @@ static long htab_map_delete_elem(struct bpf_map *map, void *key)
 	else
 		ret = -ENOENT;
 
-	htab_unlock_bucket(htab, b, hash, flags);
+	htab_unlock_bucket(b, flags);
 
 	if (l)
 		free_htab_elem(htab, l);
@@ -1481,7 +1447,7 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
 	b = __select_bucket(htab, hash);
 	head = &b->head;
 
-	ret = htab_lock_bucket(htab, b, hash, &flags);
+	ret = htab_lock_bucket(b, &flags);
 	if (ret)
 		return ret;
 
@@ -1492,7 +1458,7 @@ static long htab_lru_map_delete_elem(struct bpf_map *map, void *key)
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
 
@@ -1669,7 +1631,7 @@ static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
 			free_htab_elem(htab, l);
 	}
 
-	htab_unlock_bucket(htab, b, hash, bflags);
+	htab_unlock_bucket(b, bflags);
 
 	if (is_lru_map && l)
 		htab_lru_push_free(htab, l);
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


