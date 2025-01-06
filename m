Return-Path: <bpf+bounces-47956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E08FA02894
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 15:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE771882DE8
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 14:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5769E137930;
	Mon,  6 Jan 2025 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naQMpyp8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD1A8633A
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736175240; cv=none; b=p5c96+Uw+nznpqh/VDt7BmdWfksG7FwGJqPNoWQ/2gmt0Jo171/7O+WBU0BCEBMufFsdjmU3CamqsyM5xL35RhGR0xdagXkbSIdNVaOpyhzdbgde4KnD+E/vLd202JNqUhyfLfOzzYd0G4Tst9j7d7w30TccF+g6qMson2L0zjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736175240; c=relaxed/simple;
	bh=PIZOsUgeNn4GFhc+HRjWRD/qEOLIPpUzY6a9KyU7klA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjCDqlD1GCgo3BXgMHeyOKK70c2sgOORynnWlHRbMk0cJBmEEVcdg8bL021DCcc/GcofNtoKqwwHis5C1+S5yDBfCHcL21UhMC9BC5qI8zUO0wC9+0hyuE366+et5eXg2VPrhVi75sBSV9LbHtrAgFYzvxKB3taBa8EBTnLmss8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naQMpyp8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-436341f575fso149748475e9.1
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 06:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736175237; x=1736780037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnTmnFNraHZZOJddJKqa2n5UrakfYRlTB6KX2RcLzQ8=;
        b=naQMpyp8B0SyL40wgRGhz4IhqkbMSBF+IH84lBQsbTvm8/vlyrFRlYSnxklMV3R7/1
         8Hzz0NhezwLtjtk1Nbh67OQiH8FIVQy9gGTsPo6rIFz8+S5odNWGQwecRvkSFb4Qya7j
         k0uTLB9gl+LdylKFEXshVcNIZqaG61ONpDX51Lt83zoTzaZBqZSwMLVy/tvpkpw/qW46
         EyA6OSfkLcQ1CZHQZlcioWqLSsnyCkWPV3zyzt/nEn3YNlFcSRjDt2j9yJZlp5E5mFHQ
         nO4mDXudzPUj3y+jgZDvxmcvRPX3zrgei7rQSgFzV8uFiBvw8OlHTBaEVsXabJtb4zIR
         TnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736175237; x=1736780037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnTmnFNraHZZOJddJKqa2n5UrakfYRlTB6KX2RcLzQ8=;
        b=BKtOgemGQhvpIaNW9eGZu/7pAkRjK/Dpe4+2b7dHpWMB+QpXH8f9S6yCz+s0Zq1Ubl
         p7nqrrUQmZytlAc0TOB5pdRJV7ldIVQxUddA5zd/LvWEv/3Iu1UFYCHYIPpNvu+g5RoL
         qbF5fDQNF3ae6AZqpN4sCVEE1ckiH+pdDw6VLIAA3nwGL6DGRmSjouC1YT8nDt9DSSt7
         IzTwR/kE0WhX3PF8SJWuVGArOUQTJknNA3D1ZKDf/mDyvJ7IljiHGr5dpYyY9LfXQASX
         stPuruP6TW29PW+loSwKH/VK712w1y2Hb+JL8Sv7aXLYzoDXiUbWz62htQy/SijdBFzj
         lVPw==
X-Gm-Message-State: AOJu0Yxjqf1h00e5Yd5tzh6g+lgcQKA+T5DEIS5sV6D4ISMK/DZ+xLRn
	M7VtsYjxUy1Es4samSRZDI8fF3r+GP0FkdcF3nelnDZLRvC7vY7ZWAFwP8VsJIgLRlf+
X-Gm-Gg: ASbGncunqve/xGJYpnSjGO+hXCVIh465U+CGu1RdxjjTnn+eJNxRMk23v+CergZTzqZ
	prqvnrwor1+qyKIYoWqsz5xYTUI5nel+HFTI7iZRnNFaph4CcqLs9C3XVz874RNKV0NwgrVPKGR
	WczswA8Xw+g9wF+82RtWj+MMBPrTzCr4OTCENL/b+WVACyQuC1ZxJiDstsxwRwHdxpBtxK1drme
	Rm2c5NOwhnODD6VxynSSEnK6EzFrWO8fVc9J4+RkFLcLqQKAmtwUDXTI9EdbqFamKuSXd1g57Y=
X-Google-Smtp-Source: AGHT+IEWWW9/CZ9N03T/6d0NkYMu8csqDWf4yolHS9uL30j+K1oeRzdMYDRWNLzTocd7U54KW68ftQ==
X-Received: by 2002:a05:600c:3505:b0:430:57e8:3c7e with SMTP id 5b1f17b1804b1-43668b5f39emr399209695e9.28.1736175236825;
        Mon, 06 Jan 2025 06:53:56 -0800 (PST)
