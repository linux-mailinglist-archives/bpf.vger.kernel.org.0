Return-Path: <bpf+bounces-59967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5C8AD0A40
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 01:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9013175680
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C114C23F412;
	Fri,  6 Jun 2025 23:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fs9RKHGq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BE4126C17;
	Fri,  6 Jun 2025 23:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749252567; cv=none; b=FLYXbu9FBZZA+k/IHoNecoIuu+2cEMUB/6qnYI5GVTakEhaD/TqWupKFO3YS8e6jk9veBKhuMtl7akFetZ07slK99MThemWN+pv5UoWoJFuRrq5lpJ2ixt1LnxEpBsWJKTYBSDfujYSu3itiTKTB0A8YUiFre+kZsoyiVEA6dZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749252567; c=relaxed/simple;
	bh=hjFnvKDERuqXcXXYIzfWUkQXOxY8vv67RJM8mtVR0FM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bIRYiM9+pDAiokfbVaEDpZQpy8vaNx+lsg0CH6Fg/iDFSWSzv0ZQJq9wG98tDQe1CVMRahnc8FveXeq/UfpBaFYUPDJkIJZbrduS2ANbkDWshubtEgopBgHg1TnzTbAaqEIUG32FwqJXOVMC0XA03XaufC2IP8V5p9CFIthc4aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fs9RKHGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF978C4CEEE;
	Fri,  6 Jun 2025 23:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749252566;
	bh=hjFnvKDERuqXcXXYIzfWUkQXOxY8vv67RJM8mtVR0FM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fs9RKHGq4lRNvILCIfzXMyWYKq7zHFwVLSNf1dL4OKIzuUgyb9TBEwH1nJgsytnF4
	 kv5hnskbcyrzGkx6WJSOkz72txycw7O1TKGlhtq4CdUCb2x8xXEg5Nb3cn7y45r/4S
	 QRFqv7XsNpAjOzxKJVWj3hdQ7jqjQ7NN70xOmiXNPm44n5pmFSYtyV0NoL35XFZuTs
	 wx+i0zaD40AGsEhSIMQeFSI5YBaEBccxqhd88EOL7qbdqppUT2IkowI8N/6hqp+qFy
	 AnVA2jyfNgQWe2PPQIQTl38GZTqAcz2xaAHyp6z7MzeRZyexsAxTz+Y1oO24hXSqsN
	 Gr+bex4eBHCOg==
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
Subject: [PATCH 03/12] bpf: Implement exclusive map creation
Date: Sat,  7 Jun 2025 01:29:05 +0200
Message-ID: <20250606232914.317094-4-kpsingh@kernel.org>
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

Exclusive maps allow maps to only be accessed by a trusted loader
program with a matching hash. This allows the trusted loader program
to load the map and verify the integrity.

Both maps of maps (array, hash) cannot be exclusive and exclusive maps
cannot be added as inner maps. This is because one would need to
guarantee the exclusivity of the inner maps and would require
significant changes in the verifier.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 include/linux/bpf.h            |  1 +
 include/uapi/linux/bpf.h       |  3 ++-
 kernel/bpf/arraymap.c          |  4 ++++
 kernel/bpf/hashtab.c           | 15 +++++++++------
 kernel/bpf/syscall.c           | 35 ++++++++++++++++++++++++++++++----
 kernel/bpf/verifier.c          |  7 +++++++
 tools/include/uapi/linux/bpf.h |  3 ++-
 7 files changed, 56 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 77d62c74a4e7..cb1bea99702a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -311,6 +311,7 @@ struct bpf_map {
 	bool free_after_rcu_gp;
 	atomic64_t sleepable_refcnt;
 	s64 __percpu *elem_count;
+	char *excl_prog_sha;
 };
 
 static inline const char *btf_field_type_name(enum btf_field_type type)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 16e95398c91c..6f2f4f3b3822 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1504,6 +1504,8 @@ union bpf_attr {
 		 * If provided, map_flags should have BPF_F_TOKEN_FD flag set.
 		 */
 		__s32	map_token_fd;
+		__u32 excl_prog_hash_size;
+		__aligned_u64 excl_prog_hash;
 	};
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM and BPF_MAP_FREEZE commands */
@@ -1841,7 +1843,6 @@ union bpf_attr {
 		__u32		flags;
 		__u32		bpffs_fd;
 	} token_create;
-
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index eb28c0f219ee..8719aa821b63 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -896,6 +896,10 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
 	if (IS_ERR(new_ptr))
 		return PTR_ERR(new_ptr);
 
