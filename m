Return-Path: <bpf+bounces-69157-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F7AB8DDDF
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 18:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22BD0189B99C
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 16:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794AF202C48;
	Sun, 21 Sep 2025 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JauDxm1m"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC6E34BA28;
	Sun, 21 Sep 2025 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758470498; cv=none; b=CWQ0P/Nbg2iXYEkF+d2cXfYvuiYGNvAcM8H6BNlwZgyhHQTgFV7Fj7gXj8DL3AnkEEPruZbPyxQbeFpJmdCRTGWO4XR32iz6PQDYHBzMURL89bz2ScHFbMA0s9ZbfRLuJHVdoIM1/36+efI7Com7RiaY7BsJhbhrOrcOwe6a/0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758470498; c=relaxed/simple;
	bh=MTmj9Br1zVegrHMHsoIGl8X577XJ8S07l78lx+winNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5RGsxWE4ImwL4S4sVR2XpFtbqBvXi10UlEWDrUrFiapPH5P84W8UFqSr3sTW1D8BSpo40vhx784mlkfoOrUBxctQbtBB7qYtXrT92EpHw1NTlfzU31o0bJz2bxnAZNz/wUdKSX8r0nN+0q+wgYAA6HJ+Z09xhwbD9BUmq5U3VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JauDxm1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD5BC4CEE7;
	Sun, 21 Sep 2025 16:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758470497;
	bh=MTmj9Br1zVegrHMHsoIGl8X577XJ8S07l78lx+winNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JauDxm1mMS/V90xncWgdTTymYkvtiV9fpnUjTmvLr/KCYHJpjW4Gu0IWt/c+D1rfw
	 qDmcnhaYmGedwUKSa97Q3NPUIQeRd5q+jhYjsJHhTXH/MpQskAOptlWA82lHT6m6Eu
	 bnkQHpqKKyG69D5pMY5Tyzk9obwVrENYOoV/e+uC0Kh+qhiijnJKecZ+ua13fotH5S
	 vT7nLC2MsN4ktqFtg7YbwTZpQZyB9NwjL4ayoOknWJgr2Bcw614lCCq21IItSnm8q2
	 AnVcMUtjQvJKIr6r/VIy8jpak0ZjFll8DMeFLqkIX1YzLT8a60akenqZqpPdWaSMS1
	 CytKKFDuqQgSA==
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
Subject: [PATCH bpf-next v7 3/5] libbpf: Embed and verify the metadata hash in the loader
Date: Sun, 21 Sep 2025 18:01:18 +0200
Message-ID: <20250921160120.9711-4-kpsingh@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250921160120.9711-1-kpsingh@kernel.org>
References: <20250921160120.9711-1-kpsingh@kernel.org>
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
index 113ae4abd345..376eef292d3a 100644
--- a/tools/lib/bpf/gen_loader.c
+++ b/tools/lib/bpf/gen_loader.c
@@ -110,6 +110,7 @@ static void emit2(struct bpf_gen *gen, struct bpf_insn insn1, struct bpf_insn in
 
 static int add_data(struct bpf_gen *gen, const void *data, __u32 size);
 static void emit_sys_close_blob(struct bpf_gen *gen, int blob_off);
+static void emit_signature_match(struct bpf_gen *gen);
 
 void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps)
 {
@@ -152,6 +153,8 @@ void bpf_gen__init(struct bpf_gen *gen, int log_level, int nr_progs, int nr_maps
 	/* R7 contains the error code from sys_bpf. Copy it into R0 and exit. */
 	emit(gen, BPF_MOV64_REG(BPF_REG_0, BPF_REG_7));
 	emit(gen, BPF_EXIT_INSN());
+	if (OPTS_GET(gen->opts, gen_hash, false))
+		emit_signature_match(gen);
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
 
+static void emit_signature_match(struct bpf_gen *gen)
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
index e978bc093c39..5118d0a90e24 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1857,9 +1857,10 @@ struct gen_loader_opts {
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


