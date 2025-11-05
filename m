Return-Path: <bpf+bounces-73597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4133C34A6D
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 10:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9305D460B78
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 08:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3622EDD7E;
	Wed,  5 Nov 2025 08:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7dVn7Sj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB31E2ECEA3
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333091; cv=none; b=C+oPiQIUDIQpcATzQG8NuzJLAoL9iqPj4DGl441mV7BNVTm/ZcRo5DzT6LqBCToz2UBp+EejZoS+t5YRbySaTEU1XsX+osTKfQsrP8KEI+4SSoLgV0/oAlFXtJtiGNJEBqn5TvZIhkMmLXOUiH8g5ffMpq0rpFB+IIPFp4WPQ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333091; c=relaxed/simple;
	bh=qwhi0b6YFP8klaumdTILtoQjFuhTgWZhdreyO+ONBGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pvSmTWOmB4y0rkRwMvXn1901bpJ5kqXN7MfOirkcrk+r38pCObnKyh6HPatPEGJSnWrEd/cMMbvf4TtndpOzRUR3XINyQh90/Z3xJBQ98O7z+Zab6N84Z/43SDUu6qAF/ZIsAsOtKM0DcLWsjD9Ze7v3NFsK+VsBtNlhJZpNA7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7dVn7Sj; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640ace5f283so3990003a12.2
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 00:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762333088; x=1762937888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfYYy0jKQUjJ4qyA+O5utWTymhK1M3DOyEZzNvsNisQ=;
        b=O7dVn7SjoU9Rec/jW9uIux4SL0iSK3mCyS7uo8T9pYkfqCIG4V5aZd0BnrSSHohBZC
         aNOaWSUb7CLVqEiFBJLGHPj0DYIZJuCqtiKtVn+hUHx9dW/FvCLREioCTN3/QD+z1Qw6
         1yqghWT6PkRT/53H5b88jes/OuQ09cB3IQwH+K9DZVOYsJ7JL4grvgYulosYZwUGQ6wh
         10ukUCta5ZOOi8PYNWZW3fhCA3by4Zd5De+txPBsI4bgfogMVhoZV6VGHoYzof9stgQm
         S/bjQmCrc8aKcF0NLyPdhkovawOJaMgY1AP1qDiB8ay3mb8dMpAtaBZmHmqpzLHX+Nuu
         GeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762333088; x=1762937888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfYYy0jKQUjJ4qyA+O5utWTymhK1M3DOyEZzNvsNisQ=;
        b=NhAhnXQ9kRLg0glzN/VnDSBneHzRnpwJz7m50QVdsFkziIZ25Gb4SIzhCne81RFjNo
         +wD0QA8hT3qB4zyldj1TNSFjMeSncYCPc9WzxDhCrKpUHZ5xHzAXwpnBF5UcN7pCUmiM
         FDEbIo/lJTIkMxrSi+bocQdYpWtbr0Vf/UGH9kYSS/ECYU97/SJMzVmnAjoCJzcPWqV1
         YBuS12amkyZH8whiHHTz9JuJ+hzFz7EADzcVRaXFiDSZjoxy8kPmqwW2TRYKm/lw8MOM
         1cKt6WVA00Q2UQetJbaJ+Bsd+dl7ofNJyLc5Kz7VUyfUeL7SGwhYs4m5OrRIz0F2Sc7Q
         FcAQ==
X-Gm-Message-State: AOJu0YzkjpPevYRqFBOFn4pQQ6rqBTK1U1jfkBuEsWK6Jsbtx9YGTt7m
	1fE9bVM4e4injUe+bml8kgkEaQyTi3dGTQF8WC+QUK8HZDMI9weaZbPaqZHvfg==
