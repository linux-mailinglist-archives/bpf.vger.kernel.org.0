Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7999D19806E
	for <lists+bpf@lfdr.de>; Mon, 30 Mar 2020 18:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgC3QDm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Mar 2020 12:03:42 -0400
Received: from www62.your-server.de ([213.133.104.62]:56120 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729976AbgC3QDl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Mar 2020 12:03:41 -0400
Received: from 98.186.195.178.dynamic.wline.res.cust.swisscom.ch ([178.195.186.98] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jIwsz-000747-Ve; Mon, 30 Mar 2020 18:03:38 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     alexei.starovoitov@gmail.com
Cc:     jannh@google.com, yhs@fb.com, john.fastabend@gmail.com,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Subject: [PATCH bpf-next 1/3] bpf: Undo incorrect __reg_bound_offset32 handling
Date:   Mon, 30 Mar 2020 18:03:22 +0200
Message-Id: <20200330160324.15259-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200330160324.15259-1-daniel@iogearbox.net>
References: <20200330160324.15259-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25767/Mon Mar 30 15:08:30 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Anatoly has been fuzzing with kBdysch harness and reported a hang in
one of the outcomes:

  0: (b7) r0 = 808464432
  1: (7f) r0 >>= r0
  2: (14) w0 -= 808464432
  3: (07) r0 += 808464432
  4: (b7) r1 = 808464432
  5: (de) if w1 s<= w0 goto pc+0
   R0_w=invP(id=0,umin_value=808464432,umax_value=5103431727,var_off=(0x30303020;0x10000001f)) R1_w=invP808464432 R10=fp0
  6: (07) r0 += -2144337872
  7: (14) w0 -= -1607454672
  8: (25) if r0 > 0x30303030 goto pc+0
   R0_w=invP(id=0,umin_value=271581184,umax_value=271581311,var_off=(0x10300000;0x7f)) R1_w=invP808464432 R10=fp0
  9: (76) if w0 s>= 0x303030 goto pc+2
  12: (95) exit

  from 8 to 9: safe

  from 5 to 6: R0_w=invP(id=0,umin_value=808464432,umax_value=5103431727,var_off=(0x30303020;0x10000001f)) R1_w=invP808464432 R10=fp0
  6: (07) r0 += -2144337872
  7: (14) w0 -= -1607454672
  8: (25) if r0 > 0x30303030 goto pc+0
   R0_w=invP(id=0,umin_value=271581184,umax_value=271581311,var_off=(0x10300000;0x7f)) R1_w=invP808464432 R10=fp0
  9: safe

  from 8 to 9: safe
  verification time 589 usec
  stack depth 0
  processed 17 insns (limit 1000000) [...]

The underlying program was xlated as follows:

  # bpftool p d x i 9
   0: (b7) r0 = 808464432
   1: (7f) r0 >>= r0
   2: (14) w0 -= 808464432
   3: (07) r0 += 808464432
   4: (b7) r1 = 808464432
   5: (de) if w1 s<= w0 goto pc+0
   6: (07) r0 += -2144337872
   7: (14) w0 -= -1607454672
   8: (25) if r0 > 0x30303030 goto pc+0
   9: (76) if w0 s>= 0x303030 goto pc+2
  10: (05) goto pc-1
  11: (05) goto pc-1
  12: (95) exit

The verifier rewrote original instructions it recognized as dead code with
'goto pc-1', but reality differs from verifier simulation in that we're
actually able to trigger a hang due to hitting the 'goto pc-1' instructions.

Taking different examples to make the issue more obvious: in this example
we're probing bounds on a completely unknown scalar variable in r1:

  [...]
  5: R0_w=inv1 R1_w=inv(id=0) R10=fp0
  5: (18) r2 = 0x4000000000
  7: R0_w=inv1 R1_w=inv(id=0) R2_w=inv274877906944 R10=fp0
  7: (18) r3 = 0x2000000000
  9: R0_w=inv1 R1_w=inv(id=0) R2_w=inv274877906944 R3_w=inv137438953472 R10=fp0
  9: (18) r4 = 0x400
  11: R0_w=inv1 R1_w=inv(id=0) R2_w=inv274877906944 R3_w=inv137438953472 R4_w=inv1024 R10=fp0
  11: (18) r5 = 0x200
  13: R0_w=inv1 R1_w=inv(id=0) R2_w=inv274877906944 R3_w=inv137438953472 R4_w=inv1024 R5_w=inv512 R10=fp0
  13: (2d) if r1 > r2 goto pc+4
   R0_w=inv1 R1_w=inv(id=0,umax_value=274877906944,var_off=(0x0; 0x7fffffffff)) R2_w=inv274877906944 R3_w=inv137438953472 R4_w=inv1024 R5_w=inv512 R10=fp0
  14: R0_w=inv1 R1_w=inv(id=0,umax_value=274877906944,var_off=(0x0; 0x7fffffffff)) R2_w=inv274877906944 R3_w=inv137438953472 R4_w=inv1024 R5_w=inv512 R10=fp0
  14: (ad) if r1 < r3 goto pc+3
   R0_w=inv1 R1_w=inv(id=0,umin_value=137438953472,umax_value=274877906944,var_off=(0x0; 0x7fffffffff)) R2_w=inv274877906944 R3_w=inv137438953472 R4_w=inv1024 R5_w=inv512 R10=fp0
  15: R0=inv1 R1=inv(id=0,umin_value=137438953472,umax_value=274877906944,var_off=(0x0; 0x7fffffffff)) R2=inv274877906944 R3=inv137438953472 R4=inv1024 R5=inv512 R10=fp0
  15: (2e) if w1 > w4 goto pc+2
   R0=inv1 R1=inv(id=0,umin_value=137438953472,umax_value=274877906944,var_off=(0x0; 0x7f00000000)) R2=inv274877906944 R3=inv137438953472 R4=inv1024 R5=inv512 R10=fp0
  16: R0=inv1 R1=inv(id=0,umin_value=137438953472,umax_value=274877906944,var_off=(0x0; 0x7f00000000)) R2=inv274877906944 R3=inv137438953472 R4=inv1024 R5=inv512 R10=fp0
  16: (ae) if w1 < w5 goto pc+1
   R0=inv1 R1=inv(id=0,umin_value=137438953472,umax_value=274877906944,var_off=(0x0; 0x7f00000000)) R2=inv274877906944 R3=inv137438953472 R4=inv1024 R5=inv512 R10=fp0
  [...]

We're first probing lower/upper bounds via jmp64, later we do a similar
check via jmp32 and examine the resulting var_off there. After fall-through
in insn 14, we get the following bounded r1 with 0x7fffffffff unknown marked
bits in the variable section.

Thus, after knowing r1 <= 0x4000000000 and r1 >= 0x2000000000:

  max: 0b100000000000000000000000000000000000000 / 0x4000000000
  var: 0b111111111111111111111111111111111111111 / 0x7fffffffff
  min: 0b010000000000000000000000000000000000000 / 0x2000000000

Now, in insn 15 and 16, we perform a similar probe with lower/upper bounds
in jmp32.

Thus, after knowing r1 <= 0x4000000000 and r1 >= 0x2000000000 and
                    w1 <= 0x400        and w1 >= 0x200:

  max: 0b100000000000000000000000000000000000000 / 0x4000000000
  var: 0b111111100000000000000000000000000000000 / 0x7f00000000
  min: 0b010000000000000000000000000000000000000 / 0x2000000000

The lower/upper bounds haven't changed since they have high bits set in
u64 space and the jmp32 tests can only refine bounds in the low bits.

However, for the var part the expectation would have been 0x7f000007ff
or something less precise up to 0x7fffffffff. A outcome of 0x7f00000000
is not correct since it would contradict the earlier probed bounds
where we know that the result should have been in [0x200,0x400] in u32
space. Therefore, tests with such info will lead to wrong verifier
assumptions later on like falsely predicting conditional jumps to be
always taken, etc.

The issue here is that __reg_bound_offset32()'s implementation from
commit 581738a681b6 ("bpf: Provide better register bounds after jmp32
instructions") makes an incorrect range assumption:

  static void __reg_bound_offset32(struct bpf_reg_state *reg)
  {
        u64 mask = 0xffffFFFF;
        struct tnum range = tnum_range(reg->umin_value & mask,
                                       reg->umax_value & mask);
        struct tnum lo32 = tnum_cast(reg->var_off, 4);
        struct tnum hi32 = tnum_lshift(tnum_rshift(reg->var_off, 32), 32);

        reg->var_off = tnum_or(hi32, tnum_intersect(lo32, range));
  }

In the above walk-through example, __reg_bound_offset32() as-is chose
a range after masking with 0xffffffff of [0x0,0x0] since umin:0x2000000000
and umax:0x4000000000 and therefore the lo32 part was clamped to 0x0 as
well. However, in the umin:0x2000000000 and umax:0x4000000000 range above
we'd end up with an actual possible interval of [0x0,0xffffffff] for u32
space instead.

In case of the original reproducer, the situation looked as follows at
insn 5 for r0:

  [...]
  5: R0_w=invP(id=0,umin_value=808464432,umax_value=5103431727,var_off=(0x0; 0x1ffffffff)) R1_w=invP808464432 R10=fp0
                               0x30303030           0x13030302f
  5: (de) if w1 s<= w0 goto pc+0
   R0_w=invP(id=0,umin_value=808464432,umax_value=5103431727,var_off=(0x30303020; 0x10000001f)) R1_w=invP808464432 R10=fp0
                             0x30303030           0x13030302f
  [...]

After the fall-through, we similarly forced the var_off result into
the wrong range [0x30303030,0x3030302f] suggesting later on that fixed
bits must only be of 0x30303020 with 0x10000001f unknowns whereas such
assumption can only be made when both bounds in hi32 range match.

Originally, I was thinking to fix this by moving reg into a temp reg and
use proper coerce_reg_to_size() helper on the temp reg where we can then
based on that define the range tnum for later intersection:

  static void __reg_bound_offset32(struct bpf_reg_state *reg)
  {
        struct bpf_reg_state tmp = *reg;
        struct tnum lo32, hi32, range;

        coerce_reg_to_size(&tmp, 4);
        range = tnum_range(tmp.umin_value, tmp.umax_value);
        lo32 = tnum_cast(reg->var_off, 4);
        hi32 = tnum_lshift(tnum_rshift(reg->var_off, 32), 32);
        reg->var_off = tnum_or(hi32, tnum_intersect(lo32, range));
  }

In the case of the concrete example, this gives us a more conservative unknown
section. Thus, after knowing r1 <= 0x4000000000 and r1 >= 0x2000000000 and
                             w1 <= 0x400        and w1 >= 0x200:

  max: 0b100000000000000000000000000000000000000 / 0x4000000000
  var: 0b111111111111111111111111111111111111111 / 0x7fffffffff
  min: 0b010000000000000000000000000000000000000 / 0x2000000000

However, above new __reg_bound_offset32() has no effect on refining the
knowledge of the register contents. Meaning, if the bounds in hi32 range
mismatch we'll get the identity function given the range reg spans
[0x0,0xffffffff] and we cast var_off into lo32 only to later on binary
or it again with the hi32.

Likewise, if the bounds in hi32 range match, then we mask both bounds
with 0xffffffff, use the resulting umin/umax for the range to later
intersect the lo32 with it. However, _prior_ called __reg_bound_offset()
did already such intersection on the full reg and we therefore would only
repeat the same operation on the lo32 part twice.

Given this has no effect and the original commit had false assumptions,
this patch reverts the code entirely which is also more straight forward
for stable trees: apparently 581738a681b6 got auto-selected by Sasha's
ML system and misclassified as a fix, so it got sucked into v5.4 where
it should never have landed. A revert is low-risk also from a user PoV
since it requires a recent kernel and llc to opt-into -mcpu=v3 BPF CPU
to generate jmp32 instructions. A proper bounds refinement would need a
significantly more complex approach which is currently being worked, but
no stable material [0]. Hence revert is best option for stable. After the
revert, the original reported program gets rejected as follows:

  1: (7f) r0 >>= r0
  2: (14) w0 -= 808464432
  3: (07) r0 += 808464432
  4: (b7) r1 = 808464432
  5: (de) if w1 s<= w0 goto pc+0
   R0_w=invP(id=0,umin_value=808464432,umax_value=5103431727,var_off=(0x0; 0x1ffffffff)) R1_w=invP808464432 R10=fp0
  6: (07) r0 += -2144337872
  7: (14) w0 -= -1607454672
  8: (25) if r0 > 0x30303030 goto pc+0
   R0_w=invP(id=0,umax_value=808464432,var_off=(0x0; 0x3fffffff)) R1_w=invP808464432 R10=fp0
  9: (76) if w0 s>= 0x303030 goto pc+2
   R0=invP(id=0,umax_value=3158063,var_off=(0x0; 0x3fffff)) R1=invP808464432 R10=fp0
  10: (30) r0 = *(u8 *)skb[808464432]
  BPF_LD_[ABS|IND] uses reserved fields
  processed 11 insns (limit 1000000) [...]

  [0] https://lore.kernel.org/bpf/158507130343.15666.8018068546764556975.stgit@john-Precision-5820-Tower/T/

Fixes: 581738a681b6 ("bpf: Provide better register bounds after jmp32 instructions")
Reported-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 047b2e876399..2a84f73a93a1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1036,17 +1036,6 @@ static void __reg_bound_offset(struct bpf_reg_state *reg)
 						 reg->umax_value));
 }
 
