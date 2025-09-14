Return-Path: <bpf+bounces-68351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E19B56CAF
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 23:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A6C3BA9DB
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 21:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D702E7BDA;
	Sun, 14 Sep 2025 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQL81pN0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27903278E67;
	Sun, 14 Sep 2025 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757886727; cv=none; b=pOIheiOtLvexZzMQ3rir8px+3RCFPLeW45vlck/RfaFsgqrEKMXM3I7z8rQutJHIZr2kV3QjAyvf7ubM5fdUWBioNzxJlw2sgAvc7t65EMGbvDMb8fQLFPLVzNjBJYUXPBX3d3gZGyovFBdIiMVcuX9WFBy2RLhsViGpGwMoPso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757886727; c=relaxed/simple;
	bh=/0U9/qLDvJOuralgt0wcryFisGxmGwlrK1CFdCvUqFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5RBtTW9dtBqiwLED4dVZYv5fOnrXfjcNWoOsexPpSf8snb6QQsFrwqMd8aJh5cnsBWJeNCYIoRt8+lN1DxkwzTLkof3iN0Armxwfg15fhgxz3TtOEWugPWHN/7UVHqcFO5lnJhGL8fdMaa0Uqy7le1ts9UktUQM5XGBbJYdVO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQL81pN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3EDC4CEFB;
	Sun, 14 Sep 2025 21:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757886726;
	bh=/0U9/qLDvJOuralgt0wcryFisGxmGwlrK1CFdCvUqFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jQL81pN0BDB67AdcD50dpwZOBnHh4+/03kH4szJrD6nfF+/wiZ1f+4+o1YY9UAirv
	 jov1qUYoNVRos4iT0hfYEiXLWK+J5xUHxKK290JHdbxgQvZOFnQKxtEiEA+ICDvJ2H
	 o16lWHy23R95XzyJxRU2WLo/Ve0HY+me31fwMOaXDoVB9NyYYbsa0wsMpNUdy3eRim
	 CpvGp9dnj/fFxQ3Gixdb4n7zJMrghuaWjaSdJbk/g8gOLLPqe4wXYu4mpoZzDLJjkS
	 4dLQ2JehVfq3CS8puuL9A1hgoQ/emsA5Fa/brhGJKTW3A9Q7hoivJrd3ST5CFWnrAk
	 Ak1cGtmSAfN+Q==
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
Subject: [PATCH v4 06/12] bpf: Return hashes of maps in BPF_OBJ_GET_INFO_BY_FD
Date: Sun, 14 Sep 2025 23:51:35 +0200
Message-ID: <20250914215141.15144-7-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914215141.15144-1-kpsingh@kernel.org>
References: <20250914215141.15144-1-kpsingh@kernel.org>
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

