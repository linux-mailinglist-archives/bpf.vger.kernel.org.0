Return-Path: <bpf+bounces-61004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9324ADF905
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 23:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D815A1BC2F9C
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 21:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E51127E05E;
	Wed, 18 Jun 2025 21:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbJN7pci"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A093085CC;
	Wed, 18 Jun 2025 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750283891; cv=none; b=aH931AWIj9ojWOOjRJ+au3MKRX9P2OukEC5d4bekbZU5ijdzUib7ukArX2ifigecbFa0R65pCwVopVlcRhQO/HoOMDaYJTObs7dSyYsu5sqpyhlLXikyvScQq8cy5s9YIovMfO1YPjOP1xMBYfIApjeRcKXkUuXg7opi6H1JWEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750283891; c=relaxed/simple;
	bh=yJsbq1IWXO08CcKTCfgvUVHQT1Wdy3SNGG4MgMyABdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QM3clpqkSh46slX+XDDOy1/sPA3DzSd8LgV2yJAADOo9hyGhdNrKY+0eqYqeqCHC7XzxMD1TGtYoOtWI53mivnZURAxf8wiHZ8eZPrcNtxkg6vwj2HQi6hYU25q8y2SSeyQ+ad1nTDPhWvJihPqYxP6LkNe5QHgQH76ZWyfGJ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbJN7pci; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ff4faf858cso1306327b3.2;
        Wed, 18 Jun 2025 14:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750283888; x=1750888688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=73cezDSyml9AJ+BqkIuzybNwK78QimGTelN0nf48USU=;
        b=CbJN7pciq8thqUtGbmbVxjlLA/xsm+eJu1+4Oi08rRHaeDWfHlUrGET1S3K48aelk7
         pXj+o5ow0nFTRvlf6OeHzonhAIQQErKyav4byINlkuovmcwnntx4EA8LobjKXnHKBlc8
         gpMzYrQ4Eq4RNi5Z1rld51Og1Ntn7O03cFDKpRbFyFaGKYxEEJ+BsZGPDPJ87T9Rcou1
         TmBaPfLOYJIh0kWzaAYMA0UKs0CIiTL15wpb7J7kOP1Rxw0mVdrxUpQgIysOkQt5VZfk
         wOob73eleJkN0dzKHp6q401KKtuyn7kaeURRemjYtCH0xPyeMk6LG9zN5Ka6Q6zjxHav
         KDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750283888; x=1750888688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=73cezDSyml9AJ+BqkIuzybNwK78QimGTelN0nf48USU=;
        b=MjrwxSF13Ebg6A+t3vq1pvzl4oshoh/VWhzxbDygK5eLeIUOhZ6Rq5i0E85OUi1Gjl
         Z+908U9DZALnY+2Hi36iOH6n9EzXDGd572dGoHFpbbRg5uJlyob1NE9qffnmseWd3mf7
         XlPbExOsgLuH3MYB927QMSTvV4V15fDzUJ+xMW+E0Z3V0d+XfZSYjPzf98qodopMiZkH
         GdBKNYoNAwGgM1xU69BATE+AXZklj3phx1EPoLlwjnIjaobqku81DH6QRxXnS+sQIzNq
         kdyfxct/3Eqylhbm7nsgZ7Ej+whIcKDQKUc5kzZOgrRbrjwzPrRyNIKs89FOJz+APtQY
         z5QA==
X-Gm-Message-State: AOJu0YwRBmDNljlvOG0hgrVXr82MefB+sc6G8lEUyBKNn/ettS3w8IgJ
	reK0DXFa1nqoeIL7q20f/SmwE4GVy5eVHCv/EUnARMfSux6XjERt1nf5Wn9Dnw==
