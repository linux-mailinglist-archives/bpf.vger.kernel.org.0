Return-Path: <bpf+bounces-51706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2127EA3798A
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 02:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0165E3A425F
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 01:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C671494A8;
	Mon, 17 Feb 2025 01:53:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FFF143748
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 01:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739757208; cv=none; b=LtAP7i9dfVajwccN6Wkv+wV420iyaGDIkyH/Jq+X2M+U8faUwcVwITva1e+N8u1tehaVqd2TfIpVmClzmYByJY+Nt6dImkTJYEfe+vnQP5pD092JxSEYi/0e1JklGoP0EJRqPobp2TB84oKm2hHEVbiyjaq9G4vE5c1EVUOCWVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739757208; c=relaxed/simple;
	bh=aoCFHOArg/5CMCvaMGgiDfp332tpZDkZXfcfflPznKs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FReBP8vnpfN8SE45zVb9H95PGA2iP/sIyvwuLW7HYn6GJJmORNeHWb/G5BRa9xpLQbJ6vhcM/vbMSwxkE4nnNtYMDVEaInkh3tSDyuj5jxdthXO6NqOFIyMnBoCdyYv4sN+29qd2ZeLjBukT3L9uXRuE0puorj/4GrOUQCKclAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Yx5F011rxzkXSL;
	Mon, 17 Feb 2025 09:49:40 +0800 (CST)
Received: from kwepemh200013.china.huawei.com (unknown [7.202.181.122])
	by mail.maildlp.com (Postfix) with ESMTPS id B4FDC1401E9;
	Mon, 17 Feb 2025 09:53:17 +0800 (CST)
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
Subject: [PATCH -next 4/5] bpf: Remove map_delete_elem callbacks with -EOPNOTSUPP
Date: Mon, 17 Feb 2025 01:41:21 +0000
Message-ID: <20250217014122.65645-5-zhangxiaomeng13@huawei.com>
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

Remove redundant map_delete_elem callbacks with return -EOPNOTSUPP. We can
directly return -EOPNOTSUPP when calling the unimplemented callbacks.

Signed-off-by: Xiaomeng Zhang <zhangxiaomeng13@huawei.com>
---
 kernel/bpf/arena.c        | 6 ------
 kernel/bpf/bloom_filter.c | 6 ------
 kernel/bpf/helpers.c      | 5 ++++-
 kernel/bpf/ringbuf.c      | 7 -------
 kernel/bpf/syscall.c      | 5 ++++-
 5 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 2c95baa8ece2..50f07bbd33fa 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -62,11 +62,6 @@ u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena)
 	return arena ? arena->user_vm_start : 0;
 }
 
-static long arena_map_delete_elem(struct bpf_map *map, void *value)
-{
-	return -EOPNOTSUPP;
-}
-
 static int arena_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 {
 	return -EOPNOTSUPP;
@@ -390,7 +385,6 @@ const struct bpf_map_ops arena_map_ops = {
 	.map_get_next_key = arena_map_get_next_key,
 	.map_lookup_elem = arena_map_lookup_elem,
 	.map_update_elem = arena_map_update_elem,
-	.map_delete_elem = arena_map_delete_elem,
 	.map_check_btf = arena_map_check_btf,
 	.map_mem_usage = arena_map_mem_usage,
 	.map_btf_id = &bpf_arena_map_btf_ids[0],
diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
index d8d4dd7b711d..f3bba8ac2532 100644
--- a/kernel/bpf/bloom_filter.c
+++ b/kernel/bpf/bloom_filter.c
@@ -65,11 +65,6 @@ static long bloom_map_push_elem(struct bpf_map *map, void *value, u64 flags)
 	return 0;
 }
 
-static long bloom_map_delete_elem(struct bpf_map *map, void *value)
-{
-	return -EOPNOTSUPP;
-}
-
 static int bloom_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 {
 	return -EOPNOTSUPP;
@@ -206,7 +201,6 @@ const struct bpf_map_ops bloom_filter_map_ops = {
 	.map_peek_elem = bloom_map_peek_elem,
 	.map_lookup_elem = bloom_map_lookup_elem,
 	.map_update_elem = bloom_map_update_elem,
-	.map_delete_elem = bloom_map_delete_elem,
 	.map_check_btf = bloom_map_check_btf,
 	.map_mem_usage = bloom_map_mem_usage,
 	.map_btf_id = &bpf_bloom_map_btf_ids[0],
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index cb61c06155c8..132c2830c758 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -74,7 +74,10 @@ BPF_CALL_2(bpf_map_delete_elem, struct bpf_map *, map, void *, key)
 {
 	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
 		     !rcu_read_lock_bh_held());
-	return map->ops->map_delete_elem(map, key);
+	if (map->ops->map_delete_elem)
+		return map->ops->map_delete_elem(map, key);
+	else
+		return -EOPNOTSUPP;
 }
 
 const struct bpf_func_proto bpf_map_delete_elem_proto = {
diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 1499d8caa9a3..e2d22f10a11f 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -247,11 +247,6 @@ static long ringbuf_map_update_elem(struct bpf_map *map, void *key, void *value,
 	return -ENOTSUPP;
 }
 
-static long ringbuf_map_delete_elem(struct bpf_map *map, void *key)
-{
-	return -ENOTSUPP;
-}
-
 static int ringbuf_map_get_next_key(struct bpf_map *map, void *key,
 				    void *next_key)
 {
@@ -356,7 +351,6 @@ const struct bpf_map_ops ringbuf_map_ops = {
 	.map_poll = ringbuf_map_poll_kern,
 	.map_lookup_elem = ringbuf_map_lookup_elem,
 	.map_update_elem = ringbuf_map_update_elem,
-	.map_delete_elem = ringbuf_map_delete_elem,
 	.map_get_next_key = ringbuf_map_get_next_key,
 	.map_mem_usage = ringbuf_map_mem_usage,
 	.map_btf_id = &ringbuf_map_btf_ids[0],
@@ -371,7 +365,6 @@ const struct bpf_map_ops user_ringbuf_map_ops = {
 	.map_poll = ringbuf_map_poll_user,
 	.map_lookup_elem = ringbuf_map_lookup_elem,
 	.map_update_elem = ringbuf_map_update_elem,
-	.map_delete_elem = ringbuf_map_delete_elem,
 	.map_get_next_key = ringbuf_map_get_next_key,
 	.map_mem_usage = ringbuf_map_mem_usage,
 	.map_btf_id = &user_ringbuf_map_btf_ids[0],
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c6f55283f4ff..36eed7016da4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1789,7 +1789,10 @@ static int map_delete_elem(union bpf_attr *attr, bpfptr_t uattr)
 	} else if (IS_FD_PROG_ARRAY(map) ||
 		   map->map_type == BPF_MAP_TYPE_STRUCT_OPS) {
 		/* These maps require sleepable context */
-		err = map->ops->map_delete_elem(map, key);
+		if (map->ops->map_delete_elem)
+			err = map->ops->map_delete_elem(map, key);
+		else
+			err = -EOPNOTSUPP;
 		goto out;
 	}
 
-- 
2.34.1


