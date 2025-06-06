Return-Path: <bpf+bounces-59969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58D4AD0A44
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 01:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029BA3B3921
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 23:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4838723D290;
	Fri,  6 Jun 2025 23:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQZ1LYdE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10D223E34F;
	Fri,  6 Jun 2025 23:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749252571; cv=none; b=Ot7v6PVDUxJfaDIVQjTTJOHWNZ343RToqLTXHURZPJEElLVgaOWKgL/6GuIRYiioNIQYp93xPtYN+Ht3I+BIMRRrVMsnKPtCLrtVJicPsXimeYL2RFFPHYKIzA7Q+6HdY6mITktjBfOQjw7dF9m2uVPSP/IgKQmNyVCWGb9lX9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749252571; c=relaxed/simple;
	bh=KwauqSwYaL/Ke+T4V4C9C51vDkiamBgczwj5cC1CptY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AU04Q56lLVOO0aHXamldASZFBoM7/e6ApSS7idDtMBLGDr4QioxnQWYH3Psmk9BhFrZMtNMobNRbEWQaNGXPnSJq+nUGb7DYvJ5wGVUp4fw0wlrqAItsVnlbQHkYsYd/fI7Aad0LxNdpUiY0eE9HRPUz0GOwzRtvjxpfAK8aDg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQZ1LYdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76236C4CEF1;
	Fri,  6 Jun 2025 23:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749252571;
	bh=KwauqSwYaL/Ke+T4V4C9C51vDkiamBgczwj5cC1CptY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gQZ1LYdECw0cAlfj9GCPAJknCIQ7/g1dRVtSvbBLFWoYS97R+puJObdqnWFiriRCI
	 hQ+TlA3mlp7h1LAyAD8sJ/sUIIu9eukxzWG9lEpqLb6cWhC5WZQgwC03LXbw89nwZy
	 hCt2Vu/nL0HB77C/mRdcckVTzJfgH8RxRKIi+s+Wcit4x3Z/lFCjkID+Q/D/r0GgS6
	 p7zzTpZhSTA5ey0IlfLUHjVrjvgBsOd5mGQU50mNWEYtfK2DRanbgFO8sAd7NZQV3U
	 vrdqQeMaO5i7bS89s3L0K5szksGygZjNO9pq0JnGMErMiZMW1TC/4XOlfSMJdOswur
	 0zhlyoisr9w1Q==
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
Subject: [PATCH 05/12] libbpf: Support exclusive map creation
Date: Sat,  7 Jun 2025 01:29:07 +0200
Message-ID: <20250606232914.317094-6-kpsingh@kernel.org>
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

Implement a convenient method i.e. bpf_map__make_exclusive which
calculates the hash for the program and registers it with the map for
creation as an exclusive map when the objects are loaded.

The hash of the program must be computed after all the relocations are
done.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/lib/bpf/bpf.c            |  4 +-
 tools/lib/bpf/bpf.h            |  4 +-
 tools/lib/bpf/libbpf.c         | 68 +++++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf.h         | 13 +++++++
 tools/lib/bpf/libbpf.map       |  5 +++
 tools/lib/bpf/libbpf_version.h |  2 +-
 6 files changed, 92 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index a9c3e33d0f8a..11fa2d64ccca 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -172,7 +172,7 @@ int bpf_map_create(enum bpf_map_type map_type,
 		   __u32 max_entries,
 		   const struct bpf_map_create_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, map_token_fd);
+	const size_t attr_sz = offsetofend(union bpf_attr, excl_prog_hash);
 	union bpf_attr attr;
 	int fd;
 
