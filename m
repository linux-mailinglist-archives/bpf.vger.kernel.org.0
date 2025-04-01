Return-Path: <bpf+bounces-55036-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777F5A7744E
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 08:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336723A872C
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 06:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FA71E22FC;
	Tue,  1 Apr 2025 06:11:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0F51DD0F2
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 06:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743487859; cv=none; b=q5P9iYegRcwQkuFPWkXT3bsCvnadvC0cNSKbwJYqeWwNnchBVYoDC4VhP6TzhbQ/CQCQngt5paMAYo1q6l4etOQVmp0QjP8JqAmHj1CqUhmcXwewvR7fRi5tCNTMVq/v3XAlTrw+nPeGUQ371h4O2kGGWiPy7b7bH0RL64IkVls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743487859; c=relaxed/simple;
	bh=crJsJwuLaBAyQ8onE0w6NkkHnmQVqvbCiO6rc/x/SLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nMNHBppU/JyCfdeP1WO2P+N36gFjoD7Y3KuMYa41prdPg/cKBfebDdu9dZFeeM5+QXsOi7FmEavAChnCOgGyAJH7UupoU8zD2IA2/ZHoBrQHbENzF6npZGoV5aTOq+AxJ/AWjUQmh0Jo24ot62+g6UxKbot6iqUw7P+gYfNJOFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZRd066wWGz4f3jkw
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 14:10:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B5BDF1A0D34
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 14:10:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl9ig+tnpa6yIA--.16784S7;
	Tue, 01 Apr 2025 14:10:48 +0800 (CST)
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
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
	Zvi Effron <zeffron@riotgames.com>,
	Cody Haas <chaas@riotgames.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next v3 3/6] bpf: Support atomic update for htab of maps
Date: Tue,  1 Apr 2025 14:22:47 +0800
Message-Id: <20250401062250.543403-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250401062250.543403-1-houtao@huaweicloud.com>
References: <20250401062250.543403-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXOl9ig+tnpa6yIA--.16784S7
X-Coremail-Antispam: 1UD129KBjvJXoWxtF4rXrWkXF45AF47tr1kZrb_yoW7Kr1xpF
	WFgF1xKw4kGa1Yqw4rJw4v9rW5Arn5G3yUCa4kKFyFyr15Wrn7Zr1xAas2yryrCF1kArsY
	qrZFqw1ayayrCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU04x
	RDUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

As reported by Cody Haas [1], when there is concurrent map lookup and
map update operation in an existing element for htab of maps, the map
lookup procedure may return -ENOENT unexpectedly.

The root cause is twofold:

1) the update of existing element involves two separated list operation
In htab_map_update_elem(), it first inserts the new element at the head
of list, then it deletes the old element. Therefore, it is possible a
lookup operation has already iterated to the middle of the list when a
concurrent update operation begins, and the lookup operation will fail
to find the target element.

2) the immediate reuse of htab element.
It is more subtle. Even through the lookup operation finds the old
element, it is possible that the target element has been removed by a
concurrent update operation, and the element has been reused immediately
by other update operation which runs on the same CPU as the previous
update operation, and the element is inserted into the same bucket list.
After these steps above, when the lookup operation tries to compare the
key in the old element with the expected key, the match will fail
because the key in the old element have been overwritten by other update
operation.

The two-step update process is relatively straightforward to address.
The more challenging aspect is the immediate reuse. As Alexei pointed
out:

 So since 2022 both prealloc and no_prealloc reuse elements.
 We can consider a new flag for the hash map like F_REUSE_AFTER_RCU_GP
 that will use _rcu() flavor of freeing into bpf_ma,
 but it has to have a strong reason.

Given that htab of maps doesn't support special field in value and
directly stores the inner map pointer in htab_element, just do in-place
update for htab of maps instead of attempting to address the immediate
reuse issue.

