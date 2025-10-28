Return-Path: <bpf+bounces-72545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54825C1520A
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 15:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C4E44FCEFE
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 14:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C993375D5;
	Tue, 28 Oct 2025 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcF5nZNZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917963346AD
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 14:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660921; cv=none; b=Jqfcr6eAGal+3D5yP64aW0GfmhuRYca+IuAJRIpwDau+VYaxFo0x8zdzK0KrB4E7wJ22kf37p8Ut1zbKcEN7nL6L/8sAPL0U0/7hThgmyr6WpyRwG2FYJyei4/Nx+6TFIXKc/H1CaYZokKUHOS333cFyIrPeDkyOL1T75NiLJ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660921; c=relaxed/simple;
	bh=295iC2yHCnbQ3/VZAlzUF2lsNuQbDFdCl1b3Oruumec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UxlyDD57m4+E7Tbq/JyqRcMS9IVIVbG7h4nzHIChO+8S5ccQSkz1+rzNQG4L0LhUkFWKyojbEmbyCVvWGOD6EKzE7LUc6PT3dzYmBqEUq3OvKycQ8quwgYe8nL8pNiWIhOSTd3ZerEmqIKOwpFrTbl9Ya+M83YPB9U4jMibxtJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcF5nZNZ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4270a0127e1so4797359f8f.3
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 07:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761660917; x=1762265717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FMWgutMI/H1wkaM0YVvXpSiRgWvq/uYpvljcCg/1fw=;
        b=QcF5nZNZClvrlFaG9JNFZB9sr4dv0he3yvqOltFfWgZMk9h1lE/+PMu7JWitTZyNp6
         2HpnH8mqdYg+omHhmvEUpJ+bf30gyC8A4USNpT4ZrMYV0FdBKy25Fa8nVJ5uKZK5R38+
         Hb5yXGBGXuQsQnzvH1YpU/IHa5AZMtlHkR7Kj53akCPqx6pc/kaRx31gXE/mp+OqGG78
         r++yIP75p6TSVMcWCjI+xlOnwUet0mXrAlgA38zlkSb7tT40PqkZQNPpjbwlYn1EzO90
         lcBU5sWRRTvn0WmWqvF8I3ryEe9EXwifpOjK9b1n8YOtG9PBtqipUvGsDeYlkJCec5BL
         ghnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761660917; x=1762265717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FMWgutMI/H1wkaM0YVvXpSiRgWvq/uYpvljcCg/1fw=;
        b=ttsbXiUB+3JxOdMk903k/ZJ0R+MtNIrRaG7CDLaAlxt0SXokxDkeH3pyPODnj6ZsEV
         IxgicdZnEKDOlhH5F6FR+fwFwjl45WV3DLZVM1Szy+cE3epl5ASXerk3MewUkgkrA+zc
         binC6TH0wgmg2CHSArwNe3C5i7z8Qx5KaAWrlw7DYDXeifjjj0Ih3aTCmcguAZw0m/IK
         KUDFvBJtcD+UJbqXeJ9Q+rND0Qj4eSbNmnGu7qchq5Gj55GUPEcR2Ftj4SaPD6cBeqwh
         SjAvPp7mgbYNpexvPNT+mYr2we3jc5jvAx/DA1U0vnEYVJbs8M2439/+awWFVRMx2E4C
         rHXg==
X-Gm-Message-State: AOJu0Yyoh9Or5+XI1oOrom1osZb2sCA09uEagriLyxcj/6byYdPNwb2T
	heVYaTmihTmXGKYgy7k/CWUkp/4v4t55xiwQeTZiSz/xrJ0MCGvjrGJ9uYQRWg==
X-Gm-Gg: ASbGncuFvnDBmmlaQIgM1/S9bsvQnx5s42mAk7RtgfCs10OgfNlwSXMw8UkkYIkxuwq
	LinQMpOtIatkUR17tuKHHeRYDxsHZOnr/qqEBvpNwFiPlBQpEQbeY/BuDkOKnrME0cmS3m0Pxku
	XMzBPdJSH7KyjSj7+d85sFgQwz+oMnqQ5LufWos5ZJMOuGpablYSDGOG/TMjHdBGNQ7rPY2zt/o
	u/TxrAG2BrJpqoTtMUs8mOn0b09abzd6MalowjCB61cuMYj+D2XQXPlriuCuTyMd/1/YS+HPvfS
	l2kuGbU+kj0dodcfWsGB1ZSmvJwXVVMDMNM8vRA6gaQ0UFkYz1/41TQLRRRHVEFiNWdSDvx83l9
	YJgoG6IOefblaJxlOFSPpOi0tqO3e/3N7pyVpyZC4GFQqnUY7gED2Yn248GlX0tu2H0M631Rqjz
	2sHb86oF/aH3t5tG87d24=
