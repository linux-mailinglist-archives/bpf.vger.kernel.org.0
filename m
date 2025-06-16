Return-Path: <bpf+bounces-60731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E837ADB415
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 16:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67BC37A6898
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 14:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A715210F59;
	Mon, 16 Jun 2025 14:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y1UZhpBd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF481EF09D;
	Mon, 16 Jun 2025 14:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084744; cv=none; b=CrOhIUZ8xPrhxDZ4lvoNCH5uzVS9MVMemMlvBEmj5PP8WV8Ar/Vp42ToQjx/D2r9mHRxk/zGQOZMMW+GixL5HigaxuXRH1wnH7ZtuaHaiX5aXlkhp8qkYF0sH1yutDn8pWL4IKvAfblUs9h7McijVnUA0UaYwSOA9dS0huRaMw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084744; c=relaxed/simple;
	bh=/kkrYX7r+qW0Hw4xaL48DO0/DGQE48/qyyCrBfXD1Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kdN3/F7Pw9edUTmODG7AZ+C1yBVvlJ6Vyt+IoXPbU8cAglE3WOjn2QNqslQ/OW+U0tt+pgsuTLfC/FWAIqwNaStFVdmoIZziBm1TKNXnplxZ9MXyMiRLbubde3HCv/2WF9jPBo5yu0rotq/046MgEYe3l2Kbn172rIh3fOFAva4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y1UZhpBd; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71101668dedso38508517b3.1;
        Mon, 16 Jun 2025 07:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750084741; x=1750689541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rB8goAWp1em9/W2902mkORSKW2uX2N5v9ygA6Nz1q8g=;
        b=Y1UZhpBdXHYwwbAJDzFbTXX+OZmlmqQt0PDx+eum+xgLhOjG+9h7mE5ppxpOC1Hsb3
         e+ud4J/Yh3MuOVnOYbIkr1IoKkPGhAVaKTKJbYqvOsOIGzLDAmhFyO/s/8H3Mg2CHScF
         2awfR6NbxA34DDvjIqCBFtQD0RQgw84+I9YnQFt2DzFanuZzgL5DjDBIm9VG90aWtpDK
         MnNOBjyDi0J+6cKBRwZALqC230M5CRna4rqvpcXpMboCwP8PPcF9pF1oX2zOjbVciLRW
         YyS54pf2nHYl3r9qiiYfR7fwgcDsaLjDVmjCH7r7uX3yzIZnYQspX7uEO88D75MHPm64
         9bcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750084741; x=1750689541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rB8goAWp1em9/W2902mkORSKW2uX2N5v9ygA6Nz1q8g=;
        b=rYCjUfQuQLGeSCOt/eojwOS208qSn8svpb7ZqWtNB0ctwcioS7UlUkgIYUcmt7TnWr
         vDbjB4ibK7hGD0NKO2NFL9LVKfGoKy/H2jv/e8dICzeWrC3NaWvlv/Q5cFLTvsRNYphG
         tjK5fGH7827eqyOb6WwIvGxamehEy+W0kgZquQsbOOvGxhFiZRTSNg1H4ExVrQWxEHq/
         W7a4aC6sDaLfzkQByHgjOmm798+62flZvyNOG91ZVK3E3MkIPGCG2OPYuyonH6G4nWHs
         AbM5brOe+Ay1wn8jQTN00BuNNxk5JhQ9oSZRsJK/dTSymyB/0abvesSnJqaBOvHwgS3v
         AM2g==
X-Gm-Message-State: AOJu0YwFb8TjDiCgPiSx61mAxXHwQcc8eVB2Zs2XTOspKLAQ2lDwfGjh
	vCnN/BhMzeBpoKMqqC3X4oMYdp4Km3bx9ahj9nWrfjama6H+33ZHDR74UA8LsQ==
