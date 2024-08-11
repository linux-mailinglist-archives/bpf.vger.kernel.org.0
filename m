Return-Path: <bpf+bounces-36846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C4A94E239
	for <lists+bpf@lfdr.de>; Sun, 11 Aug 2024 18:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C70280D0D
	for <lists+bpf@lfdr.de>; Sun, 11 Aug 2024 16:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC311537A7;
	Sun, 11 Aug 2024 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0yPx2ML"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24327F6;
	Sun, 11 Aug 2024 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723392881; cv=none; b=c0V32j9Kc7YajMer2Z1R2y4rUJZfDkkqda47JDO5b9YGKvxyAiX+WYPPTsDFPyC2oEGpqUHhkQ+27JJ+EuEjGwVXyNiBn0azjciBqs2/ARbKx0aymRsCho1+4b3TvhgVo1Ua1T4AqLHPmlHCQv7uE3qJywPS4z2clzt19vumFwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723392881; c=relaxed/simple;
	bh=zxvqO0ty5aq7/s8I3F3sRn7tOKSoN/WpFzCuPnbgSHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uy55douKUBCI8B/miQyhGi2kp9jsC8hcb/5At9Od0s48ByohkhSi08LRew2d8PZUWmFKYWCZz7x98x7iQ1NpB+dOC+hj5XQQ37rRRZWOSHtM81Tn9zMXYpQcNZK1GbxyrzlDpUnfnFr8UJVSd2UcuWR0ExI8yxrlH7KX3zH5ucA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0yPx2ML; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a10bb7bcd0so4467640a12.3;
        Sun, 11 Aug 2024 09:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723392878; x=1723997678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZAe6il+hNxF8OQtTUoscaCtk2JgO5mUqlIiaLQJraA=;
        b=K0yPx2ML6bHzVwN/KRNJiWG0c1bCxytRwuZ7PPpJW9IEQH/MWsWxGXFVUvjpEHNSRc
         imL+b6imxdgSDvH211GkoIcNc3F75L6TDkAZNRap1v/6OkrFTQwJg+eff9Yy9tL34+t0
         Fi+RXEX1uVUTmrOYMxQJ6T5cTGDhtWoEsoDcP3ihJn+Tee0W26+w7SQL1wPwUNxmC2yb
         3358uyRlKTbfU/weGgH+hLWZSoiZHc6lzcC6aGZZTsq33FXRP47o4oaIz9aSwMc8FByx
         9QJimVbk5wGmBdzKccMHQ7Gh72/6BxfVzmGnX5QHI3DsSCCT07Ecg8ns89TLwrkCG91C
         rY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723392878; x=1723997678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ZAe6il+hNxF8OQtTUoscaCtk2JgO5mUqlIiaLQJraA=;
        b=Xz3O1K5v+fwdnN2XxfYnmlhBnNu66vwu/LUqlEOayLfvAZAx3X4e40+tV/b0RHLBQE
         lwCglw2yqEeQwV/3UUSglvogpQmNc8LcT7EPXR5078oZLQAE4du48lziqAvalea+YXZu
         /9o1BIfBhQINOLYohPkk8b9Gp4S2p7P+1i7aFf9FSl+RL2GKNv8oTivgFW/+oMSRq7vQ
         C73FlC2mSJd4Qaciw2xwGNIsWE61Bwxnjli0fpc+Iez7QRr0X4O4BaQyLx++V9CBNgt8
         8I474goPCMzRZger4YmqU6HFFseh+3GN8TTKTkGIA7s+/u1/dFebio6ALO8ZgI8s0RtH
         Lblw==
X-Forwarded-Encrypted: i=1; AJvYcCWS02fD/4fTF+wY7yb4pnWqBQ+Fgcgc1+ZSLkbSNSIpo1Wh2IUgF5APdPVswJVmBFshg0afxSqhs2dzDg8r4h1DflXeo2rtuvn/qXcI
X-Gm-Message-State: AOJu0Yxa253H0AS4l4lNVGbTP8YOknJTJPadCS8DGbqU5QXeEu03FT3B
	qOG5RXIWIC31nprktArBXobowHct5YhMz/6oTm5TwaUb6skWKTCbQFzhpwVC
