Return-Path: <bpf+bounces-77589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4ECCEC118
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 15:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E6FF301515F
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 14:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2A423EAB3;
	Wed, 31 Dec 2025 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHvMGKtE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7649C23D7DB
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767190484; cv=none; b=SnQKb3cURaREJ1KB+pRNgb7teUnIEnbJ9mVMSqmwHkCbHDkYEAml90rZoeHD9Q1NM38WFB6mQKUWBbTNsWWbyyjTInSIwzxiLZHOc/VLqQHlYekWWuiP6FqH3Zyb0BmZViww4gwWPypFzDsymf0A5MdIln0sRKrtEdVF/3YkNVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767190484; c=relaxed/simple;
	bh=KdXTRQxgvOK76y13k27MzIaGCd6CHqTj8FkDxcFw4Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJ1zVR2iBUCd+nepR8Qtq+ORJSIOl1vFf4nR1jdUpkTSFKH6Zt12SvTCcn9LlvZHOeSbP6Yj6GASJBdnU73WqFgHMLYaTyg19a4Pl6lPYehcpk3vhePywr+oH5ggTaoCg+VIxwJugo3rS9iOE3nSo3m8VvEXphxu59J2ZSOuiz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHvMGKtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B662C113D0;
	Wed, 31 Dec 2025 14:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767190483;
	bh=KdXTRQxgvOK76y13k27MzIaGCd6CHqTj8FkDxcFw4Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AHvMGKtEXJOBaGP7kztO2Pw5xybn2HTXYGjR1Ct3gxN0dUVK/Sjdl9EgCAmJwYdMC
	 8tRgO0KEcjljfgrUenhSWYmJBZJDMwYa52wfLIxPUaavlMcQjFETppqjqcxA3EsbaL
	 aUPQvh/O52uqN7UGqPz/A/Krxi+sEL37I/OysPjD8dzKak+c+bJhbTWHpSGOftqik2
	 MpZp3YBN9SBUSzQKWZKDUlHpYmhTa8cDEHAcJU2WW1iGx+zwCS8lkmXCsIHkUsTlTD
	 /s8ufScOq5HR/JlR9r8TUe/TPLCPKolP1XklzNHb6o5Dj8M+1aOL3UrRfW/Pe2LnoD
	 KhE05FUzg854A==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/2] bpf: syscall: Introduce memcg enter/exit helpers
Date: Wed, 31 Dec 2025 06:14:32 -0800
Message-ID: <20251231141434.3416822-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251231141434.3416822-1-puranjay@kernel.org>
References: <20251231141434.3416822-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce bpf_map_memcg_enter() and bpf_map_memcg_exit() helpers to
reduce code duplication in memcg context management.

bpf_map_memcg_enter() gets the memcg from the map, sets it as active,
and returns both the previous and the now active memcg.

bpf_map_memcg_exit() restores the previous active memcg and releases the
reference obtained during enter.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/bpf.h  | 15 +++++++++++++
 kernel/bpf/syscall.c | 50 +++++++++++++++++++++++---------------------
 2 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4e7d72dfbcd4..24a32b1043d1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2608,6 +2608,10 @@ struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
 int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
 			unsigned long nr_pages, struct page **page_array);
 #ifdef CONFIG_MEMCG
+void bpf_map_memcg_enter(const struct bpf_map *map, struct mem_cgroup **old_memcg,
+			 struct mem_cgroup **new_memcg);
+void bpf_map_memcg_exit(struct mem_cgroup *old_memcg,
+			struct mem_cgroup *memcg);
 void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
 			   int node);
 void *bpf_map_kmalloc_nolock(const struct bpf_map *map, size_t size, gfp_t flags,
@@ -2632,6 +2636,17 @@ void __percpu *bpf_map_alloc_percpu(const struct bpf_map *map, size_t size,
 		kvcalloc(_n, _size, _flags)
 #define bpf_map_alloc_percpu(_map, _size, _align, _flags)	\
 		__alloc_percpu_gfp(_size, _align, _flags)
+static inline void bpf_map_memcg_enter(const struct bpf_map *map, struct mem_cgroup **old_memcg,
+				       struct mem_cgroup **new_memcg)
+{
+	*new_memcg = NULL;
+	*old_memcg = NULL;
+}
+
+static inline void bpf_map_memcg_exit(struct mem_cgroup *old_memcg,
+				      struct mem_cgroup *memcg)
+{
+}
 #endif
 
 static inline int
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a4d38272d8bc..63849a06518b 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -505,17 +505,29 @@ static struct mem_cgroup *bpf_map_get_memcg(const struct bpf_map *map)
 	return root_mem_cgroup;
 }
 
+void bpf_map_memcg_enter(const struct bpf_map *map, struct mem_cgroup **old_memcg,
+			 struct mem_cgroup **new_memcg)
+{
+	*new_memcg = bpf_map_get_memcg(map);
+	*old_memcg = set_active_memcg(*new_memcg);
+}
+
+void bpf_map_memcg_exit(struct mem_cgroup *old_memcg,
+			struct mem_cgroup *new_memcg)
+{
+	set_active_memcg(old_memcg);
+	mem_cgroup_put(new_memcg);
+}
+
 void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
 			   int node)
 {
 	struct mem_cgroup *memcg, *old_memcg;
 	void *ptr;
 
-	memcg = bpf_map_get_memcg(map);
-	old_memcg = set_active_memcg(memcg);
+	bpf_map_memcg_enter(map, &old_memcg, &memcg);
 	ptr = kmalloc_node(size, flags | __GFP_ACCOUNT, node);
-	set_active_memcg(old_memcg);
-	mem_cgroup_put(memcg);
+	bpf_map_memcg_exit(old_memcg, memcg);
 
 	return ptr;
 }
