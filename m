Return-Path: <bpf+bounces-68305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E29DB562CD
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 21:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F4348045D
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 19:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2648025A324;
	Sat, 13 Sep 2025 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4MXwqw3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1A3253B67
	for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757792034; cv=none; b=hryw77Eq36ZO4uA70WipcpCbGlYPGzwW0RL6OT5aoTEAmDUPBapuam1XRDFcRaFEOaTNsqc6FFR9X9uaOqzxWcDohN1wq6/zugDr4l3r4jVvaS1kbLYfNAvtjuWkXo2OxyLh9pXYFB3ZLUOeMJ0IWsF699smqMQH2KrjG8wXy08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757792034; c=relaxed/simple;
	bh=fYdSzAmaDGax4NSlYAoSj+XgruleqTLSBPihK+mj7To=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uHLORQVcTlLIrZNp+hee71iYcHVu9DZ4dx9Wy0iVSxwxucC0pQXgF5jeZfsGASTHDrV6vfA4bwJ/uuIEJnVCW9vMVXv6McvMfEe1LxAMwGZoWL+3qcLggIF/BjedeVSGKeVjV0Z6niXNFjadwIQHkqmpBxgpbWJdig+UHsUVR7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4MXwqw3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3e9ca387425so8455f8f.0
        for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 12:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757792029; x=1758396829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMjjV3DzcB7r7eFz48hkkE0nKMfnB6Dsk/WdllTeWRA=;
        b=b4MXwqw3HJDwxgth6Kexud8UsCh0NHfrks6OIwXgqwTVYRF/vaRqjlSJilJZld8+ro
         L73EkATXKf/q79L1VZEEfB3RMoHVbhqUMudYBcaal/xWydr9FmMcvDpDE+wTvrWOXCuv
         PMsoMQX6lJIAgtAqntxUEwu8yhTLl2bf9C1gQAOQIcTsqpx7w9lSF/mTSzQARTfO2jOn
         O+S9L3Vdm6KZY1KIYQeII4MktIe5vVqDH+lZ7zDtPfvEXkmMWHshtJxnegPlyHgvgq4e
         ZvX8lCa5lQCW1tG/PMHbYI2DxX7asqMIWoZkPcJGZ/fWm0Y+nWV0A+WIA69vLVCYrI4a
         nhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757792029; x=1758396829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMjjV3DzcB7r7eFz48hkkE0nKMfnB6Dsk/WdllTeWRA=;
        b=Pppr4XSEuB+JsmAxfa06T/+bi6jvmThcsh0fG4z8ZVcxPJ0GvAVJZofFlYnDIL4P9J
         1AYqi5qIAa8Rl1y1xLnUukMYc3pRk/XJBvoZbKJ+vc3FDoh8Ow35qWe3ATxhVW0TBjMB
         1qQPs6h1euoAj/hRJa11dtRajqdI0jGdXJhAvzJbdoS6tfEmMiXkf0JKxl+/fy/JoJaQ
         6WEJJP64f4cmBd7KCUnYPQ3g4ikBmVJj7X7X5Csf1BrCmSBiAPJCRqGQELCmklZgMP/T
         jyRy6b+foDMP7zIkrDwt8g57h7yD/h7xkRjRjneBr+nN0y0HHETZOO3yhFnSP/ZvzN9f
         IUSg==
X-Gm-Message-State: AOJu0YxWIETzO6mzwFlN7Qc7RftI+wUvNzajBGZjkGJu/TRfWTsxA/8Q
	+ShcLSdSUjwxMcFkpvrYK5g61yOPN9rFwK7pFb9MgQrkRthisY3dzBLaKoGCxA==
