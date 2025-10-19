Return-Path: <bpf+bounces-71329-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD78CBEEC24
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 22:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEAF04E3A97
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 20:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4812ECEA8;
	Sun, 19 Oct 2025 20:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVKsVA95"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765D32EC56E
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 20:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760904940; cv=none; b=foKOPogKA+M3ZM5a1s+mWdzB78jxsHq/W818SDb9igcv2yt1YJaRGI8YZpblW1bSF3QjPVoJszOLfStigPvHXIY384QpbtWZPAVG1shoKGtH/f3yfjmCeXXGb46JPBvITBxsRhO8MIbKSrAiRN7IoSvZqo7EsZQGoIQFwKtK0lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760904940; c=relaxed/simple;
	bh=p+4u2E1Lblqi0HLi8hi3YptIjYPeKTs4r6dGwpiG0zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YSdeFQMgP2UG5jPOqJr2l6xYlBWrLVaeXuf0RLEo20MHrzOrG9OZ3vkpLFGe15iUd4NsE00dOg40rxbwGx8cKr3wfR0RIjiWjKHzbcy+PQMDTydUzrwPFZlYcC1KVrrV0Tll83oTk9jNKVWqXnunoKS91URjPv5dVpvmMDaGhG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVKsVA95; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4270a3464caso1326935f8f.1
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 13:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760904936; x=1761509736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1cqiGOix0rW8dR9ojSCbJqCtyCZUO4dzNo7QCGU6uc=;
        b=IVKsVA953j7rTwatZ5OapTJXBrFLD6U+/RB/CX++v7rvlnTYkK0kDPM2NJAd+f7GED
         +d1g2KGrYVRqR9Stm0GACByOsx/4nomehmd9JnH/2XRehW67QHxKdljdha7JOu6bLotk
         UdolQXF8o8fDdt/ueCqsnSH5fOitWKAJN0fG0fO9RWk18kgDkV7tiL+zUOBGlaLLmptA
         roYD7wPLTGHjbOTppuxcps2HD/wl3dKz8lKZQQT/QnMlQ2ZNYIMoumcxky9JCbnob0sD
         mrScCP2BtrOxB48GD/RA5vFfsjWjbimPPb/a85Cf2jMQDDZjTmUcEhK/oMPFCI/uxJ6m
         T5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760904936; x=1761509736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m1cqiGOix0rW8dR9ojSCbJqCtyCZUO4dzNo7QCGU6uc=;
        b=D0DdgtFJtnCCE93GfdK9Xr/C8OJTMSRWzVnsv6ubm18EYXPXgwZTH0BFhmKkfhfYjs
         NRhWETChtEQBvygAish4Bn9hg8W5cVKp4W01iB4h9qqA798j0XqGFLmiBgpp9Ri2OCp0
         V0KMIVi/Lcrb6tFHzJUqmX4PUyIWj/Poay6ZnaQDeDcjvt1zk8tkURWNVoA5doKm/nzC
         OpUNXFmo2lH8Q229HYCjWNFO5e4OE97Iw3B22nhU7YOBh3vAabkAQsj/tcSZy6oBK6lJ
         1EZbHbq4Vls7Vy8NXePUrB5PGP8xkVbDdOLcKL595qSS32mqsORBJPWortkDzlJL/csa
         TyaA==
X-Gm-Message-State: AOJu0YypJNSGHJedscD1poztqFVnN0GZmndrQ5ZyUjrKC0Kz80oDklGc
	spnrRBfMLGSe88i2oGt2M1hgR7cWM6b1UjCg6uCMVxTdEKOPs0RD+e9m/mpH4A==
X-Gm-Gg: ASbGncuB1/tuRx98LDFNgWeff/jffxZZfDgtkSuReWJVPn7EzFUQpnscA9/VgXJWZhL
	xwiD8N66aUIDUYjSKulCxPaUKYBWigjor460AI2CSgk0ePbbkeaxtCHL8PuWA0Q61YvJLTVpCT3
	eViZAuOmE8bjchjb3rBuMihIAxMt7mEbE/aS4pb1vZ0Jr01lx3TSwsYBA179izzgE8GfMszocug
	sQHP9rJFRyEIkA3fWjiotFIT1vx1C+84HDjVMG8f0GpXi/LrkQ+NV8B/1Ja9a+bmxWqvTo90pxe
	7U0USxjbFivbAvGvQd+VTcLQiyVxB976Rctm/xxS3cu6FJugZiCEaaf66TCHAPgjP+DM3FDBX2d
	M8WvWb9Y7PhtFZLTc1DRIELgBKTQWrdaVVn4xkt5JrL2zxloBgZcA8f4NJbsNHInv3Ern8+sey2
	qcYlADJSyLVLN2K85DuKk=
X-Google-Smtp-Source: AGHT+IEiqJfBxvuXGu3Y915/kejzyilokghkCjq0F9YWyfYFOO1LBEgPBbG8vFoPmaWcEp0Z98qDow==
X-Received: by 2002:a05:600c:3b05:b0:46e:32dd:1b1a with SMTP id 5b1f17b1804b1-47117874689mr80516755e9.7.1760904936211;
        Sun, 19 Oct 2025 13:15:36 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c831asm190460105e9.13.2025.10.19.13.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 13:15:35 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 14/17] libbpf: support llvm-generated indirect jumps
