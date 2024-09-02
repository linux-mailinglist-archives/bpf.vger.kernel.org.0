Return-Path: <bpf+bounces-38694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F7E967FD6
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 08:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34061C21FBA
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 06:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37993165F1E;
	Mon,  2 Sep 2024 06:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxTDGCpD"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22A715688E
	for <bpf@vger.kernel.org>; Mon,  2 Sep 2024 06:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260314; cv=none; b=hbdCGjvT2UhDO0WVAbcVtvS/C6LLxuFnm5WK7y8/WqfFulnGLHYGXnBvRI7WJcGChjNI3TaiJIWHIeeLGcECOcuLyMhDaWeH8ZPkdllDNlN25qmkkwCqGB99hShxwBCmOPrmjs8eX44SQ5eOtM855RdG06K5CB5vLZvoM67nUVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260314; c=relaxed/simple;
	bh=e7piipeOWeW9DwA4UHV3SmhYZmVCbkjfVHMwGvwHuWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mme9GMfI6L9viPUMMG9Mwo+JWHtqRm8/B8zmv3e837crqKCzlnEvaMrbbj8MZ/IHsr15HZdo+SAhGQgLP307T73WQAJc+CyUbvuXZNwT/vH+zbhw3aSnl18IUep9p53tUrpj+lCkdro1+17nCes6SYWgj/8/eVRWyoPS0KDKvEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UxTDGCpD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725260312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n2jPEgl6JDbir6KjTm0KD/i+8R9qKa7QNmbU2dF4eKE=;
	b=UxTDGCpDaMRa8kb5ZrJsTs7ylpEJczz8Hun4ERE7Ec/0gkyh4dTG/BLxU28lVvRLa/bzx1
	ifDn+NoG5bkMLkcM1p2aoMGddT2cgsYcqdv/fLnG60o+asMSpoxLeaWcg9AQukvz9UriGh
	VT0BDBcx8WJ7lEk+22gtfRCMb52/rFw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-2bz0r4OxNeKi85WHTOtvhQ-1; Mon,
 02 Sep 2024 02:58:27 -0400
X-MC-Unique: 2bz0r4OxNeKi85WHTOtvhQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C06AD19772C2;
	Mon,  2 Sep 2024 06:58:25 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.225.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63E16195605A;
	Mon,  2 Sep 2024 06:58:21 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [RFC bpf-next 2/3] libbpf: Handle relocations in aliased symbols
Date: Mon,  2 Sep 2024 08:58:02 +0200
Message-ID: <113cf1f68a6e334d0f500d435095a2f61278afcc.1725016029.git.vmalik@redhat.com>
In-Reply-To: <cover.1725016029.git.vmalik@redhat.com>
References: <cover.1725016029.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

It is possible to create multiple BPF programs sharing the same
instructions using the compiler `__attribute__((alias("...")))`:

    int BPF_PROG(prog)
    {
        [...]
    }
    int prog_alias() __attribute__((alias("prog")));

The problem is that libbpf currently assumes that there may not be
multiple BPF programs sharing the same instruction set in a BPF object
and therefore records relocations for a single (arbitrarily chosen)
program only.

This commit adds libbpf support for aliased programs by recording
relocations for all the aliased programs. The core of the change is
updating find_prog_by_sec_insn() to return a sequence of programs
instead of one and updating its users (where relevant) to perform
relocation recording for all of the returned programs. For BPF object
not containing aliased symbols, this works exactly as before without
additional overhead.

Currently, the main user of this feature is bpftrace which allows to
attach the same BPF program to many attach points. While this is simple
for k(u)probes using k(u)probe_multi, other program types (fentry/fexit,
(raw) tracepoints) do not have such features and currently require the
BPF object to contain a copy of the program for each attach point.

For example, considering the following bpftrace script collecting the
number of hits of each VFS function using fentry over a one second
period:

    $ bpftrace -e 'kfunc:vfs_* { @[func] = count() } i:s:1 { exit() }'
    [...]

this change will allow to reduce the size of the in-memory BPF object
that bpftrace generates from 60K to 9K.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 tools/lib/bpf/libbpf.c | 143 ++++++++++++++++++++++++-----------------
 1 file changed, 84 insertions(+), 59 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e55353887439..91afacede687 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4612,14 +4612,15 @@ static bool prog_contains_insn(const struct bpf_program *prog, size_t insn_idx)
 	       insn_idx < prog->sec_insn_off + prog->sec_insn_cnt;
 }
 
