Return-Path: <bpf+bounces-63950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEEFB0CC6A
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 23:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F583AC74D
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 21:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790C924336B;
	Mon, 21 Jul 2025 21:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omVEeiPv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8403242D79;
	Mon, 21 Jul 2025 21:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753132820; cv=none; b=lnkRKjnZtTaGEomwi+rq9S1WyyjImLBRrazdFbb2etjx9jH6pTRdaQLcNUcGj1hvR4iNfXYcwtheeLKLooEZtnB9Uv5uLKvG4ErW4486DENwVmLiDU4aNJtNG/FynPIMBpQ9thaGmg6w2ZH1bm09r8AATEt9RrmFMIM5SoHgmgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753132820; c=relaxed/simple;
	bh=g7DeGqU1AeKshbWVTPDagvcmUjEhRhJkP3HAWuHwmNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXO7XwyFw6yo25ul02Mk2lYllaHB3ed5sU3zDKHJNSvlAKS2QF5pFzQZ+f682GOfoqIRN2xDIkD+mpM1DiAppmfcpDsisvB8Us8JPGgxj5a6G3yEEuLf2ETW57P1KfGZMbFMMFi+LTHYtYI3spCqx5jF3banfk77+f3kGWJIhBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omVEeiPv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B8DC4CEF7;
	Mon, 21 Jul 2025 21:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753132818;
	bh=g7DeGqU1AeKshbWVTPDagvcmUjEhRhJkP3HAWuHwmNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=omVEeiPv7f0HSBoDFJhkGpYgTnkab4Xjyn4fxXz94LtHoCOnIlDVeWNFq1q+lDSpw
	 HiWYoyA1m6OLcPn4PIgOpHKGROoKnSWFfVGTyXWiE3txY99jF0yZQVWR3roe6CJKmT
	 iNyVORy0J95ytCSUkf7aUZlioKlVw4faPPhKxtuWubMq9dvgz1fcv14I4hV7gBQwO5
	 zhzVVaTZQi5DpzZTyH0uvGdLRmHYCxMutB7kvw/gsZmWwxdorGD1szdSmndHLiUrmk
	 /NLQD54kmT2xG7XN/K/P5KoqGa/K4L/AxuP2KpdPIXnD3JUEdoHEfHWzvT0q/FoF5F
	 r0BmMCMqoEwyQ==
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
Subject: [PATCH v2 06/13] bpf: Return hashes of maps in BPF_OBJ_GET_INFO_BY_FD
Date: Mon, 21 Jul 2025 23:19:51 +0200
Message-ID: <20250721211958.1881379-7-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721211958.1881379-1-kpsingh@kernel.org>
References: <20250721211958.1881379-1-kpsingh@kernel.org>
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
 include/linux/bpf.h                           |  3 +++
 include/uapi/linux/bpf.h                      |  2 ++
 kernel/bpf/arraymap.c                         | 13 +++++++++++
 kernel/bpf/syscall.c                          | 23 +++++++++++++++++++
 tools/include/uapi/linux/bpf.h                |  2 ++
 .../selftests/bpf/progs/verifier_map_ptr.c    |  7 ++++--
 6 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f1b259517bd6..a0af63d56985 100644
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
index 7873ba7b9468..fd3b895ebebf 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6668,6 +6668,8 @@ struct bpf_map_info {
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
index 6ebcb7e4afbb..22fda92ab7ce 100644
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
@@ -5178,6 +5179,9 @@ static int bpf_map_get_info_by_fd(struct file *file,
 	info_len = min_t(u32, sizeof(info), info_len);
 
 	memset(&info, 0, sizeof(info));
+	if (copy_from_user(&info, uinfo, info_len))
+		return -EFAULT;
+
 	info.type = map->map_type;
 	info.id = map->id;
 	info.key_size = map->key_size;
@@ -5202,6 +5206,25 @@ static int bpf_map_get_info_by_fd(struct file *file,
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
index 7873ba7b9468..fd3b895ebebf 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6668,6 +6668,8 @@ struct bpf_map_info {
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


