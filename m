Return-Path: <bpf+bounces-46918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8279F18FA
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423C7164BE4
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE601EBFE8;
	Fri, 13 Dec 2024 22:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4dwhnbw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E4C185949
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 22:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128380; cv=none; b=sjn8vBSrqyC7E7hYEs6Hq7rXtH0sCuCAA9Ve+Nn+C/YxlagfvGrtaPveX2zr2WXYKH0heb0UTNz4uV3nTcsG+/9hGi7RwB3qviDodqr2Jc6JRvXhT48VVcxBMklJV+/zjpR+paRzJVHkrMhiQL+0iRhZ7aG1cTNAoTYP05wShKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128380; c=relaxed/simple;
	bh=KEv755sEVd85j34CZrVOcnTJNLkMRBeR4Nr/xGtMmT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REcsUAlgTJE3RD1eVTf6P4la/EBEfOdEoFGhw6/LW3idLAHTWmjuzYK83UHOBfyP+h5PrdNuQNdj6RvOwNeOhncCQ+B0OzAZ1XT6xioaE9cqMJwuW7jVlXinNa2Wq35yGPycjWBZyXq9CeL5OPX60HEBAXMukPMJPjhytRTOHs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4dwhnbw; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-385df53e559so1812242f8f.3
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 14:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734128376; x=1734733176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spCXdJpgRnBemD1PVbI6UIUIfhJ5rtRztRc8Zw0sToo=;
        b=h4dwhnbwPH41Tq9lOB5C+7atwgXRgzNABRvGYKTujegHc0Zx66UDuAKWKLeTC6bRIG
         OOSvKcHgXzUSelZmec+RWBoAsR46mKbyHzHOQa0Q5Mt8lWAsJNqj/cW+N01UVBJZtRnk
         C23AeuHf+6GmVseV88ukw0NvT9zq3UyCGfqozl1gtrKBjDblfBEUUOltou8HkyUlYKcv
         2MUVu3c9a0+AMP37HSspEorg7mmX1LbGOh2ianWXFZcXvN0VRW9KU274ncIwWaTBPvoG
         UGkV88RZ37Avj+MhL0n8IhYxlt2Q8CNcfW5LFwClvxFk6EWrBWt+vG/k19BsXxm0xaPn
         jZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128376; x=1734733176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spCXdJpgRnBemD1PVbI6UIUIfhJ5rtRztRc8Zw0sToo=;
        b=SV0/NuFc/BlhSC/FtI6agwgGvVzEKRtLCJjo9ru613Yqy6/H0dH1oZcFIVBH4IJaXo
         39qG51dAdGiQj51OiuxWXfJOKtPtSgqe0KCVkTH/BOAfjkwVwhqj3DQhXTGawfitAazy
         TuOSUuntOGNHRjsgjiFeN1xuTWoLsB1YHrYJPmiO6q0ELhR3zb9Be3m8frNE1R6bSPuW
         gaoczmF900xDxFVeXerdY3jxxDt0MfVANWCjG0vato6/KMd15PKJyIV+RcEL6W6aO2gp
         j4WjMZlhTawFI2RSE9BL2oPeO51fc3prlbTy+3TTd9H2WKmc0Vp49ELhXrDqX1jg5UYI
         0fkg==
X-Gm-Message-State: AOJu0YypnGH7pwvlF19HBtOSqR7S00MbqxphIZgRM9A2WdzADED60myE
	BK08GtjLNduqOWL2ZhEhHcEyJup4tYDaBaGDNEmBBaU1C1kDTlwXXRWb9erohVUfGA==
X-Gm-Gg: ASbGncv4nY1zVP/ykTa4yH2W9EdA9cQXMwjYLGiuXFzTIZlCqjwkzFyiO3ZJw/HQpIM
	xPQ4OTUi4NFxXz1nt0fDzevvp8MxBmEZ3JiA/DquK4B5mafjXjw2wf3znaxehFhyGKCxs5iBf1v
	xCjiVFxWqMGkzOgtshSZOpHlel4r+jGuLu0RGewJ5xsC4WFsReN92PXP+Y7rdMqWJUDbquU3csE
	KZ848NlymS4k3UvqeLvlYb/Cz4r49gbv+etkP3mLKwx+eCVu1qZGpBvsHmzt6Fo10SJe2meud1E
	zjfn
