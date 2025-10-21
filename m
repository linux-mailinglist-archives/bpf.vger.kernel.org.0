Return-Path: <bpf+bounces-71631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C432ABF8827
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 22:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D79644FAF9E
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 20:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B7D27A46A;
	Tue, 21 Oct 2025 20:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/89Edxp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F9A1A00CE
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 20:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761077035; cv=none; b=E9YBDrtJ13jWof5FfeduZacE89q15qmjWIKZP4w28kaUYcFedb9tYntSqbVeQ4f0LTvcO3sBSbtw/Mdhc3gGIOyUR+b/YRuzObhqYE5PvcfeGwDKBRpdg3sgIVASTC/Y69LGPI0kaL1YPQs3EIkcSlx4Ez7ms7w9eVy2586iNN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761077035; c=relaxed/simple;
	bh=fVBjKMrnSgNJHeuzxX+CzYCAtsK3aBDU46/hnfD2AiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FiRUclcKZWTFkhFT4KQQkRoQAbiPfd6Wfr/Xf+tnRHq7ohan3+3elB1QjShSNQVCsmqhXX7ILtWE1rsBgSgCQxkz26dLQy9/GH/2n7IkwCVp+EHRjZcu42Tb1A3ZsPCNZv1Pv8YrrtdMruFUsWli1Z+Rw/Cep9TU1ErK58m3Zsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/89Edxp; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so3615126f8f.0
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 13:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761077032; x=1761681832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MIEGma5+HtHs3EDinCvM7l1YW2w77kL23c6VEg6nWw=;
        b=d/89EdxpWNRuKefzVa+zCR8CrYO3lyQNEUZLwG/gkXoRM9c7OGjbBrKei4ddWVTybe
         pcDe9iYA8qvjdEkRvzlgwsqOVo7/h6nSWWn5niRQZvvzE90FN89Mm+LCJm5v/ohG5PtN
         XKWyeg0AdzsUKG4Xbsvy2WV734I6zeyVmYwelWBOs0rjLLge0LYXhwuJvcWl5MpM5JJ/
         hplsv4r/EW7yr7ptvy1qY7OsS/tEeJA/FFTQMQeCzV1ExI6pZ5FiWnwV6XDE94vzc/dG
         Ve4NsN4cE7vC0fjU1diEL3RdvgxoUN5NuelhKBLXJhGhO4KIh4rPqbPxB0u5rP4e6isD
         T/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761077032; x=1761681832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MIEGma5+HtHs3EDinCvM7l1YW2w77kL23c6VEg6nWw=;
        b=qVCbJMR0CF5hs3uupSncUZSKtDlxtRYHsMoO10mtst7xfR7DxM6gSLxs1G9e6qpTUu
         z+a8Fsm6P+owNfGs4tK0h9wKX4ZhrdnqJ8WbiCriqX2HFrCJk3WxeFHRotAYT0g50X9r
         gfdp2GMa1tDLykzh/wS3lg9GpJuOYJBYfdu0D6/QJVQqEZEoNMwo/8pq174evmeLf1Wl
         WMSB11jcb2g1ckdsJ07UupH6pdDHTEKOYZvsshiu8JxRCCi7xmefLSdBmL9IRkv1MUzb
         RiNakturgmxrnTiOcBxiH+/TatfYOMup3yuujWm5K7Ie0JglH5zoTAF2S/rKQ15lr77H
         9OiA==
X-Gm-Message-State: AOJu0Yz6pBoTWY9M/TRKQvDMhIFgxNlh9T7gdPY0zkb4ncWo0ToK98sa
	MbjdsvqDiOp7KaqWDeVeGB0wVbVmomXeAHAVC8eehRtpJJmSICGVJeXUelXIeQ==
X-Gm-Gg: ASbGncum++R/fwaXJwuTuPwJ/Sx1On2Ysx5b4DAlsWVExoBaDAmOa6hx3jt8D7AdqR0
	q4CLeEZxwLwxCGq154INTUXMtKFRUeV+jBqArexHd4d67q8oOR+69TdXQQ+rJ4C3P5xcA+Du/UY
	Kj8r6jpl5GUzcglmnKHuxUFHIWtdAa7yhJ4EVlfC6CvY9efPvFk+3kim7U2Lwy5NrBJxae2gLGO
	R0SbTXf1Lfadu5RNL0NQvVPvNA7R90+uZDvd6gjKiDHad8MRVEEFXtOKzl6E6CT77Ex9zU1Gghr
	ETG78HE19IwGooGNi/0kYBv47TDRLN7+yQN36DVWHQ3TGwEM3NeHVcFo8nDfAKoPbxaI/MPhbxm
	jVhjPKl69+a94ASApfMcRLZan9djO70gWzP+CkqwZj0KBFchr0A3mbcb/xSGR