X-Gm-Gg: ASbGncuqK8tUQnzeEepBn6TuOvIyhboUd/KWRXW/+ic2UCyI4Xn1ZNYMPMPVGj8eoHd
	iBg0iU8dbOzr12pnUJgO41oaar7+MgrXETio1/E/kNBVTkdviuLjKVCYmUn7eLTirEguDH3+v45
	n5S2PnYN/SZ9HvWjq8J7KYosfJGfCVO9+YiHF3EwU1bwavaIRHma81TEYm8hmdzQsg63phRO/LC
	jnvC4YgrqV6bf0VCzcidtisk2kCuXcncFIAcupduCLFxdSFfTaciuuHRrvTksyruGEZCdE19L8u
	U4ONyMsnCbFUK8DOZGoVahWdFpnRxrFIy6TW8e9Kgc72urfHeMe4MROlftoyzMKw7mDlFfOz7YR
	TeAqp1czI/MPsnp1NhrmktG89Y62A5xL6uPp8anUryA==
X-Google-Smtp-Source: AGHT+IFvciUzGVR76F9xK8W34u3dzu+2Ey5Zvj5S+7X2uhfCWuHp56jf8LSA9fqdDSGbyjccplbVpw==
X-Received: by 2002:a05:6000:40de:b0:3e9:978e:48fd with SMTP id ffacd0b85a97d-3e9978e8e25mr425560f8f.23.1757792029267;
        Sat, 13 Sep 2025 12:33:49 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7ff9f77c4sm4948753f8f.27.2025.09.13.12.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 12:33:48 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 11/13] libbpf: support llvm-generated indirect jumps
Date: Sat, 13 Sep 2025 19:39:20 +0000
Message-Id: <20250913193922.1910480-12-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
References: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
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
 tools/lib/bpf/libbpf.c        | 150 +++++++++++++++++++++++++++++++++-
 tools/lib/bpf/libbpf_probes.c |   4 +
 tools/lib/bpf/linker.c        |  10 ++-
 3 files changed, 161 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2c1f48f77680..57cac0810d2e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -191,6 +191,7 @@ static const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_USER_RINGBUF]             = "user_ringbuf",
 	[BPF_MAP_TYPE_CGRP_STORAGE]		= "cgrp_storage",
 	[BPF_MAP_TYPE_ARENA]			= "arena",
