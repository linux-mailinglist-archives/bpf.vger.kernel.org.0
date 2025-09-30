Return-Path: <bpf+bounces-70022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 773F9BAC8FE
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 12:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867DA3B1BDD
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 10:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819D42FB989;
	Tue, 30 Sep 2025 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1qFX+z4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1599B2FB622
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759229401; cv=none; b=NEmPKad2bXBYwrrQHidSumASGMKuSqM1COBZS+jK+EQGv7e8wX1XeGBhcpuNIUPo/4dA4zDUHWN29kl+sBHj1xs8FAb2JyQEK0G2VMbxezxFy1c66rb0fPnAKjKxtDOfjl2VCEn/Syd/HRhUo+G4Uws2aDm69jir896XXZ+LyYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759229401; c=relaxed/simple;
	bh=TIIM0rWDcVXDgnhuCuZyathl6oqmOdZ2YJMcJYC4NJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=djIrpTODVhbGqK81kQu7EHRWO2OCxt7fQerkGprT0+W4HgjLiQM1Wvk4riE08ysXndobnOg8X846f2I/TMbD2r76K4hY0AynqmTMEQlJcmHzi+h010mGtcbS2QNuljWJ+VeWoTwEdmcCgRl5Ajn7+uexH/puODickPQnyxQIA2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1qFX+z4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e2c3b6d4cso42883205e9.3
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 03:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759229397; x=1759834197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kP3zLuKlL2pU3UlDBF2hwEBBhjPzH4FxBfqGz1eF5D4=;
        b=P1qFX+z49iHQyssCfnOCxUtRzLoepdPudUOWHmdyAPp9UzBrHQnAe9kciaYFA+Q9W4
         Gy7oA1YFoo2gzUr+nrYyAKgYiKtU+IpNXUYoVoxpK2GPE/qY+rzFOj32ik0OzKbyKdCS
         2N+vLcdR14kz9vSV7Bl2skAVluEw7492q5U+2paIKpZb/RG0uvDUEJbAJ4pAlqzayXo1
         i0G1tzv27PXEV4FrewqlTK86jJtEJGiH4fiZgqwLGhGGfHmmC0n5NZqUn4Tw7qp4N/j7
         Hq+W76nXdd4aPhs8yzlVhMJEJJBaMdLcgOcopGSLAAyKhofAm1bzjVSiaTbuE5g+7Xtu
         /0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759229397; x=1759834197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kP3zLuKlL2pU3UlDBF2hwEBBhjPzH4FxBfqGz1eF5D4=;
        b=dRfZcTDIQRcVDQRLXCJFCoWV1votGpxNUPw1P/tcShux1KFJfUFg4IB71cOnxAFlCI
         m6Af1xe/po5Id2eEKaRkb7wzspG7CaJIyBbaPlykVbqd54V8r6hF43HvrNa3gj80OHpV
         wEOdaQLyAGWa/GiM45ONuyyoluhN0UeCmhJdVUzfDYwSXznsZ4fvJCUp7t4lSQz59W+5
         U1yJfZEeuY3kUL2RKH4as1bL+U/TFws733AX8SbgmsJw5sIxRAnhiKJqcFW8v+sWhz+J
         UZDMEjotgBsgO4zKki1RkC4Pz6yIpG/9iROucciNqBXe8dcTwL8c+s9t5iU7OdkOf/sh
         8W2A==
X-Gm-Message-State: AOJu0YxojV5tWIpa1/TdyEw3OhVfH7rpUfXssK2DqEn6ZCJbI3dDhSVY
	DiHi9Ak6zOg3/lRRKgrhG93/IEi23oehHlr+7Xx5DzjA/ihAcujBIak/quEN0w==