X-Google-Smtp-Source: AGHT+IEYZ1kkBwYh0Hyn7V/WHuynR9eBRSvZMqNjGV2qZG1lPf2Fg67BbJyXSgUbxEZ8BG8c4ljLrg==
X-Received: by 2002:a5d:64c2:0:b0:427:80a:6bdb with SMTP id ffacd0b85a97d-427080a6be4mr10532071f8f.46.1761077031605;
        Tue, 21 Oct 2025 13:03:51 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:c0ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a993sm21846520f8f.24.2025.10.21.13.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:03:51 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 08/10] bpf: verifier: refactor kfunc specialization
Date: Tue, 21 Oct 2025 21:03:32 +0100
Message-ID: <20251021200334.220542-9-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021200334.220542-1-mykyta.yatsenko5@gmail.com>
References: <20251021200334.220542-1-mykyta.yatsenko5@gmail.com>
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
 kernel/bpf/verifier.c | 105 +++++++++++++++++++++++-------------------
 1 file changed, 58 insertions(+), 47 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4c8fd298b99a..ea20ab1b00d8 100644
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
+static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc);
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
@@ -3266,12 +3268,12 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 {
 	const struct btf_type *func, *func_proto;
 	struct bpf_kfunc_btf_tab *btf_tab;
+	struct btf_func_model func_model;
 	struct bpf_kfunc_desc_tab *tab;
 	struct bpf_prog_aux *prog_aux;
 	struct bpf_kfunc_desc *desc;
 	const char *func_name;
 	struct btf *desc_btf;
-	unsigned long call_imm;
 	unsigned long addr;
 	int err;
 
@@ -3355,19 +3357,6 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
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
@@ -3375,18 +3364,20 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 			return err;
 	}
 
+	err = btf_distill_func_proto(&env->log, desc_btf,
+				     func_proto, func_name,
+				     &func_model);
+	if (err)
+		return err;
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
+	desc->func_model = func_model;
+	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
+	     kfunc_desc_cmp_by_id_off, NULL);
+	return 0;
 }
 
 static int kfunc_desc_cmp_by_imm_off(const void *a, const void *b)
@@ -21861,47 +21852,62 @@ static int fixup_call_args(struct bpf_verifier_env *env)
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
+static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc)
 {
 	struct bpf_prog *prog = env->prog;
 	bool seen_direct_write;
 	void *xdp_kfunc;
 	bool is_rdonly;
+	u32 func_id = desc->func_id;
+	u16 offset = desc->offset;
+	unsigned long addr = desc->addr, call_imm;
+
+	if (offset) /* return if module BTF is used */
+		goto set_imm;
 
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
+	}
+
+set_imm:
+	call_imm = kfunc_call_imm(addr, func_id);
+	/* Check whether the relative offset overflows desc->imm */
+	if ((unsigned long)(s32)call_imm != call_imm) {
+		verbose(env, "address of kernel func_id %u is out of range\n", func_id);
+		return -EINVAL;
 	}
-
-	if (func_id == special_kfunc_list[KF_bpf_set_dentry_xattr] &&
-	    bpf_lsm_has_d_inode_locked(prog))
-		*addr = (unsigned long)bpf_set_dentry_xattr_locked;
-
-	if (func_id == special_kfunc_list[KF_bpf_remove_dentry_xattr] &&
-	    bpf_lsm_has_d_inode_locked(prog))
-		*addr = (unsigned long)bpf_remove_dentry_xattr_locked;
+	desc->imm = call_imm;
+	desc->addr = addr;
+	return 0;
 }
 
 static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
@@ -21924,7 +21930,8 @@ static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
 static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    struct bpf_insn *insn_buf, int insn_idx, int *cnt)
 {
-	const struct bpf_kfunc_desc *desc;
+	struct bpf_kfunc_desc *desc;
+	int err;
 
 	if (!insn->imm) {
 		verbose(env, "invalid kernel function call not eliminated in verifier pass\n");
@@ -21944,6 +21951,10 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EFAULT;
 	}
 
+	err = specialize_kfunc(env, desc);
+	if (err)
+		return err;
+
 	if (!bpf_jit_supports_far_kfunc_call())
 		insn->imm = BPF_CALL_IMM(desc->addr);
 	if (insn->off)
-- 
2.51.0


