Return-Path: <bpf+bounces-48470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97687A08268
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908C0168DDB
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 21:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7745204096;
	Thu,  9 Jan 2025 21:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IXjTOfWL"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC44C23C9
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 21:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459276; cv=none; b=OIpCPtAXzbP6pWf5Mjd3m7rDP+E897o+sNjovSbP2HDnE4H7Lq4xmvruIY5GErZrHeF4A2BUKC94MBOKiqfESvedqIcFLq2wFgGP5XpeqLwUyMSR1sPSdww4YWq7JFr/fDdx23E3aMAK2YDWkDCFEKMcf3CP4fSujfprwrYRW/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459276; c=relaxed/simple;
	bh=tq1qKeR7aes0OyQjhQKiM4QYvzEqjSQxK7QbP3YJFP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q60kgpjjii1gODwY9Opfq5QCCDEvVQtUqZudldlk517VC9gFg5aydELDavdElxC7Q68DOaHDyx8XKbaSkzMubckO49DFBZj5Qj85Ft2rnb6/mc0eHVataVbs45dAo/FKdEotTvgtT1FnJU/GI6rvT1veLlOQ3aDabBCbn5Q9QMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IXjTOfWL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7B500203E39C;
	Thu,  9 Jan 2025 13:47:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7B500203E39C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736459274;
	bh=QcaCRMtsVSMQdmZ/SmrtTVHOPlBXPYZXYOKffMmOLCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IXjTOfWLx+9thZBfd0bmOlen5EeqUNSj423Oejg+9wBCczT0bL9g+fkMv7scFV57E
	 Y6cnFKG0WjNRaNq8LDxzp+0WR+tUDwcPFP4HS9vdhLmSYYPaAwo4U/vGNXqC99Ldi+
	 Ucgxf3ia/tCnHU7YLjEIVI4cf5iJ92nl+NcQJKPc=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: bpf@vger.kernel.org
Cc: nkapron@google.com,
	teknoraver@meta.com,
	roberto.sassu@huawei.com,
	gregkh@linuxfoundation.org,
	paul@paul-moore.com,
	code@tyhicks.com,
	flaniel@linux.microsoft.com
Subject: [PATCH 08/14] bpf: Add elf parsing support to the BPF_LOAD_FD subcommand
Date: Thu,  9 Jan 2025 13:43:50 -0800
Message-ID: <20250109214617.485144-9-bboscaccy@linux.microsoft.com>
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

Using the sysfs entry passed into the subcommand, the previosly loaded
elf object file is parsed.  The objective of this parse is to identify
key elf file sections, specfically the text and btf sections. From
there, indicies are saved to relevant sections. Armed with the initial
parse info, we search for and create program definitions, along with
any respective btf information for them.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 kernel/bpf/syscall.c | 175 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 3cfb497e1b236..03ab0bb7bf076 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6074,6 +6074,177 @@ skip_mods_and_typedefs(const struct btf *btf, u32 id, u32 *res_id)
 	return t;
 }
 
