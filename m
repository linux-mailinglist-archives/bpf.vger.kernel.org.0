Return-Path: <bpf+bounces-77523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F287CEA113
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 16:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4078303524F
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 15:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1646B1C4A24;
	Tue, 30 Dec 2025 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="el9cUpsz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBCC2DFA4A
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767108635; cv=none; b=C510WoxWWwo/Muw3C/G/+jeAIVnmdr3Y2/LYHQuZLw5o7dDdvHnHn7S7/BNf0w5nl7erQjoY6lVpLYIhVLQ+LjKl1CkBzZ8zbds4lbbMAbXo4WuAiH0Fkovdfbjln/orUu3lFBiCd/nfY+cR0q89Re0W7XhKpHCvzP8Z+YeRJhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767108635; c=relaxed/simple;
	bh=NdiQMPhrtDOUEqVrWn/yGupmrX0pUfSGfzHL4LYncgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QB9Gvs9KUSCMiR7GnOlsxhbWre/esRwbXwpQHc4QjVC1qMkrPg3wntHzsTfcsKeJ065D1QLTxZabrCqprPss9bLA5tpQm1RLTVOTwmE8mIvnsv1n9sCfWY+4MZoKF0bk3lTgu2xbX55UBKf+ZHkBabSjCdaYt9PA+AIfSAt9Bds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=el9cUpsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC20C4CEFB;
	Tue, 30 Dec 2025 15:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767108634;
	bh=NdiQMPhrtDOUEqVrWn/yGupmrX0pUfSGfzHL4LYncgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=el9cUpszyjdDr7W7Tsnes8UTmTvCEPSV6hGaCplTD34QcblQKo58VdDK8xg4ASwZO
	 ZdpxpIVsSlEV1bhhP66BoRfZ4BnkjySRYl5NoNgtP1cdjjQz1IKwh1C/DR8LgMnRR/
	 aqcE09MjbWI8rXzjyYp/7FV+skM3Vt414BMkPGqv0TvN6zKq9jzPh5qm2iF6Fo2yBc
	 ulAesGfVJwdRewufXFsjAq0xeThteA/gl0pm9Ioq0XLdj+Hjvae7UgJkYzvMnA3AQS
	 fSsK76ey36w4PO4NnNlFcVReIWbDowUJRSX18x046lme38hIs3TCKk6rPTFUQVL6zA
	 hsG87vroHRbbw==
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
Subject: [PATCH bpf-next 1/2] bpf: syscall: Introduce memcg enter/exit helpers
Date: Tue, 30 Dec 2025 07:30:03 -0800
Message-ID: <20251230153006.1347742-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251230153006.1347742-1-puranjay@kernel.org>
References: <20251230153006.1347742-1-puranjay@kernel.org>
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
and returns the previous active memcg.

bpf_map_memcg_exit() restores the previous active memcg and releases the
reference obtained during enter.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 include/linux/bpf.h  | 15 +++++++++++++
 kernel/bpf/syscall.c | 50 +++++++++++++++++++++++---------------------
 2 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4e7d72dfbcd4..4aedc3ceb482 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2608,6 +2608,10 @@ struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id);
 int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
 			unsigned long nr_pages, struct page **page_array);
 #ifdef CONFIG_MEMCG
+struct mem_cgroup *bpf_map_memcg_enter(const struct bpf_map *map,
+				       struct mem_cgroup **memcg);
+void bpf_map_memcg_exit(struct mem_cgroup *old_memcg,
+			struct mem_cgroup *memcg);
 void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
 			   int node);
 void *bpf_map_kmalloc_nolock(const struct bpf_map *map, size_t size, gfp_t flags,
@@ -2632,6 +2636,17 @@ void __percpu *bpf_map_alloc_percpu(const struct bpf_map *map, size_t size,
 		kvcalloc(_n, _size, _flags)
 #define bpf_map_alloc_percpu(_map, _size, _align, _flags)	\
 		__alloc_percpu_gfp(_size, _align, _flags)
+static inline struct mem_cgroup *bpf_map_memcg_enter(const struct bpf_map *map,
+						     struct mem_cgroup **memcg)
+{
+	*memcg = NULL;
+	return NULL;
+}
+
+static inline void bpf_map_memcg_exit(struct mem_cgroup *old_memcg,
+				      struct mem_cgroup *memcg)
+{
+}
 #endif
 
 static inline int
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a4d38272d8bc..e7c0c469c60e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -505,17 +505,29 @@ static struct mem_cgroup *bpf_map_get_memcg(const struct bpf_map *map)
 	return root_mem_cgroup;
 }
 
+struct mem_cgroup *bpf_map_memcg_enter(const struct bpf_map *map,
+				       struct mem_cgroup **memcg)
+{
+	*memcg = bpf_map_get_memcg(map);
+	return set_active_memcg(*memcg);
+}
+
+void bpf_map_memcg_exit(struct mem_cgroup *old_memcg,
+			struct mem_cgroup *memcg)
+{
+	set_active_memcg(old_memcg);
+	mem_cgroup_put(memcg);
+}
+
 void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
 			   int node)
 {
 	struct mem_cgroup *memcg, *old_memcg;
 	void *ptr;
 
-	memcg = bpf_map_get_memcg(map);
-	old_memcg = set_active_memcg(memcg);
+	old_memcg = bpf_map_memcg_enter(map, &memcg);
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
+	old_memcg = bpf_map_memcg_enter(map, &memcg);
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
+	old_memcg = bpf_map_memcg_enter(map, &memcg);
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
+	old_memcg = bpf_map_memcg_enter(map, &memcg);
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
+	old_memcg = bpf_map_memcg_enter(map, &memcg);
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
+	old_memcg = bpf_map_memcg_enter(map, &memcg);
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


