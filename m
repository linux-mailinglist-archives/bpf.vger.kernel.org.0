Return-Path: <bpf+bounces-73849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C07DC3B255
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 14:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCAA5638D6
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 12:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9A333EAFF;
	Thu,  6 Nov 2025 12:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3tRNzt2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52291339B41
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433629; cv=none; b=aKpWKBFVwmVpXOUsN0VQ2H5Pew7+THr4upq257s/JhrCeBFzv44ZpLBqIViutC3lfEkS2S9SyDlsSHIUGIb53a4kdypUsLlysUgXL3QZ0UqDmWO+VCNDE5PGoQXssrWd83rptmUVJ5cePLf+oMx6h81rwiScrJ8FKnwZ9wHwHus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433629; c=relaxed/simple;
	bh=Jcs/EeETuzWN7pCMx7VDBkqgjWPCz6UkIhKwoJ0gHSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TlWmBSIfPL3s3dQiOmzayx1PevR96lWgcwhruadBdTUgKg4TghGQIm40glVDDjm+ADYELKTrI7FlUhktUncgLF32lt9rxdgp9jKimbJJtQw0ZIksrOxkh4ExxZzPzqPX8+mpJqcVrw3ShCg8fzBNsnCEq5cLK7cP1PkSO81t0pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3tRNzt2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-421851bcb25so497923f8f.2
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 04:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762433624; x=1763038424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnAgtUMJwOc4rjloS+eD4txeDjMJcwa78KfLJ1BQCwk=;
        b=T3tRNzt2CcklvgVFhWCJRQ1ObimJMIlX6reRG8EyNtvkRNHuAro9XKbFY49hlY6KTd
         9Z8PiJcb4j7UDahr6GtH8bGozJSMrTOLyhvmyLrPIGQZYxNfvd4wkmykr/erV84L64rm
         aSqGl1Wkx5HeABBVEaw/6RDg6TF1pz1Q/Gw3dMxCI2adHnjE8mJnu8m7QjO7c3SaTgPK
         v8l3cVqNSxeOyasxd1iw7HKB++wL8bMVsimT6107f1pWBn/6mxTFyw6+iDIO3K4cdgZL
         yGt+Mtn/c6Pv9wOeUSNGfVKYXBuIE3Z/gsZEy03a7m/1l80J8iYYt7cpqUcoYXfOvQw8
         DM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762433624; x=1763038424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnAgtUMJwOc4rjloS+eD4txeDjMJcwa78KfLJ1BQCwk=;
        b=nnVhuFozziIlIchxMqinH6Y9CrGMQpYKBe/MCmGEpFA9uU7/nT7pGBli5IHTgD29+L
         l7+TprpGcKi8v3i8sY/lyTKpQHz5OH66yxVf0El+jqqa0Yyti8M8VaiP1W/5KxjbRDYP
         5q0i+oQwF0RvFa0sKXBJJaf/T8g5B10CK/QZJd7HPcrxGpgqy6IKs1VWQwkSTuct6g4z
         UAaqVGSsTUObolPt8yLu4AQSOniL6XU1yLC1QXXOxAAeMLKJe6WNyFJYj/CxbpyHwxMw
         NoXuRtxsrTyMpJgpNkdMACntAZs1it+Lpu0g7c4XJe/++EOVhpYXB0axzoX5O+4x/Szp
         kddw==
X-Gm-Message-State: AOJu0YzPAMAilSkp4rYjs9BeQKTr7EeSPL4Qvy0en1teMrpowV9zYfGb
	LxCXiaTCoaSkZuNi5DocWPwLyum/PjEWy/hiaezlHkYrz6ojA2+OjoNroh7W
