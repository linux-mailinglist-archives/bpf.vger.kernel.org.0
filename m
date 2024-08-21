Return-Path: <bpf+bounces-37790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A9E95A85F
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 01:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A5928318D
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 23:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D7F17D378;
	Wed, 21 Aug 2024 23:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w0b5RFI6"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85DB17BB12
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 23:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724283327; cv=none; b=EnaFIKcOba0+FW7E0A6DJYMEemfqBxWmGE4fxmpZy8QsBacjDG3+sJ//URVghfbbZW4SS4jL1jJhr/lfLzMm4Es0m+n/Eu6bc2M6pqEWr5uy0VmPfag8zWL1U4xB/ZBHr7Vokrc//eQEgLsFA3Yqr/qeftQQbV3dTT66OwP4o84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724283327; c=relaxed/simple;
	bh=hpkwCapS0+PgvtZqDsWqvhK6VfSfWT0hlFAqCMT11Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZWs/4TK6c6Dxs28N2+/+zysOwHrFujTbATSXUXKp/5biwyGzumhUMLnmTuSn6ux2C84lP+RhQfoYnIQDGOkyq9wey7xK6gMxPI8XRpHTv6LY92sh15nAKo6+qGizGhIfGcFD6G3tu9M5o150vuutHYn/Od9lOefFazB19Vy9jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w0b5RFI6; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724283324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZqNDS4pWUNs5ErrGOt/CkchEH/gP5aIHQycT+Mf0CJw=;
	b=w0b5RFI6WovoyMdVoMz3I4DVG6pc3r5/yLtCrJ4iVqTpi6NTbjy3DiPmHVA7pEqYQyZVj3
	r0dnpKlc7WoVLGA8ooqfc2r5z76p++Ol57Sb9i5MPerDV/MDQc1ezZCsWp8lsSae+s2SBe
	+mBgdSHivwea8P7y8oes/Un4b2cxzos=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Amery Hung <ameryhung@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 7/8] bpf: Allow pro/epilogue to call kfunc
Date: Wed, 21 Aug 2024 16:34:37 -0700
Message-ID: <20240821233440.1855263-8-martin.lau@linux.dev>
In-Reply-To: <20240821233440.1855263-1-martin.lau@linux.dev>
References: <20240821233440.1855263-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

The existing prologue has been able to call bpf helper but not a kfunc.
This patch allows the prologue/epilogue to call the kfunc.

The subsystem that implements the .gen_prologue and .gen_epilogue
can add the BPF_PSEUDO_KFUNC_CALL instruction with insn->imm
set to the btf func_id of the kfunc call. This part is the same
as the bpf prog loaded from the sys_bpf.

Another piece is to have a way for the subsystem to tell the btf object
of the kfunc func_id. This patch uses the "struct module **module"
argument added to the .gen_prologue and .gen_epilogue
in the previous patch. The verifier will use btf_get_module_btf(module)
to find out the btf object.

The .gen_epi/prologue will usually use THIS_MODULE to initialize
the "*module = THIS_MODULE". Only kfunc(s) from one module (or vmlinux)
can be used in the .gen_epi/prologue now. In the future, the
.gen_epi/prologue can return an array of modules and use the
insn->off as an index into the array.

When the returned module is NULL, the btf is btf_vmlinux. Then the
insn->off stays at 0. This is the same as the sys_bpf.

When the btf is from a module, the btf needs an entry in
prog->aux->kfunc_btf_tab. The kfunc_btf_tab is currently
sorted by insn->off which is the offset to the attr->fd_array.

This module btf may or may not be in the kfunc_btf_tab. A new function
"find_kfunc_desc_btf_offset" is added to search for the existing entry
that has the same btf. If it is found, its offset will be used in
the insn->off. If it is not found, it will find an offset value
that is not used in the kfunc_btf_tab. Add a new entry
to kfunc_btf_tab and set this new offset to the insn->off

Once the insn->off is determined (either reuse an existing one
or an unused one is found), it will call the existing add_kfunc_call()
and everything else should fall through.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/verifier.c | 115 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 112 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5e995b7884fb..f4ac254a7661 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2787,6 +2787,60 @@ static struct btf *find_kfunc_desc_btf(struct bpf_verifier_env *env, s16 offset)
 	return btf_vmlinux ?: ERR_PTR(-ENOENT);
 }
 