-static void __reg_bound_offset32(struct bpf_reg_state *reg)
-{
-	u64 mask = 0xffffFFFF;
-	struct tnum range = tnum_range(reg->umin_value & mask,
-				       reg->umax_value & mask);
-	struct tnum lo32 = tnum_cast(reg->var_off, 4);
-	struct tnum hi32 = tnum_lshift(tnum_rshift(reg->var_off, 32), 32);
-
-	reg->var_off = tnum_or(hi32, tnum_intersect(lo32, range));
-}
-
 /* Reset the min/max bounds of a register */
 static void __mark_reg_unbounded(struct bpf_reg_state *reg)
 {
@@ -5805,10 +5794,6 @@ static void reg_set_min_max(struct bpf_reg_state *true_reg,
 	/* We might have learned some bits from the bounds. */
 	__reg_bound_offset(false_reg);
 	__reg_bound_offset(true_reg);
-	if (is_jmp32) {
-		__reg_bound_offset32(false_reg);
-		__reg_bound_offset32(true_reg);
-	}
 	/* Intersecting with the old var_off might have improved our bounds
 	 * slightly.  e.g. if umax was 0x7f...f and var_off was (0; 0xf...fc),
 	 * then new var_off is (0; 0x7f...fc) which improves our umax.
@@ -5918,10 +5903,6 @@ static void reg_set_min_max_inv(struct bpf_reg_state *true_reg,
 	/* We might have learned some bits from the bounds. */
 	__reg_bound_offset(false_reg);
 	__reg_bound_offset(true_reg);
-	if (is_jmp32) {
-		__reg_bound_offset32(false_reg);
-		__reg_bound_offset32(true_reg);
-	}
 	/* Intersecting with the old var_off might have improved our bounds
 	 * slightly.  e.g. if umax was 0x7f...f and var_off was (0; 0xf...fc),
 	 * then new var_off is (0; 0x7f...fc) which improves our umax.
-- 
2.20.1

