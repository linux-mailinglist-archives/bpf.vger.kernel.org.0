Return-Path: <bpf+bounces-41212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A870A994396
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC36F1C25652
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E521DEFE6;
	Tue,  8 Oct 2024 09:02:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779A617C213
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378157; cv=none; b=SRjmjqv0owUo8+oXWlRRdQwI9oEPSODDrG7OC71M3NAgE3flUs3/BVHoDI9Sx+84paOJmX9DtkZvLwNB4E/PjtF4gV+F37H0mQMiQApI4B3+TrDNSJ7RtGBDQ9T61QbhZXTb52ZbxftCJCPqka1zWu3/i993SUmFtXrVO6RZg/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378157; c=relaxed/simple;
	bh=IlRpadb3exyj92NARXH//zVRrVCI6frw+VScuWwIuLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gp0gpvYYGAK3LWC1YPe9yWx+b3/RcSaVKe+MWIRkmE1MPe9JtGsiX0MBwzekPgcmi8zyL04UpuLtDgHcNqhfSFBi1sboCRw8nNewBa08i6L8XMobn2dLX5nEDzmKa2fXROvtwxefDQWZyQyUVjgriqB7PEuUB53paQgGWIPUzpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XN9526YZ2z4f3lWJ
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:02:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7497D1A092F
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:02:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.60])
	by APP4 (Coremail) with SMTP id gCh0CgDH+sYd9QRnbOEHDg--.25681S18;
	Tue, 08 Oct 2024 17:02:32 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
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
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next 14/16] bpf: Support get_next_key operation for dynptr key in hash map
Date: Tue,  8 Oct 2024 17:14:59 +0800
Message-ID: <20241008091501.8302-15-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241008091501.8302-1-houtao@huaweicloud.com>
References: <20241008091501.8302-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+sYd9QRnbOEHDg--.25681S18
X-Coremail-Antispam: 1UD129KBjvJXoWxXF1UXryxGFWfCw4UKw1Dtrb_yoWrKF45pF
	18Ga97Xr40kF4qqF45Wan2vw4akr1Igw18CFykGas7GFnrWr97Zw18tFW0kryYyFZrJr4r
	tr4jq34Y9ws5JrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07Udl1kUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

It firstly passed the key_record to htab_map_hash() and
lookup_nulls_eleme_raw() to find the target key, then it uses
htab_copy_dynptr_key() helper to copy from the target key to the next
key used for output.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 55 ++++++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index edf19d36a413..b647fe9f8f9f 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -969,7 +969,8 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 	return l == tgt_l;
 }
 
-static int htab_copy_dynptr_key(struct bpf_htab *htab, void *dst_key, const void *key, u32 key_size)
+static int htab_copy_dynptr_key(struct bpf_htab *htab, void *dst_key, const void *key, u32 key_size,
+				bool copy_in)
 {
 	const struct btf_record *rec = htab->map.key_record;
 	struct bpf_dynptr_kern *dst_kptr;
@@ -994,22 +995,32 @@ static int htab_copy_dynptr_key(struct bpf_htab *htab, void *dst_key, const void
 
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
@@ -1020,7 +1031,7 @@ static int htab_copy_dynptr_key(struct bpf_htab *htab, void *dst_key, const void
 	return 0;
 
 out:
-	for (; i > 0; i--) {
+	for (; i > 0 && copy_in; i--) {
 		field = &rec->fields[i - 1];
 		if (field->type != BPF_DYNPTR)
 			continue;
@@ -1031,10 +1042,22 @@ static int htab_copy_dynptr_key(struct bpf_htab *htab, void *dst_key, const void
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
@@ -1047,12 +1070,12 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 	if (!key)
 		goto find_first_elem;
 
-	hash = htab_map_hash(key, key_size, htab->hashrnd, NULL);
+	hash = htab_map_hash(key, key_size, htab->hashrnd, key_record);
 
 	head = select_bucket(htab, hash);
 
 	/* lookup the key */
-	l = lookup_nulls_elem_raw(head, hash, key, key_size, htab->n_buckets, NULL);
+	l = lookup_nulls_elem_raw(head, hash, key, key_size, htab->n_buckets, key_record);
 
 	if (!l)
 		goto find_first_elem;
@@ -1063,8 +1086,7 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
 	if (next_l) {
 		/* if next elem in this hash list is non-zero, just return it */
-		memcpy(next_key, next_l->key, key_size);
-		return 0;
+		return htab_copy_next_key(htab, next_key, next_l->key, key_size);
 	}
 
 	/* no more elements in this hash list, go to the next bucket */
@@ -1081,8 +1103,7 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 					  struct htab_elem, hash_node);
 		if (next_l) {
 			/* if it's not empty, just return it */
-			memcpy(next_key, next_l->key, key_size);
-			return 0;
+			return htab_copy_next_key(htab, next_key, next_l->key, key_size);
 		}
 	}
 
@@ -1263,7 +1284,7 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 	if (bpf_map_has_dynptr_key(&htab->map)) {
 		int copy_err;
 
-		copy_err = htab_copy_dynptr_key(htab, l_new->key, key, key_size);
+		copy_err = htab_copy_dynptr_key(htab, l_new->key, key, key_size, true);
 		if (copy_err) {
 			bpf_mem_cache_free(&htab->ma, l_new);
 			l_new = ERR_PTR(copy_err);
-- 
2.44.0


