Return-Path: <bpf+bounces-63948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69338B0CC64
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 23:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176D61AA594A
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 21:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB43A241C8C;
	Mon, 21 Jul 2025 21:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTGLhk4h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6116623E34C;
	Mon, 21 Jul 2025 21:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753132814; cv=none; b=l/afFtzWXscFzMqckOCjAMtGrvgFyI93ts9ys1zpRNiP86H1yxNPFOnqh/7y2Td1m2lqQIFwy8rcYYhjfT+fjkFEFbfKoC97CnPU7z6v108EuINZ1lvAxJF0UsuKaOsO2M7IWlyCrC+jgBGg1OfVmDNxFMKWJM/lfXPOG8lYigQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753132814; c=relaxed/simple;
	bh=zoUo7Shl2EJVVQCpcrGNFuPsWk6BJJJLa3x/PS4qALQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9LvsH3IoSly/ZVwX944m/wgyu+/bnDT3KZWvrCbL5QUjK+gT37PO1WPJD0IJtVK+yEvJr/Ac5kVchEux/wiqdi/RY12EpVk+w4SFoeB5ijU26SrYlYpQx3+o1zAjpOui72nsYra6xbsWyIowf9t04iK+tiQnXtnKEz8SefJuuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTGLhk4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C339C4CEF4;
	Mon, 21 Jul 2025 21:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753132814;
	bh=zoUo7Shl2EJVVQCpcrGNFuPsWk6BJJJLa3x/PS4qALQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mTGLhk4hvqTmsQoIE7Ex6Q+f1ISVm9d8PZcOpVCOPVWPrp/YYV/+Aj2u4rCqjuUoY
	 VNbm5INollajXPNWss265VAzpqLK5Iu4hBoAZCx6RuopElU3Nlf/RdSgFm2PkwFI5z
	 Z5Kb7NExqjUcsGORizjLVAlwDEYBFLehTEGerX6hIw0FyQeZyGHvJmLrIoIIFvKgWs
	 ae/UEdOqpq+aIXlkU9ujVyfJczY+0ejXruv9SIf2OEKpatInYeg7uyMhFZj8T1c6kn
	 zYov3FCbW0s7giuUXhziqtG+zefpDx6xhXEt2rYyPgNoXm8Wp3zEg0Ju1dxjZOXGVV
	 Mq6Kb4BTDmiug==
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
Subject: [PATCH v2 04/13] libbpf: Support exclusive map creation
Date: Mon, 21 Jul 2025 23:19:49 +0200
Message-ID: <20250721211958.1881379-5-kpsingh@kernel.org>
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

Implement setters and getters that allow map to be registers as
exclusive to the specified program. The registration should be done
before the exclusive program is loaded.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/lib/bpf/bpf.c      |  4 ++-
 tools/lib/bpf/bpf.h      |  4 ++-
 tools/lib/bpf/libbpf.c   | 66 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   | 18 +++++++++++
 tools/lib/bpf/libbpf.map |  2 ++
 5 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index ab40dbf9f020..6a08a1559237 100644
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
index 7252150e7ad3..675a09bb7d2f 100644
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
index 8b766dfa02bc..be142f96df66 100644
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
@@ -4488,6 +4490,43 @@ bpf_object__section_to_libbpf_map_type(const struct bpf_object *obj, int shndx)
 	}
 }
 
+static int bpf_program__compute_hash(struct bpf_program *prog)
+{
+	struct bpf_insn *purged;
+	int i, err;
+
+	purged = calloc(1, BPF_INSN_SZ * prog->insns_cnt);
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
+	err = libbpf_sha256(purged, prog->insns_cnt * sizeof(struct bpf_insn), prog->hash, SHA256_DIGEST_LENGTH);
+out:
+	free(purged);
+	return err;
+}
+
 static int bpf_program__record_reloc(struct bpf_program *prog,
 				     struct reloc_desc *reloc_desc,
 				     __u32 insn_idx, const char *sym_name,
@@ -5227,6 +5266,18 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 	create_attr.token_fd = obj->token_fd;
 	if (obj->token_fd)
 		create_attr.map_flags |= BPF_F_TOKEN_FD;
+	if (map->excl_prog) {
+		if (map->excl_prog->obj->state == OBJ_LOADED) {
+			pr_warn("exclusive program already loaded\n");
+			return libbpf_err(-EINVAL);
+		}
+		err = bpf_program__compute_hash(map->excl_prog);
+		if (err)
+			return err;
+
+		create_attr.excl_prog_hash = map->excl_prog->hash;
+		create_attr.excl_prog_hash_size = SHA256_DIGEST_LENGTH;
+	}
 
 	if (bpf_map__is_struct_ops(map)) {
 		create_attr.btf_vmlinux_value_type_id = map->btf_vmlinux_value_type_id;
@@ -10517,6 +10568,21 @@ int bpf_map__set_inner_map_fd(struct bpf_map *map, int fd)
 	return 0;
 }
 
+int bpf_map__set_exclusive_program(struct bpf_map *map, struct bpf_program *prog)
+{
+	if (map_is_created(map)) {
+		pr_warn("exclusive programs must be set before map creation\n");
+		return libbpf_err(-EINVAL);
+	}
+	map->excl_prog = prog;
+	return 0;
+}
+
+struct bpf_program *bpf_map__get_exclusive_program(struct bpf_map *map)
+{
+	return map->excl_prog;
+}
+
 static struct bpf_map *
 __bpf_map__iter(const struct bpf_map *m, const struct bpf_object *obj, int i)
 {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index d1cf813a057b..60552fa5401d 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1264,7 +1264,25 @@ LIBBPF_API int bpf_map__lookup_and_delete_elem(const struct bpf_map *map,
  */
 LIBBPF_API int bpf_map__get_next_key(const struct bpf_map *map,
 				     const void *cur_key, void *next_key, size_t key_sz);
+/**
+ * @brief **bpf_map__set_exclusive_program()** sets map to be exclusive to the
+ * to the specified program. The program must not be loaded yet.
+ * @param map BPF map to make exclusive.
+ * @param prog BPF program to be the exclusive user of the map.
+ * @return 0 on success; a negative error code otherwise.
+ *
+ * Once a map is made exclusive, only the specified program can access its
+ * contents.
+ */
+LIBBPF_API int bpf_map__set_exclusive_program(struct bpf_map *map, struct bpf_program *prog);
 
+/**
+ * @brief **bpf_map__get_exclusive_program()** returns the exclusive program
+ * that is registered with the map (if any).
+ * @param map BPF map to which the exclusive program is registered.
+ * @return the registered exclusive program.
+ */
+LIBBPF_API struct bpf_program *bpf_map__get_exclusive_program(struct bpf_map *map);
 struct bpf_xdp_set_link_opts {
 	size_t sz;
 	int old_fd;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index d7bd463e7017..a5c5d0f2db5c 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -436,6 +436,8 @@ LIBBPF_1.6.0 {
 		bpf_linker__add_buf;
 		bpf_linker__add_fd;
 		bpf_linker__new_fd;
+		bpf_map__set_exclusive_program;
+		bpf_map__get_exclusive_program;
 		bpf_object__prepare;
 		bpf_prog_stream_read;
 		bpf_program__attach_cgroup_opts;
-- 
2.43.0


