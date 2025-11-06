Return-Path: <bpf+bounces-73843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 230AEC3B0EA
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 14:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DF03503DC7
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 12:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175E0339716;
	Thu,  6 Nov 2025 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1M8DFEq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AD8336EE7
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433625; cv=none; b=ABPJPJY1mWJYKzV8gOCBN0mHDsubzg6i12MgeBrgdUyMO3OYL70tthCPpcbngkArpz1q/2qUo3SQgHKc1oAv2bfSTdhZ5ZdeT9Dq+KChFkkqZYSXZ5NYnT6DdjxIjqdo87K7myzh+64ph2mJWLyd/ZoK9LbKotojyiDSh+l93d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433625; c=relaxed/simple;
	bh=yJ5nI4Pj/e2l438vacBXP4YBnLRHauWN7FXlZehjs1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AU/uqRkxF9rd6uXYfEj0YvetpNGfyKgiBDHbeXgQe3M9/6zsNE/S5NDIv86kpLti6j3AWs/waV43mLtrz6/kZ0U2m5qsi3rPyBDjRFAJyseP7xksCjhzgjpunkfXDdV9RbuUKkaEoWyB0Q8Rqac4x3xUf7S/oXQIUtdRFqJbJjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1M8DFEq; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-421851bcb25so497878f8f.2
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 04:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762433621; x=1763038421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeQ1qQssRNVDy6SgVbDGPxE08ddX4PJBvQHFLhXifeI=;
        b=R1M8DFEqJCZQNRUjCVDryhHFk+KbSPp/UeHeOYMK/0OApOx3+K6WAuh0SAFowvafHM
         9y3tkfibNU8uQVw/GqI2XYG/V+CViA4IBiwns9LtV0ehBY3P99bSOL+9QPbAGi5tq/up
         +srnFNoutTJtEzRGmcbjoWEgCRglm/0IuTH4Iom4yKIfFjqFGs6pOX8miioZsCaxWNQf
         y9MzTneQQLrePWQRulg3HRtNvtJBrmzvzvooObwDssixwjbulUvnG0TJMrtgTCED3qKX
         COA4EmpyiprnpDYKLpys4vb1dW4q3pGV1OXcFH0AYrKEJx9NjccyXnd+Zs+1/Gn1agn/
         uraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762433621; x=1763038421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TeQ1qQssRNVDy6SgVbDGPxE08ddX4PJBvQHFLhXifeI=;
        b=wQqhQy7+0z6YEPWfv499TZ5ygvKju0orKdetV7FMAaOo31N89VZ3rAM7R9GtNUFpu7
         RkcB2fwXLBwzNT2K3e/T/5LBKHK8dbS5FBr01e9VjXwW1R0FpjhGpqJO9whTUlN/HgKj
         uCy/nguths275ECjEmzxskPnC1PKgv25qLXdqCFDrveDKAn2Y9FoaOdRUOSD3XEtb1D4
         bd9pwIJJoYOimxxVa+LhpHvOi9Jw0pxzjmRkZ3ga6U+3FhpyberSnVS9vZeKRRiwzhCO
         K8js2if2NVuOuyLlksTKXQyJ8vsC/i7Qn62LOWYTJx125mNqIbqu5iP2ZV2YUozHg6FU
         gZHw==
X-Gm-Message-State: AOJu0YzlJ+BQoDS+MhQ8wLARmIULi1R9/S0Xnr2DY6Mg/LfmyFs9PkyP
	hpGZDLaeH6Bz9X3ixRfFMr59X1E6k2lnYKE5isN18U/p63EeW6p55Q6ySShs
X-Gm-Gg: ASbGncteUoO959UoDxQNYCdRsuGYZsRaDH5iB/DQrExRWrY6lD1be7Cm2UKUdMDnPVz
	tHgv1dwEsRfaRoz8k03FmInbpZwTtyRkocVRjMEhd0wg+Mx2YxlR6ZPGrSHUKhS1RMH78teARJQ
	sHvENyRKPxepqqHvmhPFLaDXH02vLsaidQ/g0m0gBazHt1P2l1CRBSpJu/7OipLOoJggLGn+nmi
	d6sga0dykMh/9AMseLvjj+r43YgVVbS5sd7/lBNvhyxWHGrlOKhJJsg+vV5tmcszw2LwwE1i1tn
	6bur6jts/AMtVJbDW645zjWUpQMw+g6ZNFzacs7OoXp0Jrche+ZVcd6Nsu7gHICSFxosdGuf4mn
	j43Pm3UYKbjSvdJtDc4bbYOrBbWmnw+cv17m6YQhGQaiPP3ZwxTgs5xtLdTLazgL91CNAVBNxxh
	ED7fBSOcjuUZ6qM3GFkBAe3nG/Vh4qneTZEbTEZbP0QaiV4zPNGGGqKeJDMUBHBVcDpw==