+static int init_btf(struct bpf_obj *obj, unsigned int btf_idx, unsigned int btf_ext_idx)
+{
+	Elf_Shdr *shdr =  &obj->sechdrs[btf_idx];
+	void *buffer = (void *)obj->hdr + shdr->sh_offset;
+	struct btf_ext_info *ext_segs[3];
+	int seg_num, sec_num;
+	int idx;
+	struct btf_ext_info *seg;
+	const struct btf_ext_info_sec *sec;
+	const char *sec_name;
+	struct btf *btf = btf_init_mem(buffer, shdr->sh_size, 0, 0, 0);
+
+	obj->btf = btf;
+	shdr = &obj->sechdrs[btf_ext_idx];
+	buffer = (void *)obj->hdr + shdr->sh_offset;
+	obj->btf_ext = btf_ext__new(buffer, shdr->sh_size);
+	obj->index.btf = btf_idx;
+	obj->index.btf_ext = btf_ext_idx;
+
+	/* setup .BTF.ext to ELF section mapping */
+	ext_segs[0] = &obj->btf_ext->func_info;
+	ext_segs[1] = &obj->btf_ext->line_info;
+	ext_segs[2] = &obj->btf_ext->core_relo_info;
+	for (seg_num = 0; seg_num < ARRAY_SIZE(ext_segs); seg_num++) {
+		seg = ext_segs[seg_num];
+
+		if (seg->sec_cnt == 0)
+			continue;
+
+		seg->sec_idxs = kcalloc(seg->sec_cnt, sizeof(*seg->sec_idxs), GFP_KERNEL);
+		if (!seg->sec_idxs)
+			return -ENOMEM;
+
+		sec_num = 0;
+		for_each_btf_ext_sec(seg, sec) {
+			/* preventively increment index to avoid doing
+			 * this before every continue below
+			 */
+			sec_num++;
+
+			sec_name = btf_str_by_offset(obj->btf, sec->sec_name_off);
+			if (str_is_empty(sec_name))
+				continue;
+
+			idx = elf_sec_idx_by_name(obj, sec_name);
+			if (idx < 0)
+				continue;
+			seg->sec_idxs[sec_num - 1] = idx;
+		}
+	}
+	return 0;
+}
+
+static int find_progs(struct bpf_obj *obj, unsigned int sec_idx)
+{
+	unsigned int i;
+	unsigned int prog_sz;
+	unsigned int sec_off;
+	Elf_Shdr *symsec = &obj->sechdrs[obj->index.sym];
+	Elf_Sym *sym = (void *)obj->hdr + symsec->sh_offset;
+	Elf_Shdr *shdr =  &obj->sechdrs[sec_idx];
+	struct bpf_prog_obj *progs;
+	int err;
+	struct bpf_insn *insns = NULL;
+	void *buffer;
+	unsigned int insn_cnt, ndx;
+	char *name;
+
+	for (i = 1; i < symsec->sh_size / sizeof(Elf_Sym); i++) {
+		name = obj->strtab + sym[i].st_name;
+
+		if (sym[i].st_shndx != sec_idx)
+			continue;
+		if (ELF64_ST_TYPE(sym[i].st_info) != STT_FUNC)
+			continue;
+
+		prog_sz = sym[i].st_size;
+		sec_off = sym[i].st_value;
+		buffer = (void *)obj->hdr + shdr->sh_offset + sec_off;
+
+		insns = kmalloc(prog_sz, GFP_KERNEL);
+		if (!insns)
+			return -ENOMEM;
+
+		memcpy(insns, buffer, prog_sz);
+		insn_cnt = prog_sz / sizeof(struct bpf_insn);
+
+		progs = krealloc_array(obj->progs, obj->nr_programs + 1,
+				       sizeof(struct bpf_prog_obj), GFP_KERNEL);
+		if (!progs) {
+			err = -ENOMEM;
+			goto free_insns;
+		}
+
+		obj->progs = progs;
+		ndx = obj->nr_programs;
+		obj->progs[ndx].insn = insns;
+		obj->progs[ndx].insn_cnt = insn_cnt;
+		obj->progs[ndx].sec_idx = sec_idx;
+		obj->progs[ndx].sec_insn_off = sec_off / sizeof(struct bpf_insn);
+		obj->progs[ndx].sec_insn_cnt = insn_cnt;
+		obj->progs[ndx].name = name;
+		obj->progs[ndx].exception_cb_idx = -1;
+		obj->nr_programs++;
+
+	}
+	return 0;
+
+free_insns:
+	kfree(insns);
+	return err;
+}
+
+static int elf_collect(struct bpf_obj *obj)
+{
+	unsigned int i;
+	Elf_Shdr *shdr, *strhdr;
+	unsigned int sym_idx;
+	unsigned int sec_idx = 0;
+	unsigned int btf_idx = 0, btf_ext_idx = 0;
+	int err = 0;
+
+	obj->sechdrs = (void *)obj->hdr + obj->hdr->e_shoff;
+	strhdr = &obj->sechdrs[obj->hdr->e_shstrndx];
+	obj->secstrings = (void *)obj->hdr + strhdr->sh_offset;
+
+	for (i = 1; i < obj->hdr->e_shnum; i++) {
+		shdr = &obj->sechdrs[i];
+		switch (shdr->sh_type) {
+		case SHT_NULL:
+		case SHT_NOBITS:
+			continue;
+		case SHT_SYMTAB:
+			sym_idx = i;
+			fallthrough;
+		default:
+			break;
+		}
+	}
+
+	obj->index.sym = sym_idx;
+	shdr = &obj->sechdrs[sym_idx];
+	obj->index.str = shdr->sh_link;
+	obj->strtab = (char *)obj->hdr + obj->sechdrs[obj->index.str].sh_offset;
+
+	for (i = 1; i < obj->hdr->e_shnum; i++) {
+		shdr = &obj->sechdrs[i];
+		sec_idx = i;
+		if (strcmp(".text", obj->secstrings + shdr->sh_name) == 0)
+			obj->index.text = sec_idx;
+
+		if (shdr->sh_type == SHT_PROGBITS && shdr->sh_size > 0) {
+			err = find_progs(obj, sec_idx);
+			if (err)
+				return err;
+		}
+
+		if (strcmp(".BTF", obj->secstrings + shdr->sh_name) == 0)
+			btf_idx = i;
+
+		if (strcmp(".BTF.ext", obj->secstrings + shdr->sh_name) == 0)
+			btf_ext_idx = i;
+
+		if (strcmp(".addr_space.1", obj->secstrings + shdr->sh_name) == 0)
+			obj->index.arena = sec_idx;
+	}
+
+	err = init_btf(obj, btf_idx, btf_ext_idx);
+	return err;
+}
+
 static void free_bpf_obj(struct bpf_obj *obj)
 {
 	int i;
@@ -6305,6 +6476,10 @@ static int load_fd(union bpf_attr *attr)
 	}
 	kfree(modules);
 
+	err = elf_collect(obj);
+	if (err < 0)
+		goto free;
+
 	return obj_f;
 free:
 	free_bpf_obj(obj);
-- 
2.47.1


