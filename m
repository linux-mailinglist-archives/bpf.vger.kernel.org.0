Return-Path: <bpf+bounces-49797-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933ECA1C2D9
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 11:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6897167B5E
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 10:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BFD20897A;
	Sat, 25 Jan 2025 10:59:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594D31DC19D
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737802758; cv=none; b=cUK2yS6Rsac15Lpsyy6Z50G+EdrQK11tuMbk8DxrotFp7a8XT8K1XdMuC96hUH8KBfgjyChNQpY7Ud8YdpGq5uCg6LqMbleN+9hiKdqWJEBc/r/5EW230g+uOiE8zINIqTm/2PDZjeOzzvUUDejZC9WJXXNLRpBZX7kfnV/wLnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737802758; c=relaxed/simple;
	bh=jBplyqZdnFCgADA3WUMNE6quuYaRCA+wfWU2lJCY9D4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XSIJ9p/cjOyROqT0+SZsf2HRJAlxbi8nslSeHhTNXOlBf9GfrzyvZf8Jfza/7H+ZR5fgxJsLmxWUN8TvHD/m3NM8tYMe5WMFqKJVnY65FIVcZDbYNr9dW85IUPvqckXHe2rKvFe4frQo2JlpgG36gY3PWGLu35/+hjMSLqSfV2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YgBWH3qYHz4f3jXn
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:58:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 45E251A06E6
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:59:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBXul7zw5Rn79XHBw--.24605S19;
	Sat, 25 Jan 2025 18:59:12 +0800 (CST)
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
	Dan Carpenter <dan.carpenter@linaro.org>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next v2 15/20] bpf: Support get_next_key operation for dynptr key in hash map
Date: Sat, 25 Jan 2025 19:11:04 +0800
Message-Id: <20250125111109.732718-16-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250125111109.732718-1-houtao@huaweicloud.com>
References: <20250125111109.732718-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXul7zw5Rn79XHBw--.24605S19
X-Coremail-Antispam: 1UD129KBjvJXoWxXF1UXryxGFWfCw48WrW8tFb_yoWrKF47pF
	18G397Xr40kF4qqF45Wan2vw4ayr1Igw10kFykKas7GFnrWr97Zw18tFW0kryYyFZrJr4r
	tr4jqa4Y9ws5JrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF
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
 kernel/bpf/hashtab.c | 55 ++++++++++++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index f3ec2b32b59b8..74962a461d091 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -970,7 +970,8 @@ static bool htab_lru_map_delete_node(void *arg, struct bpf_lru_node *node)
 	return l == tgt_l;
 }
 
-static int htab_copy_dynptr_key(struct bpf_htab *htab, void *dst_key, const void *key, u32 key_size)
+static int htab_copy_dynptr_key(struct bpf_htab *htab, void *dst_key, const void *key, u32 key_size,
+				bool copy_in)
 {
 	const struct btf_record *rec = htab->map.key_record;
 	struct bpf_dynptr_kern *dst_kptr;
@@ -995,22 +996,32 @@ static int htab_copy_dynptr_key(struct bpf_htab *htab, void *dst_key, const void
 
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
@@ -1021,7 +1032,7 @@ static int htab_copy_dynptr_key(struct bpf_htab *htab, void *dst_key, const void
 	return 0;
 
 out:
-	for (; i > 0; i--) {
+	for (; i > 0 && copy_in; i--) {
 		field = &rec->fields[i - 1];
 		if (field->type != BPF_DYNPTR)
 			continue;
@@ -1032,10 +1043,22 @@ static int htab_copy_dynptr_key(struct bpf_htab *htab, void *dst_key, const void
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
@@ -1048,12 +1071,12 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
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
@@ -1064,8 +1087,7 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
 	if (next_l) {
 		/* if next elem in this hash list is non-zero, just return it */
-		memcpy(next_key, next_l->key, key_size);
-		return 0;
+		return htab_copy_next_key(htab, next_key, next_l->key, key_size);
 	}
 
 	/* no more elements in this hash list, go to the next bucket */
@@ -1082,8 +1104,7 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
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
2.29.2