Date: Sun, 19 Oct 2025 20:21:42 +0000
Message-Id: <20251019202145.3944697-15-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
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
 tools/lib/bpf/libbpf.c        | 240 +++++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf_probes.c |   4 +
 tools/lib/bpf/linker.c        |  10 +-
 3 files changed, 251 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b90574f39d1c..ee44bc49a3ba 100644
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
@@ -523,6 +542,7 @@ struct bpf_struct_ops {
 #define STRUCT_OPS_SEC ".struct_ops"
 #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
 #define ARENA_SEC ".addr_space.1"
+#define JUMPTABLES_SEC ".jumptables"
 
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -667,6 +687,7 @@ struct elf_state {
 	int symbols_shndx;
 	bool has_st_ops;
 	int arena_data_shndx;
+	int jumptables_data_shndx;
 };
 
 struct usdt_manager;
@@ -738,6 +759,16 @@ struct bpf_object {
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
@@ -764,6 +795,7 @@ void bpf_program__unload(struct bpf_program *prog)
 
 	zfree(&prog->func_info);
 	zfree(&prog->line_info);
+	zfree(&prog->subprogs);
 }
 
 static void bpf_program__exit(struct bpf_program *prog)
@@ -3942,6 +3974,13 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
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
@@ -4634,6 +4673,16 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
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
@@ -6144,6 +6193,144 @@ static void poison_kfunc_call(struct bpf_program *prog, int relo_idx,
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
+static int create_jt_map(struct bpf_object *obj, struct bpf_program *prog,
+			 int sym_off, int jt_size, int adjust_off)
+{
+	const __u32 jt_entry_size = 8;
+	const __u32 max_entries = jt_size / jt_entry_size;
+	const __u32 value_size = sizeof(struct bpf_insn_array_value);
+	struct bpf_insn_array_value val = {};
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
+		 * LLVM-generated jump tables contain u64 records, however
+		 * should contain values that fit in u32.
+		 * The adjust_off provided by the caller adjusts the offset to
+		 * be relative to the beginning of the main function
+		 */
+		insn_off = jt[i]/sizeof(struct bpf_insn) + adjust_off;
+		if (insn_off > UINT32_MAX) {
+			pr_warn("invalid jump table value %llx at offset %d (adjust_off %d)\n",
+				jt[i], sym_off + i, adjust_off);
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
+/*
+ * In LLVM the .jumptables section contains jump tables entries relative to the
+ * section start. The BPF kernel-side code expects jump table offsets relative
+ * to the beginning of the program (passed in bpf(BPF_PROG_LOAD)). This helper
+ * computes a delta to be added when creating a map.
+ */
+static int jt_adjust_off(struct bpf_program *prog, int insn_idx)
+{
+	int i;
+
+	for (i = prog->subprog_cnt - 1; i >= 0; i--) {
+		if (insn_idx >= prog->subprogs[i].sub_insn_off)
+			return prog->subprogs[i].sub_insn_off - prog->subprogs[i].sec_insn_off;
+	}
+
+	return -prog->sec_insn_off;
+}
+
+
 /* Relocate data references within program code:
  *  - map references;
  *  - global variable references;
@@ -6235,6 +6422,21 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 		case RELO_CORE:
 			/* will be handled by bpf_program_record_relos() */
 			break;
+		case RELO_INSN_ARRAY: {
+			int map_fd;
+
+			map_fd = create_jt_map(obj, prog, relo->sym_off, relo->sym_size,
+					       jt_adjust_off(prog, relo->insn_idx));
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
@@ -6432,6 +6634,24 @@ static int append_subprog_relos(struct bpf_program *main_prog, struct bpf_progra
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
@@ -6461,6 +6681,15 @@ bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_program *main
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
 
@@ -9228,6 +9457,15 @@ void bpf_object__close(struct bpf_object *obj)
 
 	zfree(&obj->arena_data);
 
+	zfree(&obj->jumptables_data);
+	obj->jumptables_data_sz = 0;
+
+	if (obj->jumptable_maps && obj->jumptable_map_cnt) {
+		for (i = 0; i < obj->jumptable_map_cnt; i++)
+			close(obj->jumptable_maps[i].fd);
+	}
+	zfree(&obj->jumptable_maps);
+
 	free(obj);
 }
 
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
index 56ae77047bc3..3defd4bc9154 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -27,6 +27,8 @@
 #include "strset.h"
 
 #define BTF_EXTERN_SEC ".extern"
+#define JUMPTABLES_SEC ".jumptables"
+#define JUMPTABLES_REL_SEC ".rel.jumptables"
 
 struct src_sec {
 	const char *sec_name;
@@ -2025,6 +2027,9 @@ static int linker_append_elf_sym(struct bpf_linker *linker, struct src_obj *obj,
 			obj->sym_map[src_sym_idx] = dst_sec->sec_sym_idx;
 			return 0;
 		}
+
+		if (strcmp(src_sec->sec_name, JUMPTABLES_SEC) == 0)
+			goto add_sym;
 	}
 
 	if (sym_bind == STB_LOCAL)
@@ -2271,8 +2276,9 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
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


