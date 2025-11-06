Return-Path: <bpf+bounces-73842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3B1C3B1FB
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 14:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B184229EE
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 12:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0876A339709;
	Thu,  6 Nov 2025 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2KG0TNH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABA4336EE3
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433625; cv=none; b=MaJ76YGg1rB+gqxd+U7nwTQzJsB/7RPZG4hNO+tel+gJRQUU0BUmbbNwOwg9osACtDDDbxOrD5rJvGLoVWLEJP9wSsi9k54zSPKuhEwbNg86kdPmHX6RpUq9ElGezGIqTe0ftQbMYHJbZ6t1C2rq+Kgp12zqF5qyLz4W1A51p0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433625; c=relaxed/simple;
	bh=gYI3PPdY/pxVI3TQMaLHa1tG9D9Q3pX163qPj6Y+5JI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kKePRtJFC2JdXRov73R3upbfs/dMJa8ddlW44nUjRruZ1006Vd5Ovh6PRBn/dNQokwK+3JDVUJh0iOM3VowrVop7v8VPaiMLYf40Bv/LdtXcrNAEsNdBiK/dMzdcxGKj+vf+pItnJ70QNmVX7YIqaK2UHzz0I24BaDKEVnp3gDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2KG0TNH; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42421b1514fso516576f8f.2
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 04:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762433620; x=1763038420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vW1pnqHWzKhRlujJQJ97tr37TfsN4Lo7m0CG+Gl/ro=;
        b=X2KG0TNHHBut73oYurbxKGyoBsCoxsWO0/djDjSJhUdgXanM0xsOGO3BA5PG5pNDVA
         i3UE5jWSPa0Q5y1za81R29fj/1WP+u8gidGRtxUz/c9diDzPTtuAFMyy7utdW4gjusiD
         rI5Hl1KU2s4i67tn1sO7GoCpB/rNpLoQQyQfbn+ZlkC37kaT5RNjmhobqcb+y08JuUes
         Yi4xcnZwHP2EGbUU+Gwe4HPf+lk7dfmmAITRJJtv1gFXJJNProD694zx0pwKQAaEctfg
         I/Bu7hBIrgWRmSw21STgBleUqLpwJ9O4ITxaQDcpAykyTW2KTfN2v9a8JMMoRwaR4kKC
         5PBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762433620; x=1763038420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8vW1pnqHWzKhRlujJQJ97tr37TfsN4Lo7m0CG+Gl/ro=;
        b=nIMxj3xXlK+b7eokCi0ycENoHpmY0q2lPIzh/g3ly57Cs1GK+zicJ81OxigM7ZvVM5
         ZKILMR5VQ7lHkiLBAfZJYGYQ/B5lpRg2sspTqkLlRdyJUjENXdAlJh+R7+mYb/e9CNpT
         dX51FreSI2AwDjPjGpDlKsHKn169AyyNv0QGXgx5LDi6K3gynn/2wkoJGMF+pMX/d06Y
         SVOL/TwZEPM70cKKuBlNT+LTU3472k8p9hCjzLusX1sa0d0JMlC6jIi5zlZ6OqMTbx54
         N4reMoBSW8mZ3BB/NJcRsk7hxrp9mL3OLNXGfXTiNxYCJeqBZ70K1PPYM61p9poEobLn
         L/SA==
X-Gm-Message-State: AOJu0YwcJiomK9hyGZdb5rRMBHit5VFKwCF3SijgIJQgL491wfAkxIEU
	AF5M3rvKTbaJVHPc4ZsXxXMOMjt3/NaMRxdcZ1Q2xpmAeRWRCZvqTHyfVV/Y
X-Gm-Gg: ASbGncuRjdc9EXtGGlhFMB6AZU49+NigYJZF5gHrhZosRGtj6j8cjZ+YERED//G90xf
	hxr1qjZ8ZebbcwwXZ+i5dGvFu5bMvWbeuN6UtA9k4vRtn+9v8o0t1lZ0HH6joHzKN8l97GTu5Wv
	FX9ORI/t5Mi63sybpBe0njXvRk3cZv0M3nRigozso3/nz0UXFIbOZxl6LEflt2cup8KSMf+Xdyy
	OMQ8hRvJmTc+UGclwrQ6kT/AXAdbhBxLaVOc7YwPpbk9WL/v0h/FL1z5eTq3ueO+zzeEq0PcGJ/
	7O2huX1tt2mBH9gl9KzkmII1JD/EfMc5OKyE+OZXdVLbQLITJQSP9UFsVbpVYn63WZn2U1J9QXx
	UkdHVrokv/eYA9Nf2J5SMisob2W5VjtiSEonDoXkZVq41Ritfpe5JffCG40jNpdQGwpKsFfTVNa
	dWsXym7iomt2etPf+H/ykGfvTZ4Jdpcwg7a13pjqf86lpoAaw7g7PzddY=
