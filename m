Return-Path: <bpf+bounces-41902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8555499DAD4
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 02:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A3E1C213A6
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 00:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9420E446A1;
	Tue, 15 Oct 2024 00:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UU6mLcTw"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD6529D0D
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 00:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728953429; cv=none; b=TK8do4B1ecnjrLn8uCR7+Hn872lWqysKOT2AE/9m2PcpW+Nli3U+Y5S2jpJMBDs12pBnOQONF/5N12k8SuI/XXf2ALwKZyHNqgj3/1fsKshE1jxuJ+BZaKN/U3ztvv7b5KaeDbmWRkqu3WktYBVrOnEmpRzI8w6MVWQ6RTXhWaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728953429; c=relaxed/simple;
	bh=PdMA6Bv9vgVIzqIYZGMyp9fWewEVtw857nn3KXPH8YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGyh3iRySuIH8fk1oTsS76K7mKmVlzHME2AKStGUUznGiSetlt2fYo6c/PDv0BJl1BheHquxJS84IbxrR6nPUw7r5hQQk/eUKXz2rQjHqyJRXQAnT8LvdGMOisew5/h7sTeKy6p3gOQih/hMQqzNT+FrrZ3O40PapvB8a9lzk/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UU6mLcTw; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728953425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bvYhJde40xawy1qxOhEF1sN00RFpRoe/EuUjB1+KGfM=;
	b=UU6mLcTwHsQBnb2MJYBTjv5jtl71oRZh0SNehNsJAkw0/isLz+LsD/GaTG8QFwMwFfnvjT
	0BrE6CnhEVxO0j4LuDzOzO+VF2DemyEgE6ApWN7Tgnynire4I4cZrsNm9f5r3qOykp1X5E
	3XPv606heMEqXP+3RJiiVbDVIOM6qe8=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v5 bpf-next 03/12] bpf: Add "bool swap_uptrs" arg to bpf_local_storage_update() and bpf_selem_alloc()
Date: Mon, 14 Oct 2024 17:49:53 -0700
Message-ID: <20241015005008.767267-4-martin.lau@linux.dev>
In-Reply-To: <20241015005008.767267-1-martin.lau@linux.dev>
References: <20241015005008.767267-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

In a later patch, the task local storage will only accept uptr
from the syscall update_elem and will not accept uptr from
the bpf prog. The reason is the bpf prog does not have a way
to provide a valid user space address.

bpf_local_storage_update() and bpf_selem_alloc() are used by
both bpf prog bpf_task_storage_get(BPF_LOCAL_STORAGE_GET_F_CREATE)
and bpf syscall update_elem. "bool swap_uptrs" arg is added
to bpf_local_storage_update() and bpf_selem_alloc() to tell if
it is called by the bpf prog or by the bpf syscall. When
swap_uptrs==true, it is called by the syscall.

The arg is named (swap_)uptrs because the later patch will swap
the uptrs between the newly allocated selem and the user space
provided map_value. It will make error handling easier in case
map->ops->map_update_elem() fails and the caller can decide
if it needs to unpin the uptr in the user space provided
map_value or the bpf_local_storage_update() has already
taken the uptr ownership and will take care of unpinning it also.

Only swap_uptrs==false is passed now. The logic to handle
the true case will be added in a later patch.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 include/linux/bpf_local_storage.h | 4 ++--
 kernel/bpf/bpf_cgrp_storage.c     | 4 ++--
 kernel/bpf/bpf_inode_storage.c    | 4 ++--
 kernel/bpf/bpf_local_storage.c    | 8 ++++----
 kernel/bpf/bpf_task_storage.c     | 4 ++--
 net/core/bpf_sk_storage.c         | 6 +++---
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index dcddb0aef7d8..0c7216c065d5 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -181,7 +181,7 @@ void bpf_selem_link_map(struct bpf_local_storage_map *smap,
 
 struct bpf_local_storage_elem *
 bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner, void *value,
-		bool charge_mem, gfp_t gfp_flags);
+		bool charge_mem, bool swap_uptrs, gfp_t gfp_flags);
 
 void bpf_selem_free(struct bpf_local_storage_elem *selem,
 		    struct bpf_local_storage_map *smap,
@@ -195,7 +195,7 @@ bpf_local_storage_alloc(void *owner,
 
 struct bpf_local_storage_data *
 bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
-			 void *value, u64 map_flags, gfp_t gfp_flags);
+			 void *value, u64 map_flags, bool swap_uptrs, gfp_t gfp_flags);
 
 u64 bpf_local_storage_map_mem_usage(const struct bpf_map *map);
 
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 28efd0a3f220..20f05de92e9c 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -107,7 +107,7 @@ static long bpf_cgrp_storage_update_elem(struct bpf_map *map, void *key,
 
 	bpf_cgrp_storage_lock();
 	sdata = bpf_local_storage_update(cgroup, (struct bpf_local_storage_map *)map,
-					 value, map_flags, GFP_ATOMIC);
+					 value, map_flags, false, GFP_ATOMIC);
 	bpf_cgrp_storage_unlock();
 	cgroup_put(cgroup);
 	return PTR_ERR_OR_ZERO(sdata);
