Return-Path: <bpf+bounces-70312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4851CBB7716
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 18:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E9C1890A2F
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 16:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9022BE024;
	Fri,  3 Oct 2025 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mh5Cd/we"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96142BD5A1
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759507486; cv=none; b=COtUVHX/navN8r8xlRu/vuRHZMKRJ4XwiSH+0JfkALZnQLORjr7pM8rhCSd1r9hEhvJuUHepDoXMh7+jRm8GR7shtFVyyID9mHIOaT1SmE2svSPwZQ8oKzjchZbINeEJyisHRxKw1L+FKlZndUllIP5TrNSTj1mw8ea1ESMYBOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759507486; c=relaxed/simple;
	bh=gXDR8hmWiUex6rLJ+ZnI8cvKeYR9oryHdum/DFGpU7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMfhzw5I+Drfm2TVH/+u8LU9a6wXgmvRJX3nnNWxKGLL1qTr0eJgIg37HWWaM49G7Pb+HpRjxox+aisJJeL3Vgb1HSG68o3WKMVI59I3XSpzytViSBULBrg49vz0nSXsWQC7zlPBvPGy3MTJtGjr1CX8vXaPquDGTHi3gAd2o0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mh5Cd/we; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e61ebddd6so22977965e9.0
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 09:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759507483; x=1760112283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7HGJLaEQd9SSRliEOKKtJpOYUYsPkSVqJRdvtsfT34=;
        b=mh5Cd/we+zsx6QYnEq318rEImm4EgPLZP8ol+fVHJNH9nZBLFKAo/OfzxAdrvo4l2N
         jJfd+KW3gLNdyrat6nL5XG/ZOggM8lh9/EiPtbvLNXrx7qQlc15AgCDXs+C2Pg4fI+XV
         XJ5slIelhr88FsoKJxuZ1aAfAV7HJGDJCrF03dO9j1+eB/drv2ElKLuC0TStuAABQHro
         WD34KyX2EXBwsldvNfI6Fn3w44CuJJRVQGFnR26s+ewIYnmXLgJY093+6Bff8N7FiWRq
         wL2WetpFTdcZ1EvTJAdZ/X69t9UIPy9GpyRBONgLWOWjikSYSZt4Tq6cSAP2F1HvjfcE
         nv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759507483; x=1760112283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7HGJLaEQd9SSRliEOKKtJpOYUYsPkSVqJRdvtsfT34=;
        b=cXVN1Z3KFygKD1bqcFcECcmvuCizji+8Y9hgzF1tIG05cNQWML5bLTMxEEmqCvk9gP
         daGvyVXtt8+Tuui0iIfiWZG6lG8VxHoNNtDLpuVwjMySjFIEd1xhipIZcTk59umx8o2k
         H8MyQgaJoK6z7m40D6s5P2ypRsL7/AmGZDrQdA1mW3oaZZmHCVHj6p+NJQcPmzLoTyDj
         4EkhGnpxmvtqFz1INM6ejmg2DkpX0i+Gl5Bm3sN4RcRSRoSIyCmX/vaeslmpxgkF9niz
         R1wvhnD3xj9xeUEbcAvn3hRAkQEZBCt04L2Cba5pQVj7wtG/WsubG92dE4kXHu+CNlIy
         83eg==
X-Gm-Message-State: AOJu0Yw/9bbSmvq1vLQJFj8alUyKFBPrGG25dRa6HkQ9Qj4QGC84Vu7l
	9pv4q/EHvia/tHwkdnhF7r9OmAJjGshh/ImcT1on+hUc4uXuuLf9Ai8awz1h0g==
X-Gm-Gg: ASbGncvLNtvy5QzO2jhTR4BClBnLGTxmX7cVzEjJiZRUAgX//icNIBBNKX0q8w0DuCJ
	HtRSCFChaHr4kw/oJkZ7JpX37eZ5TAACKcChDG1cAAbfYIC1IHb70WUBIp+TXG+yuohB7jA31jx
	Ln9P5YlRsysWSUuD3re9jN7lZHBOWcH/HOnM7Wl1AEWDFJc5ZjONfAufJWhw66ZqF/OSuD/kQt2
	JeA6zjo46JwdSS4BM1GUcEnh++uy9cHypWJDn7ZocbIBdaMk4x+ROvcIPpvF8rQmpD1BgaP0uxo
	zMfiJ7rxod0s/iBJcnaU5G/bYyGWcInI/7fLzIsof63sYXXsX+lNXRJoauvSt1Pwc7yq1HvmX13
	V4d7acQj/MRjvLbdiOQt2ZBzt8g==