Received: from babis.. ([2a02:3033:700:3ba2:3837:7343:334:7680])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832e74sm47389982f8f.30.2025.01.06.06.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 06:53:56 -0800 (PST)
From: Charalampos Stylianopoulos <charalampos.stylianopoulos@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nick Zavaritsky <mejedi@gmail.com>,
	Charalampos Stylianopoulos <charalampos.stylianopoulos@gmail.com>
Subject: [PATCH bpf-next 1/4] bpf: Add map_num_entries map op
Date: Mon,  6 Jan 2025 15:53:25 +0100
Message-ID: <20250106145328.399610-2-charalampos.stylianopoulos@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250106145328.399610-1-charalampos.stylianopoulos@gmail.com>
References: <20250106145328.399610-1-charalampos.stylianopoulos@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch extends map operations with map_num_entries that returns the number of
entries currently present in the map. Provides implementation of the ops
for maps that track the number of elements added in them.

Co-developed-by: Nick Zavaritsky <mejedi@gmail.com>
Signed-off-by: Nick Zavaritsky <mejedi@gmail.com>
Signed-off-by: Charalampos Stylianopoulos <charalampos.stylianopoulos@gmail.com>
---
 include/linux/bpf.h               |  3 +++
 include/linux/bpf_local_storage.h |  1 +
 kernel/bpf/devmap.c               | 14 ++++++++++++++
 kernel/bpf/hashtab.c              | 10 ++++++++++
 kernel/bpf/lpm_trie.c             |  8 ++++++++
 kernel/bpf/queue_stack_maps.c     | 11 ++++++++++-
 6 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index feda0ce90f5a..217260a8f5f4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -175,6 +175,7 @@ struct bpf_map_ops {
 				     void *callback_ctx, u64 flags);
 
 	u64 (*map_mem_usage)(const struct bpf_map *map);
+	s64 (*map_num_entries)(const struct bpf_map *map);
 
 	/* BTF id of struct allocated by map_alloc */
 	int *map_btf_id;
@@ -2402,6 +2403,8 @@ static inline void bpf_map_dec_elem_count(struct bpf_map *map)
 	this_cpu_dec(*map->elem_count);
 }
 
+s64 bpf_map_sum_elem_count(const struct bpf_map *map);
+
 extern int sysctl_unprivileged_bpf_disabled;
 
 bool bpf_token_capable(const struct bpf_token *token, int cap);
diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index ab7244d8108f..3a9e69e44c1d 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -204,5 +204,6 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 			 void *value, u64 map_flags, bool swap_uptrs, gfp_t gfp_flags);
 
 u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map);
+s64 bpf_local_storage_map_num_entries(const struct bpf_map *map);
 
 #endif /* _BPF_LOCAL_STORAGE_H */
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 3aa002a47a96..f43a58389f8f 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -1041,6 +1041,18 @@ static u64 dev_map_mem_usage(const struct bpf_map *map)
 	return usage;
 }
 
+static s64 dev_map_num_entries(const struct bpf_map *map)
+{
+	struct bpf_dtab *dtab = container_of(map, struct bpf_dtab, map);
+	s64 entries = 0;
+
+	if (map->map_type == BPF_MAP_TYPE_DEVMAP_HASH)
+		entries = atomic_read((atomic_t *)&dtab->items);
+	else
+		entries = -EOPNOTSUPP;
+	return entries;
+}
+
 BTF_ID_LIST_SINGLE(dev_map_btf_ids, struct, bpf_dtab)
 const struct bpf_map_ops dev_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
@@ -1053,6 +1065,7 @@ const struct bpf_map_ops dev_map_ops = {
 	.map_delete_elem = dev_map_delete_elem,
 	.map_check_btf = map_check_no_btf,
 	.map_mem_usage = dev_map_mem_usage,
+	.map_num_entries = dev_map_num_entries,
 	.map_btf_id = &dev_map_btf_ids[0],
 	.map_redirect = dev_map_redirect,
 };
@@ -1068,6 +1081,7 @@ const struct bpf_map_ops dev_map_hash_ops = {
 	.map_delete_elem = dev_map_hash_delete_elem,
 	.map_check_btf = map_check_no_btf,
 	.map_mem_usage = dev_map_mem_usage,
+	.map_num_entries = dev_map_num_entries,
 	.map_btf_id = &dev_map_btf_ids[0],
 	.map_redirect = dev_hash_map_redirect,
 };
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 3ec941a0ea41..769a4c33c81f 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2287,6 +2287,11 @@ static u64 htab_map_mem_usage(const struct bpf_map *map)
 	return usage;
 }
 
+static s64 htab_map_num_entries(const struct bpf_map *map)
+{
+	return bpf_map_sum_elem_count(map);
+}
+
 BTF_ID_LIST_SINGLE(htab_map_btf_ids, struct, bpf_htab)
 const struct bpf_map_ops htab_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
