Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC57C5633A8
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 14:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbiGAMrq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Jul 2022 08:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236573AbiGAMrp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Jul 2022 08:47:45 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2291344E9
        for <bpf@vger.kernel.org>; Fri,  1 Jul 2022 05:47:43 -0700 (PDT)
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1o7G3h-00044J-Iz; Fri, 01 Jul 2022 14:47:41 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     andrii@kernel.org, john.fastabend@gmail.com, liulin063@gmail.com,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 2/4] bpf: Fix insufficient bounds propagation from adjust_scalar_min_max_vals
Date:   Fri,  1 Jul 2022 14:47:25 +0200
Message-Id: <20220701124727.11153-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220701124727.11153-1-daniel@iogearbox.net>
References: <20220701124727.11153-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26590/Fri Jul  1 09:25:21 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Kuee reported a corner case where the tnum becomes constant after the call
to __reg_bound_offset(), but the register's bounds are not, that is, its
min bounds are still not equal to the register's max bounds.

This in turn allows to leak pointers through turning a pointer register as
is into an unknown scalar via adjust_ptr_min_max_vals().

Before:

  func#0 @0
  0: R1=ctx(off=0,imm=0,umax=0,var_off=(0x0; 0x0)) R10=fp(off=0,imm=0,umax=0,var_off=(0x0; 0x0))
  0: (b7) r0 = 1                        ; R0_w=scalar(imm=1,umin=1,umax=1,var_off=(0x1; 0x0))
  1: (b7) r3 = 0                        ; R3_w=scalar(imm=0,umax=0,var_off=(0x0; 0x0))
  2: (87) r3 = -r3                      ; R3_w=scalar()
  3: (87) r3 = -r3                      ; R3_w=scalar()
  4: (47) r3 |= 32767                   ; R3_w=scalar(smin=-9223372036854743041,umin=32767,var_off=(0x7fff; 0xffffffffffff8000),s32_min=-2147450881)
  5: (75) if r3 s>= 0x0 goto pc+1       ; R3_w=scalar(umin=9223372036854808575,var_off=(0x8000000000007fff; 0x7fffffffffff8000),s32_min=-2147450881,u32_min=32767)
  6: (95) exit

  from 5 to 7: R0=scalar(imm=1,umin=1,umax=1,var_off=(0x1; 0x0)) R1=ctx(off=0,imm=0,umax=0,var_off=(0x0; 0x0)) R3=scalar(umin=32767,umax=9223372036854775807,var_off=(0x7fff; 0x7fffffffffff8000),s32_min=-2147450881) R10=fp(off=0,imm=0,umax=0,var_off=(0x0; 0x0))
  7: (d5) if r3 s<= 0x8000 goto pc+1    ; R3=scalar(umin=32769,umax=9223372036854775807,var_off=(0x7fff; 0x7fffffffffff8000),s32_min=-2147450881,u32_min=32767)
  8: (95) exit

  from 7 to 9: R0=scalar(imm=1,umin=1,umax=1,var_off=(0x1; 0x0)) R1=ctx(off=0,imm=0,umax=0,var_off=(0x0; 0x0)) R3=scalar(umin=32767,umax=32768,var_off=(0x7fff; 0x8000)) R10=fp(off=0,imm=0,umax=0,var_off=(0x0; 0x0))
  9: (07) r3 += -32767                  ; R3_w=scalar(imm=0,umax=1,var_off=(0x0; 0x0))  <--- [*]
  10: (95) exit

What can be seen here is that R3=scalar(umin=32767,umax=32768,var_off=(0x7fff;
0x8000)) after the operation R3 += -32767 results in a 'malformed' constant, that
is, R3_w=scalar(imm=0,umax=1,var_off=(0x0; 0x0)). Intersecting with var_off has
not been done at that point via __update_reg_bounds(), which would have improved
the umax to be equal to umin.

Refactor the tnum <> min/max bounds information flow into a reg_bounds_sync()
helper and use it consistently everywhere. After the fix, bounds have been
corrected to R3_w=scalar(imm=0,umax=0,var_off=(0x0; 0x0)) and thus the register
is regarded as a 'proper' constant scalar of 0.

