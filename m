Return-Path: <bpf+bounces-48472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A7FA0826A
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC953A824C
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 21:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08C8204C3D;
	Thu,  9 Jan 2025 21:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bZd7pJhi"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31B323C9
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 21:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459287; cv=none; b=DeEaVV/OOY614l5BcV0gWO1jVy1ZA9/wwUFCoaFujlmDTROC0C+AjTGL1n4z4qs/pkumjH/jaKs91+x/qrP0CyQDkMtTcWEeVetvzERnH5H5V29t3n0dHwi03nF9JoQoU7AI9N5ym1RUWlhGxfmuQ0ab60cWFRr1k9Le47nZLIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459287; c=relaxed/simple;
	bh=vNj6Gz8pPT2ZuUZAn77l+VznhqAVIm0Jd2639rjIrOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5hFI+DBPKD1TyZYYk5VIK2AZvonG8WxgFXIunXbuZPxRwJoII0WoMV2zsljr48HH2kUKo4oQXbykmEcfkT3LCO5qI9AczCtDMTEQ7BwclIM4AdFOJwBS9GUN4f89/iFqiJyVJgNm9Ok0wkQ0vazop36PtlQeuhEFzbzNTaUtOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bZd7pJhi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0FE58203E3BC;
	Thu,  9 Jan 2025 13:48:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0FE58203E3BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736459285;
	bh=cD0FnKjjt1NzTPyBMWpVv/13uT+KayLvq8IwyERKrJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bZd7pJhi36uhID+JoiL3U59QiX7ZqzZDD9wi1R6+IU2eBWm+cNLbgEYGnu6xWBXLt
	 0uhJfLLS0ygn3G/YFg4SNzndxnoXzvyagSXRTH/jF5kuivUVgQvdIp6l/l+GVg6T13
	 GH92U47zI0KByFXWpdrPp1ZSOE+1M+xmQqPp+R0Q=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: bpf@vger.kernel.org
Cc: nkapron@google.com,
	teknoraver@meta.com,
	roberto.sassu@huawei.com,
	gregkh@linuxfoundation.org,
	paul@paul-moore.com,
	code@tyhicks.com,
	flaniel@linux.microsoft.com
Subject: [PATCH 10/14] bpf: Implement BTF fixup functionality
Date: Thu,  9 Jan 2025 13:43:52 -0800
Message-ID: <20250109214617.485144-11-bboscaccy@linux.microsoft.com>
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

This code heavily borrows from bpf_object_fixup_btf. There are certain
things that clang doesn't quite handle properly for our needs, mostly
related to zeroed sizes and offsets.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 kernel/bpf/syscall.c | 189 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 51b14cb9c4ca1..f47e95c1ab975 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6578,6 +6578,191 @@ static int collect_externs(struct bpf_obj *obj)
 	return 0;
 }
 
