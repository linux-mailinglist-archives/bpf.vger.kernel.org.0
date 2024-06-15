Return-Path: <bpf+bounces-32218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B40909798
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 12:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA4131C20BE9
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 10:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376B12E3E5;
	Sat, 15 Jun 2024 10:12:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx.der-flo.net (mx.der-flo.net [193.160.39.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A32F4C89
	for <bpf@vger.kernel.org>; Sat, 15 Jun 2024 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.160.39.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718446354; cv=none; b=tDNJLeejiMueWDL58K5I6S2cQokHls4FgUtT+Z1pTjqVg8snlxN776oOb4lccLybAO3gNa6W4xhhYCSJ+5TXHAacYBOWWWC2c6E5R+Q+zSLn0okEJSyesBhbxyT0SttiGekjmyKWnRdKLafBlH8IrbEi8zbhSw0JDc9/PZwVPSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718446354; c=relaxed/simple;
	bh=ElXLqOFhbUfaNp8GfgQBFmM7CN9vgayE9zHUyUqbkNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QmBXBUZdV3tYfFQVBLjvHJQrZUXO/BYKvdkRq3hMW9YQsbbkHpgJS1z3v7Ykpk9F4l4gN9a495I1FO1TyS8J04O8zGAXAW99Vjjs7aNupDt+rqbrBEe3Y4ZBX8uOvLW3HFaB4iFxyGQzTEE/LRkt/fVjwkB9S4T/Q2eLT6Jl3Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net; spf=pass smtp.mailfrom=der-flo.net; arc=none smtp.client-ip=193.160.39.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=der-flo.net
From: Florian Lehner <dev@der-flo.net>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	Florian Lehner <dev@der-flo.net>
Subject: [PATCH] bpf, devmap: Add .map_alloc_check
Date: Sat, 15 Jun 2024 12:11:58 +0200
Message-ID: <20240615101158.57889-1-dev@der-flo.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the .map_allock_check callback to perform allocation checks before
allocating memory for the devmap.

Signed-off-by: Florian Lehner <dev@der-flo.net>
---
 kernel/bpf/devmap.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 7f3b34452243..9ec346dbf078 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -107,7 +107,7 @@ static inline struct hlist_head *dev_map_index_hash(struct bpf_dtab *dtab,
 	return &dtab->dev_index_head[idx & (dtab->n_buckets - 1)];
 }
 
-static int dev_map_init_map(struct bpf_dtab *dtab, union bpf_attr *attr)
+static int dev_map_alloc_check(union bpf_attr *attr)
 {
 	u32 valsize = attr->value_size;
 
@@ -121,21 +121,29 @@ static int dev_map_init_map(struct bpf_dtab *dtab, union bpf_attr *attr)
 	    attr->map_flags & ~DEV_CREATE_FLAG_MASK)
 		return -EINVAL;
 
+	if (attr->map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
+		/* hash table size must be power of 2; roundup_pow_of_two() can
+		 * overflow into UB on 32-bit arches, so check that
+		 */
+		if (attr->max_entries > 1UL << 31)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int dev_map_init_map(struct bpf_dtab *dtab, union bpf_attr *attr)
+{
 	/* Lookup returns a pointer straight to dev->ifindex, so make sure the
 	 * verifier prevents writes from the BPF side
 	 */
 	attr->map_flags |= BPF_F_RDONLY_PROG;
 
-
 	bpf_map_init_from_attr(&dtab->map, attr);
 
 	if (attr->map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
-		/* hash table size must be power of 2; roundup_pow_of_two() can
-		 * overflow into UB on 32-bit arches, so check that first
+		/* hash table size must be power of 2
 		 */
-		if (dtab->map.max_entries > 1UL << 31)
-			return -EINVAL;
-
 		dtab->n_buckets = roundup_pow_of_two(dtab->map.max_entries);
 
 		dtab->dev_index_head = dev_map_create_hash(dtab->n_buckets,
@@ -1040,6 +1048,7 @@ static u64 dev_map_mem_usage(const struct bpf_map *map)
 BTF_ID_LIST_SINGLE(dev_map_btf_ids, struct, bpf_dtab)
 const struct bpf_map_ops dev_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
+	.map_alloc_check = dev_map_alloc_check,
 	.map_alloc = dev_map_alloc,
 	.map_free = dev_map_free,
 	.map_get_next_key = dev_map_get_next_key,
@@ -1054,6 +1063,7 @@ const struct bpf_map_ops dev_map_ops = {
 
 const struct bpf_map_ops dev_map_hash_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
+	.map_alloc_check = dev_map_alloc_check,
 	.map_alloc = dev_map_alloc,
 	.map_free = dev_map_free,
 	.map_get_next_key = dev_map_hash_get_next_key,
-- 
2.45.2


