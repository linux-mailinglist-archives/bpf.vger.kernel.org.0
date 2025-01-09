Return-Path: <bpf+bounces-48471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47C6A08269
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1B83A85A0
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 21:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA1F204C2C;
	Thu,  9 Jan 2025 21:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Bv+lO5eu"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB5023C9
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459282; cv=none; b=KAVL1U5SK619P5ee8yOPJVQdJozd4scqurhK8ZZrKcztEWxk8r8dZWzJojRamsJHSUZ/EYL3Iat0T8L3F6KnK9VBDNYG/dQf4JC67DSsgr+qrtDWXUgrIdHPcqqmGTjLam1wRd8QwQErFcVT6+Am6f2Lr3r2tApA0w16dik3PWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459282; c=relaxed/simple;
	bh=bU6xzwrrq9IeXFp7V1ScxShOcNnzlKfrDesQpIfcgvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bfp99+Ybea0PjRIFqRU/vCCwtvFq90U0HZ1tU3M4jgXTJJ0+28XXihOEiWrEwL6xT2a5YFNwVgj97yoYkXwPOdsAqgzj+FVoMBgVWPSenaBsCizMLH9sVMMExvUzkN7STCH6JZXQLOviT7nRlTvwUy6KKLTk/GqbR2VF4qWRiiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Bv+lO5eu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id AC5B0203E3A1;
	Thu,  9 Jan 2025 13:47:55 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AC5B0203E3A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736459280;
	bh=mCjxjxj5eqqhlQa3OnTBIxUQmUgh91+8dl6ov0IKNuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bv+lO5eujxrkKVZKrzCY7+z89S/pYhrTDKhuM/D3gXmgRda3pspP+/CKtyffvwx/D
	 b0cQ1VmXgRXHeFdOacKZwJSXGjoz/rq0Ui+16c/XH0Rd2PIsLFJAGgIM9iAiWuyNAb
	 rVUYfgqtxJwQ4eUPNS6xCGfv58CGn6wUOPHTCZr4=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: bpf@vger.kernel.org
Cc: nkapron@google.com,
	teknoraver@meta.com,
	roberto.sassu@huawei.com,
	gregkh@linuxfoundation.org,
	paul@paul-moore.com,
	code@tyhicks.com,
	flaniel@linux.microsoft.com
Subject: [PATCH 09/14] bpf: Collect extern relocations
Date: Thu,  9 Jan 2025 13:43:51 -0800
Message-ID: <20250109214617.485144-10-bboscaccy@linux.microsoft.com>
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

This code heavily borrows from bpf_object__collect_externs in
libbpf. Here we walk the symbol table and attempt to determine which
symbols correspond to external relocations, specifically kconfig
options and kernel or module symbols.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 kernel/bpf/syscall.c | 337 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 337 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 03ab0bb7bf076..51b14cb9c4ca1 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6245,6 +6245,339 @@ static int elf_collect(struct bpf_obj *obj)
 	return err;
 }
 
