Return-Path: <bpf+bounces-77712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFCECEF415
	for <lists+bpf@lfdr.de>; Fri, 02 Jan 2026 21:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FF293011F96
	for <lists+bpf@lfdr.de>; Fri,  2 Jan 2026 20:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F127B2BEC41;
	Fri,  2 Jan 2026 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K93Nor6w"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A0226E718
	for <bpf@vger.kernel.org>; Fri,  2 Jan 2026 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767384168; cv=none; b=VxtSMcoVNmn82bKJ9ZepEmv8mbpaCNXGYObuFU5j3wut1g3j1xSamhqAvBSgzWGX1dOU0bR4OuCQYeXYZxbQe1dvT6jtfn7MuVxdRuFdT4nFsbs9vST1qMiHiP34Q5sO0tdX2RBPp1mAdFwbU9T3VhlBFn4mw2BFwLhIrgQofXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767384168; c=relaxed/simple;
	bh=JvYRBw2Y1hDk9KS3lQFO/YjrtbyCpt5ewtP2Sy5TODQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KS2GAvFOKm272ztL47zDIEcCk7ZJqO0IibVfQhRLW7S/3kl1VEkwqQaX2k5Fa58RPnuH+vVo32igXNxpcai6hHe8ivEvBSyr3JItmzZm73LnaL1mR3LZsNPMyS3puW+h6Fhf9iue1wA68UV+AAwmRLJAGkxCqk70+XQf2JzaB9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K93Nor6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAD0C116B1;
	Fri,  2 Jan 2026 20:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767384168;
	bh=JvYRBw2Y1hDk9KS3lQFO/YjrtbyCpt5ewtP2Sy5TODQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K93Nor6wPCFU7C+JXrX82Dk8jIdW+K6UeEIxq8obtMn6/slwl8sK3DcnRT+qJMQ6n
	 cw1cxmFgF7bY6bxFQeb9eg+q27YzK7lmPyPQesyGrKUtmL60zyA63DdK9TXiL9LSZg
	 AMni9bUabV7e3kgU+WPwxcDCqjRhnVm7WIgAFGdftr5WGb9yTNlqsuLVBCKTnbMsEY
	 8aGr0+teHtIXj2AE210QNLbzpMiSP/u5MARRZIt7zwqBPcVhtWwelmL4OBmroKelXS
	 X9L1xlZVlfFYFNoAWOs+4l+P5VYUgpcaXd4p7SyfqJKaSUxkBiRxCpzRrqPONV1QCj
	 BGiTINAqx6JFQ==
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
Subject: [PATCH bpf-next v5 1/2] bpf: syscall: Introduce memcg enter/exit helpers
Date: Fri,  2 Jan 2026 12:02:27 -0800
Message-ID: <20260102200230.25168-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260102200230.25168-1-puranjay@kernel.org>
References: <20260102200230.25168-1-puranjay@kernel.org>
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
 include/linux/bpf.h  | 15 ++++++++++++
 kernel/bpf/syscall.c | 54 +++++++++++++++++++++-----------------------
 2 files changed, 41 insertions(+), 28 deletions(-)

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
index a4d38272d8bc..c77ab2e32659 100644
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
@@ -612,12 +616,9 @@ int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
 	unsigned long i, j;
 	struct page *pg;
 	int ret = 0;
-#ifdef CONFIG_MEMCG
 	struct mem_cgroup *memcg, *old_memcg;
 
-	memcg = bpf_map_get_memcg(map);
-	old_memcg = set_active_memcg(memcg);
-#endif
+	bpf_map_memcg_enter(map, &old_memcg, &memcg);
 	for (i = 0; i < nr_pages; i++) {
 		pg = __bpf_alloc_page(nid);
 
@@ -631,10 +632,7 @@ int bpf_map_alloc_pages(const struct bpf_map *map, int nid,
 		break;
 	}
 
-#ifdef CONFIG_MEMCG
-	set_active_memcg(old_memcg);
-	mem_cgroup_put(memcg);
-#endif
+	bpf_map_memcg_exit(old_memcg, memcg);
 	return ret;
 }
 
-- 
2.47.3


