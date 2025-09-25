Return-Path: <bpf+bounces-69758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBF2BA0F24
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 19:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606AF4A1F87
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 17:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC9330FF36;
	Thu, 25 Sep 2025 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iGYsq72Z"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3D2306B04
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758822658; cv=none; b=eCpMDoWeXUJbdEQWyJosde1NvWdH+VNzHUDiyY/M4yI8sNElhEEw7da3y7XoPlnoFpCyYxhR5vJSGyhpPhgcHBuGfysj8V0qXNM35eC9l8S6klO/s7nSk3Om0596qBIJhPrBVWw32zHh89hW3Ko9P8kH6v2OQth0jo5txOao8+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758822658; c=relaxed/simple;
	bh=UcYOwcfZzoxRB6iU58p1ZdJnlHqXUjyDBVbjpgw5eHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nqv1rwNVMGEf780qbffZtXgCtfm5bXoOhWdtMWs6dQP/eWCNP72aU90LkDTY7J5ICcvvsp43yUUSGLSdeQDWNapKrbKXgOihUl0imeXFPn/8/ZEOh1oRwlK3qIBoDalfWnZAzAfkaKZoE+BxCOqg47eIXm8ZT7N/qHYrLc//Iqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iGYsq72Z; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758822654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cYQd1md66vM9s37F/zYjAlS0nJTxCwUjUbLiFwAr/NI=;
	b=iGYsq72ZICPOW7GAWCEyMc/Lhu5u+CcFepkbnciKTSbsEG3emi5+nnVfuzqfgc7RfDUR7Z
	qjQL/Nde0uri49jaed/XMOcq5WkSCHBZnvY2+uJ3tc/FKmovkmYuHFZm5VSleY8Rv3KXB9
	FMm9a4rYxFBpOf08RKSi6BskMXzjevE=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v6 1/3] bpf: Add lookup_and_delete_elem for BPF_MAP_STACK_TRACE
Date: Fri, 26 Sep 2025 01:50:28 +0800
Message-ID: <20250925175030.1615837-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The stacktrace map can be easily full, which will lead to failure in
obtaining the stack. In addition to increasing the size of the map,
another solution is to delete the stack_id after looking it up from
the user, so extend the existing bpf_map_lookup_and_delete_elem()
functionality to stacktrace map types.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 include/linux/bpf.h   |  2 +-
 kernel/bpf/stackmap.c | 16 ++++++++++++++--
 kernel/bpf/syscall.c  |  8 +++++---
 3 files changed, 20 insertions(+), 6 deletions(-)

Change list:
 v1 -> v2:
  - typo s/detele/delete/.(Jiri)
  - make sure following lookup fails after deleting the stack_id with NOENT.(Jiri)
  - use '&key' directly as the update value.(Jiri)
  v1: https://lore.kernel.org/bpf/20250908113622.810652-1-chen.dylane@linux.dev
 v2 -> v3:
  - rename bpf_stackmap_copy_and_delete with bpf_stackmap_extract.(Andrii)
  v2: https://lore.kernel.org/bpf/20250909163223.864120-1-chen.dylane@linux.dev
 v3 -> v4:
  - describe what the test is for in commit message.(Leon)
  - 'val_buf' should stay on a single line.(Leon)
  v3: https://lore.kernel.org/bpf/20250920155211.1354348-1-chen.dylane@linux.dev
 v4 -> v5:
  - refactor stacktrace_map with skeleton in patch2.(Andrii)
  - replace CHECK*() with ASSERT_xx() and just check err from bpf_map_lookup_elem
    only.(Andrii)
  v4: https://lore.kernel.org/bpf/20250922140317.1468691-1-chen.dylane@linux.dev
 v5 -> v6:
  - fix test_stacktrace_map_raw_tp fail.(Daniel)
  v5: https://lore.kernel.org/bpf/20250923165849.1524622-1-chen.dylane@linux.dev

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8f6e87f0f3a..9d6f7671ba1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2703,7 +2703,7 @@ int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
 int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 			    u64 flags);
 
-int bpf_stackmap_copy(struct bpf_map *map, void *key, void *value);
+int bpf_stackmap_extract(struct bpf_map *map, void *key, void *value, bool delete);
 
 int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
 				 void *key, void *value, u64 map_flags);
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 3615c06b7df..2e182a3ac4c 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -646,7 +646,15 @@ static void *stack_map_lookup_elem(struct bpf_map *map, void *key)
 }
 
 /* Called from syscall */
-int bpf_stackmap_copy(struct bpf_map *map, void *key, void *value)
+static int stack_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
+					    void *value, u64 flags)
+{
+	return bpf_stackmap_extract(map, key, value, true);
+}
+
+/* Called from syscall */
+int bpf_stackmap_extract(struct bpf_map *map, void *key, void *value,
+			 bool delete)
 {
 	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
 	struct stack_map_bucket *bucket, *old_bucket;
@@ -663,7 +671,10 @@ int bpf_stackmap_copy(struct bpf_map *map, void *key, void *value)
 	memcpy(value, bucket->data, trace_len);
 	memset(value + trace_len, 0, map->value_size - trace_len);
 
-	old_bucket = xchg(&smap->buckets[id], bucket);
+	if (delete)
+		old_bucket = bucket;
+	else
+		old_bucket = xchg(&smap->buckets[id], bucket);
 	if (old_bucket)
 		pcpu_freelist_push(&smap->freelist, &old_bucket->fnode);
 	return 0;
@@ -754,6 +765,7 @@ const struct bpf_map_ops stack_trace_map_ops = {
 	.map_free = stack_map_free,
 	.map_get_next_key = stack_map_get_next_key,
 	.map_lookup_elem = stack_map_lookup_elem,
+	.map_lookup_and_delete_elem = stack_map_lookup_and_delete_elem,
 	.map_update_elem = stack_map_update_elem,
 	.map_delete_elem = stack_map_delete_elem,
 	.map_check_btf = map_check_no_btf,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0fbfa8532c3..c380a2576fc 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -318,7 +318,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
 		err = bpf_percpu_cgroup_storage_copy(map, key, value);
 	} else if (map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
-		err = bpf_stackmap_copy(map, key, value);
+		err = bpf_stackmap_extract(map, key, value, false);
 	} else if (IS_FD_ARRAY(map) || IS_FD_PROG_ARRAY(map)) {
 		err = bpf_fd_array_map_lookup_elem(map, key, value);
 	} else if (IS_FD_HASH(map)) {
@@ -1627,7 +1627,8 @@ struct bpf_map *bpf_map_inc_not_zero(struct bpf_map *map)
 }
 EXPORT_SYMBOL_GPL(bpf_map_inc_not_zero);
 
-int __weak bpf_stackmap_copy(struct bpf_map *map, void *key, void *value)
+int __weak bpf_stackmap_extract(struct bpf_map *map, void *key, void *value,
+				bool delete)
 {
 	return -ENOTSUPP;
 }
@@ -2158,7 +2159,8 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
 	} else if (map->map_type == BPF_MAP_TYPE_HASH ||
 		   map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 		   map->map_type == BPF_MAP_TYPE_LRU_HASH ||
-		   map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
+		   map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+		   map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
 		if (!bpf_map_is_offloaded(map)) {
 			bpf_disable_instrumentation();
 			rcu_read_lock();
-- 
2.48.1


