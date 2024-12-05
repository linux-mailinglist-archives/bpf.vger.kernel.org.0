Return-Path: <bpf+bounces-46183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C60209E60A8
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 23:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3BEA188566C
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 22:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F681CEACD;
	Thu,  5 Dec 2024 22:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2iIBy+K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C819B17E019
	for <bpf@vger.kernel.org>; Thu,  5 Dec 2024 22:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733437919; cv=none; b=JM/J2RRd+yANOJRUW/DzuD07eqALmF9mbKF8OwwjWDRqu5aqLAHok1gmA+F4DtLjN0DEOIZJfgfBGJ8uBXM/49H9LhF7v57UwjWVWBl2O9SN6BFBYlqSDy2e6j24N5JVzIDmnt7kMipJ3s4KUUbMCNwAW3BnXJ0LvOc+fQCuzJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733437919; c=relaxed/simple;
	bh=i4lwKxk0mQNXNI8Zr+ep9zrj9JKSpCYwkpy1xoIK1Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXPAG6YUE7LU2UdF62IOenLKYT5MsXOyHNr+FvJKtmzaHJBGTyZKJ6aiyxFAfUZU/B3ZRqZknotRXqci4Nt5Oq3F3UfV8K23DdkXEgaibud4rCBA6cwYqlO/IlW/oPsj5PwhwFEi553jb8Wrcb9cAQZzp5cvEfiv1ZEft0EXMxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2iIBy+K; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-434a044dce2so16587065e9.2
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 14:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733437916; x=1734042716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcSL9ReCVO5Sv85uz/i5JsBCJPXG3XAZg4c8IJpU1nM=;
        b=Y2iIBy+KvJ6HEPdL+e6IFz8YpADbqMmkLzv+EpYIcVl5GRWiA+kTEaUBiQTv+Kz7wp
         2vGFj2PLYTvaxKudI56BoctQbrSiMvfCQ9taBdv6AjOKbnS19HlLIFYTiK4liFJEXKwj
         bKDBUaQtDFzSB13IpE2dfWCIlYiDrU7LhOYbWOeAhJNGx+M4KUHUVh6QPU4PwphIkZCy
         +pf28NYp3TFdEQYdvl5/YGcPhTFrNtL7b+hOBc9W5TXX2zPjrkrSdOacQzTWwoUj0X5l
         +afDFA5hNyONmNQ5PHP4Ml5ZpWASZCNMl7zShIJtGjyMaq1fX9OzoHFZE7Cw5WTBQVkK
         Mqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733437916; x=1734042716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcSL9ReCVO5Sv85uz/i5JsBCJPXG3XAZg4c8IJpU1nM=;
        b=K+DX3jgB0XX5EQcg5PT/9QAxaCU7weEj1CmJyh/uuQdKA2IcHQEVnlz202X2tDgCMJ
         rj4cEPLHkTGOxGJSUUCVRUl9lGLrreIm/SyO7H46b7a1vxoaML0XiuzwwbbPvcBZbbpb
         15XvnZ3LqqC1tHprT/6geYsGAoqazmlC3GG5zfthtCMV+YeFrc25ZoZ7NIIzN9+5o4po
         d6bO7s6z2Fk+XrAaIaUyCC5P9xwFnzci64mejc394r1Em2IJr3Nh4GMxYjvRghFi2jX6
         EEvxnHUiXeXMud1xRIdClBQh6gkheggETmUSnabRtlqL1IdXS75SDNavGahs/dET7EdL
         fZSg==
X-Gm-Message-State: AOJu0Yw1jmysA4roTey3Yi8iXd03XtY/I385PhoCShYAykjRuWtg7UNe
	+aAo8yyGURi097xu/Ef2tQd9XpEtEk0oc7uIR5QXLrK2F5IVA+wR1gcexRA7ch0=
X-Gm-Gg: ASbGncuPAvr8ewJjeHp4/FV7E4mlx+KYxCAnBvOGqsF58qR5F7tnzWSe14SenBs2bOH
	yQhNjWYkV9G8Bdj9m3Qm4kzcmoxVsDvOhfjIETA10olfiR6Qkr7mwigTcONMWeRib5NcWUYZeBh
	e6qyrPv/yANWDRYf8K0svMQ+XdeYLUsKnHBxNH3+r3P6fJ3kImLe/xwo+Pg3paU82cIms7muXi/
	wJL2QT0GCfJJzuT3EvE331SoP9+JiGSl6eRt13mEGM7o/0KSYHRPRgkrvQb4t0HdRsgbRd14ACM
