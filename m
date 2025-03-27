Return-Path: <bpf+bounces-54799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFA9A72B5E
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 09:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F96D1898E15
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 08:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D01205ABF;
	Thu, 27 Mar 2025 08:23:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59AD204F83
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743063787; cv=none; b=rbPEzTiEaN02CS/GPH3vPIQ7LmJZTumR2L1NP6IXnBFgdvwUkAeeoq+EKarvf7lKtq0WWJBxIAab47uqKMt5LupvG08SAj3dKuesZbFJAyEuss+gJSKtDGv1Wjaf9grU2pPItkr2XYfgOUZdGKrGDXYktJcXPju5qVdq+Y2wftA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743063787; c=relaxed/simple;
	bh=QJJDTnwYgISQUbuzvnXJLr4lJHAYz6U+kC/Yj9Hi6E8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VA/zdYJSstsdrJKjPJDhlm4w/HjA9zd20Ym2Q7wC1R8fJE3iLwlijTrUcVn838NLZ9KQCAqC1Lw/r1SIYNIu2yxxzAON2p0n2fjg5NqT6F/AIh+a6oc5LAhw2RYinalsXW5uZ+dY8k5QzexQnYqYnlF2WhleLyL8FfRDihDv4HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ZNc8p3Bz9z4f3jXm
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6877B1A0EC9
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 16:22:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAXe1_XCuVnluzSHg--.7420S15;
	Thu, 27 Mar 2025 16:22:57 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next v3 11/16] bpf: Support get_next_key operation for dynptr key in hash map
Date: Thu, 27 Mar 2025 16:34:50 +0800
Message-Id: <20250327083455.848708-12-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250327083455.848708-1-houtao@huaweicloud.com>
References: <20250327083455.848708-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXe1_XCuVnluzSHg--.7420S15
X-Coremail-Antispam: 1UD129KBjvJXoWxXF1UXryxGw4DJr4kXFW8Zwb_yoWrKF1fpF
	18Ga97Xw40kF4DtF45Wan2vw43Kr1Igw109FykGas7KFnFgr97Zw18tFW0kryYyFZrJr4f
	tr4jqa45uws5JrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUF9NVUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

It firstly passed the key_record to htab_map_hash() and
lookup_nulls_eleme_raw() to find the target key, then it uses
htab_copy_dynptr_key() helper to copy from the target key to the next
key used for output.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 56 ++++++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 028542c2b4237..2c3017086e4ab 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -923,7 +923,8 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 	return l == tgt_l;
 }
 
-static int htab_copy_dynptr_key(struct bpf_htab *htab, void *dst_key, const void *key, u32 key_size)
+static int htab_copy_dynptr_key(struct bpf_htab *htab, void *dst_key, const void *key, u32 key_size,
+				bool copy_in)
 {
 	const struct btf_record *rec = htab->map.key_record;
 	struct bpf_dynptr_kern *dst_kptr;
@@ -948,22 +949,32 @@ static int htab_copy_dynptr_key(struct bpf_htab *htab, void *dst_key, const void
 
 		/* Doesn't support nullified dynptr in map key */
 		kptr = key + field->offset;
-		if (!kptr->data) {
+		if (copy_in && !kptr->data) {
 			err = -EINVAL;
 			goto out;
 		}
 		len = __bpf_dynptr_size(kptr);
 		data = __bpf_dynptr_data(kptr, len);
 
-		dst_data = bpf_mem_alloc(&htab->dynptr_ma, len);
-		if (!dst_data) {
-			err = -ENOMEM;
-			goto out;
-		}
+		dst_kptr = dst_key + field->offset;
+		if (copy_in) {
+			dst_data = bpf_mem_alloc(&htab->dynptr_ma, len);
+			if (!dst_data) {
+				err = -ENOMEM;
+				goto out;
+			}
+			bpf_dynptr_init(dst_kptr, dst_data, BPF_DYNPTR_TYPE_LOCAL, 0, len);
+		} else {
+			dst_data = __bpf_dynptr_data_rw(dst_kptr, len);
+			if (!dst_data) {
+				err = -ENOSPC;
+				goto out;
+			}
 
+			if (__bpf_dynptr_size(dst_kptr) > len)
+				bpf_dynptr_set_size(dst_kptr, len);
+		}
 		memcpy(dst_data, data, len);
-		dst_kptr = dst_key + field->offset;
-		bpf_dynptr_init(dst_kptr, dst_data, BPF_DYNPTR_TYPE_LOCAL, 0, len);
 
 		offset = field->offset + field->size;
 	}
@@ -974,7 +985,7 @@ static int htab_copy_dynptr_key(struct bpf_htab *htab, void *dst_key, const void
 	return 0;
 
 out:
-	while (i-- > 0) {
+	while (copy_in && i-- > 0) {
 		field = &rec->fields[i];
 		if (field->type != BPF_DYNPTR)
 			continue;
@@ -985,10 +996,22 @@ static int htab_copy_dynptr_key(struct bpf_htab *htab, void *dst_key, const void
 	return err;
 }
 
+static inline int htab_copy_next_key(struct bpf_htab *htab, void *next_key, const void *key,
+				     u32 key_size)
+{
+	if (!bpf_map_has_dynptr_key(&htab->map)) {
+		memcpy(next_key, key, key_size);
+		return 0;
+	}
+
+	return htab_copy_dynptr_key(htab, next_key, key, key_size, false);
+}
+
 /* Called from syscall */
 static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
+	const struct btf_record *key_record = map->key_record;
 	struct hlist_nulls_head *head;
 	struct htab_elem *l, *next_l;
 	u32 hash, key_size;
@@ -1001,13 +1024,12 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 	if (!key)
 		goto find_first_elem;
 
-	hash = htab_map_hash(key, key_size, htab->hashrnd, NULL);
+	hash = htab_map_hash(key, key_size, htab->hashrnd, key_record);
 
 	head = select_bucket(htab, hash);
 
 	/* lookup the key */
-	l = lookup_nulls_elem_raw(head, hash, key, key_size, htab->n_buckets, NULL);
-
+	l = lookup_nulls_elem_raw(head, hash, key, key_size, htab->n_buckets, key_record);
 	if (!l)
 		goto find_first_elem;
 
@@ -1017,8 +1039,7 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
 	if (next_l) {
 		/* if next elem in this hash list is non-zero, just return it */
-		memcpy(next_key, next_l->key, key_size);
-		return 0;
+		return htab_copy_next_key(htab, next_key, next_l->key, key_size);
 	}
 
 	/* no more elements in this hash list, go to the next bucket */
@@ -1035,8 +1056,7 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 					  struct htab_elem, hash_node);
 		if (next_l) {
 			/* if it's not empty, just return it */
-			memcpy(next_key, next_l->key, key_size);
-			return 0;
+			return htab_copy_next_key(htab, next_key, next_l->key, key_size);
 		}
 	}
 
@@ -1216,7 +1236,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 	if (bpf_map_has_dynptr_key(&htab->map)) {
 		int copy_err;
 
-		copy_err = htab_copy_dynptr_key(htab, l_new->key, key, key_size);
+		copy_err = htab_copy_dynptr_key(htab, l_new->key, key, key_size, true);
 		if (copy_err) {
 			bpf_mem_cache_free(&htab->ma, l_new);
 			l_new = ERR_PTR(copy_err);
-- 
2.29.2


