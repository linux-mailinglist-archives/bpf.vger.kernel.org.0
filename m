Return-Path: <bpf+bounces-60681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BCAADA165
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 10:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403AC170E64
	for <lists+bpf@lfdr.de>; Sun, 15 Jun 2025 08:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465EC266582;
	Sun, 15 Jun 2025 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nW21hzBe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3E1264616
	for <bpf@vger.kernel.org>; Sun, 15 Jun 2025 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749977740; cv=none; b=WfUYfB1leVkngbBmFn34s+Ibq0wMYRB1lLukPSS/+VSqOpz0eK3wK8diLB6kd2V6pGS155MVF/sbirFcE/tZ6yIRj8kAUDbo4TzQFJ1dzDhehes1CsJhnUM4zt1VujbQSkv4PRkmyrdCQmphB3aYdfQi/LPeMFtbwZRxYX8hbyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749977740; c=relaxed/simple;
	bh=g7X01Z38wHRvJ68IJJNQJDEdYOgRk1dmmc5jmDP20cs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c+5q3ZaUmXVmSS9y6eW9wvWrcO71l6PmyKCZnSDFCpxaJCaAyCmZOJS34QwWRcikgJxtAYCzjDipa2v0jnFa8PZmzg6s5p8ZywjT8I8KlKUgNTSunIL4miKZsshBKRr8nlrkOME9o3/7PBytorNXyLfb4J7NbGDchHv34j9Gvqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nW21hzBe; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a52874d593so3476508f8f.0
        for <bpf@vger.kernel.org>; Sun, 15 Jun 2025 01:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749977735; x=1750582535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvRHGOwZk/p83QQHtNPYUdpCo0OCixEy+aItQHXm45Q=;
        b=nW21hzBeFXS3g7fKBAKfHKJ+qEDpggtHEAdEUcJTztgw7CWal0qagldk33QOcXg+DU
         rj/jL+yJ2c3O/+Gjaz7fg3zi9+ouZDcVmUYvS1goHRbpYEsAmYBDuI+ut4Q6hlq7Dnci
         UCZUZc1HIJtKqyDMQM5IrI/AXltzBE6LZTBOqFVzyr8/jqRK/t1Yky5bAtvS9PBgwyv/
         3QULcG+9e4jNYJyR5Z+KyU0pxWfaeF2is+U/wGJUn8AeIbtNqD4wz9At+tvZrYrky2/L
         kc3gQ+NrIpQRqEz8BK/UkFIhLttXzo9Kync3+KZg2JY7zZXsrKAGlKabbqHl1R++FOUW
         z47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749977735; x=1750582535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvRHGOwZk/p83QQHtNPYUdpCo0OCixEy+aItQHXm45Q=;
        b=QIdKq9mgszHZmmOYfP1T/JMfYxnqfmWFN3+K3wRhElJ6985zEbM7dPLzhrRB8aj+n6
         5TOMeLOgnfPx2rWyzSS6cQ1uhIIXvgbe1IrxCtyrQNFgL9NzhW5yapFV1R6U7E1Qtx6N
         uPxOSP1kN9QW3bE7axpsS/mCTHWEjbnAYFxBya+1MXsXb6v13+KBDrRkIUsYLv4BEUZT
         SJnTGlVU9MADMntSWSNQ3JWGqglfujlaKirT9v8bymFjpDd6VIoXwEh3Z3jaOM9lUDXM
         8L1KP3OlZkHxSNMpu7PM+RdCXFswShIUUeIbh1G7jE33wwCBcEwx1MRjjdEIrC7rZJwU
         9cKQ==
X-Gm-Message-State: AOJu0YyqHG2xiS3rrSqwaxzttMxIfK2OSh66FAi0ySdh/hqeRwwRpMOH
	jCN8B2IEn7DPQhE8xQmHBnbee3/NPH71IcsZxRqg7RjFx7PfCXnOoxOZPH3nCw==
X-Gm-Gg: ASbGncs8ScEj+BbpUSawTBkRek4BkorPFL3Us/7okqTR1tX/li2xtZoz99OvJ9FWmtn
	aqmsfWuG6aUNNF/0jhwk3C9PkTsHGla032a0y7jL+GhVgfMWexIUxWGoNf/ixptakjrvSEPEzHt
	+J6PT8GuSWjCyEbcqaOYpeZ35GEkjBSpy1TrZcBNjoWmPJ/h/mhji2ODXxTK4BETio8xFqhMOb+
	e/ADyVUCpS7QTEFPDV8e4YztR9hD4pZk6mJeTMfLpXSahfS13/5UgYpNvsz41BjlxUZwvaVVhe6
	Aye9AdIGNYiUhCrYBCWd9RyAdPGekkG0HLYRRo5+OBAmcRHwzKRxhOSQ6uqBGDlARY2YRLKys0O
	YgaxqoA==
