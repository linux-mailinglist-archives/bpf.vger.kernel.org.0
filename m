Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C546D6C3AD2
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 20:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjCUTk0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 15:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjCUTj7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 15:39:59 -0400
X-Greylist: delayed 125 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Mar 2023 12:39:34 PDT
Received: from www62.your-server.de (www62.your-server.de [IPv6:2a01:4f8:d0a:276a::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB0B44BA
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 12:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=OBl2Y/mLYP19EvKpnKt0Ab8or8d/Rqpr5JhWCwdn07Q=; b=Xywv00TyVb7W0RFdXdF/vqEcD/
        VCzYyI47OThu+TuVSKdiX7/bwCdXCk/pCiiZtU1xxBiNW78NNhu7D62gjiZCvtKJoJpHFkQkw5o3/
        sXEcP2x0fQvN+dyBatI0w44ovaKQwrwCXwUEqCgjEWZDeVbMHsmt0sISBdZjQOtClj5YX2GP91qL8
        8FPf7qZyXgmyC3ntoz48GVRDhHORcXAKt4GbqniD/JXTLaBEI2XCtrwGEXCQkdPy0mIKjWcexY0V9
        Tm6BiO0vSnlMSCmfsYD+xAW4GyQtuvzoeQe4g/A8gKVgpN4z533FTE0MwzFVVQmym/D/lIZd0y9vY
        y+x7P1iQ==;
Received: from [81.6.34.132] (helo=localhost)
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pehkG-000CQP-GU; Tue, 21 Mar 2023 20:34:08 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     bpf@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Xu Kuohai <xukuohai@huaweicloud.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: Fix __reg_bound_offset 64->32 var_off subreg propagation
Date:   Tue, 21 Mar 2023 20:33:53 +0100
Message-Id: <20230321193354.10445-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26850/Tue Mar 21 08:22:52 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Xu reports that after commit 3f50f132d840 ("bpf: Verifier, do explicit ALU32
bounds tracking"), the following BPF program is rejected by the verifier:

   0: (61) r2 = *(u32 *)(r1 +0)          ; R2_w=pkt(off=0,r=0,imm=0)
   1: (61) r3 = *(u32 *)(r1 +4)          ; R3_w=pkt_end(off=0,imm=0)
   2: (bf) r1 = r2
   3: (07) r1 += 1
   4: (2d) if r1 > r3 goto pc+8
   5: (71) r1 = *(u8 *)(r2 +0)           ; R1_w=scalar(umax=255,var_off=(0x0; 0xff))
   6: (18) r0 = 0x7fffffffffffff10
   8: (0f) r1 += r0                      ; R1_w=scalar(umin=0x7fffffffffffff10,umax=0x800000000000000f)
   9: (18) r0 = 0x8000000000000000
  11: (07) r0 += 1
  12: (ad) if r0 < r1 goto pc-2
  13: (b7) r0 = 0
  14: (95) exit

And the verifier log says:

  func#0 @0
  0: R1=ctx(off=0,imm=0) R10=fp0
  0: (61) r2 = *(u32 *)(r1 +0)          ; R1=ctx(off=0,imm=0) R2_w=pkt(off=0,r=0,imm=0)
  1: (61) r3 = *(u32 *)(r1 +4)          ; R1=ctx(off=0,imm=0) R3_w=pkt_end(off=0,imm=0)
  2: (bf) r1 = r2                       ; R1_w=pkt(off=0,r=0,imm=0) R2_w=pkt(off=0,r=0,imm=0)
  3: (07) r1 += 1                       ; R1_w=pkt(off=1,r=0,imm=0)
  4: (2d) if r1 > r3 goto pc+8          ; R1_w=pkt(off=1,r=1,imm=0) R3_w=pkt_end(off=0,imm=0)
  5: (71) r1 = *(u8 *)(r2 +0)           ; R1_w=scalar(umax=255,var_off=(0x0; 0xff)) R2_w=pkt(off=0,r=1,imm=0)
  6: (18) r0 = 0x7fffffffffffff10       ; R0_w=9223372036854775568
  8: (0f) r1 += r0                      ; R0_w=9223372036854775568 R1_w=scalar(umin=9223372036854775568,umax=9223372036854775823,s32_min=-240,s32_max=15)
  9: (18) r0 = 0x8000000000000000       ; R0_w=-9223372036854775808
  11: (07) r0 += 1                      ; R0_w=-9223372036854775807
  12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775807 R1_w=scalar(umin=9223372036854775568,umax=9223372036854775809)
  13: (b7) r0 = 0                       ; R0_w=0
  14: (95) exit

  from 12 to 11: R0_w=-9223372036854775807 R1_w=scalar(umin=9223372036854775810,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff)) R2_w=pkt(off=0,r=1,imm=0) R3_w=pkt_end(off=0,imm=0) R10=fp0
  11: (07) r0 += 1                      ; R0_w=-9223372036854775806
  12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775806 R1_w=scalar(umin=9223372036854775810,umax=9223372036854775810,var_off=(0x8000000000000000; 0xffffffff))
  13: safe

  [...]

  from 12 to 11: R0_w=-9223372036854775795 R1=scalar(umin=9223372036854775822,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff)) R2=pkt(off=0,r=1,imm=0) R3=pkt_end(off=0,imm=0) R10=fp0
  11: (07) r0 += 1                      ; R0_w=-9223372036854775794
  12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775794 R1=scalar(umin=9223372036854775822,umax=9223372036854775822,var_off=(0x8000000000000000; 0xffffffff))
  13: safe

  from 12 to 11: R0_w=-9223372036854775794 R1=scalar(umin=9223372036854775823,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff)) R2=pkt(off=0,r=1,imm=0) R3=pkt_end(off=0,imm=0) R10=fp0
  11: (07) r0 += 1                      ; R0_w=-9223372036854775793
  12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775793 R1=scalar(umin=9223372036854775823,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff))
  13: safe

  from 12 to 11: R0_w=-9223372036854775793 R1=scalar(umin=9223372036854775824,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff)) R2=pkt(off=0,r=1,imm=0) R3=pkt_end(off=0,imm=0) R10=fp0
  11: (07) r0 += 1                      ; R0_w=-9223372036854775792
  12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775792 R1=scalar(umin=9223372036854775824,umax=9223372036854775823,var_off=(0x8000000000000000; 0xffffffff))
  13: safe

  [...]

