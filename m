Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E086D2FB0
	for <lists+bpf@lfdr.de>; Sat,  1 Apr 2023 12:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjDAKnA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Apr 2023 06:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDAKm7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Apr 2023 06:42:59 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107D526A0;
        Sat,  1 Apr 2023 03:42:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PpYdj6qS1z4f3plF;
        Sat,  1 Apr 2023 18:42:49 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
        by APP4 (Coremail) with SMTP id gCh0CgBH96qqCihkGI77GQ--.56456S2;
        Sat, 01 Apr 2023 18:42:51 +0800 (CST)
From:   Xu Kuohai <xukuohai@huaweicloud.com>
To:     bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Florent Revest <revest@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH bpf-next] bpf, arm64: Fixed a BTI error on returning to patched function
Date:   Sat,  1 Apr 2023 19:41:44 -0400
Message-Id: <20230401234144.3719742-1-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH96qqCihkGI77GQ--.56456S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWrWxtF18Xr15uw45WFyDZFb_yoWrWrW3pw
        1DGr43Cr4vgr1UuFW8JF17Xr4YyF4DAF1UGFy7try5JF1Yq34UtF15t3y2grs8Gr15Zr13
        KFyqyr4Fk3WkXaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r4Y6ry7M2
        8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E
        3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gc
        CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
        r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87
        Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU0jYLPUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=3.9 required=5.0 tests=DATE_IN_FUTURE_12_24,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Xu Kuohai <xukuohai@huawei.com>

When BPF_TRAMP_F_CALL_ORIG is set, bpf trampoline uses BLR to jump
back to the instruction next to call site to call the patched function.
For BTI-enabled kernel, the instruction next to call site is usually
PACIASP, in this case, it's safe to jump back with BLR. But when
the call site is not followed by a PACIASP or bti, a BTI exception
is triggered.

Here is a fault log:

 Unhandled 64-bit el1h sync exception on CPU0, ESR 0x0000000034000002 -- BTI
 CPU: 0 PID: 263 Comm: test_progs Tainted: GF
 Hardware name: linux,dummy-virt (DT)
 pstate: 40400805 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=-c)
 pc : bpf_fentry_test1+0xc/0x30
 lr : bpf_trampoline_6442573892_0+0x48/0x1000
 sp : ffff80000c0c3a50
 x29: ffff80000c0c3a90 x28: ffff0000c2e6c080 x27: 0000000000000000
 x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000050
 x23: 0000000000000000 x22: 0000ffffcfd2a7f0 x21: 000000000000000a
 x20: 0000ffffcfd2a7f0 x19: 0000000000000000 x18: 0000000000000000
 x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffcfd2a7f0
 x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
 x11: 0000000000000000 x10: ffff80000914f5e4 x9 : ffff8000082a1528
 x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0101010101010101
 x5 : 0000000000000000 x4 : 00000000fffffff2 x3 : 0000000000000001
 x2 : ffff8001f4b82000 x1 : 0000000000000000 x0 : 0000000000000001
 Kernel panic - not syncing: Unhandled exception
 CPU: 0 PID: 263 Comm: test_progs Tainted: GF
 Hardware name: linux,dummy-virt (DT)
 Call trace:
  dump_backtrace+0xec/0x144
  show_stack+0x24/0x7c
  dump_stack_lvl+0x8c/0xb8
  dump_stack+0x18/0x34
  panic+0x1cc/0x3ec
  __el0_error_handler_common+0x0/0x130
  el1h_64_sync_handler+0x60/0xd0
  el1h_64_sync+0x78/0x7c
  bpf_fentry_test1+0xc/0x30
  bpf_fentry_test1+0xc/0x30
  bpf_prog_test_run_tracing+0xdc/0x2a0
  __sys_bpf+0x438/0x22a0
  __arm64_sys_bpf+0x30/0x54
  invoke_syscall+0x78/0x110
  el0_svc_common.constprop.0+0x6c/0x1d0
  do_el0_svc+0x38/0xe0
  el0_svc+0x30/0xd0
  el0t_64_sync_handler+0x1ac/0x1b0
  el0t_64_sync+0x1a0/0x1a4
 Kernel Offset: disabled
 CPU features: 0x0000,00034c24,f994fdab
 Memory Limit: none

And the instruction next to call site of bpf_fentry_test1 is ADD,
not PACIASP:

<bpf_fentry_test1>:
	bti     c
	nop
	nop
	add     w0, w0, #0x1
	paciasp

For bpf prog, jit always puts a PACIASP after call site for BTI-enabled
kernel, so there is no problem.

To fix it, replace BLR with RET to bypass the branch target check.

Fixes: efc9909fdce0 ("bpf, arm64: Add bpf trampoline for arm64")
Reported-by: Florent Revest <revest@chromium.org>
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arm64/net/bpf_jit.h      | 4 ++++
 arch/arm64/net/bpf_jit_comp.c | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index a6acb94ea3d6..c2edadb8ec6a 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -281,4 +281,8 @@
 /* DMB */
 #define A64_DMB_ISH aarch64_insn_gen_dmb(AARCH64_INSN_MB_ISH)
 
+/* ADR */
+#define A64_ADR(Rd, offset) \
+	aarch64_insn_gen_adr(0, offset, Rd, AARCH64_INSN_ADR_TYPE_ADR)
+
 #endif /* _BPF_JIT_H */
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 62f805f427b7..b26da8efa616 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1900,7 +1900,8 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 		restore_args(ctx, args_off, nargs);
 		/* call original func */
 		emit(A64_LDR64I(A64_R(10), A64_SP, retaddr_off), ctx);
-		emit(A64_BLR(A64_R(10)), ctx);
+		emit(A64_ADR(A64_LR, AARCH64_INSN_SIZE * 2), ctx);
+		emit(A64_RET(A64_R(10)), ctx);
 		/* store return value */
 		emit(A64_STR64I(A64_R(0), A64_SP, retval_off), ctx);
 		/* reserve a nop for bpf_tramp_image_put */
-- 
2.30.2