+static int find_kfunc_desc_btf_offset(struct bpf_verifier_env *env, struct btf *btf,
+				      struct module *module, s16 *offset)
+{
+	struct bpf_kfunc_btf_tab *tab;
+	struct bpf_kfunc_btf *b;
+	s16 new_offset = 1; /* 0 is reserved for btf_vmlinux */
+	u32 i;
+
+	if (btf_is_vmlinux(btf)) {
+		*offset = 0;
+		return 0;
+	}
+
+	tab = env->prog->aux->kfunc_btf_tab;
+	if (!tab) {
+		tab = kzalloc(sizeof(*tab), GFP_KERNEL);
+		if (!tab)
+			return -ENOMEM;
+		env->prog->aux->kfunc_btf_tab = tab;
+	}
+
+	b = tab->descs;
+	for (i = 0; i < tab->nr_descs; i++) {
+		if (b[i].btf == btf) {
+			*offset = b[i].offset;
+			return 0;
+		}
+		/* tab->nr_descs (from the sys_bpf) max out at MAX_KFUNC_BTFS
+		 * which is smaller than S16_MAX, so it will be able to find
+		 * a new_offset to use.
+		 */
+		if (new_offset == b[i].offset)
+			new_offset++;
+	}
+
+	if (tab->nr_descs == MAX_KFUNC_BTFS) {
+		verbose(env, "too many different module BTFs\n");
+		return -E2BIG;
+	}
+
+	if (!try_module_get(module))
+		return -ENXIO;
+
+	b = &tab->descs[tab->nr_descs++];
+	btf_get(btf);
+	b->btf = btf;
+	b->module = module;
+	b->offset = new_offset;
+	*offset = new_offset;
+	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
+	     kfunc_btf_cmp_by_off, NULL);
+	return 0;
+}
+
 static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 {
 	const struct btf_type *func, *func_proto;
@@ -19603,6 +19657,50 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int fixup_pro_epilogue_kfunc(struct bpf_verifier_env *env, struct bpf_insn *insns,
+				    int cnt, struct module *module)
+{
+	struct btf *btf;
+	u32 func_id;
+	int i, err;
+	s16 offset;
+
+	for (i = 0; i < cnt; i++) {
+		if (!bpf_pseudo_kfunc_call(&insns[i]))
+			continue;
+
+		/* The kernel may not have BTF available, so only
+		 * try to get a btf if the pro/epilogue calls a kfunc.
+		 */
+		btf = btf_get_module_btf(module);
+		if (IS_ERR_OR_NULL(btf)) {
+			verbose(env, "cannot find BTF from %s for kfunc used in pro/epilogue\n",
+				module_name(module));
+			return -EINVAL;
+		}
+
+		func_id = insns[i].imm;
+		if (btf_is_vmlinux(btf) &&
+		    btf_id_set_contains(&special_kfunc_set, func_id)) {
+			verbose(env, "pro/epilogue cannot use special kfunc\n");
+			btf_put(btf);
+			return -EINVAL;
+		}
+
+		err = find_kfunc_desc_btf_offset(env, btf, module, &offset);
+		btf_put(btf);
+		if (err)
+			return err;
+
+		insns[i].off = offset;
+		err = add_kfunc_call(env, func_id, offset);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 /* convert load instructions that access fields of a context type into a
  * sequence of instructions that access fields of the underlying structure:
  *     struct __sk_buff    -> struct sk_buff
@@ -19612,21 +19710,27 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 {
 	struct bpf_subprog_info *subprogs = env->subprog_info;
 	const struct bpf_verifier_ops *ops = env->ops;
-	int i, cnt, size, ctx_field_size, delta = 0, epilogue_cnt = 0;
+	int err, i, cnt, size, ctx_field_size, delta = 0, epilogue_cnt = 0;
 	const int insn_cnt = env->prog->len;
 	struct bpf_insn insn_buf[16], epilogue_buf[16], *insn;
 	u32 target_size, size_default, off;
 	struct bpf_prog *new_prog;
 	enum bpf_access_type type;
 	bool is_narrower_load;
+	struct module *module;
 
 	if (ops->gen_epilogue) {
+		module = NULL;
 		epilogue_cnt = ops->gen_epilogue(epilogue_buf, env->prog,
-						 -(subprogs[0].stack_depth + 8), NULL);
+						 -(subprogs[0].stack_depth + 8), &module);
 		if (epilogue_cnt >= ARRAY_SIZE(epilogue_buf)) {
 			verbose(env, "bpf verifier is misconfigured\n");
 			return -EINVAL;
 		} else if (epilogue_cnt) {
+			err = fixup_pro_epilogue_kfunc(env, epilogue_buf, epilogue_cnt, module);
+			if (err)
+				return err;
+
 			/* Save the ARG_PTR_TO_CTX for the epilogue to use */
 			cnt = 0;
 			subprogs[0].stack_depth += 8;
@@ -19646,12 +19750,17 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			verbose(env, "bpf verifier is misconfigured\n");
 			return -EINVAL;
 		}
+		module = NULL;
 		cnt = ops->gen_prologue(insn_buf, env->seen_direct_write,
-					env->prog, NULL);
+					env->prog, &module);
 		if (cnt >= ARRAY_SIZE(insn_buf)) {
 			verbose(env, "bpf verifier is misconfigured\n");
 			return -EINVAL;
 		} else if (cnt) {
+			err = fixup_pro_epilogue_kfunc(env, insn_buf, cnt, module);
+			if (err)
+				return err;
+
 			new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
 			if (!new_prog)
 				return -ENOMEM;
-- 
2.43.5


