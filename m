Return-Path: <bpf+bounces-65827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8615FB29003
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 20:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55527AE5ECF
	for <lists+bpf@lfdr.de>; Sat, 16 Aug 2025 18:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE1A304964;
	Sat, 16 Aug 2025 18:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZDSpieK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41104302777
	for <bpf@vger.kernel.org>; Sat, 16 Aug 2025 18:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755367334; cv=none; b=j8Dw4nE0W9kZfKdIP52Ysbw3KqfDoOEHWjHQ6udHsSYFBXXpMXd9OEEk6TKZOqjGog5pekhI6xjJ+nCupelEccY+eqzMF7tyBmxmmWHG0ke4OlmmFqDVeqKiH8X/1Srv7seOGZA4YaVAIu1dH9wtzidNC8bHwMLbOTbyUs7Tz+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755367334; c=relaxed/simple;
	bh=Brpf8SqzYzbKSLgUG/6b6BJJMCTgCPXaWxxmsQkzvXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e6laVG9JHKObFvwQaelRvwYz5Y5F648K3WCVRqja54Wfg9nnBv3F22nUTK+1HYkaOx2p3fK88RzrqojrmZqj+X1ikI76hPWRBpGJCXVsTNagaCgyCa0GhyuD+wNHRyTN1iNg9wWXhCplC8IYu8dycD2gaP4qWfLpp/KlvWD2ynw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IZDSpieK; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b9e414ef53so2840314f8f.2
        for <bpf@vger.kernel.org>; Sat, 16 Aug 2025 11:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755367330; x=1755972130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NW1fpUW+Qdz+AYW15D1LJbRQ7daeI3WyA9wV+jFd/w=;
        b=IZDSpieKg1nNPO3zZL6LnC47+IXvOCWF3GCyuwhkgDW+SARXM041LxIKwJXYIDv0o+
         1n7fleEo9Etzd9Jlu8MxdfWmBEIrLnDjMROSnzNODRcq9yy4Wem4VASKKxRtEFHDAKF0
         QeUm6Nym+pjlabzECALSRFsszeQzdoS4Cn11FGz2Z7YH/v8GL20ZuEf1LuBhJT0yfKmF
         1Xp0huV5VhvlEJHAiClW9ELbeCPs23pdofwHjJIG5dkW9VETTY69BkXKwJ2IMzb9Aioe
         fPJ7gz19YeIpHETIJkWRkLr9jYHVqY6SEA1AmW1BtVGT9y4+x6T5ljakY+QgMbSzzyfZ
         x9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755367330; x=1755972130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NW1fpUW+Qdz+AYW15D1LJbRQ7daeI3WyA9wV+jFd/w=;
        b=rWdOtTZUQIU61eYvy/d95B3xMAl/ZkyN5fOgB21MyscHchVuZtLgrd3WjZgrRVGpk9
         7BLeEISw8D4r1EecJeinN0l8vZLu7F6LQ0g7y7349RUBaac64pCxPdad7zA1EMdOVQnm
         C/pRH0prL87yFjavjh5f9MIXwlAc9TnfP8aobHvANw4u9Ftd4MW1J/t0b9cj3U1oTdJB
         KNpu4vzknH8b/rA1IjJY3DaeJtHbJU/IAJz4pzQNdN3FphRHa3KxgyZ9RYTBmlyKu/gY
         fK6RwnRjbL+ZjYLR1ksFvndSZWGIdgB+5SqxprcrbH6hGxaxoXXJvhJKms4QAsRp3I73
         8OCA==
X-Gm-Message-State: AOJu0YxfpfqI8rRwihNiAL7SSSb52CcRcNeXkFJ4tdPHGdybHDvrRAc5
	1xLXgJ8F0JHl7JPOq7i/Npc0at6ysSD4mhYJQJWT4WlRdnOBcoy5sabXlgmefQ==
