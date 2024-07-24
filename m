Return-Path: <bpf+bounces-35575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 583A293B94F
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 00:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB79E1F2451E
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 22:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81F413D8A8;
	Wed, 24 Jul 2024 22:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGDkWmUr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C2013C683
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 22:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721861560; cv=none; b=G9LptMyoDgkMw8j9gqqoCB3sMhbmKag0PuISVS3GBhKw2gGnXpyPsIm4RpZKs+5ohav7rhKW9zt0kkb/O5ka5oXQ7gBOm/F+s5aYtKsrUFU1Zu1AFH+9IqGc8xNub5K6jOleilUH7PiQ8veln9/gSB8QFN11m9prESGgwWt1l+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721861560; c=relaxed/simple;
	bh=kcQeVuVwnIJJkBHc/ynMBCpPQQtY5kY6QBTEhCYYFCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GH5Z5KzV1FuytIL+MwEsl6N1atl6LV4VJS41kzc02S4LcUYqdVZxhAzPiZkS7Ej81aCSP37PldDsdkV/cARuoVO+aWeNRvtIEcyG26U0kSpj3Sz5QGPO9sRbR4O6bSeHOTICiO3Pkl0F0cNNHVLqZCvcTl0sIIr3hDz18WPJ0Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGDkWmUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9582C4AF0B;
	Wed, 24 Jul 2024 22:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721861560;
	bh=kcQeVuVwnIJJkBHc/ynMBCpPQQtY5kY6QBTEhCYYFCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BGDkWmUrnZuRcU338NjBL7jISkv1hnIqu7EmRZtJYWqjfuNTDFVhavENhOlvKQQSC
	 htiPnRUx56FVGLy6y9FmD0Mg9cXTodSpvRBXVhd9VbCcimJEMqZgr8XsaMut99P4EW
	 4O4k1eFKlMHBPhHkhHGx0nzwefPziyBydQetHHkbo5UjUelJlYxKHkwAK76DqlRH/A
	 d7jK6YSLVcsQ37iktrEAyy9ZPcna3kEuhe9qqjN7Pw+EQtJF1vH5ZEE7sUzEKu0q8C
	 l7GXLqDK7VXlh/YLNPFlW9fsLME0ruLo2ZVLvLoQy8qtAiJNmK4Sp92LI88/xdPMFc
	 USYEDfusZiTQQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	adobriyan@gmail.com,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	ak@linux.intel.com,
	osandov@osandov.com,
	song@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 bpf-next 08/10] bpf: decouple stack_map_get_build_id_offset() from perf_callchain_entry
Date: Wed, 24 Jul 2024 15:52:08 -0700
Message-ID: <20240724225210.545423-9-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240724225210.545423-1-andrii@kernel.org>
References: <20240724225210.545423-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change stack_map_get_build_id_offset() which is used to convert stack
trace IP addresses into build ID+offset pairs. Right now this function
accepts an array of u64s as an input, and uses array of
struct bpf_stack_build_id as an output.

This is problematic because u64 array is coming from
perf_callchain_entry, which is (non-sleepable) RCU protected, so once we
allows sleepable build ID fetching, this all breaks down.

But its actually pretty easy to make stack_map_get_build_id_offset()
works with array of struct bpf_stack_build_id as both input and output.
Which is what this patch is doing, eliminating the dependency on
perf_callchain_entry. We require caller to fill out
bpf_stack_build_id.ip fields (all other can be left uninitialized), and
update in place as we do build ID resolution.

We make sure to READ_ONCE() and cache locally current IP value as we
used it in a few places to find matching VMA and so on. Given this data
is directly accessible and modifiable by user's BPF code, we should make
sure to have a consistent view of it.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/stackmap.c | 49 +++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 770ae8e88016..6457222b0b46 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -124,8 +124,18 @@ static struct bpf_map *stack_map_alloc(union bpf_attr *attr)
 	return ERR_PTR(err);
 }
 