X-Google-Smtp-Source: AGHT+IG7hu+a//Q4vaGG3yKVdqfKKP4ZVKnF3YP+lgsyZ/KrCS8pdVD9QOMyxm9J6YZvA6ViDP98pQ==
X-Received: by 2002:a05:600c:1987:b0:45d:5c71:769a with SMTP id 5b1f17b1804b1-46e71146083mr24413865e9.26.1759507482858;
        Fri, 03 Oct 2025 09:04:42 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:5b97])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e722e4c59sm37059425e9.0.2025.10.03.09.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 09:04:42 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [RFC PATCH v1 08/10] bpf: verifier: refactor kfunc specialization
Date: Fri,  3 Oct 2025 17:04:14 +0100
Message-ID: <20251003160416.585080-9-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Move kfunc specialization (function address substitution) to later stage
of verification to support a new use case, where we need to take into
consideration whether kfunc is called in sleepable context.

Minor refactoring in add_kfunc_call(), making sure that if function
fails, kfunc desc is not added to tab->descs (previously it could be
added or not, depending on what failed).

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/verifier.c | 97 ++++++++++++++++++++++++++-----------------
 1 file changed, 59 insertions(+), 38 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e4441155a4bf..aacefa3d0544 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -209,8 +209,6 @@ static void invalidate_non_owning_refs(struct bpf_verifier_env *env);
 static bool in_rbtree_lock_required_cb(struct bpf_verifier_env *env);
 static int ref_set_non_owning(struct bpf_verifier_env *env,
 			      struct bpf_reg_state *reg);
-static void specialize_kfunc(struct bpf_verifier_env *env,
-			     u32 func_id, u16 offset, unsigned long *addr);
 static bool is_trusted_reg(const struct bpf_reg_state *reg);
 
 static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
@@ -3105,6 +3103,10 @@ struct bpf_kfunc_btf_tab {
 	u32 nr_descs;
 };
 
+static unsigned long kfunc_call_imm(unsigned long func_addr, u32 func_id);
+
+static void specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc);
+
 static int kfunc_desc_cmp_by_id_off(const void *a, const void *b)
 {
 	const struct bpf_kfunc_desc *d0 = a;
@@ -3122,7 +3124,7 @@ static int kfunc_btf_cmp_by_off(const void *a, const void *b)
 	return d0->offset - d1->offset;
 }
 
-static const struct bpf_kfunc_desc *
+static struct bpf_kfunc_desc *
 find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset)
 {
 	struct bpf_kfunc_desc desc = {
@@ -3245,6 +3247,7 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 {
 	const struct btf_type *func, *func_proto;
 	struct bpf_kfunc_btf_tab *btf_tab;
+	struct btf_func_model func_model;
 	struct bpf_kfunc_desc_tab *tab;
 	struct bpf_prog_aux *prog_aux;
 	struct bpf_kfunc_desc *desc;
@@ -3334,19 +3337,6 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 			func_name);
 		return -EINVAL;
 	}
-	specialize_kfunc(env, func_id, offset, &addr);
-
-	if (bpf_jit_supports_far_kfunc_call()) {
-		call_imm = func_id;
-	} else {
-		call_imm = BPF_CALL_IMM(addr);
-		/* Check whether the relative offset overflows desc->imm */
-		if ((unsigned long)(s32)call_imm != call_imm) {
-			verbose(env, "address of kernel function %s is out of range\n",
-				func_name);
-			return -EINVAL;
-		}
-	}
 
 	if (bpf_dev_bound_kfunc_id(func_id)) {
 		err = bpf_dev_bound_kfunc_check(&env->log, prog_aux);
@@ -3354,18 +3344,29 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 			return err;
 	}
 
+	err = btf_distill_func_proto(&env->log, desc_btf,
+				     func_proto, func_name,
+				     &func_model);
+	if (err)
+		return err;
+
+	call_imm = kfunc_call_imm(addr, func_id);
+	/* Check whether the relative offset overflows desc->imm */
+	if ((unsigned long)(s32)call_imm != call_imm) {
+		verbose(env, "address of kernel function %s is out of range\n",
+			func_name);
+		return -EINVAL;
+	}
+
 	desc = &tab->descs[tab->nr_descs++];
 	desc->func_id = func_id;
-	desc->imm = call_imm;
 	desc->offset = offset;
 	desc->addr = addr;
-	err = btf_distill_func_proto(&env->log, desc_btf,
-				     func_proto, func_name,
-				     &desc->func_model);
-	if (!err)
-		sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
-		     kfunc_desc_cmp_by_id_off, NULL);
-	return err;
+	desc->imm = call_imm;
+	desc->func_model = func_model;
+	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
+	     kfunc_desc_cmp_by_id_off, NULL);
+	return 0;
 }
 
 static int kfunc_desc_cmp_by_imm_off(const void *a, const void *b)