[1]: https://lore.kernel.org/xdp-newbies/CAH7f-ULFTwKdoH_t2SFc5rWCVYLEg-14d1fBYWH2eekudsnTRg@mail.gmail.com/

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 9778e9871d86..4879c79dd677 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1076,10 +1076,9 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 				 u64 map_flags)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
-	struct htab_elem *l_new = NULL, *l_old;
+	struct htab_elem *l_new, *l_old;
 	struct hlist_nulls_head *head;
 	unsigned long flags;
-	void *old_map_ptr;
 	struct bucket *b;
 	u32 key_size, hash;
 	int ret;
@@ -1160,24 +1159,14 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		hlist_nulls_del_rcu(&l_old->hash_node);
 
 		/* l_old has already been stashed in htab->extra_elems, free
-		 * its special fields before it is available for reuse. Also
-		 * save the old map pointer in htab of maps before unlock
-		 * and release it after unlock.
+		 * its special fields before it is available for reuse.
 		 */
-		old_map_ptr = NULL;
-		if (htab_is_prealloc(htab)) {
-			if (map->ops->map_fd_put_ptr)
-				old_map_ptr = fd_htab_map_get_ptr(map, l_old);
+		if (htab_is_prealloc(htab))
 			check_and_free_fields(htab, l_old);
-		}
 	}
 	htab_unlock_bucket(b, flags);
-	if (l_old) {
-		if (old_map_ptr)
-			map->ops->map_fd_put_ptr(map, old_map_ptr, true);
-		if (!htab_is_prealloc(htab))
-			free_htab_elem(htab, l_old);
-	}
+	if (l_old && !htab_is_prealloc(htab))
+		free_htab_elem(htab, l_old);
 	return 0;
 err:
 	htab_unlock_bucket(b, flags);
@@ -1265,6 +1254,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct htab_elem *l_new, *l_old;
 	struct hlist_nulls_head *head;
+	void *old_map_ptr = NULL;
 	unsigned long flags;
 	struct bucket *b;
 	u32 key_size, hash;
@@ -1296,8 +1286,15 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 
 	if (l_old) {
 		/* Update value in-place */
-		pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
-				value, onallcpus);
+		if (percpu) {
+			pcpu_copy_value(htab, htab_elem_get_ptr(l_old, key_size),
+					value, onallcpus);
+		} else {
+			void **inner_map_pptr = htab_elem_value(l_old, key_size);
+
+			old_map_ptr = *inner_map_pptr;
+			WRITE_ONCE(*inner_map_pptr, *(void **)value);
+		}
 	} else {
 		l_new = alloc_htab_elem(htab, key, value, key_size,
 					hash, percpu, onallcpus, NULL);
@@ -1309,6 +1306,8 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 	}
 err:
 	htab_unlock_bucket(b, flags);
+	if (old_map_ptr)
+		map->ops->map_fd_put_ptr(map, old_map_ptr, true);
 	return ret;
 }
 
@@ -2531,24 +2530,23 @@ int bpf_fd_htab_map_lookup_elem(struct bpf_map *map, void *key, u32 *value)
 	return ret;
 }
 
-/* only called from syscall */
+/* Only called from syscall */
 int bpf_fd_htab_map_update_elem(struct bpf_map *map, struct file *map_file,
 				void *key, void *value, u64 map_flags)
 {
 	void *ptr;
 	int ret;
-	u32 ufd = *(u32 *)value;
 
-	ptr = map->ops->map_fd_get_ptr(map, map_file, ufd);
+	ptr = map->ops->map_fd_get_ptr(map, map_file, *(int *)value);
 	if (IS_ERR(ptr))
 		return PTR_ERR(ptr);
 
 	/* The htab bucket lock is always held during update operations in fd
 	 * htab map, and the following rcu_read_lock() is only used to avoid
-	 * the WARN_ON_ONCE in htab_map_update_elem().
+	 * the WARN_ON_ONCE in htab_map_update_elem_in_place().
 	 */
 	rcu_read_lock();
-	ret = htab_map_update_elem(map, key, &ptr, map_flags);
+	ret = htab_map_update_elem_in_place(map, key, &ptr, map_flags, false, false);
 	rcu_read_unlock();
 	if (ret)
 		map->ops->map_fd_put_ptr(map, ptr, false);
-- 
2.29.2


