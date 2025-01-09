Return-Path: <bpf+bounces-48473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 147A6A0826B
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0BBE7A02E0
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 21:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D86D204C39;
	Thu,  9 Jan 2025 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="k0b/YbOg"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4322046AA
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 21:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459292; cv=none; b=iRqMhzyc3/S3QIO/MQtRwVzKjHn3qiaOeQGDItYPDkrZ95xk+xfzL1EHiCcTXvQG1Do4Zk0d1BybQAhRApSl1PeqzebkmS0vGJgxkB70QF0u4rLJyCvlutrxY4UETxEbF7jrWRj1OPzqLfZn7Ayb3q//IsIPq1wGjSfqn9cZZrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459292; c=relaxed/simple;
	bh=6FFhGmEGemrHhWvhc6kWPLOVYrkjrrQ1AjluEGcRNMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbE3n2TTI3PkjXb2o/CcPTLzOpaI6T35FbQ7cacjiyAbCsk8fs49L6nG0+O5PDR3EHYN4GWytkqwqiH0E7LVo+Ya+zdIrWcvVh68T4O6h82uZz80V7KxrwThJDlguRPa4Twj3kiSMmzcLOMZSSrphdFV/sEexgrxMW4OlAre270=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=k0b/YbOg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 909F7203E3A1;
	Thu,  9 Jan 2025 13:48:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 909F7203E3A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736459291;
	bh=yNOK8xobsXjC2zcCGpoKul59SyMrDg1nsFvW4E6YNTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k0b/YbOgFh0UFW7s2hR5Gcj6Wdoc9mvEVJ4LTYT9LcABSnMhso8Yy7bFv2i2tfJye
	 9IeqA0JWVJEJ2exPoBSt8ftnxztC49eRwHC4lTZtxpmkn6K0sOQ9tAF8x3zb8u1PiR
	 JoJUuVEzXtGxQnKlmYaQTom8YOopkDtPdxRSg9Jc=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: bpf@vger.kernel.org
Cc: nkapron@google.com,
	teknoraver@meta.com,
	roberto.sassu@huawei.com,
	gregkh@linuxfoundation.org,
	paul@paul-moore.com,
	code@tyhicks.com,
	flaniel@linux.microsoft.com
Subject: [PATCH 11/14] bpf: Implement relocation collection
Date: Thu,  9 Jan 2025 13:43:53 -0800
Message-ID: <20250109214617.485144-12-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
References: <20250109214617.485144-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This code heavily borrows from bpf_program__record_reloc from
libbpf. This symbol parse is primarily responsible for identifying
subprogram and call instructions that need to be
relocated. Additionally map relocations are discovered in this parse
as well.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 kernel/bpf/syscall.c | 308 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 308 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f47e95c1ab975..9c3d037cd6b95 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6763,6 +6763,310 @@ static int fixup_btf(struct bpf_obj *obj)
 	return 0;
 }
 