X-Gm-Gg: ASbGncs2ZNICfTRDuaxJXrRpyIrRAm0kPiAMaKOXyblmEoIGeG/d2ShK0VZB0rh2C/o
	xsVDFb4HT9JuVAajZnM/4u2dEvvRmaP4IxmMYAgo8NcThBwfSZBPpGE4JNK8/P+veFyKiCZtY1n
	IdsuSHSXs7G00O2hoxWUWIbKuezTcVaHrsPEPyhhFPtwSg8qv+oarrH8rCLTHuf6r6blCOIPFgh
	LDjrUDIQpYjQ+z+Mo2oDftWiAlnmtu9BFegeWwljoLsUspfJ0AEDlrb1bOpEcLwzUhHgKETeFBn
	rTFwnb9pWYjMJXmS+1/CvVjydnt4SPYn92AwNa9amUvRUCzjDOFVXGMUTSojXOHi04zr2U70yLP
	ZOdm2oFh34TcSbz7JZtfD/xeh4GM5a/tdVt3NVPUGsD4bShZhascZXrZemetFK+PF
X-Google-Smtp-Source: AGHT+IFZbCIPbbie27zsppwO/yodd/rb4EXgNbH3dMGkj1TkeyJECYDb+FUw9lWwWlg916dZoNvlvA==
X-Received: by 2002:a05:690c:708e:b0:70d:ee83:3733 with SMTP id 00721157ae682-7117520fc05mr139266887b3.0.1750084741143;
        Mon, 16 Jun 2025 07:39:01 -0700 (PDT)
Received: from willemb.c.googlers.com.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71152792fbfsm17741197b3.65.2025.06.16.07.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 07:39:00 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH bpf-next] bpf: lru: adjust free target to avoid global table starvation
Date: Mon, 16 Jun 2025 10:38:34 -0400
Message-ID: <20250616143846.2154727-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
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

The tests are updated to pass. Test comments are extensive: updating
those is left for a v2 if the approach is considered ok.

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

This suggested approach is a small patch, easy to understand, and
easy to verity to have no effect on sufficiently sized maps.

Global table exhaustion can be mitigated in other ways besides or
alongside this approach:

Grow the map.
  The most obvious approach, but increases memory use. And requires
  users to know map implementation details to choose a right size.

Round up map size.
  As htab_map_alloc does for the PERCPU variant of this list.
  Increases memory use, and a conservative strategy still leaves one
  element per CPU, and thus MRU behavior.

Steal from neighbors before force shrink.
  May increase lock contention.

Steal more than 1 element from neighbor when stealing.
  For instance, half its list. Requires traversing the entire list.

Steal from least recently active neighbors.
  Needs inactive CPU tracking.

Dynamic target_free: high and low watermarks to double/halve size.
   I also implemented this. Adjusts to the active CPU count, which may
   be << NR_CPUS. But it is hard to reason whether or at what level
   target_free will stabilize.
---
 kernel/bpf/bpf_lru_list.c                  |  9 ++++---
 kernel/bpf/bpf_lru_list.h                  |  1 +
 tools/testing/selftests/bpf/test_lru_map.c | 28 ++++++++++++++--------
 3 files changed, 25 insertions(+), 13 deletions(-)

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
index fda7589c5023..abb592553394 100644
--- a/tools/testing/selftests/bpf/test_lru_map.c
+++ b/tools/testing/selftests/bpf/test_lru_map.c
@@ -138,6 +138,12 @@ static int sched_next_online(int pid, int *next_to_try)
 	return ret;
 }
 
+/* inverse of how bpf_common_lru_populate derives target_free from map_size. */
+static unsigned int __map_size(unsigned int tgt_free)
+{
+	return tgt_free * nr_cpus * 2;
+}
+
 /* Size of the LRU map is 2
  * Add key=1 (+1 key)
  * Add key=2 (+1 key)
@@ -257,7 +263,7 @@ static void test_lru_sanity1(int map_type, int map_flags, unsigned int tgt_free)
 	batch_size = tgt_free / 2;
 	assert(batch_size * 2 == tgt_free);
 
-	map_size = tgt_free + batch_size;
+	map_size = __map_size(tgt_free) + batch_size;
 	lru_map_fd = create_map(map_type, map_flags, map_size);
 	assert(lru_map_fd != -1);
 
@@ -267,7 +273,7 @@ static void test_lru_sanity1(int map_type, int map_flags, unsigned int tgt_free)
 	value[0] = 1234;
 
 	/* Insert 1 to tgt_free (+tgt_free keys) */