X-Gm-Gg: ASbGnctRiEMGXqqB8uESZ+7U/Bl7ebOZJuwC7ldsyb4kgU9Z/7MCCCYjVFBd8tlhCAX
	I/xYrpDux5PL8Hqv/fL8I0YgQNpWV0JTg378R9hlnpv4xLJfVuxnlvmxdccbsy/iXaK36ysSVpJ
	z7h2VZOe1yu2V61VcpD1TNiKdUwWupytx2v0H9r/5vfcR7AdH1i1HKANlP4k2B5OfitslQm4w9X
	TjI1Z4Jy/UlWjpczCOFdxRCcXNTgO3fPoGs+ecTAK+AvpkuErLj/kjAqmbxAs3nIDR4yfYTgbyy
	0jJijXKYnpmfQywzPZYdHpQnc+A84y3+FpqwEMHNLhVAlT6e+0RykoJ/gqLW38I+71/B/cOw8I5
	lwIiAiVy0FFWnFKCHmXls0B7xhHU7W7lpq0e9DyrgUO1lExIybfhc2F5C8pzHCsrggY68C1Yg9A
	7Org/hkUh94jg9Td8ONk60pi26tw6zng==
X-Google-Smtp-Source: AGHT+IHzBUhhoGL18NPGuDScVaUVpUPmGs9uipXsInLSzYYouWHW/Gz10bSIrSLkZRMpAwXqTpKVMA==
X-Received: by 2002:a17:907:7245:b0:b70:aac5:c163 with SMTP id a640c23a62f3a-b72652bbe34mr224853966b.24.1762333087551;
        Wed, 05 Nov 2025 00:58:07 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723db0fd12sm429685466b.32.2025.11.05.00.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 00:58:06 -0800 (PST)
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
Subject: [PATCH v11 bpf-next 10/12] libbpf: support llvm-generated indirect jumps
Date: Wed,  5 Nov 2025 09:04:08 +0000
Message-Id: <20251105090410.1250500-11-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
References: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
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
 tools/lib/bpf/libbpf.c          | 247 +++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf_internal.h |   2 +
 tools/lib/bpf/linker.c          |   3 +
 3 files changed, 251 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 777c848ac097..706e7481bdf6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -370,6 +370,7 @@ enum reloc_type {
 	RELO_EXTERN_CALL,
 	RELO_SUBPROG_ADDR,
 	RELO_CORE,
+	RELO_INSN_ARRAY,
 };
 
 struct reloc_desc {
@@ -380,7 +381,16 @@ struct reloc_desc {
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
@@ -422,6 +432,11 @@ struct bpf_sec_def {
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
@@ -495,6 +510,9 @@ struct bpf_program {
 	__u32 line_info_cnt;
 	__u32 prog_flags;
 	__u8  hash[SHA256_DIGEST_LENGTH];
+
+	struct bpf_light_subprog *subprogs;
+	__u32 subprog_cnt;
 };
 
 struct bpf_struct_ops {
@@ -668,6 +686,7 @@ struct elf_state {
 	int symbols_shndx;
 	bool has_st_ops;
 	int arena_data_shndx;
+	int jumptables_data_shndx;
 };
 
 struct usdt_manager;
@@ -739,6 +758,16 @@ struct bpf_object {
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
@@ -765,6 +794,7 @@ void bpf_program__unload(struct bpf_program *prog)
 
 	zfree(&prog->func_info);
 	zfree(&prog->line_info);
+	zfree(&prog->subprogs);
 }
 
 static void bpf_program__exit(struct bpf_program *prog)
@@ -3943,6 +3973,13 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
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
@@ -4635,6 +4672,16 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
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
@@ -6145,6 +6192,157 @@ static void poison_kfunc_call(struct bpf_program *prog, int relo_idx,
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
+	size_t cnt = obj->jumptable_map_cnt;
+	size_t size = sizeof(obj->jumptable_maps[0]);
+	void *tmp;
+
+	tmp = libbpf_reallocarray(obj->jumptable_maps, cnt + 1, size);
+	if (!tmp)
+		return -ENOMEM;
+
+	obj->jumptable_maps = tmp;
+	obj->jumptable_maps[cnt].prog = prog;
+	obj->jumptable_maps[cnt].sym_off = sym_off;
+	obj->jumptable_maps[cnt].fd = map_fd;
+	obj->jumptable_map_cnt++;
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
+		pr_warn("map '.jumptables': jumptable start %d should be multiple of %u\n",
+			sym_off, jt_entry_size);
+		return -EINVAL;
+	}
+
+	if (jt_size % jt_entry_size) {
+		pr_warn("map '.jumptables': jumptable size %d should be multiple of %u\n",
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
+		pr_warn("map '.jumptables': jumptables_data size is %zd, trying to access %d\n",
+			obj->jumptables_data_sz, sym_off + jt_size);
+		err = -EINVAL;
+		goto err_close;
+	}
+
+	subprog_idx = -1; /* main program */
+	if (relo->insn_idx < 0 || relo->insn_idx >= prog->insns_cnt) {
+		pr_warn("map '.jumptables': invalid instruction index %d\n", relo->insn_idx);
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
+			pr_warn("map '.jumptables': invalid jump table value 0x%llx at offset %d\n",
+				(long long)jt[i], sym_off + i * jt_entry_size);
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
@@ -6236,6 +6434,20 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 		case RELO_CORE:
 			/* will be handled by bpf_program_record_relos() */
 			break;
+		case RELO_INSN_ARRAY: {
+			int map_fd;
+
+			map_fd = create_jt_map(obj, prog, relo);
+			if (map_fd < 0) {
+				pr_warn("prog '%s': relo #%d: can't create jump table: sym_off %u\n",
+					prog->name, i, relo->sym_off);
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
@@ -6433,6 +6645,24 @@ static int append_subprog_relos(struct bpf_program *main_prog, struct bpf_progra
 	return 0;
 }
 
+static int save_subprog_offsets(struct bpf_program *main_prog, struct bpf_program *subprog)
+{
+	size_t size = sizeof(main_prog->subprogs[0]);
+	int cnt = main_prog->subprog_cnt;
+	void *tmp;
+
+	tmp = libbpf_reallocarray(main_prog->subprogs, cnt + 1, size);
+	if (!tmp)
+		return -ENOMEM;
+
+	main_prog->subprogs = tmp;
+	main_prog->subprogs[cnt].sec_insn_off = subprog->sec_insn_off;
+	main_prog->subprogs[cnt].sub_insn_off = subprog->sub_insn_off;
+	main_prog->subprog_cnt++;
+
+	return 0;
+}
+
 static int
 bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_program *main_prog,
 				struct bpf_program *subprog)
@@ -6462,6 +6692,14 @@ bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_program *main
 	err = append_subprog_relos(main_prog, subprog);
 	if (err)
 		return err;
+
+	err = save_subprog_offsets(main_prog, subprog);
+	if (err) {
+		pr_warn("prog '%s': failed to add subprog offsets: %s\n",
+			main_prog->name, errstr(err));
+		return err;
+	}
+
 	return 0;
 }
 
@@ -9229,6 +9467,13 @@ void bpf_object__close(struct bpf_object *obj)
 
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
index 35b2527bedec..fc59b21b51b5 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -74,6 +74,8 @@
 #define ELF64_ST_VISIBILITY(o) ((o) & 0x03)
 #endif
 
+#define JUMPTABLES_SEC ".jumptables"
+
 #define BTF_INFO_ENC(kind, kind_flag, vlen) \
 	((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
 #define BTF_TYPE_ENC(name, info, size_or_type) (name), (info), (size_or_type)
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 56ae77047bc3..f4403e3cf994 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -2025,6 +2025,9 @@ static int linker_append_elf_sym(struct bpf_linker *linker, struct src_obj *obj,
 			obj->sym_map[src_sym_idx] = dst_sec->sec_sym_idx;
 			return 0;
 		}
+
+		if (strcmp(src_sec->sec_name, JUMPTABLES_SEC) == 0)
+			goto add_sym;
 	}
 
 	if (sym_bind == STB_LOCAL)
-- 
2.34.1


