Return-Path: <bpf+bounces-71027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC57BDF991
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 18:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7027B54228A
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B983375D6;
	Wed, 15 Oct 2025 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhcVzwow"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515873375AD
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 16:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544730; cv=none; b=ad5VLz07UEvLpGGIhfpNPM31VKx4SkvAFGZFcsf47suEL9ThYBXqIrIaRz/QebA0ayyb0OC9UemZktFZ0eQEg40LH/NJD+NYJIYGU7iq1QcRjKr7aF5Y2uqGKZij+qNekgMAXU7uug0TFQE+fuZK0Ja7nobmyzOX3UgvklrvfmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544730; c=relaxed/simple;
	bh=MtlqMsT/3aPB9r5Gvp4EiyregmrTpu1z+IwkL4He+jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JiISM9fUJjscgFF09Z5qi6CPb5cWltqeqN+F7DGRGfSuTsMsPORAP1y60yOY9gOxIlUEPfURfLV8d2y/XAbgedyYxR4840bxy6Zo+trkCeuL2uz/A+8IwaCNE0RdgzC3mtHq7EoS6lkItKeJcwA9xhdss5goj60yn6j5CQD2QEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhcVzwow; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47108104bcbso6959655e9.3
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 09:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760544726; x=1761149526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZSbcpGRmzbA7NgC3lAm/Lf1nYXopoQgf/v2nAjplw0=;
        b=NhcVzwowVadf3mZb/yXE27cof19OGIPeYroikaSXjCZeiA1QCZOSXbhdQVrnHyMnJa
         tCUWmxaNXekqQQ6YDLCpdhY6y4uf2TDwFIEd+huCMPAwOLiFx4piQKYcfK9YEaC0b1R2
         UVwIum5Lcy7uquXGEhlsTff41Ur1DlDVaAbBCgh3k/gz79z8DzDxrXEjt2wwaWg8VpH2
         oDdyOD6SQwQ18W27q7/KCdbwWbzuPM8gbnASwtFb4cu5RLPVs1QXpBzdSeKOCjYvMF/3
         3BYRNFWM+bnXc+Bu5FzwI+VLbTDwO17eQKZremqNG+sn/Fi8fDjp7GSP1JwLHUULjlui
         DoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760544726; x=1761149526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZSbcpGRmzbA7NgC3lAm/Lf1nYXopoQgf/v2nAjplw0=;
        b=uNHJwrfoa/0E3cbbMpcQrgEhciiaNi6wFWyE9mCgpKktpud4gYqAjd85EssrlBEbgo
         +Li+Vh1X2tjC0jfC1ieXqtCMafQ0Fk3XR9iVteGJCNKyvMGvLZyh4cLfbx0VEbYLzFeI
         4uOGyw1cjY1ihqkk3exe2TBWot4RQ6feLIvZpy2UPnP9ck3tU1/OZYBN6/tmPfX9J3jx
         rviRUO+1R1OPKol0c79biPnNoJLa4GyuBJ9xmqsv4Nb4roDzoV+BsJ/Y6U3IE/9iJd7n
         URNLkknlk5KNSUsffee/fTnS/FVNppoPnv+cn9kkbHp6qaVtaIZsEKUwjzmayASDk8V6
         Tt8w==
X-Gm-Message-State: AOJu0YySLbv/Gv1a2lS/5+cvqVnTk8XkvHB3XQXO03vU4cQRsHC9ah9u
	Pcy50czG7Rt+z6ALh9EqQvVzWH8YGOTrA6Fn9eqm/1t3oBG4CU5a9pyg3siVPA==
X-Gm-Gg: ASbGncvacaO2K5eotvPdv4Kn3F8tjBd5Jhjhu1GFpTYrLggJ5/kr2gruaWknkwCqQGh
	3To1HR7Go8GRmT6aS2JPIoQsCZxdx6L53drIvVVH21+TkohI6/9F1hm4XYVvZhwdV+f5lHnJO9a
	xhoHvra+daAMqSG3vTi/ioD7UiqxREr58DmOeQt79YbVNgk1UkQaNBp/yb/xfwbVy4ERiL7+usF
	PPEdRV6/ndHTSjeubr9XTfuCypbCpmmuARRm+kigTef3njqMDu27NU1G9vYMbDHqKv+bYszzfoL
	IVOBsSRaavOwGYLp7tzPD0JPrJ+5/7ip3sswLeiVU+ea5dIBB+LmauD3h5OvwfwEehmP25uogdY
	LjcrubXh2KCvvo0GShtPlMfv7btNEyy7auLS+QLWBghFCRWqgnQ+6rPo=
