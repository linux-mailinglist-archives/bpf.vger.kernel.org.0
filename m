Return-Path: <bpf+bounces-73844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB57C3B0F0
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 14:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25DA41889DFD
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 12:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C231333A011;
	Thu,  6 Nov 2025 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9pv/ail"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65322333737
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 12:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433626; cv=none; b=hNUH6pImtJOEPEvpwt49gy++h4rGnsZMVzgdhkkMsGIKp1lS9JvGIY/LzfxZnJ6lopZruEF15ci1Qn14RCola3dGSBaBSN6l3uBEvjMGue0kFwlV1INeYgsoU3j+dYDKPxcsZ+RqtFyMFL5jNK9ni+rgS/vAcqMc7VdLp65cOys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433626; c=relaxed/simple;
	bh=+3bu+o7yrXof/2MI+bET1ey025h5hY27tO76ys+rXo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mgIFSwQL36qIamBsFGfGETL85DAjsbMH9+R2l+Qd3aZIYPD71IGKNDVKRzKWs6w/tzN5VBw4On+2FakhR3j8cQU5Qdw2IU5Mo/nsx00PNJCDp2Klmg/+7BDMiEnFJXT4DAu0JfpoKhvJS0MiJFj8GqYe8n0a665alCpWPPaCPLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9pv/ail; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-427007b1fe5so603153f8f.1
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 04:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762433621; x=1763038421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgIvWdywaJTgIXUxCBq7xXfTtWMf1izHesmgmA/pMTw=;
        b=P9pv/ail5t9GJeLjOLMdRswZwIyt/H58+iG9PAic1EBwaU4MhQTR7Hey5cMYdgNHic
         qlgSvkuFxBNNX0IIYGza3rMcqE/wXdIR3HiIhnbzTmWmqLkA4ZRRjho8eCg2+XLCowGN
         tCmmJ5uZ6JQ294ZpN5c8IGpUovVMKAKgo2Jtzh7h1UUBrNOyloAqNgm1NdYVbjJWyAYH
         d6vO8pPi8+JNuYDqNX0od5TFvZG41hvbEQFmTaL27opZso69yHsFxTjWezRmi1l8I0OP
         NZmCj6I1lHnk5Vt69edm3can3A7ihsgl9t1aGCw5ErLn8fGZJsl1Eq0xTNuGbAGOAwkh
         Gfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762433621; x=1763038421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SgIvWdywaJTgIXUxCBq7xXfTtWMf1izHesmgmA/pMTw=;
        b=HqNPKOyU8m7Q16KAsOHVMR+IQOWrQ6E/DVjLjOCtpexOkAGOGVQWVS+PXeXuz40Dh9
         ZGuiR2ICFE0N8i7zQIfnBDvM4jrQwYhuXvIrC6oKIbs7OQgsqloR9FTyai8TYcw7s8rU
         dpCAMQzWW37TiVdkXffr+UWTB3nVovTP0I0eiy3EQx55ugUYtA6WxDMsf2P+5Xu55SlX
         lukNfJ9hqMAUXDrxVfiNhJGjYPqajtJK+YNfVofqBJC58Ts5k9VEJiZEzdtulgnJ78C3
         Zwkw9GPE9V1N3QCLUuiYCO/Hdxr/L5pzcB1RcEbqDN0W8rJB5zLdEM06D3ij9TZ7oWCz
         yPng==
X-Gm-Message-State: AOJu0YwO2UuVNoIdX+2cjHgQRLLxuFoWy4sFDfYUoMnWf1VorvfAapfx
	RsQg6GmxtS9I1UX/bGPaxzXj1rFtCK9icrLgt0QQ3hXaIFf569+KcHFc8q5W