X-Google-Smtp-Source: AGHT+IHk6QOY3WYnMl4O5GXkMGEKhgXFozl8TpIRmRRpuq9kxfr4TzppKxq9BSgYuBzgS9Uq71/Pqw==
X-Received: by 2002:a05:6402:42c6:b0:5a2:ec88:de7a with SMTP id 4fb4d7f45d1cf-5bd0a6dc52cmr5230488a12.33.1723392877487;
        Sun, 11 Aug 2024 09:14:37 -0700 (PDT)
Received: from localhost.localdomain (93-103-32-68.dynamic.t-2.net. [93.103.32.68])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd191a20bcsm1436138a12.34.2024.08.11.09.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 09:14:36 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH v2] bpf: Fix percpu address space issues
Date: Sun, 11 Aug 2024 18:13:33 +0200
Message-ID: <20240811161414.56744-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In arraymap.c:

In bpf_array_map_seq_start() and bpf_array_map_seq_next()
cast return values from the __percpu address space to
the generic address space via uintptr_t [1].

Correct the declaration of pptr pointer in __bpf_array_map_seq_show()
to void __percpu * and cast the value from the generic address
space to the __percpu address space via uintptr_t [1].

In hashtab.c:

Assign the return value from bpf_mem_cache_alloc() to void pointer
and cast the value to void __percpu ** (void pointer to percpu void
pointer) before dereferencing.

In memalloc.c:

Explicitly declare __percpu variables.

Cast obj to void __percpu **.

In helpers.c:

Cast ptr in BPF_CALL_1 and BPF_CALL_2 from generic address space
to __percpu address space via const uintptr_t [1].

Found by GCC's named address space checks.

There were no changes in the resulting object files.

[1] https://sparse.docs.kernel.org/en/latest/annotations.html#address-space-name

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
---
v2: - cast return values from the __percpu address space to
    the generic address space in bpf_array_map_seq_{start,next}().
    - correct the declaration of pptr pointer in
    __bpf_array_map_seq_show() to void __percpu *
---
 kernel/bpf/arraymap.c |  8 ++++----
 kernel/bpf/hashtab.c  |  9 +++++----
 kernel/bpf/helpers.c  |  4 ++--
 kernel/bpf/memalloc.c | 12 ++++++------
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 188e3c2effb2..a43e62e2a8bb 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -600,7 +600,7 @@ static void *bpf_array_map_seq_start(struct seq_file *seq, loff_t *pos)
 	array = container_of(map, struct bpf_array, map);
 	index = info->index & array->index_mask;
 	if (info->percpu_value_buf)
-	       return array->pptrs[index];
+		return (void *)(uintptr_t)array->pptrs[index];
 	return array_map_elem_ptr(array, index);
 }
 
@@ -619,7 +619,7 @@ static void *bpf_array_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	array = container_of(map, struct bpf_array, map);
 	index = info->index & array->index_mask;
 	if (info->percpu_value_buf)
-	       return array->pptrs[index];
+		return (void *)(uintptr_t)array->pptrs[index];
 	return array_map_elem_ptr(array, index);
 }
 
@@ -632,7 +632,7 @@ static int __bpf_array_map_seq_show(struct seq_file *seq, void *v)
 	struct bpf_iter_meta meta;
 	struct bpf_prog *prog;
 	int off = 0, cpu = 0;
-	void __percpu **pptr;
+	void __percpu *pptr;
 	u32 size;
 
 	meta.seq = seq;