X-Google-Smtp-Source: AGHT+IHty1oSxL3qSZllaGoL0SGowqGfkBo4X3+lTrCY0nd/iHPBogcDbKopZ2vKPV/hi/9DYdINIQ==
X-Received: by 2002:a05:6000:144a:b0:385:f996:1bb9 with SMTP id ffacd0b85a97d-3888e0ae56dmr2978801f8f.23.1734128376137;
        Fri, 13 Dec 2024 14:19:36 -0800 (PST)
Received: from localhost (fwdproxy-cln-000.fbsv.net. [2a03:2880:31ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4363602cc19sm5922425e9.13.2024.12.13.14.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:19:34 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Manu Bretelle <chantra@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	kernel-team@fb.com
Subject: [PATCH bpf v3 1/3] bpf: Revert "bpf: Mark raw_tp arguments with PTR_MAYBE_NULL"
Date: Fri, 13 Dec 2024 14:19:27 -0800
Message-ID: <20241213221929.3495062-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241213221929.3495062-1-memxor@gmail.com>
References: <20241213221929.3495062-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12835; h=from:subject; bh=KEv755sEVd85j34CZrVOcnTJNLkMRBeR4Nr/xGtMmT4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnXK5lAac1/avgRyK3awTQWkJz/sZWTVpTL79hP84K y8a2oYeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ1yuZQAKCRBM4MiGSL8Ryn1JD/ 9ddQKSiLry/HBAbhqKhaE3uMMk8sp62Xno6p2exM2wB78TGlwczTBr9UNmD0hzed+WwHcpBUHfnaok zCKBrjMf9aAO76SynpEAkpUxQ5wxwyWr5LX9hYn6ME6K+RiUFrcLuMCyD4Vuffz9ffKBjhA7gYqtvQ DRe7nIEgOGWIWDXy7TnIX7KEXSMlEiO0lym3KtvSSPmdkDSafukVSnL2zM9yEWj7RE1dpVWXmjoYdv R7sia2gXeI8bKCCGs0rCDXUABPFA8NWsel8xlOczK6L6Ety4bVkctpF2a2r9VNbjhiDPS/YWOPC5X4 QeBsOlBuL3OwLD42Bi+QLZy7KV+crbVb60eMCJMUvqvcj0BtEBMoUyfcDchq9KGMwMTUne8RmOssaa iIJfEE0oI4gU7mH08Z6Jh7rT7TskRUqefM+KdXru9zhOXXINvTs9k6kwT4qcaKFZpUH+rCxEmd2R48 Vtz1GvM9J3M/I8HlbCgs2rC4vyqBQ9f1QnGnbA5AzU0KA0O1D0oaHwOltcGE3dUWYosfYhj81t2qJx WjSA9neSPiqRx+EydElxu5yrsHc4xSs9TOHbYI/hUVvDQVFNYWlrAQApDZA2GCX7f2AZfBcF9pGLs5 lpr+9RIRG3FOR/uvOpwX/KHOc/WmFiz1+HNI4RE/xaZ//UsDEhLbgOfmThiA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This patch reverts commit
cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL"). The
patch was well-intended and meant to be as a stop-gap fixing branch
prediction when the pointer may actually be NULL at runtime. Eventually,
it was supposed to be replaced by an automated script or compiler pass
detecting possibly NULL arguments and marking them accordingly.

However, it caused two main issues observed for production programs and
failed to preserve backwards compatibility. First, programs relied on
the verifier not exploring == NULL branch when pointer is not NULL, thus
they started failing with a 'dereference of scalar' error.  Next,
allowing raw_tp arguments to be modified surfaced the warning in the
verifier that warns against reg->off when PTR_MAYBE_NULL is set.

More information, context, and discusson on both problems is available
in [0]. Overall, this approach had several shortcomings, and the fixes
would further complicate the verifier's logic, and the entire masking
scheme would have to be removed eventually anyway.

Hence, revert the patch in preparation of a better fix avoiding these
issues to replace this commit.

  [0]: https://lore.kernel.org/bpf/20241206161053.809580-1-memxor@gmail.com

Reported-by: Manu Bretelle <chantra@meta.com>
Fixes: cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h                           |  6 --
 kernel/bpf/btf.c                              |  5 +-
 kernel/bpf/verifier.c                         | 79 ++-----------------
 .../bpf/progs/test_tp_btf_nullable.c          |  6 +-
 4 files changed, 9 insertions(+), 87 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 805040813f5d..6e63dd3443b9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3514,10 +3514,4 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 	return prog->aux->func_idx != 0;
 }
 
-static inline bool bpf_prog_is_raw_tp(const struct bpf_prog *prog)
-{
-	return prog->type == BPF_PROG_TYPE_TRACING &&
-	       prog->expected_attach_type == BPF_TRACE_RAW_TP;
-}
-
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a63a03582f02..c4aa304028ce 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6594,10 +6594,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	if (prog_args_trusted(prog))
 		info->reg_type |= PTR_TRUSTED;
 
-	/* Raw tracepoint arguments always get marked as maybe NULL */
-	if (bpf_prog_is_raw_tp(prog))
-		info->reg_type |= PTR_MAYBE_NULL;
-	else if (btf_param_match_suffix(btf, &args[arg], "__nullable"))
+	if (btf_param_match_suffix(btf, &args[arg], "__nullable"))
 		info->reg_type |= PTR_MAYBE_NULL;
 
 	if (tgt_prog) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5e541339b2f6..f7f892a52a37 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -420,25 +420,6 @@ static struct btf_record *reg_btf_record(const struct bpf_reg_state *reg)
 	return rec;
 }
 