X-Google-Smtp-Source: AGHT+IHMuaWdAYQFgMiiE3mKiZ0pJSbtJBvzgJrQLIPVjykPGqGleSdtnZrqgq/4fn+em8JgCZTdbA==
X-Received: by 2002:a05:6000:24c1:b0:3eb:c276:a347 with SMTP id ffacd0b85a97d-429a7df89ccmr2844056f8f.0.1761660917222;
        Tue, 28 Oct 2025 07:15:17 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm20867060f8f.21.2025.10.28.07.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 07:15:16 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v8 bpf-next 08/11] libbpf: support llvm-generated indirect jumps
Date: Tue, 28 Oct 2025 14:20:46 +0000
Message-Id: <20251028142049.1324520-9-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251028142049.1324520-1-a.s.protopopov@gmail.com>
References: <20251028142049.1324520-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For v4 instruction set LLVM is allowed to generate indirect jumps for
switch statements and for 'goto *rX' assembly. Every such a jump will
be accompanied by necessary metadata, e.g. (`llvm-objdump -Sr ...`):

       0:       r2 = 0x0 ll
                0000000000000030:  R_BPF_64_64  BPF.JT.0.0

Here BPF.JT.1.0 is a symbol residing in the .jumptables section:

    Symbol table:
       4: 0000000000000000   240 OBJECT  GLOBAL DEFAULT     4 BPF.JT.0.0

The -bpf-min-jump-table-entries llvm option may be used to control the
minimal size of a switch which will be converted to an indirect jumps.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/libbpf.c          | 249 +++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf_internal.h |   4 +
 tools/lib/bpf/libbpf_probes.c   |   4 +
 tools/lib/bpf/linker.c          |   9 +-
 4 files changed, 263 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b90574f39d1c..49a1411bfaf7 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -190,6 +190,7 @@ static const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_USER_RINGBUF]             = "user_ringbuf",
 	[BPF_MAP_TYPE_CGRP_STORAGE]		= "cgrp_storage",
 	[BPF_MAP_TYPE_ARENA]			= "arena",