@@ -648,7 +648,7 @@ static int __bpf_array_map_seq_show(struct seq_file *seq, void *v)
 		if (!info->percpu_value_buf) {
 			ctx.value = v;
 		} else {
-			pptr = v;
+			pptr = (void __percpu *)(uintptr_t)v;
 			size = array->elem_size;
 			for_each_possible_cpu(cpu) {
 				copy_map_value_long(map, info->percpu_value_buf + off,
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index be1f64c20125..45c7195b65ba 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1049,14 +1049,15 @@ static struct htab_elem *alloc_htab_elem(struct bpf_htab *htab, void *key,
 			pptr = htab_elem_get_ptr(l_new, key_size);
 		} else {
 			/* alloc_percpu zero-fills */
-			pptr = bpf_mem_cache_alloc(&htab->pcpu_ma);
-			if (!pptr) {
+			void *ptr = bpf_mem_cache_alloc(&htab->pcpu_ma);
+
+			if (!ptr) {
 				bpf_mem_cache_free(&htab->ma, l_new);
 				l_new = ERR_PTR(-ENOMEM);
 				goto dec_count;
 			}
-			l_new->ptr_to_pptr = pptr;
-			pptr = *(void **)pptr;
+			l_new->ptr_to_pptr = ptr;
+			pptr = *(void __percpu **)ptr;
 		}
 
 		pcpu_init_value(htab, pptr, value, onallcpus);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d02ae323996b..dd7529153146 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -715,7 +715,7 @@ BPF_CALL_2(bpf_per_cpu_ptr, const void *, ptr, u32, cpu)
 	if (cpu >= nr_cpu_ids)
 		return (unsigned long)NULL;
 
-	return (unsigned long)per_cpu_ptr((const void __percpu *)ptr, cpu);
+	return (unsigned long)per_cpu_ptr((const void __percpu *)(const uintptr_t)ptr, cpu);
 }
 
 const struct bpf_func_proto bpf_per_cpu_ptr_proto = {
@@ -728,7 +728,7 @@ const struct bpf_func_proto bpf_per_cpu_ptr_proto = {
 
 BPF_CALL_1(bpf_this_cpu_ptr, const void *, percpu_ptr)
 {
-	return (unsigned long)this_cpu_ptr((const void __percpu *)percpu_ptr);
+	return (unsigned long)this_cpu_ptr((const void __percpu *)(const uintptr_t)percpu_ptr);
 }
 
 const struct bpf_func_proto bpf_this_cpu_ptr_proto = {
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index dec892ded031..b3858a76e0b3 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -138,8 +138,8 @@ static struct llist_node notrace *__llist_del_first(struct llist_head *head)
 static void *__alloc(struct bpf_mem_cache *c, int node, gfp_t flags)
 {
 	if (c->percpu_size) {
-		void **obj = kmalloc_node(c->percpu_size, flags, node);
-		void *pptr = __alloc_percpu_gfp(c->unit_size, 8, flags);
+		void __percpu **obj = kmalloc_node(c->percpu_size, flags, node);
+		void __percpu *pptr = __alloc_percpu_gfp(c->unit_size, 8, flags);
 
 		if (!obj || !pptr) {
 			free_percpu(pptr);
@@ -253,7 +253,7 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node, bool atomic)
 static void free_one(void *obj, bool percpu)
 {
 	if (percpu) {
-		free_percpu(((void **)obj)[1]);
+		free_percpu(((void __percpu **)obj)[1]);
 		kfree(obj);
 		return;
 	}
@@ -509,8 +509,8 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
  */
 int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 {
-	struct bpf_mem_caches *cc, __percpu *pcc;
-	struct bpf_mem_cache *c, __percpu *pc;
+	struct bpf_mem_caches *cc; struct bpf_mem_caches __percpu *pcc;
+	struct bpf_mem_cache *c; struct bpf_mem_cache __percpu *pc;
 	struct obj_cgroup *objcg = NULL;
 	int cpu, i, unit_size, percpu_size = 0;
 
@@ -591,7 +591,7 @@ int bpf_mem_alloc_percpu_init(struct bpf_mem_alloc *ma, struct obj_cgroup *objcg
 
 int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size)
 {
-	struct bpf_mem_caches *cc, __percpu *pcc;
+	struct bpf_mem_caches *cc; struct bpf_mem_caches __percpu *pcc;
 	int cpu, i, unit_size, percpu_size;
 	struct obj_cgroup *objcg;
 	struct bpf_mem_cache *c;
-- 
2.46.0