+static enum bpf_kcfg_type find_kcfg_type(const struct btf *btf, int id,
+				     bool *is_signed)
+{
+	const struct btf_type *t;
+	const char *name;
+
+	t = skip_mods_and_typedefs(btf, id, NULL);
+	name = btf_str_by_offset(btf, t->name_off);
+
+	if (is_signed)
+		*is_signed = false;
+	switch (btf_kind(t)) {
+	case BTF_KIND_INT: {
+		int enc = btf_int_encoding(t);
+
+		if (enc & BTF_INT_BOOL)
+			return t->size == 1 ? KCFG_BOOL : KCFG_UNKNOWN;
+		if (is_signed)
+			*is_signed = enc & BTF_INT_SIGNED;
+		if (t->size == 1)
+			return KCFG_CHAR;
+		if (t->size < 1 || t->size > 8 || (t->size & (t->size - 1)))
+			return KCFG_UNKNOWN;
+		return KCFG_INT;
+	}
+	case BTF_KIND_ENUM:
+		if (t->size != 4)
+			return KCFG_UNKNOWN;
+		if (strcmp(name, "libbpf_tristate"))
+			return KCFG_UNKNOWN;
+		return KCFG_TRISTATE;
+	case BTF_KIND_ENUM64:
+		if (strcmp(name, "libbpf_tristate"))
+			return KCFG_UNKNOWN;
+		return KCFG_TRISTATE;
+	case BTF_KIND_ARRAY:
+		if (btf_array(t)->nelems == 0)
+			return KCFG_UNKNOWN;
+		if (find_kcfg_type(btf, btf_array(t)->type, NULL) != KCFG_CHAR)
+			return KCFG_UNKNOWN;
+		return KCFG_CHAR_ARR;
+	default:
+		return KCFG_UNKNOWN;
+	}
+}
+
+static int cmp_externs(const void *_a, const void *_b)
+{
+	const struct bpf_extern_desc *a = _a;
+	const struct bpf_extern_desc *b = _b;
+
+	if (a->type != b->type)
+		return a->type < b->type ? -1 : 1;
+
+	if (a->type == EXT_KCFG) {
+		/* descending order by alignment requirements */
+		if (a->kcfg.align != b->kcfg.align)
+			return a->kcfg.align > b->kcfg.align ? -1 : 1;
+		/* ascending order by size, within same alignment class */
+		if (a->kcfg.sz != b->kcfg.sz)
+			return a->kcfg.sz < b->kcfg.sz ? -1 : 1;
+	}
+
+	/* resolve ties by name */
+	return strcmp(a->name, b->name);
+}
+
+static int find_int_btf_id(const struct btf *btf)
+{
+	const struct btf_type *t;
+	int i, n;
+
+	n = btf_type_cnt(btf);
+	for (i = 1; i < n; i++) {
+		t = btf_type_by_id(btf, i);
+
+		if (btf_type_is_int(t) && btf_type_int_bits(t) == 32)
+			return i;
+	}
+	return 0;
+}
+
+static struct bpf_extern_desc *find_extern_by_name(const struct bpf_obj *obj,
+						   const void *name)
+{
+	int i;
+
+	for (i = 0; i < obj->nr_extern; i++) {
+		if (strcmp(obj->externs[i].name, name) == 0)
+			return &obj->externs[i];
+	}
+	return NULL;
+}
+
+static int add_dummy_ksym_var(struct btf *btf)
+{
+	int i, int_btf_id, sec_btf_id, dummy_var_btf_id;
+	const struct btf_var_secinfo *vs;
+	const struct btf_type *sec;
+
+	if (!btf)
+		return 0;
+
+	sec_btf_id = btf_find_by_name_kind(btf, ".ksyms",
+					   BTF_KIND_DATASEC);
+	if (sec_btf_id < 0)
+		return 0;
+
+	sec = btf_type_by_id(btf, sec_btf_id);
+	vs = btf_var_secinfos(sec);
+	for (i = 0; i < btf_vlen(sec); i++, vs++) {
+		const struct btf_type *vt;
+
+		vt = btf_type_by_id(btf, vs->type);
+		if (btf_type_is_func(vt))
+			break;
+	}
+
+	/* No func in ksyms sec.  No need to add dummy var. */
+	if (i == btf_vlen(sec))
+		return 0;
+
+	int_btf_id = find_int_btf_id(btf);
+
+	dummy_var_btf_id = btf_add_var(btf,
+				       sec->name_off,
+				       BTF_VAR_GLOBAL_ALLOCATED,
+				       int_btf_id);
+	if (dummy_var_btf_id < 0)
+		pr_warn("cannot create a dummy_ksym var\n");
+
+	return dummy_var_btf_id;
+}
+
+static int collect_externs(struct bpf_obj *obj)
+{
+	int i, n, off, dummy_var_btf_id;
+	Elf_Shdr *symsec = &obj->sechdrs[obj->index.sym];
+	Elf_Sym *sym = (void *)obj->hdr + symsec->sh_offset;
+	const char *ext_name;
+	const char *sec_name;
+	struct bpf_extern_desc *ext;
+	const struct btf_type *t;
+	size_t ext_essent_len;
+	struct btf_type *sec, *kcfg_sec = NULL, *ksym_sec = NULL;
+	int size;
+	int int_btf_id;
+	const struct btf_type *dummy_var;
+	struct btf_type *vt;
+	struct btf_var_secinfo *vs;
+	const struct btf_type *func_proto;
+	struct btf_param *param;
+	int j;
+
+	dummy_var_btf_id = add_dummy_ksym_var(obj->btf);
+	if (dummy_var_btf_id < 0)
+		return dummy_var_btf_id;
+
+	for (i = 1; i < symsec->sh_size / sizeof(Elf_Sym); i++) {
+		if (!sym_is_extern(&sym[i]))
+			continue;
+
+		ext_name = obj->strtab + sym[i].st_name;
+		ext = krealloc_array(obj->externs,
+				     obj->nr_extern + 1,
+				     sizeof(struct bpf_extern_desc),
+				     GFP_KERNEL);
+		if (!ext)
+			return -ENOMEM;
+
+		obj->externs = ext;
+		ext = &ext[obj->nr_extern];
+		memset(ext, 0, sizeof(*ext));
+		obj->nr_extern++;
+
+		ext->btf_id = find_extern_btf_id(obj->btf, ext_name);
+		if (ext->btf_id <= 0)
+			return ext->btf_id;
+
+		t = btf_type_by_id(obj->btf, ext->btf_id);
+		ext->name = btf_str_by_offset(obj->btf, t->name_off);
+		ext->sym_idx = i;
+		ext->is_weak = ELF64_ST_BIND(sym->st_info) == STB_WEAK;
+
+		ext_essent_len = bpf_core_essential_name_len(ext->name);
+		ext->essent_name = NULL;
+		if (ext_essent_len != strlen(ext->name)) {
+			ext->essent_name = kstrndup(ext->name, ext_essent_len, GFP_KERNEL);
+			if (!ext->essent_name)
+				return -ENOMEM;
+		}
+
+		ext->sec_btf_id = find_extern_sec_btf_id(obj->btf, ext->btf_id);
+		if (ext->sec_btf_id <= 0) {
+			pr_warn("failed to find BTF for extern '%s' [%d] section: %d\n",
+				ext_name, ext->btf_id, ext->sec_btf_id);
+			return ext->sec_btf_id;
+		}
+
+		sec = (void *)btf_type_by_id(obj->btf, ext->sec_btf_id);
+		sec_name = btf_str_by_offset(obj->btf, sec->name_off);
+
+		if (strcmp(sec_name, ".kconfig") == 0) {
+			if (btf_type_is_func(t)) {
+				pr_warn("extern function %s is unsupported under .kconfig section\n",
+					ext->name);
+				return -EOPNOTSUPP;
+			}
+			kcfg_sec = sec;
+			ext->type = EXT_KCFG;
+
+			if (!btf_resolve_size(obj->btf, t, &size)) {
+				pr_warn("failed to resolve size of extern (kcfg) '%s': %d\n",
+					ext_name, ext->kcfg.sz);
+				return -EINVAL;
+			}
+			ext->kcfg.sz = size;
+			ext->kcfg.align = btf_align_of(obj->btf, t->type);
+			if (ext->kcfg.align <= 0) {
+				pr_warn("failed to determine alignment of extern (kcfg) '%s': %d\n",
+					ext_name, ext->kcfg.align);
+				return -EINVAL;
+			}
+			ext->kcfg.type = find_kcfg_type(obj->btf, t->type,
+							&ext->kcfg.is_signed);
+			if (ext->kcfg.type == KCFG_UNKNOWN) {
+				pr_warn("extern (kcfg) '%s': type is unsupported\n", ext_name);
+				return -EOPNOTSUPP;
+			}
+		} else if (strcmp(sec_name, ".ksyms") == 0) {
+			ksym_sec = sec;
+			ext->type = EXT_KSYM;
+			skip_mods_and_typedefs(obj->btf, t->type,
+					       &ext->ksym.type_id);
+		} else {
+			pr_warn("unrecognized extern section '%s'\n", sec_name);
+			return -EOPNOTSUPP;
+		}
+	}
+
+	sort(obj->externs, obj->nr_extern, sizeof(struct bpf_extern_desc),
+	     cmp_externs, NULL);
+
+	if (ksym_sec) {
+		/* find existing 4-byte integer type in BTF to use for fake
+		 * extern variables in DATASEC
+		 */
+		int_btf_id = find_int_btf_id(obj->btf);
+
+		/* For extern function, a dummy_var added earlier
+		 * will be used to replace the vs->type and
+		 * its name string will be used to refill
+		 * the missing param's name.
+		 */
+		dummy_var = btf_type_by_id(obj->btf, dummy_var_btf_id);
+		for (i = 0; i < obj->nr_extern; i++) {
+			ext = &obj->externs[i];
+			if (ext->type != EXT_KSYM)
+				continue;
+			pr_debug("extern (ksym) #%d: symbol %d, name %s\n",
+				 i, ext->sym_idx, ext->name);
+		}
+
+		sec = ksym_sec;
+		n = btf_vlen(sec);
+		for (i = 0, off = 0; i < n; i++, off += sizeof(int)) {
+			vs = btf_var_secinfos(sec) + i;
+			vt = (void *)btf_type_by_id(obj->btf, vs->type);
+			ext_name = btf_str_by_offset(obj->btf, vt->name_off);
+			ext = find_extern_by_name(obj, ext_name);
+			if (!ext) {
+				pr_warn("failed to find extern definition for BTF %s\n",
+					ext_name);
+				return -ESRCH;
+			}
+			if (btf_type_is_func(vt)) {
+				func_proto = btf_type_by_id(obj->btf,
+							    vt->type);
+				param = btf_params(func_proto);
+				/* Reuse the dummy_var string if the
+				 * func proto does not have param name.
+				 */
+				for (j = 0; j < btf_vlen(func_proto); j++)
+					if (param[j].type && !param[j].name_off)
+						param[j].name_off =
+							dummy_var->name_off;
+				vs->type = dummy_var_btf_id;
+				vt->info &= ~0xffff;
+				vt->info |= BTF_FUNC_GLOBAL;
+			} else {
+				btf_var(vt)->linkage = BTF_VAR_GLOBAL_ALLOCATED;
+				vt->type = int_btf_id;
+			}
+			vs->offset = off;
+			vs->size = sizeof(int);
+		}
+		sec->size = off;
+	}
+
+	if (kcfg_sec) {
+		sec = kcfg_sec;
+		/* for kcfg externs calculate their offsets within a .kconfig map */
+		off = 0;
+		for (i = 0; i < obj->nr_extern; i++) {
+			ext = &obj->externs[i];
+			if (ext->type != EXT_KCFG)
+				continue;
+
+			ext->kcfg.data_off = roundup(off, ext->kcfg.align);
+			off = ext->kcfg.data_off + ext->kcfg.sz;
+			pr_debug("extern (kcfg) #%d: symbol %d, off %u, name %s\n",
+				 i, ext->sym_idx, ext->kcfg.data_off, ext->name);
+		}
+		sec->size = off;
+		n = btf_vlen(sec);
+		for (i = 0; i < n; i++) {
+			vs = btf_var_secinfos(sec) + i;
+			t = btf_type_by_id(obj->btf, vs->type);
+			ext_name = btf_str_by_offset(obj->btf, t->name_off);
+
+			ext = find_extern_by_name(obj, ext_name);
+			if (!ext) {
+				pr_warn("failed to find extern definition for BTF var '%s'\n",
+					ext_name);
+				return -ESRCH;
+			}
+			btf_var(t)->linkage = BTF_VAR_GLOBAL_ALLOCATED;
+			vs->offset = ext->kcfg.data_off;
+		}
+	}
+	return 0;
+}
+
 static void free_bpf_obj(struct bpf_obj *obj)
 {
 	int i;
@@ -6480,6 +6813,10 @@ static int load_fd(union bpf_attr *attr)
 	if (err < 0)
 		goto free;
 
+	err = collect_externs(obj);
+	if (err < 0)
+		goto free;
+
 	return obj_f;
 free:
 	free_bpf_obj(obj);
-- 
2.47.1


