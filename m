Return-Path: <bpf+bounces-73845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5761FC3B1B3
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 14:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E961423718
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 12:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6171A333737;
	Thu,  6 Nov 2025 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f85kQUa5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC8D33711C
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 12:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433626; cv=none; b=HFwEPHMYKHjqvNO9ilE0jdp8NsWo5q9inMi/Phi8+0tY4c/quGb3kOCc19COL2UC5vbroAbuxXih/ejgaXQICRXMpBSTTIXWSDt4bUH86xavfRLhnCJPqacEEdjnLVZS/VyrCoa+TLDXQfYxOuc/yhd7Rrj+vJ+mXfiRCv3kRv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433626; c=relaxed/simple;
	bh=bcHRGOqbqzzhPFu+ojNR6wxaw6xjv4kXNLSndDc36ME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ua2oyyLnnojIuDbLqAc4FcCTuj6TM4+wKmjQtxmVEXTxoqvyF9hI4Hfn/R/NcTZ5Vv/+CoNd9Qs1yKppjyWRscRwCwfpMg1UfaK4cJIvnW3o1ALFrsIYeuazozsu3j1Uyo7rbaSBhcSXDszK7SphXP+3w5lBR4GfABu6YWejbVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f85kQUa5; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-427007b1fe5so603160f8f.1
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 04:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762433622; x=1763038422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjCst0RmwR8vxuLUXqKmfS8QPtIrCS1B+n9Hqasdjnw=;
        b=f85kQUa5iJSxf0Et/ff+m7JLvsgQzLhg2mQongDbZuAGXkCAUW//misPdEBKj4hOes
         kc5h4kTctIZBVISZ2MY7y2EOQLe0AAnu/VFSXlQhISObgOIdQt9V52zxAzVXrmJm+/Gv
         y2dlS/LSBB6SqaQhvJpd72gfY037Zc5oksQhJy+SdvOS53Fvoq4y6SFnkVHtw14lYFvd
         6ONOUcRXdLlWUrC/yWZhdbob5iaMBl+xDR7D/sh8hzR7gu2lMo8z3HVXI0yaQm3BW36z
         wiurrTWyqwzSBsQFZZP0f9lVxBM/iFDGN3Ca7BRw0yyMIhRDNLSdTAYvcWsx36c1gWCI
         1xWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762433622; x=1763038422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjCst0RmwR8vxuLUXqKmfS8QPtIrCS1B+n9Hqasdjnw=;
        b=R9+1PoMoXHj+LP3Iods/wSvdu+Gap+eDVF01KaEH7IO2YG+JB/WDwcYlP5vDrj9MmU
         lU5IBKW21HrgaoUPyjHSm42LUESj3mRAa1XOkvlK+TnB04jtL2s75r8laAcVBPfGL3Rq
         UN8rQEVHPSroH2jZx82JPIe7GAvqUh9oMFvDo4xLJl7/jjsp49a5awygyL8ehgbgakKp
         6jdLPI+zBCN6lBIpeHzRcjAhVY3TURTC10LplPvtUIOsZB0rn/W68lDEsyB0abyHWirG
         GeevnpcI3AG40ApYWQbFyCUQDGz/l5hb3+fc+fjAhKUm5SbpAecxnBIIrCLCrrGzfojd
         3+0Q==
X-Gm-Message-State: AOJu0Yzz8s+hYzuqDRs4m2p1FSsb/P8zigkFYhfAMfWpqW6oTL9Vpmkd
	pvzetAMfCDNg48e9+PNfkqopc+tb0HcplWhXQ+K3bSYKntsulsISvLWR8nnK
