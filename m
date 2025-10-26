Return-Path: <bpf+bounces-72266-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA841C0B11B
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 20:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D72D189F675
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 19:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF1C2FE581;
	Sun, 26 Oct 2025 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gn73yQ5a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F832FE575
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761506450; cv=none; b=BUACKBRO8D8ksUPMVJThmMM40A4FcSLGUrAeBg3WKy2oJd9ptdbWM2fsu+16ZodQI59HnY5yQIjEAgSk8kLbZYqh7VtO7VR6THIFFjPyxkeqmRiSktLcIaxKrLukrE2FCDD3MK2iGmc23eAjhIMUZipJ0fLhkSmcnhw8nrrCbuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761506450; c=relaxed/simple;
	bh=RW9YEST5SoSgkZal93ZqSiLRIgTFXDZrJI5/RyZhOzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TogAhWnnXCmZ1dY7+f1q/DGSyYkn43OYf75FViFI6USTL+BWOFCVsTyfxJHgOdrMGjBqT+7tZXn626O22nuYIDQudyjQS0QJsGuH3quQ0gVJGAr/BbpdmOgphUUl6wBIrl9/pBzUqgUUXuQQa1+9wO33rUpWOFUhGG2NqH2qsTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gn73yQ5a; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so22558735e9.0
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 12:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761506446; x=1762111246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8q8+E3wqkbEKt3m81EzH0SxHh3JOTu+5Em7lXqyKi8M=;
        b=Gn73yQ5ar9DIBwcE/m2rZU6cCbmOy4hxLD8JXPPOJZdZ5xOzaRjpEWw1s+LxhI5q2X
         5+S/6ReYhErBHEhHpLSJYiblwbaDtMgVtK4iv9R1qq1Btsd18zWEgLEftlWVU6KF0YQg
         enhCeJAFJU+canEQbBICMUSWoi7bsuu1LTDWhpdQsJ9IC9FgcF4EcnF7RRzzx5X1qSUM
         9ED9uQt/rIknNB3Yz8uisovIkbYi2lOOaBxNjWFR8EeUo10GptJXui6vzUOexnZypqil
         8X5qSjcwhjpQgaVhThiE4l+K6UlJxDxzkQWt4pFEdslGJ1gwhbvdmmeU1HqD6FCfDQs1
         0fzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761506446; x=1762111246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8q8+E3wqkbEKt3m81EzH0SxHh3JOTu+5Em7lXqyKi8M=;
        b=HuQARl111pa1H7t1EEGiBrslI0omksZ9MV5yDxbBrpcBCPVY5U69cntAno3HVchhnh
         wOVaOqQzjk0aQOnWw88rMQTPm7sPT+o6DwDQW/nvg1gWxihy/1gHQ09FKktew/9vhPh6
         j8d5UTdAMM+B8fqL/hPwrk0yLrEypIyNKMh3u/aX8ybnysYZu3SwKuc30bmB6RnqO2JG
         9rBuTSfTuQhMAhoThXFfsrbor362tADV3a3NVeA7UXJvqfa8yRY5fWsH76X9aCSLvXgX
         XNwdsmJoWM2yB4XZCZaJkQY8w0nwBFD9c4zBoUF3MQwQfpc/BL7hVekkxFOK3bGw4fZg
         59Pg==
X-Gm-Message-State: AOJu0Yw+Ua2gv8KaKShd05Xgt9QsdyIZ0K8ScEj9uALLBBV4JBdfO7AY
	i6zeCBl7ymWcKPJl/F9gN+T5wkGVZkmfIA0o1RS1LzUZ8PKfA1koPXe2a1G0nQ==
X-Gm-Gg: ASbGnctfOvjxoHwO0yN/3eIGRLK2IFwP4qrk7YyvtOy4z22n9V/Kp8AT1bbrVRklMOr
	uS1RSdM/w4sfmjjNX7fnQe8mUGY3L+KHdFZxie/vhU6y12gBaR7qO4JeqIkx4Qz0JcKniQXBi/d
	1yMjH0kuXI790BmG24bA8T6Bld9A1W4jflH8BbHvj0R7+5fXppuSxhKB/UcWxtu4Ak1MOFCjMCP
	g4WbaW9BmfMpAd8KzOLQn+BWZsToAKGyA5BTVrl866AXchvD5BeXe/S5D8V5XmZ+mCJVF88oZFo
	AhhxAKXXeaAWIqLmwWZctM4ySzToM6iDnuJ57HKlhWxsx23M8AUfqDCw/O6Oey+/MJmTQJ+NdAn
	0pDzIVLtvx2sOl+2oxAhR6a8u5tOlqdUHrTlTO++s313ECPk04AbCcTjB6Lf2WZAiE/WOiTokno
	whtEY6DJ1sZJ6UzaIYHHw=
X-Google-Smtp-Source: AGHT+IFvG2O52SNx55+hWWV16wCsxEq9jhh+v3segKTtpqohTvw/fSHhmibZwGP17wk+P72xZVNM4A==
X-Received: by 2002:a05:600c:a4e:b0:46e:711c:efeb with SMTP id 5b1f17b1804b1-475cb02f5b9mr96597385e9.25.1761506445691;
        Sun, 26 Oct 2025 12:20:45 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4894c9sm92434375e9.5.2025.10.26.12.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 12:20:44 -0700 (PDT)
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
Subject: [PATCH v7 bpf-next 09/12] libbpf: support llvm-generated indirect jumps
Date: Sun, 26 Oct 2025 19:27:06 +0000
Message-Id: <20251026192709.1964787-10-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
References: <20251026192709.1964787-1-a.s.protopopov@gmail.com>
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
---
 tools/lib/bpf/libbpf.c          | 249 +++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf_internal.h |   4 +
 tools/lib/bpf/libbpf_probes.c   |   4 +
 tools/lib/bpf/linker.c          |   9 +-
 4 files changed, 263 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b90574f39d1c..2127f11c9ef2 100644
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
+	if (insn_idx < 0 || insn_idx >= prog->insns_cnt)
+		return -1;
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
+	jt = (__u64 *)(obj->jumptables_data + sym_off);
+	for (i = 0; i < max_entries; i++) {
+		/*
+		 * The offset should be made to be relative to the beginning of
+		 * the main function, not the subfunction.
+		 */
+		insn_off = jt[i]/sizeof(struct bpf_insn);
+		if (!prog->subprogs) {
+			insn_off -= prog->sec_insn_off;
+		} else {
+			subprog_idx = find_subprog_idx(prog, relo->insn_idx);
+			if (subprog_idx < 0) {
+				pr_warn("invalid jump insn idx[%d]: %d, no subprog found\n",
+					i, relo->insn_idx);
+				err = -EINVAL;
+			}
+			insn_off -= prog->subprogs[subprog_idx].sec_insn_off;
+			insn_off += prog->subprogs[subprog_idx].sub_insn_off;
+		}
+
+		/*
+		 * LLVM-generated jump tables contain u64 records, however
+		 * should contain values that fit in u32.
+		 */
+		if (insn_off > UINT32_MAX) {
+			pr_warn("invalid jump table value %llx at offset %d\n",
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