+static bool insn_is_subprog_call(const struct bpf_insn *insn)
+{
+	return BPF_CLASS(insn->code) == BPF_JMP &&
+	       BPF_OP(insn->code) == BPF_CALL &&
+	       BPF_SRC(insn->code) == BPF_K &&
+	       insn->src_reg == BPF_PSEUDO_CALL &&
+	       insn->dst_reg == 0 &&
+	       insn->off == 0;
+}
+
+static bool is_call_insn(const struct bpf_insn *insn)
+{
+	return insn->code == (BPF_JMP | BPF_CALL);
+}
+
+static inline bool is_ldimm64_insn(struct bpf_insn *insn)
+{
+	return insn->code == (BPF_LD | BPF_IMM | BPF_DW);
+}
+
+static bool insn_is_pseudo_func(struct bpf_insn *insn)
+{
+	return is_ldimm64_insn(insn) && insn->src_reg == BPF_PSEUDO_FUNC;
+}
+
+static bool sym_is_subprog(const Elf64_Sym *sym, int text_shndx)
+{
+	int bind = ELF64_ST_BIND(sym->st_info);
+	int type = ELF64_ST_TYPE(sym->st_info);
+
+	/* in .text section */
+	if (sym->st_shndx != text_shndx)
+		return false;
+
+	/* local function */
+	if (bind == STB_LOCAL && type == STT_SECTION)
+		return true;
+
+	/* global function */
+	return bind == STB_GLOBAL && type == STT_FUNC;
+}
+
+static bool prog_contains_insn(const struct bpf_prog_obj *prog, size_t insn_idx)
+{
+	return insn_idx >= prog->sec_insn_off &&
+	       insn_idx < prog->sec_insn_off + prog->sec_insn_cnt;
+}
+
+static struct bpf_prog_obj *find_prog_by_sec_insn(const struct bpf_obj *obj,
+						 size_t sec_idx, size_t insn_idx)
+{
+	int l = 0, r = obj->nr_programs - 1, m;
+	struct bpf_prog_obj *prog;
+
+	if (!obj->nr_programs)
+		return NULL;
+
+	while (l < r) {
+		m = l + (r - l + 1) / 2;
+		prog = &obj->progs[m];
+
+		if (prog->sec_idx < sec_idx ||
+		    (prog->sec_idx == sec_idx && prog->sec_insn_off <= insn_idx))
+			l = m;
+		else
+			r = m - 1;
+	}
+	/* matching program could be at index l, but it still might be the
+	 * wrong one, so we need to double check conditions for the last time
+	 */
+	prog = &obj->progs[l];
+	if (prog->sec_idx == sec_idx && prog_contains_insn(prog, insn_idx))
+		return prog;
+	return NULL;
+}
+
+static enum libbpf_map_type section_to_libbpf_map_type(struct bpf_obj *obj, int sec_idx)
+{
+	Elf_Shdr *shdr = &obj->sechdrs[sec_idx];
+
+	if (strcmp(".data", obj->secstrings + shdr->sh_name) == 0)
+		return LIBBPF_MAP_DATA;
+
+	if (str_has_prefix(obj->secstrings + shdr->sh_name, ".rodata"))
+		return LIBBPF_MAP_RODATA;
+
+	if (str_has_prefix(obj->secstrings + shdr->sh_name, ".bss"))
+		return LIBBPF_MAP_BSS;
+
+	return LIBBPF_MAP_UNSPEC;
+}
+
+static int program_record_reloc(struct bpf_obj *obj,
+				struct bpf_prog_obj *prog,
+				struct bpf_reloc_desc *reloc_desc,
+				u32 insn_idx, const char *sym_name,
+				const Elf64_Sym *sym, const Elf64_Rel *rel)
+{
+	struct bpf_insn *insn = &prog->insn[insn_idx];
+	size_t map_idx, nr_maps = obj->nr_maps;
+	u32 shdr_idx = sym->st_shndx;
+	enum libbpf_map_type type;
+	struct bpf_map_obj *map;
+
+	if (!is_call_insn(insn) && !is_ldimm64_insn(insn)) {
+		pr_warn("prog '%s': invalid relo against '%s' for insns[%d].code 0x%x\n",
+			prog->name, sym_name, insn_idx, insn->code);
+		return -EOPNOTSUPP;
+	}
+
+	if (sym_is_extern(sym)) {
+		int sym_idx = ELF64_R_SYM(rel->r_info);
+		int i, n = obj->nr_extern;
+		struct bpf_extern_desc *ext;
+
+		for (i = 0; i < n; i++) {
+			ext = &obj->externs[i];
+			if (ext->sym_idx == sym_idx)
+				break;
+		}
+		if (i >= n) {
+			pr_warn("prog '%s': extern relo failed to find extern for '%s' (%d)\n",
+				prog->name, sym_name, sym_idx);
+			return -EOPNOTSUPP;
+		}
+		pr_debug("prog '%s': found extern #%d '%s' (sym %d) for insn #%u\n",
+			 prog->name, i, ext->name, ext->sym_idx, insn_idx);
+		if (insn->code == (BPF_JMP | BPF_CALL))
+			reloc_desc->type = RELO_EXTERN_CALL;
+		else
+			reloc_desc->type = RELO_EXTERN_LD64;
+		reloc_desc->insn_idx = insn_idx;
+		reloc_desc->ext_idx = i;
+		return 0;
+	}
+
+	/* sub-program call relocation */
+	if (is_call_insn(insn)) {
+		if (insn->src_reg != BPF_PSEUDO_CALL) {
+			pr_warn("prog '%s': incorrect bpf_call opcode\n", prog->name);
+			return -EOPNOTSUPP;
+		}
+		/* text_shndx can be 0, if no default "main" program exists */
+		if (!shdr_idx || shdr_idx != obj->index.text)
+			return -EOPNOTSUPP;
+
+		if (sym->st_value % sizeof(struct bpf_insn)) {
+			pr_warn("prog '%s': bad call relo against '%s' at offset %zu\n",
+				prog->name, sym_name, (size_t)sym->st_value);
+			return -EOPNOTSUPP;
+		}
+		reloc_desc->type = RELO_CALL;
+		reloc_desc->insn_idx = insn_idx;
+		reloc_desc->sym_off = sym->st_value;
+		return 0;
+	}
+
+	if (!shdr_idx || shdr_idx >= SHN_LORESERVE) {
+		pr_warn("prog '%s': invalid relo against '%s' in special section 0x%x; forgot to initialize global var?..\n",
+			prog->name, sym_name, shdr_idx);
+		return -EOPNOTSUPP;
+	}
+
+	/* loading subprog addresses */
+	if (sym_is_subprog(sym, obj->index.text)) {
+		/* global_func: sym->st_value = offset in the section, insn->imm = 0.
+		 * local_func: sym->st_value = 0, insn->imm = offset in the section.
+		 */
+		if ((sym->st_value % sizeof(struct bpf_insn)) ||
+		    (insn->imm % sizeof(struct bpf_insn))) {
+			pr_warn("prog '%s': bad subprog addr relo against '%s' at offset %zu+%d\n",
+				prog->name, sym_name, (size_t)sym->st_value, insn->imm);
+			return -EOPNOTSUPP;
+		}
+		reloc_desc->type = RELO_SUBPROG_ADDR;
+		reloc_desc->insn_idx = insn_idx;
+		reloc_desc->sym_off = sym->st_value;
+		return 0;
+	}
+
+
+	type = section_to_libbpf_map_type(obj, shdr_idx);
+
+	if (shdr_idx == obj->index.arena) {
+		reloc_desc->type = RELO_DATA;
+		reloc_desc->insn_idx = insn_idx;
+		reloc_desc->map_idx = obj->arena_map_idx;
+		reloc_desc->sym_off = sym->st_value;
+		return 0;
+	}
+
+	/* generic map reference relocation */
+	if (type == LIBBPF_MAP_UNSPEC) {
+		for (map_idx = 0; map_idx < nr_maps; map_idx++) {
+			map = &obj->maps[map_idx];
+			if (map->map_type != type ||
+			    map->sec_idx != sym->st_shndx ||
+			    map->sec_offset != sym->st_value)
+				continue;
+			pr_debug("prog '%s': found map %zd (sec %d, off %d) for insn #%u\n",
+				 prog->name, map_idx, map->sec_idx,
+				 map->sec_offset, insn_idx);
+			break;
+		}
+		if (map_idx >= nr_maps) {
+			pr_warn("prog '%s': map relo failed to find map for section off %lu\n",
+				prog->name, (size_t)sym->st_value);
+			return -EOPNOTSUPP;
+		}
+		reloc_desc->type = RELO_LD64;
+		reloc_desc->insn_idx = insn_idx;
+		reloc_desc->map_idx = map_idx;
+		reloc_desc->sym_off = 0; /* sym->st_value determines map_idx */
+		return 0;
+	}
+
+	for (map_idx = 0; map_idx < nr_maps; map_idx++) {
+		map = &obj->maps[map_idx];
+		if (map->map_type != type || map->sec_idx != sym->st_shndx)
+			continue;
+		pr_debug("prog '%s': found data map %zd (sec %d, off %u) for insn %u\n",
+			 prog->name, map_idx, map->sec_idx,
+			 map->sec_offset, insn_idx);
+		break;
+	}
+	if (map_idx >= nr_maps) {
+		pr_warn("prog '%s': data relo failed to find map for section (%lu:%lu)\n",
+			prog->name, map_idx, nr_maps);
+		return -EOPNOTSUPP;
+	}
+
+	reloc_desc->type = RELO_DATA;
+	reloc_desc->insn_idx = insn_idx;
+	reloc_desc->map_idx = map_idx;
+	reloc_desc->sym_off = sym->st_value;
+	return 0;
+}
+
+static int collect_prog_relocs(struct bpf_obj *obj, Elf64_Shdr *shdr, unsigned int shdr_idx)
+{
+	unsigned int i, nrels, sym_idx, insn_idx;
+	size_t sec_idx = shdr->sh_info;
+	int err;
+	struct bpf_prog_obj *prog;
+	Elf64_Rel *rel = (void *)obj->hdr + shdr->sh_offset;
+
+	Elf_Shdr *symsec = &obj->sechdrs[obj->index.sym];
+	Elf_Sym *sym = (void *)obj->hdr + symsec->sh_offset;
+	const char *sym_name;
+
+	nrels = shdr->sh_size / shdr->sh_entsize;
+
+	for (i = 0; i < nrels; i++) {
+		sym_idx = ELF64_R_SYM(rel[i].r_info);
+		insn_idx = rel[i].r_offset / sizeof(struct bpf_insn);
+
+		sym_name = obj->strtab + sym[sym_idx].st_name;
+		prog = find_prog_by_sec_insn(obj, sec_idx, insn_idx);
+		if (!prog)
+			continue;
+
+		prog->reloc_desc = krealloc_array(prog->reloc_desc,
+						  prog->nr_reloc + 1,
+						  sizeof(struct bpf_reloc_desc),
+						  GFP_KERNEL);
+		if (!prog->reloc_desc)
+			return -ENOMEM;
+
+		err = program_record_reloc(obj,
+					   prog,
+					   &prog->reloc_desc[prog->nr_reloc],
+					   insn_idx,
+					   sym_name,
+					   &sym[sym_idx],
+					   &rel[i]);
+
+		if (err)
+			return err;
+
+		prog->nr_reloc++;
+
+	}
+	return 0;
+}
+
+static int collect_relos(struct bpf_obj *obj)
+{
+	unsigned int i;
+	Elf_Shdr *shdr;
+	int err;
+
+	for (i = 1; i < obj->hdr->e_shnum; i++) {
+		shdr = &obj->sechdrs[i];
+		if (shdr->sh_type != SHT_REL)
+			continue;
+		if (i != obj->index.btf && i != obj->index.btf_ext) {
+			err = collect_prog_relocs(obj, shdr, i);
+			if (err)
+				return err;
+		}
+	}
+	return 0;
+}
+
 static void free_bpf_obj(struct bpf_obj *obj)
 {
 	int i;
@@ -7006,6 +7310,10 @@ static int load_fd(union bpf_attr *attr)
 	if (err < 0)
 		goto free;
 
+	err = collect_relos(obj);
+	if (err < 0)
+		goto free;
+
 	return obj_f;
 free:
 	free_bpf_obj(obj);
-- 
2.47.1