X-Gm-Gg: ASbGnctaJYB6TP8/HVwWeQsHZ1NFbZ0D0ouaD73mPk4VKumbS/N1wIxUHpwkZu0dMwi
	Bo2BMlt9NMiTD3D59Nx6CNTkh0vvFkEcnGIwnH6inaPu7IovzVs5LMAUctDHS50Io0r4mX79CRk
	SrxH7DiS9KvCid5xT0FF0dF3dJBwsRZVYSXyzLsM/Caet6C7Dnmng4Q3SycWeKKBUvJEwEih+ym
	t1eyIMZPNBv4Ghu3jxP0JA/P8sUSNiwFogPMgyWBgLMwJ9skVFzej0zIRcKCacPRCrgYCC2TeNb
	XruK9Nok629hAzRFZUtv6ZEWG+pDv31fdxYqiGGQcUMhYCa71ul+by9j/7WkVwq7df2uEdtnzFD
	ccpN7cYHk9WDalNFWuqcIOnczRoFLcoMmDM3XWXgd/6s=
X-Google-Smtp-Source: AGHT+IGVTWqvn2Jqf7O4uvXTqlHduktyH91m0OwCf6+turRdrIpo9cDVGkHYQEFJnOanEH04qR4Tlg==
X-Received: by 2002:a05:6000:188c:b0:3b4:9721:2b2d with SMTP id ffacd0b85a97d-3bb667532b4mr4545680f8f.9.1755367329793;
        Sat, 16 Aug 2025 11:02:09 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bd736b88besm1080193f8f.67.2025.08.16.11.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 11:02:08 -0700 (PDT)
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
Subject: [PATCH v1 bpf-next 10/11] libbpf: support llvm-generated indirect jumps
Date: Sat, 16 Aug 2025 18:06:30 +0000
Message-Id: <20250816180631.952085-11-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250816180631.952085-1-a.s.protopopov@gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For v5 instruction set, LLVM now is allowed to generate indirect
jumps for switch statements and for 'goto *rX' assembly. Every such a
jump will be accompanied by necessary metadata, e.g. (`llvm-objdump
-Sr ...`):

       0:       r2 = 0x0 ll
                0000000000000030:  R_BPF_64_64  BPF.JT.0.0

Here BPF.JT.1.0 is a symbol residing in the .jumptables section:

    Symbol table:
       4: 0000000000000000   240 OBJECT  GLOBAL DEFAULT     4 BPF.JT.0.0

The -bpf-min-jump-table-entries llvm option may be used to control
the minimal size of a switch which will be converted to an indirect
jumps.

The code generated by LLVM for a switch will look, approximately,
like this:

    0: rX <- jump_table_x[i]
    2: rX <<= 3
    3: gotox *rX

Right now there is no robust way to associate the jump with the
corresponding map, so libbpf doesn't insert map file descriptor
inside the gotox instruction.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 .../bpf/bpftool/Documentation/bpftool-map.rst |   2 +-
 tools/bpf/bpftool/map.c                       |   2 +-
 tools/lib/bpf/libbpf.c                        | 159 +++++++++++++++---
 tools/lib/bpf/libbpf_probes.c                 |   4 +
 tools/lib/bpf/linker.c                        |  12 +-
 5 files changed, 153 insertions(+), 26 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 252e4c538edb..3377d4a01c62 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -55,7 +55,7 @@ MAP COMMANDS
 |     | **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap** | **sockhash**
 |     | **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
 |     | **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage**
-|     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena** }
+|     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena** | **insn_array** }
 
 DESCRIPTION
 ===========
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index c9de44a45778..79b90f274bef 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1477,7 +1477,7 @@ static int do_help(int argc, char **argv)
 		"                 devmap | devmap_hash | sockmap | cpumap | xskmap | sockhash |\n"
 		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
 		"                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage |\n"
-		"                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena }\n"
+		"                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena | insn_array }\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
 		"                    {-f|--bpffs} | {-n|--nomount} }\n"
 		"",
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fe4fc5438678..a5f04544c09c 100644
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
@@ -383,6 +385,7 @@ struct reloc_desc {
 			int map_idx;
 			int sym_off;
 			int ext_idx;
+			int sym_size;
 		};
 	};
 };