X-Gm-Gg: ASbGncsA6dDI1O3AOICI1fkTR67whhArbYSo4RNWri7EqKyn/F0Mo8Mvx+eDtYwgVbT
	updHC71IthZoeLI+RKu/5gdu2BgK9sA/9Q5S5o9gdkYPo+xKiA36wkZIIOP7YdFWtqkXIsZs0SE
	j5XfFn43nIa+BlEEmuqQKNCPdl/1KKqavbq9T+XRUD+hBaTJBlUbzMCIx9qywZl/+Nc1oUz93VU
	wORCA46xr/LJXbisE8iokwKmaoiguOCkvc0i0c8S0wor6q/ht/D1HJRjtQvvTsQILt4BeQmI7Dy
	BP+JbsgB1IdDPc9J/qlSduRNNZ2IubW6JlNfvqpKSt1UZquLGZCne5AVo9yj6y9vgBE+oWFStwP
	Vmf8zpkA1BImdJDUj6jrGaOi7tzClH2f0gQndmoBUV0UNnPCddxrqP9O9o/8jy+14
X-Google-Smtp-Source: AGHT+IGS7+Mv+rgkJoJAsL4Daj7JDUqtP8uzaMIUK4XHzawB+y8cSWMMU9PE2SiLmCsoomgo3M1OFA==
X-Received: by 2002:a05:690c:3512:b0:70d:f3bb:a731 with SMTP id 00721157ae682-7117539977cmr253699097b3.9.1750283887684;
        Wed, 18 Jun 2025 14:58:07 -0700 (PDT)
Received: from willemb.c.googlers.com.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-712b7aaf176sm276677b3.54.2025.06.18.14.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 14:58:07 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	stfomichev@gmail.com,
	a.s.protopopov@gmail.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH bpf v2] bpf: lru: adjust free target to avoid global table starvation
Date: Wed, 18 Jun 2025 17:57:40 -0400
Message-ID: <20250618215803.3587312-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

BPF_MAP_TYPE_LRU_HASH can recycle most recent elements well before the
map is full, due to percpu reservations and force shrink before
neighbor stealing. Once a CPU is unable to borrow from the global map,
it will once steal one elem from a neighbor and after that each time
flush this one element to the global list and immediately recycle it.

Batch value LOCAL_FREE_TARGET (128) will exhaust a 10K element map
with 79 CPUs. CPU 79 will observe this behavior even while its
neighbors hold 78 * 127 + 1 * 15 == 9921 free elements (99%).

CPUs need not be active concurrently. The issue can appear with
affinity migration, e.g., irqbalance. Each CPU can reserve and then
hold onto its 128 elements indefinitely.

Avoid global list exhaustion by limiting aggregate percpu caches to
half of map size, by adjusting LOCAL_FREE_TARGET based on cpu count.
This change has no effect on sufficiently large tables.

Similar to LOCAL_NR_SCANS and lru->nr_scans, introduce a map variable
lru->free_target. The extra field fits in a hole in struct bpf_lru.
The cacheline is already warm where read in the hot path. The field is
only accessed with the lru lock held.

Tested-by: Anton Protopopov <a.s.protopopov@gmail.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Changes
  v1 -> v2
    - Update documentation (Stanislav)
    - Add Tested-by (Anton)
    - Update test comments (As mentioned in v1)

  v1: https://lore.kernel.org/netdev/20250616143846.2154727-1-willemdebruijn.kernel@gmail.com/
---
 Documentation/bpf/map_hash.rst             |  8 ++-
 Documentation/bpf/map_lru_hash_update.dot  |  6 +-
 kernel/bpf/bpf_lru_list.c                  |  9 ++-
 kernel/bpf/bpf_lru_list.h                  |  1 +
 tools/testing/selftests/bpf/test_lru_map.c | 72 +++++++++++-----------
 5 files changed, 52 insertions(+), 44 deletions(-)

diff --git a/Documentation/bpf/map_hash.rst b/Documentation/bpf/map_hash.rst
index d2343952f2cb..8606bf958a8c 100644
--- a/Documentation/bpf/map_hash.rst
+++ b/Documentation/bpf/map_hash.rst
@@ -233,10 +233,16 @@ attempts in order to enforce the LRU property which have increasing impacts on
 other CPUs involved in the following operation attempts:
 
 - Attempt to use CPU-local state to batch operations
-- Attempt to fetch free nodes from global lists
+- Attempt to fetch ``target_free`` free nodes from global lists
 - Attempt to pull any node from a global list and remove it from the hashmap
 - Attempt to pull any node from any CPU's list and remove it from the hashmap
 
