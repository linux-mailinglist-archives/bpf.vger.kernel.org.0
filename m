Return-Path: <bpf+bounces-53006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5442AA4B7A0
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 06:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604D318906D9
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 05:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D041E3DC8;
	Mon,  3 Mar 2025 05:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TLbRHSH6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63EA1DCB24
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 05:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740980245; cv=none; b=ZcOxwbTDUfOxMbxVMQl1X5WkMHgIaquQdrwqGE1R7ek3l5tdRdxRH2MafvcY3usro9PZ5nQpuSW0q++1DQ+kpiBhBnR2TVJcRSakdh+wJOomllW76yyoK2jyXwXtXiLIzmyssz06nOgpwF922igUmGkIfVhkZp0WRDpXtsbsx0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740980245; c=relaxed/simple;
	bh=7knf85jVRu6AA2qW2iwIFp+1/VVhv5rUXtSLUlAdyq4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bk49J5rneE1Ny10GLRhFPPwrYsCKAsMxg85snoDqSS3XWewpcO+YdQaGfx2RsqpKMpdKpNZ8+67MzpOtcO5JWJ934G7ZhIVl1DgkVmSm3Hytbm+7KSUvzcdHjdhglbRTcIUDck5vT/E9qFOO9JRc+Ab3aepwnZfibJ/57sPjzxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TLbRHSH6; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-727332732b0so964903a34.1
        for <bpf@vger.kernel.org>; Sun, 02 Mar 2025 21:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740980242; x=1741585042; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t+JbDsy67cUYL40rbVjYYPAZCoJAbJK+Bgpj1Q0SZXU=;
        b=TLbRHSH6P8a2/5iMsLgN/QvHyTWLOTg3Z+CBGaVo9KYt2LBvQYiLtF6zz7iRCk5OCR
         tXYWgXrw2rdEopvs/hSf9s8UBnDkKo72TLixj8BBIbzQEPqSjhqCH9ZvHbBvM/3ywYat
         bil7xikwlxHWNZ96jO7FHha/YRmVvnEJDpT33+yPrfvya2AMSut2Hkb9j/4pj9tU5JKw
         OeoWlFdGEje22X0CgicHI/IFiPHD3/5Y0qRCynM9T+JeE/od4SLF2nLCy40zFpoOi8Uy
         n3ES4W8eKMu31RGwA9ZJHfZ50taXiG3hVdZdcKd3R5uxm7cSIS7600dgqzfiq8qsScqT
         Rw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740980242; x=1741585042;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+JbDsy67cUYL40rbVjYYPAZCoJAbJK+Bgpj1Q0SZXU=;
        b=i0rr0bSncJIN8Qm2tLxIpnEOrVrBiAeocHtMYcU9C5yInppk153FO+GPmFk+MK98Jr
         x0FyKg/+DR+wXnLajJpKD8ylwEe7S9Ue5GsjqCQd6vjHI1D1kEM0jFA58PMWdK3BNVco
         kcuWxinWWLXTE4qcji7q0c0NE/yws5d55hX2YCjWGci3VMdlS79MQExRlni2OkLPVdjt
         4Ecd1DRcQyOm1w5hwLvoJuMtnM/5WVGXnx13Qoz9i2PMmnlgGYylIWKjlglzH7Z4YOCF
         pNBFxzTGwXE7s9aO+ozT0g6z5eFuyYIgjRgD3Yzw/AN/3GpQWyGE2e+g3JQNJW5zSZuH
         stZw==
X-Gm-Message-State: AOJu0YwZK70CZM62ugVijZHbOIaFuia/a8LPomWaYwJIxcDmQ/gyUE/F
	QccnS7AA99XRpmy2tK4ldGaB7yM6Fb2mtqbpwajEP+PK9XfDSR1b3O27tAfi7lr7V90H28bAVlt
	hqhE4A6iS3qANEy/PszSybruxez4rUjWk4S94oAMGdywuI3vsC0RekBnRH5PREi2xDMzSBsqn4M
	mKHqtdUpe9tiu9NjBIHev4VFsEsnzPe9FC1CNKJEg=
X-Google-Smtp-Source: AGHT+IFuLGBKXj1TfcM+fxYVw/tUg0+xPiDUPHUfaif0a8hS8bsHY09Qvrucsh1Gl+blURS/FrX7hRSfk4jONw==
X-Received: from oaclu2.prod.google.com ([2002:a05:6871:3142:b0:2bc:6ad3:5671])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:af08:b0:29e:7603:be65 with SMTP id 586e51a60fabf-2c178337712mr6365626fac.1.1740980242647;
 Sun, 02 Mar 2025 21:37:22 -0800 (PST)