After:

  func#0 @0
  0: R1=ctx(off=0,imm=0,umax=0,var_off=(0x0; 0x0)) R10=fp(off=0,imm=0,umax=0,var_off=(0x0; 0x0))
  0: (b7) r0 = 1                        ; R0_w=scalar(imm=1,umin=1,umax=1,var_off=(0x1; 0x0))
  1: (b7) r3 = 0                        ; R3_w=scalar(imm=0,umax=0,var_off=(0x0; 0x0))
  2: (87) r3 = -r3                      ; R3_w=scalar()
  3: (87) r3 = -r3                      ; R3_w=scalar()
  4: (47) r3 |= 32767                   ; R3_w=scalar(smin=-9223372036854743041,umin=32767,var_off=(0x7fff; 0xffffffffffff8000),s32_min=-2147450881)
  5: (75) if r3 s>= 0x0 goto pc+1       ; R3_w=scalar(umin=9223372036854808575,var_off=(0x8000000000007fff; 0x7fffffffffff8000),s32_min=-2147450881,u32_min=32767)
  6: (95) exit

  from 5 to 7: R0=scalar(imm=1,umin=1,umax=1,var_off=(0x1; 0x0)) R1=ctx(off=0,imm=0,umax=0,var_off=(0x0; 0x0)) R3=scalar(umin=32767,umax=9223372036854775807,var_off=(0x7fff; 0x7fffffffffff8000),s32_min=-2147450881) R10=fp(off=0,imm=0,umax=0,var_off=(0x0; 0x0))
  7: (d5) if r3 s<= 0x8000 goto pc+1    ; R3=scalar(umin=32769,umax=9223372036854775807,var_off=(0x7fff; 0x7fffffffffff8000),s32_min=-2147450881,u32_min=32767)
  8: (95) exit

  from 7 to 9: R0=scalar(imm=1,umin=1,umax=1,var_off=(0x1; 0x0)) R1=ctx(off=0,imm=0,umax=0,var_off=(0x0; 0x0)) R3=scalar(umin=32767,umax=32768,var_off=(0x7fff; 0x8000)) R10=fp(off=0,imm=0,umax=0,var_off=(0x0; 0x0))
  9: (07) r3 += -32767                  ; R3_w=scalar(imm=0,umax=0,var_off=(0x0; 0x0))  <--- [*]
  10: (95) exit

Fixes: b03c9f9fdc37 ("bpf/verifier: track signed and unsigned min/max values")
Reported-by: Kuee K1r0a <liulin063@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 kernel/bpf/verifier.c | 72 ++++++++++++++-----------------------------
 1 file changed, 23 insertions(+), 49 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ec164b3c0fa2..0efbac0fd126 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1562,6 +1562,21 @@ static void __reg_bound_offset(struct bpf_reg_state *reg)
 	reg->var_off = tnum_or(tnum_clear_subreg(var64_off), var32_off);
 }
 
+static void reg_bounds_sync(struct bpf_reg_state *reg)
+{
+	/* We might have learned new bounds from the var_off. */
+	__update_reg_bounds(reg);
+	/* We might have learned something about the sign bit. */
+	__reg_deduce_bounds(reg);
+	/* We might have learned some bits from the bounds. */
+	__reg_bound_offset(reg);
+	/* Intersecting with the old var_off might have improved our bounds
+	 * slightly, e.g. if umax was 0x7f...f and var_off was (0; 0xf...fc),
+	 * then new var_off is (0; 0x7f...fc) which improves our umax.
+	 */
+	__update_reg_bounds(reg);
+}
+
 static bool __reg32_bound_s64(s32 a)
 {
 	return a >= 0 && a <= S32_MAX;
@@ -1603,16 +1618,8 @@ static void __reg_combine_32_into_64(struct bpf_reg_state *reg)
 		 * so they do not impact tnum bounds calculation.
 		 */
 		__mark_reg64_unbounded(reg);
-		__update_reg_bounds(reg);
 	}
-
-	/* Intersecting with the old var_off might have improved our bounds
-	 * slightly.  e.g. if umax was 0x7f...f and var_off was (0; 0xf...fc),
-	 * then new var_off is (0; 0x7f...fc) which improves our umax.
-	 */
-	__reg_deduce_bounds(reg);
-	__reg_bound_offset(reg);
-	__update_reg_bounds(reg);
+	reg_bounds_sync(reg);
 }
 
 static bool __reg64_bound_s32(s64 a)