X-Google-Smtp-Source: AGHT+IF67KTAG0Z+EcRSvv3TCoZ31iPTiYggpF50xcRnauZWBkj9PGoXZ+O8tYHDr6SE2qfIi6fvvw==
X-Received: by 2002:a05:6000:3101:b0:429:8cda:dd4e with SMTP id ffacd0b85a97d-429e33079fbmr6395601f8f.32.1762433619927;
        Thu, 06 Nov 2025 04:53:39 -0800 (PST)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4788856f8f.9.2025.11.06.04.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 04:53:39 -0800 (PST)
From: Hao Sun <sunhao.th@gmail.com>
X-Google-Original-From: Hao Sun <hao.sun@inf.ethz.ch>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	linux-kernel@vger.kernel.org,
	sunhao.th@gmail.com,
	Hao Sun <hao.sun@inf.ethz.ch>
Subject: [PATCH RFC 07/17] bpf: Add bcf_expr management and binding
Date: Thu,  6 Nov 2025 13:52:45 +0100
Message-Id: <20251106125255.1969938-8-hao.sun@inf.ethz.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
References: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add expression arena management for BCF tracking and lazy binding of symbolic
expressions to registers during `bcf_track()`.

- Arena management: `bcf_alloc_expr()` grows `env->bcf.exprs` with
  reallocation in chunks; `bcf_add_expr()` copies a built node; `bcf_build_expr()`
  constructs nodes with varargs.

- Predicates/constraints: `bcf_add_pred()` creates boolean comparisons with an
  immediate RHS; `bcf_add_cond()` appends branch-condition ids into
  `env->bcf.br_conds`.

- Lazy binding: `reg->bcf_expr` starts at -1 and is set on first use via
  `bcf_reg_expr()`. Binding leverages existing range info: if a reg fits in
  u32/s32 ranges, allocate a 32-bit var, add range constraints (u/s min/max),
  then extend to 64-bit with zero/sign extension; otherwise allocate a 64-bit
  var and emit 64-bit bounds. `__check_reg_arg()` binds on first read when
  tracking.

This allows later instruction-specific tracking to refer to previously bound
register expressions and accumulate path constraints.

Signed-off-by: Hao Sun <hao.sun@inf.ethz.ch>
---
 kernel/bpf/verifier.c | 280 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 280 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3ecee219605f..7b6d509c773a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2018 Covalent IO, Inc. http://covalent.io
  */
 #include <uapi/linux/btf.h>
+#include <uapi/linux/bcf.h>
 #include <linux/bpf-cgroup.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -625,6 +626,275 @@ static void mark_bcf_requested(struct bpf_verifier_env *env)
 	env->prog->aux->bcf_requested = true;
 }
 