X-Gm-Gg: ASbGncuVyUkpq4VgJH+AXSDDEoLoDEWwWK3sRomX/elFu9Yvhd3Ta6EbJK1KCvQ5DT1
	4AIfpui0Z+Mz8xRYZDAPb+kBje43+tXSmabMoWSlLUV9PipC+VLkRP/rOptwPSY76O93QllqAJs
	/Oo4WMNvViXWwfwYETliB1+OqysCdUp89W6JQunutSNjNfyKzT9rKTBXWslIa7zGUZ5nLc3OlmZ
	LCVIFjvrZcT3Vf3021/WVIGoohmstMwcyrhSGEz6P+NCDK1wuuHJR/xai0cbWgbNAEhJLv4huhr
	tsMX2npzx18RT5b0DzOc9w6RmjZEDqQ4EHOUqRI7tdhjDMzJ+2TgTGu+SFMsnA0Kfm3t/Ki7ID2
	TzpDQvGslhXDsFzyplTciynpkgOv94Jcrj9DRj7KJ1+Twp6uZSE9uZCN5L/MhuIhO2k2kSaQBJK
	ZoWCu5xIuYNA4Ov2IJQ+KmSFoj48PPmGu7/dVYlWY0kxc8LXB3wilv390=
X-Google-Smtp-Source: AGHT+IF59d5GYYpx4VOKuwUgzJ5BNLyqt4IadFejfqDnuxk1Y2oRGUxA032fi9ljWUpPNLgprK4b7A==
X-Received: by 2002:a05:6000:220d:b0:426:ff2f:9c15 with SMTP id ffacd0b85a97d-429e32c8784mr7110253f8f.5.1762433621744;
        Thu, 06 Nov 2025 04:53:41 -0800 (PST)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4788856f8f.9.2025.11.06.04.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 04:53:41 -0800 (PST)
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
Subject: [PATCH RFC 10/17] bpf: Add bcf_alu() 32bits optimization
Date: Thu,  6 Nov 2025 13:52:48 +0100
Message-Id: <20251106125255.1969938-11-hao.sun@inf.ethz.ch>
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

Lower symbolic ALU nodes to 32-bit when both operands and the resulting dst
fit in 32 bits, to reduce solver/proof complexity.

- Extend `bcf_alu()` with `op_u32`/`op_s32` hints and derive a `zext` decision:
  when ALU32 or both operands/results fit u32, emit a 32-bit op and zero-extend
  to 64; when signed-32 is in effect, sign-extend to 64 after the op.

- Compute `op_u32`/`op_s32` for pointer and scalar ALUs (using fit_u32/fit_s32)
  before emitting the node, then mask them again with the post-ALU dst range so
  the final node width reflects the verifier’s bounds.

This shrinks many BV nodes and helps keep per-node vlen within limits (U8_MAX),
reducing proof size.