-static bool mask_raw_tp_reg_cond(const struct bpf_verifier_env *env, struct bpf_reg_state *reg) {
-	return reg->type == (PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL) &&
-	       bpf_prog_is_raw_tp(env->prog) && !reg->ref_obj_id;
-}
-
-static bool mask_raw_tp_reg(const struct bpf_verifier_env *env, struct bpf_reg_state *reg)
-{
-	if (!mask_raw_tp_reg_cond(env, reg))
-		return false;
-	reg->type &= ~PTR_MAYBE_NULL;
-	return true;
-}
-
-static void unmask_raw_tp_reg(struct bpf_reg_state *reg, bool result)
-{
-	if (result)
-		reg->type |= PTR_MAYBE_NULL;
-}
-
 static bool subprog_is_global(const struct bpf_verifier_env *env, int subprog)
 {
 	struct bpf_func_info_aux *aux = env->prog->aux->func_info_aux;
@@ -6801,7 +6782,6 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	const char *field_name = NULL;
 	enum bpf_type_flag flag = 0;
 	u32 btf_id = 0;
-	bool mask;
 	int ret;
 
 	if (!env->allow_ptr_leaks) {
@@ -6873,21 +6853,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 
 	if (ret < 0)
 		return ret;
-	/* For raw_tp progs, we allow dereference of PTR_MAYBE_NULL
-	 * trusted PTR_TO_BTF_ID, these are the ones that are possibly
-	 * arguments to the raw_tp. Since internal checks in for trusted
-	 * reg in check_ptr_to_btf_access would consider PTR_MAYBE_NULL
-	 * modifier as problematic, mask it out temporarily for the
-	 * check. Don't apply this to pointers with ref_obj_id > 0, as
-	 * those won't be raw_tp args.
-	 *
-	 * We may end up applying this relaxation to other trusted
-	 * PTR_TO_BTF_ID with maybe null flag, since we cannot
-	 * distinguish PTR_MAYBE_NULL tagged for arguments vs normal
-	 * tagging, but that should expand allowed behavior, and not
-	 * cause regression for existing behavior.
-	 */
-	mask = mask_raw_tp_reg(env, reg);
+
 	if (ret != PTR_TO_BTF_ID) {
 		/* just mark; */
 
@@ -6948,13 +6914,8 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		clear_trusted_flags(&flag);
 	}
 
-	if (atype == BPF_READ && value_regno >= 0) {
+	if (atype == BPF_READ && value_regno >= 0)
 		mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
-		/* We've assigned a new type to regno, so don't undo masking. */
-		if (regno == value_regno)
-			mask = false;
-	}
-	unmask_raw_tp_reg(reg, mask);
 
 	return 0;
 }
@@ -7329,7 +7290,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 		if (!err && t == BPF_READ && value_regno >= 0)
 			mark_reg_unknown(env, regs, value_regno);
 	} else if (base_type(reg->type) == PTR_TO_BTF_ID &&
-		   (mask_raw_tp_reg_cond(env, reg) || !type_may_be_null(reg->type))) {
+		   !type_may_be_null(reg->type)) {
 		err = check_ptr_to_btf_access(env, regs, regno, off, size, t,
 					      value_regno);
 	} else if (reg->type == CONST_PTR_TO_MAP) {
@@ -9032,7 +8993,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	enum bpf_reg_type type = reg->type;
 	u32 *arg_btf_id = NULL;
 	int err = 0;
-	bool mask;
 
 	if (arg_type == ARG_DONTCARE)
 		return 0;
@@ -9073,11 +9033,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	    base_type(arg_type) == ARG_PTR_TO_SPIN_LOCK)
 		arg_btf_id = fn->arg_btf_id[arg];
 