+static int compare_vsi_off(const void *_a, const void *_b)
+{
+	const struct btf_var_secinfo *a = _a;
+	const struct btf_var_secinfo *b = _b;
+
+	return a->offset - b->offset;
+}
+
+static Elf_Shdr *elf_sec_by_name(const struct bpf_obj *obj, const char *name)
+{
+	unsigned int i;
+	Elf_Shdr *shdr;
+
+	for (i = 1; i < obj->hdr->e_shnum; i++) {
+		shdr = &obj->sechdrs[i];
+		if (strcmp(name, obj->secstrings + shdr->sh_name) == 0)
+			return shdr;
+	}
+	return NULL;
+}
+
+static int find_elf_sec_sz(const struct bpf_obj *obj, const char *name, u32 *size)
+{
+	Elf_Shdr *scn;
+
+	if (!name)
+		return -EINVAL;
+
+	scn = elf_sec_by_name(obj, name);
+	if (scn) {
+		*size = scn->sh_size;
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+static Elf64_Sym *find_elf_var_sym(const struct bpf_obj *obj, const char *name)
+{
+	unsigned int i;
+	Elf_Shdr *symsec = &obj->sechdrs[obj->index.sym];
+	Elf_Sym *sym = (void *)obj->hdr + symsec->sh_offset;
+
+	for (i = 1; i < symsec->sh_size / sizeof(Elf_Sym); i++) {
+		if (ELF64_ST_TYPE(sym[i].st_info) != STT_OBJECT)
+			continue;
+
+		if (ELF64_ST_BIND(sym[i].st_info) != STB_GLOBAL &&
+		    ELF64_ST_BIND(sym[i].st_info) != STB_WEAK)
+			continue;
+
+		if (strcmp(name,  obj->strtab + sym[i].st_name) == 0)
+			return &sym[i];
+
+	}
+	return ERR_PTR(-ENOENT);
+}
+
+#define ELF64_ST_VISIBILITY(o) ((o) & 0x03)
+
+/* Symbol visibility specification encoded in the st_other field.  */
+#define STV_DEFAULT	0		/* Default symbol visibility rules */
+#define STV_INTERNAL	1		/* Processor specific hidden class */
+#define STV_HIDDEN	2		/* Sym unavailable in other modules */
+#define STV_PROTECTED	3		/* Not preemptible, not exported */
+
+static int btf_fixup_datasec(struct bpf_obj *obj, struct btf *btf,
+			     struct btf_type *t)
+{
+	__u32 size = 0, i, vars = btf_vlen(t);
+	const char *sec_name = btf_str_by_offset(btf, t->name_off);
+	struct btf_var_secinfo *vsi;
+	bool fixup_offsets = false;
+	int err;
+
+	if (!sec_name) {
+		pr_debug("No name found in string section for DATASEC kind.\n");
+		return -ENOENT;
+	}
+
+	/* Extern-backing datasecs (.ksyms, .kconfig) have their size and
+	 * variable offsets set at the previous step. Further, not every
+	 * extern BTF VAR has corresponding ELF symbol preserved, so we skip
+	 * all fixups altogether for such sections and go straight to sorting
+	 * VARs within their DATASEC.
+	 */
+	if (strcmp(sec_name, ".kconfig") == 0 || strcmp(sec_name, ".ksyms") == 0)
+		goto sort_vars;
+
+	/* Clang leaves DATASEC size and VAR offsets as zeroes, so we need to
+	 * fix this up. But BPF static linker already fixes this up and fills
+	 * all the sizes and offsets during static linking. So this step has
+	 * to be optional. But the STV_HIDDEN handling is non-optional for any
+	 * non-extern DATASEC, so the variable fixup loop below handles both
+	 * functions at the same time, paying the cost of BTF VAR <-> ELF
+	 * symbol matching just once.
+	 */
+	if (t->size == 0) {
+		err = find_elf_sec_sz(obj, sec_name, &size);
+		if (err || !size) {
+			pr_debug("sec '%s': failed to determine size from ELF: size %u, err %d\n",
+				 sec_name, size, err);
+			return -ENOENT;
+		}
+
+		t->size = size;
+		fixup_offsets = true;
+	}
+
+	for (i = 0, vsi = btf_var_secinfos(t); i < vars; i++, vsi++) {
+		const struct btf_type *t_var;
+		struct btf_var *var;
+		const char *var_name;
+		Elf64_Sym *sym;
+
+		t_var = btf_type_by_id(btf, vsi->type);
+		if (!t_var || !(btf_kind(t_var) == BTF_KIND_VAR)) {
+			pr_debug("sec '%s': unexpected non-VAR type found\n", sec_name);
+			return -EINVAL;
+		}
+
+		var = btf_var(t_var);
+		if (var->linkage == BTF_VAR_STATIC || var->linkage == BTF_VAR_GLOBAL_EXTERN)
+			continue;
+
+		var_name = btf_str_by_offset(btf, t_var->name_off);
+		if (!var_name) {
+			pr_debug("sec '%s': failed to find name of DATASEC's member #%d\n",
+				 sec_name, i);
+			return -ENOENT;
+		}
+
+		sym = find_elf_var_sym(obj, var_name);
+		if (IS_ERR(sym)) {
+			pr_debug("sec '%s': failed to find ELF symbol for VAR '%s'\n",
+				 sec_name, var_name);
+			return -ENOENT;
+		}
+
+		if (fixup_offsets)
+			vsi->offset = sym->st_value;
+
+		/* if variable is a global/weak symbol, but has restricted
+		 * (STV_HIDDEN or STV_INTERNAL) visibility, mark its BTF VAR
+		 * as static. This follows similar logic for functions (BPF
+		 * subprogs) and influences libbpf's further decisions about
+		 * whether to make global data BPF array maps as
+		 * BPF_F_MMAPABLE.
+		 */
+		if (ELF64_ST_VISIBILITY(sym->st_other) == STV_HIDDEN
+		    || ELF64_ST_VISIBILITY(sym->st_other) == STV_INTERNAL)
+			var->linkage = BTF_VAR_STATIC;
+	}
+
+sort_vars:
+	sort(btf_var_secinfos(t), vars, sizeof(*vsi), compare_vsi_off, NULL);
+	return 0;
+}
+
+static int fixup_btf(struct bpf_obj *obj)
+{
+	int i, n, err = 0;
+
+	if (!obj->btf)
+		return 0;
+
+	n = btf_type_cnt(obj->btf);
+	for (i = 1; i < n; i++) {
+		struct btf_type *t = (struct btf_type *)btf_type_by_id(obj->btf, i);
+
+		/* Loader needs to fix up some of the things compiler
+		 * couldn't get its hands on while emitting BTF. This
+		 * is section size and global variable offset. We use
+		 * the info from the ELF itself for this purpose.
+		 */
+		if (btf_kind(t) == BTF_KIND_DATASEC) {
+			err = btf_fixup_datasec(obj, obj->btf, t);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
 static void free_bpf_obj(struct bpf_obj *obj)
 {
 	int i;
@@ -6817,6 +7002,10 @@ static int load_fd(union bpf_attr *attr)
 	if (err < 0)
 		goto free;
 
+	err = fixup_btf(obj);
+	if (err < 0)
+		goto free;
+
 	return obj_f;
 free:
 	free_bpf_obj(obj);
-- 
2.47.1