X-Gm-Gg: ASbGnctiluPa6aJLL7Wrg/5doyAiR7rJsstUEpoOWxR+Ii7RuOnIwBppzFbE9PLPOBm
	+9eTDLL43Pphd9vYyZZIDybx21QPu8cd3iZZyFUKNkMuB2gdlTjpRcCh6LC81lu6rdBhYen1XBA
	eSz0HLvfYfyT0m/4SSVoeKPRJY9L6EqY34a1dTKdddkOg+k1qcMQUgyHW6ebxMcRmNRx6q1I20D
	B5NXuYL6I22kuoI9EmnPtJZ8t7IqTR7M/INqRMRv/HND9iMCQUmQL9gIWDrTAxoPibg/tHUVRdx
	oZJz4C7EL8AJLP9J/yvE4OWyXqvLUllj5fPgT5nc8xtWNgqMlDtOWRpbDz1b2YEl9UD1vcxVXD2
	7SBgs2j0KeCBSwxh9CQXL8GWYiVqfIR+VrcWQr6XUJusYzm/w0nz7vJvXqEh6+JuGag==
X-Google-Smtp-Source: AGHT+IEhR6KKzLH7r6HarGIVxJYUiZVjfRLX9esyTEj49lDqkoCHq6BlPxynzRCEZ+gTKwFK/VY2Gw==
X-Received: by 2002:a05:600c:5494:b0:46e:33a6:46b2 with SMTP id 5b1f17b1804b1-46e33a649a8mr181669655e9.12.1759229396519;
        Tue, 30 Sep 2025 03:49:56 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602dfdsm21982161f8f.33.2025.09.30.03.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 03:49:55 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 13/15] libbpf: support llvm-generated indirect jumps
Date: Tue, 30 Sep 2025 10:55:21 +0000
Message-Id: <20250930105523.1014140-14-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
References: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For v5 instruction set LLVM is allowed to generate indirect jumps for
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
 tools/lib/bpf/libbpf.c        | 221 +++++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf_probes.c |   4 +
 tools/lib/bpf/linker.c        |  10 +-
 3 files changed, 232 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1bb390a5c76e..51a9b25e3833 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -194,6 +194,7 @@ static const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_USER_RINGBUF]             = "user_ringbuf",
 	[BPF_MAP_TYPE_CGRP_STORAGE]		= "cgrp_storage",
 	[BPF_MAP_TYPE_ARENA]			= "arena",
