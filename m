Return-Path: <bpf+bounces-71472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D02DBF3E48
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 00:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC313B1FCD
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 22:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DF62F25F8;
	Mon, 20 Oct 2025 22:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kf+wMo0e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523272F12B1
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 22:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999159; cv=none; b=JOPXtc+3z22QHjfWsGPHaX1ipfZvMn8I3mIxw0zgmQGE5N6W3xRRRWb943lRv03LKRTwuB/I3wRUKyxvw7JgZTqCDB4wrhXgoKrctmuzGYdA26GbVC29xJU4FrCeqaI0icbikBy/d8fvnYPXXEuJPIQOOMWNhMYu1ppdZn7zaYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999159; c=relaxed/simple;
	bh=80g19Ko0Q8imrqmmnhj1sgAgMh1jnOURyaavC91bDBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FXr6bj8460T9vB/fxUzPBewT2sXy5KmJGBTTw9qZW8hOOi9+9m0Nhmrmvwy7qZzEC7tABCisFjmwwMkOC79cmkpq+V2Hfi+MlgPM2YYlYThuzEt7PEfeZUBoRziLmRrX3L2t9cpub4VhhKnKDuhNtXGmghjVnNGK7/RW7Vfsu/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kf+wMo0e; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-471075c0a18so51108025e9.1
        for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 15:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760999155; x=1761603955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlOcK+G0KVh9gdQNB2Ix+dJEopvlEQ5ivobm4K6VJ8A=;
        b=Kf+wMo0eO6AH7q+lKEvG8XQxfzMdL3V3Tp/WuExutvAR1T/1M+qZmPbWxkeDBATmA6
         yfEkpZ8SunYd9bnpXLWwF13pxd2es8kQxiOi85KoKxD9Zj6PBm0zEeH2aHyqE3n3+26T
         08USZAmX9jj9aFmQgyY9LascZeUiyFxQsapRgKHhxi8BoZUyL9588Tc1UHbG3cRjLKDU
         54hMYvxUEHQKzLO+oUriZBQntqF8VNmtzUmPMMgbW4XoRciFbrvkxld5p338Lm21GsPC
         oj42+T018q9k1ebtfkVye1VkEE7c2MIYSQ6eUFNXnegoqZZ8hNMCHUjnBkhwxAV2F0ns
         qtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999155; x=1761603955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlOcK+G0KVh9gdQNB2Ix+dJEopvlEQ5ivobm4K6VJ8A=;
        b=bKF66wdXz1bCPZh6lyU79zRPMvvFddbQ+EIfSGghpzKzZTuPSrVCZAtWas4B6zAitg
         SCJTpvHc5OCwQx+vcxvk9Dx4nMhOy14kT6u+4ll6jA3s1JzZzK6k3OKdUdun1C4Fxqhu
         njalDLt329pKtldnSH56muV+yActlHKW7FlG+VyXu3lxXYbYmM1BN7zyDTdjVqv9MHYp
         dHyy9Ak1GOpYzvpOSaj2aN1ivdzSa9/BoJLUzf3NPbEkYMv9NwfIASuba65FzGW3BFPb
         BQ5jzd+dLifawAghuP93YCTDLcw22o7SqAOuEu7LeIoIZWic0G0vwNHU19w+rO7JFbG3
         exhg==
X-Gm-Message-State: AOJu0YxtIKwgu8hi0s6waS+tC8p39CmB0pwjqex3P88NgRRuvzM1KmXC
	mKAfc0uQdULccL88UDMcpMXWYNxfcficFU8Q9y1opn1V+khnnQx+mNlm4HFW7A==
X-Gm-Gg: ASbGncttojTmXmuOSiVZ17vmoFmv2faP2voyhPcTJGsZSq7KPZ0P4c5L1abqYfVbmz4
	Th92u2FCUINq5Y6QFilRlbvfs2nf9LIinLntxRQZNzuDAmcZYhWRJsSSCPui6MiKllanRulY9PK
	Hc7OKMAMXFAw0SIhOcN36gJY2xcXdOkftpvdpuRrW/XXaBgFUoZEEaUV3i2c+8x/9hvGinuw/iN
	z9OFommCLsAHSCSSEL/2mJV3lU/Q+4LVAFLMAA3f1xx3uLd2AnMb2wPn8pzGr71Qa0FNakt/OLl
	V0THUDXlodbcP1r2lVAStakpRtB4eoCopAJ2xFcrcRf3bzdLdL4lIbvul/w2eAzO9Sok9DWPTkU
	a33lzh8TOywlacy2wsrEyPhCnC2rxPvXBAFpQufzselymc5AnQarShzNJFe0=