The 64bit umin=9223372036854775810 bound continuously bumps by +1 while
umax=9223372036854775823 stays as-is until the verifier complexity limit
is reached and the program gets finally rejected. During this simulation,
the umin also eventually surpasses umax. Looking at the first 'from 12
to 11' output line from the loop, R1 has the following state:

  R1_w=scalar(umin=0x8000000000000002 (9223372036854775810),
              umax=0x800000000000000f (9223372036854775823),
          var_off=(0x8000000000000000;
                           0xffffffff))

The var_off has technically not an inconsistent state but it's very
imprecise and far off surpassing 64bit umax bounds whereas the expected
output refining bits in var_off should have been like:

  R1_w=scalar(umin=0x8000000000000002 (9223372036854775810),
              umax=0x800000000000000f (9223372036854775823),
          var_off=(0x8000000000000000;
                                  0xf))

In the above log, var_off stays as var_off=(0x8000000000000000; 0xffffffff)
and does not converge into a narrower mask where more bits become known,
eventually transforming R1 into a constant upon umin=9223372036854775823,
umax=9223372036854775823 case where the verifier would have terminated and
let the program pass.

The __reg_combine_64_into_32() marks the subregister unknown and propagates
64bit {s,u}min/{s,u}max bounds to their 32bit equivalents iff they are within
the 32bit universe. The question came up whether __reg_combine_64_into_32()
should special case the situation that when 64bit {s,u}min bounds have
the same value as 64bit {s,u}max bounds to then assign the latter as
well to the 32bit reg->{s,u}32_{min,max}_value. As can be seen from the
above example however, that is just /one/ special case and not a /generic/
solution given above example would still not be addressed this way and
remain at an imprecise var_off=(0x8000000000000000; 0xffffffff).

The improvement is needed in __reg_bound_offset() to refine var32_off with
the updated var64_off instead of the prior reg->var_off. The reg_bounds_sync()
code first refines information about the register's min/max bounds via
__update_reg_bounds() from the current var_off, then in __reg_deduce_bounds()
from sign bit and with the potentially learned bits from bounds it'll
update the var_off tnum in __reg_bound_offset(). For example, intersecting
with the old var_off might have improved bounds slightly, e.g. if umax
was 0x7f...f and var_off was (0; 0xf...fc), then new var_off will then
result in (0; 0x7f...fc). The intersected var64_off holds then the
universe which is a superset of var32_off. The point for the latter is
not to broaden, but to further refine known bits based on the intersection
of var_off with 32 bit bounds, so that we later construct the final var_off
from upper and lower 32 bits. The final __update_reg_bounds() can then
potentially refine bounds if more bits became known from new var_off.

