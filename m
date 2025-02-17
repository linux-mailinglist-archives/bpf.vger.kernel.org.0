Return-Path: <bpf+bounces-51707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6A1A3798B
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 02:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FDC53AF78E
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 01:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A17149C50;
	Mon, 17 Feb 2025 01:53:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8F813B293
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 01:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739757208; cv=none; b=tZBTS5o1dmZWuzhs47qYoD7rBF/2VkpSPEXyKDiNw3I7rKCywH8xda/XVaEklljPRwEs+htTRSh1NhZA7Vve0gJJ49sVAZBhtf2B6TCZA/fw9/wgmKmcGZb8lyWaDXZYWYURpZlo0IxC9WQGwnOET04Vu8QDjrzn79sE3uFGCMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739757208; c=relaxed/simple;
	bh=bgrxAgD4FAv8davl9VSPrFONST1pdyk5vXsqlhSmA8U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GgWwesMJfjEhW6WOzAgdNup3vidwpkQR2nwJacZxG+M5lh5+/ZhfxfgTgUV2+oaWFL7COo/vcIwqwhqb3ktv9zQezGhX671M7D2qWJ8OUfzkrnvXifhHgr7TlZ8GjDoxJnkFp/mYyuyER7X0KTjLQc9PFTM+rYUQZRhtWiTfPxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Yx5Fm22THzRs9J;
	Mon, 17 Feb 2025 09:50:20 +0800 (CST)
Received: from kwepemh200013.china.huawei.com (unknown [7.202.181.122])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C1A51401E9;
	Mon, 17 Feb 2025 09:53:18 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.175.36) by
 kwepemh200013.china.huawei.com (7.202.181.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Feb 2025 09:53:17 +0800
From: Xiaomeng Zhang <zhangxiaomeng13@huawei.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH -next 5/5] bpf: Remove map_get_next_key callbacks with -EOPNOTSUPP
Date: Mon, 17 Feb 2025 01:41:22 +0000
Message-ID: <20250217014122.65645-6-zhangxiaomeng13@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250217014122.65645-1-zhangxiaomeng13@huawei.com>
References: <20250217014122.65645-1-zhangxiaomeng13@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh200013.china.huawei.com (7.202.181.122)

Remove redundant map_get_next_key callbacks with return -EOPNOTSUPP. We can
directly return -EOPNOTSUPP when calling the unimplemented callbacks.

Signed-off-by: Xiaomeng Zhang <zhangxiaomeng13@huawei.com>
---
 kernel/bpf/arena.c             |  6 ------
 kernel/bpf/bloom_filter.c      |  6 ------
 kernel/bpf/bpf_cgrp_storage.c  |  6 ------
 kernel/bpf/bpf_inode_storage.c |  7 -------
 kernel/bpf/bpf_task_storage.c  |  6 ------
 kernel/bpf/ringbuf.c           |  8 --------
 kernel/bpf/syscall.c           | 10 ++++++++--
 7 files changed, 8 insertions(+), 41 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 50f07bbd33fa..7f37ef1b72ce 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -62,11 +62,6 @@ u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena)
 	return arena ? arena->user_vm_start : 0;
 }
 