@@ -21822,21 +21823,32 @@ static int fixup_call_args(struct bpf_verifier_env *env)
 	return err;
 }
 
+static unsigned long kfunc_call_imm(unsigned long func_addr, u32 func_id)
+{
+	if (bpf_jit_supports_far_kfunc_call())
+		return func_id;
+
+	return BPF_CALL_IMM(func_addr);
+}
+
 /* replace a generic kfunc with a specialized version if necessary */
-static void specialize_kfunc(struct bpf_verifier_env *env,
-			     u32 func_id, u16 offset, unsigned long *addr)
+static void specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc)
 {
+	struct bpf_prog_aux *prog_aux = env->prog->aux;
+	struct bpf_kfunc_desc_tab *tab = prog_aux->kfunc_tab;
 	struct bpf_prog *prog = env->prog;
 	bool seen_direct_write;
 	void *xdp_kfunc;
 	bool is_rdonly;
+	u32 func_id = desc->func_id;
+	u16 offset = desc->offset;
+	unsigned long call_imm;
+	unsigned long addr = 0;
 
 	if (bpf_dev_bound_kfunc_id(func_id)) {
 		xdp_kfunc = bpf_dev_bound_resolve_kfunc(prog, func_id);
-		if (xdp_kfunc) {
-			*addr = (unsigned long)xdp_kfunc;
-			return;
-		}
+		if (xdp_kfunc)
+			addr = (unsigned long)xdp_kfunc;
 		/* fallback to default kfunc when not supported by netdev */
 	}
 
@@ -21848,21 +21860,28 @@ static void specialize_kfunc(struct bpf_verifier_env *env,
 		is_rdonly = !may_access_direct_pkt_data(env, NULL, BPF_WRITE);
 
 		if (is_rdonly)
-			*addr = (unsigned long)bpf_dynptr_from_skb_rdonly;
+			addr = (unsigned long)bpf_dynptr_from_skb_rdonly;
 
 		/* restore env->seen_direct_write to its original value, since
 		 * may_access_direct_pkt_data mutates it
 		 */
 		env->seen_direct_write = seen_direct_write;
+	} else if (func_id == special_kfunc_list[KF_bpf_set_dentry_xattr]) {
+		if (bpf_lsm_has_d_inode_locked(prog))
+			addr = (unsigned long)bpf_set_dentry_xattr_locked;
+	} else if (func_id == special_kfunc_list[KF_bpf_remove_dentry_xattr]) {
+		if (bpf_lsm_has_d_inode_locked(prog))
+			addr = (unsigned long)bpf_remove_dentry_xattr_locked;
 	}
 
-	if (func_id == special_kfunc_list[KF_bpf_set_dentry_xattr] &&
-	    bpf_lsm_has_d_inode_locked(prog))
-		*addr = (unsigned long)bpf_set_dentry_xattr_locked;
+	if (!addr) /* Nothing to patch with */
+		return;
 
-	if (func_id == special_kfunc_list[KF_bpf_remove_dentry_xattr] &&
-	    bpf_lsm_has_d_inode_locked(prog))
-		*addr = (unsigned long)bpf_remove_dentry_xattr_locked;
+	call_imm = kfunc_call_imm(addr, func_id);
+	desc->imm = call_imm;
+	desc->addr = addr;
+	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
+	     kfunc_desc_cmp_by_id_off, NULL);
 }
 
 static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
@@ -21885,7 +21904,7 @@ static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
 static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    struct bpf_insn *insn_buf, int insn_idx, int *cnt)
 {
-	const struct bpf_kfunc_desc *desc;
+	struct bpf_kfunc_desc *desc;
 
 	if (!insn->imm) {
 		verbose(env, "invalid kernel function call not eliminated in verifier pass\n");
@@ -21905,6 +21924,8 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EFAULT;
 	}
 
+	specialize_kfunc(env, desc);
+
 	if (!bpf_jit_supports_far_kfunc_call())
 		insn->imm = BPF_CALL_IMM(desc->addr);
 	if (insn->off)
-- 
2.51.0


