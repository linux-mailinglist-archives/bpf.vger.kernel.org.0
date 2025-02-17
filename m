Return-Path: <bpf+bounces-51704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D4BA37986
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 02:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D5551887E28
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 01:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B62145B27;
	Mon, 17 Feb 2025 01:53:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B753513BAE3
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 01:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739757205; cv=none; b=WfyolCs5RuG1z+lzdsMoCrG3NLoWS7l8OfUJYtutmvEZU85Z9XWG4QYRXujdpOyu2IV8aw6U6Bk70zd3/dcrO2u9/gSgqsKxfUogEcEvL6tPzo7kDLfc0+3Q+7BXVS2jP7cU9Qc1Hmb/tK/zZCSPa6AqmhV7scHKYcNuCFLd/g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739757205; c=relaxed/simple;
	bh=NpISDxi7NgbjwcTbH/rv1VJgLXUJoX4j4klbBItCx/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VyyMeGTstkQDmkBw09dZs5p1j3emZ56ki9parwg0i2K6+m1nwxajMezNv09+oprdSlLRNSvtN2yzINPlO1gdfaY3VBKD24MNPGAQjK77olSQxBQ2Y+HoJxvCyWkDdAjT2TwvEXVW44Wl+IKceZe511p7xMVmZ+h+BAqZR63qwn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Yx5Fk2lzRz22sxC;
	Mon, 17 Feb 2025 09:50:18 +0800 (CST)
Received: from kwepemh200013.china.huawei.com (unknown [7.202.181.122])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F546140155;
	Mon, 17 Feb 2025 09:53:16 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.175.36) by
 kwepemh200013.china.huawei.com (7.202.181.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 17 Feb 2025 09:53:15 +0800
From: Xiaomeng Zhang <zhangxiaomeng13@huawei.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH -next 1/5] bpf: Remove map_peek_elem callbacks with -EOPNOTSUPP
Date: Mon, 17 Feb 2025 01:41:18 +0000
Message-ID: <20250217014122.65645-2-zhangxiaomeng13@huawei.com>
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

Remove redundant map_peek_elem callbacks with return -EOPNOTSUPP. We can
directly return -EOPNOTSUPP when calling the unimplemented callbacks.

Signed-off-by: Xiaomeng Zhang <zhangxiaomeng13@huawei.com>
---
 kernel/bpf/arena.c   | 6 ------
 kernel/bpf/helpers.c | 5 ++++-
 kernel/bpf/syscall.c | 5 ++++-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 095a9554e1de..0aaefa5d6b09 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -62,11 +62,6 @@ u64 bpf_arena_get_user_vm_start(struct bpf_arena *arena)
 	return arena ? arena->user_vm_start : 0;
 }
 
-static long arena_map_peek_elem(struct bpf_map *map, void *value)
-{
-	return -EOPNOTSUPP;
-}
-
 static long arena_map_push_elem(struct bpf_map *map, void *value, u64 flags)
 {
 	return -EOPNOTSUPP;
@@ -404,7 +399,6 @@ const struct bpf_map_ops arena_map_ops = {
 	.map_get_unmapped_area = arena_get_unmapped_area,
 	.map_get_next_key = arena_map_get_next_key,
 	.map_push_elem = arena_map_push_elem,
-	.map_peek_elem = arena_map_peek_elem,
 	.map_pop_elem = arena_map_pop_elem,
 	.map_lookup_elem = arena_map_lookup_elem,
 	.map_update_elem = arena_map_update_elem,
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index f27ce162427a..0f429171de6d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -116,7 +116,10 @@ const struct bpf_func_proto bpf_map_pop_elem_proto = {
 
 BPF_CALL_2(bpf_map_peek_elem, struct bpf_map *, map, void *, value)
 {
-	return map->ops->map_peek_elem(map, value);
+	if (map->ops->map_peek_elem)
+		return map->ops->map_peek_elem(map, value);
+	else
+		return -EOPNOTSUPP;
 }
 
 const struct bpf_func_proto bpf_map_peek_elem_proto = {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ff1f980bd59a..e6e859f71c5d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -325,7 +325,10 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
 	} else if (map->map_type == BPF_MAP_TYPE_QUEUE ||
 		   map->map_type == BPF_MAP_TYPE_STACK ||
 		   map->map_type == BPF_MAP_TYPE_BLOOM_FILTER) {
-		err = map->ops->map_peek_elem(map, value);
+		if (map->ops->map_peek_elem)
+			err = map->ops->map_peek_elem(map, value);
+		else
+			err = -EOPNOTSUPP;
 	} else if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS) {
 		/* struct_ops map requires directly updating "value" */
 		err = bpf_struct_ops_map_sys_lookup_elem(map, key, value);
-- 
2.34.1