+/*
+ * Expects all id_offs[i].ip values to be set to correct initial IPs.
+ * They will be subsequently:
+ *   - either adjusted in place to a file offset, if build ID fetching
+ *     succeeds; in this case id_offs[i].build_id is set to correct build ID,
+ *     and id_offs[i].status is set to BPF_STACK_BUILD_ID_VALID;
+ *   - or IP will be kept intact, if build ID fetching failed; in this case
+ *     id_offs[i].build_id is zeroed out and id_offs[i].status is set to
+ *     BPF_STACK_BUILD_ID_IP.
+ */
 static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
-					  u64 *ips, u32 trace_nr, bool user)
+					  u32 trace_nr, bool user)
 {
 	int i;
 	struct mmap_unlock_irq_work *work = NULL;
@@ -142,30 +152,28 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 		/* cannot access current->mm, fall back to ips */
 		for (i = 0; i < trace_nr; i++) {
 			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
-			id_offs[i].ip = ips[i];
 			memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
 		}
 		return;
 	}
 
 	for (i = 0; i < trace_nr; i++) {
-		if (range_in_vma(prev_vma, ips[i], ips[i])) {
+		u64 ip = READ_ONCE(id_offs[i].ip);
+
+		if (range_in_vma(prev_vma, ip, ip)) {
 			vma = prev_vma;
-			memcpy(id_offs[i].build_id, prev_build_id,
-			       BUILD_ID_SIZE_MAX);
+			memcpy(id_offs[i].build_id, prev_build_id, BUILD_ID_SIZE_MAX);
 			goto build_id_valid;
 		}
-		vma = find_vma(current->mm, ips[i]);
+		vma = find_vma(current->mm, ip);
 		if (!vma || build_id_parse_nofault(vma, id_offs[i].build_id, NULL)) {
 			/* per entry fall back to ips */
 			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
-			id_offs[i].ip = ips[i];
 			memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
 			continue;
 		}
 build_id_valid:
-		id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + ips[i]
-			- vma->vm_start;
+		id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + ip - vma->vm_start;
 		id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
 		prev_vma = vma;
 		prev_build_id = id_offs[i].build_id;
@@ -216,7 +224,7 @@ static long __bpf_get_stackid(struct bpf_map *map,
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
 	struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
 	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
-	u32 hash, id, trace_nr, trace_len;
+	u32 hash, id, trace_nr, trace_len, i;
 	bool user = flags & BPF_F_USER_STACK;
 	u64 *ips;
 	bool hash_matches;
@@ -238,15 +246,18 @@ static long __bpf_get_stackid(struct bpf_map *map,
 		return id;
 
 	if (stack_map_use_build_id(map)) {
+		struct bpf_stack_build_id *id_offs;
+
 		/* for build_id+offset, pop a bucket before slow cmp */
 		new_bucket = (struct stack_map_bucket *)
 			pcpu_freelist_pop(&smap->freelist);
 		if (unlikely(!new_bucket))
 			return -ENOMEM;
 		new_bucket->nr = trace_nr;
-		stack_map_get_build_id_offset(
-			(struct bpf_stack_build_id *)new_bucket->data,
-			ips, trace_nr, user);
+		id_offs = (struct bpf_stack_build_id *)new_bucket->data;
+		for (i = 0; i < trace_nr; i++)
+			id_offs[i].ip = ips[i];
+		stack_map_get_build_id_offset(id_offs, trace_nr, user);
 		trace_len = trace_nr * sizeof(struct bpf_stack_build_id);
 		if (hash_matches && bucket->nr == trace_nr &&
 		    memcmp(bucket->data, new_bucket->data, trace_len) == 0) {
@@ -445,10 +456,16 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	copy_len = trace_nr * elem_size;
 
 	ips = trace->ip + skip;
-	if (user && user_build_id)
-		stack_map_get_build_id_offset(buf, ips, trace_nr, user);
-	else
+	if (user && user_build_id) {
+		struct bpf_stack_build_id *id_offs = buf;
+		u32 i;
+
+		for (i = 0; i < trace_nr; i++)
+			id_offs[i].ip = ips[i];
+		stack_map_get_build_id_offset(buf, trace_nr, user);
+	} else {
 		memcpy(buf, ips, copy_len);
+	}
 
 	if (size > copy_len)
 		memset(buf + copy_len, 0, size - copy_len);
-- 
2.43.0