@@ -2304,6 +2309,7 @@ const struct bpf_map_ops htab_map_ops = {
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
 	.map_mem_usage = htab_map_mem_usage,
+	.map_num_entries = htab_map_num_entries,
 	BATCH_OPS(htab),
 	.map_btf_id = &htab_map_btf_ids[0],
 	.iter_seq_info = &iter_seq_info,
@@ -2326,6 +2332,7 @@ const struct bpf_map_ops htab_lru_map_ops = {
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
 	.map_mem_usage = htab_map_mem_usage,
+	.map_num_entries = htab_map_num_entries,
 	BATCH_OPS(htab_lru),
 	.map_btf_id = &htab_map_btf_ids[0],
 	.iter_seq_info = &iter_seq_info,
@@ -2499,6 +2506,7 @@ const struct bpf_map_ops htab_percpu_map_ops = {
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
 	.map_mem_usage = htab_map_mem_usage,
+	.map_num_entries = htab_map_num_entries,
 	BATCH_OPS(htab_percpu),
 	.map_btf_id = &htab_map_btf_ids[0],
 	.iter_seq_info = &iter_seq_info,
@@ -2519,6 +2527,7 @@ const struct bpf_map_ops htab_lru_percpu_map_ops = {
 	.map_set_for_each_callback_args = map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_hash_elem,
 	.map_mem_usage = htab_map_mem_usage,
+	.map_num_entries = htab_map_num_entries,
 	BATCH_OPS(htab_lru_percpu),
 	.map_btf_id = &htab_map_btf_ids[0],
 	.iter_seq_info = &iter_seq_info,
@@ -2663,6 +2672,7 @@ const struct bpf_map_ops htab_of_maps_map_ops = {
 	.map_gen_lookup = htab_of_map_gen_lookup,
 	.map_check_btf = map_check_no_btf,
 	.map_mem_usage = htab_map_mem_usage,
+	.map_num_entries = htab_map_num_entries,
 	BATCH_OPS(htab),
 	.map_btf_id = &htab_map_btf_ids[0],
 };
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index f8bc1e096182..5297eb2e8e97 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -780,6 +780,13 @@ static u64 trie_mem_usage(const struct bpf_map *map)
 	return elem_size * READ_ONCE(trie->n_entries);
 }
 
+static s64 trie_num_entries(const struct bpf_map *map)
+{
+	struct lpm_trie *trie = container_of(map, struct lpm_trie, map);
+
+	return READ_ONCE(trie->n_entries);
+}
+
 BTF_ID_LIST_SINGLE(trie_map_btf_ids, struct, lpm_trie)
 const struct bpf_map_ops trie_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
@@ -794,5 +801,6 @@ const struct bpf_map_ops trie_map_ops = {
 	.map_delete_batch = generic_map_delete_batch,
 	.map_check_btf = trie_check_btf,
 	.map_mem_usage = trie_mem_usage,
+	.map_num_entries = trie_num_entries,
 	.map_btf_id = &trie_map_btf_ids[0],
 };
diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index d869f51ea93a..f66aa31248e7 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -22,7 +22,7 @@ struct bpf_queue_stack {
 	char elements[] __aligned(8);
 };
 
-static struct bpf_queue_stack *bpf_queue_stack(struct bpf_map *map)
+static struct bpf_queue_stack *bpf_queue_stack(const struct bpf_map *map)
 {
 	return container_of(map, struct bpf_queue_stack, map);
 }
@@ -265,6 +265,13 @@ static u64 queue_stack_map_mem_usage(const struct bpf_map *map)
 	return usage;
 }
 
+static s64 queue_stack_map_num_entries(const struct bpf_map *map)
+{
+	struct bpf_queue_stack *qs = bpf_queue_stack(map);
+	s64 entries = qs->head - qs->tail;
+	return entries;
+}
+
 BTF_ID_LIST_SINGLE(queue_map_btf_ids, struct, bpf_queue_stack)
 const struct bpf_map_ops queue_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
@@ -279,6 +286,7 @@ const struct bpf_map_ops queue_map_ops = {
 	.map_peek_elem = queue_map_peek_elem,
 	.map_get_next_key = queue_stack_map_get_next_key,
 	.map_mem_usage = queue_stack_map_mem_usage,
+	.map_num_entries = queue_stack_map_num_entries,
 	.map_btf_id = &queue_map_btf_ids[0],
 };
 
@@ -295,5 +303,6 @@ const struct bpf_map_ops stack_map_ops = {
 	.map_peek_elem = stack_map_peek_elem,
 	.map_get_next_key = queue_stack_map_get_next_key,
 	.map_mem_usage = queue_stack_map_mem_usage,
+	.map_num_entries = queue_stack_map_num_entries,
 	.map_btf_id = &queue_map_btf_ids[0],
 };
-- 
2.43.0