@@ -181,7 +181,7 @@ BPF_CALL_5(bpf_cgrp_storage_get, struct bpf_map *, map, struct cgroup *, cgroup,
 	if (!percpu_ref_is_dying(&cgroup->self.refcnt) &&
 	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE))
 		sdata = bpf_local_storage_update(cgroup, (struct bpf_local_storage_map *)map,
-						 value, BPF_NOEXIST, gfp_flags);
+						 value, BPF_NOEXIST, false, gfp_flags);
 
 unlock:
 	bpf_cgrp_storage_unlock();
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 29da6d3838f6..44ccebc745e5 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -100,7 +100,7 @@ static long bpf_fd_inode_storage_update_elem(struct bpf_map *map, void *key,
 
 	sdata = bpf_local_storage_update(file_inode(fd_file(f)),
 					 (struct bpf_local_storage_map *)map,
-					 value, map_flags, GFP_ATOMIC);
+					 value, map_flags, false, GFP_ATOMIC);
 	return PTR_ERR_OR_ZERO(sdata);
 }
 
@@ -154,7 +154,7 @@ BPF_CALL_5(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
 	if (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {
 		sdata = bpf_local_storage_update(
 			inode, (struct bpf_local_storage_map *)map, value,
-			BPF_NOEXIST, gfp_flags);
+			BPF_NOEXIST, false, gfp_flags);
 		return IS_ERR(sdata) ? (unsigned long)NULL :
 					     (unsigned long)sdata->data;
 	}
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index c938dea5ddbf..1cf772cb26eb 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -73,7 +73,7 @@ static bool selem_linked_to_map(const struct bpf_local_storage_elem *selem)
 
 struct bpf_local_storage_elem *
 bpf_selem_alloc(struct bpf_local_storage_map *smap, void *owner,
-		void *value, bool charge_mem, gfp_t gfp_flags)
+		void *value, bool charge_mem, bool swap_uptrs, gfp_t gfp_flags)
 {
 	struct bpf_local_storage_elem *selem;
 
@@ -524,7 +524,7 @@ int bpf_local_storage_alloc(void *owner,
  */
 struct bpf_local_storage_data *
 bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
-			 void *value, u64 map_flags, gfp_t gfp_flags)
+			 void *value, u64 map_flags, bool swap_uptrs, gfp_t gfp_flags)
 {
 	struct bpf_local_storage_data *old_sdata = NULL;
 	struct bpf_local_storage_elem *alloc_selem, *selem = NULL;
@@ -550,7 +550,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		if (err)
 			return ERR_PTR(err);
 
-		selem = bpf_selem_alloc(smap, owner, value, true, gfp_flags);
+		selem = bpf_selem_alloc(smap, owner, value, true, swap_uptrs, gfp_flags);
 		if (!selem)
 			return ERR_PTR(-ENOMEM);
 
@@ -584,7 +584,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	/* A lookup has just been done before and concluded a new selem is
 	 * needed. The chance of an unnecessary alloc is unlikely.
 	 */
-	alloc_selem = selem = bpf_selem_alloc(smap, owner, value, true, gfp_flags);
+	alloc_selem = selem = bpf_selem_alloc(smap, owner, value, true, swap_uptrs, gfp_flags);
 	if (!alloc_selem)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index adf6dfe0ba68..45dc3ca334d3 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -147,7 +147,7 @@ static long bpf_pid_task_storage_update_elem(struct bpf_map *map, void *key,
 	bpf_task_storage_lock();
 	sdata = bpf_local_storage_update(
 		task, (struct bpf_local_storage_map *)map, value, map_flags,
-		GFP_ATOMIC);
+		false, GFP_ATOMIC);
 	bpf_task_storage_unlock();
 
 	err = PTR_ERR_OR_ZERO(sdata);
@@ -219,7 +219,7 @@ static void *__bpf_task_storage_get(struct bpf_map *map,
 	    (flags & BPF_LOCAL_STORAGE_GET_F_CREATE) && nobusy) {
 		sdata = bpf_local_storage_update(
 			task, (struct bpf_local_storage_map *)map, value,
-			BPF_NOEXIST, gfp_flags);
+			BPF_NOEXIST, false, gfp_flags);
 		return IS_ERR(sdata) ? NULL : sdata->data;
 	}
 
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index bc01b3aa6b0f..2f4ed83a75ae 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -106,7 +106,7 @@ static long bpf_fd_sk_storage_update_elem(struct bpf_map *map, void *key,
 	if (sock) {
 		sdata = bpf_local_storage_update(
 			sock->sk, (struct bpf_local_storage_map *)map, value,
-			map_flags, GFP_ATOMIC);
+			map_flags, false, GFP_ATOMIC);
 		sockfd_put(sock);
 		return PTR_ERR_OR_ZERO(sdata);
 	}
@@ -137,7 +137,7 @@ bpf_sk_storage_clone_elem(struct sock *newsk,
 {
 	struct bpf_local_storage_elem *copy_selem;
 
-	copy_selem = bpf_selem_alloc(smap, newsk, NULL, true, GFP_ATOMIC);
+	copy_selem = bpf_selem_alloc(smap, newsk, NULL, true, false, GFP_ATOMIC);
 	if (!copy_selem)
 		return NULL;
 
@@ -243,7 +243,7 @@ BPF_CALL_5(bpf_sk_storage_get, struct bpf_map *, map, struct sock *, sk,
 	    refcount_inc_not_zero(&sk->sk_refcnt)) {
 		sdata = bpf_local_storage_update(
 			sk, (struct bpf_local_storage_map *)map, value,
-			BPF_NOEXIST, gfp_flags);
+			BPF_NOEXIST, false, gfp_flags);
 		/* sk must be a fullsock (guaranteed by verifier),
 		 * so sock_gen_put() is unnecessary.
 		 */
-- 
2.43.5