This is required for BPF signing, enabling a trusted loader program to
verify a map's integrity. The loader retrieves
the map's runtime hash from the kernel and compares it against an
expected hash computed at build time.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/bpf.h                           |  3 +++
 include/uapi/linux/bpf.h                      |  2 ++
 kernel/bpf/arraymap.c                         | 13 +++++++++++
 kernel/bpf/syscall.c                          | 23 +++++++++++++++++++
 tools/include/uapi/linux/bpf.h                |  2 ++
 .../selftests/bpf/progs/verifier_map_ptr.c    |  7 ++++--
 6 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c6a6ee1b2938..e0c2c78a5faa 100644
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
@@ -289,6 +291,7 @@ struct bpf_map_owner {
 };
 
 struct bpf_map {
+	u8 sha[SHA256_DIGEST_SIZE];
 	const struct bpf_map_ops *ops;
 	struct bpf_map *inner_map_meta;
 #ifdef CONFIG_SECURITY
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 57687b2e1c47..0987b52d5648 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6672,6 +6672,8 @@ struct bpf_map_info {
 	__u32 btf_value_type_id;
 	__u32 btf_vmlinux_id;
 	__u64 map_extra;
+	__aligned_u64 hash;
+	__u32 hash_size;
 } __attribute__((aligned(8)));
 
 struct bpf_btf_info {
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 3d080916faf9..26d5dda989bc 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -12,6 +12,7 @@
 #include <uapi/linux/btf.h>
 #include <linux/rcupdate_trace.h>
 #include <linux/btf_ids.h>
+#include <crypto/sha2.h>
 
 #include "map_in_map.h"
 
@@ -174,6 +175,17 @@ static void *array_map_lookup_elem(struct bpf_map *map, void *key)
 	return array->value + (u64)array->elem_size * (index & array->index_mask);
 }
 
+static int array_map_get_hash(struct bpf_map *map, u32 hash_buf_size,
+			       void *hash_buf)
+{
+	struct bpf_array *array = container_of(map, struct bpf_array, map);
+
+	sha256(array->value, (u64)array->elem_size * array->map.max_entries,
+	       hash_buf);
+	memcpy(array->map.sha, hash_buf, sizeof(array->map.sha));
+	return 0;
+}
+
 static int array_map_direct_value_addr(const struct bpf_map *map, u64 *imm,
 				       u32 off)
 {
@@ -800,6 +812,7 @@ const struct bpf_map_ops array_map_ops = {
 	.map_mem_usage = array_map_mem_usage,
 	.map_btf_id = &array_map_btf_ids[0],
 	.iter_seq_info = &iter_seq_info,
+	.map_get_hash = &array_map_get_hash,
 };
 
 const struct bpf_map_ops percpu_array_map_ops = {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c8ef91acfe98..cf7173b1bb83 100644
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
@@ -5184,6 +5185,9 @@ static int bpf_map_get_info_by_fd(struct file *file,
 	info_len = min_t(u32, sizeof(info), info_len);
 
 	memset(&info, 0, sizeof(info));
+	if (copy_from_user(&info, uinfo, info_len))
+		return -EFAULT;
+
 	info.type = map->map_type;
 	info.id = map->id;
 	info.key_size = map->key_size;
@@ -5208,6 +5212,25 @@ static int bpf_map_get_info_by_fd(struct file *file,
 			return err;
 	}
 
+	if (info.hash) {
+		char __user *uhash = u64_to_user_ptr(info.hash);
+
+		if (!map->ops->map_get_hash)
+			return -EINVAL;
+
+		if (info.hash_size != SHA256_DIGEST_SIZE)
+			return -EINVAL;
+
+		err = map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, map->sha);
+		if (err != 0)
+			return err;
+
+		if (copy_to_user(uhash, map->sha, SHA256_DIGEST_SIZE) != 0)
+			return -EFAULT;
+	} else if (info.hash_size) {
+		return -EINVAL;
+	}
+
 	if (copy_to_user(uinfo, &info, info_len) ||
 	    put_user(info_len, &uattr->info.info_len))
 		return -EFAULT;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 57687b2e1c47..0987b52d5648 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6672,6 +6672,8 @@ struct bpf_map_info {
 	__u32 btf_value_type_id;
 	__u32 btf_vmlinux_id;
 	__u64 map_extra;
+	__aligned_u64 hash;
+	__u32 hash_size;
 } __attribute__((aligned(8)));
 
 struct bpf_btf_info {
diff --git a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
index 11a079145966..e2767d27d8aa 100644
--- a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
@@ -70,10 +70,13 @@ __naked void bpf_map_ptr_write_rejected(void)
 	: __clobber_all);
 }
 
+/* The first element of struct bpf_map is a SHA256 hash of 32 bytes, accessing
+ * into this array is valid. The opts field is now at offset 33.
+ */
 SEC("socket")
 __description("bpf_map_ptr: read non-existent field rejected")
 __failure
-__msg("cannot access ptr member ops with moff 0 in struct bpf_map with off 1 size 4")
+__msg("cannot access ptr member ops with moff 32 in struct bpf_map with off 33 size 4")
 __failure_unpriv
 __msg_unpriv("access is allowed only to CAP_PERFMON and CAP_SYS_ADMIN")
 __flag(BPF_F_ANY_ALIGNMENT)
@@ -82,7 +85,7 @@ __naked void read_non_existent_field_rejected(void)
 	asm volatile ("					\
 	r6 = 0;						\
 	r1 = %[map_array_48b] ll;			\
-	r6 = *(u32*)(r1 + 1);				\
+	r6 = *(u32*)(r1 + 33);				\
 	r0 = 1;						\
 	exit;						\
 "	:
-- 
2.43.0