X-Google-Smtp-Source: AGHT+IHQbn9arJttZOiN+MENdYgRXMtpR7vJ894FeiofhXZq3AiXatXh46HhGhOBghBrjS+EPl0LPQ==
X-Received: by 2002:a05:6000:250c:b0:399:6dd9:9f40 with SMTP id ffacd0b85a97d-3a5723678b8mr5593031f8f.9.1749977735053;
        Sun, 15 Jun 2025 01:55:35 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a633ddsm7196105f8f.26.2025.06.15.01.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 01:55:34 -0700 (PDT)
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
Subject: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
Date: Sun, 15 Jun 2025 08:59:42 +0000
Message-Id: <20250615085943.3871208-9-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For v5 instruction set, LLVM now is allowed to generate indirect
jumps for switch statements. Every such a jump will be accompanied
by necessary metadata (enabled by -emit-jump-table-sizes-section).
The -bpf-min-jump-table-entries llvm option may be used to control
the minimal size of a jump table which will be converted to an
indirect jumps.

For a given switch the following data will be generated by LLVM:
.rodata will contain actual addresses, .llvm_jump_table_sizes
and .rel.llvm_jump_table_sizes tables provide meta-data necessary
to find and relocate the offsets.

The code generated by LLVM for a switch will look, approximately,
like this:

    0: rX <- jump_table_x[i]
    2: rX *= rX
    3: gotox rX

This code will be rejected by the verifier as is. First
transformation required here is that jump_table_x at the insn(0)
actually points to the `.rodata` section (map). So for such loads
libbpf should create a proper map of type BPF_MAP_TYPE_INSN_SET,
using the aforementioned meta-data.

Then, in the insn(2) the address in rX gets dereferenced to point to
an actual instruction address. (From the verifier's point of view,
the rX changes type from PTR_TO_MAP_VALUE to PTR_TO_INSN.)

The final line generates an indirect jump. The
format of the indirect jump instruction supported by BPF is

    BPF_JMP|BPF_X|BPF_JA, SRC=0, DST=Rx, off=0, imm=fd(M)

