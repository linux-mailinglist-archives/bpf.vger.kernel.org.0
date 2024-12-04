Return-Path: <bpf+bounces-46045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4D59E3182
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 03:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F5028513F
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 02:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC34757F3;
	Wed,  4 Dec 2024 02:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAIYhgWl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3662A8D0
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 02:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733280121; cv=none; b=WdtrfG0z408UvSsvPUKkVisCYTN9rq3+edU8JiMAKDu3MdzjF9YV/m0ErhlnpglsDP294Gth2BLRvIsaOgYWPDVMYdFSkeE7eKP8vaQDCCezR2C8Zf8BmrspIwJPtTMpRmb0G2SSVbPHuS/Fmr2y2djgh8l0z/SICWfZ/Ydn1iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733280121; c=relaxed/simple;
	bh=kr8LKcqxg60fcBZt62Nwvk3k3pyftJLPfJKNwyWiICc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAtpqAYEgi3sloAe3h6Hzn6Z9NbGn4/OllIKCDs+OC5AP1rM+SeiYsB48SEhg8eCGCfBRVvdxXMSZkHclltEFYuxE4wR6BkuVmHHV3hoC+135xdRqgnS4yPzix1HsHppLPfuGaL8SCV4qeyR6/+B2s8JiSrfRhWOnCvNyaVxUyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAIYhgWl; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-385e0e224cbso3090882f8f.2
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 18:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733280117; x=1733884917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6IibgXDbezQ+bSHsgMht2fdqkKOjGq0NApi11zMm0s=;
        b=jAIYhgWlR7SR9pmChk4cUVQ/ktUjbKNOMcw66yEYNefb6EXgoEru+WoBJO2TKgpChS
         uWGbcKuTjhXFHVxcvbOBLtl9UUQDjP4tIOrIKl8EGTx+xtdYlv6Wcwq0uDrxAQNrdh4c
         gfbdIAhLaIEJBcCbQ35DYjeVS+tGyEnVfBqoftLnXgX6GwnWf9BYT7SWbV1DzJTp9AcS
         nl1o3+YlkwTTsYPDIktQF5Tog4q0cCFygmzu/3x3OFONFK5WhlJW/K+TkKC3gttgIT+6
         6OhIWCmdjYIbkVPyFMlZsrmCzjzMRFuA5TCtED1hMQBNFABDTBLPEGk26DUq9mguwywE
         YcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733280117; x=1733884917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6IibgXDbezQ+bSHsgMht2fdqkKOjGq0NApi11zMm0s=;
        b=KD9KBTXjqt6e+jZLnHqqC3/YXViQjKJ0kGh5O8Y6Q6ASiNpLpxXOlOHxTZPu2k7Tdh
         WZoc48QFoEsjdXV0PusFo6+f4KjUSI1cYeWwgYT6ehcmNAlMoNPRceZZLp+lw5CcHZoP
         Q79mhkUetpAP6xCWh6zu/O9ciiXqEBrEo7iFNme+wevdAM1R4Q30ZRAjVJ6uBjVYFIWv
         OEdrdn3GHpYq9ikNjqLOo2axk3g0aUb6yThOqoImrKtNE4jkcp0Im5nJF42RinbhSoMA
         Hki3UhfRCgcUvayRilF+hoI7S+OLeTM7rmhZv/EXU8OtuxGzsfTMzuO/nmpe3JxaLQJ1
         8Vhw==
X-Gm-Message-State: AOJu0YzWzGVPNP/v0ybH0ViitVDzAXatIcFGOzLQL5eK9Aa2DE/wIULV
	saUju6G1OQXYFw2JnlsSQMf0SWA+cArRI5kgKYpfOsQvKfnp6jeJUN4dpLiCfyI=
X-Gm-Gg: ASbGnctVumdNxfmr8cWeX/DWy+bs/jPcRc/RfI3vZDPrWtoSTHd4ev9Pnsq+npv6wYo
	g9JYWqX9lokmxikBdAgXZ7smxiGscfaBxxNXVv65n98OFX6Q5Uh9XrxTWdJoVS5Emab+weXDpix
	P9uYoVxJC4J872207UTq9+znGu1VKm5DH/Za8rSeP06a09mfRx83KhBdiMMLHSaHB50lT6WzAcu
	2j0h6j/Ksxhwy1ywsVoTOzs3uVOiZcaV2e0byH0Zq210UFgP9PwMGLz/fwtfm+XmulOh7K0j6ym
	bw==
X-Google-Smtp-Source: AGHT+IGhVC42yoECG0uqtF5SGUNluQCYdIn35tmQDJjTHXd1EAAyOzzGjFYrEYIWibTXe0cel+liug==
X-Received: by 2002:a5d:5f45:0:b0:385:e4a7:def9 with SMTP id ffacd0b85a97d-385fd532811mr3442206f8f.50.1733280117428;
        Tue, 03 Dec 2024 18:41:57 -0800 (PST)