-static struct bpf_program *find_prog_by_sec_insn(const struct bpf_object *obj,
-						 size_t sec_idx, size_t insn_idx)
+static int find_progs_by_sec_insn(const struct bpf_object *obj,
+				     size_t sec_idx, size_t insn_idx,
+				     struct bpf_program **progs)
 {
-	int l = 0, r = obj->nr_programs - 1, m;
+	int l = 0, r = obj->nr_programs - 1, m, nr_progs = 0;
 	struct bpf_program *prog;
 
 	if (!obj->nr_programs)
-		return NULL;
+		return 0;
 
 	while (l < r) {
 		m = l + (r - l + 1) / 2;
@@ -4631,13 +4632,20 @@ static struct bpf_program *find_prog_by_sec_insn(const struct bpf_object *obj,
 		else
 			r = m - 1;
 	}
-	/* matching program could be at index l, but it still might be the
-	 * wrong one, so we need to double check conditions for the last time
+	/* there may be multiple (aliasing) programs sharing the same instructions,
+	 * index l will contain the last one so we search for the first one,
+	 * set *progs to point to it, and return the number of matching programs
+	 *
+	 * note that there may be no matching programs so we may return 0 here
 	 */
 	prog = &obj->programs[l];
-	if (prog->sec_idx == sec_idx && prog_contains_insn(prog, insn_idx))
-		return prog;
-	return NULL;
+	while (l >= 0 && prog->sec_idx == sec_idx && prog_contains_insn(prog, insn_idx)) {
+		prog = &obj->programs[--l];
+		nr_progs++;
+	}
+	if (nr_progs)
+		*progs = &obj->programs[l + 1];
+	return nr_progs;
 }
 
 static int
@@ -4647,7 +4655,7 @@ bpf_object__collect_prog_relos(struct bpf_object *obj, Elf64_Shdr *shdr, Elf_Dat
 	size_t sec_idx = shdr->sh_info, sym_idx;
 	struct bpf_program *prog;
 	struct reloc_desc *relos;
-	int err, i, nrels;
+	int err, i, j, nrels, nr_progs;
 	const char *sym_name;
 	__u32 insn_idx;
 	Elf_Scn *scn;
@@ -4715,27 +4723,33 @@ bpf_object__collect_prog_relos(struct bpf_object *obj, Elf64_Shdr *shdr, Elf_Dat
 		pr_debug("sec '%s': relo #%d: insn #%u against '%s'\n",
 			 relo_sec_name, i, insn_idx, sym_name);
 
-		prog = find_prog_by_sec_insn(obj, sec_idx, insn_idx);
-		if (!prog) {
+		nr_progs = find_progs_by_sec_insn(obj, sec_idx, insn_idx, &prog);
+		if (!nr_progs) {
 			pr_debug("sec '%s': relo #%d: couldn't find program in section '%s' for insn #%u, probably overridden weak function, skipping...\n",
 				relo_sec_name, i, sec_name, insn_idx);
 			continue;
 		}
 
-		relos = libbpf_reallocarray(prog->reloc_desc,
-					    prog->nr_reloc + 1, sizeof(*relos));
-		if (!relos)
-			return -ENOMEM;
-		prog->reloc_desc = relos;
-
-		/* adjust insn_idx to local BPF program frame of reference */
+		/* adjust insn_idx to local BPF program frame of reference
+		 * we can just do it once as all progs have the same sec_insn_off
+		 */
 		insn_idx -= prog->sec_insn_off;
-		err = bpf_program__record_reloc(prog, &relos[prog->nr_reloc],
-						insn_idx, sym_name, sym, rel);
-		if (err)
-			return err;
 
-		prog->nr_reloc++;
+		for (j = 0; j < nr_progs; j++, prog++) {
+			relos = libbpf_reallocarray(prog->reloc_desc,
+						    prog->nr_reloc + 1, sizeof(*relos));
+			if (!relos)
+				return -ENOMEM;
+			prog->reloc_desc = relos;
+
+			/* adjust insn_idx to local BPF program frame of reference */
+			err = bpf_program__record_reloc(prog, &relos[prog->nr_reloc],
+							insn_idx, sym_name, sym, rel);
+			if (err)
+				return err;
+
+			prog->nr_reloc++;
+		}
 	}
 	return 0;
 }
@@ -5861,7 +5875,7 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 	struct bpf_program *prog;
 	struct bpf_insn *insn;
 	const char *sec_name;
-	int i, err = 0, insn_idx, sec_idx, sec_num;
+	int i, j, err = 0, insn_idx, sec_idx, sec_num, nr_progs;
 
 	if (obj->btf_ext->core_relo_info.len == 0)
 		return 0;
@@ -5899,8 +5913,8 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 			if (rec->insn_off % BPF_INSN_SZ)
 				return -EINVAL;
 			insn_idx = rec->insn_off / BPF_INSN_SZ;
-			prog = find_prog_by_sec_insn(obj, sec_idx, insn_idx);
-			if (!prog) {
+			nr_progs = find_progs_by_sec_insn(obj, sec_idx, insn_idx, &prog);
+			if (!nr_progs) {
 				/* When __weak subprog is "overridden" by another instance
 				 * of the subprog from a different object file, linker still
 				 * appends all the .BTF.ext info that used to belong to that
@@ -5913,43 +5927,48 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 					 sec_name, i, insn_idx);
 				continue;
 			}
-			/* no need to apply CO-RE relocation if the program is
-			 * not going to be loaded
-			 */
-			if (!prog->autoload)
-				continue;
 
 			/* adjust insn_idx from section frame of reference to the local
 			 * program's frame of reference; (sub-)program code is not yet
-			 * relocated, so it's enough to just subtract in-section offset
+			 * relocated, so it's enough to just subtract in-section offset;
+			 * we can just do it once as all progs have the same sec_insn_off
 			 */
 			insn_idx = insn_idx - prog->sec_insn_off;
 			if (insn_idx >= prog->insns_cnt)
 				return -EINVAL;
-			insn = &prog->insns[insn_idx];
 
-			err = record_relo_core(prog, rec, insn_idx);
-			if (err) {
-				pr_warn("prog '%s': relo #%d: failed to record relocation: %d\n",
-					prog->name, i, err);
-				goto out;
-			}
+			for (j = 0; j < nr_progs; j++, prog++) {
+				/* no need to apply CO-RE relocation if the program is
+				 * not going to be loaded
+				 */
+				if (!prog->autoload)
+					continue;
 
-			if (prog->obj->gen_loader)
-				continue;
+				insn = &prog->insns[insn_idx];
 
-			err = bpf_core_resolve_relo(prog, rec, i, obj->btf, cand_cache, &targ_res);
-			if (err) {
-				pr_warn("prog '%s': relo #%d: failed to relocate: %d\n",
-					prog->name, i, err);
-				goto out;
-			}
+				err = record_relo_core(prog, rec, insn_idx);
+				if (err) {
+					pr_warn("prog '%s': relo #%d: failed to record relocation: %d\n",
+						prog->name, i, err);
+					goto out;
+				}
 
-			err = bpf_core_patch_insn(prog->name, insn, insn_idx, rec, i, &targ_res);
-			if (err) {
-				pr_warn("prog '%s': relo #%d: failed to patch insn #%u: %d\n",
-					prog->name, i, insn_idx, err);
-				goto out;
+				if (prog->obj->gen_loader)
+					continue;
+
+				err = bpf_core_resolve_relo(prog, rec, i, obj->btf, cand_cache, &targ_res);
+				if (err) {
+					pr_warn("prog '%s': relo #%d: failed to relocate: %d\n",
+						prog->name, i, err);
+					goto out;
+				}
+
+				err = bpf_core_patch_insn(prog->name, insn, insn_idx, rec, i, &targ_res);
+				if (err) {
+					pr_warn("prog '%s': relo #%d: failed to patch insn #%u: %d\n",
+						prog->name, i, insn_idx, err);
+					goto out;
+				}
 			}
 		}
 	}
@@ -6350,7 +6369,7 @@ bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
 	struct bpf_program *subprog;
 	struct reloc_desc *relo;
 	struct bpf_insn *insn;
-	int err;
+	int err, nr_subprogs;
 
 	err = reloc_prog_func_and_line_info(obj, main_prog, prog);
 	if (err)
@@ -6406,12 +6425,15 @@ bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
 		}
 
 		/* we enforce that sub-programs should be in .text section */
-		subprog = find_prog_by_sec_insn(obj, obj->efile.text_shndx, sub_insn_idx);
-		if (!subprog) {
+		nr_subprogs = find_progs_by_sec_insn(obj, obj->efile.text_shndx, sub_insn_idx, &subprog);
+		if (!nr_subprogs) {
 			pr_warn("prog '%s': no .text section found yet sub-program call exists\n",
 				prog->name);
 			return -LIBBPF_ERRNO__RELOC;
 		}
+		/* there may be multiple aliasing subprogs but it doesn't matter
+		 * which one we use here as they must all have the same insns
+		 */
 
 		/* if it's the first call instruction calling into this
 		 * subprogram (meaning this subprog hasn't been processed
@@ -9725,7 +9747,7 @@ static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
 	__u32 member_idx;
 	Elf64_Sym *sym;
 	Elf64_Rel *rel;
-	int i, nrels;
+	int i, nrels, nr_progs;
 
 	btf = obj->btf;
 	nrels = shdr->sh_size / shdr->sh_entsize;
@@ -9789,12 +9811,15 @@ static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
 			return -EINVAL;
 		}
 
-		prog = find_prog_by_sec_insn(obj, shdr_idx, insn_idx);
-		if (!prog) {
+		nr_progs = find_progs_by_sec_insn(obj, shdr_idx, insn_idx, &prog);
+		if (!nr_progs) {
 			pr_warn("struct_ops reloc %s: cannot find prog at shdr_idx %u to relocate func ptr %s\n",
 				map->name, shdr_idx, name);
 			return -EINVAL;
 		}
+		/* there may be multiple aliasing progs but it doesn't matter
+		 * which one we use here as they must all have the same insns
+		 */
 
 		/* prevent the use of BPF prog with invalid type */
 		if (prog->type != BPF_PROG_TYPE_STRUCT_OPS) {
-- 
2.46.0


