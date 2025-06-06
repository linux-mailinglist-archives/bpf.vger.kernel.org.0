Return-Path: <bpf+bounces-59971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 501C3AD0A46
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 01:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B183B06B9
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD9723FC6B;
	Fri,  6 Jun 2025 23:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+AbwPUY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F9523D2AC;
	Fri,  6 Jun 2025 23:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749252576; cv=none; b=mCf5iMc3rHGxUBmpAkzaaPjEk510CtdV3dLZcvhHDQ1kGJZ6UNH4P1/5ytdRdK4GLzYRl8BUxmaaiyXwLCIaHhHDzLhqEfKKjsW55AEozWhBVZ4hsP7N1kFTqe7FK8X83bVlfc6wUyGJMMjVSq3r+5r7V5t6CTrz6lZNn8YDmok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749252576; c=relaxed/simple;
	bh=4sjfI38kjc3em00fZ77tApMQym+r/4qYRjBSLJaimTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijyh+nJv5QTMBaVCMWesNmy0uMHaLgwjsUE4po5nB93jBBj4cw1YiLGifwlOS5R0CtWV3Hi0fP9/TIKXh4O4U8sL+K8Fhu7sWfedcmfdTbUms7gA6ELPEO7g/wo4cmdW2qmAmPljDvHE7f8Pfnc0nJtc1DeQl7OohCkrav0VgIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+AbwPUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01F9C4CEEB;
	Fri,  6 Jun 2025 23:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749252575;
	bh=4sjfI38kjc3em00fZ77tApMQym+r/4qYRjBSLJaimTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H+AbwPUYBb1nUzQubA0PVU6Rcm8o+oH268QUtmfre7xyDa8ljDprhB7V7Ox6qhPWT
	 b/gbHb8+jZUWNLgc0yPmGJxngMOleJ148TWP7vtPtvxQvRMoSetZ1PIt+Cc16zxMb1
	 mWB9hxFKr0hoY4bwqTiOqJw6nOapfICYzsCWqrPNwkHBEHEE7be8iCLJbitikIEJxk
	 hRSrbDEy1n4T5Z6+M86L1VjJQ8BEtesy68Jo46wcBp6Ro4bpSVoa32jo/P9/ONXn58
	 BkURX4QCFztlUBJMRkSDsDmISlCbquhilUL1hk9GlctWzfoq0XYgc7fn04TGV3+Mua
	 0QbBREajCG7Pw==
From: KP Singh <kpsingh@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: bboscaccy@linux.microsoft.com,
	paul@paul-moore.com,
	kys@microsoft.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH 07/12] bpf: Return hashes of maps in BPF_OBJ_GET_INFO_BY_FD
Date: Sat,  7 Jun 2025 01:29:09 +0200
Message-ID: <20250606232914.317094-8-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606232914.317094-1-kpsingh@kernel.org>
References: <20250606232914.317094-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently only array maps are supported, but the implementation can be
extended for other maps and objects. The hash is memoized only for
exclusive and frozen maps as their content is stable until the exclusive
program modifies the map.

This is required  for BPF signing, enabling a trusted loader program to
verify a map's integrity. The loader retrieves
the map's runtime hash from the kernel and compares it against an
expected hash computed at build time.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/bpf.h            |  3 +++
 include/uapi/linux/bpf.h       |  2 ++
 kernel/bpf/arraymap.c          | 13 ++++++++++++
 kernel/bpf/syscall.c           | 38 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  2 ++
 5 files changed, 58 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cb1bea99702a..35f1a633d87a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -7,6 +7,7 @@
 #include <uapi/linux/bpf.h>
 #include <uapi/linux/filter.h>
 
+#include <crypto/sha2.h>
 #include <linux/workqueue.h>
 #include <linux/file.h>
 #include <linux/percpu.h>
