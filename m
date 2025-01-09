Return-Path: <bpf+bounces-48475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FA1A0826D
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348473A8602
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 21:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1957C204C23;
	Thu,  9 Jan 2025 21:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="j9DCuONh"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DC7204C2C
	for <bpf@vger.kernel.org>; Thu,  9 Jan 2025 21:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459301; cv=none; b=o1laNPAuUzsziPel5Aa9bHwplWJ23CsLqfiQlVuOVFnGfG4b2n5QzHYmcm1HaprIwa/gsyCQPxAobGGnjfH0h3ye/6GAV/l2kYKUXWaAznLqZ3HvDHOBEHvG7piuu2Uxd1k4P8yO2o4SbjOIKOWPfIIWGyFq0MQ28T/1S7W9bNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459301; c=relaxed/simple;
	bh=gjLhZnAGKTsDkooGOBFY8/UYgK1Rt9KtzNA7fJeKdGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jot/ZLwdbqZa47+IvzaYcGs1OURZYQn9cI4CjD8vvDTtxgGFEA4RKyDbQUBk/Thmq5MpkOjGJqw0a5CsuKjao1yTLvlUjcWqsqV3B2S6awFew5+S5ducF2ki0A8iKv5aZxueHMU3QnixcDhEw5qW9X0HcwYjsLCXCk3+ZtOWhp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=j9DCuONh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1A558203E3A1;
	Thu,  9 Jan 2025 13:48:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1A558203E3A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736459299;
	bh=fgwXH2TRGiuXekeIIRkMCnKUXxmNSPexDoJUBjRhkDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j9DCuONhUUyd7GiUVTVe1Wp5jQjAATADKWSGOTbZxuyVVS04lrq8a3Qjb/jRjmx08
	 3TG7fkMIpl5S+tovVce3jmLELiigphoZ9rL5LTMfijT3ofh/zCHAmyUfXYnXWm2pMB
	 1ozuHezTf3xsGWBnceV/bo4Lvjbb2Vfa6Lo+29oM=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: bpf@vger.kernel.org
Cc: nkapron@google.com,
	teknoraver@meta.com,
	roberto.sassu@huawei.com,
	gregkh@linuxfoundation.org,
	paul@paul-moore.com,
	code@tyhicks.com,
	flaniel@linux.microsoft.com
Subject: [PATCH 13/14] bpf: Apply in-kernel bpf instruction relocations
Date: Thu,  9 Jan 2025 13:43:55 -0800
Message-ID: <20250109214617.485144-14-bboscaccy@linux.microsoft.com>
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

This code heavily borrows from libbpf, in particular,
bpf_object__relocate.  CO-RE relocation facilities already exist in
the kernel.

All the previously collected relocations are applied and the immediate
of the instructions are re-written accordingly.  Any values
corresponding to map offsets depend upon the user-supplied map array.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 kernel/bpf/syscall.c | 489 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 489 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index b766c790ae3f4..ea0401634e752 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -41,6 +41,8 @@
 #include <net/netkit.h>
 #include <net/tcx.h>
 
+#include "../tools/lib/bpf/relo_core.h"
+
 #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
 			  (map)->map_type == BPF_MAP_TYPE_CGROUP_ARRAY || \
 			  (map)->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS)
@@ -7237,6 +7239,489 @@ static int resolve_externs(struct bpf_obj *obj)
 	return 0;
 }
 
