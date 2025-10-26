Return-Path: <bpf+bounces-72283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A8BC0B380
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 21:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04DA93B6C06
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 20:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3137F26A0B9;
	Sun, 26 Oct 2025 20:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1EdqMfZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03352F618B
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 20:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761511159; cv=none; b=fQkePrQgllEN6vs+lgrxVYTC1qM5CCcic0lKGAzFn1gwxLVE3W+h+kZRAdtPO8UdAqOKpQReM3T5Y97rQrLsYOKoXECox97/M9+c8WOa4UOp6PhuCNOuIsgDeDDNpQTO6GzsCazuGBk4aHnjcX124kLNInLBQIQDoFMArbJM/Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761511159; c=relaxed/simple;
	bh=+JimTawBLCbsO2I6hTPmcmgW1qS1wdBkmXIEldnEi5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPmo8HtTeevJP4mTHD1HOMiBL0fCOx2RHKFPt97y8HH/KG21eVrvsy8uvGRWeqsShNzoZW8xIpSW9rtvt7VUqjoMjPvtsmojuUEUm7M/3oM8GIKy39WfbgiZVNdI2h3fSQs/NUZfH8JAwn4rG6AZblMwg458goWjS4KEVjbAXHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1EdqMfZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so22730125e9.0
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 13:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761511156; x=1762115956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFVVVTNP5ViaTTQsudsxSa7pRh4a4vlpGKVgAJyYTUI=;
        b=M1EdqMfZ9VY+TjKYoVJCZsageT1GYWPaRYMA1ttvM63UkCuHkySNUQO6XJF9eRuOrL
         83QaR5p0kyf7W4cKXyl1g4GD6Pl9TBatvxzIAImTBXvrcawpgi87ILU6/bOlG0BlAKYR
         FJZy++mgX9sGlOsxsrI9KRzz1FUxmrGzfhAEGULfhP2vwlL61UY/2kpwrO3XZQUaujlC
         pltVcNmAYxHeL8RUQJgqWdQFYHJGd6HN5QJKB9L/TlQIIROcONPuIHJ4cypLhyQvUE54
         Jq9ccxotao6jpvlAJQsipg/t0ZGq7r8R2bhZdA5v8V14AZmH72e5PFJ2QD6bzIlXVD5V
         v6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761511156; x=1762115956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFVVVTNP5ViaTTQsudsxSa7pRh4a4vlpGKVgAJyYTUI=;
        b=T16E+7VoKrj+spxUa8x1scMn0zeppivs9U0ZixcVO2TWKcG+QatWPqNRyjnxfjOwGn
         VSvitU8vEQkYIw1R7CdsVW5MCz5cIvEyrnsqclefV2k/H1PJb5YE/8upFUP6tqjRpfT8
         8txhcD9Kmq0Gfjs/WFsQf2oQKuvtTHDlk0qZxPtTnvZTHnOSl1j830hSPNuqujTfJwKJ
         XPkH76ZEaY0uLfTcm5sb7wN2g9wkH1KFzxjV4IrRtHbgSCI5srFEk2frIY6+iPQg/Gx5
         3G7w+kz7cEh8IJwodVvu90k4T/z6y5296j+9CUpVJ7A4+PTmZRL0/pvgNDXbj3tqiZSI
         EEig==
X-Gm-Message-State: AOJu0YzVnXsb95ThHkehjw3/u1+bVrRUXq9mbINRvOYqTSh8j78TPktF
	Cok7ZxnzqsThGVn4VhvTgmCP2LC8MpLFpQc97lBKcpCU2kJMKPFLqKLlGoE+WA==