+The number of nodes to borrow from the global list in a batch, ``target_free``,
+depends on the size of the map. Larger batch size reduces lock contention, but
+may also exhaust the global structure. The value is computed at map init to
+avoid exhaustion, by limiting aggregate reservation by all CPUs to half the map
+size. With a minimum of a single element and maximum budget of 128 at a time.
+
 This algorithm is described visually in the following diagram. See the
 description in commit 3a08c2fd7634 ("bpf: LRU List") for a full explanation of
 the corresponding operations:
diff --git a/Documentation/bpf/map_lru_hash_update.dot b/Documentation/bpf/map_lru_hash_update.dot
index a0fee349d29c..ab10058f5b79 100644
--- a/Documentation/bpf/map_lru_hash_update.dot
+++ b/Documentation/bpf/map_lru_hash_update.dot
@@ -35,18 +35,18 @@ digraph {
   fn_bpf_lru_list_pop_free_to_local [shape=rectangle,fillcolor=2,
     label="Flush local pending,
     Rotate Global list, move
-    LOCAL_FREE_TARGET
+    target_free
     from global -> local"]
   // Also corresponds to:
   // fn__local_list_flush()
   // fn_bpf_lru_list_rotate()
   fn___bpf_lru_node_move_to_free[shape=diamond,fillcolor=2,
-    label="Able to free\nLOCAL_FREE_TARGET\nnodes?"]
+    label="Able to free\ntarget_free\nnodes?"]
 
   fn___bpf_lru_list_shrink_inactive [shape=rectangle,fillcolor=3,
     label="Shrink inactive list
       up to remaining
-      LOCAL_FREE_TARGET
+      target_free
       (global LRU -> local)"]
   fn___bpf_lru_list_shrink [shape=diamond,fillcolor=2,
     label="> 0 entries in\nlocal free list?"]
diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
index 3dabdd137d10..2d6e1c98d8ad 100644
--- a/kernel/bpf/bpf_lru_list.c
+++ b/kernel/bpf/bpf_lru_list.c
@@ -337,12 +337,12 @@ static void bpf_lru_list_pop_free_to_local(struct bpf_lru *lru,
 				 list) {
 		__bpf_lru_node_move_to_free(l, node, local_free_list(loc_l),
 					    BPF_LRU_LOCAL_LIST_T_FREE);
-		if (++nfree == LOCAL_FREE_TARGET)
+		if (++nfree == lru->target_free)
 			break;
 	}
 
-	if (nfree < LOCAL_FREE_TARGET)
-		__bpf_lru_list_shrink(lru, l, LOCAL_FREE_TARGET - nfree,
+	if (nfree < lru->target_free)
+		__bpf_lru_list_shrink(lru, l, lru->target_free - nfree,
 				      local_free_list(loc_l),
 				      BPF_LRU_LOCAL_LIST_T_FREE);
 
@@ -577,6 +577,9 @@ static void bpf_common_lru_populate(struct bpf_lru *lru, void *buf,
 		list_add(&node->list, &l->lists[BPF_LRU_LIST_T_FREE]);
 		buf += elem_size;
 	}
+
+	lru->target_free = clamp((nr_elems / num_possible_cpus()) / 2,
+				 1, LOCAL_FREE_TARGET);
 }
 
 static void bpf_percpu_lru_populate(struct bpf_lru *lru, void *buf,
diff --git a/kernel/bpf/bpf_lru_list.h b/kernel/bpf/bpf_lru_list.h
index cbd8d3720c2b..fe2661a58ea9 100644
--- a/kernel/bpf/bpf_lru_list.h
+++ b/kernel/bpf/bpf_lru_list.h
@@ -58,6 +58,7 @@ struct bpf_lru {
 	del_from_htab_func del_from_htab;
 	void *del_arg;
 	unsigned int hash_offset;
+	unsigned int target_free;
 	unsigned int nr_scans;
 	bool percpu;
 };
diff --git a/tools/testing/selftests/bpf/test_lru_map.c b/tools/testing/selftests/bpf/test_lru_map.c
index fda7589c5023..4ae83f4b7fc7 100644
--- a/tools/testing/selftests/bpf/test_lru_map.c
+++ b/tools/testing/selftests/bpf/test_lru_map.c
@@ -138,6 +138,12 @@ static int sched_next_online(int pid, int *next_to_try)
 	return ret;
 }
 
+/* Inverse of how bpf_common_lru_populate derives target_free from map_size. */
+static unsigned int __map_size(unsigned int tgt_free)
+{
+	return tgt_free * nr_cpus * 2;
+}
+
 /* Size of the LRU map is 2
  * Add key=1 (+1 key)
  * Add key=2 (+1 key)
@@ -231,11 +237,11 @@ static void test_lru_sanity0(int map_type, int map_flags)
 	printf("Pass\n");
 }
 
-/* Size of the LRU map is 1.5*tgt_free
- * Insert 1 to tgt_free (+tgt_free keys)
- * Lookup 1 to tgt_free/2
- * Insert 1+tgt_free to 2*tgt_free (+tgt_free keys)
- * => 1+tgt_free/2 to LOCALFREE_TARGET will be removed by LRU
+/* Verify that unreferenced elements are recycled before referenced ones.
+ * Insert elements.
+ * Reference a subset of these.
+ * Insert more, enough to trigger recycling.
+ * Verify that unreferenced are recycled.
  */
 static void test_lru_sanity1(int map_type, int map_flags, unsigned int tgt_free)
 {
@@ -257,7 +263,7 @@ static void test_lru_sanity1(int map_type, int map_flags, unsigned int tgt_free)
 	batch_size = tgt_free / 2;
 	assert(batch_size * 2 == tgt_free);
 
-	map_size = tgt_free + batch_size;
+	map_size = __map_size(tgt_free) + batch_size;
 	lru_map_fd = create_map(map_type, map_flags, map_size);
 	assert(lru_map_fd != -1);
 
@@ -266,13 +272,13 @@ static void test_lru_sanity1(int map_type, int map_flags, unsigned int tgt_free)
 
 	value[0] = 1234;
 
-	/* Insert 1 to tgt_free (+tgt_free keys) */
-	end_key = 1 + tgt_free;
+	/* Insert map_size - batch_size keys */
+	end_key = 1 + __map_size(tgt_free);
 	for (key = 1; key < end_key; key++)
 		assert(!bpf_map_update_elem(lru_map_fd, &key, value,
 					    BPF_NOEXIST));
 
-	/* Lookup 1 to tgt_free/2 */
+	/* Lookup 1 to batch_size */
 	end_key = 1 + batch_size;
 	for (key = 1; key < end_key; key++) {
 		assert(!bpf_map_lookup_elem_with_ref_bit(lru_map_fd, key, value));
@@ -280,12 +286,13 @@ static void test_lru_sanity1(int map_type, int map_flags, unsigned int tgt_free)
 					    BPF_NOEXIST));
 	}
 
-	/* Insert 1+tgt_free to 2*tgt_free
-	 * => 1+tgt_free/2 to LOCALFREE_TARGET will be
+	/* Insert another map_size - batch_size keys
+	 * Map will contain 1 to batch_size plus these latest, i.e.,
+	 * => previous 1+batch_size to map_size - batch_size will have been
 	 * removed by LRU
 	 */
-	key = 1 + tgt_free;
-	end_key = key + tgt_free;
+	key = 1 + __map_size(tgt_free);
+	end_key = key + __map_size(tgt_free);
 	for (; key < end_key; key++) {
 		assert(!bpf_map_update_elem(lru_map_fd, &key, value,
 					    BPF_NOEXIST));
@@ -301,17 +308,8 @@ static void test_lru_sanity1(int map_type, int map_flags, unsigned int tgt_free)
 	printf("Pass\n");
 }
 
-/* Size of the LRU map 1.5 * tgt_free
- * Insert 1 to tgt_free (+tgt_free keys)
- * Update 1 to tgt_free/2
- *   => The original 1 to tgt_free/2 will be removed due to
- *      the LRU shrink process
- * Re-insert 1 to tgt_free/2 again and do a lookup immeidately
- * Insert 1+tgt_free to tgt_free*3/2
- * Insert 1+tgt_free*3/2 to tgt_free*5/2
- *   => Key 1+tgt_free to tgt_free*3/2
- *      will be removed from LRU because it has never
- *      been lookup and ref bit is not set
+/* Verify that insertions exceeding map size will recycle the oldest.
+ * Verify that unreferenced elements are recycled before referenced.
  */
 static void test_lru_sanity2(int map_type, int map_flags, unsigned int tgt_free)
 {
@@ -334,7 +332,7 @@ static void test_lru_sanity2(int map_type, int map_flags, unsigned int tgt_free)
 	batch_size = tgt_free / 2;
 	assert(batch_size * 2 == tgt_free);
 
-	map_size = tgt_free + batch_size;
+	map_size = __map_size(tgt_free) + batch_size;
 	lru_map_fd = create_map(map_type, map_flags, map_size);
 	assert(lru_map_fd != -1);
 
@@ -343,8 +341,8 @@ static void test_lru_sanity2(int map_type, int map_flags, unsigned int tgt_free)
 
 	value[0] = 1234;
 
-	/* Insert 1 to tgt_free (+tgt_free keys) */
-	end_key = 1 + tgt_free;
+	/* Insert map_size - batch_size keys */
+	end_key = 1 + __map_size(tgt_free);
 	for (key = 1; key < end_key; key++)
 		assert(!bpf_map_update_elem(lru_map_fd, &key, value,
 					    BPF_NOEXIST));
@@ -357,8 +355,7 @@ static void test_lru_sanity2(int map_type, int map_flags, unsigned int tgt_free)
 	 * shrink the inactive list to get tgt_free
 	 * number of free nodes.
 	 *
-	 * Hence, the oldest key 1 to tgt_free/2
-	 * are removed from the LRU list.
+	 * Hence, the oldest key is removed from the LRU list.
 	 */
 	key = 1;
 	if (map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
@@ -370,8 +367,7 @@ static void test_lru_sanity2(int map_type, int map_flags, unsigned int tgt_free)
 					   BPF_EXIST));
 	}
 