-static int arena_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
-{
-	return -EOPNOTSUPP;
-}
-
 static long compute_pgoff(struct bpf_arena *arena, long uaddr)
 {
 	return (u32)(uaddr - (u32)arena->user_vm_start) >> PAGE_SHIFT;
@@ -382,7 +377,6 @@ const struct bpf_map_ops arena_map_ops = {
 	.map_direct_value_addr = arena_map_direct_value_addr,
 	.map_mmap = arena_map_mmap,
 	.map_get_unmapped_area = arena_get_unmapped_area,
-	.map_get_next_key = arena_map_get_next_key,
 	.map_lookup_elem = arena_map_lookup_elem,
 	.map_update_elem = arena_map_update_elem,
 	.map_check_btf = arena_map_check_btf,
diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
index f3bba8ac2532..3aed40c92c26 100644
--- a/kernel/bpf/bloom_filter.c
+++ b/kernel/bpf/bloom_filter.c
@@ -65,11 +65,6 @@ static long bloom_map_push_elem(struct bpf_map *map, void *value, u64 flags)
 	return 0;
 }
 
-static int bloom_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
-{
-	return -EOPNOTSUPP;
-}
-
 /* Called from syscall */
 static int bloom_map_alloc_check(union bpf_attr *attr)
 {
@@ -196,7 +191,6 @@ const struct bpf_map_ops bloom_filter_map_ops = {
 	.map_alloc_check = bloom_map_alloc_check,
 	.map_alloc = bloom_map_alloc,
 	.map_free = bloom_map_free,
-	.map_get_next_key = bloom_map_get_next_key,
 	.map_push_elem = bloom_map_push_elem,
 	.map_peek_elem = bloom_map_peek_elem,
 	.map_lookup_elem = bloom_map_lookup_elem,
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 54ff2a85d4c0..305f23c36afc 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -141,11 +141,6 @@ static long bpf_cgrp_storage_delete_elem(struct bpf_map *map, void *key)
 	return err;
 }
 
-static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
-{
-	return -ENOTSUPP;
-}
-
 static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 {
 	return bpf_local_storage_map_alloc(attr, &cgroup_cache, true);
@@ -208,7 +203,6 @@ const struct bpf_map_ops cgrp_storage_map_ops = {
 	.map_alloc_check = bpf_local_storage_map_alloc_check,
 	.map_alloc = cgroup_storage_map_alloc,
 	.map_free = cgroup_storage_map_free,
-	.map_get_next_key = notsupp_get_next_key,
 	.map_lookup_elem = bpf_cgrp_storage_lookup_elem,
 	.map_update_elem = bpf_cgrp_storage_update_elem,
 	.map_delete_elem = bpf_cgrp_storage_delete_elem,
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 15a3eb9b02d9..6db158c2a42b 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -175,12 +175,6 @@ BPF_CALL_2(bpf_inode_storage_delete,
 	return inode_storage_delete(inode, map);
 }
 
-static int notsupp_get_next_key(struct bpf_map *map, void *key,
-				void *next_key)
-{
-	return -ENOTSUPP;
-}
-
 static struct bpf_map *inode_storage_map_alloc(union bpf_attr *attr)
 {
 	return bpf_local_storage_map_alloc(attr, &inode_cache, false);
@@ -196,7 +190,6 @@ const struct bpf_map_ops inode_storage_map_ops = {
 	.map_alloc_check = bpf_local_storage_map_alloc_check,
 	.map_alloc = inode_storage_map_alloc,
 	.map_free = inode_storage_map_free,
-	.map_get_next_key = notsupp_get_next_key,
 	.map_lookup_elem = bpf_fd_inode_storage_lookup_elem,
 	.map_update_elem = bpf_fd_inode_storage_update_elem,
 	.map_delete_elem = bpf_fd_inode_storage_delete_elem,
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 1109475953c0..3bdb49aab55f 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -303,11 +303,6 @@ BPF_CALL_2(bpf_task_storage_delete, struct bpf_map *, map, struct task_struct *,
 	return ret;
 }
 
-static int notsupp_get_next_key(struct bpf_map *map, void *key, void *next_key)
-{
-	return -ENOTSUPP;
-}
-
 static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
 {
 	return bpf_local_storage_map_alloc(attr, &task_cache, true);
@@ -324,7 +319,6 @@ const struct bpf_map_ops task_storage_map_ops = {
 	.map_alloc_check = bpf_local_storage_map_alloc_check,
 	.map_alloc = task_storage_map_alloc,
 	.map_free = task_storage_map_free,
-	.map_get_next_key = notsupp_get_next_key,
 	.map_lookup_elem = bpf_pid_task_storage_lookup_elem,
 	.map_update_elem = bpf_pid_task_storage_update_elem,
 	.map_delete_elem = bpf_pid_task_storage_delete_elem,
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index e2d22f10a11f..932a6c06e3e0 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -247,12 +247,6 @@ static long ringbuf_map_update_elem(struct bpf_map *map, void *key, void *value,
 	return -ENOTSUPP;
 }
 
-static int ringbuf_map_get_next_key(struct bpf_map *map, void *key,
-				    void *next_key)
-{
-	return -ENOTSUPP;
-}
-
 static int ringbuf_map_mmap_kern(struct bpf_map *map, struct vm_area_struct *vma)
 {
 	struct bpf_ringbuf_map *rb_map;
@@ -351,7 +345,6 @@ const struct bpf_map_ops ringbuf_map_ops = {
 	.map_poll = ringbuf_map_poll_kern,
 	.map_lookup_elem = ringbuf_map_lookup_elem,
 	.map_update_elem = ringbuf_map_update_elem,
-	.map_get_next_key = ringbuf_map_get_next_key,
 	.map_mem_usage = ringbuf_map_mem_usage,
 	.map_btf_id = &ringbuf_map_btf_ids[0],
 };
@@ -365,7 +358,6 @@ const struct bpf_map_ops user_ringbuf_map_ops = {
 	.map_poll = ringbuf_map_poll_user,
 	.map_lookup_elem = ringbuf_map_lookup_elem,
 	.map_update_elem = ringbuf_map_update_elem,
-	.map_get_next_key = ringbuf_map_get_next_key,
 	.map_mem_usage = ringbuf_map_mem_usage,
 	.map_btf_id = &user_ringbuf_map_btf_ids[0],
 };
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 36eed7016da4..087abbacbd05 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1850,7 +1850,10 @@ static int map_get_next_key(union bpf_attr *attr)
 	}
 
 	rcu_read_lock();
-	err = map->ops->map_get_next_key(map, key, next_key);
+	if (map->ops->map_get_next_key)
+		err = map->ops->map_get_next_key(map, key, next_key);
+	else
+		err = -EOPNOTSUPP;
 	rcu_read_unlock();
 out:
 	if (err)
@@ -2037,7 +2040,10 @@ int generic_map_lookup_batch(struct bpf_map *map,
 
 	for (cp = 0; cp < max_count;) {
 		rcu_read_lock();
-		err = map->ops->map_get_next_key(map, prev_key, key);
+		if (map->ops->map_get_next_key)
+			err = map->ops->map_get_next_key(map, prev_key, key);
+		else
+			err = -EOPNOTSUPP;
 		rcu_read_unlock();
 		if (err)
 			break;
-- 
2.34.1


