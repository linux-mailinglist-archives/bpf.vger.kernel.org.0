Return-Path: <bpf+bounces-69138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B28BB8DC03
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 15:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FB4B7B1862
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 13:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58732D8780;
	Sun, 21 Sep 2025 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrZJP9QZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C822D47FA;
	Sun, 21 Sep 2025 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758461508; cv=none; b=JhMJA0bdNOjK6R87Ty+Rinyfrm4H4CjCBST3nMZP0ReafAjL+hqUK1pEbkJyYLFR3f72avuAfa9A9dfF/7RLS45On3rAdizCz9UxaCWEwJo3ZfxBQLpKZx6bcyXErxSVWoTqO/zcYTtSuwdns1hOUaSAkqRT0JZctUKtz2iwtIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758461508; c=relaxed/simple;
	bh=go5+lXCzY3vTOZyXw9iwcGqbj77D+gp1tHTH19PZz20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xx8Z+sWxwKYDwGUOQYBSbBmZD+57Vc4ChKQKOyiMpOTIOatkRquOgJmA/I2wgZyagl8q0GlCzWwSNXu9oFluNQXuEWzzGoBD5GXIIPBP1SmqdacdmLj48kWbIOaERjrsLrjRqMwEH+OfqOFzazUq4eHjCzOt50WsZZEDmI8PwfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrZJP9QZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EFBC4CEF0;
	Sun, 21 Sep 2025 13:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758461507;
	bh=go5+lXCzY3vTOZyXw9iwcGqbj77D+gp1tHTH19PZz20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JrZJP9QZL5GjosGpMvDbjC8S+TDRpLx3LqGsSn2tt2+ALreg5Rh5iwkt0uo65ZmEA
	 /zfM8mM3j3Hrjsebkiu12jWwQCEtuVqXuzBblXrxRMuOQ8hvrKk+9OrXvoLe+LGWrx
	 9f9RPzyAz5fAPb4qY+NJcNvgE7fCVxdWZFBdhir3P2kq36ioqdlC0ntQhOkdguvawS
	 7naikD2JJKhcbjCjUBfiRnVsDTByPFEFt8YgaqZAT3CKJuPgFQq0RM4dfjhRTWyvLJ
	 +NpsSmzfiPxpWNSPYmlmt5a94su4zquvVLV3VpdrO8KEPZ4pDUVwsz8yL2Z9//lmz5
	 lr0xruLKLdP5Q==
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
Subject: [PATCH v5 04/12] libbpf: Support exclusive map creation
Date: Sun, 21 Sep 2025 15:31:25 +0200
Message-ID: <20250921133133.82062-5-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250921133133.82062-1-kpsingh@kernel.org>
References: <20250921133133.82062-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement setters and getters that allow map to be registered as
exclusive to the specified program. The registration should be done
before the exclusive program is loaded.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/lib/bpf/bpf.c      |  4 ++-
 tools/lib/bpf/bpf.h      |  5 ++-
 tools/lib/bpf/libbpf.c   | 69 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   | 22 +++++++++++++
 tools/lib/bpf/libbpf.map |  3 ++
 5 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index ab40dbf9f020..19ad7bcf0c2f 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -172,7 +172,7 @@ int bpf_map_create(enum bpf_map_type map_type,
 		   __u32 max_entries,
 		   const struct bpf_map_create_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, map_token_fd);
+	const size_t attr_sz = offsetofend(union bpf_attr, excl_prog_hash_size);
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
index 7252150e7ad3..e983a3e40d61 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -54,9 +54,12 @@ struct bpf_map_create_opts {
 	__s32 value_type_btf_obj_fd;
 
 	__u32 token_fd;
+
+	const void *excl_prog_hash;
+	__u32 excl_prog_hash_size;
 	size_t :0;
 };
-#define bpf_map_create_opts__last_field token_fd
+#define bpf_map_create_opts__last_field excl_prog_hash_size
 
 LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
 			      const char *map_name,
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a39640bd5448..5161c2b39875 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -499,6 +499,7 @@ struct bpf_program {
 	__u32 line_info_rec_size;
 	__u32 line_info_cnt;
 	__u32 prog_flags;
+	__u8  hash[SHA256_DIGEST_LENGTH];
 };
 
 struct bpf_struct_ops {
@@ -578,6 +579,7 @@ struct bpf_map {
 	bool autocreate;
 	bool autoattach;
 	__u64 map_extra;
+	struct bpf_program *excl_prog;
 };
 
 enum extern_type {
@@ -4488,6 +4490,44 @@ bpf_object__section_to_libbpf_map_type(const struct bpf_object *obj, int shndx)
 	}
 }
 
