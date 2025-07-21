Return-Path: <bpf+bounces-63954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0978FB0CC72
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 23:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C222542952
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 21:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856F3245007;
	Mon, 21 Jul 2025 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh3RVLuQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB752405E8;
	Mon, 21 Jul 2025 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753132828; cv=none; b=et8KEP8jlRF3h0xYWelJq7Y7r4xTXE6LbpNkDK1a83zGfW5EQEU/1CZnX7CiPMcdDp8KDyoXNjge5w5XYZrW05+rOWSvJt907U4YvfJQ3PQlfhTKHtJg9GDNTb0SjiJK6ttH0l8VTrKAZ7jt+OzOXQ6XGhYNuj+iTfPc1qj1LG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753132828; c=relaxed/simple;
	bh=6CSVXHc/X9g5p0ye/75j6MYxYzzPLsaJ8l35HU2uboQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=log5KSIHKuSU76sXkxcQXLaFSgxS7jd35QHtToDB/8713Z1zEZ/aCvHxjROs5OOn5o7TZpeaK9jSzibyZutFRFSKa7/SrgMaQtGmvCgbxggbrq/vuZYolfpQvAOASSfvBBJJSsbzGLE+WZPvk98xxcuNPJuduvma9KpS17904jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh3RVLuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC31C4CEED;
	Mon, 21 Jul 2025 21:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753132827;
	bh=6CSVXHc/X9g5p0ye/75j6MYxYzzPLsaJ8l35HU2uboQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dh3RVLuQ/+2/qsnLz4dJpj4lqfmYB53oeLK9cJ4fZAZYqAxXyekNELqxd2pHJDwx3
	 qzYWWjKBorgDbHStMcilagwCry6NJ5O+B6aR3cBggkDpkTeRBOZl9VNtw6SVG3xEqi
	 kZG7/cKT46JjIfhwopnM0MdL30afRroDPH6GX86m5mSYo4Xct/U1zZtMJ1xKw4ma0/
	 Fir/8H86Q6hiBf2TUqlZAR54n8heo0QjFLgaYXDcatb5jr+ki/Fyx0ux+1lldbiQ9k
	 FoKcMF570BulZGy7TWDdXZp+RcgMMb7MDvs8nTohtIlroCNLt50nZn2wpE7LaQQ0Y5
	 z6dM4xUsqQ6Mg==
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
Subject: [PATCH v2 10/13] libbpf: Embed and verify the metadata hash in the loader
Date: Mon, 21 Jul 2025 23:19:55 +0200
Message-ID: <20250721211958.1881379-11-kpsingh@kernel.org>
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

To fulfill the BPF signing contract, represented as Sig(I_loader ||
H_meta), the generated trusted loader program must verify the integrity
of the metadata. This signature cryptographically binds the loader's
instructions (I_loader) to a hash of the metadata (H_meta).

The verification process is embedded directly into the loader program.
Upon execution, the loader loads the runtime hash from struct bpf_map
i.e. BPF_PSEUDO_MAP_IDX and compares this runtime hash against an
expected hash value that has been hardcoded directly by
bpf_obj__gen_loader.

The load from bpf_map can be improved by calling
BPF_OBJ_GET_INFO_BY_FD from the kernel context after BPF_OBJ_GET_INFO_BY_FD
has been updated for being called from the kernel context.

The following instructions are generated:

    ld_imm64 r1, const_ptr_to_map // insn[0].src_reg == BPF_PSEUDO_MAP_IDX
    r2 = *(u64 *)(r1 + 0);
    ld_imm64 r3, sha256_of_map_part1 // constant precomputed by
bpftool (part of H_meta)
    if r2 != r3 goto out;

    r2 = *(u64 *)(r1 + 8);
    ld_imm64 r3, sha256_of_map_part2 // (part of H_meta)
    if r2 != r3 goto out;

    r2 = *(u64 *)(r1 + 16);
    ld_imm64 r3, sha256_of_map_part3 // (part of H_meta)
    if r2 != r3 goto out;

    r2 = *(u64 *)(r1 + 24);
    ld_imm64 r3, sha256_of_map_part4 // (part of H_meta)
    if r2 != r3 goto out;
    ...

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/lib/bpf/bpf_gen_internal.h |  2 ++
 tools/lib/bpf/gen_loader.c       | 55 ++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h           |  3 +-
 3 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf_gen_internal.h b/tools/lib/bpf/bpf_gen_internal.h
index 6ff963a491d9..49af4260b8e6 100644
--- a/tools/lib/bpf/bpf_gen_internal.h
+++ b/tools/lib/bpf/bpf_gen_internal.h
@@ -4,6 +4,7 @@
 #define __BPF_GEN_INTERNAL_H
 
 #include "bpf.h"
+#include "libbpf_internal.h"
 
 struct ksym_relo_desc {
 	const char *name;
@@ -50,6 +51,7 @@ struct bpf_gen {
 	__u32 nr_ksyms;
 	int fd_array;
 	int nr_fd_array;
+	int hash_insn_offset[SHA256_DWORD_SIZE];
 };
 
 void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps);
diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
index 113ae4abd345..8eba7c1514ef 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -110,6 +110,7 @@ static void emit2(struct bpf_gen *gen, struct bpf_insn insn1, struct bpf_insn in
 
 static int add_data(struct bpf_gen *gen, const void *data, __u32 size);
 static void emit_sys_close_blob(struct bpf_gen *gen, int blob_off);
+static void bpf_gen__signature_match(struct bpf_gen *gen);
 
 void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps)
 {
@@ -152,6 +153,8 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps
 	/* R7 contains the error code from sys_bpf. Copy it into R0 and exit. */
 	emit(gen, BPF_MOV64_REG(BPF_REG_0, BPF_REG_7));
 	emit(gen, BPF_EXIT_INSN());
+	if (OPTS_GET(gen->opts, gen_hash, false))
+		bpf_gen__signature_match(gen);
 }
 
 static int add_data(struct bpf_gen *gen, const void *data, __u32 size)
@@ -368,6 +371,8 @@ static void emit_sys_close_blob(struct bpf_gen *gen, int blob_off)
 	__emit_sys_close(gen);
 }
 
+static int compute_sha_udpate_offsets(struct bpf_gen *gen);
+
 int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
 {
 	int i;
@@ -394,6 +399,12 @@ int bpf_gen__finish(struct bpf_gen *gen, int nr_progs, int nr_maps)
 			      blob_fd_array_off(gen, i));
 	emit(gen, BPF_MOV64_IMM(BPF_REG_0, 0));
 	emit(gen, BPF_EXIT_INSN());
+	if (OPTS_GET(gen->opts, gen_hash, false)) {
+		gen->error = compute_sha_udpate_offsets(gen);
+		if (gen->error)
+			return gen->error;
+	}
+
 	pr_debug("gen: finish %s\n", errstr(gen->error));
 	if (!gen->error) {
 		struct gen_loader_opts *opts = gen->opts;
@@ -446,6 +457,27 @@ void bpf_gen__free(struct bpf_gen *gen)
 	_val;							\
 })
 
+static int compute_sha_udpate_offsets(struct bpf_gen *gen)
+{
+	__u64 sha[SHA256_DWORD_SIZE];
+	__u64 sha_dw;
+	int i, err;
+
+	err = libbpf_sha256(gen->data_start, gen->data_cur - gen->data_start, sha, SHA256_DIGEST_LENGTH);
+	if (err < 0) {
+		pr_warn("sha256 computation of the metadata failed");
+		return err;
+	}
+	for (i = 0; i < SHA256_DWORD_SIZE; i++) {
+		struct bpf_insn *insn =
+			(struct bpf_insn *)(gen->insn_start + gen->hash_insn_offset[i]);
+		sha_dw = tgt_endian(sha[i]);
+		insn[0].imm = (__u32)sha_dw;
+		insn[1].imm = sha_dw >> 32;
+	}
+	return 0;
+}
+
 void bpf_gen__load_btf(struct bpf_gen *gen, const void *btf_raw_data,
 		       __u32 btf_raw_size)
 {
@@ -557,6 +589,29 @@ void bpf_gen__map_create(struct bpf_gen *gen,
 		emit_sys_close_stack(gen, stack_off(inner_map_fd));
 }
 
+static void bpf_gen__signature_match(struct bpf_gen *gen)
+{
+	__s64 off;
+	int i;
+
+	for (i = 0; i < SHA256_DWORD_SIZE; i++) {
+		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_1, BPF_PSEUDO_MAP_IDX,
+						 0, 0, 0, 0));
+		emit(gen, BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, i * sizeof(__u64)));
+		gen->hash_insn_offset[i] = gen->insn_cur - gen->insn_start;
+		emit2(gen, BPF_LD_IMM64_RAW_FULL(BPF_REG_3, 0, 0, 0, 0, 0));
+
+		off =  -(gen->insn_cur - gen->insn_start - gen->cleanup_label) / 8 - 1;
+		if (is_simm16(off)) {
+			emit(gen, BPF_MOV64_IMM(BPF_REG_7, -EINVAL));
+			emit(gen, BPF_JMP_REG(BPF_JNE, BPF_REG_2, BPF_REG_3, off));
+		} else {
+			gen->error = -ERANGE;
+			emit(gen, BPF_JMP_IMM(BPF_JA, 0, 0, -1));
+		}
+	}
+}
+
 void bpf_gen__record_attach_target(struct bpf_gen *gen, const char *attach_name,
 				   enum bpf_attach_type type)
 {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 60552fa5401d..7cad8470d9eb 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1826,9 +1826,10 @@ struct gen_loader_opts {
 	const char *insns;
 	__u32 data_sz;
 	__u32 insns_sz;
+	bool gen_hash;
 };
 
-#define gen_loader_opts__last_field insns_sz
+#define gen_loader_opts__last_field gen_hash
 LIBBPF_API int bpf_object__gen_loader(struct bpf_object *obj,
 				      struct gen_loader_opts *opts);
 
-- 
2.43.0