X-Google-Smtp-Source: AGHT+IF3TL7X9TEZnVdk6gIal3tN3rQqu28EXuAIEJt7uEEkszY6oNj19oZVGS/iVGzdzePwzyAXAQ==
X-Received: by 2002:a05:600c:4f51:b0:434:a923:9321 with SMTP id 5b1f17b1804b1-434ddead515mr8314375e9.5.1733437915419;
        Thu, 05 Dec 2024 14:31:55 -0800 (PST)
Received: from localhost (fwdproxy-cln-007.fbsv.net. [2a03:2880:31ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386221a5eadsm3026270f8f.104.2024.12.05.14.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 14:31:54 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Manu Bretelle <chantra@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf v2 1/2] bpf: Suppress warning for non-zero off raw_tp arg NULL check
Date: Thu,  5 Dec 2024 14:31:51 -0800
Message-ID: <20241205223152.2434683-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241205223152.2434683-1-memxor@gmail.com>
References: <20241205223152.2434683-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5677; h=from:subject; bh=i4lwKxk0mQNXNI8Zr+ep9zrj9JKSpCYwkpy1xoIK1Xk=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnUii0yD2sl24TdJoD96jmqB9RCWsoorDEHYEIFnE4 LMCDQTuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ1IotAAKCRBM4MiGSL8Ryn68D/ sFHkDfVQpk4CbZpUWsokd8D5Ou5Eolyg/+lhcUDy8kSfKG/g8VoeQ22SZD8IMbPNciQO/98ZEJL0m8 Zo4aLokC+XlKQIrlxMN7uqfNzO/dKd6pK1DvVLqSZxgfqJs7KDzwwpmX+mPGVjNriWsUk14J9zR/3M UdcmWhW/iLqU4oSeE5czCJSkLp2/vxdxXgrXoLAyCsnQrVv3F5ozi8S8yoWmHLOtbKms421PJiyQuT MasGYSAPl67I8wxj6yxrAElzXVc0WaOGvYipeBZiVqFhhVLnagqZBkGPulmqjV78KpkOd6/hEAyKjf wlsN4Ve2m9HcyRsnasDD2KzEgbzLM3cM3ROFF7rMOP6s0eQ7Yc99sa19MpM4ANxTYnU9isGJS0EM4H AbpvP/SwxfmaNO2okomjW4dWqk0MQMPWBU54RlEvItDs+uN1qHYzFaUi4gTrLvGCOnkgE6xVf17kOs QWGCnJ0evTPWdkAbuGDA5PGyaCLLJiFRjqUGLKpFDbfCC4Npm/IELEcybQgqXexMIwyn1G0fA/VYij vQEhB95t7SlOBbwe6PU2aTn3U3XFKQa3/Swf8E8t7MSEVr7nNYxgLfN5WMaeI7A7amW4+GvpgZonK9 Ge9ijh4VVfJICF+4OksHgK1WztXfRNd3cWBQ9vyry1QpYFMBPZRUfUby75Dw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

The fixed commit began marking raw_tp arguments as PTR_MAYBE_NULL to
avoid dead code elimination in the verifier, since raw_tp arguments
may actually be NULL at runtime. However, to preserve compatibility,
it simulated the raw_tp accesses as if the NULL marking was not present.

One of the behaviors permitted by this simulation is offset modification
for NULL pointers. Typically, this pattern is rejected by the verifier,
and users make workarounds to prevent the compiler from producing such
patterns. However, now that it is allowed, when the compiler emits such
code, the offset modification is allowed and a PTR_MAYBE_NULL raw_tp arg
with non-zero off can be formed.

The failing example program had the following pseudo-code:

r0 = 1024;
r1 = ...; // r1 = trusted_or_null_(id=1)
r3 = r1;  // r3 = trusted_or_null_(id=1) r1 = trusted_or_null_(id=1)
r3 += r0; // r3 = trusted_or_null_(id=1, off=1024)
if r1 == 0 goto pc+X;

At this point, while mark_ptr_or_null_reg will see PTR_MAYBE_NULL and
off == 0 for r1, it will notice non-zero off for r3, and the
WARN_ON_ONCE will fire, as the condition checks excluding register types
do not include raw_tp argument type.

This is a pattern produced by LLVM, therefore it is hard to suppress it
everywhere in BPF programs.

The right "generic" fix for this issue in general, will be permitting
offset modification for PTR_MAYBE_NULL pointers everywhere, and
enforcing that the instruction operand of a conditional jump has the
offset as zero. It's other copies may still have non-zero offset, and
that is fine. But this is more involved and will take longer to
integrate.

If a zero offset pointer is NULL checked, all copies can be marked
non-NULL, while checking non-zero offset PTR_MAYBE_NULL is a no-op.

For now, only make this change for raw_tp arguments, and table the
generic fix for later.

Dereferencing such pointers will still work as the fixed commit allowed
it for raw_tp args.

Fixes: cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")
Reported-by: Manu Bretelle <chantra@meta.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2fd35465d650..dea92cac2522 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15340,7 +15340,8 @@ static int reg_set_min_max(struct bpf_verifier_env *env,
 	return err;
 }
 
-static void mark_ptr_or_null_reg(struct bpf_func_state *state,
+static void mark_ptr_or_null_reg(struct bpf_verifier_env *env,
+				 struct bpf_func_state *state,
 				 struct bpf_reg_state *reg, u32 id,
 				 bool is_null)
 {
@@ -15357,8 +15358,8 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 		 */
 		if (WARN_ON_ONCE(reg->smin_value || reg->smax_value || !tnum_equals_const(reg->var_off, 0)))
 			return;
-		if (!(type_is_ptr_alloc_obj(reg->type) || type_is_non_owning_ref(reg->type)) &&
-		    WARN_ON_ONCE(reg->off))
+		if (!(type_is_ptr_alloc_obj(reg->type) || type_is_non_owning_ref(reg->type) ||
+		    mask_raw_tp_reg_cond(env, reg)) && WARN_ON_ONCE(reg->off))
 			return;
 
 		if (is_null) {
@@ -15390,11 +15391,12 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 /* The logic is similar to find_good_pkt_pointers(), both could eventually
  * be folded together at some point.
  */
-static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
+static void mark_ptr_or_null_regs(struct bpf_verifier_env *env,
+				  struct bpf_verifier_state *vstate, u32 regno,
 				  bool is_null)
 {
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
-	struct bpf_reg_state *regs = state->regs, *reg;
+	struct bpf_reg_state *regs = state->regs, *reg = &regs[regno];
 	u32 ref_obj_id = regs[regno].ref_obj_id;
 	u32 id = regs[regno].id;
 
@@ -15405,8 +15407,28 @@ static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
 		 */
 		WARN_ON_ONCE(release_reference_state(state, id));
 
+	/* For raw_tp args, compiler can produce code of the following
+	 * pattern:
+	 * r3 = r1; // r1 = trusted_or_null_(id=1) r3 = trusted_or_null_(id=1)
+	 * r3 += 8; // r3 = trusted_or_null_(id=1,off=8)
+	 * if r1 == 0 goto pc+N; // r1 = trusted_(id=1)
+	 *
+	 * But we musn't remove the or_null mark from r3, as it won't be
+	 * NULL.
+	 *
+	 * Only do unmarking of everything sharing id if operand of NULL check
+	 * has off = 0.
+	 */
+	if (mask_raw_tp_reg_cond(env, reg) && reg->off) {
+		/* We don't reset reg->id back to 0, as it's unexpected
+		 * when PTR_MAYBE_NULL is set. Simply avoid performing
+		 * a walk for other registers with the same id.
+		 */
+		return;
+	}
+
 	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
-		mark_ptr_or_null_reg(state, reg, id, is_null);
+		mark_ptr_or_null_reg(env, state, reg, id, is_null);
 	}));
 }
 
@@ -15832,9 +15854,9 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		/* Mark all identical registers in each branch as either
 		 * safe or unknown depending R == 0 or R != 0 conditional.
 		 */
-		mark_ptr_or_null_regs(this_branch, insn->dst_reg,
+		mark_ptr_or_null_regs(env, this_branch, insn->dst_reg,
 				      opcode == BPF_JNE);
-		mark_ptr_or_null_regs(other_branch, insn->dst_reg,
+		mark_ptr_or_null_regs(env, other_branch, insn->dst_reg,
 				      opcode == BPF_JEQ);
 	} else if (!try_match_pkt_pointers(insn, dst_reg, &regs[insn->src_reg],
 					   this_branch, other_branch) &&
-- 
2.43.5