@@ -110,6 +111,7 @@ struct bpf_map_ops {
 	long (*map_pop_elem)(struct bpf_map *map, void *value);
 	long (*map_peek_elem)(struct bpf_map *map, void *value);
 	void *(*map_lookup_percpu_elem)(struct bpf_map *map, void *key, u32 cpu);
+	int (*map_get_hash)(struct bpf_map *map, u32 hash_buf_size, void *hash_buf);
 
 	/* funcs called by prog_array and perf_event_array map */
 	void *(*map_fd_get_ptr)(struct bpf_map *map, struct file *map_file,
@@ -262,6 +264,7 @@ struct bpf_list_node_kern {
 } __attribute__((aligned(8)));
 
 struct bpf_map {
+	u8 sha[SHA256_DIGEST_SIZE];
 	const struct bpf_map_ops *ops;
 	struct bpf_map *inner_map_meta;
 #ifdef CONFIG_SECURITY
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6f2f4f3b3822..ffd9e11befc2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6630,6 +6630,8 @@ struct bpf_map_info {
 	__u32 btf_value_type_id;
 	__u32 btf_vmlinux_id;
 	__u64 map_extra;
+	__aligned_u64 hash;
+	__u32 hash_size;
 } __attribute__((aligned(8)));
 
 struct bpf_btf_info {
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 8719aa821b63..1fb989db03a2 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -12,6 +12,7 @@
 #include <uapi/linux/btf.h>
 #include <linux/rcupdate_trace.h>
 #include <linux/btf_ids.h>
+#include <crypto/sha256_base.h>
 
 #include "map_in_map.h"
 
@@ -174,6 +175,17 @@ static void *array_map_lookup_elem(struct bpf_map *map, void *key)
 	return array->value + (u64)array->elem_size * (index & array->index_mask);
 }
 
+static int array_map_get_hash(struct bpf_map *map, u32 hash_buf_size,
+			       void *hash_buf)
+{
+	struct bpf_array *array = container_of(map, struct bpf_array, map);
+
+	bpf_sha256(array->value, (u64)array->elem_size * array->map.max_entries,
+	       hash_buf);
+	memcpy(array->map.sha, hash_buf, sizeof(array->map.sha));
+	return 0;
+}
+
 static int array_map_direct_value_addr(const struct bpf_map *map, u64 *imm,
 				       u32 off)
 {
@@ -805,6 +817,7 @@ const struct bpf_map_ops array_map_ops = {
 	.map_mem_usage = array_map_mem_usage,
 	.map_btf_id = &array_map_btf_ids[0],
 	.iter_seq_info = &iter_seq_info,
+	.map_get_hash = &array_map_get_hash,
 };
 
 const struct bpf_map_ops percpu_array_map_ops = {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index bef9edcfdb76..c81be07fa4fa 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2011-2014 PLUMgrid, http://plumgrid.com
  */
+#include <crypto/sha2.h>
 #include <linux/bpf.h>
 #include <linux/bpf-cgroup.h>
 #include <linux/bpf_trace.h>
@@ -5027,6 +5028,9 @@ static int bpf_map_get_info_by_fd(struct file *file,
 	info_len = min_t(u32, sizeof(info), info_len);
 
 	memset(&info, 0, sizeof(info));
+	if (copy_from_user(&info, uinfo, info_len))
+		return -EFAULT;
+
 	info.type = map->map_type;
 	info.id = map->id;
 	info.key_size = map->key_size;
@@ -5051,6 +5055,40 @@ static int bpf_map_get_info_by_fd(struct file *file,
 			return err;
 	}
 
+	if (map->ops->map_get_hash && map->frozen && map->excl_prog_sha) {
+		err = map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, &map->sha);
+		if (err != 0)
+			return err;
+	}
+
+	if (info.hash) {
+		char __user *uhash = u64_to_user_ptr(info.hash);
+
+		if (!map->ops->map_get_hash)
+			return -EINVAL;
+
+		if (info.hash_size < SHA256_DIGEST_SIZE)
+			return -EINVAL;
+
+		info.hash_size  = SHA256_DIGEST_SIZE;
+
+		if (map->excl_prog_sha && map->frozen) {
+			if (copy_to_user(uhash, map->sha, SHA256_DIGEST_SIZE) !=
+			    0)
+				return -EFAULT;
+		} else {
+			u8 sha[SHA256_DIGEST_SIZE];
+
+			err = map->ops->map_get_hash(map, SHA256_DIGEST_SIZE,
+						     sha);
+			if (err != 0)
+				return err;
+
+			if (copy_to_user(uhash, sha, SHA256_DIGEST_SIZE) != 0)
+				return -EFAULT;
+		}
+	}
+
 	if (copy_to_user(uinfo, &info, info_len) ||
 	    put_user(info_len, &uattr->info.info_len))
 		return -EFAULT;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6f2f4f3b3822..ffd9e11befc2 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6630,6 +6630,8 @@ struct bpf_map_info {
 	__u32 btf_value_type_id;
 	__u32 btf_vmlinux_id;
 	__u64 map_extra;
+	__aligned_u64 hash;
+	__u32 hash_size;
 } __attribute__((aligned(8)));
 
 struct bpf_btf_info {
-- 
2.43.0