-	mask = mask_raw_tp_reg(env, reg);
 	err = check_reg_type(env, regno, arg_type, arg_btf_id, meta);
+	if (err)
+		return err;
 
-	err = err ?: check_func_arg_reg_off(env, reg, regno, arg_type);
-	unmask_raw_tp_reg(reg, mask);
+	err = check_func_arg_reg_off(env, reg, regno, arg_type);
 	if (err)
 		return err;
 
@@ -9872,17 +9832,14 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 				return ret;
 		} else if (base_type(arg->arg_type) == ARG_PTR_TO_BTF_ID) {
 			struct bpf_call_arg_meta meta;
-			bool mask;
 			int err;
 
 			if (register_is_null(reg) && type_may_be_null(arg->arg_type))
 				continue;
 
 			memset(&meta, 0, sizeof(meta)); /* leave func_id as zero */
-			mask = mask_raw_tp_reg(env, reg);
 			err = check_reg_type(env, regno, arg->arg_type, &arg->btf_id, &meta);
 			err = err ?: check_func_arg_reg_off(env, reg, regno, arg->arg_type);
-			unmask_raw_tp_reg(reg, mask);
 			if (err)
 				return err;
 		} else {
@@ -12205,7 +12162,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		enum bpf_arg_type arg_type = ARG_DONTCARE;
 		u32 regno = i + 1, ref_id, type_size;
 		bool is_ret_buf_sz = false;
-		bool mask = false;
 		int kf_arg_type;
 
 		t = btf_type_skip_modifiers(btf, args[i].type, NULL);
@@ -12264,15 +12220,12 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			return -EINVAL;
 		}
 
-		mask = mask_raw_tp_reg(env, reg);
 		if ((is_kfunc_trusted_args(meta) || is_kfunc_rcu(meta)) &&
 		    (register_is_null(reg) || type_may_be_null(reg->type)) &&
 			!is_kfunc_arg_nullable(meta->btf, &args[i])) {
 			verbose(env, "Possibly NULL pointer passed to trusted arg%d\n", i);
-			unmask_raw_tp_reg(reg, mask);
 			return -EACCES;
 		}
