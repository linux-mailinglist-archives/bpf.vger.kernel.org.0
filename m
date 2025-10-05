Return-Path: <bpf+bounces-70399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C359BB958F
	for <lists+bpf@lfdr.de>; Sun, 05 Oct 2025 12:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 78C863459BB
	for <lists+bpf@lfdr.de>; Sun,  5 Oct 2025 10:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5815026CE28;
	Sun,  5 Oct 2025 10:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="EYbriPVe"
X-Original-To: bpf@vger.kernel.org
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC162343BE
	for <bpf@vger.kernel.org>; Sun,  5 Oct 2025 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759660925; cv=none; b=B6YcSSbJaixCAo2vNgUWO4LDU1hgbs/zLUekRAhOX0Q05awIC1G3PzogxF0W+ATNUd085lU7S/qgLfkTNF0DhgWjJGTJFR9dUKBjKXRIvOupoUUCJ0VDn1sOaI0R09iZdq0R88cZ4SKsIUcbH4WOC4EPnOenNmaMSB2vzicYvEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759660925; c=relaxed/simple;
	bh=ZQa/MIKFXOP4kj4c26LbMZuWz2ddzSFlLjEGAqPtIjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2K+JDk2XYN+hex4wxwpvLaUHdQj0hj3/WLzt2bABvI0f8eKCboMZhPyvmK+IGX6ukTXKXVgtXA+s3P4QYUtCDLJXFOvdIjOf8zBnsHp5Ww0YPhUgjFkZCeS3Eqirkjz2C0w4orWQERweubE4G2Fk1U5HlZ/tzmrfD9NYEmM4Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=EYbriPVe; arc=none smtp.client-ip=131.188.11.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1759660550; bh=QV4cgBm7MMoZA21cmcEP+It+97CMAcEXYlCuOSQquv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=EYbriPVeMM9svZxMm9ANHJiipWWeRnetcN8DzaD8l9yWspOLN5G3nxpdA/0FkdLZr
	 uD/oU/3Si1uOsdFcNfl51ZATMJAqTTbHhX34MUPyFEShunvapAn7z0Ym5mp8SK09TI
	 N37jd2iw0ydyMQp83xzTrhQqXllkcJqI/Kp6Gm5h1oIXWDvrAx/H0yF3sa/QoFUJw2
	 I8Y2cWWgJrbxein5lr6NKvSnLGvfFVPfYH/uuqQWmWuxTlGOtjd6sB9Za9yrYHyFfb
	 0siSoe6SpLmFedOAYe345krkJu8CIMtGChlTpEmosObbL0zBdqWy9hQhNvDcECM6qA
	 Yb8JPsvuBhPcQ==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4cff1y1Tl8zPkCR;
	Sun,  5 Oct 2025 12:35:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3632:e00:f174:1ae7:eb66:61e6