X-Gm-Gg: ASbGncvIT1OMitqy5AmMvPixhDyevaN4X8U9s4s2NXfHZIEgtJys5u0vYtMgiSisN1l
	heRv05wgPt/KTb8RssUmVIUEIMd4ivQ5aCSToH3LnAihhaj686g7kfToqfJAhGEotcu6gwRJWM3
	XY+s/Lq10/ZkLBbLQG4sZxxMzUoOCxJEJUIW3t/X9x3VUdX5w57I/4/KkjybINLwx9jpVJsJ5MU
	119Pay29KY37MBGgPhzeMIhyW/nb6sVv93tj73tpObBqw3hkNwPReaKgtYH1r2y5FZwge43W1TY
	e/2n6FW2N6V90un0XgYzKyMhOxaehY+5EIiZNmUHdiaaIcI4MkM/uy1mNXI54Cf+0h6Y/8W+LwH
	PDZDj59OgQxxJ9+/e7xz64cxgim4B9vf+0o0rVx40Oo6MnKmEbplgQLdBCRzh0ajBwG1jZiuugV
	BvxEs4Ke9LWsvh441GOh6wqwCkcHF1G36FB/d/AWpLxd1rpjYN2EZu5Qg=
X-Google-Smtp-Source: AGHT+IHO9Y865RnKqwcQvNsaYqBCQdn4w1DxC2oH7NFH7f8XcVitcqMdXr6+EAIHeK9b0by1bRC/cQ==
X-Received: by 2002:a05:6000:220e:b0:3ee:d165:2edd with SMTP id ffacd0b85a97d-429e32f4852mr6104960f8f.28.1762433624020;
        Thu, 06 Nov 2025 04:53:44 -0800 (PST)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4788856f8f.9.2025.11.06.04.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 04:53:43 -0800 (PST)
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
Subject: [PATCH RFC 14/17] bpf: Add mem access bound refinement
Date: Thu,  6 Nov 2025 13:52:52 +0100
Message-Id: <20251106125255.1969938-15-hao.sun@inf.ethz.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
References: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement on-demand refinement for memory access bound checks and add 
fallback to path-unreachable when refinement is not applicable.

When common bound checks (stack/map/packet) fail (min/max outside bounds) or
certain helper memory checks fail with -EACCES, call into `bcf_refine()` to
prove either: (a) tighter bounds on pointer offset or size make the access
safe, or (b) the current path is unreachable. For -EACCES on other sites, try
path-unreachable directly (`bcf_prove_unreachable()`). If the same error point
is re-encountered under tracking, refinement is applied directly without a new
proof since they are known safe.

- __bcf_refine_access_bound():
  * const ptr + var size: prove `off + size_expr <= high` and refine size
    upper bound accordingly; the condition emitted is JGT, expects the
    solver to prove it unsat.
  * var ptr + const size: prove `fix_off + off_expr + sz <= high` and if needed,
    `off + off_expr >= low`; refine pointer smin/smax accordingly.
  * var ptr + var size: emit two constraints (sum <= high and ptr_off >= low),
    and if proved, treat the access as safe for range [smin, high) without
    changing either reg as the source of imprecision is unknown.
    Mark current state’s children as unsafe for pruning.

  * Split `check_mem_access()` into `do_check_mem_access()` and a wrapper that
    triggers path-unreachable on -EACCES when no request was made yet.
  * Wrap `check_helper_mem_access()` similarly and integrate `check_mem_size_reg()`
    with `access_checked` fast path to re-check a proven safe range by
    temporarily constraining the pointer reg.