X-Gm-Gg: ASbGncvoZNlypaJ3ls+p9S+Av94+ssruOa6jY9TngbQ8aIUDnUKkV3lgaaBBJjAHRvF
	HCcA3LelLZwrZcxy5AvKl2faF3WC4okyk8BjUBQNdhzcv1OxPN15Ic9f7ewbRGQyqQnFcdCvqVh
	aaFK/dk9mV2tPRljiDj8l1nw6s6VjDQo5PRx1bopnVgVjeFkQoj1Iz7CEuYX5GoCzMUaaQeQx93
	UKVIg7Af2D+ugpFbofEZNYaBgqkOQWgv7QS2KZqfG6MfPHki6/o+x8zQoP7Y0m1aoB2zQPLMFqG
	YzPZcpOU0FHc221u3EmNmv+OFpDA3SzuFC/wy1XQzGFTRJOuA7jbyjWPHsgGdBo/81evOrTVrKx
	cIuI1X5fHV09SbY3QxLj63fo2AuI85zrJNWueqJ2MMY2iWUMp1XxcdYDGsQ53ztUQd9Mm1F7fOZ
	rgDpYjRHIGfFYZretgE7uU5VwYfqKQUeWTn55mCnfg+AO8r/Ek4TYyQIc=
X-Google-Smtp-Source: AGHT+IGl6C6kdPOlCbRiSJYBIio8cezmiils5dPZ8ddwCv4SAqIpv33ItVTQPophXlCcShFEyPG7Bw==
X-Received: by 2002:a05:6000:210c:b0:3e1:2d70:673e with SMTP id ffacd0b85a97d-429e3308422mr4649504f8f.37.1762433621174;
        Thu, 06 Nov 2025 04:53:41 -0800 (PST)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4788856f8f.9.2025.11.06.04.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 04:53:40 -0800 (PST)
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
Subject: [PATCH RFC 09/17] bpf: Track alu operations in bcf_track()
Date: Thu,  6 Nov 2025 13:52:47 +0100
Message-Id: <20251106125255.1969938-10-hao.sun@inf.ethz.ch>
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

Model scalar and pointer ALU operations in the symbolic tracking.

- Scalar ALU: when either operand is non-constant, lazily bind `dst_reg` to a
  symbolic expr and emit the BV op; If both operands are constants, rely on
  the verifier’s result and skip emitting a symbolic node.
  Achieved by hooking `adjust_scalar_min_max_vals()`,

- Pointer ALU: follow verifier logic in `adjust_ptr_min_max_vals()` and record
  only the variable part into `dst_reg->bcf_expr`, carrying constants in
  `reg->off`.

Signed-off-by: Hao Sun <hao.sun@inf.ethz.ch>
---
 kernel/bpf/verifier.c | 80 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 76 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4491d665cc49..66682d365e5e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14865,6 +14865,41 @@ static int sanitize_check_bounds(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int bcf_alu(struct bpf_verifier_env *env, struct bpf_reg_state *dst_reg,
+		   struct bpf_reg_state *src_reg, u8 op, bool alu32)
+{
+	DEFINE_RAW_FLEX(struct bcf_expr, alu_expr, args, 2);
+	bool unary = (op == BPF_NEG);
+	int dst, src = 0, bits;
+
+	if (!env->bcf.tracking)
+		return 0;
+	if (tnum_is_const(dst_reg->var_off)) {
+		dst_reg->bcf_expr = -1;
+		return 0;
+	}
+
+	dst = bcf_reg_expr(env, dst_reg, alu32);
+	if (!unary)
+		src = bcf_reg_expr(env, src_reg, alu32);
+	if (dst < 0 || src < 0)
+		return -ENOMEM;
+
+	bits = alu32 ? 32 : 64;
+	alu_expr->code = BCF_BV | op;
+	alu_expr->vlen = unary ? 1 : 2;
+	alu_expr->params = bits;
+	alu_expr->args[0] = dst;
+	alu_expr->args[1] = src;
+	dst_reg->bcf_expr = bcf_add_expr(env, alu_expr);
+	if (alu32)
+		bcf_zext_32_to_64(env, dst_reg);
+	if (dst_reg->bcf_expr < 0)
+		return dst_reg->bcf_expr;
+
+	return 0;
+}
+
 /* Handles arithmetic on a pointer and a scalar: computes new min/max and var_off.
  * Caller should also handle BPF_MOV case separately.
  * If we return -EACCES, caller may want to try again treating pointer as a
@@ -14872,12 +14907,12 @@ static int sanitize_check_bounds(struct bpf_verifier_env *env,
  */
 static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 				   struct bpf_insn *insn,
-				   const struct bpf_reg_state *ptr_reg,
-				   const struct bpf_reg_state *off_reg)
+				   struct bpf_reg_state *ptr_reg,
+				   struct bpf_reg_state *off_reg)
 {
 	struct bpf_verifier_state *vstate = env->cur_state;
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
-	struct bpf_reg_state *regs = state->regs, *dst_reg;
+	struct bpf_reg_state *regs = state->regs, *dst_reg, *src_reg;
 	bool known = tnum_is_const(off_reg->var_off);
 	s64 smin_val = off_reg->smin_value, smax_val = off_reg->smax_value,
 	    smin_ptr = ptr_reg->smin_value, smax_ptr = ptr_reg->smax_value;
@@ -14889,6 +14924,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	int ret, bounds_ret;
 
 	dst_reg = &regs[dst];
+	src_reg = dst_reg == ptr_reg ? off_reg : ptr_reg;
 
 	if ((known && (smin_val != smax_val || umin_val != umax_val)) ||
 	    smin_val > smax_val || umin_val > umax_val) {
@@ -14989,8 +15025,15 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 			dst_reg->var_off = ptr_reg->var_off;
 			dst_reg->off = ptr_reg->off + smin_val;
 			dst_reg->raw = ptr_reg->raw;
+			dst_reg->bcf_expr = ptr_reg->bcf_expr;
 			break;
 		}
+
+		if (env->bcf.tracking) {
+			bcf_reg_expr(env, dst_reg, false);
+			if (dst_reg->bcf_expr < 0)
+				return dst_reg->bcf_expr;
+		}
 		/* A new variable offset is created.  Note that off_reg->off
 		 * == 0, since it's a scalar.
 		 * dst_reg gets the pointer type and since some positive
@@ -15018,6 +15061,10 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 			/* something was added to pkt_ptr, set range to zero */
 			memset(&dst_reg->raw, 0, sizeof(dst_reg->raw));
 		}