@@ -1628,7 +1635,6 @@ static bool __reg64_bound_u32(u64 a)
 static void __reg_combine_64_into_32(struct bpf_reg_state *reg)
 {
 	__mark_reg32_unbounded(reg);
-
 	if (__reg64_bound_s32(reg->smin_value) && __reg64_bound_s32(reg->smax_value)) {
 		reg->s32_min_value = (s32)reg->smin_value;
 		reg->s32_max_value = (s32)reg->smax_value;
@@ -1637,14 +1643,7 @@ static void __reg_combine_64_into_32(struct bpf_reg_state *reg)
 		reg->u32_min_value = (u32)reg->umin_value;
 		reg->u32_max_value = (u32)reg->umax_value;
 	}
-
-	/* Intersecting with the old var_off might have improved our bounds
-	 * slightly.  e.g. if umax was 0x7f...f and var_off was (0; 0xf...fc),
-	 * then new var_off is (0; 0x7f...fc) which improves our umax.
-	 */
-	__reg_deduce_bounds(reg);
-	__reg_bound_offset(reg);
-	__update_reg_bounds(reg);
+	reg_bounds_sync(reg);
 }
 
 /* Mark a register as having a completely unknown (scalar) value. */
@@ -6943,9 +6942,7 @@ static void do_refine_retval_range(struct bpf_reg_state *regs, int ret_type,
 	ret_reg->s32_max_value = meta->msize_max_value;
 	ret_reg->smin_value = -MAX_ERRNO;
 	ret_reg->s32_min_value = -MAX_ERRNO;
-	__reg_deduce_bounds(ret_reg);
-	__reg_bound_offset(ret_reg);
-	__update_reg_bounds(ret_reg);
+	reg_bounds_sync(ret_reg);
 }
 
 static int
@@ -8202,11 +8199,7 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 
 	if (!check_reg_sane_offset(env, dst_reg, ptr_reg->type))
 		return -EINVAL;
-
-	__update_reg_bounds(dst_reg);
-	__reg_deduce_bounds(dst_reg);
-	__reg_bound_offset(dst_reg);
-
+	reg_bounds_sync(dst_reg);
 	if (sanitize_check_bounds(env, insn, dst_reg) < 0)
 		return -EACCES;
 	if (sanitize_needed(opcode)) {
@@ -8944,10 +8937,7 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	/* ALU32 ops are zero extended into 64bit register */
 	if (alu32)
 		zext_32_to_64(dst_reg);
-
-	__update_reg_bounds(dst_reg);
-	__reg_deduce_bounds(dst_reg);
-	__reg_bound_offset(dst_reg);
+	reg_bounds_sync(dst_reg);
 	return 0;
 }
 
@@ -9136,10 +9126,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 							 insn->dst_reg);
 				}
 				zext_32_to_64(dst_reg);
-
-				__update_reg_bounds(dst_reg);
-				__reg_deduce_bounds(dst_reg);
-				__reg_bound_offset(dst_reg);
+				reg_bounds_sync(dst_reg);
 			}
 		} else {
 			/* case: R = imm
@@ -9742,21 +9729,8 @@ static void __reg_combine_min_max(struct bpf_reg_state *src_reg,
 							dst_reg->smax_value);
 	src_reg->var_off = dst_reg->var_off = tnum_intersect(src_reg->var_off,
 							     dst_reg->var_off);
-	/* We might have learned new bounds from the var_off. */
-	__update_reg_bounds(src_reg);
-	__update_reg_bounds(dst_reg);
-	/* We might have learned something about the sign bit. */
-	__reg_deduce_bounds(src_reg);
-	__reg_deduce_bounds(dst_reg);
-	/* We might have learned some bits from the bounds. */
-	__reg_bound_offset(src_reg);
-	__reg_bound_offset(dst_reg);
-	/* Intersecting with the old var_off might have improved our bounds
-	 * slightly.  e.g. if umax was 0x7f...f and var_off was (0; 0xf...fc),
-	 * then new var_off is (0; 0x7f...fc) which improves our umax.
-	 */
-	__update_reg_bounds(src_reg);
-	__update_reg_bounds(dst_reg);
+	reg_bounds_sync(src_reg);
+	reg_bounds_sync(dst_reg);
 }
 
 static void reg_combine_min_max(struct bpf_reg_state *true_src,
-- 
2.27.0