Signed-off-by: Hao Sun <hao.sun@inf.ethz.ch>
---
 include/linux/bpf_verifier.h |   6 +
 kernel/bpf/verifier.c        | 262 +++++++++++++++++++++++++++++++++--
 2 files changed, 255 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 9b91353a86d7..05e8e3feea30 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -752,6 +752,12 @@ struct bcf_refine_state {
 	u32 br_cond_cnt;
 	int path_cond; /* conjunction of br_conds */
 	int refine_cond; /* refinement condition */
+
+	/* Refinement specific */
+	u32 size_regno;
+	int checked_off;
+	int checked_sz;
+	bool access_checked;
 };
 
 /* single container for all structs
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ec0e736f39c5..22a068bfd0f2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -621,6 +621,16 @@ static bool bcf_requested(const struct bpf_verifier_env *env)
 	return env->prog->aux->bcf_requested;
 }
 
+static void bcf_prove_unreachable(struct bpf_verifier_env *env)
+{
+	int err;
+
+	err = bcf_refine(env, env->cur_state, 0, NULL, NULL);
+	if (!err)
+		verbose(env,
+			"bcf requested, try to prove the path unreachable\n");
+}
+
 static void mark_bcf_requested(struct bpf_verifier_env *env)
 {
 	env->prog->aux->bcf_requested = true;
@@ -4088,8 +4098,12 @@ static int check_reg_arg(struct bpf_verifier_env *env, u32 regno,
 {
 	struct bpf_verifier_state *vstate = env->cur_state;
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
+	int err;
 
-	return __check_reg_arg(env, state->regs, regno, t);
+	err = __check_reg_arg(env, state->regs, regno, t);
+	if (err == -EACCES && !bcf_requested(env))
+		bcf_prove_unreachable(env);
+	return err;
 }
 
 static int insn_stack_access_flags(int frameno, int spi)
@@ -5256,6 +5270,163 @@ static bool __is_pointer_value(bool allow_ptr_leaks,
 	return reg->type != SCALAR_VALUE;
 }
 
+struct bcf_mem_access_refine_ctx {
+	struct bpf_reg_state *ptr_reg;
+	struct bpf_reg_state *size_reg;
+	s32 off;
+	s32 lower_bound;
+	s32 higher_bound;
+};
+
+static int __bcf_refine_access_bound(struct bpf_verifier_env *env,
+				     struct bpf_verifier_state *st,
+				     void *access)
+{
+	struct bcf_mem_access_refine_ctx *ctx = access;
+	struct bpf_reg_state *size_reg = ctx->size_reg, *ptr_reg = ctx->ptr_reg;
+	u32 mem_sz = ctx->higher_bound - ctx->lower_bound;
+	int size_expr, off_expr, low_expr, high_expr;
+	struct bcf_refine_state *bcf = &env->bcf;
+	s32 off = ctx->off;
+	s64 min_off, max_off;
+	bool bit32 = false;
+
+	off_expr = ptr_reg->bcf_expr;
+	size_expr = size_reg->bcf_expr;
+	if (fit_s32(ptr_reg) && fit_s32(size_reg)) {
+		off_expr = bcf_expr32(env, off_expr);
+		size_expr = bcf_expr32(env, size_expr);
+		bit32 = true;
+	}
+
+	min_off = ptr_reg->smin_value + off;
+	max_off = ptr_reg->smax_value + off;
+
+	if (tnum_is_const(ptr_reg->var_off)) { /* Refine the size range */
+		off += ptr_reg->var_off.value;
+
+		/* Prove `off + size > higher_bound` unsatisfiable */
+		bcf->refine_cond = bcf_add_pred(env, BPF_JGT, size_expr,
+						ctx->higher_bound - off, bit32);
+
+		/* size->umax + off <= higher holds after proof */
+		size_reg->umax_value = ctx->higher_bound - off;
+		size_reg->umin_value =
+			min_t(u64, size_reg->umax_value, size_reg->umin_value);
+		reg_bounds_sync(size_reg);
+
+	} else if (tnum_is_const(size_reg->var_off)) { /* Refine the ptr off */
+		u32 sz = size_reg->var_off.value;
+
+		/* Prove `off + off_expr + sz > higher_bound` unsatisfiable */
+		high_expr = bcf_add_pred(env, BPF_JSGT, off_expr,
+					 ctx->higher_bound - sz - off, bit32);
+		/*
+		 * If the verifier already knows the lower bound is safe, then
+		 * don't emit this in the formula.
+		 */
+		bcf->refine_cond = high_expr;
+		if (min_off < ctx->lower_bound) {
+			low_expr = bcf_add_pred(env, BPF_JSLT, off_expr,
+						ctx->lower_bound - off, bit32);
+			bcf->refine_cond =
+				bcf_build_expr(env, BCF_BOOL | BCF_DISJ, 0, 2,
+					       low_expr, high_expr);
+		}
+
+		if (min_off < ctx->lower_bound)
+			ptr_reg->smin_value = ctx->lower_bound - off;
+		if (max_off + sz > ctx->higher_bound)
+			ptr_reg->smax_value = ctx->higher_bound - off - sz;
+		reg_bounds_sync(ptr_reg);
+	} else { /* Prove var off with var size is safe */
+		u32 bitsz = bit32 ? 32 : 64;
+
+		high_expr = bcf_build_expr(env, BCF_BV | BPF_ADD, bitsz, 2,
+					   off_expr, size_expr);
+		high_expr = bcf_add_pred(env, BPF_JSGT, high_expr,
+					 ctx->higher_bound - off, bit32);
+		bcf->refine_cond = high_expr;
+		if (min_off < ctx->lower_bound) {
+			low_expr = bcf_add_pred(env, BPF_JSLT, off_expr,
+						ctx->lower_bound - off, bit32);
+			bcf->refine_cond =
+				bcf_build_expr(env, BCF_BOOL | BCF_DISJ, 0, 2,
+					       low_expr, high_expr);
+		}
+
+		if (min_off < ctx->lower_bound)
+			ptr_reg->smin_value = ctx->lower_bound - off;
+		if (max_off > ctx->higher_bound)
+			ptr_reg->smax_value = ctx->higher_bound - off;
+		if (size_reg->umax_value > mem_sz)
+			size_reg->umax_value = mem_sz;
+		reg_bounds_sync(ptr_reg);
+		reg_bounds_sync(size_reg);
+
+		/*
+		 * off+off_expr+sz_expr <= high && off+off_expr>=low proved,
+		 * but it's not clear which regs are the source of imprecision;
+		 * hence don't refine, but remember the access is safe and
+		 * treat this access as [smin, higher) range access.
+		 */
+		min_off = ptr_reg->smin_value + off;
+		bcf->checked_off = ptr_reg->smin_value;
+		bcf->checked_sz = ctx->higher_bound - min_off;
+		bcf->access_checked = true;
+		st->children_unsafe = true;
+	}
+
+	return bcf->refine_cond < 0 ? bcf->refine_cond : 0;
+}
+
+static void bcf_refine_access_bound(struct bpf_verifier_env *env, int regno,
+				    s32 off, s32 low, s32 high, u32 access_size)
+{
+	struct bcf_mem_access_refine_ctx ctx = {
+		.off = off,
+		.lower_bound = low,
+		.higher_bound = high,
+	};
+	struct bpf_reg_state *regs = cur_regs(env), tmp_reg;
+	struct bpf_reg_state *ptr_reg, *size_reg;
+	struct bcf_refine_state *bcf = &env->bcf;
+	u32 reg_masks = 0, mem_sz = high - low;
+	bool ptr_const, size_const;
+	s64 ptr_off;
+	int err;
+
+	ptr_reg = regs + regno;
+	ptr_const = tnum_is_const(ptr_reg->var_off);
+	if (!ptr_const)
+		reg_masks |= (1 << regno);
+
+	__mark_reg_known(&tmp_reg, access_size);
+	tmp_reg.type = SCALAR_VALUE;
+	size_reg = &tmp_reg;
+	if (bcf->size_regno > 0) {
+		size_reg = regs + bcf->size_regno;
+		if (!tnum_is_const(size_reg->var_off))
+			reg_masks |= (1 << bcf->size_regno);
+	}
+	size_const = tnum_is_const(size_reg->var_off);
+	ctx.size_reg = size_reg;
+	ctx.ptr_reg = ptr_reg;
+
+	/* Prove unreachable. */
+	ptr_off = ptr_reg->smin_value + off;
+	if (!reg_masks || !mem_sz ||
+	    (ptr_const && (ptr_off < low || ptr_off >= high)) ||
+	    (size_const && size_reg->var_off.value > mem_sz))
+		return bcf_prove_unreachable(env);
+
+	err = bcf_refine(env, env->cur_state, reg_masks,
+			 __bcf_refine_access_bound, &ctx);
+	if (!err)
+		verbose(env, "bcf requested, try to refine R%d access\n",
+			regno);
+}
+
 static void assign_scalar_id_before_mov(struct bpf_verifier_env *env,
 					struct bpf_reg_state *src_reg)
 {
@@ -6016,6 +6187,7 @@ static int check_mem_region_access(struct bpf_verifier_env *env, u32 regno,
 	if (err) {
 		verbose(env, "R%d min value is outside of the allowed memory range\n",
 			regno);
+		bcf_refine_access_bound(env, regno, off, 0, mem_size, size);
 		return err;
 	}
 
@@ -6033,6 +6205,7 @@ static int check_mem_region_access(struct bpf_verifier_env *env, u32 regno,
 	if (err) {
 		verbose(env, "R%d max value is outside of the allowed memory range\n",
 			regno);
+		bcf_refine_access_bound(env, regno, off, 0, mem_size, size);
 		return err;
 	}
 
@@ -7680,6 +7853,15 @@ static int check_ptr_to_map_access(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int stack_min_off(struct bpf_verifier_env *env, struct bpf_func_state *state,
+			 enum bpf_access_type t)
+{
+	if (t == BPF_WRITE || env->allow_uninit_stack)
+		return -MAX_BPF_STACK;
+	else
+		return -state->allocated_stack;
+}
+
 /* Check that the stack access at the given offset is within bounds. The
  * maximum valid offset is -1.
  *
@@ -7693,11 +7875,7 @@ static int check_stack_slot_within_bounds(struct bpf_verifier_env *env,
 {
 	int min_valid_off;
 
-	if (t == BPF_WRITE || env->allow_uninit_stack)
-		min_valid_off = -MAX_BPF_STACK;
-	else
-		min_valid_off = -state->allocated_stack;
-
+	min_valid_off = stack_min_off(env, state, t);
 	if (off < min_valid_off || off > -1)
 		return -EACCES;
 	return 0;
@@ -7759,6 +7937,11 @@ static int check_stack_access_within_bounds(
 			verbose(env, "invalid variable-offset%s stack R%d var_off=%s off=%d size=%d\n",
 				err_extra, regno, tn_buf, off, access_size);
 		}
+
+		if (err != -EFAULT)
+			bcf_refine_access_bound(env, regno, off,
+						stack_min_off(env, state, type),
+						0, access_size);
 		return err;
 	}
 
@@ -7785,7 +7968,7 @@ static bool get_func_retval_range(struct bpf_prog *prog,
  * if t==write && value_regno==-1, some unknown value is stored into memory
  * if t==read && value_regno==-1, don't care what we read from memory
  */
-static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regno,
+static int do_check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regno,
 			    int off, int bpf_size, enum bpf_access_type t,
 			    int value_regno, bool strict_alignment_once, bool is_ldsx)
 {
@@ -8045,6 +8228,20 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 	return err;
 }
 
+static int check_mem_access(struct bpf_verifier_env *env, int insn_idx,
+			    u32 regno, int off, int bpf_size,
+			    enum bpf_access_type t, int value_regno,
+			    bool strict_alignment_once, bool is_ldsx)
+{
+	int err;
+
+	err = do_check_mem_access(env, insn_idx, regno, off, bpf_size, t,
+			       value_regno, strict_alignment_once, is_ldsx);
+	if (err == -EACCES && !bcf_requested(env))
+		bcf_prove_unreachable(env);
+	return err;
+}
+
 static int save_aux_ptr_type(struct bpf_verifier_env *env, enum bpf_reg_type type,
 			     bool allow_trust_mismatch);
 
@@ -8427,7 +8624,7 @@ static int check_stack_range_initialized(
 	return 0;
 }
 
-static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
+static int __check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 				   int access_size, enum bpf_access_type access_type,
 				   bool zero_size_allowed,
 				   struct bpf_call_arg_meta *meta)
@@ -8518,6 +8715,21 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 	}
 }
 