Received: from luis-tp.fritz.box (unknown [IPv6:2001:9e8:3632:e00:f174:1ae7:eb66:61e6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX18iL5GdxpQjUaQADVJn71Ma3FubxqLEADQ=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4cff1t1g43zPkR1;
	Sun,  5 Oct 2025 12:35:46 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Hengqi Chen <hengqi.chen@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	bpf <bpf@vger.kernel.org>
Cc: Luis Gerhorst <luis.gerhorst@fau.de>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Henriette Herzog <henriette.herzog@rub.de>
Subject: [RFC 1/3] bpf: Fall back to nospec for sanitization-failures
Date: Sun,  5 Oct 2025 12:35:18 +0200
Message-ID: <20251005103518.996383-1-luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <87plb17ijl.fsf@fau.de>
References: <87plb17ijl.fsf@fau.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ALU sanitization was introduced to ensure that a subsequent ptr access
can never go OOB, even under speculation. This is required because we
currently allow speculative scalar confusion. Spec. scalar confusion is
possible because Spectre v4 sanitization only adds a nospec after
critical stores (e.g., scalar overwritten with a pointer).

If we add a nospec before the ALU op, none of the operands can be
subject to scalar confusion. As an ADD/SUB can not introduce scalar
confusion itself, the result will also not be subject to scalar
confusion. Therefore, the subsequent ptr access is always safe.

We directly fall back to nospec for the sanitization errors
REASON_BOUNDS, _TYPE, _PATHS, and _LIMIT, even if we are not on a
speculative path. For REASON_STACK, we return the error directly now.

Decided to directly set cur_aux(env)->nospec to implement the fallback
instead of (conceptually) making the nospec part of the ALU sanitization
state and therefore potentially dragging it through info.aux before
copying it over into cur_aux(env). This has the drawback that the usage
of cur_aux(env) and aux in these functions might be confusing, but it
has the upside that it does not needlessly complicate the dataflow for
nospec. Also the presence of cur_aux() might make it more obvious that
aux might not equal cur_aux() here. In the commit window,
sanitize_ptr_alu() will bail out early because can_skip_alu_sanitation()
checks cur_aux(env)->nospec.

Regarding commit 97744b4971d81 ("bpf: Clarify sanitize_check_bounds()"),
having the assertion trigger if alu_state is set on a non-speculative
path makes the most sense, because the masking would truncate the bounds
on that path when executed and sanitize_check_bounds() exists to ensure
this trucation does not happen. Two cases are relevant:

- First, if a case in sanitize_check_bounds() is omitted, it fails with
  EOPNOTSUPP but retrieve_ptr_limit() returns 0 (thereby potentially not
  setting cur_aux(env)->nospec instead of setting alu_state). With the
  old/new assertion, this is cought.

- Second, if a case is omitted from retrieve_ptr_limit() but not from
  sanitize_check_bounds(), bounds_ret equals 0 or -EACCES. If it is 0
  and the default case in retrieve_ptr_limit() runs errorously, we mark
  the insn for nospec-sanitization. This is not really a security
  problem and it could also only be detected by adding a
  verifier_bug_if(bounds_ret != -EOPNOTSUPP) into the default case in
  retrieve_ptr_limit(). It is not cought by the old/new assertion.

Because it remove the possibility for these errors altogether, this
change also fixes some unwarranted test failures on architectures that
have bpf_jit_bypass_spec_v1 set (e.g., LoongArch).

Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Henriette Herzog <henriette.herzog@rub.de>
Cc: Hengqi Chen <hengqi.chen@gmail.com>
---

Changes since v4 of series:
- Rebase and resolve merge conflicts with 97744b4971d81 ("bpf: Clarify
  sanitize_check_bounds()").
- Change update_alu_sanitation_state() and sanitize_val_alu() to return
  void as they now never fail.
- Link to v4 of series: https://lore.kernel.org/all/20250603213232.339242-1-luis.gerhorst@fau.de/

...
---
 kernel/bpf/verifier.c                         | 128 +++++++-----------
 .../selftests/bpf/progs/verifier_bounds.c     |   5 +-
 .../bpf/progs/verifier_bounds_deduction.c     |  45 +++---
 .../selftests/bpf/progs/verifier_map_ptr.c    |  20 ++-
 .../bpf/progs/verifier_value_ptr_arith.c      |  97 ++++++++++---
 5 files changed, 180 insertions(+), 115 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e892df386eed..c5c1956f1aee 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14195,14 +14195,6 @@ static bool check_reg_sane_offset(struct bpf_verifier_env *env,
 	return true;
 }
 
-enum {
-	REASON_BOUNDS	= -1,
-	REASON_TYPE	= -2,
-	REASON_PATHS	= -3,
-	REASON_LIMIT	= -4,
-	REASON_STACK	= -5,
-};
-
 static int retrieve_ptr_limit(const struct bpf_reg_state *ptr_reg,
 			      u32 *alu_limit, bool mask_to_left)
 {
@@ -14225,11 +14217,13 @@ static int retrieve_ptr_limit(const struct bpf_reg_state *ptr_reg,
 			     ptr_reg->umax_value) + ptr_reg->off;
 		break;
 	default:
-		return REASON_TYPE;
+		/* Register has pointer with unsupported alu operation. */
+		return -EOPNOTSUPP;
 	}
 
+	/* Register tried access beyond pointer bounds. */
 	if (ptr_limit >= max)
-		return REASON_LIMIT;
+		return -EOPNOTSUPP;
 	*alu_limit = ptr_limit;
 	return 0;
 }
@@ -14242,32 +14236,38 @@ static bool can_skip_alu_sanitation(const struct bpf_verifier_env *env,
 		cur_aux(env)->nospec;
 }
 
-static int update_alu_sanitation_state(struct bpf_insn_aux_data *aux,
-				       u32 alu_state, u32 alu_limit)
+static void update_alu_sanitation_state(struct bpf_verifier_env *env,
+					struct bpf_insn_aux_data *aux,
+					u32 alu_state, u32 alu_limit)
 {
 	/* If we arrived here from different branches with different
 	 * state or limits to sanitize, then this won't work.
 	 */
 	if (aux->alu_state &&
 	    (aux->alu_state != alu_state ||
-	     aux->alu_limit != alu_limit))
-		return REASON_PATHS;
+	     aux->alu_limit != alu_limit)) {
+		/* Tried to perform alu op from different maps, paths or
+		 * scalars.
+		 */
+		cur_aux(env)->nospec = true;
+		cur_aux(env)->alu_state = 0;
+		return;
+	}
 
 	/* Corresponding fixup done in do_misc_fixups(). */
 	aux->alu_state = alu_state;
 	aux->alu_limit = alu_limit;
-	return 0;
 }
 
