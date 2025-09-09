Return-Path: <bpf+bounces-67888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 582B5B502B5
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 18:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B8034E1C8E
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 16:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB5233CEBE;
	Tue,  9 Sep 2025 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tKQ/dsuP"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41FC32CF76
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435566; cv=none; b=gHy7xIqE5YxayEdSdEPH8Nhwn8jUGk+7buf9rEaK+AJjYMgK04m224cgCSOw6UhLQHQW+OQRVj6ECKVUNv+mou9r65CQdDoAC4asLytYbNQI7BoVki2oWqvk++G8KAypVXPNzHJSgLIpjNr6A7D3Bxzfc40q6BQmZX4NsDRvjZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435566; c=relaxed/simple;
	bh=ciEY2PaVBYP+7hoGJMbRLn9kqFFWPM7A52v8VWueBtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PUsgDqc2Vb3CNteg5fUdtd9DjSTsLx3Z0huba8+BXldIYT0EeNNPCbxo4fY+icaVtwqZtqA7174YT+cHQGvar5mrJ07J6N/oUslOqP/m+N/cTr3nrUI08K41SYIQ47h/PEi3dIO/3fKiHlaUobWflmkYeWD60fTmFjDB/kHN3pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tKQ/dsuP; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757435561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x3f//JhIM3taFVtW9+tp/WXHFv05eY0uyCUPn/w7lIw=;
	b=tKQ/dsuPeVjJ66SlFP7V45ZhHxgWJXPh5qn4QPu1tJKL/ymhS7IFVW6Lj9anl8AneUNvpV
	wuSVTV9Ds6QANvdItGAuU4mJ3dEcFxkH+whL8zhNZxnfuvhJzRCZprnpxAIZvDICnfGZYp
	Dn3oHsw7ZDSgeVMc/0QSaDEJPFN98/E=
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
Subject: [PATCH bpf-next v2 1/2] bpf: Add lookup_and_delete_elem for BPF_MAP_STACK_TRACE
Date: Wed, 10 Sep 2025 00:32:21 +0800
Message-ID: <20250909163223.864120-1-chen.dylane@linux.dev>
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

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 8f6e87f0f3a..84a41c42495 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2703,7 +2703,7 @@ int bpf_percpu_hash_update(struct bpf_map *map, void *key, void *value,
 int bpf_percpu_array_update(struct bpf_map *map, void *key, void *value,
 			    u64 flags);
 
-int bpf_stackmap_copy(struct bpf_map *map, void *key, void *value);
+int bpf_stackmap_copy_and_delete(struct bpf_map *map, void *key, void *value, bool delete);
 
 int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
 				 void *key, void *value, u64 map_flags);
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 3615c06b7df..bb63a74db7b 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -646,7 +646,15 @@ static void *stack_map_lookup_elem(struct bpf_map *map, void *key)
 }
 
 /* Called from syscall */
-int bpf_stackmap_copy(struct bpf_map *map, void *key, void *value)
+static int stack_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
+					    void *value, u64 flags)
+{
+	return bpf_stackmap_copy_and_delete(map, key, value, true);
+}
+
+/* Called from syscall */
+int bpf_stackmap_copy_and_delete(struct bpf_map *map, void *key, void *value,
+				 bool delete)
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
index 0fbfa8532c3..d606d156c62 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -318,7 +318,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
 	} else if (map->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE) {
 		err = bpf_percpu_cgroup_storage_copy(map, key, value);
 	} else if (map->map_type == BPF_MAP_TYPE_STACK_TRACE) {
-		err = bpf_stackmap_copy(map, key, value);
+		err = bpf_stackmap_copy_and_delete(map, key, value, false);
 	} else if (IS_FD_ARRAY(map) || IS_FD_PROG_ARRAY(map)) {
 		err = bpf_fd_array_map_lookup_elem(map, key, value);
 	} else if (IS_FD_HASH(map)) {
@@ -1627,7 +1627,8 @@ struct bpf_map *bpf_map_inc_not_zero(struct bpf_map *map)
 }
 EXPORT_SYMBOL_GPL(bpf_map_inc_not_zero);
 
-int __weak bpf_stackmap_copy(struct bpf_map *map, void *key, void *value)
+int __weak bpf_stackmap_copy_and_delete(struct bpf_map *map, void *key, void *value,
+					bool delete)
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