Signed-off-by: Hao Sun <hao.sun@inf.ethz.ch>
---
 kernel/bpf/verifier.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 66682d365e5e..df6d16a1c6f6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14866,11 +14866,13 @@ static int sanitize_check_bounds(struct bpf_verifier_env *env,
 }
 
 static int bcf_alu(struct bpf_verifier_env *env, struct bpf_reg_state *dst_reg,
-		   struct bpf_reg_state *src_reg, u8 op, bool alu32)
+		   struct bpf_reg_state *src_reg, u8 op, bool alu32,
+		   bool op_u32, bool op_s32)
 {
 	DEFINE_RAW_FLEX(struct bcf_expr, alu_expr, args, 2);
 	bool unary = (op == BPF_NEG);
 	int dst, src = 0, bits;
+	bool zext = alu32 || op_u32;
 
 	if (!env->bcf.tracking)
 		return 0;
@@ -14879,6 +14881,7 @@ static int bcf_alu(struct bpf_verifier_env *env, struct bpf_reg_state *dst_reg,
 		return 0;
 	}
 
+	alu32 |= (op_u32 || op_s32);
 	dst = bcf_reg_expr(env, dst_reg, alu32);
 	if (!unary)
 		src = bcf_reg_expr(env, src_reg, alu32);
@@ -14892,8 +14895,11 @@ static int bcf_alu(struct bpf_verifier_env *env, struct bpf_reg_state *dst_reg,
 	alu_expr->args[0] = dst;
 	alu_expr->args[1] = src;
 	dst_reg->bcf_expr = bcf_add_expr(env, alu_expr);
-	if (alu32)
+	if (zext)
 		bcf_zext_32_to_64(env, dst_reg);
+	else if (op_s32)
+		bcf_sext_32_to_64(env, dst_reg);
+
 	if (dst_reg->bcf_expr < 0)
 		return dst_reg->bcf_expr;
 
@@ -14922,6 +14928,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	u8 opcode = BPF_OP(insn->code);
 	u32 dst = insn->dst_reg;
 	int ret, bounds_ret;
+	bool op_u32, op_s32;
 
 	dst_reg = &regs[dst];
 	src_reg = dst_reg == ptr_reg ? off_reg : ptr_reg;
@@ -15034,6 +15041,8 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 			if (dst_reg->bcf_expr < 0)
 				return dst_reg->bcf_expr;
 		}
+		op_u32 = fit_u32(dst_reg) && fit_u32(src_reg);
+		op_s32 = fit_s32(dst_reg) && fit_s32(src_reg);
 		/* A new variable offset is created.  Note that off_reg->off
 		 * == 0, since it's a scalar.
 		 * dst_reg gets the pointer type and since some positive
@@ -15062,7 +15071,9 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 			memset(&dst_reg->raw, 0, sizeof(dst_reg->raw));
 		}
 
-		ret = bcf_alu(env, dst_reg, src_reg, opcode, false);
+		op_u32 &= fit_u32(dst_reg);
+		op_s32 &= fit_s32(dst_reg);
+		ret = bcf_alu(env, dst_reg, src_reg, opcode, false, op_u32, op_s32);
 		if (ret)
 			return ret;
 		break;
@@ -15102,6 +15113,8 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 			if (dst_reg->bcf_expr < 0)
 				return dst_reg->bcf_expr;
 		}
+		op_u32 = fit_u32(dst_reg) && fit_u32(src_reg);
+		op_s32 = fit_s32(dst_reg) && fit_s32(src_reg);
 		/* A new variable offset is created.  If the subtrahend is known
 		 * nonnegative, then any reg->range we had before is still good.
 		 */
@@ -15130,7 +15143,9 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 				memset(&dst_reg->raw, 0, sizeof(dst_reg->raw));
 		}
 
-		ret = bcf_alu(env, dst_reg, src_reg, opcode, false);
+		op_u32 &= fit_u32(dst_reg);
+		op_s32 &= fit_s32(dst_reg);
+		ret = bcf_alu(env, dst_reg, src_reg, opcode, false, op_u32, op_s32);
 		if (ret)
 			return ret;
 		break;
@@ -15787,6 +15802,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	u8 opcode = BPF_OP(insn->code);
 	bool alu32 = (BPF_CLASS(insn->code) != BPF_ALU64);
 	int ret, dst_expr = dst_reg->bcf_expr;
+	bool op_u32, op_s32;
 
 	if (!is_safe_to_compute_dst_reg_range(insn, &src_reg)) {
 		__mark_reg_unknown(env, dst_reg);
@@ -15806,6 +15822,8 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 		if (dst_expr < 0)
 			return dst_expr;
 	}
+	op_u32 = fit_u32(dst_reg) && fit_u32(&src_reg);
+	op_s32 = fit_s32(dst_reg) && fit_s32(&src_reg);
 
 	/* Calculate sign/unsigned bounds and tnum for alu32 and alu64 bit ops.
 	 * There are two classes of instructions: The first class we track both
@@ -15887,7 +15905,9 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	reg_bounds_sync(dst_reg);
 
 	dst_reg->bcf_expr = dst_expr;
-	ret = bcf_alu(env, dst_reg, &src_reg, opcode, alu32);
+	op_u32 &= fit_u32(dst_reg);
+	op_s32 &= fit_s32(dst_reg);
+	ret = bcf_alu(env, dst_reg, &src_reg, opcode, alu32, op_u32, op_s32);
 	if (ret)
 		return ret;
 
-- 
2.34.1