-	end_key = 1 + tgt_free;
+	end_key = 1 + __map_size(tgt_free);
 	for (key = 1; key < end_key; key++)
 		assert(!bpf_map_update_elem(lru_map_fd, &key, value,
 					    BPF_NOEXIST));
@@ -284,8 +290,8 @@ static void test_lru_sanity1(int map_type, int map_flags, unsigned int tgt_free)
 	 * => 1+tgt_free/2 to LOCALFREE_TARGET will be
 	 * removed by LRU
 	 */
-	key = 1 + tgt_free;
-	end_key = key + tgt_free;
+	key = 1 + __map_size(tgt_free);
+	end_key = key + __map_size(tgt_free);
 	for (; key < end_key; key++) {
 		assert(!bpf_map_update_elem(lru_map_fd, &key, value,
 					    BPF_NOEXIST));
@@ -334,7 +340,7 @@ static void test_lru_sanity2(int map_type, int map_flags, unsigned int tgt_free)
 	batch_size = tgt_free / 2;
 	assert(batch_size * 2 == tgt_free);
 
-	map_size = tgt_free + batch_size;
+	map_size = __map_size(tgt_free) + batch_size;
 	lru_map_fd = create_map(map_type, map_flags, map_size);
 	assert(lru_map_fd != -1);
 
@@ -344,7 +350,7 @@ static void test_lru_sanity2(int map_type, int map_flags, unsigned int tgt_free)
 	value[0] = 1234;
 
 	/* Insert 1 to tgt_free (+tgt_free keys) */
-	end_key = 1 + tgt_free;
+	end_key = 1 + __map_size(tgt_free);
 	for (key = 1; key < end_key; key++)
 		assert(!bpf_map_update_elem(lru_map_fd, &key, value,
 					    BPF_NOEXIST));
@@ -388,8 +394,9 @@ static void test_lru_sanity2(int map_type, int map_flags, unsigned int tgt_free)
 	value[0] = 1234;
 
 	/* Insert 1+tgt_free to tgt_free*3/2 */
-	end_key = 1 + tgt_free + batch_size;
-	for (key = 1 + tgt_free; key < end_key; key++)
+	key = 1 + __map_size(tgt_free);
+	end_key = key + batch_size;
+	for (; key < end_key; key++)
 		/* These newly added but not referenced keys will be
 		 * gone during the next LRU shrink.
 		 */
@@ -397,7 +404,7 @@ static void test_lru_sanity2(int map_type, int map_flags, unsigned int tgt_free)
 					    BPF_NOEXIST));
 
 	/* Insert 1+tgt_free*3/2 to  tgt_free*5/2 */
-	end_key = key + tgt_free;
+	end_key += __map_size(tgt_free);
 	for (; key < end_key; key++) {
 		assert(!bpf_map_update_elem(lru_map_fd, &key, value,
 					    BPF_NOEXIST));
@@ -500,7 +507,8 @@ static void test_lru_sanity4(int map_type, int map_flags, unsigned int tgt_free)
 		lru_map_fd = create_map(map_type, map_flags,
 					3 * tgt_free * nr_cpus);
 	else
-		lru_map_fd = create_map(map_type, map_flags, 3 * tgt_free);
+		lru_map_fd = create_map(map_type, map_flags,
+					3 * __map_size(tgt_free));
 	assert(lru_map_fd != -1);
 
 	expected_map_fd = create_map(BPF_MAP_TYPE_HASH, 0,
-- 
2.50.0.rc1.591.g9c95f17f64-goog