-	/* Re-insert 1 to tgt_free/2 again and do a lookup
-	 * immeidately.
+	/* Re-insert 1 to batch_size again and do a lookup immediately.
 	 */
 	end_key = 1 + batch_size;
 	value[0] = 4321;
@@ -387,17 +383,18 @@ static void test_lru_sanity2(int map_type, int map_flags, unsigned int tgt_free)
 
 	value[0] = 1234;
 
-	/* Insert 1+tgt_free to tgt_free*3/2 */
-	end_key = 1 + tgt_free + batch_size;
-	for (key = 1 + tgt_free; key < end_key; key++)
+	/* Insert batch_size new elements */
+	key = 1 + __map_size(tgt_free);
+	end_key = key + batch_size;
+	for (; key < end_key; key++)
 		/* These newly added but not referenced keys will be
 		 * gone during the next LRU shrink.
 		 */
 		assert(!bpf_map_update_elem(lru_map_fd, &key, value,
 					    BPF_NOEXIST));
 
-	/* Insert 1+tgt_free*3/2 to  tgt_free*5/2 */
-	end_key = key + tgt_free;
+	/* Insert map_size - batch_size elements */
+	end_key += __map_size(tgt_free);
 	for (; key < end_key; key++) {
 		assert(!bpf_map_update_elem(lru_map_fd, &key, value,
 					    BPF_NOEXIST));
@@ -500,7 +497,8 @@ static void test_lru_sanity4(int map_type, int map_flags, unsigned int tgt_free)
 		lru_map_fd = create_map(map_type, map_flags,
 					3 * tgt_free * nr_cpus);
 	else
-		lru_map_fd = create_map(map_type, map_flags, 3 * tgt_free);
+		lru_map_fd = create_map(map_type, map_flags,
+					3 * __map_size(tgt_free));
 	assert(lru_map_fd != -1);
 
 	expected_map_fd = create_map(BPF_MAP_TYPE_HASH, 0,
-- 
2.50.0.rc2.701.gf1e915cc24-goog