@@ -496,6 +499,10 @@ struct bpf_program {
 	__u32 line_info_rec_size;
 	__u32 line_info_cnt;
 	__u32 prog_flags;
+
+	__u32 subprog_offset[256];
+	__u32 subprog_sec_offst[256];
+	__u32 subprog_cnt;
 };
 
 struct bpf_struct_ops {
@@ -525,6 +532,7 @@ struct bpf_struct_ops {
 #define STRUCT_OPS_SEC ".struct_ops"
 #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
 #define ARENA_SEC ".addr_space.1"
+#define JUMPTABLES_SEC ".jumptables"
 
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -658,6 +666,7 @@ struct elf_state {
 	Elf64_Ehdr *ehdr;
 	Elf_Data *symbols;
 	Elf_Data *arena_data;
+	Elf_Data jumptables_data;
 	size_t shstrndx; /* section index for section name strings */
 	size_t strtabidx;
 	struct elf_sec_desc *secs;
@@ -668,6 +677,7 @@ struct elf_state {
 	int symbols_shndx;
 	bool has_st_ops;
 	int arena_data_shndx;
+	int jumptables_data_shndx;
 };
 
 struct usdt_manager;
@@ -3945,6 +3955,9 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			} else if (strcmp(name, ARENA_SEC) == 0) {
 				obj->efile.arena_data = data;
 				obj->efile.arena_data_shndx = idx;
+			} else if (strcmp(name, JUMPTABLES_SEC) == 0) {
+				memcpy(&obj->efile.jumptables_data, data, sizeof(*data));
+				obj->efile.jumptables_data_shndx = idx;
 			} else {
 				pr_info("elf: skipping unrecognized data section(%d) %s\n",
 					idx, name);
@@ -4599,6 +4612,16 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
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
@@ -6101,6 +6124,60 @@ static void poison_kfunc_call(struct bpf_program *prog, int relo_idx,
 	insn->imm = POISON_CALL_KFUNC_BASE + ext_idx;
 }
 
+static int create_jt_map(struct bpf_object *obj, int off, int size, int adjust_off)
+{
+	static union bpf_attr attr = {
+		.map_type = BPF_MAP_TYPE_INSN_ARRAY,
+		.key_size = 4,
+		.value_size = sizeof(struct bpf_insn_array_value),
+		.max_entries = 0,
+	};
+	struct bpf_insn_array_value val = {};
+	int map_fd;
+	int err;
+	__u32 i;
+	__u32 *jt;
+
+	attr.max_entries = size / 8;
+
+	map_fd = syscall(__NR_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
+	if (map_fd < 0)
+		return map_fd;
+
+	jt = (__u32 *)(obj->efile.jumptables_data.d_buf + off);
+	if (!jt)
+		return -EINVAL;
+
+	for (i = 0; i < attr.max_entries; i++) {
+		val.xlated_off = jt[2*i]/8 + adjust_off;
+		err = bpf_map_update_elem(map_fd, &i, &val, 0);
+		if (err) {
+			close(map_fd);
+			return err;
+		}
+	}
+
+	err = bpf_map_freeze(map_fd);
+	if (err) {
+		close(map_fd);
+		return err;
+	}
+
+	return map_fd;
+}
+
+static int subprog_insn_off(struct bpf_program *prog, int insn_idx)
+{
+	int i;
+
+	for (i = prog->subprog_cnt - 1; i >= 0; i--)
+		if (insn_idx >= prog->subprog_offset[i])
+			return prog->subprog_offset[i] - prog->subprog_sec_offst[i];
+
+	return -prog->sec_insn_off;
+}
+
+
 /* Relocate data references within program code:
  *  - map references;
  *  - global variable references;
@@ -6192,6 +6269,21 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 		case RELO_CORE:
 			/* will be handled by bpf_program_record_relos() */
 			break;
+		case RELO_INSN_ARRAY: {
+			int map_fd;
+
+			map_fd = create_jt_map(obj, relo->sym_off, relo->sym_size,
+					       subprog_insn_off(prog, relo->insn_idx));
+			if (map_fd < 0) {
+				pr_warn("prog '%s': relo #%d: failed to create a jt map for sym_off=%u\n",
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
@@ -6389,36 +6481,58 @@ static int append_subprog_relos(struct bpf_program *main_prog, struct bpf_progra
 	return 0;
 }
 
+static int
+bpf_prog__append_subprog_offsets(struct bpf_program *prog, __u32 sec_insn_off, __u32 sub_insn_off)
+{
+	if (prog->subprog_cnt == ARRAY_SIZE(prog->subprog_sec_offst)) {
+		pr_warn("prog '%s': number of subprogs exceeds %zu\n",
+			prog->name, ARRAY_SIZE(prog->subprog_sec_offst));
+		return -E2BIG;
+	}
+
+	prog->subprog_sec_offst[prog->subprog_cnt] = sec_insn_off;
+	prog->subprog_offset[prog->subprog_cnt] = sub_insn_off;
+
+	prog->subprog_cnt += 1;
+	return 0;
+}
+
 static int
 bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_program *main_prog,
-				struct bpf_program *subprog)
+		struct bpf_program *subprog)
 {
-       struct bpf_insn *insns;
-       size_t new_cnt;
-       int err;
+	struct bpf_insn *insns;
+	size_t new_cnt;
+	int err;
 
-       subprog->sub_insn_off = main_prog->insns_cnt;
+	subprog->sub_insn_off = main_prog->insns_cnt;
 
-       new_cnt = main_prog->insns_cnt + subprog->insns_cnt;
-       insns = libbpf_reallocarray(main_prog->insns, new_cnt, sizeof(*insns));
-       if (!insns) {
-               pr_warn("prog '%s': failed to realloc prog code\n", main_prog->name);
-               return -ENOMEM;
-       }
-       main_prog->insns = insns;
-       main_prog->insns_cnt = new_cnt;
+	new_cnt = main_prog->insns_cnt + subprog->insns_cnt;
+	insns = libbpf_reallocarray(main_prog->insns, new_cnt, sizeof(*insns));
+	if (!insns) {
+		pr_warn("prog '%s': failed to realloc prog code\n", main_prog->name);
+		return -ENOMEM;
+	}
+	main_prog->insns = insns;
+	main_prog->insns_cnt = new_cnt;
 
-       memcpy(main_prog->insns + subprog->sub_insn_off, subprog->insns,
-              subprog->insns_cnt * sizeof(*insns));
+	memcpy(main_prog->insns + subprog->sub_insn_off, subprog->insns,
+			subprog->insns_cnt * sizeof(*insns));
 
-       pr_debug("prog '%s': added %zu insns from sub-prog '%s'\n",
-                main_prog->name, subprog->insns_cnt, subprog->name);
+	pr_debug("prog '%s': added %zu insns from sub-prog '%s'\n",
+			main_prog->name, subprog->insns_cnt, subprog->name);
 
-       /* The subprog insns are now appended. Append its relos too. */
-       err = append_subprog_relos(main_prog, subprog);
-       if (err)
-               return err;
-       return 0;
+	/* The subprog insns are now appended. Append its relos too. */
+	err = append_subprog_relos(main_prog, subprog);
+	if (err)
+		return err;
+
+	err = bpf_prog__append_subprog_offsets(main_prog, subprog->sec_insn_off,
+					       subprog->sub_insn_off);
+	if (err)
+		return err;
+
+	return 0;
 }
 
 static int
@@ -7954,6 +8068,7 @@ static int bpf_object_prepare_progs(struct bpf_object *obj)
 		if (err)
 			return err;
 	}
+
 	return 0;
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
index a469e5d4fee7..827867f8bba3 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -28,6 +28,9 @@
 #include "str_error.h"
 
 #define BTF_EXTERN_SEC ".extern"
+#define RODATA_REL_SEC ".rel.rodata"
+#define JUMPTABLES_SEC ".jumptables"
+#define JUMPTABLES_REL_SEC ".rel.jumptables"
 
 struct src_sec {
 	const char *sec_name;
@@ -2026,6 +2029,9 @@ static int linker_append_elf_sym(struct bpf_linker *linker, struct src_obj *obj,
 			obj->sym_map[src_sym_idx] = dst_sec->sec_sym_idx;
 			return 0;
 		}
+
+		if (!strcmp(src_sec->sec_name, JUMPTABLES_SEC))
+			goto add_sym;
 	}
 
 	if (sym_bind == STB_LOCAL)
@@ -2272,8 +2278,10 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
 						insn->imm += sec->dst_off / sizeof(struct bpf_insn);
 					else
 						insn->imm += sec->dst_off;
-				} else {
-					pr_warn("relocation against STT_SECTION in non-exec section is not supported!\n");
+				} else if (strcmp(src_sec->sec_name, JUMPTABLES_REL_SEC) &&
+					   strcmp(src_sec->sec_name, RODATA_REL_SEC)) {
+					pr_warn("relocation against STT_SECTION in section %s is not supported!\n",
+						src_sec->sec_name);
 					return -EINVAL;
 				}
 			}
-- 
2.34.1