@@ -203,6 +203,8 @@ int bpf_map_create(enum bpf_map_type map_type,
 	attr.map_ifindex = OPTS_GET(opts, map_ifindex, 0);
 
 	attr.map_token_fd = OPTS_GET(opts, token_fd, 0);
+	attr.excl_prog_hash = ptr_to_u64(OPTS_GET(opts, excl_prog_hash, NULL));
+	attr.excl_prog_hash_size = OPTS_GET(opts, excl_prog_hash_size, 0);
 
 	fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
 	return libbpf_err_errno(fd);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 777627d33d25..a82b79c0c349 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -54,9 +54,11 @@ struct bpf_map_create_opts {
 	__s32 value_type_btf_obj_fd;
 
 	__u32 token_fd;
+	__u32 excl_prog_hash_size;
+	const void *excl_prog_hash;
 	size_t :0;
 };
-#define bpf_map_create_opts__last_field token_fd
+#define bpf_map_create_opts__last_field excl_prog_hash
 
 LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
 			      const char *map_name,
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 475038d04cb4..17de756973f4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -499,6 +499,7 @@ struct bpf_program {
 	__u32 line_info_rec_size;
 	__u32 line_info_cnt;
 	__u32 prog_flags;
+	__u8  hash[SHA256_DIGEST_LENGTH];
 };
 
 struct bpf_struct_ops {
@@ -578,6 +579,8 @@ struct bpf_map {
 	bool autocreate;
 	bool autoattach;
 	__u64 map_extra;
+	const void *excl_prog_sha;
+	__u32 excl_prog_sha_size;
 };
 
 enum extern_type {
@@ -4485,6 +4488,43 @@ bpf_object__section_to_libbpf_map_type(const struct bpf_object *obj, int shndx)
 	}
 }
 
+static int bpf_program__compute_hash(struct bpf_program *prog)
+{
+	struct bpf_insn *purged;
+	bool was_ld_map;
+	int i, err;
+
+	purged = calloc(1, BPF_INSN_SZ * prog->insns_cnt);
+	if (!purged)
+		return -ENOMEM;
+
+	/* If relocations have been done, the map_fd needs to be
+	 * discarded for the digest calculation.
+	 */
+	for (i = 0, was_ld_map = false; i < prog->insns_cnt; i++) {
+		purged[i] = prog->insns[i];
+		if (!was_ld_map &&
+		    purged[i].code == (BPF_LD | BPF_IMM | BPF_DW) &&
+		    (purged[i].src_reg == BPF_PSEUDO_MAP_FD ||
+		     purged[i].src_reg == BPF_PSEUDO_MAP_VALUE)) {
+			was_ld_map = true;
+			purged[i].imm = 0;
+		} else if (was_ld_map && purged[i].code == 0 &&
+			   purged[i].dst_reg == 0 && purged[i].src_reg == 0 &&
+			   purged[i].off == 0) {
+			was_ld_map = false;
+			purged[i].imm = 0;
+		} else {
+			was_ld_map = false;
+		}
+	}
+	err = libbpf_sha256(purged,
+			    prog->insns_cnt * sizeof(struct bpf_insn),
+			    prog->hash);
+	free(purged);
+	return err;
+}
+
 static int bpf_program__record_reloc(struct bpf_program *prog,
 				     struct reloc_desc *reloc_desc,
 				     __u32 insn_idx, const char *sym_name,
@@ -5214,6 +5254,10 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 	create_attr.token_fd = obj->token_fd;
 	if (obj->token_fd)
 		create_attr.map_flags |= BPF_F_TOKEN_FD;
+	if (map->excl_prog_sha) {
+		create_attr.excl_prog_hash = map->excl_prog_sha;
+		create_attr.excl_prog_hash_size = map->excl_prog_sha_size;
+	}
 
 	if (bpf_map__is_struct_ops(map)) {
 		create_attr.btf_vmlinux_value_type_id = map->btf_vmlinux_value_type_id;
@@ -7933,6 +7977,11 @@ static int bpf_object_prepare_progs(struct bpf_object *obj)
 		err = bpf_object__sanitize_prog(obj, prog);
 		if (err)
 			return err;
+		/* Now that the instruction buffer is stable finalize the hash
+		 */
+		err = bpf_program__compute_hash(&obj->programs[i]);
+		if (err)
+			return err;
 	}
 	return 0;
 }
@@ -8602,8 +8651,8 @@ static int bpf_object_prepare(struct bpf_object *obj, const char *target_btf_pat
 	err = err ? : bpf_object_adjust_struct_ops_autoload(obj);
 	err = err ? : bpf_object__relocate(obj, obj->btf_custom_path ? : target_btf_path);
 	err = err ? : bpf_object__sanitize_and_load_btf(obj);
-	err = err ? : bpf_object__create_maps(obj);
 	err = err ? : bpf_object_prepare_progs(obj);
+	err = err ? : bpf_object__create_maps(obj);
 
 	if (err) {
 		bpf_object_unpin(obj);
@@ -10502,6 +10551,23 @@ int bpf_map__set_inner_map_fd(struct bpf_map *map, int fd)
 	return 0;
 }
 
+int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog)
+{
+	if (map_is_created(map)) {
+		pr_warn("%s must be called before creation\n", __func__);
+		return libbpf_err(-EINVAL);
+	}
+
+	if (prog->obj->state == OBJ_LOADED) {
+		pr_warn("%s must be called before the prog load\n", __func__);
+		return libbpf_err(-EINVAL);
+	}
+	map->excl_prog_sha = prog->hash;
+	map->excl_prog_sha_size = SHA256_DIGEST_LENGTH;
+	return 0;
+}
+
+
 static struct bpf_map *
 __bpf_map__iter(const struct bpf_map *m, const struct bpf_object *obj, int i)
 {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index d39f19c8396d..b6ee9870523a 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1249,6 +1249,19 @@ LIBBPF_API int bpf_map__lookup_and_delete_elem(const struct bpf_map *map,
  */
 LIBBPF_API int bpf_map__get_next_key(const struct bpf_map *map,
 				     const void *cur_key, void *next_key, size_t key_sz);
+/**
+ * @brief **bpf_map__make_exclusive()** makes the map exclusive to a single program.
+ * @param map BPF map to make exclusive.
+ * @param prog BPF program to be the exclusive user of the map.
+ * @return 0 on success; a negative error code otherwise.
+ *
+ * Once a map is made exclusive, only the specified program can access its
+ * contents. **bpf_map__make_exclusive** must be called before the objects are
+ * loaded.
+ */
+LIBBPF_API int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
+
+int bpf_map__make_exclusive(struct bpf_map *map, struct bpf_program *prog);
 
 struct bpf_xdp_set_link_opts {
 	size_t sz;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 1205f9a4fe04..67b1ff4202a1 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -444,3 +444,8 @@ LIBBPF_1.6.0 {
 		btf__add_decl_attr;
 		btf__add_type_attr;
 } LIBBPF_1.5.0;
+
+LIBBPF_1.7.0 {
+	global:
+		bpf_map__make_exclusive;
+} LIBBPF_1.6.0;
diff --git a/tools/lib/bpf/libbpf_version.h b/tools/lib/bpf/libbpf_version.h
index 28c58fb17250..99331e317dee 100644
--- a/tools/lib/bpf/libbpf_version.h
+++ b/tools/lib/bpf/libbpf_version.h
@@ -4,6 +4,6 @@
 #define __LIBBPF_VERSION_H
 
 #define LIBBPF_MAJOR_VERSION 1
-#define LIBBPF_MINOR_VERSION 6
+#define LIBBPF_MINOR_VERSION 7
 
 #endif /* __LIBBPF_VERSION_H */
-- 
2.43.0