+static int bpf_prog_compute_hash(struct bpf_program *prog)
+{
+	struct bpf_insn *purged;
+	int i, err;
+
+	purged = calloc(prog->insns_cnt, BPF_INSN_SZ);
+	if (!purged)
+		return -ENOMEM;
+
+	/* If relocations have been done, the map_fd needs to be
+	 * discarded for the digest calculation.
+	 */
+	for (i = 0; i < prog->insns_cnt; i++) {
+		purged[i] = prog->insns[i];
+		if (purged[i].code == (BPF_LD | BPF_IMM | BPF_DW) &&
+		    (purged[i].src_reg == BPF_PSEUDO_MAP_FD ||
+		     purged[i].src_reg == BPF_PSEUDO_MAP_VALUE)) {
+			purged[i].imm = 0;
+			i++;
+			if (i >= prog->insns_cnt ||
+			    prog->insns[i].code != 0 ||
+			    prog->insns[i].dst_reg != 0 ||
+			    prog->insns[i].src_reg != 0 ||
+			    prog->insns[i].off != 0) {
+				err = -EINVAL;
+				goto out;
+			}
+			purged[i] = prog->insns[i];
+			purged[i].imm = 0;
+		}
+	}
+	err = libbpf_sha256(purged, prog->insns_cnt * sizeof(struct bpf_insn),
+			    prog->hash, SHA256_DIGEST_LENGTH);
+out:
+	free(purged);
+	return err;
+}
+
 static int bpf_program__record_reloc(struct bpf_program *prog,
 				     struct reloc_desc *reloc_desc,
 				     __u32 insn_idx, const char *sym_name,
@@ -5237,6 +5277,14 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 	create_attr.token_fd = obj->token_fd;
 	if (obj->token_fd)
 		create_attr.map_flags |= BPF_F_TOKEN_FD;
+	if (map->excl_prog) {
+		err = bpf_prog_compute_hash(map->excl_prog);
+		if (err)
+			return err;
+
+		create_attr.excl_prog_hash = map->excl_prog->hash;
+		create_attr.excl_prog_hash_size = SHA256_DIGEST_LENGTH;
+	}
 
 	if (bpf_map__is_struct_ops(map)) {
 		create_attr.btf_vmlinux_value_type_id = map->btf_vmlinux_value_type_id;
@@ -10527,6 +10575,27 @@ int bpf_map__set_inner_map_fd(struct bpf_map *map, int fd)
 	return 0;
 }
 
+int bpf_map__set_exclusive_program(struct bpf_map *map, struct bpf_program *prog)
+{
+	if (map_is_created(map)) {
+		pr_warn("exclusive programs must be set before map creation\n");
+		return libbpf_err(-EINVAL);
+	}
+
+	if (map->obj != prog->obj) {
+		pr_warn("excl_prog and map must be from the same bpf object\n");
+		return libbpf_err(-EINVAL);
+	}
+
+	map->excl_prog = prog;
+	return 0;
+}
+
+struct bpf_program *bpf_map__exclusive_program(struct bpf_map *map)
+{
+	return map->excl_prog;
+}
+
 static struct bpf_map *
 __bpf_map__iter(const struct bpf_map *m, const struct bpf_object *obj, int i)
 {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 2e91148d9b44..e978bc093c39 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1291,6 +1291,28 @@ LIBBPF_API int bpf_map__lookup_and_delete_elem(const struct bpf_map *map,
  */
 LIBBPF_API int bpf_map__get_next_key(const struct bpf_map *map,
 				     const void *cur_key, void *next_key, size_t key_sz);
+/**
+ * @brief **bpf_map__set_exclusive_program()** sets a map to be exclusive to the
+ * specified program. This must be called *before* the map is created.
+ *
+ * @param map BPF map to make exclusive.
+ * @param prog BPF program to be the exclusive user of the map. Must belong
+ * to the same bpf_object as the map.
+ * @return 0 on success; a negative error code otherwise.
+ *
+ * This function must be called after the BPF object is opened but before
+ * it is loaded. Once the object is loaded, only the specified program
+ * will be able to access the map's contents.
+ */
+LIBBPF_API int bpf_map__set_exclusive_program(struct bpf_map *map, struct bpf_program *prog);
+
+/**
+ * @brief **bpf_map__exclusive_program()** returns the exclusive program
+ * that is registered with the map (if any).
+ * @param map BPF map to which the exclusive program is registered.
+ * @return the registered exclusive program.
+ */
+LIBBPF_API struct bpf_program *bpf_map__exclusive_program(struct bpf_map *map);
 
 struct bpf_xdp_set_link_opts {
 	size_t sz;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index d7bd463e7017..8ed8749907d4 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -448,4 +448,7 @@ LIBBPF_1.6.0 {
 } LIBBPF_1.5.0;
 
 LIBBPF_1.7.0 {
+	global:
+		bpf_map__set_exclusive_program;
+		bpf_map__exclusive_program;
 } LIBBPF_1.6.0;
-- 
2.43.0