+
+		ret = bcf_alu(env, dst_reg, src_reg, opcode, false);
+		if (ret)
+			return ret;
 		break;
 	case BPF_SUB:
 		if (dst_reg == off_reg) {
@@ -15046,8 +15093,15 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 			dst_reg->id = ptr_reg->id;
 			dst_reg->off = ptr_reg->off - smin_val;
 			dst_reg->raw = ptr_reg->raw;
+			dst_reg->bcf_expr = ptr_reg->bcf_expr;
 			break;
 		}
+
+		if (env->bcf.tracking) {
+			bcf_reg_expr(env, dst_reg, false);
+			if (dst_reg->bcf_expr < 0)
+				return dst_reg->bcf_expr;
+		}
 		/* A new variable offset is created.  If the subtrahend is known
 		 * nonnegative, then any reg->range we had before is still good.
 		 */
@@ -15075,6 +15129,10 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 			if (smin_val < 0)
 				memset(&dst_reg->raw, 0, sizeof(dst_reg->raw));
 		}
+
+		ret = bcf_alu(env, dst_reg, src_reg, opcode, false);
+		if (ret)
+			return ret;
 		break;
 	case BPF_AND:
 	case BPF_OR:
@@ -15728,7 +15786,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 {
 	u8 opcode = BPF_OP(insn->code);
 	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
-	int ret;
+	int ret, dst_expr = dst_reg->bcf_expr;
 
 	if (!is_safe_to_compute_dst_reg_range(insn, &src_reg)) {
 		__mark_reg_unknown(env, dst_reg);
@@ -15741,6 +15799,14 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 			return sanitize_err(env, insn, ret, NULL, NULL);
 	}
 
+	/* Constants alu produces constant, skip it; otherwise, bind expr. */
+	if (env->bcf.tracking && (!tnum_is_const(dst_reg->var_off) ||
+				   !tnum_is_const(src_reg.var_off))) {
+		dst_expr = bcf_reg_expr(env, dst_reg, false);
+		if (dst_expr < 0)
+			return dst_expr;
+	}
+
 	/* Calculate sign/unsigned bounds and tnum for alu32 and alu64 bit ops.
 	 * There are two classes of instructions: The first class we track both
 	 * alu32 and alu64 sign/unsigned bounds independently this provides the
@@ -15819,6 +15885,12 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	if (alu32)
 		zext_32_to_64(dst_reg);
 	reg_bounds_sync(dst_reg);
+
+	dst_reg->bcf_expr = dst_expr;
+	ret = bcf_alu(env, dst_reg, &src_reg, opcode, alu32);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.34.1