+static int relocate_core(struct bpf_obj *obj)
+{
+	const struct btf_ext_info_sec *sec;
+	const struct bpf_core_relo *rec;
+	const struct btf_ext_info *seg;
+	int i, insn_idx, sec_idx, sec_num;
+	struct bpf_prog_obj *prog;
+	struct bpf_insn *insn;
+	const char *sec_name;
+
+	struct bpf_core_ctx ctx = {
+		.log = NULL,
+		.btf = obj->btf,
+	};
+
+	seg = &obj->btf_ext->core_relo_info;
+	sec_num = 0;
+
+	for_each_btf_ext_sec(seg, sec) {
+		sec_idx = seg->sec_idxs[sec_num];
+		sec_num++;
+		sec_name = btf_str_by_offset(obj->btf, sec->sec_name_off);
+
+		for_each_btf_ext_rec(seg, sec, i, rec) {
+			insn_idx = rec->insn_off / sizeof(struct bpf_insn);
+			prog = find_prog_by_sec_insn(obj, sec_idx, insn_idx);
+
+			if (!prog)
+				continue;
+
+			insn_idx = insn_idx - prog->sec_insn_off;
+			if (insn_idx >= prog->insn_cnt)
+				return -EINVAL;
+			insn = &prog->insn[insn_idx];
+
+			bpf_core_apply(&ctx, rec, i, insn);
+		}
+	}
+
+	return 0;
+}
+
+static int append_subprog_relos(struct bpf_prog_obj *main_prog, struct bpf_prog_obj *subprog)
+{
+	int new_cnt = main_prog->nr_reloc + subprog->nr_reloc;
+	struct bpf_reloc_desc *relos;
+	int i;
+
+	if (main_prog == subprog)
+		return 0;
+	relos = krealloc_array(main_prog->reloc_desc, new_cnt, sizeof(*relos), GFP_KERNEL);
+	/* if new count is zero, reallocarray can return a valid NULL result;
+	 * in this case the previous pointer will be freed, so we *have to*
+	 * reassign old pointer to the new value (even if it's NULL)
+	 */
+	if (!relos && new_cnt)
+		return -ENOMEM;
+	if (subprog->nr_reloc)
+		memcpy(relos + main_prog->nr_reloc, subprog->reloc_desc,
+		       sizeof(*relos) * subprog->nr_reloc);
+
+	for (i = main_prog->nr_reloc; i < new_cnt; i++)
+		relos[i].insn_idx += subprog->sub_insn_off;
+	/* After insn_idx adjustment the 'relos' array is still sorted
+	 * by insn_idx and doesn't break bsearch.
+	 */
+	main_prog->reloc_desc = relos;
+	main_prog->nr_reloc = new_cnt;
+	return 0;
+}
+
+static int cmp_relo_by_insn_idx(const void *key, const void *elem)
+{
+	size_t insn_idx = *(const size_t *)key;
+	const struct bpf_reloc_desc *relo = elem;
+
+	if (insn_idx == relo->insn_idx)
+		return 0;
+	return insn_idx < relo->insn_idx ? -1 : 1;
+}
+
+static struct bpf_reloc_desc *find_prog_insn_relo(const struct bpf_prog_obj *prog, size_t insn_idx)
+{
+	if (!prog->nr_reloc)
+		return NULL;
+	return bsearch(&insn_idx, prog->reloc_desc, prog->nr_reloc,
+		       sizeof(*prog->reloc_desc), cmp_relo_by_insn_idx);
+}
+
+static int append_subprog_code(struct bpf_obj *obj, struct bpf_prog_obj *main_prog,
+			       struct bpf_prog_obj *subprog)
+{
+	struct bpf_insn *insns;
+	size_t new_cnt;
+	int err;
+
+	subprog->sub_insn_off = main_prog->insn_cnt;
+
+	new_cnt = main_prog->insn_cnt + subprog->insn_cnt;
+	insns = krealloc_array(main_prog->insn, new_cnt, sizeof(*insns), GFP_KERNEL);
+	if (!insns) {
+		pr_warn("prog '%s': failed to realloc prog code\n", main_prog->name);
+		return -ENOMEM;
+	}
+
+	main_prog->insn = insns;
+	main_prog->insn_cnt = new_cnt;
+
+	memcpy(main_prog->insn + subprog->sub_insn_off, subprog->insn,
+	       subprog->insn_cnt * sizeof(*insns));
+
+	/* The subprog insns are now appended. Append its relos too. */
+	err = append_subprog_relos(main_prog, subprog);
+	if (err)
+		return err;
+	return 0;
+}
+
+static int reloc_code(struct bpf_obj *obj, struct bpf_prog_obj *main_prog,
+		      struct bpf_prog_obj *prog)
+{
+
+	size_t sub_idx, insn_idx;
+	struct bpf_prog_obj *subprog;
+	struct bpf_reloc_desc *relo;
+	struct bpf_insn *insn;
+	int err;
+
+	for (insn_idx = 0; insn_idx < prog->sec_insn_cnt; insn_idx++) {
+		insn = &main_prog->insn[prog->sub_insn_off + insn_idx];
+		if (!insn_is_subprog_call(insn) && !insn_is_pseudo_func(insn))
+			continue;
+
+		relo = find_prog_insn_relo(prog, insn_idx);
+		if (relo && relo->type == RELO_EXTERN_CALL)
+			/* kfunc relocations will be handled later
+			 * in bpf_object__relocate_data()
+			 */
+			continue;
+		if (relo && relo->type != RELO_CALL && relo->type != RELO_SUBPROG_ADDR) {
+			pr_warn("prog '%s': unexpected relo for insn #%zu, type %d\n",
+				prog->name, insn_idx, relo->type);
+			return -EOPNOTSUPP;
+		}
+		if (relo) {
+			/* sub-program instruction index is a combination of
+			 * an offset of a symbol pointed to by relocation and
+			 * call instruction's imm field; for global functions,
+			 * call always has imm = -1, but for static functions
+			 * relocation is against STT_SECTION and insn->imm
+			 * points to a start of a static function
+			 *
+			 * for subprog addr relocation, the relo->sym_off + insn->imm is
+			 * the byte offset in the corresponding section.
+			 */
+			if (relo->type == RELO_CALL)
+				sub_idx = relo->sym_off / sizeof(struct bpf_insn) + insn->imm + 1;
+			else
+				sub_idx = (relo->sym_off + insn->imm) / sizeof(struct bpf_insn);
+		} else if (insn_is_pseudo_func(insn)) {
+			/*
+			 * RELO_SUBPROG_ADDR relo is always emitted even if both
+			 * functions are in the same section, so it shouldn't reach here.
+			 */
+			pr_warn("prog '%s': missing subprog addr relo for insn #%zu\n",
+				prog->name, insn_idx);
+			return -EOPNOTSUPP;
+		} else {
+			/* if subprogram call is to a static function within
+			 * the same ELF section, there won't be any relocation
+			 * emitted, but it also means there is no additional
+			 * offset necessary, insns->imm is relative to
+			 * instruction's original position within the section
+			 */
+			sub_idx = prog->sec_insn_off + insn_idx + insn->imm + 1;
+		}
+
+		/* we enforce that sub-programs should be in .text section */
+		subprog = find_prog_by_sec_insn(obj, obj->index.text, sub_idx);
+		if (!subprog) {
+			pr_warn("prog '%s': no .text section found yet sub-program call exists\n",
+				prog->name);
+			return -EOPNOTSUPP;
+		}
+
+		/* if it's the first call instruction calling into this
+		 * subprogram (meaning this subprog hasn't been processed
+		 * yet) within the context of current main program:
+		 *   - append it at the end of main program's instructions blog;
+		 *   - process is recursively, while current program is put on hold;
+		 *   - if that subprogram calls some other not yet processes
+		 *   subprogram, same thing will happen recursively until
+		 *   there are no more unprocesses subprograms left to append
+		 *   and relocate.
+		 */
+		if (subprog->sub_insn_off == 0) {
+			err = append_subprog_code(obj, main_prog, subprog);
+			if (err)
+				return err;
+			err = reloc_code(obj, main_prog, subprog);
+			if (err)
+				return err;
+		}
+
+		/* main_prog->insns memory could have been re-allocated, so
+		 * calculate pointer again
+		 */
+		insn = &main_prog->insn[prog->sub_insn_off + insn_idx];
+		/* calculate correct instruction position within current main
+		 * prog; each main prog can have a different set of
+		 * subprograms appended (potentially in different order as
+		 * well), so position of any subprog can be different for
+		 * different main programs
+		 */
+		insn->imm = subprog->sub_insn_off - (prog->sub_insn_off + insn_idx) - 1;
+
+		pr_debug("prog '%s': insn #%zu relocated, imm %d points to subprog '%s' (now at %zu offset)\n",
+			 prog->name, insn_idx, insn->imm, subprog->name, subprog->sub_insn_off);
+	}
+
+	return 0;
+}
+
+static bool prog_is_subprog(const struct bpf_obj *obj, const struct bpf_prog_obj *prog)
+{
+	return prog->sec_idx == obj->index.text && obj->nr_programs > 1;
+}
+
+static int relocate_calls(struct bpf_obj *obj, struct bpf_prog_obj *prog)
+{
+	struct bpf_prog_obj *subprog;
+	int i, err;
+
+	/* mark all subprogs as not relocated (yet) within the context of
+	 * current main program
+	 */
+	for (i = 0; i < obj->nr_programs; i++) {
+		subprog = &obj->progs[i];
+		if (!prog_is_subprog(obj, subprog))
+			continue;
+
+		subprog->sub_insn_off = 0;
+	}
+
+	err = reloc_code(obj, prog, prog);
+	if (err)
+		return err;
+	return 0;
+
+}
+
+/* unresolved kfunc call special constant, used also for log fixup logic */
+#define POISON_CALL_KFUNC_BASE 2002000000
+#define POISON_CALL_KFUNC_PFX "2002"
+
+static void poison_kfunc_call(struct bpf_prog_obj *prog, int relo_idx,
+			      int insn_idx, struct bpf_insn *insn,
+			      int ext_idx, const struct bpf_extern_desc *ext)
+{
+	pr_debug("prog '%s': relo #%d: poisoning insn #%d that calls kfunc '%s'\n",
+		 prog->name, relo_idx, insn_idx, ext->name);
+
+	/* we turn kfunc call into invalid helper call with identifiable constant */
+	insn->code = BPF_JMP | BPF_CALL;
+	insn->dst_reg = 0;
+	insn->src_reg = 0;
+	insn->off = 0;
+	/* if this instruction is reachable (not a dead code),
+	 * verifier will complain with something like:
+	 * invalid func unknown#2001000123
+	 * where lower 123 is extern index into obj->externs[] array
+	 */
+	insn->imm = POISON_CALL_KFUNC_BASE + ext_idx;
+}
+
+static int relocate_data(struct bpf_obj *obj, struct bpf_prog_obj *prog)
+{
+	int i;
+
+	for (i = 0; i < prog->nr_reloc; i++) {
+		struct bpf_reloc_desc *relo = &prog->reloc_desc[i];
+		struct bpf_insn *insn = &prog->insn[relo->insn_idx];
+		const struct bpf_map_obj *map;
+		struct bpf_extern_desc *ext;
+
+		switch (relo->type) {
+		case RELO_LD64:
+			map = &obj->maps[relo->map_idx];
+			insn[0].src_reg = BPF_PSEUDO_MAP_FD;
+			insn[0].imm = map->fd;
+			break;
+		case RELO_DATA:
+			map = &obj->maps[relo->map_idx];
+			insn[0].src_reg = BPF_PSEUDO_MAP_VALUE;
+			insn[0].imm = map->fd;
+			break;
+		case RELO_EXTERN_LD64:
+			ext = &obj->externs[relo->ext_idx];
+			if (ext->type == EXT_KCFG) {
+				insn[0].src_reg = BPF_PSEUDO_MAP_VALUE;
+				insn[0].imm = obj->maps[obj->kconfig_map_idx].fd;
+				insn[1].imm = ext->kcfg.data_off;
+			} else /* EXT_KSYM */ {
+				if (ext->ksym.type_id && ext->is_set) { /* typed ksyms */
+					insn[0].src_reg = BPF_PSEUDO_BTF_ID;
+					insn[0].imm = ext->ksym.kernel_btf_id;
+					insn[1].imm = ext->ksym.kernel_btf_obj_fd;
+				} else { /* typeless ksyms or unresolved typed ksyms */
+					insn[0].imm = (__u32)ext->ksym.addr;
+					insn[1].imm = ext->ksym.addr >> 32;
+				}
+			}
+			break;
+		case RELO_EXTERN_CALL:
+			ext = &obj->externs[relo->ext_idx];
+			insn[0].src_reg = BPF_PSEUDO_KFUNC_CALL;
+			if (ext->is_set) {
+				insn[0].imm = ext->ksym.kernel_btf_id;
+				insn[0].off = ext->ksym.btf_fd_idx;
+			} else { /* unresolved weak kfunc call */
+				poison_kfunc_call(prog, i, relo->insn_idx, insn,
+						  relo->ext_idx, ext);
+			}
+			break;
+		case RELO_SUBPROG_ADDR:
+		case RELO_CALL:
+		case RELO_CORE:
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int prog_assign_exc_cb(struct bpf_obj *obj, struct bpf_prog_obj *prog)
+{
+	const char *str = "exception_callback:";
+	size_t pfx_len = strlen(str);
+	int i, j, n;
+	const char *name;
+	const struct btf_type *t;
+
+	if (!obj->btf)
+		return 0;
+
+	n = btf_type_cnt(obj->btf);
+	for (i = 1; i < n; i++) {
+		t = btf_type_by_id(obj->btf, i);
+		if (!btf_is_decl_tag(t) || btf_decl_tag(t)->component_idx != -1)
+			continue;
+
+		name = btf_str_by_offset(obj->btf, t->name_off);
+		if (strncmp(name, str, pfx_len) != 0)
+			continue;
+
+		t = btf_type_by_id(obj->btf, t->type);
+		if (!btf_is_func(t) || btf_func_linkage(t) != BTF_FUNC_GLOBAL) {
+			pr_warn("prog '%s': exception_callback:<value> decl tag not applied to the main program\n",
+				prog->name);
+			return -EINVAL;
+		}
+		if (strcmp(prog->name, btf_str_by_offset(obj->btf, t->name_off)) != 0)
+			continue;
+		/* Multiple callbacks are specified for the same prog,
+		 * the verifier will eventually return an error for this
+		 * case, hence simply skip appending a subprog.
+		 */
+		if (prog->exception_cb_idx >= 0) {
+			prog->exception_cb_idx = -1;
+			break;
+		}
+
+		name += pfx_len;
+		if (str_is_empty(name)) {
+			pr_warn("prog '%s': exception_callback:<value> decl tag contains empty value\n",
+				prog->name);
+			return -EINVAL;
+		}
+
+		for (j = 0; j < obj->nr_programs; j++) {
+			struct bpf_prog_obj *subprog = &obj->progs[j];
+
+			if (!prog_is_subprog(obj, subprog))
+				continue;
+			if (strcmp(name, subprog->name) != 0)
+				continue;
+			/* Let's see if we already saw a static exception callback with this name */
+			if (prog->exception_cb_idx >= 0) {
+				pr_warn("prog '%s': multiple subprogs with same name as exception callback '%s'\n",
+					prog->name, subprog->name);
+				return -EINVAL;
+			}
+			prog->exception_cb_idx = j;
+			break;
+		}
+
+		if (prog->exception_cb_idx >= 0)
+			continue;
+
+		pr_warn("prog '%s': cannot find exception callback '%s'\n", prog->name, name);
+		return -ENOENT;
+	}
+
+	return 0;
+
+}
+
+static int relocate_object(struct bpf_obj *obj)
+{
+	struct bpf_prog_obj *prog;
+	int i, j, err;
+
+	if (obj->btf)
+		relocate_core(obj);
+
+	for (i = 0; i < obj->nr_programs; i++) {
+		prog = &obj->progs[i];
+		for (j = 0; j < prog->nr_reloc; j++) {
+			struct bpf_reloc_desc *relo = &prog->reloc_desc[j];
+			struct bpf_insn *insn = &prog->insn[relo->insn_idx];
+
+			/* mark the insn, so it's recognized by insn_is_pseudo_func() */
+			if (relo->type == RELO_SUBPROG_ADDR)
+				insn[0].src_reg = BPF_PSEUDO_FUNC;
+		}
+	}
+
+	for (i = 0; i < obj->nr_programs; i++) {
+		prog = &obj->progs[i];
+		/* sub-program's sub-calls are relocated within the context of
+		 * its main program only
+		 */
+		if (prog_is_subprog(obj, prog))
+			continue;
+
+		err = relocate_calls(obj, prog);
+		if (err) {
+			pr_warn("prog '%s': failed to relocate calls: %d\n",
+				prog->name, err);
+			return err;
+		}
+
+		err = prog_assign_exc_cb(obj, prog);
+		if (err)
+			return err;
+
+		/* Now, also append exception callback if it has not been done already. */
+		if (prog->exception_cb_idx >= 0) {
+			struct bpf_prog_obj *subprog = &obj->progs[prog->exception_cb_idx];
+
+			/* Calling exception callback directly is disallowed, which the
+			 * verifier will reject later. In case it was processed already,
+			 * we can skip this step, otherwise for all other valid cases we
+			 * have to append exception callback now.
+			 */
+			if (subprog->sub_insn_off == 0) {
+				err = append_subprog_code(obj, prog, subprog);
+				if (err)
+					return err;
+				err = reloc_code(obj, prog, subprog);
+				if (err)
+					return err;
+			}
+		}
+	}
+
+	for (i = 0; i < obj->nr_programs; i++) {
+		prog = &obj->progs[i];
+		if (prog_is_subprog(obj, prog))
+			continue;
+
+		/* Process data relos for main programs */
+		err = relocate_data(obj, prog);
+		if (err) {
+			pr_warn("prog '%s': failed to relocate data references: %d\n",
+				prog->name, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 static void free_bpf_obj(struct bpf_obj *obj)
 {
 	int i;
@@ -7488,6 +7973,10 @@ static int load_fd(union bpf_attr *attr)
 	if (err < 0)
 		goto free;
 
+	err = relocate_object(obj);
+	if (err < 0)
+		goto free;
+
 	return obj_f;
 free:
 	free_bpf_obj(obj);
-- 
2.47.1