X-Google-Smtp-Source: AGHT+IE4WeXhsky+jhICNwkq06BH1yga9ZKf0OU+KbnClnDodaB5ZqsioX7uow8vUcql+bhJay2WmA==
X-Received: by 2002:a05:6000:4011:b0:425:855c:5879 with SMTP id ffacd0b85a97d-42704d6c536mr10027644f8f.15.1760999155502;
        Mon, 20 Oct 2025 15:25:55 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:2617])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0f88sm16610391f8f.7.2025.10.20.15.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:25:54 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 08/10] bpf: verifier: refactor kfunc specialization
Date: Mon, 20 Oct 2025 23:25:36 +0100
Message-ID: <20251020222538.932915-9-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020222538.932915-1-mykyta.yatsenko5@gmail.com>
References: <20251020222538.932915-1-mykyta.yatsenko5@gmail.com>
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
 kernel/bpf/verifier.c | 117 ++++++++++++++++++++++++++----------------
 1 file changed, 73 insertions(+), 44 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4c8fd298b99a..64575f19d185 100644
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
@@ -3126,6 +3124,11 @@ struct bpf_kfunc_btf_tab {
 	u32 nr_descs;
 };
 
+static int kfunc_call_imm(struct bpf_verifier_env *env, unsigned long func_addr, u32 func_id,
+			  s32 *imm);
+
+static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc);
+
 static int kfunc_desc_cmp_by_id_off(const void *a, const void *b)
 {
 	const struct bpf_kfunc_desc *d0 = a;
@@ -3143,7 +3146,7 @@ static int kfunc_btf_cmp_by_off(const void *a, const void *b)
 	return d0->offset - d1->offset;
 }
 
-static const struct bpf_kfunc_desc *
+static struct bpf_kfunc_desc *
 find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset)
 {
 	struct bpf_kfunc_desc desc = {
@@ -3266,12 +3269,13 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
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
+	s32 call_imm;
 	unsigned long addr;
 	int err;
 
@@ -3355,19 +3359,6 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
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
@@ -3375,18 +3366,25 @@ static int add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, s16 offset)
 			return err;
 	}
 
+	err = btf_distill_func_proto(&env->log, desc_btf,
+				     func_proto, func_name,
+				     &func_model);
+	if (err)
+		return err;
+
+	err = kfunc_call_imm(env, addr, func_id, &call_imm);
+	if (err)
+		return err;
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
@@ -21861,47 +21859,73 @@ static int fixup_call_args(struct bpf_verifier_env *env)
 	return err;
 }
 
+static int kfunc_call_imm(struct bpf_verifier_env *env, unsigned long func_addr, u32 func_id,
+			  s32 *imm)
+{
+	unsigned long call_imm;
+
+	if (bpf_jit_supports_far_kfunc_call()) {
+		*imm = func_id;
+		return 0;
+	}
+
+	call_imm = BPF_CALL_IMM(func_addr);
+	/* Check whether the relative offset overflows desc->imm */
+	if ((unsigned long)(s32)call_imm != call_imm) {
+		verbose(env, "address of kernel func_id %u is out of range\n", func_id);
+		return -EINVAL;
+	}
+	*imm = call_imm;
+	return 0;
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
+	unsigned long addr = 0;
+	int err;
+
+	if (offset) /* return if module BTF is used */
+		return 0;
 
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
+		return 0;
 
-	if (func_id == special_kfunc_list[KF_bpf_remove_dentry_xattr] &&
-	    bpf_lsm_has_d_inode_locked(prog))
-		*addr = (unsigned long)bpf_remove_dentry_xattr_locked;
+	err = kfunc_call_imm(env, addr, func_id, &desc->imm);
+	if (err)
+		return err;
+	desc->addr = addr;
+	return 0;
 }
 
 static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
@@ -21924,7 +21948,8 @@ static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
 static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			    struct bpf_insn *insn_buf, int insn_idx, int *cnt)
 {
-	const struct bpf_kfunc_desc *desc;
+	struct bpf_kfunc_desc *desc;
+	int err;
 
 	if (!insn->imm) {
 		verbose(env, "invalid kernel function call not eliminated in verifier pass\n");
@@ -21944,6 +21969,10 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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