+	[BPF_MAP_TYPE_INSN_ARRAY]		= "insn_array",
 };
 
 static const char * const prog_type_name[] = {
@@ -369,6 +370,7 @@ enum reloc_type {
 	RELO_EXTERN_CALL,
 	RELO_SUBPROG_ADDR,
 	RELO_CORE,
+	RELO_INSN_ARRAY,
 };
 
 struct reloc_desc {
@@ -379,7 +381,16 @@ struct reloc_desc {
 		struct {
 			int map_idx;
 			int sym_off;
-			int ext_idx;
+			/*
+			 * The following two fields can be unionized, as the
+			 * ext_idx field is used for extern symbols, and the
+			 * sym_size is used for jump tables, which are never
+			 * extern
+			 */
+			union {
+				int ext_idx;
+				int sym_size;
+			};
 		};
 	};
 };
@@ -421,6 +432,11 @@ struct bpf_sec_def {
 	libbpf_prog_attach_fn_t prog_attach_fn;
 };
 
+struct bpf_light_subprog {
+	__u32 sec_insn_off;
+	__u32 sub_insn_off;
+};
+
 /*
  * bpf_prog should be a better name but it has been used in
  * linux/filter.h.
@@ -494,6 +510,9 @@ struct bpf_program {
 	__u32 line_info_cnt;
 	__u32 prog_flags;
 	__u8  hash[SHA256_DIGEST_LENGTH];
+
+	struct bpf_light_subprog *subprogs;
+	__u32 subprog_cnt;
 };
 
 struct bpf_struct_ops {
@@ -667,6 +686,7 @@ struct elf_state {
 	int symbols_shndx;
 	bool has_st_ops;
 	int arena_data_shndx;
+	int jumptables_data_shndx;
 };
 
 struct usdt_manager;
@@ -738,6 +758,16 @@ struct bpf_object {
 	void *arena_data;
 	size_t arena_data_sz;
 
+	void *jumptables_data;
+	size_t jumptables_data_sz;
+
+	struct {
+		struct bpf_program *prog;
+		int sym_off;
+		int fd;
+	} *jumptable_maps;
+	size_t jumptable_map_cnt;
+
 	struct kern_feature_cache *feat_cache;
 	char *token_path;
 	int token_fd;
@@ -764,6 +794,7 @@ void bpf_program__unload(struct bpf_program *prog)
 
 	zfree(&prog->func_info);
 	zfree(&prog->line_info);
+	zfree(&prog->subprogs);
 }
 
 static void bpf_program__exit(struct bpf_program *prog)
@@ -3942,6 +3973,13 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			} else if (strcmp(name, ARENA_SEC) == 0) {
 				obj->efile.arena_data = data;
 				obj->efile.arena_data_shndx = idx;
+			} else if (strcmp(name, JUMPTABLES_SEC) == 0) {
+				obj->jumptables_data = malloc(data->d_size);
+				if (!obj->jumptables_data)
+					return -ENOMEM;
+				memcpy(obj->jumptables_data, data->d_buf, data->d_size);
+				obj->jumptables_data_sz = data->d_size;
+				obj->efile.jumptables_data_shndx = idx;
 			} else {
 				pr_info("elf: skipping unrecognized data section(%d) %s\n",
 					idx, name);
@@ -4634,6 +4672,16 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
 		return 0;
 	}
 
+	/* jump table data relocation */
+	if (shdr_idx == obj->efile.jumptables_data_shndx) {
+		reloc_desc->type = RELO_INSN_ARRAY;
+		reloc_desc->insn_idx = insn_idx;
+		reloc_desc->map_idx = -1;
+		reloc_desc->sym_off = sym->st_value;
+		reloc_desc->sym_size = sym->st_size;
+		return 0;
+	}
+
 	/* generic map reference relocation */
 	if (type == LIBBPF_MAP_UNSPEC) {
 		if (!bpf_object__shndx_is_maps(obj, shdr_idx)) {
@@ -6144,6 +6192,157 @@ static void poison_kfunc_call(struct bpf_program *prog, int relo_idx,
 	insn->imm = POISON_CALL_KFUNC_BASE + ext_idx;
 }
 
+static int find_jt_map(struct bpf_object *obj, struct bpf_program *prog, int sym_off)
+{
+	size_t i;
+
+	for (i = 0; i < obj->jumptable_map_cnt; i++) {
+		/*
+		 * This might happen that same offset is used for two different
+		 * programs (as jump tables can be the same). However, for
+		 * different programs different maps should be created.
+		 */
+		if (obj->jumptable_maps[i].sym_off == sym_off &&
+		    obj->jumptable_maps[i].prog == prog)
+			return obj->jumptable_maps[i].fd;
+	}
+
+	return -ENOENT;
+}
+
+static int add_jt_map(struct bpf_object *obj, struct bpf_program *prog, int sym_off, int map_fd)
+{
+	size_t new_cnt = obj->jumptable_map_cnt + 1;
+	size_t size = sizeof(obj->jumptable_maps[0]);
+	void *tmp;
+
+	tmp = libbpf_reallocarray(obj->jumptable_maps, new_cnt, size);
+	if (!tmp)
+		return -ENOMEM;
+
+	obj->jumptable_maps = tmp;
+	obj->jumptable_maps[new_cnt - 1].prog = prog;
+	obj->jumptable_maps[new_cnt - 1].sym_off = sym_off;
+	obj->jumptable_maps[new_cnt - 1].fd = map_fd;
+	obj->jumptable_map_cnt = new_cnt;
+
+	return 0;
+}
+
+static int find_subprog_idx(struct bpf_program *prog, int insn_idx)
+{
+	int i;
+
+	for (i = prog->subprog_cnt - 1; i >= 0; i--) {
+		if (insn_idx >= prog->subprogs[i].sub_insn_off)
+			return i;
+	}
+
+	return -1;
+}
+
+static int create_jt_map(struct bpf_object *obj, struct bpf_program *prog, struct reloc_desc *relo)
+{
+	const __u32 jt_entry_size = 8;
+	int sym_off = relo->sym_off;
+	int jt_size = relo->sym_size;
+	__u32 max_entries = jt_size / jt_entry_size;
+	__u32 value_size = sizeof(struct bpf_insn_array_value);
+	struct bpf_insn_array_value val = {};
+	int subprog_idx;
+	int map_fd, err;
+	__u64 insn_off;
+	__u64 *jt;
+	__u32 i;
+
+	map_fd = find_jt_map(obj, prog, sym_off);
+	if (map_fd >= 0)
+		return map_fd;
+
+	if (sym_off % jt_entry_size) {
+		pr_warn("jumptable start %d should be multiple of %u\n",
+			sym_off, jt_entry_size);
+		return -EINVAL;
+	}
+
+	if (jt_size % jt_entry_size) {
+		pr_warn("jumptable size %d should be multiple of %u\n",
+			jt_size, jt_entry_size);
+		return -EINVAL;
+	}
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_INSN_ARRAY, ".jumptables",
+				4, value_size, max_entries, NULL);
+	if (map_fd < 0)
+		return map_fd;
+
+	if (!obj->jumptables_data) {
+		pr_warn("map '.jumptables': ELF file is missing jump table data\n");
+		err = -EINVAL;
+		goto err_close;
+	}
+	if (sym_off + jt_size > obj->jumptables_data_sz) {
+		pr_warn("jumptables_data size is %zd, trying to access %d\n",
+			obj->jumptables_data_sz, sym_off + jt_size);
+		err = -EINVAL;
+		goto err_close;
+	}
+
+	subprog_idx = -1; /* main program */
+	if (relo->insn_idx < 0 || relo->insn_idx >= prog->insns_cnt) {
+		pr_warn("invalid instruction index %d\n", relo->insn_idx);
+		err = -EINVAL;
+		goto err_close;
+	}
+	if (prog->subprogs)
+		subprog_idx = find_subprog_idx(prog, relo->insn_idx);
+
+	jt = (__u64 *)(obj->jumptables_data + sym_off);
+	for (i = 0; i < max_entries; i++) {
+		/*
+		 * The offset should be made to be relative to the beginning of
+		 * the main function, not the subfunction.
+		 */
+		insn_off = jt[i]/sizeof(struct bpf_insn);
+		if (subprog_idx >= 0) {
+			insn_off -= prog->subprogs[subprog_idx].sec_insn_off;
+			insn_off += prog->subprogs[subprog_idx].sub_insn_off;
+		} else {
+			insn_off -= prog->sec_insn_off;
+		}
+
+		/*
+		 * LLVM-generated jump tables contain u64 records, however
+		 * should contain values that fit in u32.
+		 */
+		if (insn_off > UINT32_MAX) {
+			pr_warn("invalid jump table value 0x%llx at offset %d\n",
+				jt[i], sym_off + i);
+			err = -EINVAL;
+			goto err_close;
+		}
+
+		val.orig_off = insn_off;
+		err = bpf_map_update_elem(map_fd, &i, &val, 0);
+		if (err)
+			goto err_close;
+	}
+
+	err = bpf_map_freeze(map_fd);
+	if (err)
+		goto err_close;
+
+	err = add_jt_map(obj, prog, sym_off, map_fd);
+	if (err)
+		goto err_close;
+
+	return map_fd;
+
+err_close:
+	close(map_fd);
+	return err;
+}
+
 /* Relocate data references within program code:
  *  - map references;
  *  - global variable references;
@@ -6235,6 +6434,20 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 		case RELO_CORE:
 			/* will be handled by bpf_program_record_relos() */
 			break;
+		case RELO_INSN_ARRAY: {
+			int map_fd;
+
+			map_fd = create_jt_map(obj, prog, relo);
+			if (map_fd < 0) {
+				pr_warn("prog '%s': relo #%d: can't create jump table: sym_off %u\n",
+						prog->name, i, relo->sym_off);
+				return map_fd;
+			}
+			insn[0].src_reg = BPF_PSEUDO_MAP_VALUE;
+			insn->imm = map_fd;
+			insn->off = 0;
+		}
+			break;
 		default:
 			pr_warn("prog '%s': relo #%d: bad relo type %d\n",
 				prog->name, i, relo->type);
@@ -6432,6 +6645,24 @@ static int append_subprog_relos(struct bpf_program *main_prog, struct bpf_progra
 	return 0;
 }
 
+static int save_subprog_offsets(struct bpf_program *main_prog, struct bpf_program *subprog)
+{
+	size_t size = sizeof(main_prog->subprogs[0]);
+	int new_cnt = main_prog->subprog_cnt + 1;
+	void *tmp;
+
+	tmp = libbpf_reallocarray(main_prog->subprogs, new_cnt, size);
+	if (!tmp)
+		return -ENOMEM;
+
+	main_prog->subprogs = tmp;
+	main_prog->subprogs[new_cnt - 1].sec_insn_off = subprog->sec_insn_off;
+	main_prog->subprogs[new_cnt - 1].sub_insn_off = subprog->sub_insn_off;
+	main_prog->subprog_cnt = new_cnt;
+
+	return 0;
+}
+
 static int
 bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_program *main_prog,
 				struct bpf_program *subprog)
@@ -6461,6 +6692,15 @@ bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_program *main
 	err = append_subprog_relos(main_prog, subprog);
 	if (err)
 		return err;
+
+	/* Save subprogram offsets */
+	err = save_subprog_offsets(main_prog, subprog);
+	if (err) {
+		pr_warn("prog '%s': failed to add subprog offsets: %s\n",
+			main_prog->name, errstr(err));
+		return err;
+	}
+
 	return 0;
 }
 
