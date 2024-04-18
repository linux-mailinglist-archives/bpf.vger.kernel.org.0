Return-Path: <bpf+bounces-27096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12958A904D
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 03:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E722BB21A9B
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 01:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296F843AAD;
	Thu, 18 Apr 2024 01:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="asElrn9b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA5A3A27E
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 01:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713402455; cv=none; b=VuvOUVZtkJOXdcFss3P9zUmy7+mrmriORevm96CEQzHhfBQYkqYPwO5OEax4qKGKy9F7ZX83tpGb7cT5LbRIBfx1GCK1iJoFmy44sxpPDMumgXOzo9MZAQic0016fmzJlUe0IKhnB3WRW1PutotSxxiPJsQfNWYmRYpBX+jBgjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713402455; c=relaxed/simple;
	bh=hdMC0z91vvJYbvI01dveXo00UXftnvvAxvKn4Y6t0CI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iiDL9XOCGnrEdwaTQAjKKHCvuTnw/RSwgFAq9yH+v+tzUzDRVAbQ/bTXtb6LNSubyAKKDnlia+nHdn0PA/bHfKg1F9OrapUp8R7mMQbWuJwtlE0qiXp7YsYG/ShokUViYkcaJ5Z82hyNfJtZygiIwu5yqOknOyKyjLAc1GKt3X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=asElrn9b; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6150dcdf83fso5795757b3.2
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 18:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713402453; x=1714007253; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LPdsH3unfID5a94BwZ2eo2AhAQkfEbFlWqnVbTkdEDg=;
        b=asElrn9bmq1Ly7TmzP/VQbj7DrDVi8ImEmgvTYOoH0hU8qpOVzvkm+/9QdoguCNc+U
         4o9y79TqyRbWGetg6FfMwbwLAhM7H3oPboihOCfA11vecFEbZHFXeUtZFIif/dtjo5V+
         rRxeD2PUxsGi1LM8qJuD4cVhtpD4Vza+2facM9EaIc4dVTLh90oR29VMW52KcSDQcAfV
         S7its/lmyjSCbhoQJF63cFAM2vNTFY+ULQfcN0iFgK1ojZ+mNquto74NNdQkPTY/i3P2
         9x9i7utEmwz4ebLtSPSq+iErr1khQLiNf5CGeve83RLlJLxYR1GeONU/uK+hxTxvpDi6
         763A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713402453; x=1714007253;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LPdsH3unfID5a94BwZ2eo2AhAQkfEbFlWqnVbTkdEDg=;
        b=QrI+Nokgnor7Ij3BUyBIwJm1oE53ZiZVt2b6zkSGll6yF1QZPLbeNlPdGDz5z/hW3v
         IQM/r4BIy6hRSApGkm2rPeWQ/uaHeQ/lxgDLSO0Ftg3rxEzvUjs4xbkznBGbJKHBf2JQ
         7x6oxxja4nARBqvMZM3+bhCar0GT8rDpRksARqp//RjJ7RMg8hICk+UYt0evtZDGvdwY
         CtPkQYt8fDbdsZIXX1a777bj/EEsTfkiPA1t6z/OQROM4ZbN1/XXhYSnrNhvOf9wr0St
         Yg8RV5sNy03su/bDDq3IfemJKuZQVkLKeftjKTz19PNY4/KY8E+K45cTGmxgMkBZLLEK
         tFhA==
X-Gm-Message-State: AOJu0YymvBOcOgE+0o4UpVK//rsYnwbbUSO5Q8o5bW6Xb7FiWuTVpoTt
	eWCPM3Gf1YKnEtc0eSuPTmnpCDeAOdu5ISXRRX99m18AzWjlc3tDZiGdx0tJydYq7FFUTnhvxO/
	zZw==
X-Google-Smtp-Source: AGHT+IFR37E+g/Hieyk3cbAnHMPPekB2ASXI+KjFwMkBR6XYdvFShHQ6MxZ3cXSjs2LpInjQDvDZDKtKakM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a81:f208:0:b0:617:cbcf:8233 with SMTP id
 i8-20020a81f208000000b00617cbcf8233mr221167ywm.2.1713402453368; Wed, 17 Apr
 2024 18:07:33 -0700 (PDT)
