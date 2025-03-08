Return-Path: <bpf+bounces-53647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86277A57A8E
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 14:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32CC61895572
	for <lists+bpf@lfdr.de>; Sat,  8 Mar 2025 13:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFB31D4335;
	Sat,  8 Mar 2025 13:39:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19461C9B9B
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441158; cv=none; b=GB06h09in70f3DWUz+8rzfO2hXymG7Y5e7ntICbA0okX+I6RhTq6nztTON8DBzdY1xHjrAv6X74a0rLPjQC7L5uDM8x9JM8+cFunMNkKjPNIFbKgyvoeW5yydxkJNmxhjPKmze37oT/f8QiTWizSu30ck/4CtmKeAmf8Mf/ay2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441158; c=relaxed/simple;
	bh=a98xMV/ZB1yQRAA1OHvtNF1FinyEhVNB/GQE+cp5NMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=djSE4NfBMTC6hfrsmeGAvZW74HzD8/4iWYOR2BcKoqo5dmb9/BYVB+kpt+/0NSt0jr9NgZkBwVNrOKjERp5hFrAO/Aop8oavUFbCJoGtRZ2xaLRiqMMuGa+zu4eu0RksLqNrlUNWUl0k1ZNeAs0eS7X3m80ha1D9PpVI++/jWq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Z944P2GQPz4f3jdB
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 21:38:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8A66B1A160D
	for <bpf@vger.kernel.org>; Sat,  8 Mar 2025 21:39:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDnSl91SMxn+YeeFw--.42876S7;
	Sat, 08 Mar 2025 21:39:07 +0800 (CST)
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
Subject: [PATCH bpf-next v2 3/6] bpf: Support atomic update for htab of maps
Date: Sat,  8 Mar 2025 21:51:07 +0800
Message-Id: <20250308135110.953269-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250308135110.953269-1-houtao@huaweicloud.com>
References: <20250308135110.953269-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnSl91SMxn+YeeFw--.42876S7
X-Coremail-Antispam: 1UD129KBjvJXoWxtF4rXrWkXF45AF47tr1kZrb_yoW7tw4xpF
	WFgF1xKw4kGa1Ygw4rJw409rW5Arn5G3yUCa4kKFyFyr1UWrn2vr1xAas2kryrCr1kArsY
	qrZFqw1ayay8CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
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

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 8d78a518cf820..909639fe4df25 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1107,10 +1107,9 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
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
@@ -1191,24 +1190,14 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
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
 	htab_unlock_bucket(htab, b, hash, flags);
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
 	htab_unlock_bucket(htab, b, hash, flags);
@@ -1296,6 +1285,7 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
 	struct htab_elem *l_new, *l_old;
 	struct hlist_nulls_head *head;
+	void *old_map_ptr = NULL;
 	unsigned long flags;
 	struct bucket *b;
 	u32 key_size, hash;
@@ -1327,8 +1317,15 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 
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
@@ -1340,6 +1337,8 @@ static long htab_map_update_elem_in_place(struct bpf_map *map, void *key,
 	}
 err:
 	htab_unlock_bucket(htab, b, hash, flags);
+	if (old_map_ptr)
+		map->ops->map_fd_put_ptr(map, old_map_ptr, true);
 	return ret;
 }
 
@@ -2566,24 +2565,23 @@ int bpf_fd_htab_map_lookup_elem(struct bpf_map *map, void *key, u32 *value)
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