Received: from localhost (fwdproxy-cln-020.fbsv.net. [2a03:2880:31ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385f10a12dbsm7896468f8f.105.2024.12.03.18.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 18:41:56 -0800 (PST)
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
Subject: [PATCH bpf v1 1/2] bpf: Suppress warning for non-zero off raw_tp arg NULL check
Date: Tue,  3 Dec 2024 18:41:53 -0800
Message-ID: <20241204024154.21386-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241204024154.21386-1-memxor@gmail.com>
References: <20241204024154.21386-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6311; h=from:subject; bh=kr8LKcqxg60fcBZt62Nwvk3k3pyftJLPfJKNwyWiICc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnT8CAFZYji05D7JQsUu8CC191JRFpTWUCy2XNeqP0 3j9Md3aJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0/AgAAKCRBM4MiGSL8RyiwYD/ 9BvkJHn0/1z7j9otzZccpPOLMo2oRFlTaPvzOpLBKLRcRmTg8jCNTU2u5u7fVcbgcz3iBMwqFMl4gr GjmKfjc2QvXX6KA3MMuYOyL6ERVP2sJdK7eC4fkW1YCkPfax2BqLefa2Bdqp81dYuxfCAxlueyx7A/ 1ERFjoU23BytaPaGvVwGbKF29TYGWmXvX+bu78h/D8teW64B6uhbJeMY+WRwrnnt6ipJGRPeU2jNhv rkaKfaonCIx/ljYzbMRwVOZtb21er9r3wIxCAChOkTRUN7Ho8SbJdXobW4CIMHUFmR2ajW1iP5Uc8l YB8XdBGY6OU76Bdu0HZLR31IiZpJQnvXsYk/Z8QvOs/+IkONOiApj1d5l0nnHVoZ8n/M1M2Ba5Eo61 J6lDqQVEVCb2Taf+640h7n+4XtSuQflCGD69QrtLj6Kgi70h04BGxUMQrGUEJ+XZcwc6vbjpi1wlh6 cqrEedVtJKQph5UcjTmafnBXdoX2oYq0siSUv23cZq6P5CB2X336ORCMdLxVfDDdxnpwRPJQUaJiqs KBxYcvKXcX6MJ1plancfgYaArXMK6JN08agtC2Q6j9YdXzca5eFfYCkFvEWqeidBHDezY65vIzpXIp KuajIcdra3+7Fyyjqngaecw4/ahH3RfXhcqP9ebK2tQVe1pJTyUFjrRPF5Vw==
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

Hence, for now, when we notice raw_tp args with off != 0 when unmarking
NULL modifier, simply allocate such pointer a fresh id and remove them
from the "id" set being currently operated on, and leave them as is
without removing PTR_MAYBE_NULL marking.

Dereferencing such pointers will still work as the fixed commit allowed
it for raw_tp args.

This will mean that still, all registers with a given id and off = 0
will be unmarked, even if a register with off != 0 is NULL checked, but
this shouldn't introducing any incorrectness. Just that any register
with off != 0 excludes itself from the marking exercise by reassigning
itself a new id.

Fixes: cb4158ce8ec8 ("bpf: Mark raw_tp arguments with PTR_MAYBE_NULL")
Reported-by: Manu Bretelle <chantra@meta.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 44 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1c4ebb326785..37504095a0bc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15335,7 +15335,8 @@ static int reg_set_min_max(struct bpf_verifier_env *env,
 	return err;
 }
 
-static void mark_ptr_or_null_reg(struct bpf_func_state *state,
+static void mark_ptr_or_null_reg(struct bpf_verifier_env *env,
+				 struct bpf_func_state *state,
 				 struct bpf_reg_state *reg, u32 id,
 				 bool is_null)
 {
@@ -15352,6 +15353,38 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 		 */
 		if (WARN_ON_ONCE(reg->smin_value || reg->smax_value || !tnum_equals_const(reg->var_off, 0)))
 			return;
+		/* Unlike the MEM_ALLOC and NON_OWN_REF cases explicitly tested
+		 * below, where verifier will set off != 0, we allow users to
+		 * modify offset of PTR_MAYBE_NULL raw_tp args to preserve
+		 * compatibility since they were not marked NULL in older
+		 * kernels. This however means we may see a non-zero offset
+		 * register when marking them non-NULL in verifier state.
+		 * This can happen for the operand of the instruction:
+		 *
+		 * r1 = trusted_or_null_(id=1);
+		 * if r1 == 0 goto X;
+		 *
+		 * or a copy when LLVM produces code like below:
+		 *
+		 * r1 = trusted_or_null_(id=1);
+		 * r3 = r1; // r3 = trusted_or_null(id=1)
+		 * r3 += K; // r3 = trusted_or_null_(id=1, off=K)
+		 * if r1 == 0 goto X; // see r3.off != 0 when unmarking _or_null
+		 *
+		 * The right fix would be more generic: lift the restriction on
+		 * modifying reg->off for PTR_MAYBE_NULL pointers, and only
+		 * enforce it for the instruction operand of a NULL check, while
+		 * allowing non-zero off for other registers, but this is future
+		 * work.
+		 */
+		if (mask_raw_tp_reg_cond(env, reg) && reg->off) {
+			/* We don't reset reg->id back to 0, as it's unexpected
+			 * when PTR_MAYBE_NULL is set. Simply give this reg a
+			 * new id in case user decides to NULL check it again.
+			 */
+			reg->id = ++env->id_gen;
+			return;
+		}
 		if (!(type_is_ptr_alloc_obj(reg->type) || type_is_non_owning_ref(reg->type)) &&
 		    WARN_ON_ONCE(reg->off))
 			return;
@@ -15385,7 +15418,8 @@ static void mark_ptr_or_null_reg(struct bpf_func_state *state,
 /* The logic is similar to find_good_pkt_pointers(), both could eventually
  * be folded together at some point.
  */
-static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
+static void mark_ptr_or_null_regs(struct bpf_verifier_env *env,
+				  struct bpf_verifier_state *vstate, u32 regno,
 				  bool is_null)
 {
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
@@ -15401,7 +15435,7 @@ static void mark_ptr_or_null_regs(struct bpf_verifier_state *vstate, u32 regno,
 		WARN_ON_ONCE(release_reference_state(state, id));
 
 	bpf_for_each_reg_in_vstate(vstate, state, reg, ({
-		mark_ptr_or_null_reg(state, reg, id, is_null);
+		mark_ptr_or_null_reg(env, state, reg, id, is_null);
 	}));
 }
 
@@ -15827,9 +15861,9 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
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