@@ -9228,6 +9468,13 @@ void bpf_object__close(struct bpf_object *obj)
 
 	zfree(&obj->arena_data);
 
+	zfree(&obj->jumptables_data);
+	obj->jumptables_data_sz = 0;
+
+	for (i = 0; i < obj->jumptable_map_cnt; i++)
+		close(obj->jumptable_maps[i].fd);
+	zfree(&obj->jumptable_maps);
+
 	free(obj);
 }
 
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 35b2527bedec..93bc39bd1307 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -74,6 +74,10 @@
 #define ELF64_ST_VISIBILITY(o) ((o) & 0x03)
 #endif
 
+#ifndef JUMPTABLES_SEC
+#define JUMPTABLES_SEC ".jumptables"
+#endif
+
 #define BTF_INFO_ENC(kind, kind_flag, vlen) \
 	((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
 #define BTF_TYPE_ENC(name, info, size_or_type) (name), (info), (size_or_type)
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 9dfbe7750f56..bccf4bb747e1 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -364,6 +364,10 @@ static int probe_map_create(enum bpf_map_type map_type)
 	case BPF_MAP_TYPE_SOCKHASH:
 	case BPF_MAP_TYPE_REUSEPORT_SOCKARRAY:
 		break;
+	case BPF_MAP_TYPE_INSN_ARRAY:
+		key_size	= sizeof(__u32);
+		value_size	= sizeof(struct bpf_insn_array_value);
+		break;
 	case BPF_MAP_TYPE_UNSPEC:
 	default:
 		return -EOPNOTSUPP;
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 56ae77047bc3..f6ca3b23b17a 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -27,6 +27,7 @@
 #include "strset.h"
 
 #define BTF_EXTERN_SEC ".extern"
+#define JUMPTABLES_REL_SEC ".rel.jumptables"
 
 struct src_sec {
 	const char *sec_name;
@@ -2025,6 +2026,9 @@ static int linker_append_elf_sym(struct bpf_linker *linker, struct src_obj *obj,
 			obj->sym_map[src_sym_idx] = dst_sec->sec_sym_idx;
 			return 0;
 		}
+
+		if (strcmp(src_sec->sec_name, JUMPTABLES_SEC) == 0)
+			goto add_sym;
 	}
 
 	if (sym_bind == STB_LOCAL)
@@ -2271,8 +2275,9 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
 						insn->imm += sec->dst_off / sizeof(struct bpf_insn);
 					else
 						insn->imm += sec->dst_off;
-				} else {
-					pr_warn("relocation against STT_SECTION in non-exec section is not supported!\n");
+				} else if (strcmp(src_sec->sec_name, JUMPTABLES_REL_SEC) != 0) {
+					pr_warn("relocation against STT_SECTION in section %s is not supported!\n",
+						src_sec->sec_name);
 					return -EINVAL;
 				}
 			}
-- 
2.34.1