-static int sanitize_val_alu(struct bpf_verifier_env *env,
-			    struct bpf_insn *insn)
+static void sanitize_val_alu(struct bpf_verifier_env *env,
+			     struct bpf_insn *insn)
 {
 	struct bpf_insn_aux_data *aux = cur_aux(env);
 
 	if (can_skip_alu_sanitation(env, insn))
-		return 0;
+		return;
 
-	return update_alu_sanitation_state(aux, BPF_ALU_NON_POINTER, 0);
+	update_alu_sanitation_state(env, aux, BPF_ALU_NON_POINTER, 0);
 }
 
 static bool sanitize_needed(u8 opcode)
@@ -14332,16 +14332,29 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 
 	if (!commit_window) {
 		if (!tnum_is_const(off_reg->var_off) &&
-		    (off_reg->smin_value < 0) != (off_reg->smax_value < 0))
-			return REASON_BOUNDS;
+		    (off_reg->smin_value < 0) != (off_reg->smax_value < 0)) {
+			/* Register has unknown scalar with mixed signed
+			 * bounds.
+			 */
+			cur_aux(env)->alu_state = 0;
+			cur_aux(env)->nospec = true;
+			return 0;
+		}
 
 		info->mask_to_left = (opcode == BPF_ADD &&  off_is_neg) ||
 				     (opcode == BPF_SUB && !off_is_neg);
 	}
 
 	err = retrieve_ptr_limit(ptr_reg, &alu_limit, info->mask_to_left);
