Return-Path: <bpf+bounces-78161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B160D0009E
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 21:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E36C3047661
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 20:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C974C329E6D;
	Wed,  7 Jan 2026 20:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jl1mMcIL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B97285CB8
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767818444; cv=none; b=upnFvY8vZsvc4mm3v9Uxpf8RSiHHYkXfTWU0A0OHjfk179iLsS8wt1X+TEn5rNY1jlLODkeL6b4/Eqn+9sYLsYTgPbdpNrNcGB/VB56DugVeI6QzoVXL5pbUgmNYitZQSyJ6f9YnGcuk9Fn/KQsTrD5OxbWjZhhjG6aE4tBJYGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767818444; c=relaxed/simple;
	bh=K5AWz2LayQmpLYha/V3zDMRst/rt6vs2BBNH2/gQNUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ge9c4UUBxPupoM8754NLLObfOMbpY+fCCfTyGq7LQZzreSq1p1tK4sJS/EduAeuvniTSt/9CIAXKs0NbMA7+U7XQDlaAopR009WcHrRkU4Z0T3Ux1xr/+oWsyxg104r6vmEfW0Ds9y5TCjymS41Uc/DDo9a64C1Nnq6RFYEjZjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jl1mMcIL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E0EC4CEF1;
	Wed,  7 Jan 2026 20:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767818443;
	bh=K5AWz2LayQmpLYha/V3zDMRst/rt6vs2BBNH2/gQNUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jl1mMcILp819w0qX0Mnrw7eIayvVysXR5T04pYZP3sJL3Wxo3aJ1qzTpaq3MOKzK5
	 N/QFWhJ06lzIsruUaVxSFcqocLCu49TKfWWxVtFevNcT7z2Xt93TPhM91t1WoAOuHh
	 11chiu49HNm9tEzHzi1B3JuEyTZXz8LRdf2ww7TfsqVj0tz/U2PU80yblczXEDfbR/
	 8zZ6yHboDf8JKI7MjcDzNLIPVegUZ6CA8dbucV7Ov4u62IilOJOvGkVSFXDdpiL5BK
	 tNU1gSLZzQ9NQE/VJLy9Z8gJuzWazbb0emNX2ZtOsdKPV8IzgYWQ7toShPX/XkR0nu
	 PSQXdY014Xr3A==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/3] bpf: Support negative offsets and BPF_SUB for linked register tracking
Date: Wed,  7 Jan 2026 12:39:34 -0800
Message-ID: <20260107203941.1063754-2-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260107203941.1063754-1-puranjay@kernel.org>
References: <20260107203941.1063754-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the linked register tracking to support:

1. Negative offsets via BPF_ADD (e.g., r1 += -4)
2. BPF_SUB operations (e.g., r1 -= 4), which is treated as r1 += -4

Previously, the verifier only tracked positive constant deltas between
linked registers using BPF_ADD. This limitation meant patterns like:

  r1 = r0
  r1 += -4
  if r1 s>= 0 goto ...   // r1 >= 0 implies r0 >= 4
  // verifier couldn't propagate bounds back to r0

With this change, the verifier can now track negative deltas in reg->off
(which is already s32), enabling bound propagation for the above pattern.

The changes include:
- Accept BPF_SUB in addition to BPF_ADD
- Change overflow check from val > (u32)S32_MAX to checking if val fits
  in s32 range: (s64)val != (s64)(s32)val
- For BPF_SUB, negate the offset with a guard against S32_MIN overflow
- Keep !alu32 restriction as 32-bit ALU has known issues with upper bits

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/bpf/verifier.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 53635ea2e41b..5eca33e02d6e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15710,22 +15710,34 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	 * update r1 after 'if' condition.
 	 */
 	if (env->bpf_capable &&
-	    BPF_OP(insn->code) == BPF_ADD && !alu32 &&
-	    dst_reg->id && is_reg_const(src_reg, false)) {
+	    (BPF_OP(insn->code) == BPF_ADD || BPF_OP(insn->code) == BPF_SUB) &&
+	    !alu32 && dst_reg->id && is_reg_const(src_reg, false)) {
 		u64 val = reg_const_value(src_reg, false);
+		s32 off;
 
-		if ((dst_reg->id & BPF_ADD_CONST) ||
-		    /* prevent overflow in sync_linked_regs() later */
-		    val > (u32)S32_MAX) {
+		if ((s64)val != (s64)(s32)val)
+			goto clear_id;
+
+		off = (s32)val;
+
+		if (BPF_OP(insn->code) == BPF_SUB) {
+			/* Negating S32_MIN would overflow */
+			if (off == S32_MIN)
+				goto clear_id;
+			off = -off;
+		}
+
+		if (dst_reg->id & BPF_ADD_CONST) {
 			/*
 			 * If the register already went through rX += val
 			 * we cannot accumulate another val into rx->off.
 			 */
+clear_id:
 			dst_reg->off = 0;
 			dst_reg->id = 0;
 		} else {
 			dst_reg->id |= BPF_ADD_CONST;
-			dst_reg->off = val;
+			dst_reg->off = off;
 		}
 	} else {
 		/*
@@ -16821,7 +16833,7 @@ static void sync_linked_regs(struct bpf_verifier_state *vstate, struct bpf_reg_s
 			s32 saved_off = reg->off;
 
 			fake_reg.type = SCALAR_VALUE;
-			__mark_reg_known(&fake_reg, (s32)reg->off - (s32)known_reg->off);
+			__mark_reg_known(&fake_reg, (s64)reg->off - (s64)known_reg->off);
 
 			/* reg = known_reg; reg += delta */
 			copy_register_state(reg, known_reg);
-- 
2.47.3


