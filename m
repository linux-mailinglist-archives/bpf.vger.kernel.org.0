Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4097E5A4139
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 05:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiH2DFc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Aug 2022 23:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiH2DF2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Aug 2022 23:05:28 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9957913EB2;
        Sun, 28 Aug 2022 20:05:26 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx5OHlLAxjCJ4LAA--.51514S2;
        Mon, 29 Aug 2022 11:05:10 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     bpf@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH bpf-next v2] bpf, mips: No need to use min() to get MAX_TAIL_CALL_CNT
Date:   Mon, 29 Aug 2022 11:05:09 +0800
Message-Id: <1661742309-2320-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8Bx5OHlLAxjCJ4LAA--.51514S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4UZr1xGF47CFy7CryrCrg_yoW5Gw18pr
        4rJwnxKr4qgr4fX3Z3Aa18Xw1rWFsY9rW7AFWjgFyIyan8WFn7WF13Kr15uFyYvrW8J3Wf
        XrWqkwn8u34kAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r48MxAI
        w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUghIDDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

MAX_TAIL_CALL_CNT is 33, so min(MAX_TAIL_CALL_CNT, 0xffff) is always
MAX_TAIL_CALL_CNT, it is better to use MAX_TAIL_CALL_CNT directly.

At the same time, add BUILD_BUG_ON(MAX_TAIL_CALL_CNT > 0xffff) with a
comment on why the assertion is there.

Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Suggested-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

v2: Add BUILD_BUG_ON(MAX_TAIL_CALL_CNT > 0xffff) with a comment
    suggested by Daniel and Johan, thank you.

 arch/mips/net/bpf_jit_comp32.c | 10 +++++++++-
 arch/mips/net/bpf_jit_comp64.c | 10 +++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp32.c
index 83c975d..ace5db3 100644
--- a/arch/mips/net/bpf_jit_comp32.c
+++ b/arch/mips/net/bpf_jit_comp32.c
@@ -1377,11 +1377,19 @@ void build_prologue(struct jit_context *ctx)
 	int stack, saved, locals, reserved;
 
 	/*
+	 * In the unlikely event that the TCC limit is raised to more
+	 * than 16 bits, it is clamped to the maximum value allowed for
+	 * the generated code (0xffff). It is better fail to compile
+	 * instead of degrading gracefully.
+	 */
+	BUILD_BUG_ON(MAX_TAIL_CALL_CNT > 0xffff);
+
+	/*
 	 * The first two instructions initialize TCC in the reserved (for us)
 	 * 16-byte area in the parent's stack frame. On a tail call, the
 	 * calling function jumps into the prologue after these instructions.
 	 */
-	emit(ctx, ori, MIPS_R_T9, MIPS_R_ZERO, min(MAX_TAIL_CALL_CNT, 0xffff));
+	emit(ctx, ori, MIPS_R_T9, MIPS_R_ZERO, MAX_TAIL_CALL_CNT);
 	emit(ctx, sw, MIPS_R_T9, 0, MIPS_R_SP);
 
 	/*
diff --git a/arch/mips/net/bpf_jit_comp64.c b/arch/mips/net/bpf_jit_comp64.c
index 6475828..0e7c1bd 100644
--- a/arch/mips/net/bpf_jit_comp64.c
+++ b/arch/mips/net/bpf_jit_comp64.c
@@ -548,11 +548,19 @@ void build_prologue(struct jit_context *ctx)
 	int stack, saved, locals, reserved;
 
 	/*
+	 * In the unlikely event that the TCC limit is raised to more
+	 * than 16 bits, it is clamped to the maximum value allowed for
+	 * the generated code (0xffff). It is better fail to compile
+	 * instead of degrading gracefully.
+	 */
+	BUILD_BUG_ON(MAX_TAIL_CALL_CNT > 0xffff);
+
+	/*
 	 * The first instruction initializes the tail call count register.
 	 * On a tail call, the calling function jumps into the prologue
 	 * after this instruction.
 	 */
-	emit(ctx, ori, tc, MIPS_R_ZERO, min(MAX_TAIL_CALL_CNT, 0xffff));
+	emit(ctx, ori, tc, MIPS_R_ZERO, MAX_TAIL_CALL_CNT);
 
 	/* === Entry-point for tail calls === */
 
-- 
2.1.0