X-Gm-Gg: ASbGncuuuqOl4ibhP86+6AP71tkNmKCDwIKFapYKC4QcyiGCtnZXWMIfmojrQs5EdvN
	BgBE0zr3uLgeu0mubDQI2W+Ea48TNGs1S4xIvbporK/Myyysp5KnvamFD65APTcjU1wbTmXEhmo
	8agqKM/pjLFsqf8hGVU79eNUsByMmGcX4DFso/60JhDtQGg0id8z5Mxvaeq1k6E7qNF4z6B9uhQ
	WUE9+OxkXi+y5jUDImrU/Tw6LfBx7hkh1Q5g9/lGNNxAVh4w8TtbDocBz+E5igAT+0yoBCVpsC6
	u1+yay9mhJW4cUnYzTzTz4v6oT2syiEokjm+7fZ1RC4YZJxh6FcIByU87k8r0eMpQT+foqq95Uv
	ftM9DGKtBuurS6pTKiMoc8Z4H0lTR+dMmwsWoGdDjq39+nIzzJu+VtTUIH+c=
X-Google-Smtp-Source: AGHT+IF6aw2zku85WhmX3ei7iim1HKvJfBZsJCd6IUvyFm1q5jZ4DazF9rsS5hR/QTrqHAnzNXXDLQ==
X-Received: by 2002:a05:600c:5296:b0:471:1774:3003 with SMTP id 5b1f17b1804b1-475cb044f10mr114107205e9.29.1761511156038;
        Sun, 26 Oct 2025 13:39:16 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:4ccd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4924a4sm96621125e9.7.2025.10.26.13.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 13:39:15 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 08/10] bpf: verifier: refactor kfunc specialization
Date: Sun, 26 Oct 2025 20:38:51 +0000
Message-ID: <20251026203853.135105-9-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251026203853.135105-1-mykyta.yatsenko5@gmail.com>
References: <20251026203853.135105-1-mykyta.yatsenko5@gmail.com>
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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 97 +++++++++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 46 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cd48ead852a0..61589be91c65 100644
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
@@ -3126,6 +3124,8 @@ struct bpf_kfunc_btf_tab {
 	u32 nr_descs;
 };
 
+static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc);
+
 static int kfunc_desc_cmp_by_id_off(const void *a, const void *b)
 {
 	const struct bpf_kfunc_desc *d0 = a;
@@ -3143,7 +3143,7 @@ static int kfunc_btf_cmp_by_off(const void *a, const void *b)
 	return d0->offset - d1->offset;
 }
 
-static const struct bpf_kfunc_desc *
+static struct bpf_kfunc_desc *
 find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset)
 {
 	struct bpf_kfunc_desc desc = {
@@ -3266,12 +3266,12 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
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
 
@@ -3355,19 +3355,6 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
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
@@ -3375,18 +3362,20 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
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
@@ -21880,46 +21869,57 @@ static int fixup_call_args(struct bpf_verifier_env *env)
 }
 
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
 	}
 
-	if (func_id == special_kfunc_list[KF_bpf_set_dentry_xattr] &&
-	    bpf_lsm_has_d_inode_locked(prog))
-		*addr = (unsigned long)bpf_set_dentry_xattr_locked;
-
-	if (func_id == special_kfunc_list[KF_bpf_remove_dentry_xattr] &&
-	    bpf_lsm_has_d_inode_locked(prog))
-		*addr = (unsigned long)bpf_remove_dentry_xattr_locked;
+set_imm:
+	if (bpf_jit_supports_far_kfunc_call()) {
+		call_imm = func_id;
+	} else {
+		call_imm = BPF_CALL_IMM(addr);
+		/* Check whether the relative offset overflows desc->imm */
+		if ((unsigned long)(s32)call_imm != call_imm) {
+			verbose(env, "address of kernel func_id %u is out of range\n", func_id);
+			return -EINVAL;
+		}
+	}
+	desc->imm = call_imm;
+	desc->addr = addr;
+	return 0;
 }
 
 static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
@@ -21942,7 +21942,8 @@ static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
 static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    struct bpf_insn *insn_buf, int insn_idx, int *cnt)
 {
-	const struct bpf_kfunc_desc *desc;
+	struct bpf_kfunc_desc *desc;
+	int err;
 
 	if (!insn->imm) {
 		verbose(env, "invalid kernel function call not eliminated in verifier pass\n");
@@ -21962,6 +21963,10 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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