and, obviously, the map M must be the same map which was used to
init the register rX. This patch implements this in the following,
hacky, but so far suitable for all existing use-cases, way. On
encountering a `gotox` instruction libbpf tracks back to the
previous direct load from map and stores this map file descriptor
in the gotox instruction.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/lib/bpf/libbpf.c          | 333 +++++++++++++++++++++++++++++---
 tools/lib/bpf/libbpf_internal.h |   4 +
 tools/lib/bpf/linker.c          |  66 ++++++-
 3 files changed, 376 insertions(+), 27 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6445165a24f2..a4cc15c8a3c0 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -496,6 +496,10 @@ struct bpf_program {
 	__u32 line_info_rec_size;
 	__u32 line_info_cnt;
 	__u32 prog_flags;
+
+	__u32 subprog_offset[256];
+	__u32 subprog_sec_offst[256];
+	__u32 subprog_cnt;
 };
 
 struct bpf_struct_ops {
@@ -525,6 +529,7 @@ struct bpf_struct_ops {
 #define STRUCT_OPS_SEC ".struct_ops"
 #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
 #define ARENA_SEC ".addr_space.1"
+#define LLVM_JT_SIZES_SEC ".llvm_jump_table_sizes"
 
 enum libbpf_map_type {
 	LIBBPF_MAP_UNSPEC,
@@ -658,6 +663,7 @@ struct elf_state {
 	Elf64_Ehdr *ehdr;
 	Elf_Data *symbols;
 	Elf_Data *arena_data;
+	Elf_Data *jt_sizes_data;
 	size_t shstrndx; /* section index for section name strings */
 	size_t strtabidx;
 	struct elf_sec_desc *secs;
@@ -668,6 +674,7 @@ struct elf_state {
 	int symbols_shndx;
 	bool has_st_ops;
 	int arena_data_shndx;
+	int jt_sizes_data_shndx;
 };
 
 struct usdt_manager;
@@ -678,6 +685,13 @@ enum bpf_object_state {
 	OBJ_LOADED,
 };
 
+struct jt {
+	__u64 insn_off; /* unique offset within .rodata */
+
+	size_t jump_target_cnt;
+	__u32 jump_target[];
+};
+
 struct bpf_object {
 	char name[BPF_OBJ_NAME_LEN];
 	char license[64];
@@ -698,6 +712,14 @@ struct bpf_object {
 	bool has_subcalls;
 	bool has_rodata;
 
+	const void *rodata;
+	size_t rodata_size;
+	int rodata_map_fd;
+
+	/* Jump Tables */
+	struct jt **jt;
+	size_t jt_cnt;
+
 	struct bpf_gen *gen_loader;
 
 	/* Information when doing ELF related work. Only valid if efile.elf is not NULL */
@@ -1888,6 +1910,98 @@ static char *internal_map_name(struct bpf_object *obj, const char *real_name)
 	return strdup(map_name);
 }
 
+static const struct jt *bpf_object__find_jt(struct bpf_object *obj, __u64 insn_off)
+{
+	size_t i;
+
+	for (i = 0; i < obj->jt_cnt; i++)
+		if (obj->jt[i]->insn_off == insn_off)
+			return obj->jt[i];
+
+	return ERR_PTR(-ENOENT);
+}
+
+static int bpf_object__alloc_jt(struct bpf_object *obj, __u64 insn_off, __u64 size)
+{
+	__u64 i, jump_target;
+	struct jt *jt;
+	int err = 0;
+	void *x;
+
+	jt = calloc(1, sizeof(struct jt) + sizeof(jt->jump_target[0])*size);
+	if (!jt)
+		return -ENOMEM;
+
+	jt->insn_off = insn_off;
+	jt->jump_target_cnt = size;
+
+	for (i = 0; i < size; i++) {
+		if (i + insn_off > obj->rodata_size / 8) {
+			pr_warn("can't resolve a pointer to .rodata[%llu]: rodata size is %lu!\n",
+				(i + insn_off) * 8, obj->rodata_size);
+			err = -EINVAL;
+			goto ret;
+		}
+
+		jump_target = ((__u64 *)obj->rodata)[insn_off + i] / 8;
+		if (jump_target > UINT32_MAX) {
+			pr_warn("jump target is too big: 0x%016llx!\n", jump_target);
+			err = -EINVAL;
+			goto ret;
+		}
+		jt->jump_target[i] = jump_target;
+	}
+
+	x = realloc(obj->jt, (obj->jt_cnt + 1) * sizeof(long));
+	if (!x) {
+		err = -ENOMEM;
+		goto ret;
+	}
+	obj->jt = x;
+	obj->jt[obj->jt_cnt++] = jt;
+
+ret:
+	if (err)
+		free(jt);
+	return err;
+}
+
+static int bpf_object__add_jt(struct bpf_object *obj, __u64 insn_off, __u64 size)
+{
+	if (!obj->rodata) {
+		pr_warn("attempt to add a jump table, but no .rodata present!\n");
+		return -EINVAL;
+	}
+
+	if (!IS_ERR(bpf_object__find_jt(obj, insn_off)))
+		return -EINVAL;
+
+	return bpf_object__alloc_jt(obj, insn_off, size);
+}
+
+static int bpf_object__collect_jt(struct bpf_object *obj)
+{
+	Elf_Data *data = obj->efile.jt_sizes_data;
+	__u64 *buf;
+	size_t i;
+	int err;
+
+	if (!data)
+		return 0;
+
+	buf = (__u64 *)data->d_buf;
+	for (i = 0; i < data->d_size / 16; i++) {
+		__u64 off = buf[2*i];
+		__u64 size = buf[2*i+1];
+
+		err = bpf_object__add_jt(obj, off / 8, size);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int
 map_fill_btf_type_info(struct bpf_object *obj, struct bpf_map *map);
 
@@ -1978,6 +2092,10 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
 	if (data)
 		memcpy(map->mmaped, data, data_sz);
 
+	/* Save this file descriptor */
+	if (type == LIBBPF_MAP_RODATA)
+		obj->rodata_map_fd = map->fd;
+
 	pr_debug("map %td is \"%s\"\n", map - obj->maps, map->name);
 	return 0;
 }
@@ -2008,6 +2126,8 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
 			break;
 		case SEC_RODATA:
 			obj->has_rodata = true;
+			obj->rodata = sec_desc->data->d_buf;
+			obj->rodata_size = sec_desc->data->d_size;
 			sec_name = elf_sec_name(obj, elf_sec_by_idx(obj, sec_idx));
 			err = bpf_object__init_internal_map(obj, LIBBPF_MAP_RODATA,
 							    sec_name, sec_idx,
@@ -3961,7 +4081,9 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			    strcmp(name, ".rel" STRUCT_OPS_LINK_SEC) &&
 			    strcmp(name, ".rel?" STRUCT_OPS_SEC) &&
 			    strcmp(name, ".rel?" STRUCT_OPS_LINK_SEC) &&
-			    strcmp(name, ".rel" MAPS_ELF_SEC)) {
+			    strcmp(name, ".rel" MAPS_ELF_SEC) &&
+			    strcmp(name, ".rel" LLVM_JT_SIZES_SEC) &&
+			    strcmp(name, ".rel" RODATA_SEC)) {
 				pr_info("elf: skipping relo section(%d) %s for section(%d) %s\n",
 					idx, name, targ_sec_idx,
 					elf_sec_name(obj, elf_sec_by_idx(obj, targ_sec_idx)) ?: "<?>");
@@ -3976,6 +4098,10 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			sec_desc->sec_type = SEC_BSS;
 			sec_desc->shdr = sh;
 			sec_desc->data = data;
+
+		} else if (sh->sh_type == SHT_LLVM_JT_SIZES) {
+			obj->efile.jt_sizes_data = data;
+			obj->efile.jt_sizes_data_shndx = idx;
 		} else {
 			pr_info("elf: skipping section(%d) %s (size %zu)\n", idx, name,
 				(size_t)sh->sh_size);
@@ -6078,6 +6204,59 @@ static void poison_kfunc_call(struct bpf_program *prog, int relo_idx,
 	insn->imm = POISON_CALL_KFUNC_BASE + ext_idx;
 }
 
+static bool map_fd_is_rodata(struct bpf_object *obj, int map_fd)
+{
+	return map_fd == obj->rodata_map_fd;
+}
+
+static int create_jt_map(const struct jt *jt, int adjust_off)
+{
+	static union bpf_attr attr = {
+		.map_type = BPF_MAP_TYPE_INSN_SET,
+		.key_size = 4,
+		.value_size = sizeof(struct bpf_insn_set_value),
+		.max_entries = 0,
+	};
+	struct bpf_insn_set_value val = {};
+	int map_fd;
+	int err;
+	__u32 i;
+
+	attr.max_entries = jt->jump_target_cnt;
+
+	map_fd = syscall(__NR_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
+	if (map_fd < 0)
+		return map_fd;
+
+	for (i = 0; i < jt->jump_target_cnt; i++) {
+		val.xlated_off = jt->jump_target[i] + adjust_off;
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
 /* Relocate data references within program code:
  *  - map references;
  *  - global variable references;
@@ -6115,8 +6294,31 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 				insn[0].src_reg = BPF_PSEUDO_MAP_IDX_VALUE;
 				insn[0].imm = relo->map_idx;
 			} else if (map->autocreate) {
+				const struct jt *jt;
+				int ajdust_insn_off;
+				int map_fd = map->fd;
+
+				/*
+				 * Set imm to proper map file descriptor. In normal case,
+				 * it is just map->fd. However, in case of a jump table,
+				 * a new map file descriptor should be created
+				 */
+				jt = bpf_object__find_jt(obj, insn[1].imm / 8);
+				if (map_fd_is_rodata(obj, map_fd) && !IS_ERR(jt)) {
+					ajdust_insn_off = subprog_insn_off(prog, relo->insn_idx);
+					map_fd = create_jt_map(jt, ajdust_insn_off);
+					if (map_fd < 0) {
+						pr_warn("prog '%s': relo #%d: failed to create a jt map for .rodata offset %u\n",
+								prog->name, i, insn[1].imm / 8);
+						return map_fd;
+					}
+
+					/* a new map is created, so offset should be 0 */
+					insn[1].imm = 0;
+				}
+
 				insn[0].src_reg = BPF_PSEUDO_MAP_VALUE;
-				insn[0].imm = map->fd;
+				insn[0].imm = map_fd;
 			} else {
 				poison_map_ldimm64(prog, i, relo->insn_idx, insn,
 						   relo->map_idx, map);
@@ -6366,36 +6568,58 @@ static int append_subprog_relos(struct bpf_program *main_prog, struct bpf_progra
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
@@ -7388,6 +7612,58 @@ static int bpf_object__sanitize_prog(struct bpf_object *obj, struct bpf_program
 	return 0;
 }
 
+static bool insn_is_gotox(struct bpf_insn *insn)
+{
+	return BPF_CLASS(insn->code) == BPF_JMP &&
+	       BPF_OP(insn->code) == BPF_JA &&
+	       BPF_SRC(insn->code) == BPF_X;
+}
+
+/*
+ * This one is too dumb, of course. TBD to make it smarter.
+ */
+static int find_jt_map_fd(struct bpf_program *prog, int insn_idx)
+{
+	struct bpf_insn *insn = &prog->insns[insn_idx];
+	__u8 dst_reg = insn->dst_reg;
+
+	/* TBD: this function is such smart for now that it even ignores this
+	 * register. Instead, it should backtrack the load more carefully.
+	 * (So far even this dumb version works with all selftests.)
+	 */
+	pr_debug("searching for a load instruction which populated dst_reg=r%u\n", dst_reg);
+
+	while (--insn >= prog->insns) {
+		if (insn->code == (BPF_LD|BPF_DW|BPF_IMM))
+			return insn[0].imm;
+	}
+
+	return -ENOENT;
+}
+
+static int bpf_object__patch_gotox(struct bpf_object *obj, struct bpf_program *prog)
+{
+	struct bpf_insn *insn = prog->insns;
+	int map_fd;
+	int i;
+
+	for (i = 0; i < prog->insns_cnt; i++, insn++) {
+		if (!insn_is_gotox(insn))
+			continue;
+
+		if (obj->gen_loader)
+			return -EFAULT;
+
+		map_fd = find_jt_map_fd(prog, i);
+		if (map_fd < 0)
+			return map_fd;
+
+		insn->imm = map_fd;
+	}
+
+	return 0;
+}
+
 static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attach_name,
 				     int *btf_obj_fd, int *btf_type_id);
 
@@ -7931,6 +8207,14 @@ static int bpf_object_prepare_progs(struct bpf_object *obj)
 		if (err)
 			return err;
 	}
+
+	for (i = 0; i < obj->nr_programs; i++) {
+		prog = &obj->programs[i];
+		err = bpf_object__patch_gotox(obj, prog);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
@@ -8063,6 +8347,7 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 	err = err ? : bpf_object__init_maps(obj, opts);
 	err = err ? : bpf_object_init_progs(obj, opts);
 	err = err ? : bpf_object__collect_relos(obj);
+	err = err ? : bpf_object__collect_jt(obj);
 	if (err)
 		goto out;
 
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 477a3b3389a0..0632d2d812d7 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -64,6 +64,10 @@
 #define SHT_LLVM_ADDRSIG 0x6FFF4C03
 #endif
 
+#ifndef SHT_LLVM_JT_SIZES
+#define SHT_LLVM_JT_SIZES 0x6FFF4C0D
+#endif
+
 /* if libelf is old and doesn't support mmap(), fall back to read() */
 #ifndef ELF_C_READ_MMAP
 #define ELF_C_READ_MMAP ELF_C_READ
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index a469e5d4fee7..cbd57ece8594 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -28,6 +28,8 @@
 #include "str_error.h"
 
 #define BTF_EXTERN_SEC ".extern"
+#define RODATA_REL_SEC ".rel.rodata"
+#define LLVM_JT_SIZES_REL_SEC ".rel.llvm_jump_table_sizes"
 
 struct src_sec {
 	const char *sec_name;
@@ -178,6 +180,7 @@ static int linker_sanity_check_btf(struct src_obj *obj);
 static int linker_sanity_check_btf_ext(struct src_obj *obj);
 static int linker_fixup_btf(struct src_obj *obj);
 static int linker_append_sec_data(struct bpf_linker *linker, struct src_obj *obj);
+static int linker_append_sec_jt(struct bpf_linker *linker, struct src_obj *obj);
 static int linker_append_elf_syms(struct bpf_linker *linker, struct src_obj *obj);
 static int linker_append_elf_sym(struct bpf_linker *linker, struct src_obj *obj,
 				 Elf64_Sym *sym, const char *sym_name, int src_sym_idx);
@@ -499,6 +502,7 @@ static int bpf_linker_add_file(struct bpf_linker *linker, int fd,
 
 	err = err ?: linker_load_obj_file(linker, &obj);
 	err = err ?: linker_append_sec_data(linker, &obj);
+	err = err ?: linker_append_sec_jt(linker, &obj);
 	err = err ?: linker_append_elf_syms(linker, &obj);
 	err = err ?: linker_append_elf_relos(linker, &obj);
 	err = err ?: linker_append_btf(linker, &obj);
@@ -811,6 +815,9 @@ static int linker_load_obj_file(struct bpf_linker *linker,
 		case SHT_REL:
 			/* relocations */
 			break;
+		case SHT_LLVM_JT_SIZES:
+			/* LLVM jump tables sizes */
+			break;
 		default:
 			pr_warn("unrecognized section #%zu (%s) in %s\n",
 				sec_idx, sec_name, obj->filename);
@@ -899,6 +906,9 @@ static int linker_sanity_check_elf(struct src_obj *obj)
 			break;
 		case SHT_LLVM_ADDRSIG:
 			break;
+		case SHT_LLVM_JT_SIZES:
+			/* LLVM jump tables sizes */
+			break;
 		default:
 			pr_warn("ELF section #%zu (%s) has unrecognized type %zu in %s\n",
 				sec->sec_idx, sec->sec_name, (size_t)sec->shdr->sh_type, obj->filename);
@@ -1022,7 +1032,10 @@ static int linker_sanity_check_elf_relos(struct src_obj *obj, struct src_sec *se
 		return 0;
 
 	/* relocatable section is data or instructions */
-	if (link_sec->shdr->sh_type != SHT_PROGBITS && link_sec->shdr->sh_type != SHT_NOBITS) {
+	if (link_sec->shdr->sh_type != SHT_PROGBITS &&
+	    link_sec->shdr->sh_type != SHT_NOBITS &&
+	    link_sec->shdr->sh_type != SHT_LLVM_JT_SIZES
+		) {
 		pr_warn("ELF relo section #%zu points to invalid section #%zu in %s\n",
 			sec->sec_idx, (size_t)sec->shdr->sh_info, obj->filename);
 		return -EINVAL;
@@ -1351,6 +1364,13 @@ static bool is_relo_sec(struct src_sec *sec)
 	return sec->shdr->sh_type == SHT_REL;
 }
 
+static bool is_jt_sec(struct src_sec *sec)
+{
+	if (!sec || sec->skipped || !sec->shdr)
+		return false;
+	return sec->shdr->sh_type == SHT_LLVM_JT_SIZES;
+}
+
 static int linker_append_sec_data(struct bpf_linker *linker, struct src_obj *obj)
 {
 	int i, err;
@@ -1403,6 +1423,44 @@ static int linker_append_sec_data(struct bpf_linker *linker, struct src_obj *obj
 	return 0;
 }
 
+static int linker_append_sec_jt(struct bpf_linker *linker, struct src_obj *obj)
+{
+	int i, err;
+
+	for (i = 1; i < obj->sec_cnt; i++) {
+		struct src_sec *src_sec;
+		struct dst_sec *dst_sec;
+
+		src_sec = &obj->secs[i];
+		if (!is_jt_sec(src_sec))
+			continue;
+
+		dst_sec = find_dst_sec_by_name(linker, src_sec->sec_name);
+		if (!dst_sec) {
+			dst_sec = add_dst_sec(linker, src_sec->sec_name);
+			if (!dst_sec)
+				return -ENOMEM;
+			err = init_sec(linker, dst_sec, src_sec);
+			if (err) {
+				pr_warn("failed to init section '%s'\n", src_sec->sec_name);
+				return err;
+			}
+		} else if (!secs_match(dst_sec, src_sec)) {
+			pr_warn("ELF sections %s are incompatible\n", src_sec->sec_name);
+			return -EINVAL;
+		}
+
+		/* record mapped section index */
+		src_sec->dst_id = dst_sec->id;
+
+		err = extend_sec(linker, dst_sec, src_sec);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int linker_append_elf_syms(struct bpf_linker *linker, struct src_obj *obj)
 {
 	struct src_sec *symtab = &obj->secs[obj->symtab_sec_idx];
@@ -2272,8 +2330,10 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
 						insn->imm += sec->dst_off / sizeof(struct bpf_insn);
 					else
 						insn->imm += sec->dst_off;
-				} else {
-					pr_warn("relocation against STT_SECTION in non-exec section is not supported!\n");
+				} else if (strcmp(src_sec->sec_name, LLVM_JT_SIZES_REL_SEC) &&
+					   strcmp(src_sec->sec_name, RODATA_REL_SEC)) {
+					pr_warn("relocation against STT_SECTION in section %s is not supported!\n",
+						src_sec->sec_name);
 					return -EINVAL;
 				}
 			}
-- 
2.34.1