+	[BPF_MAP_TYPE_INSN_ARRAY]		= "insn_array",
 };
 
 static const char * const prog_type_name[] = {
@@ -372,6 +373,7 @@ enum reloc_type {
 	RELO_EXTERN_CALL,
 	RELO_SUBPROG_ADDR,
 	RELO_CORE,
+	RELO_INSN_ARRAY,
 };
 
 struct reloc_desc {
@@ -382,7 +384,10 @@ struct reloc_desc {
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
@@ -424,6 +429,11 @@ struct bpf_sec_def {
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
@@ -496,6 +506,9 @@ struct bpf_program {
 	__u32 line_info_rec_size;
 	__u32 line_info_cnt;
 	__u32 prog_flags;
+
+	struct bpf_light_subprog *subprog;
+	__u32 subprog_cnt;
 };
 
 struct bpf_struct_ops {
@@ -525,6 +538,7 @@ struct bpf_struct_ops {
 #define STRUCT_OPS_SEC ".struct_ops"
 #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
 #define ARENA_SEC ".addr_space.1"
+#define JUMPTABLES_SEC ".jumptables"
 
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -668,6 +682,7 @@ struct elf_state {
 	int symbols_shndx;
 	bool has_st_ops;
 	int arena_data_shndx;
+	int jumptables_data_shndx;
 };
 
 struct usdt_manager;
@@ -739,6 +754,9 @@ struct bpf_object {
 	void *arena_data;
 	size_t arena_data_sz;
 
+	void *jumptables_data;
+	size_t jumptables_data_sz;
+
 	struct kern_feature_cache *feat_cache;
 	char *token_path;
 	int token_fd;
@@ -765,6 +783,7 @@ void bpf_program__unload(struct bpf_program *prog)
 
 	zfree(&prog->func_info);
 	zfree(&prog->line_info);
+	zfree(&prog->subprog);
 }
 
 static void bpf_program__exit(struct bpf_program *prog)
@@ -3945,6 +3964,13 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
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
@@ -4599,6 +4625,16 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
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
@@ -6101,6 +6137,74 @@ static void poison_kfunc_call(struct bpf_program *prog, int relo_idx,
 	insn->imm = POISON_CALL_KFUNC_BASE + ext_idx;
 }
 
+static int create_jt_map(struct bpf_object *obj, int off, int size, int adjust_off)
+{
+	const __u32 value_size = sizeof(struct bpf_insn_array_value);
+	const __u32 max_entries = size / value_size;
+	struct bpf_insn_array_value val = {};
+	int map_fd, err;
+	__u64 xlated_off;
+	__u64 *jt;
+	__u32 i;
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_INSN_ARRAY, "jt",
+				4, value_size, max_entries, NULL);
+	if (map_fd < 0)
+		return map_fd;
+
+	if (!obj->jumptables_data) {
+		pr_warn("object contains no jumptables_data\n");
+		return -EINVAL;
+	}
+	if ((off + size) > obj->jumptables_data_sz) {
+		pr_warn("jumptables_data size is %zd, trying to access %d\n",
+			obj->jumptables_data_sz, off + size);
+		return -EINVAL;
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
+			return -EINVAL;
+		}
+
+		val.xlated_off = xlated_off;
+		err = bpf_map_update_elem(map_fd, &i, &val, 0);
+		if (err) {
+			close(map_fd);
+			return err;
+		}
+	}
+	return map_fd;
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
+	for (i = prog->subprog_cnt - 1; i >= 0; i--)
+		if (insn_idx >= prog->subprog[i].sub_insn_off)
+			return prog->subprog[i].sub_insn_off - prog->subprog[i].sec_insn_off;
+
+	return -prog->sec_insn_off;
+}
+
+
 /* Relocate data references within program code:
  *  - map references;
  *  - global variable references;
@@ -6192,6 +6296,21 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 		case RELO_CORE:
 			/* will be handled by bpf_program_record_relos() */
 			break;
+		case RELO_INSN_ARRAY: {
+			int map_fd;
+
+			map_fd = create_jt_map(obj, relo->sym_off, relo->sym_size,
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
@@ -6389,6 +6508,24 @@ static int append_subprog_relos(struct bpf_program *main_prog, struct bpf_progra
 	return 0;
 }
 
+static int save_subprog_offsets(struct bpf_program *main_prog, struct bpf_program *subprog)
+{
+	size_t size = sizeof(main_prog->subprog[0]);
+	int new_cnt = main_prog->subprog_cnt + 1;
+	void *tmp;
+
+	tmp = libbpf_reallocarray(main_prog->subprog, new_cnt, size);
+	if (!tmp)
+		return -ENOMEM;
+
+	main_prog->subprog = tmp;
+	main_prog->subprog[new_cnt - 1].sec_insn_off = subprog->sec_insn_off;
+	main_prog->subprog[new_cnt - 1].sub_insn_off = subprog->sub_insn_off;
+	main_prog->subprog_cnt = new_cnt;
+
+	return 0;
+}
+
 static int
 bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_program *main_prog,
 				struct bpf_program *subprog)
@@ -6418,6 +6555,14 @@ bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_program *main
 	err = append_subprog_relos(main_prog, subprog);
 	if (err)
 		return err;
+
+	/* Save subprogram offsets */
+	err = save_subprog_offsets(main_prog, subprog);
+	if (err) {
+		pr_warn("prog '%s': failed to add subprog offsets\n", main_prog->name);
+		return err;
+	}
+
 	return 0;
 }
 
@@ -9185,6 +9330,9 @@ void bpf_object__close(struct bpf_object *obj)
 
 	zfree(&obj->arena_data);
 
+	zfree(&obj->jumptables_data);
+	obj->jumptables_data_sz = 0;
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
index a469e5d4fee7..d1585baa9f14 100644
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
+				} else if (strcmp(src_sec->sec_name, JUMPTABLES_REL_SEC)) {
+					pr_warn("relocation against STT_SECTION in section %s is not supported!\n",
+						src_sec->sec_name);
 					return -EINVAL;
 				}
 			}
-- 
2.34.1


