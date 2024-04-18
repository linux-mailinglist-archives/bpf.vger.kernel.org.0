Return-Path: <bpf+bounces-27184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7EC8AA5B5
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 01:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC5D1C2135E
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 23:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045DD7D414;
	Thu, 18 Apr 2024 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pn2WQmcr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BEA7C0B0
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713482435; cv=none; b=N1bdiv5pACJwF94Y3tnVq1Upiyav3R/pRdkgib0iaHC/2zxZ/awiFdB0xW5k/WxjKMh2C8PJp4JIcgm4vq8sLptGSbLzvV8WlapkZanINg9a2LcWuCtdX1xi3u9B5npy+BoQ1AhLvNKNgI091FhzvhzSdkMFgrwEWIuS/Q7rbvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713482435; c=relaxed/simple;
	bh=7WAgsmWa8I2nRXxoayOV0F/ehsyZq3cQzYa0hL40wdw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DcGF+v3fX8hvy1nm7tst+BQQ0lHCRrjxR81tndsugb334hcOAK/1Klp/J/0balBLtk4D5/bfzqbfKuHOldjoUX5PxCC0oXDiav6Q8+B6vLYFEJkn5AlS0ntnDJJbqKfNxlrIj5vTlGBZ18kUejJ4asaSoZ5XtU/YQ7suxNzwnrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pn2WQmcr; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5cf555b2a53so1756635a12.1
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 16:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713482432; x=1714087232; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PJWz1uvQTzKPjGuvX+wqPQBpUoIACARU5eow85W6RVU=;
        b=pn2WQmcr1AACnBg5t7LFSPJCbfvLviyF4Z/jvnKO/HCaMnH1ATHN6yAHg6D7ZHxJwY
         PSlVz3VxmPq1Q0MZHJFL4+Ors94G/RF1eCOVBSgSowkwFf0AsPMrhu+3dsMlQHqZcU9n
         QK93oCqiqWGkMRwvvuIn6AREpdkTtn755Wa0K+f7a6AVhxKkXc+QH7t5H2dyTRrXnNZg
         9g1aozYqfFpkW2jUBsni5riM7COFPRRTiJukt7UEWjVpXlT24DmudVdVTyW8IR+Ft1IR
         ofGN3MCSIneVRslKtO61lu7/px2RxXjgigal61k7wT/k8sTn/fkj2rJPzyn7o8IHzk3/
         Y9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713482432; x=1714087232;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJWz1uvQTzKPjGuvX+wqPQBpUoIACARU5eow85W6RVU=;
        b=wVOQ3fXKE3tqNEFJCr7zByoJEXBnnPWQtn08j51NdT6Icrton0J4iJ4bPW5M7XFoHG
         9soTV1HRHM7npUsiD5ChujuN8dKNIE0oKLe3BpBzhk2jE5MhinS725eyyiNDZRWLT1g5
         m569THIcsDDINcgxDm/g2SjVQRWVO6ab/j+XQET7G84vgb7z3rYCUHsqw7cvk7IyuTFe
         /TXQkhBM1qYrAzTlg/Z82Y5Go4EquPk9OIcY4lpw5P1qPVasvEMMYqFz9/9yh66JY1Xf
         3rKMRfuA3qeS7E17V4y+nyfIIzqfcEr5l/VYG7RMpAo3D+nD7gnY7kQ6OZgaRo0smdRM
         KgEQ==
X-Gm-Message-State: AOJu0YxM2hdZZuz7x2eISKhdVVT+MWrcDulCFH4W6pTPon48rn9x7cTO
	cqg/0PX9+dfe4PHqqHKspul6Qa1mwaLF/qWqKdsRqTxuRdRuPlLdSRK8wgNA6j1RHVMsIFmJnD0
	XGQ==
X-Google-Smtp-Source: AGHT+IGZvpipb458KhuKNr2lT6l2L7v8w6uv6b7TY6/fKUTAKy1KSarqOpYJWvLTO6PRPcEY1aRIn/XdgRg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:3d4f:b0:2a2:bcae:83c1 with SMTP id
 o15-20020a17090a3d4f00b002a2bcae83c1mr28422pjf.3.1713482432421; Thu, 18 Apr
 2024 16:20:32 -0700 (PDT)
Date: Thu, 18 Apr 2024 23:19:48 +0000
In-Reply-To: <20240418232005.34244-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <16430256912363@kroah.com> <20240418232005.34244-1-edliaw@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418232005.34244-3-edliaw@google.com>
Subject: [PATCH 5.15.y v3 2/5] bpf: Generalize check_ctx_reg for reuse with
 other types
From: Edward Liaw <edliaw@google.com>
To: stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, Yonghong Song <yhs@fb.com>, linux-kernel@vger.kernel.org
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
index 77929fd7bcef..a0c7e13e0ab4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5558,7 +5558,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
 					i, btf_type_str(t));
 				return -EINVAL;
 			}
-			if (check_ctx_reg(env, reg, regno))
+			if (check_ptr_off_reg(env, reg, regno))
 				return -EINVAL;
 		} else if (is_kfunc && (reg->type == PTR_TO_BTF_ID ||
 			   (reg2btf_ids[base_type(reg->type)] && !type_flag(reg->type)))) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 008ddb694c8a..6fe805b559c0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3980,16 +3980,16 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
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
 
@@ -3997,7 +3997,8 @@ int check_ctx_reg(struct bpf_verifier_env *env,
 		char tn_buf[48];
 
 		tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
-		verbose(env, "variable ctx access var_off=%s disallowed\n", tn_buf);
+		verbose(env, "variable %s access var_off=%s disallowed\n",
+			reg_type_str(env, reg->type), tn_buf);
 		return -EACCES;
 	}
 
@@ -4447,7 +4448,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			return -EACCES;
 		}
 
-		err = check_ctx_reg(env, reg, regno);
+		err = check_ptr_off_reg(env, reg, regno);
 		if (err < 0)
 			return err;
 
@@ -5327,7 +5328,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		return err;
 
 	if (type == PTR_TO_CTX) {
-		err = check_ctx_reg(env, reg, regno);
+		err = check_ptr_off_reg(env, reg, regno);
 		if (err < 0)
 			return err;
 	}
@@ -9561,7 +9562,7 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 			return err;
 	}
 
-	err = check_ctx_reg(env, &regs[ctx_reg], ctx_reg);
+	err = check_ptr_off_reg(env, &regs[ctx_reg], ctx_reg);
 	if (err < 0)
 		return err;
 
-- 
2.44.0.769.g3c40516874-goog