+static int bcf_alloc_expr(struct bpf_verifier_env *env, u32 cnt)
+{
+	struct bcf_refine_state *bcf = &env->bcf;
+	int idx = bcf->expr_cnt;
+	struct bcf_expr *exprs;
+	u32 size, alloc_cnt;
+
+	bcf->expr_cnt += cnt;
+	if (bcf->expr_cnt <= bcf->expr_size)
+		return idx;
+
+	alloc_cnt = max_t(u32, 256, cnt);
+	size = size_mul(bcf->expr_size + alloc_cnt, sizeof(struct bcf_expr));
+	exprs = kvrealloc(bcf->exprs, size, GFP_KERNEL_ACCOUNT);
+	if (!exprs) {
+		kvfree(bcf->exprs);
+		bcf->exprs = NULL;
+		return -ENOMEM;
+	}
+	bcf->exprs = exprs;
+	bcf->expr_size += alloc_cnt;
+
+	return idx;
+}
+
+static int bcf_add_expr(struct bpf_verifier_env *env, struct bcf_expr *expr)
+{
+	u32 cnt = (u32)expr->vlen + 1;
+	int idx;
+
+	idx = bcf_alloc_expr(env, cnt);
+	if (idx >= 0)
+		memcpy(env->bcf.exprs + idx, expr,
+		       sizeof(struct bcf_expr) * cnt);
+	return idx;
+}
+
+static int bcf_build_expr(struct bpf_verifier_env *env, u8 code, u16 params,
+			  u32 vlen, ...)
+{
+	DEFINE_RAW_FLEX(struct bcf_expr, expr, args, U8_MAX);
+	va_list args;
+	u32 i;
+
+	if (vlen > U8_MAX)
+		return -EFAULT;
+
+	expr->code = code;
+	expr->vlen = vlen;
+	expr->params = params;
+
+	va_start(args, vlen);
+	for (i = 0; i < vlen; i++) {
+		int arg = va_arg(args, int);
+
+		if (arg < 0)
+			return arg;
+		expr->args[i] = arg;
+	}
+	return bcf_add_expr(env, expr);
+}
+
+static int bcf_add_cond(struct bpf_verifier_env *env, int expr)
+{
+	struct bcf_refine_state *bcf = &env->bcf;
+	u32 cnt = bcf->br_cond_cnt;
+	size_t size;
+	u32 *conds;
+
+	if (expr < 0)
+		return expr;
+	if (cnt >= U8_MAX)
+		return -E2BIG;
+
+	cnt++;
+	size = kmalloc_size_roundup(cnt * sizeof(u32));
+	conds = krealloc(bcf->br_conds, size, GFP_KERNEL_ACCOUNT);
+	if (!conds) {
+		kfree(bcf->br_conds);
+		bcf->br_conds = NULL;
+		return -ENOMEM;
+	}
+	bcf->br_conds = conds;
+	conds[bcf->br_cond_cnt++] = expr;
+	return 0;
+}
+
+static int bcf_val(struct bpf_verifier_env *env, u64 val, bool bit32)
+{
+	DEFINE_RAW_FLEX(struct bcf_expr, expr, args, 2);
+
+	expr->code = BCF_BV | BCF_VAL;
+	expr->vlen = bit32 ? 1 : 2;
+	expr->params = bit32 ? 32 : 64;
+	expr->args[0] = val;
+	if (!bit32)
+		expr->args[1] = val >> 32;
+	return bcf_add_expr(env, expr);
+}
+
+static int bcf_var(struct bpf_verifier_env *env, bool bit32)
+{
+	return bcf_build_expr(env, BCF_BV | BCF_VAR, bit32 ? 32 : 64, 0);
+}
+
+static int bcf_extend(struct bpf_verifier_env *env, u16 ext_sz, u16 bit_sz,
+		      bool sign_ext, int expr)
+{
+	u8 op = sign_ext ? BCF_SIGN_EXTEND : BCF_ZERO_EXTEND;
+
+	return bcf_build_expr(env, BCF_BV | op, (ext_sz << 8) | bit_sz, 1,
+			      expr);
+}
+
+static int bcf_extract(struct bpf_verifier_env *env, u16 sz, int expr)
+{
+	return bcf_build_expr(env, BCF_BV | BCF_EXTRACT, (sz - 1) << 8, 1,
+			      expr);
+}
+
+static int bcf_zext_32_to_64(struct bpf_verifier_env *env,
+			     struct bpf_reg_state *reg)
+{
+	reg->bcf_expr = bcf_extend(env, 32, 64, false, reg->bcf_expr);
+	return reg->bcf_expr;
+}
+
+static int bcf_sext_32_to_64(struct bpf_verifier_env *env,
+			     struct bpf_reg_state *reg)
+{
+	reg->bcf_expr = bcf_extend(env, 32, 64, true, reg->bcf_expr);
+	return reg->bcf_expr;
+}
+
+static bool is_zext_32_to_64(struct bcf_expr *expr)
+{
+	return expr->code == (BCF_BV | BCF_ZERO_EXTEND) &&
+	       expr->params == (((u16)32 << 8) | 64);
+}
+
+static bool is_sext_32_to_64(struct bcf_expr *expr)
+{
+	return expr->code == (BCF_BV | BCF_SIGN_EXTEND) &&
+	       expr->params == (((u16)32 << 8) | 64);
+}
+
+static int bcf_expr32(struct bpf_verifier_env *env, int expr_idx)
+{
+	struct bcf_expr *expr;
+
+	if (expr_idx < 0)
+		return expr_idx;
+
+	expr = env->bcf.exprs + expr_idx;
+	if (is_zext_32_to_64(expr) || is_sext_32_to_64(expr))
+		return expr->args[0];
+
+	if (expr->code == (BCF_BV | BCF_VAL))
+		return bcf_val(env, expr->args[0], true);
+
+	return bcf_extract(env, 32, expr_idx);
+}
+
+static int bcf_add_pred(struct bpf_verifier_env *env, u8 op, int lhs, u64 imm,
+			bool bit32)
+{
+	int rhs;
+
+	if (lhs < 0)
+		return lhs;
+
+	rhs = bcf_val(env, imm, bit32);
+	return bcf_build_expr(env, BCF_BOOL | op, 0, 2, lhs, rhs);
+}
+
+static bool fit_u32(struct bpf_reg_state *reg)
+{
+	return reg->umin_value == reg->u32_min_value &&
+	       reg->umax_value == reg->u32_max_value;
+}
+
+static bool fit_s32(struct bpf_reg_state *reg)
+{
+	return reg->smin_value == reg->s32_min_value &&
+	       reg->smax_value == reg->s32_max_value;
+}
+
+static int __bcf_bound_reg(struct bpf_verifier_env *env, int op, int expr,
+			   u64 imm, bool bit32)
+{
+	return bcf_add_cond(env, bcf_add_pred(env, op, expr, imm, bit32));
+}
+
+static int bcf_bound_reg32(struct bpf_verifier_env *env,
+			   struct bpf_reg_state *reg)
+{
+	u32 umin = reg->u32_min_value, umax = reg->u32_max_value;
+	s32 smin = reg->s32_min_value, smax = reg->s32_max_value;
+	int expr = reg->bcf_expr;
+	int ret = 0;
+
+	if (umin != 0)
+		ret = __bcf_bound_reg(env, BPF_JGE, expr, umin, true);
+	if (ret >= 0 && umax != U32_MAX)
+		ret = __bcf_bound_reg(env, BPF_JLE, expr, umax, true);
+
+	if (ret >= 0 && smin != S32_MIN && smin != umin)
+		ret = __bcf_bound_reg(env, BPF_JSGE, expr, smin, true);
+	if (ret >= 0 && smax != S32_MAX && smax != umax)
+		ret = __bcf_bound_reg(env, BPF_JSLE, expr, smax, true);
+
+	return ret;
+}
+
+static int bcf_bound_reg(struct bpf_verifier_env *env,
+			 struct bpf_reg_state *reg)
+{
+	u64 umin = reg->umin_value, umax = reg->umax_value;
+	s64 smin = reg->smin_value, smax = reg->smax_value;
+	int expr = reg->bcf_expr;
+	int ret = 0;
+
+	if (umin != 0)
+		ret = __bcf_bound_reg(env, BPF_JGE, expr, umin, false);
+	if (ret >= 0 && umax != U64_MAX)
+		ret = __bcf_bound_reg(env, BPF_JLE, expr, umax, false);
+
+	if (ret >= 0 && smin != S64_MIN && smin != umin)
+		ret = __bcf_bound_reg(env, BPF_JSGE, expr, smin, false);
+	if (ret >= 0 && smax != S64_MAX && smax != umax)
+		ret = __bcf_bound_reg(env, BPF_JSLE, expr, smax, false);
+
+	return ret;
+}
+
+static int bcf_reg_expr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+			bool subreg)
+{
+	int err;
+
+	if (reg->bcf_expr >= 0)
+		goto out;
+
+	if (tnum_is_const(reg->var_off)) {
+		reg->bcf_expr = bcf_val(env, reg->var_off.value, false);
+	} else if (fit_u32(reg)) {
+		reg->bcf_expr = bcf_var(env, true);
+		err = bcf_bound_reg32(env, reg);
+		if (err < 0)
+			return err;
+		bcf_zext_32_to_64(env, reg);
+	} else if (fit_s32(reg)) {
+		reg->bcf_expr = bcf_var(env, true);
+		err = bcf_bound_reg32(env, reg);
+		if (err < 0)
+			return err;
+		bcf_sext_32_to_64(env, reg);
+	} else {
+		reg->bcf_expr = bcf_var(env, false);
+		err = bcf_bound_reg(env, reg);
+		if (err < 0)
+			return err;
+	}
+out:
+	if (!subreg)
+		return reg->bcf_expr;
+	return bcf_expr32(env, reg->bcf_expr);
+}
+
 static int __get_spi(s32 off)
 {
 	return (-off - 1) / BPF_REG_SIZE;
@@ -2187,6 +2457,8 @@ static void ___mark_reg_known(struct bpf_reg_state *reg, u64 imm)
 	reg->s32_max_value = (s32)imm;
 	reg->u32_min_value = (u32)imm;
 	reg->u32_max_value = (u32)imm;
+
+	reg->bcf_expr = -1;
 }
 
 /* Mark the unknown part of a register (variable offset or scalar value) as
@@ -2807,6 +3079,7 @@ static void __mark_reg_unknown_imprecise(struct bpf_reg_state *reg)
 	reg->var_off = tnum_unknown;
 	reg->frameno = 0;
 	reg->precise = false;
+	reg->bcf_expr = -1;
 	__mark_reg_unbounded(reg);
 }
 
@@ -3790,6 +4063,12 @@ static int __check_reg_arg(struct bpf_verifier_env *env, struct bpf_reg_state *r
 		if (rw64)
 			mark_insn_zext(env, reg);
 
+		/* Bind an expr for non-constants when it's first used. */
+		if (env->bcf.tracking && !tnum_is_const(reg->var_off)) {
+			bcf_reg_expr(env, reg, false);
+			if (reg->bcf_expr < 0)
+				return reg->bcf_expr;
+		}
 		return 0;
 	} else {
 		/* check whether register used as dest operand can be written to */
@@ -25244,6 +25523,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	kvfree(env->cfg.insn_postorder);
 	kvfree(env->scc_info);
 	kvfree(env->succ);
+	kvfree(env->bcf.exprs);
 	kvfree(env);
 	return ret;
 }
-- 
2.34.1