+	[BPF_MAP_TYPE_INSN_ARRAY]		= "insn_array",
 };
 
 static const char * const prog_type_name[] = {
@@ -375,6 +376,7 @@ enum reloc_type {
 	RELO_EXTERN_CALL,
 	RELO_SUBPROG_ADDR,
 	RELO_CORE,
+	RELO_INSN_ARRAY,
 };
 
 struct reloc_desc {
@@ -385,7 +387,10 @@ struct reloc_desc {
 		struct {
 			int map_idx;
 			int sym_off;
-			int ext_idx;
+			union {
+				int ext_idx;
+				int sym_size;
+			};
 		};
 	};
 };
@@ -427,6 +432,11 @@ struct bpf_sec_def {
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
@@ -500,6 +510,9 @@ struct bpf_program {
 	__u32 line_info_cnt;
 	__u32 prog_flags;
 	__u8  hash[SHA256_DIGEST_LENGTH];
+
+	struct bpf_light_subprog *subprogs;
+	__u32 subprog_cnt;
 };
 
 struct bpf_struct_ops {
@@ -529,6 +542,7 @@ struct bpf_struct_ops {
 #define STRUCT_OPS_SEC ".struct_ops"
 #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
 #define ARENA_SEC ".addr_space.1"
+#define JUMPTABLES_SEC ".jumptables"
 
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -673,6 +687,7 @@ struct elf_state {
 	int symbols_shndx;
 	bool has_st_ops;
 	int arena_data_shndx;
+	int jumptables_data_shndx;
 };
 
 struct usdt_manager;
@@ -744,6 +759,16 @@ struct bpf_object {
 	void *arena_data;
 	size_t arena_data_sz;
 
+	void *jumptables_data;
+	size_t jumptables_data_sz;
+
+	struct {
+		struct bpf_program *prog;
+		int off;
+		int fd;
+	} *jumptable_maps;
+	size_t jumptable_map_cnt;
+
 	struct kern_feature_cache *feat_cache;
 	char *token_path;
 	int token_fd;
@@ -770,6 +795,7 @@ void bpf_program__unload(struct bpf_program *prog)
 
 	zfree(&prog->func_info);
 	zfree(&prog->line_info);
+	zfree(&prog->subprogs);
 }
 
 static void bpf_program__exit(struct bpf_program *prog)
@@ -3950,6 +3976,13 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
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
@@ -4642,6 +4675,16 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
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
@@ -6152,6 +6195,131 @@ static void poison_kfunc_call(struct bpf_program *prog, int relo_idx,
 	insn->imm = POISON_CALL_KFUNC_BASE + ext_idx;
 }
 
+static int find_jt_map(struct bpf_object *obj, struct bpf_program *prog, int off)
+{
+	size_t i;
+
+	for (i = 0; i < obj->jumptable_map_cnt; i++) {
+		/*
+		 * This might happen that same offset is used for two different
+		 * programs (as jump tables can be the same). However, for
+		 * different programs different maps should be created.
+		 */
+		if (obj->jumptable_maps[i].off == off &&
+		    obj->jumptable_maps[i].prog == prog)
+			return obj->jumptable_maps[i].fd;
+	}
+
+	return -ENOENT;
+}
+
+static int add_jt_map(struct bpf_object *obj, struct bpf_program *prog, int off, int map_fd)
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
+	obj->jumptable_maps[new_cnt - 1].off = off;
+	obj->jumptable_maps[new_cnt - 1].fd = map_fd;
+	obj->jumptable_map_cnt = new_cnt;
+
+	return 0;
+}
+
+static int create_jt_map(struct bpf_object *obj, struct bpf_program *prog,
+			 int off, int size, int adjust_off)
+{
+	const __u32 value_size = sizeof(struct bpf_insn_array_value);
+	const __u32 max_entries = size / value_size;
+	struct bpf_insn_array_value val = {};
+	int map_fd, err;
+	__u64 xlated_off;
+	__u64 *jt;
+	__u32 i;
+
+	map_fd = find_jt_map(obj, prog, off);
+	if (map_fd >= 0)
+		return map_fd;
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
+	if (off + size > obj->jumptables_data_sz) {
+		pr_warn("jumptables_data size is %zd, trying to access %d\n",
+			obj->jumptables_data_sz, off + size);
+		err = -EINVAL;
+		goto err_close;
+	}
+
+	jt = (__u64 *)(obj->jumptables_data + off);
+	for (i = 0; i < max_entries; i++) {
+		/*
+		 * LLVM-generated jump tables contain u64 records, however
+		 * should contain values that fit in u32.
+		 * The adjust_off provided by the caller adjusts the offset to
+		 * be relative to the beginning of the main function
+		 */
+		xlated_off = jt[i]/sizeof(struct bpf_insn) + adjust_off;
+		if (xlated_off > UINT32_MAX) {
+			pr_warn("invalid jump table value %llx at offset %d (adjust_off %d)\n",
+				jt[i], off + i, adjust_off);
+			err = -EINVAL;
+			goto err_close;
+		}
+
+		val.xlated_off = xlated_off;
+		err = bpf_map_update_elem(map_fd, &i, &val, 0);
+		if (err)
+			goto err_close;
+	}
+
+	err = bpf_map_freeze(map_fd);
+	if (err)
+		goto err_close;
+
+	err = add_jt_map(obj, prog, off, map_fd);
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
@@ -6243,6 +6411,21 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
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
@@ -6440,6 +6623,24 @@ static int append_subprog_relos(struct bpf_program *main_prog, struct bpf_progra
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
@@ -6469,6 +6670,15 @@ bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_program *main
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
 
@@ -9236,6 +9446,15 @@ void bpf_object__close(struct bpf_object *obj)
 
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
index a469e5d4fee7..60dbf3edfa54 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -28,6 +28,8 @@
 #include "str_error.h"
 
 #define BTF_EXTERN_SEC ".extern"
+#define JUMPTABLES_SEC ".jumptables"
+#define JUMPTABLES_REL_SEC ".rel.jumptables"
 
 struct src_sec {
 	const char *sec_name;
@@ -2026,6 +2028,9 @@ static int linker_append_elf_sym(struct bpf_linker *linker, struct src_obj *obj,
 			obj->sym_map[src_sym_idx] = dst_sec->sec_sym_idx;
 			return 0;
 		}
+
+		if (strcmp(src_sec->sec_name, JUMPTABLES_SEC) == 0)
+			goto add_sym;
 	}
 
 	if (sym_bind == STB_LOCAL)
@@ -2272,8 +2277,9 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
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