After the improvement, we can see R1 converging successively:

  func#0 @0
  0: R1=ctx(off=0,imm=0) R10=fp0
  0: (61) r2 = *(u32 *)(r1 +0)          ; R1=ctx(off=0,imm=0) R2_w=pkt(off=0,r=0,imm=0)
  1: (61) r3 = *(u32 *)(r1 +4)          ; R1=ctx(off=0,imm=0) R3_w=pkt_end(off=0,imm=0)
  2: (bf) r1 = r2                       ; R1_w=pkt(off=0,r=0,imm=0) R2_w=pkt(off=0,r=0,imm=0)
  3: (07) r1 += 1                       ; R1_w=pkt(off=1,r=0,imm=0)
  4: (2d) if r1 > r3 goto pc+8          ; R1_w=pkt(off=1,r=1,imm=0) R3_w=pkt_end(off=0,imm=0)
  5: (71) r1 = *(u8 *)(r2 +0)           ; R1_w=scalar(umax=255,var_off=(0x0; 0xff)) R2_w=pkt(off=0,r=1,imm=0)
  6: (18) r0 = 0x7fffffffffffff10       ; R0_w=9223372036854775568
  8: (0f) r1 += r0                      ; R0_w=9223372036854775568 R1_w=scalar(umin=9223372036854775568,umax=9223372036854775823,s32_min=-240,s32_max=15)
  9: (18) r0 = 0x8000000000000000       ; R0_w=-9223372036854775808
  11: (07) r0 += 1                      ; R0_w=-9223372036854775807
  12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775807 R1_w=scalar(umin=9223372036854775568,umax=9223372036854775809)
  13: (b7) r0 = 0                       ; R0_w=0
  14: (95) exit

  from 12 to 11: R0_w=-9223372036854775807 R1_w=scalar(umin=9223372036854775810,umax=9223372036854775823,var_off=(0x8000000000000000; 0xf),s32_min=0,s32_max=15,u32_max=15) R2_w=pkt(off=0,r=1,imm=0) R3_w=pkt_end(off=0,imm=0) R10=fp0
  11: (07) r0 += 1                      ; R0_w=-9223372036854775806
  12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775806 R1_w=-9223372036854775806
  13: safe

  from 12 to 11: R0_w=-9223372036854775806 R1_w=scalar(umin=9223372036854775811,umax=9223372036854775823,var_off=(0x8000000000000000; 0xf),s32_min=0,s32_max=15,u32_max=15) R2_w=pkt(off=0,r=1,imm=0) R3_w=pkt_end(off=0,imm=0) R10=fp0
  11: (07) r0 += 1                      ; R0_w=-9223372036854775805
  12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775805 R1_w=-9223372036854775805
  13: safe

  [...]

  from 12 to 11: R0_w=-9223372036854775798 R1=scalar(umin=9223372036854775819,umax=9223372036854775823,var_off=(0x8000000000000008; 0x7),s32_min=8,s32_max=15,u32_min=8,u32_max=15) R2=pkt(off=0,r=1,imm=0) R3=pkt_end(off=0,imm=0) R10=fp0
  11: (07) r0 += 1                      ; R0_w=-9223372036854775797
  12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775797 R1=-9223372036854775797
  13: safe

  from 12 to 11: R0_w=-9223372036854775797 R1=scalar(umin=9223372036854775820,umax=9223372036854775823,var_off=(0x800000000000000c; 0x3),s32_min=12,s32_max=15,u32_min=12,u32_max=15) R2=pkt(off=0,r=1,imm=0) R3=pkt_end(off=0,imm=0) R10=fp0
  11: (07) r0 += 1                      ; R0_w=-9223372036854775796
  12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775796 R1=-9223372036854775796
  13: safe

  from 12 to 11: R0_w=-9223372036854775796 R1=scalar(umin=9223372036854775821,umax=9223372036854775823,var_off=(0x800000000000000c; 0x3),s32_min=12,s32_max=15,u32_min=12,u32_max=15) R2=pkt(off=0,r=1,imm=0) R3=pkt_end(off=0,imm=0) R10=fp0
  11: (07) r0 += 1                      ; R0_w=-9223372036854775795
  12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775795 R1=-9223372036854775795
  13: safe

  from 12 to 11: R0_w=-9223372036854775795 R1=scalar(umin=9223372036854775822,umax=9223372036854775823,var_off=(0x800000000000000e; 0x1),s32_min=14,s32_max=15,u32_min=14,u32_max=15) R2=pkt(off=0,r=1,imm=0) R3=pkt_end(off=0,imm=0) R10=fp0
  11: (07) r0 += 1                      ; R0_w=-9223372036854775794
  12: (ad) if r0 < r1 goto pc-2         ; R0_w=-9223372036854775794 R1=-9223372036854775794
  13: safe

  from 12 to 11: R0_w=-9223372036854775794 R1=-9223372036854775793 R2=pkt(off=0,r=1,imm=0) R3=pkt_end(off=0,imm=0) R10=fp0
  11: (07) r0 += 1                      ; R0_w=-9223372036854775793
  12: (ad) if r0 < r1 goto pc-2
  last_idx 12 first_idx 12
  parent didn't have regs=1 stack=0 marks: R0_rw=P-9223372036854775801 R1_r=scalar(umin=9223372036854775815,umax=9223372036854775823,var_off=(0x8000000000000000; 0xf),s32_min=0,s32_max=15,u32_max=15) R2=pkt(off=0,r=1,imm=0) R3=pkt_end(off=0,imm=0) R10=fp0
  last_idx 11 first_idx 11
  regs=1 stack=0 before 11: (07) r0 += 1
  parent didn't have regs=1 stack=0 marks: R0_rw=P-9223372036854775805 R1_rw=scalar(umin=9223372036854775812,umax=9223372036854775823,var_off=(0x8000000000000000; 0xf),s32_min=0,s32_max=15,u32_max=15) R2_w=pkt(off=0,r=1,imm=0) R3_w=pkt_end(off=0,imm=0) R10=fp0
  last_idx 12 first_idx 0
  regs=1 stack=0 before 12: (ad) if r0 < r1 goto pc-2
  regs=1 stack=0 before 11: (07) r0 += 1
  regs=1 stack=0 before 12: (ad) if r0 < r1 goto pc-2
  regs=1 stack=0 before 11: (07) r0 += 1
  regs=1 stack=0 before 12: (ad) if r0 < r1 goto pc-2
  regs=1 stack=0 before 11: (07) r0 += 1
  regs=1 stack=0 before 9: (18) r0 = 0x8000000000000000
  last_idx 12 first_idx 12
  parent didn't have regs=2 stack=0 marks: R0_rw=P-9223372036854775801 R1_r=Pscalar(umin=9223372036854775815,umax=9223372036854775823,var_off=(0x8000000000000000; 0xf),s32_min=0,s32_max=15,u32_max=15) R2=pkt(off=0,r=1,imm=0) R3=pkt_end(off=0,imm=0) R10=fp0
  last_idx 11 first_idx 11
  regs=2 stack=0 before 11: (07) r0 += 1
  parent didn't have regs=2 stack=0 marks: R0_rw=P-9223372036854775805 R1_rw=Pscalar(umin=9223372036854775812,umax=9223372036854775823,var_off=(0x8000000000000000; 0xf),s32_min=0,s32_max=15,u32_max=15) R2_w=pkt(off=0,r=1,imm=0) R3_w=pkt_end(off=0,imm=0) R10=fp0
  last_idx 12 first_idx 0
  regs=2 stack=0 before 12: (ad) if r0 < r1 goto pc-2
  regs=2 stack=0 before 11: (07) r0 += 1
  regs=2 stack=0 before 12: (ad) if r0 < r1 goto pc-2
  regs=2 stack=0 before 11: (07) r0 += 1
  regs=2 stack=0 before 12: (ad) if r0 < r1 goto pc-2
  regs=2 stack=0 before 11: (07) r0 += 1
  regs=2 stack=0 before 9: (18) r0 = 0x8000000000000000
  regs=2 stack=0 before 8: (0f) r1 += r0
  regs=3 stack=0 before 6: (18) r0 = 0x7fffffffffffff10
  regs=2 stack=0 before 5: (71) r1 = *(u8 *)(r2 +0)
  13: safe

  from 4 to 13: safe
  verification time 322 usec
  stack depth 0
  processed 56 insns (limit 1000000) max_states_per_insn 1 total_states 3 peak_states 3 mark_read 1

Fixes: 3f50f132d840 ("bpf: Verifier, do explicit ALU32 bounds tracking")
Reported-by: Xu Kuohai <xukuohai@huaweicloud.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/bpf/20230314203424.4015351-2-xukuohai@huaweicloud.com
---
 kernel/bpf/verifier.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d517d13878cf..d66e70707172 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1823,9 +1823,9 @@ static void __reg_bound_offset(struct bpf_reg_state *reg)
 	struct tnum var64_off = tnum_intersect(reg->var_off,
 					       tnum_range(reg->umin_value,
 							  reg->umax_value));
-	struct tnum var32_off = tnum_intersect(tnum_subreg(reg->var_off),
-						tnum_range(reg->u32_min_value,
-							   reg->u32_max_value));
+	struct tnum var32_off = tnum_intersect(tnum_subreg(var64_off),
+					       tnum_range(reg->u32_min_value,
+							  reg->u32_max_value));
 
 	reg->var_off = tnum_or(tnum_clear_subreg(var64_off), var32_off);
 }
-- 
2.27.0