@@ -526,11 +538,9 @@ void *bpf_map_kmalloc_nolock(const struct bpf_map *map, size_t size, gfp_t flags
 	struct mem_cgroup *memcg, *old_memcg;
 	void *ptr;
 
-	memcg = bpf_map_get_memcg(map);
-	old_memcg = set_active_memcg(memcg);
+	bpf_map_memcg_enter(map, &old_memcg, &memcg);
 	ptr = kmalloc_nolock(size, flags | __GFP_ACCOUNT, node);
-	set_active_memcg(old_memcg);
-	mem_cgroup_put(memcg);
+	bpf_map_memcg_exit(old_memcg, memcg);
 
 	return ptr;
 }
@@ -540,11 +550,9 @@ void *bpf_map_kzalloc(const struct bpf_map *map, size_t size, gfp_t flags)
 	struct mem_cgroup *memcg, *old_memcg;
 	void *ptr;
 
-	memcg = bpf_map_get_memcg(map);
-	old_memcg = set_active_memcg(memcg);
+	bpf_map_memcg_enter(map, &old_memcg, &memcg);
 	ptr = kzalloc(size, flags | __GFP_ACCOUNT);
-	set_active_memcg(old_memcg);
-	mem_cgroup_put(memcg);
+	bpf_map_memcg_exit(old_memcg, memcg);
 
 	return ptr;
 }
@@ -555,11 +563,9 @@ void *bpf_map_kvcalloc(struct bpf_map *map, size_t n, size_t size,
 	struct mem_cgroup *memcg, *old_memcg;
 	void *ptr;
 
-	memcg = bpf_map_get_memcg(map);
-	old_memcg = set_active_memcg(memcg);
+	bpf_map_memcg_enter(map, &old_memcg, &memcg);
 	ptr = kvcalloc(n, size, flags | __GFP_ACCOUNT);
-	set_active_memcg(old_memcg);
-	mem_cgroup_put(memcg);
+	bpf_map_memcg_exit(old_memcg, memcg);
 
 	return ptr;
 }
@@ -570,11 +576,9 @@ void __percpu *bpf_map_alloc_percpu(const struct bpf_map *map, size_t size,
 	struct mem_cgroup *memcg, *old_memcg;
 	void __percpu *ptr;
 
-	memcg = bpf_map_get_memcg(map);
-	old_memcg = set_active_memcg(memcg);
+	bpf_map_memcg_enter(map, &old_memcg, &memcg);
 	ptr = __alloc_percpu_gfp(size, align, flags | __GFP_ACCOUNT);
-	set_active_memcg(old_memcg);
-	mem_cgroup_put(memcg);
+	bpf_map_memcg_exit(old_memcg, memcg);
 
 	return ptr;
 }
@@ -615,8 +619,7 @@ int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
 #ifdef CONFIG_MEMCG
 	struct mem_cgroup *memcg, *old_memcg;
 
-	memcg = bpf_map_get_memcg(map);
-	old_memcg = set_active_memcg(memcg);
+	bpf_map_memcg_enter(map, &old_memcg, &memcg);
 #endif
 	for (i = 0; i < nr_pages; i++) {
 		pg = __bpf_alloc_page(nid);
@@ -632,8 +635,7 @@ int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
 	}
 
 #ifdef CONFIG_MEMCG
-	set_active_memcg(old_memcg);
-	mem_cgroup_put(memcg);
+	bpf_map_memcg_exit(old_memcg, memcg);
 #endif
 	return ret;
 }
-- 
2.47.3