Date: Mon,  3 Mar 2025 05:37:19 +0000
In-Reply-To: <cover.1740978603.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740978603.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <6323ac8e73a10a1c8ee547c77ed68cf8eb6b90e1.1740978603.git.yepeilin@google.com>
Subject: [PATCH bpf-next v4 02/10] bpf/verifier: Factor out check_atomic_rmw()
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peilin Ye <yepeilin@google.com>, bpf@ietf.org, Alexei Starovoitov <ast@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	David Vernet <void@manifault.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Yingchi Long <longyingchi24s@ict.ac.cn>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently, check_atomic() only handles atomic read-modify-write (RMW)
instructions.  Since we are planning to introduce other types of atomic
instructions (i.e., atomic load/store), extract the existing RMW
handling logic into its own function named check_atomic_rmw().

Remove the @insn_idx parameter as it is not really necessary.  Use
'env->insn_idx' instead, as in other places in verifier.c.

Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 kernel/bpf/verifier.c | 53 +++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 66b19fa4be48..e3991ac72029 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7616,28 +7616,12 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type type,
 			     bool allow_trust_mismatch);
 
-static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_insn *insn)
+static int check_atomic_rmw(struct bpf_verifier_env *env,
+			    struct bpf_insn *insn)
 {
 	int load_reg;
 	int err;
 
-	switch (insn->imm) {
-	case BPF_ADD:
-	case BPF_ADD | BPF_FETCH:
-	case BPF_AND:
-	case BPF_AND | BPF_FETCH:
-	case BPF_OR:
-	case BPF_OR | BPF_FETCH:
-	case BPF_XOR:
-	case BPF_XOR | BPF_FETCH:
-	case BPF_XCHG:
-	case BPF_CMPXCHG:
-		break;
-	default:
-		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm);
-		return -EINVAL;
-	}
-
 	if (BPF_SIZE(insn->code) != BPF_W && BPF_SIZE(insn->code) != BPF_DW) {
 		verbose(env, "invalid atomic operand size\n");
 		return -EINVAL;
@@ -7699,12 +7683,12 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	/* Check whether we can read the memory, with second call for fetch
 	 * case to simulate the register fill.
 	 */
-	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
+	err = check_mem_access(env, env->insn_idx, insn->dst_reg, insn->off,
 			       BPF_SIZE(insn->code), BPF_READ, -1, true, false);
 	if (!err && load_reg >= 0)
-		err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
-				       BPF_SIZE(insn->code), BPF_READ, load_reg,
-				       true, false);
+		err = check_mem_access(env, env->insn_idx, insn->dst_reg,
+				       insn->off, BPF_SIZE(insn->code),
+				       BPF_READ, load_reg, true, false);
 	if (err)
 		return err;
 
@@ -7714,13 +7698,34 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 			return err;
 	}
 	/* Check whether we can write into the same memory. */
-	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
+	err = check_mem_access(env, env->insn_idx, insn->dst_reg, insn->off,
 			       BPF_SIZE(insn->code), BPF_WRITE, -1, true, false);
 	if (err)
 		return err;
 	return 0;
 }
 
+static int check_atomic(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	switch (insn->imm) {
+	case BPF_ADD:
+	case BPF_ADD | BPF_FETCH:
+	case BPF_AND:
+	case BPF_AND | BPF_FETCH:
+	case BPF_OR:
+	case BPF_OR | BPF_FETCH:
+	case BPF_XOR:
+	case BPF_XOR | BPF_FETCH:
+	case BPF_XCHG:
+	case BPF_CMPXCHG:
+		return check_atomic_rmw(env, insn);
+	default:
+		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n",
+			insn->imm);
+		return -EINVAL;
+	}
+}
+
 /* When register 'regno' is used to read the stack (either directly or through
  * a helper function) make sure that it's within stack boundary and, depending
  * on the access type and privileges, that all elements of the stack are
@@ -19224,7 +19229,7 @@ static int do_check(struct bpf_verifier_env *env)
 			enum bpf_reg_type dst_reg_type;
 
 			if (BPF_MODE(insn->code) == BPF_ATOMIC) {
-				err = check_atomic(env, env->insn_idx, insn);
+				err = check_atomic(env, insn);
 				if (err)
 					return err;
 				env->insn_idx++;
-- 
2.48.1.711.g2feabab25a-goog