+static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
+				   int access_size,
+				   enum bpf_access_type access_type,
+				   bool zero_size_allowed,
+				   struct bpf_call_arg_meta *meta)
+{
+	int err;
+
+	err = __check_helper_mem_access(env, regno, access_size, access_type,
+					zero_size_allowed, meta);
+	if (err == -EACCES && !bcf_requested(env))
+		bcf_prove_unreachable(env);
+	return err;
+}
+
 /* verify arguments to helpers or kfuncs consisting of a pointer and an access
  * size.
  *
@@ -8530,6 +8742,7 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 			      bool zero_size_allowed,
 			      struct bpf_call_arg_meta *meta)
 {
+	struct bcf_refine_state *bcf = &env->bcf;
 	int err;
 
 	/* This is used to refine r0 return value bounds for helpers
@@ -8553,22 +8766,40 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
 	if (reg->smin_value < 0) {
 		verbose(env, "R%d min value is negative, either use unsigned or 'var &= const'\n",
 			regno);
+		bcf_prove_unreachable(env);
 		return -EACCES;
 	}
 
 	if (reg->umin_value == 0 && !zero_size_allowed) {
 		verbose(env, "R%d invalid zero-sized read: u64=[%lld,%lld]\n",
 			regno, reg->umin_value, reg->umax_value);
+		bcf_prove_unreachable(env);
 		return -EACCES;
 	}
 
 	if (reg->umax_value >= BPF_MAX_VAR_SIZ) {
 		verbose(env, "R%d unbounded memory access, use 'var &= const' or 'if (var < const)'\n",
 			regno);
+		bcf_prove_unreachable(env);
 		return -EACCES;
 	}
-	err = check_helper_mem_access(env, regno - 1, reg->umax_value,
+
+	if (bcf->access_checked) {
+		struct bpf_reg_state *ptr_reg = &cur_regs(env)[regno - 1];
+		struct bpf_reg_state tmp = *ptr_reg;
+
+		___mark_reg_known(ptr_reg, bcf->checked_off);
+		err = check_helper_mem_access(env, regno - 1, bcf->checked_sz,
+					      access_type, zero_size_allowed, meta);
+		*ptr_reg = tmp;
+		bcf->access_checked = false;
+	} else {
+		bcf->size_regno = regno;
+		err = check_helper_mem_access(env, regno - 1, reg->umax_value,
 				      access_type, zero_size_allowed, meta);
+		bcf->size_regno = 0;
+	}
+
 	if (!err)
 		err = mark_chain_precision(env, regno);
 	return err;
@@ -16367,8 +16598,11 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 		/* check dest operand */
 		err = check_reg_arg(env, insn->dst_reg, DST_OP_NO_MARK);
 		err = err ?: adjust_reg_min_max_vals(env, insn);
-		if (err)
+		if (err) {
+			if (!bcf_requested(env))
+				bcf_prove_unreachable(env);
 			return err;
+		}
 	}
 
 	return reg_bounds_sanity_check(env, &regs[insn->dst_reg], "alu");
@@ -20474,6 +20708,8 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
 			} else {
 				err = check_helper_call(env, insn, &env->insn_idx);
 			}
+			if (err == -EACCES && !bcf_requested(env))
+				bcf_prove_unreachable(env);
 			if (err)
 				return err;
 
@@ -24224,9 +24460,9 @@ backtrack_states(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
 	return base;
 }
 
-static int __used bcf_refine(struct bpf_verifier_env *env,
-			     struct bpf_verifier_state *st, u32 reg_masks,
-			     refine_state_fn refine_cb, void *ctx)
+static int bcf_refine(struct bpf_verifier_env *env,
+		      struct bpf_verifier_state *st, u32 reg_masks,
+		      refine_state_fn refine_cb, void *ctx)
 {
 	struct bpf_reg_state *regs = st->frame[st->curframe]->regs;
 	struct bcf_refine_state *bcf = &env->bcf;
-- 
2.34.1


