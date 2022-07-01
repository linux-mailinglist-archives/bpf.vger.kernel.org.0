Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA2A5633A7
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 14:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236639AbiGAMrp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Jul 2022 08:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236576AbiGAMrp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Jul 2022 08:47:45 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A7D34648
        for <bpf@vger.kernel.org>; Fri,  1 Jul 2022 05:47:43 -0700 (PDT)
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1o7G3h-00044B-2A; Fri, 01 Jul 2022 14:47:41 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@kernel.org
Cc:     andrii@kernel.org, john.fastabend@gmail.com, liulin063@gmail.com,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 1/4] bpf: Fix incorrect verifier simulation around jmp32's jeq/jne
Date:   Fri,  1 Jul 2022 14:47:24 +0200
Message-Id: <20220701124727.11153-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
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

Kuee reported a quirk in the jmp32's jeq/jne simulation, namely that the
register value does not match expectations for the fall-through path. For
example:

Before fix:

  0: R1=ctx(off=0,imm=0) R10=fp0
  0: (b7) r2 = 0                        ; R2_w=P0
  1: (b7) r6 = 563                      ; R6_w=P563
  2: (87) r2 = -r2                      ; R2_w=Pscalar()
  3: (87) r2 = -r2                      ; R2_w=Pscalar()
  4: (4c) w2 |= w6                      ; R2_w=Pscalar(umin=563,umax=4294967295,var_off=(0x233; 0xfffffdcc),s32_min=-2147483085) R6_w=P563
  5: (56) if w2 != 0x8 goto pc+1        ; R2_w=P571  <--- [*]
  6: (95) exit
  R0 !read_ok

After fix:

  0: R1=ctx(off=0,imm=0) R10=fp0
  0: (b7) r2 = 0                        ; R2_w=P0
  1: (b7) r6 = 563                      ; R6_w=P563
  2: (87) r2 = -r2                      ; R2_w=Pscalar()
  3: (87) r2 = -r2                      ; R2_w=Pscalar()
  4: (4c) w2 |= w6                      ; R2_w=Pscalar(umin=563,umax=4294967295,var_off=(0x233; 0xfffffdcc),s32_min=-2147483085) R6_w=P563
  5: (56) if w2 != 0x8 goto pc+1        ; R2_w=P8  <--- [*]
  6: (95) exit
  R0 !read_ok

As can be seen on line 5 for the branch fall-through path in R2 [*] is that
given condition w2 != 0x8 is false, verifier should conclude that r2 = 8 as
upper 32 bit are known to be zero. However, verifier incorrectly concludes
that r2 = 571 which is far off.

The problem is it only marks false{true}_reg as known in the switch for JE/NE
case, but at the end of the function, it uses {false,true}_{64,32}off to
update {false,true}_reg->var_off and they still hold the prior value of
{false,true}_reg->var_off before it got marked as known. The subsequent
__reg_combine_32_into_64() then propagates this old var_off and derives new
bounds. The information between min/max bounds on {false,true}_reg from
setting the register to known const combined with the {false,true}_reg->var_off
based on the old information then derives wrong register data.

Fix it by detangling the BPF_JEQ/BPF_JNE cases and updating relevant
{false,true}_{64,32}off tnums along with the register marking to known
constant.

Fixes: 3f50f132d840 ("bpf: Verifier, do explicit ALU32 bounds tracking")
Reported-by: Kuee K1r0a <liulin063@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 kernel/bpf/verifier.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index aedac2ac02b9..ec164b3c0fa2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9577,26 +9577,33 @@ static void reg_set_min_max(struct bpf_reg_state *true_reg,
 		return;
 
 	switch (opcode) {
+	/* JEQ/JNE comparison doesn't change the register equivalence.
+	 *
+	 * r1 = r2;
+	 * if (r1 == 42) goto label;
+	 * ...
+	 * label: // here both r1 and r2 are known to be 42.
+	 *
+	 * Hence when marking register as known preserve it's ID.
+	 */
 	case BPF_JEQ:
+		if (is_jmp32) {
+			__mark_reg32_known(true_reg, val32);
+			true_32off = tnum_subreg(true_reg->var_off);
+		} else {
+			___mark_reg_known(true_reg, val);
+			true_64off = true_reg->var_off;
+		}
+		break;
 	case BPF_JNE:
-	{
-		struct bpf_reg_state *reg =
-			opcode == BPF_JEQ ? true_reg : false_reg;
-
-		/* JEQ/JNE comparison doesn't change the register equivalence.
-		 * r1 = r2;
-		 * if (r1 == 42) goto label;
-		 * ...
-		 * label: // here both r1 and r2 are known to be 42.
-		 *
-		 * Hence when marking register as known preserve it's ID.
-		 */
-		if (is_jmp32)
-			__mark_reg32_known(reg, val32);
-		else
-			___mark_reg_known(reg, val);
+		if (is_jmp32) {
+			__mark_reg32_known(false_reg, val32);
+			false_32off = tnum_subreg(false_reg->var_off);
+		} else {
+			___mark_reg_known(false_reg, val);
+			false_64off = false_reg->var_off;
+		}
 		break;
-	}
 	case BPF_JSET:
 		if (is_jmp32) {
 			false_32off = tnum_and(false_32off, tnum_const(~val32));
-- 
2.27.0