X-Google-Smtp-Source: AGHT+IEvHQae/DdgE4l69ZGk9YPpgiY3aHyHsz2CnC3/A5kBWiPZHJ65DfE1jKBbUd365IB/TXLpxA==
X-Received: by 2002:a05:600c:1e87:b0:46e:4b89:13d9 with SMTP id 5b1f17b1804b1-46fa9a22e67mr206408735e9.0.1760544726381;
        Wed, 15 Oct 2025 09:12:06 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-470ff15ef28sm47411315e9.5.2025.10.15.09.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 09:12:05 -0700 (PDT)
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
Subject: [RFC PATCH v2 09/11] bpf: verifier: refactor kfunc specialization
Date: Wed, 15 Oct 2025 17:11:53 +0100
Message-ID: <20251015161155.120148-10-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
References: <20251015161155.120148-1-mykyta.yatsenko5@gmail.com>
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
 kernel/bpf/verifier.c | 99 ++++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 43 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7bae81c631cf..f9f7151eaf1f 100644
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
@@ -3126,6 +3124,10 @@ struct bpf_kfunc_btf_tab {
 	u32 nr_descs;
 };
 
+static unsigned long kfunc_call_imm(unsigned long func_addr, u32 func_id);
+
+static void specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc);
+
 static int kfunc_desc_cmp_by_id_off(const void *a, const void *b)
 {
 	const struct bpf_kfunc_desc *d0 = a;
@@ -3143,7 +3145,7 @@ static int kfunc_btf_cmp_by_off(const void *a, const void *b)
 	return d0->offset - d1->offset;
 }
 
-static const struct bpf_kfunc_desc *
+static struct bpf_kfunc_desc *
 find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset)
 {
 	struct bpf_kfunc_desc desc = {
@@ -3266,6 +3268,7 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 {
 	const struct btf_type *func, *func_proto;
 	struct bpf_kfunc_btf_tab *btf_tab;
+	struct btf_func_model func_model;
 	struct bpf_kfunc_desc_tab *tab;
 	struct bpf_prog_aux *prog_aux;
 	struct bpf_kfunc_desc *desc;
@@ -3355,19 +3358,6 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
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
@@ -3375,18 +3365,29 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
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
 	desc->imm = call_imm;
 	desc->offset = offset;
 	desc->addr = addr;
-	err = btf_distill_func_proto(&env->log, desc_btf,
-				     func_proto, func_name,
-				     &desc->func_model);
-	if (!err)
-		sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
-		     kfunc_desc_cmp_by_id_off, NULL);
-	return err;
+	desc->func_model = func_model;
+	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
+	     kfunc_desc_cmp_by_id_off, NULL);
+	return 0;
 }
 
 static int kfunc_desc_cmp_by_imm_off(const void *a, const void *b)
@@ -21860,47 +21861,57 @@ static int fixup_call_args(struct bpf_verifier_env *env)
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
 	struct bpf_prog *prog = env->prog;
 	bool seen_direct_write;
 	void *xdp_kfunc;
 	bool is_rdonly;
+	u32 func_id = desc->func_id;
+	u16 offset = desc->offset;
+	unsigned long addr = 0;
+
+	if (offset) /* return if module BTF is used */
+		return;
 
 	if (bpf_dev_bound_kfunc_id(func_id)) {
 		xdp_kfunc = bpf_dev_bound_resolve_kfunc(prog, func_id);
-		if (xdp_kfunc) {
-			*addr = (unsigned long)xdp_kfunc;
-			return;
-		}
+		if (xdp_kfunc)
+			addr = (unsigned long)xdp_kfunc;
 		/* fallback to default kfunc when not supported by netdev */
-	}
-
-	if (offset)
-		return;
-
-	if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
+	} else if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
 		seen_direct_write = env->seen_direct_write;
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
+	desc->imm = kfunc_call_imm(addr, func_id);
+	desc->addr = addr;
 }
 
 static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
@@ -21923,7 +21934,7 @@ static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
 static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    struct bpf_insn *insn_buf, int insn_idx, int *cnt)
 {
-	const struct bpf_kfunc_desc *desc;
+	struct bpf_kfunc_desc *desc;
 
 	if (!insn->imm) {
 		verbose(env, "invalid kernel function call not eliminated in verifier pass\n");
@@ -21943,6 +21954,8 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EFAULT;
 	}
 
+	specialize_kfunc(env, desc);
+
 	if (!bpf_jit_supports_far_kfunc_call())
 		insn->imm = BPF_CALL_IMM(desc->addr);
 	if (insn->off)
-- 
2.51.0