Date: Thu, 18 Apr 2024 01:07:11 +0000
In-Reply-To: <20240418010723.3069001-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <16430256912363@kroah.com> <20240418010723.3069001-1-edliaw@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418010723.3069001-3-edliaw@google.com>
Subject: [PATCH 5.15.y v2 2/5] bpf: Generalize check_ctx_reg for reuse with
 other types
From: Edward Liaw <edliaw@google.com>
To: stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>
Cc: bpf@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Daniel Borkmann <daniel@iogearbox.net>

Generalize the check_ctx_reg() helper function into a more generic named one
so that it can be reused for other register types as well to check whether
their offset is non-zero. No functional change.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
(cherry picked from commit be80a1d3f9dbe5aee79a325964f7037fe2d92f30)
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 include/linux/bpf_verifier.h |  4 ++--
 kernel/bpf/btf.c             |  2 +-
 kernel/bpf/verifier.c        | 21 +++++++++++----------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3d04b48e502d..c0993b079ab5 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -541,8 +541,8 @@ bpf_prog_offload_replace_insn(struct bpf_verifier_env *env, u32 off,
 void
 bpf_prog_offload_remove_insns(struct bpf_verifier_env *env, u32 off, u32 cnt);
 
-int check_ctx_reg(struct bpf_verifier_env *env,
-		  const struct bpf_reg_state *reg, int regno);
+int check_ptr_off_reg(struct bpf_verifier_env *env,
+		      const struct bpf_reg_state *reg, int regno);
 int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 		   u32 regno, u32 mem_size);
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9a0db26a3bfa..be5bd4670296 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5553,7 +5553,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 					i, btf_type_str(t));
 				return -EINVAL;
 			}
-			if (check_ctx_reg(env, reg, regno))
+			if (check_ptr_off_reg(env, reg, regno))
 				return -EINVAL;
 		} else if (is_kfunc && (reg->type == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
 			const struct btf_type *reg_ref_t;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1c95d97e7aa5..61b8a9c69b1c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3792,16 +3792,16 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
 }
 #endif
 
-int check_ctx_reg(struct bpf_verifier_env *env,
-		  const struct bpf_reg_state *reg, int regno)
+int check_ptr_off_reg(struct bpf_verifier_env *env,
+		      const struct bpf_reg_state *reg, int regno)
 {
-	/* Access to ctx or passing it to a helper is only allowed in
-	 * its original, unmodified form.
+	/* Access to this pointer-typed register or passing it to a helper
+	 * is only allowed in its original, unmodified form.
 	 */
 
 	if (reg->off) {
-		verbose(env, "dereference of modified ctx ptr R%d off=%d disallowed\n",
-			regno, reg->off);
+		verbose(env, "dereference of modified %s ptr R%d off=%d disallowed\n",
+			reg_type_str(env, reg->type), regno, reg->off);
 		return -EACCES;
 	}
 
@@ -3809,7 +3809,8 @@ int check_ctx_reg(struct bpf_verifier_env *env,
 		char tn_buf[48];
 
 		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-		verbose(env, "variable ctx access var_off=%s disallowed\n", tn_buf);
+		verbose(env, "variable %s access var_off=%s disallowed\n",
+			reg_type_str(env, reg->type), tn_buf);
 		return -EACCES;
 	}
 
@@ -4260,7 +4261,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			return -EACCES;
 		}
 
-		err = check_ctx_reg(env, reg, regno);
+		err = check_ptr_off_reg(env, reg, regno);
 		if (err < 0)
 			return err;
 
@@ -5140,7 +5141,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		return err;
 
 	if (type == PTR_TO_CTX) {
-		err = check_ctx_reg(env, reg, regno);
+		err = check_ptr_off_reg(env, reg, regno);
 		if (err < 0)
 			return err;
 	}
@@ -9348,7 +9349,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 			return err;
 	}
 
-	err = check_ctx_reg(env, &regs[ctx_reg], ctx_reg);
+	err = check_ptr_off_reg(env, &regs[ctx_reg], ctx_reg);
 	if (err < 0)
 		return err;
 
-- 
2.44.0.769.g3c40516874-goog