X-Google-Smtp-Source: AGHT+IGmXXB3sYTtNVijmZK/dE1I0XwRMENPcN7ucBxdXqW1KCxYeITYB9d4TFOdh1oLXlDVTdzeLg==
X-Received: by 2002:a05:6000:2304:b0:429:c505:8cb1 with SMTP id ffacd0b85a97d-429e3333c80mr6684600f8f.52.1762433620557;
        Thu, 06 Nov 2025 04:53:40 -0800 (PST)
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
Subject: [PATCH RFC 08/17] bpf: Track mov and signed extension
Date: Thu,  6 Nov 2025 13:52:46 +0100
Message-Id: <20251106125255.1969938-9-hao.sun@inf.ethz.ch>
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

Add `bcf_mov()` helpers to model MOV/cast operations in `bcf_track()` and add 
calls into ALU processing paths. The helpers extract the source to the target
width and apply zero/sign extension to the final width as needed.

- For MOV32, build a 32-bit expr for src and zero-extend it.
- For sign-extending MOVs (s8/s16 to W, or s8/s16 to R), extract the sub-width
  and sign-extend to 32 or 64.
- If the destination is known-constant, clear `dst_reg->bcf_expr` (-1) to avoid
  carrying redundant symbolic nodes.

These routines are only active when `env->bcf.tracking` is set. They are called
from `check_alu_op()` in the relevant MOV/SEXT cases.

Signed-off-by: Hao Sun <hao.sun@inf.ethz.ch>
---
 kernel/bpf/verifier.c | 69 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7b6d509c773a..4491d665cc49 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15959,6 +15959,57 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	return 0;
 }
 
+static int bcf_mov(struct bpf_verifier_env *env, struct bpf_reg_state *dst_reg,
+		   struct bpf_reg_state *src_reg, u32 sz, bool bit32, bool sext)
+{
+	int src_expr, ext_sz, bitsz = bit32 ? 32 : 64;
+
+	if (!env->bcf.tracking)
+		return 0;
+	if (tnum_is_const(dst_reg->var_off)) {
+		dst_reg->bcf_expr = -1;
+		return 0;
+	}
+
+	src_expr = bcf_reg_expr(env, src_reg, bit32 || sz == 32);
+	if (sz != 32) /* u/s16 u/s8 */
+		src_expr = bcf_extract(env, sz, src_expr);
+
+	if (sext) {
+		ext_sz = bitsz - sz;
+		dst_reg->bcf_expr =
+			bcf_extend(env, ext_sz, bitsz, true, src_expr);
+		if (bit32)
+			bcf_zext_32_to_64(env, dst_reg);
+	} else {
+		ext_sz = 64 - sz;
+		dst_reg->bcf_expr =
+			bcf_extend(env, ext_sz, 64, false, src_expr);
+	}
+	if (dst_reg->bcf_expr < 0)
+		return dst_reg->bcf_expr;
+
+	return 0;
+}
+
+static int bcf_mov32(struct bpf_verifier_env *env, struct bpf_reg_state *dst,
+		     struct bpf_reg_state *src)
+{
+	return bcf_mov(env, dst, src, 32, true, false);
+}
+
+static int bcf_sext32(struct bpf_verifier_env *env, struct bpf_reg_state *dst,
+		      struct bpf_reg_state *src, u32 sz)
+{
+	return bcf_mov(env, dst, src, sz, true, true);
+}
+
+static int bcf_sext64(struct bpf_verifier_env *env, struct bpf_reg_state *dst,
+		      struct bpf_reg_state *src, u32 sz)
+{
+	return bcf_mov(env, dst, src, sz, false, true);
+}
+
 /* check validity of 32-bit and 64-bit arithmetic operations */
 static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 {
@@ -16084,8 +16135,12 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						if (no_sext)
 							assign_scalar_id_before_mov(env, src_reg);
 						copy_register_state(dst_reg, src_reg);
-						if (!no_sext)
+						if (!no_sext) {
 							dst_reg->id = 0;
+							err = bcf_sext64(env, dst_reg, src_reg, insn->off);
+							if (err)
+								return err;
+						}
 						coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
 						dst_reg->subreg_def = DEF_NOT_SUBREG;
 					} else {
@@ -16110,8 +16165,12 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						 * range otherwise dst_reg min/max could be incorrectly
 						 * propagated into src_reg by sync_linked_regs()
 						 */
-						if (!is_src_reg_u32)
+						if (!is_src_reg_u32) {
 							dst_reg->id = 0;
+							err = bcf_mov32(env, dst_reg, src_reg);
+							if (err)
+								return err;
+						}
 						dst_reg->subreg_def = env->insn_idx + 1;
 					} else {
 						/* case: W1 = (s8, s16)W2 */
@@ -16120,8 +16179,12 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 						if (no_sext)
 							assign_scalar_id_before_mov(env, src_reg);
 						copy_register_state(dst_reg, src_reg);
-						if (!no_sext)
+						if (!no_sext) {
 							dst_reg->id = 0;
+							err = bcf_sext32(env, dst_reg, src_reg, insn->off);
+							if (err)
+								return err;
+						}
 						dst_reg->subreg_def = env->insn_idx + 1;
 						coerce_subreg_to_size_sx(dst_reg, insn->off >> 3);
 					}
-- 
2.34.1