+	if (map->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS &&
+		((struct bpf_map *)new_ptr)->excl_prog_sha)
+		return -EOPNOTSUPP;
+
 	if (map->ops->map_poke_run) {
 		mutex_lock(&array->aux->poke_mutex);
 		old_ptr = xchg(array->ptrs + index, new_ptr);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 71f9931ac64c..2732b4a23c27 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2537,22 +2537,25 @@ int bpf_fd_htab_map_lookup_elem(struct bpf_map *map, void *key, u32 *value)
 int bpf_fd_htab_map_update_elem(struct bpf_map *map, struct file *map_file,
 				void *key, void *value, u64 map_flags)
 {
-	void *ptr;
+	struct bpf_map *inner_map;
 	int ret;
 
-	ptr = map->ops->map_fd_get_ptr(map, map_file, *(int *)value);
-	if (IS_ERR(ptr))
-		return PTR_ERR(ptr);
+	inner_map = map->ops->map_fd_get_ptr(map, map_file, *(int *)value);
+	if (IS_ERR(inner_map))
+		return PTR_ERR(inner_map);
+
+	if (inner_map->excl_prog_sha)
+		return -EOPNOTSUPP;
 
 	/* The htab bucket lock is always held during update operations in fd
 	 * htab map, and the following rcu_read_lock() is only used to avoid
 	 * the WARN_ON_ONCE in htab_map_update_elem_in_place().
 	 */
 	rcu_read_lock();
-	ret = htab_map_update_elem_in_place(map, key, &ptr, map_flags, false, false);
+	ret = htab_map_update_elem_in_place(map, key, &inner_map, map_flags, false, false);
 	rcu_read_unlock();
 	if (ret)
-		map->ops->map_fd_put_ptr(map, ptr, false);
+		map->ops->map_fd_put_ptr(map, inner_map, false);
 
 	return ret;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4b5f29168618..bef9edcfdb76 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -858,6 +858,7 @@ static void bpf_map_free(struct bpf_map *map)
 	 * the free of values or special fields allocated from bpf memory
 	 * allocator.
 	 */
+	kfree(map->excl_prog_sha);
 	migrate_disable();
 	map->ops->map_free(map);
 	migrate_enable();
@@ -1335,9 +1336,9 @@ static bool bpf_net_capable(void)
 	return capable(CAP_NET_ADMIN) || capable(CAP_SYS_ADMIN);
 }
 
-#define BPF_MAP_CREATE_LAST_FIELD map_token_fd
+#define BPF_MAP_CREATE_LAST_FIELD excl_prog_hash
 /* called via syscall */
-static int map_create(union bpf_attr *attr, bool kernel)
+static int map_create(union bpf_attr *attr, bpfptr_t uattr)
 {
 	const struct bpf_map_ops *ops;
 	struct bpf_token *token = NULL;
@@ -1527,7 +1528,33 @@ static int map_create(union bpf_attr *attr, bool kernel)
 			attr->btf_vmlinux_value_type_id;
 	}
 
-	err = security_bpf_map_create(map, attr, token, kernel);
+	if (attr->excl_prog_hash) {
+		bpfptr_t uprog_hash = make_bpfptr(attr->excl_prog_hash, uattr.is_kernel);
+
+		if (map->inner_map_meta) {
+			err = -EOPNOTSUPP;
+			goto free_map;
+		}
+
+		map->excl_prog_sha = kzalloc(SHA256_DIGEST_SIZE, GFP_KERNEL);
+		if (!map->excl_prog_sha) {
+			err = -EINVAL;
+			goto free_map;
+		}
+
+		if (attr->excl_prog_hash_size < SHA256_DIGEST_SIZE) {
+			err = -EINVAL;
+			goto free_map;
+		}
+
+		if (copy_from_bpfptr(map->excl_prog_sha, uprog_hash,
+				     SHA256_DIGEST_SIZE)) {
+			err = -EFAULT;
+			goto free_map;
+		}
+	}
+
+	err = security_bpf_map_create(map, attr, token, uattr.is_kernel);
 	if (err)
 		goto free_map_sec;
 
@@ -5815,7 +5842,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int size)
 
 	switch (cmd) {
 	case BPF_MAP_CREATE:
-		err = map_create(&attr, uattr.is_kernel);
+		err = map_create(&attr, uattr);
 		break;
 	case BPF_MAP_LOOKUP_ELEM:
 		err = map_lookup_elem(&attr);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d5807d2efc92..15fdd63bdcf9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19943,6 +19943,12 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(prog);
 
+	if (map->excl_prog_sha &&
+	    memcmp(map->excl_prog_sha, prog->digest, SHA256_DIGEST_SIZE)) {
+		verbose(env, "exclusive map access denied\n");
+		return -EACCES;
+	}
+
 	if (btf_record_has_field(map->record, BPF_LIST_HEAD) ||
 	    btf_record_has_field(map->record, BPF_RB_ROOT)) {
 		if (is_tracing_prog_type(prog_type)) {
@@ -20051,6 +20057,7 @@ static int __add_used_map(struct bpf_verifier_env *env, struct bpf_map *map)
 {
 	int i, err;
 
+	/* check if the map is used already*/
 	/* check whether we recorded this map already */
 	for (i = 0; i < env->used_map_cnt; i++)
 		if (env->used_maps[i] == map)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 16e95398c91c..6f2f4f3b3822 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1504,6 +1504,8 @@ union bpf_attr {
 		 * If provided, map_flags should have BPF_F_TOKEN_FD flag set.
 		 */
 		__s32	map_token_fd;
+		__u32 excl_prog_hash_size;
+		__aligned_u64 excl_prog_hash;
 	};
 
 	struct { /* anonymous struct used by BPF_MAP_*_ELEM and BPF_MAP_FREEZE commands */
@@ -1841,7 +1843,6 @@ union bpf_attr {
 		__u32		flags;
 		__u32		bpffs_fd;
 	} token_create;
-
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
-- 
2.43.0


