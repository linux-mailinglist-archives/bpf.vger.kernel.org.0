Return-Path: <bpf+bounces-51705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4E3A37989
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 02:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987233AEC4B
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 01:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA5A148318;
	Mon, 17 Feb 2025 01:53:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46B013AA2A
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 01:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739757206; cv=none; b=o/4OH7B1SrB2yWZg4zBQVrTliiV11SFjs5CgMJqUMGorSU8QvyGSvnRRLs9k+JmZ2chmBXTtEDUrKTBg2NhBH5s/C1dRGdt/6iGQu/R8vwBCt/pUC7DNUu2PYHZ9hmulccLJ7sYXPF1BcdqCo/btq1CmjsFa90YdOjJNajbTuC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739757206; c=relaxed/simple;
	bh=yXWt9ueL23iAUuaQ4cmRIsxa8JH3FHTsmnOVQd16CPc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nXkPlZcwmkGGAfxBc+dvqdx3bDiN0DwuI6lSZutpx9QX9GI+v5zeXmszPm7h7X9kgf1WuIuFYnGrNaNntMQg27Bw0rXb7dDlpoezR+VcxLVDla2IuPN95gd7clvPzjAHmv7ah7iPkF4Bi7boSSEfTChxgcD9VFAwpXsS516R6Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Yx5Dj37VVz2Fd2S;
	Mon, 17 Feb 2025 09:49:25 +0800 (CST)
Received: from kwepemh200013.china.huawei.com (unknown [7.202.181.122])
	by mail.maildlp.com (Postfix) with ESMTPS id 359B01402C7;
	Mon, 17 Feb 2025 09:53:17 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.175.36) by
 kwepemh200013.china.huawei.com (7.202.181.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Feb 2025 09:53:16 +0800
From: Xiaomeng Zhang <zhangxiaomeng13@huawei.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH -next 3/5] bpf: Remove map_pop_elem callbacks with -EOPNOTSUPP
Date: Mon, 17 Feb 2025 01:41:20 +0000
Message-ID: <20250217014122.65645-4-zhangxiaomeng13@huawei.com>
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

Remove redundant map_pop_elem callbacks with return -EOPNOTSUPP. We can
directly return -EOPNOTSUPP when calling the unimplemented callbacks.

Signed-off-by: Xiaomeng Zhang <zhangxiaomeng13@huawei.com>
---
 kernel/bpf/arena.c        | 6 ------
 kernel/bpf/bloom_filter.c | 6 ------
 kernel/bpf/helpers.c      | 5 ++++-
 kernel/bpf/syscall.c      | 5 ++++-
 4 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 7ee98aeccf3c..2c95baa8ece2 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -62,11 +62,6 @@ u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena)
 	return arena ? arena->user_vm_start : 0;
 }
 
-static long arena_map_pop_elem(struct bpf_map *map, void *value)
-{
-	return -EOPNOTSUPP;
-}
-
 static long arena_map_delete_elem(struct bpf_map *map, void *value)
 {
 	return -EOPNOTSUPP;
@@ -393,7 +388,6 @@ const struct bpf_map_ops arena_map_ops = {
 	.map_mmap = arena_map_mmap,
 	.map_get_unmapped_area = arena_get_unmapped_area,
 	.map_get_next_key = arena_map_get_next_key,
-	.map_pop_elem = arena_map_pop_elem,
 	.map_lookup_elem = arena_map_lookup_elem,
 	.map_update_elem = arena_map_update_elem,
 	.map_delete_elem = arena_map_delete_elem,
diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
index 35e1ddca74d2..d8d4dd7b711d 100644
--- a/kernel/bpf/bloom_filter.c
+++ b/kernel/bpf/bloom_filter.c
@@ -65,11 +65,6 @@ static long bloom_map_push_elem(struct bpf_map *map, void *value, u64 flags)
 	return 0;
 }
 
-static long bloom_map_pop_elem(struct bpf_map *map, void *value)
-{
-	return -EOPNOTSUPP;
-}
-
 static long bloom_map_delete_elem(struct bpf_map *map, void *value)
 {
 	return -EOPNOTSUPP;
@@ -209,7 +204,6 @@ const struct bpf_map_ops bloom_filter_map_ops = {
 	.map_get_next_key = bloom_map_get_next_key,
 	.map_push_elem = bloom_map_push_elem,
 	.map_peek_elem = bloom_map_peek_elem,
-	.map_pop_elem = bloom_map_pop_elem,
 	.map_lookup_elem = bloom_map_lookup_elem,
 	.map_update_elem = bloom_map_update_elem,
 	.map_delete_elem = bloom_map_delete_elem,
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 000409c8308a..cb61c06155c8 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -106,7 +106,10 @@ const struct bpf_func_proto bpf_map_push_elem_proto = {
 
 BPF_CALL_2(bpf_map_pop_elem, struct bpf_map *, map, void *, value)
 {
-	return map->ops->map_pop_elem(map, value);
+	if (map->ops->map_pop_elem)
+		return map->ops->map_pop_elem(map, value);
+	else
+		return -EOPNOTSUPP;
 }
 
 const struct bpf_func_proto bpf_map_pop_elem_proto = {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 79a118ea9270..c6f55283f4ff 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2142,7 +2142,10 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 	err = -ENOTSUPP;
 	if (map->map_type == BPF_MAP_TYPE_QUEUE ||
 	    map->map_type == BPF_MAP_TYPE_STACK) {
-		err = map->ops->map_pop_elem(map, value);
+		if (map->ops->map_pop_elem)
+			err = map->ops->map_pop_elem(map, value);
+		else
+			err = -EOPNOTSUPP;
 	} else if (map->map_type == BPF_MAP_TYPE_HASH ||
 		   map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 		   map->map_type == BPF_MAP_TYPE_LRU_HASH ||
-- 
2.34.1