-		unmask_raw_tp_reg(reg, mask);
 
 		if (reg->ref_obj_id) {
 			if (is_kfunc_release(meta) && meta->ref_obj_id) {
@@ -12330,24 +12283,16 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu(meta))
 				break;
 
-			/* Allow passing maybe NULL raw_tp arguments to
-			 * kfuncs for compatibility. Don't apply this to
-			 * arguments with ref_obj_id > 0.
-			 */
-			mask = mask_raw_tp_reg(env, reg);
 			if (!is_trusted_reg(reg)) {
 				if (!is_kfunc_rcu(meta)) {
 					verbose(env, "R%d must be referenced or trusted\n", regno);
-					unmask_raw_tp_reg(reg, mask);
 					return -EINVAL;
 				}
 				if (!is_rcu_reg(reg)) {
 					verbose(env, "R%d must be a rcu pointer\n", regno);
-					unmask_raw_tp_reg(reg, mask);
 					return -EINVAL;
 				}
 			}
-			unmask_raw_tp_reg(reg, mask);
 			fallthrough;
 		case KF_ARG_PTR_TO_CTX:
 		case KF_ARG_PTR_TO_DYNPTR:
@@ -12370,9 +12315,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 
 		if (is_kfunc_release(meta) && reg->ref_obj_id)
 			arg_type |= OBJ_RELEASE;
-		mask = mask_raw_tp_reg(env, reg);
 		ret = check_func_arg_reg_off(env, reg, regno, arg_type);
-		unmask_raw_tp_reg(reg, mask);
 		if (ret < 0)
 			return ret;
 
@@ -12549,7 +12492,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			ref_tname = btf_name_by_offset(btf, ref_t->name_off);
 			fallthrough;
 		case KF_ARG_PTR_TO_BTF_ID:
-			mask = mask_raw_tp_reg(env, reg);
 			/* Only base_type is checked, further checks are done here */
 			if ((base_type(reg->type) != PTR_TO_BTF_ID ||
 			     (bpf_type_has_unsafe_modifiers(reg->type) && !is_rcu_reg(reg))) &&
@@ -12558,11 +12500,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				verbose(env, "expected %s or socket\n",
 					reg_type_str(env, base_type(reg->type) |
 							  (type_flag(reg->type) & BPF_REG_TRUSTED_MODIFIERS)));
-				unmask_raw_tp_reg(reg, mask);
 				return -EINVAL;
 			}
 			ret = process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname, ref_id, meta, i);
-			unmask_raw_tp_reg(reg, mask);
 			if (ret < 0)
 				return ret;
 			break;
@@ -13535,7 +13475,7 @@ static int sanitize_check_bounds(struct bpf_verifier_env *env,
  */
 static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 				   struct bpf_insn *insn,
-				   struct bpf_reg_state *ptr_reg,
+				   const struct bpf_reg_state *ptr_reg,
 				   const struct bpf_reg_state *off_reg)
 {
 	struct bpf_verifier_state *vstate = env->cur_state;
@@ -13549,7 +13489,6 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	struct bpf_sanitize_info info = {};
 	u8 opcode = BPF_OP(insn->code);
 	u32 dst = insn->dst_reg;
-	bool mask;
 	int ret;
 
 	dst_reg = &regs[dst];
@@ -13576,14 +13515,11 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	mask = mask_raw_tp_reg(env, ptr_reg);
 	if (ptr_reg->type & PTR_MAYBE_NULL) {
 		verbose(env, "R%d pointer arithmetic on %s prohibited, null-check it first\n",
 			dst, reg_type_str(env, ptr_reg->type));
-		unmask_raw_tp_reg(ptr_reg, mask);
 		return -EACCES;
 	}
-	unmask_raw_tp_reg(ptr_reg, mask);
 
 	switch (base_type(ptr_reg->type)) {
 	case PTR_TO_CTX:
@@ -20126,7 +20062,6 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 		 * for this case.
 		 */
 		case PTR_TO_BTF_ID | MEM_ALLOC | PTR_UNTRUSTED:
-		case PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL:
 			if (type == BPF_READ) {
 				if (BPF_MODE(insn->code) == BPF_MEM)
 					insn->code = BPF_LDX | BPF_PROBE_MEM |
diff --git a/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c b/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
index 5aaf2b065f86..bba3e37f749b 100644
--- a/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
+++ b/tools/testing/selftests/bpf/progs/test_tp_btf_nullable.c
@@ -7,11 +7,7 @@
 #include "bpf_misc.h"
 
 SEC("tp_btf/bpf_testmod_test_nullable_bare")
-/* This used to be a failure test, but raw_tp nullable arguments can now
- * directly be dereferenced, whether they have nullable annotation or not,
- * and don't need to be explicitly checked.
- */
-__success
+__failure __msg("R1 invalid mem access 'trusted_ptr_or_null_'")
 int BPF_PROG(handle_tp_btf_nullable_bare1, struct bpf_testmod_test_read_ctx *nullable_ctx)
 {
 	return nullable_ctx->len;
-- 
2.43.5