-	if (err < 0)
-		return err;
+	if (err) {
+		if (verifier_bug_if(err != -EOPNOTSUPP, env,
+				    "Fall back to BPF_NOSPEC for error %d might not be safe",
+				    err))
+			return -EFAULT;
+		cur_aux(env)->alu_state = 0;
+		cur_aux(env)->nospec = true;
+		return 0;
+	}
 
 	if (commit_window) {
 		/* In commit phase we narrow the masking window based on
@@ -14362,9 +14375,7 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 			env->explore_alu_limits = true;
 	}
 
-	err = update_alu_sanitation_state(aux, alu_state, alu_limit);
-	if (err < 0)
-		return err;
+	update_alu_sanitation_state(env, aux, alu_state, alu_limit);
 do_sim:
 	/* If we're in commit phase, we're done here given we already
 	 * pushed the truncated dst_reg into the speculative verification
@@ -14373,8 +14384,9 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 	 * Also, when register is a known constant, we rewrite register-based
 	 * operation to immediate-based, and thus do not need masking (and as
 	 * a consequence, do not need to simulate the zero-truncation either).
+	 * Same is true if we did a fallback to a nospec.
 	 */
-	if (commit_window || off_is_imm)
+	if (commit_window || off_is_imm || cur_aux(env)->nospec)
 		return 0;
 
 	/* Simulate and find potential out-of-bounds access under
@@ -14394,7 +14406,7 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
 					env->insn_idx);
 	if (!ptr_is_dst_reg && ret)
 		*dst_reg = tmp;
-	return !ret ? REASON_STACK : 0;
+	return !ret ? -ENOMEM : 0;
 }
 
 static void sanitize_mark_insn_seen(struct bpf_verifier_env *env)
@@ -14410,44 +14422,6 @@ static void sanitize_mark_insn_seen(struct bpf_verifier_env *env)
 		env->insn_aux_data[env->insn_idx].seen = env->pass_cnt;
 }
 
-static int sanitize_err(struct bpf_verifier_env *env,
-			const struct bpf_insn *insn, int reason,
-			const struct bpf_reg_state *off_reg,
-			const struct bpf_reg_state *dst_reg)
-{
-	static const char *err = "pointer arithmetic with it prohibited for !root";
-	const char *op = BPF_OP(insn->code) == BPF_ADD ? "add" : "sub";
-	u32 dst = insn->dst_reg, src = insn->src_reg;
-
-	switch (reason) {
-	case REASON_BOUNDS:
-		verbose(env, "R%d has unknown scalar with mixed signed bounds, %s\n",
-			off_reg == dst_reg ? dst : src, err);
-		break;
-	case REASON_TYPE:
-		verbose(env, "R%d has pointer with unsupported alu operation, %s\n",
-			off_reg == dst_reg ? src : dst, err);
-		break;
-	case REASON_PATHS:
-		verbose(env, "R%d tried to %s from different maps, paths or scalars, %s\n",
-			dst, op, err);
-		break;
-	case REASON_LIMIT:
-		verbose(env, "R%d tried to %s beyond pointer bounds, %s\n",
-			dst, op, err);
-		break;
-	case REASON_STACK:
-		verbose(env, "R%d could not be pushed for speculative verification, %s\n",
-			dst, err);
-		return -ENOMEM;
-	default:
-		verifier_bug(env, "unknown reason (%d)", reason);
-		break;
-	}
-
-	return -EACCES;
-}
-
 /* check that stack access falls within stack limits and that 'reg' doesn't
  * have a variable offset.
  *
@@ -14620,7 +14594,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		ret = sanitize_ptr_alu(env, insn, ptr_reg, off_reg, dst_reg,
 				       &info, false);
 		if (ret < 0)
-			return sanitize_err(env, insn, ret, off_reg, dst_reg);
+			return ret;
 	}
 
 	switch (opcode) {
@@ -14748,15 +14722,15 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	if (sanitize_needed(opcode)) {
 		ret = sanitize_ptr_alu(env, insn, dst_reg, off_reg, dst_reg,
 				       &info, true);
-		if (verifier_bug_if(!can_skip_alu_sanitation(env, insn)
-				    && !env->cur_state->speculative
-				    && bounds_ret
-				    && !ret,
-				    env, "Pointer type unsupported by sanitize_check_bounds() not rejected by retrieve_ptr_limit() as required")) {
-			return -EFAULT;
-		}
 		if (ret < 0)
-			return sanitize_err(env, insn, ret, off_reg, dst_reg);
+			return ret;
+		if (verifier_bug_if(cur_aux(env)->alu_state &&
+				    cur_aux(env)->alu_state != BPF_ALU_NON_POINTER &&
+				    !env->cur_state->speculative &&
+				    bounds_ret, env,
+				    "Pointer type unsupported by sanitize_check_bounds() (error %d) not rejected by retrieve_ptr_limit() as required",
+				    bounds_ret))
+			return -EFAULT;
 	}
 
 	return 0;
@@ -15385,9 +15359,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	}
 
 	if (sanitize_needed(opcode)) {
-		ret = sanitize_val_alu(env, insn);
-		if (ret < 0)
-			return sanitize_err(env, insn, ret, NULL, NULL);
+		sanitize_val_alu(env, insn);
 	}
 
 	/* Calculate sign/unsigned bounds and tnum for alu32 and alu64 bit ops.
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 0a72e0228ea9..a8fc9b38633b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -48,9 +48,12 @@ SEC("socket")
 __description("subtraction bounds (map value) variant 2")
 __failure
 __msg("R0 min value is negative, either use unsigned index or do a if (index >=0) check.")
-__msg_unpriv("R1 has unknown scalar with mixed signed bounds")
+__msg_unpriv("R0 pointer arithmetic of map value goes out of range, prohibited for !root")
 __naked void bounds_map_value_variant_2(void)
 {
+	/* unpriv: nospec inserted to prevent "R1 has unknown scalar with mixed
+	 * signed bounds".
+	 */
 	asm volatile ("					\
 	r1 = 0;						\
 	*(u64*)(r10 - 8) = r1;				\
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c b/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
index 260a6df264e3..bd18ad60d8ee 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds_deduction.c
@@ -8,22 +8,26 @@
 SEC("socket")
 __description("check deducing bounds from const, 1")
 __failure __msg("R0 tried to subtract pointer from scalar")
-__msg_unpriv("R1 has pointer with unsupported alu operation")
+__failure_unpriv
 __naked void deducing_bounds_from_const_1(void)
 {
 	asm volatile ("					\
 	r0 = 1;						\
 	if r0 s>= 1 goto l0_%=;				\
-l0_%=:	r0 -= r1;					\
+l0_%=:	/* unpriv: nospec (inserted to prevent `R1 has pointer with unsupported alu operation`) */\
+	r0 -= r1;					\
 	exit;						\
 "	::: __clobber_all);
 }
 
 SEC("socket")
 __description("check deducing bounds from const, 2")
-__success __failure_unpriv
-__msg_unpriv("R1 has pointer with unsupported alu operation")
+__success __success_unpriv
 __retval(1)
+#ifdef SPEC_V1
+__xlated_unpriv("nospec") /* inserted to prevent `R1 has pointer with unsupported alu operation` */
+__xlated_unpriv("r1 -= r0")
+#endif
 __naked void deducing_bounds_from_const_2(void)
 {
 	asm volatile ("					\
@@ -40,22 +44,26 @@ l1_%=:	r1 -= r0;					\
 SEC("socket")
 __description("check deducing bounds from const, 3")
 __failure __msg("R0 tried to subtract pointer from scalar")
-__msg_unpriv("R1 has pointer with unsupported alu operation")
+__failure_unpriv
 __naked void deducing_bounds_from_const_3(void)
 {
 	asm volatile ("					\
 	r0 = 0;						\
 	if r0 s<= 0 goto l0_%=;				\
-l0_%=:	r0 -= r1;					\
+l0_%=:	/* unpriv: nospec (inserted to prevent `R1 has pointer with unsupported alu operation`) */\
+	r0 -= r1;					\
 	exit;						\
 "	::: __clobber_all);
 }
 
 SEC("socket")
 __description("check deducing bounds from const, 4")
-__success __failure_unpriv
-__msg_unpriv("R6 has pointer with unsupported alu operation")
+__success __success_unpriv
 __retval(0)
+#ifdef SPEC_V1
+__xlated_unpriv("nospec") /* inserted to prevent `R6 has pointer with unsupported alu operation` */
+__xlated_unpriv("r6 -= r0")
+#endif
 __naked void deducing_bounds_from_const_4(void)
 {
 	asm volatile ("					\
@@ -73,12 +81,13 @@ l1_%=:	r6 -= r0;					\
 SEC("socket")
 __description("check deducing bounds from const, 5")
 __failure __msg("R0 tried to subtract pointer from scalar")
-__msg_unpriv("R1 has pointer with unsupported alu operation")
+__failure_unpriv
 __naked void deducing_bounds_from_const_5(void)
 {
 	asm volatile ("					\
 	r0 = 0;						\
 	if r0 s>= 1 goto l0_%=;				\
+	/* unpriv: nospec (inserted to prevent `R1 has pointer with unsupported alu operation`) */\
 	r0 -= r1;					\
 l0_%=:	exit;						\
 "	::: __clobber_all);
@@ -87,14 +96,15 @@ l0_%=:	exit;						\
 SEC("socket")
 __description("check deducing bounds from const, 6")
 __failure __msg("R0 tried to subtract pointer from scalar")
-__msg_unpriv("R1 has pointer with unsupported alu operation")
+__failure_unpriv
 __naked void deducing_bounds_from_const_6(void)
 {
 	asm volatile ("					\
 	r0 = 0;						\
 	if r0 s>= 0 goto l0_%=;				\
 	exit;						\
-l0_%=:	r0 -= r1;					\
+l0_%=:	/* unpriv: nospec (inserted to prevent `R1 has pointer with unsupported alu operation`) */\
+	r0 -= r1;					\
 	exit;						\
 "	::: __clobber_all);
 }
@@ -102,14 +112,15 @@ l0_%=:	r0 -= r1;					\
 SEC("socket")
 __description("check deducing bounds from const, 7")
 __failure __msg("dereference of modified ctx ptr")
-__msg_unpriv("R1 has pointer with unsupported alu operation")
+__failure_unpriv
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void deducing_bounds_from_const_7(void)
 {
 	asm volatile ("					\
 	r0 = %[__imm_0];				\
 	if r0 s>= 0 goto l0_%=;				\
-l0_%=:	r1 -= r0;					\
+l0_%=:	/* unpriv: nospec (inserted to prevent `R1 has pointer with unsupported alu operation`) */\
+	r1 -= r0;					\
 	r0 = *(u32*)(r1 + %[__sk_buff_mark]);		\
 	exit;						\
 "	:
@@ -121,13 +132,14 @@ l0_%=:	r1 -= r0;					\
 SEC("socket")
 __description("check deducing bounds from const, 8")
 __failure __msg("negative offset ctx ptr R1 off=-1 disallowed")
-__msg_unpriv("R1 has pointer with unsupported alu operation")
+__failure_unpriv
 __flag(BPF_F_ANY_ALIGNMENT)
 __naked void deducing_bounds_from_const_8(void)
 {
 	asm volatile ("					\
 	r0 = %[__imm_0];				\
 	if r0 s>= 0 goto l0_%=;				\
+	/* unpriv: nospec (inserted to prevent `R1 has pointer with unsupported alu operation`) */\
 	r1 += r0;					\
 l0_%=:	r0 = *(u32*)(r1 + %[__sk_buff_mark]);		\
 	exit;						\
@@ -140,13 +152,14 @@ l0_%=:	r0 = *(u32*)(r1 + %[__sk_buff_mark]);		\
 SEC("socket")
 __description("check deducing bounds from const, 9")
 __failure __msg("R0 tried to subtract pointer from scalar")
-__msg_unpriv("R1 has pointer with unsupported alu operation")
+__failure_unpriv
 __naked void deducing_bounds_from_const_9(void)
 {
 	asm volatile ("					\
 	r0 = 0;						\
 	if r0 s>= 0 goto l0_%=;				\
-l0_%=:	r0 -= r1;					\
+l0_%=:	/* unpriv: nospec (inserted to prevent `R1 has pointer with unsupported alu operation`) */\
+	r0 -= r1;					\
 	exit;						\
 "	::: __clobber_all);
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
index e2767d27d8aa..d7ab165fdc82 100644
--- a/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_map_ptr.c
@@ -113,9 +113,17 @@ __naked void ptr_read_ops_field_accepted(void)
 
 SEC("socket")
 __description("bpf_map_ptr: r = 0, map_ptr = map_ptr + r")
-__success __failure_unpriv
-__msg_unpriv("R1 has pointer with unsupported alu operation")
+__success __success_unpriv
 __retval(0)
+#ifdef SPEC_V1
+__xlated_unpriv("r1 = 0x") /* r0 = %[map_hash_16b] ll */
+/* This nospec is not really needed here, because there is no bypassable
+ * branch/store that could lead to r0 not containing 0 when `r1 += r0` executes.
+ * We still keep it like this to not complicate the verifier.
+ */
+__xlated_unpriv("nospec") /* inserted to prevent `R1 has pointer with unsupported alu operation` */
+__xlated_unpriv("r1 += r0")
+#endif
 __naked void map_ptr_map_ptr_r(void)
 {
 	asm volatile ("					\
@@ -137,9 +145,13 @@ __naked void map_ptr_map_ptr_r(void)
 
 SEC("socket")
 __description("bpf_map_ptr: r = 0, r = r + map_ptr")
-__success __failure_unpriv
-__msg_unpriv("R0 has pointer with unsupported alu operation")
+__success __success_unpriv
 __retval(0)
+#ifdef SPEC_V1
+__xlated_unpriv("r0 = 0x") /* r0 = %[map_hash_16b] ll */
+__xlated_unpriv("nospec") /* inserted to prevent `R0 has pointer with unsupported alu operation` */
+__xlated_unpriv("r1 += r0")
+#endif
 __naked void _0_r_r_map_ptr(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
index af7938ce56cb..b545f2b420b8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
+++ b/tools/testing/selftests/bpf/progs/verifier_value_ptr_arith.c
@@ -41,9 +41,17 @@ struct {
 
 SEC("socket")
 __description("map access: known scalar += value_ptr unknown vs const")
-__success __failure_unpriv
-__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__success __success_unpriv
 __retval(1)
+#ifdef SPEC_V1
+__xlated_unpriv("r1 &= 7")
+__xlated_unpriv("goto pc+1")
+/* l3_%=: */
+__xlated_unpriv("r1 = 3")
+/* l4_%=: */
+__xlated_unpriv("nospec") /* inserted to prevent `R1 tried to add from different maps, paths or scalars` */
+__xlated_unpriv("r1 += r0")
+#endif
 __naked void value_ptr_unknown_vs_const(void)
 {
 	asm volatile ("					\
@@ -79,9 +87,14 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: known scalar += value_ptr const vs unknown")
-__success __failure_unpriv
-__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__success __success_unpriv
 __retval(1)
+#ifdef SPEC_V1
+__xlated_unpriv("r1 &= 7")
+/* l4_%=: */
+__xlated_unpriv("nospec") /* inserted to prevent `R1 tried to add from different maps, paths or scalars` */
+__xlated_unpriv("r1 += r0")
+#endif
 __naked void value_ptr_const_vs_unknown(void)
 {
 	asm volatile ("					\
@@ -117,9 +130,16 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: known scalar += value_ptr const vs const (ne)")
-__success __failure_unpriv
-__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__success __success_unpriv
 __retval(1)
+#ifdef SPEC_V1
+__xlated_unpriv("goto pc+1") /* to l4, must not be pc+2 as this would skip nospec */
+/* l3_%=: */
+__xlated_unpriv("r1 = 5")
+/* l4_%=: */
+__xlated_unpriv("nospec") /* inserted to prevent `R1 tried to add from different maps, paths or scalars` */
+__xlated_unpriv("r1 += r0")
+#endif
 __naked void ptr_const_vs_const_ne(void)
 {
 	asm volatile ("					\
@@ -225,9 +245,18 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: known scalar += value_ptr unknown vs unknown (lt)")
-__success __failure_unpriv
-__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__success __success_unpriv
 __retval(1)
+#ifdef SPEC_V1
+__xlated_unpriv("r1 &= 3")
+__xlated_unpriv("goto pc+3") /* must go to l4 (nospec) */
+__xlated_unpriv("r1 = 6")
+__xlated_unpriv("r1 = r9")
+__xlated_unpriv("r1 &= 7")
+/* l4_%=: */
+__xlated_unpriv("nospec") /* inserted to prevent `R1 tried to add from different maps, paths or scalars` */
+__xlated_unpriv("r1 += r0")
+#endif
 __naked void ptr_unknown_vs_unknown_lt(void)
 {
 	asm volatile ("					\
@@ -270,9 +299,14 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: known scalar += value_ptr unknown vs unknown (gt)")
-__success __failure_unpriv
-__msg_unpriv("R1 tried to add from different maps, paths or scalars")
+__success __success_unpriv
 __retval(1)
+#ifdef SPEC_V1
+__xlated_unpriv("r1 &= 3")
+/* l4_%=: */
+__xlated_unpriv("nospec") /* inserted to prevent `R1 tried to add from different maps, paths or scalars` */
+__xlated_unpriv("r1 += r0")
+#endif
 __naked void ptr_unknown_vs_unknown_gt(void)
 {
 	asm volatile ("					\
@@ -408,9 +442,27 @@ l2_%=:	r0 = 1;						\
 
 SEC("socket")
 __description("map access: mixing value pointer and scalar, 1")
-__success __failure_unpriv
-__msg_unpriv("R2 tried to add from different maps, paths or scalars, pointer arithmetic with it prohibited for !root")
+__success __success_unpriv
 __retval(0)
+#ifdef SPEC_V1
+__xlated_unpriv("goto pc+2") /* to l2, must not be pc+3 as this would skip nospec */
+__xlated_unpriv("r2 = 0")
+__xlated_unpriv("r3 = 1048576")
+/* l2_%=: */
+__xlated_unpriv("nospec") /* inserted to prevent `R2 tried to add from different maps, paths or scalars, pointer arithmetic with it prohibited for !root` */
+__xlated_unpriv("r2 += r3")
+__xlated_unpriv("if r1 != 0x0 goto pc+1")
+__xlated_unpriv("goto pc+5") /* to l4 */
+/* l3_%=: */
+__xlated_unpriv("r0 = 322376503")
+__xlated_unpriv("nospec") /* inserted to prevent `R2 pointer comparison prohibited` */
+__xlated_unpriv("if r2 != 0x100000 goto pc+2") /* to l4 */
+__xlated_unpriv("r0 = 0")
+__xlated_unpriv("exit")
+/* l4_%=: */
+__xlated_unpriv("nospec")
+__xlated_unpriv("r0 = *(u8 *)(r0 +0)")
+#endif
 __naked void value_pointer_and_scalar_1(void)
 {
 	asm volatile ("					\
@@ -444,7 +496,6 @@ l2_%=:	/* common instruction */			\
 l3_%=:	/* branch B */					\
 	r0 = 0x13371337;				\
 	/* verifier follows fall-through */		\
-	/* unpriv: nospec (inserted to prevent `R2 pointer comparison prohibited`) */\
 	if r2 != 0x100000 goto l4_%=;			\
 	r0 = 0;						\
 	exit;						\
@@ -462,9 +513,24 @@ l4_%=:	/* fake-dead code; targeted from branch A to	\
 
 SEC("socket")
 __description("map access: mixing value pointer and scalar, 2")
-__success __failure_unpriv
-__msg_unpriv("R2 tried to add from different maps, paths or scalars, pointer arithmetic with it prohibited for !root")
+__success __success_unpriv
 __retval(0)
+#ifdef SPEC_V1
+__xlated_unpriv("goto pc+2")
+__xlated_unpriv("r2 = r0")
+__xlated_unpriv("r3 = 0")
+__xlated_unpriv("nospec")
+__xlated_unpriv("r2 += r3")
+__xlated_unpriv("if r1 != 0x0 goto pc+1")
+__xlated_unpriv("goto pc+5")
+__xlated_unpriv("r0 = 322376503")
+__xlated_unpriv("nospec")
+__xlated_unpriv("if r2 != 0x100000 goto pc+2")
+__xlated_unpriv("r0 = 0")
+__xlated_unpriv("exit")
+__xlated_unpriv("nospec") /* inserted to prevent `R0 invalid mem access 'scalar'` */
+__xlated_unpriv("r0 = *(u8 *)(r0 +0)")
+#endif
 __naked void value_pointer_and_scalar_2(void)
 {
 	asm volatile ("					\
@@ -505,7 +571,6 @@ l4_%=:	/* fake-dead code; targeted from branch A to	\
 	 * prevent dead code sanitization, rejected	\
 	 * via branch B however				\
 	 */						\
-	/* unpriv: nospec (inserted to prevent `R0 invalid mem access 'scalar'`) */\
 	r0 = *(u8*)(r0 + 0);				\
 	r0 = 0;						\
 	exit;						\
-- 
2.51.0


