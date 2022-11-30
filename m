Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF3163CDE2
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 04:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbiK3Dhb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 22:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiK3Dh2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 22:37:28 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A276D73BBF;
        Tue, 29 Nov 2022 19:37:25 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NMPz41THGz4f3mS4;
        Wed, 30 Nov 2022 11:37:20 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
        by APP2 (Coremail) with SMTP id Syh0CgBHXrnyz4ZjLguABQ--.10963S2;
        Wed, 30 Nov 2022 11:37:22 +0800 (CST)
From:   Pu Lehui <pulehui@huaweicloud.com>
To:     bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Pu Lehui <pulehui@huawei.com>,
        Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf] riscv, bpf: Emit fixed-length imm64 for BPF_PSEUDO_FUNC
Date:   Wed, 30 Nov 2022 11:38:06 +0800
Message-Id: <20221130033806.2967822-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBHXrnyz4ZjLguABQ--.10963S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFy5AFyxuryDur4UCF1DAwb_yoW8tFy5pr
        WUKr4fCFZ2qr1S9rnxtr1rXr15CF40qFsIgry3Way5Ga12qrsF93WDKw4Yka98ZFy8Gr15
        XFyUKF9xua4Dt3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvF14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        fUF0eHDUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Pu Lehui <pulehui@huawei.com>

For BPF_PSEUDO_FUNC instruction, verifier will refill imm with
correct addresses of bpf_calls and then run last pass of JIT.
Since the emit_imm of RV64 is variable-length, which will emit
appropriate length instructions accorroding to the imm, it may
broke ctx->offset, and lead to unpredictable problem, such as
inaccurate jump. So let's fix it with fixed-length imm64 insns.

Fixes: 69c087ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index eb99df41fa33..f984d5fa014b 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -139,6 +139,30 @@ static bool in_auipc_jalr_range(s64 val)
 		val < ((1L << 31) - (1L << 11));
 }
 
+/* Emit fixed-length instructions for 32-bit imm */
+static void emit_fixed_imm32(u8 rd, s32 val, struct rv_jit_context *ctx)
+{
+	s32 upper = (val + (1U << 11)) >> 12;
+	s32 lower = ((val & 0xfff) << 20) >> 20;
+
+	emit(rv_lui(rd, upper), ctx);
+	emit(rv_addi(rd, rd, lower), ctx);
+}
+
+/* Emit fixed-length instructions for 64-bit imm */
+static void emit_fixed_imm64(u8 rd, s64 val, struct rv_jit_context *ctx)
+{
+	/* Compensation for sign-extension of rv_addi */
+	s32 imm_hi = (val + (1U << 31)) >> 32;
+	s32 imm_lo = val;
+
+	emit_fixed_imm32(rd, imm_hi, ctx);
+	emit_fixed_imm32(RV_REG_T1, imm_lo, ctx);
+	emit(rv_slli(rd, rd, 32), ctx);
+	emit(rv_add(rd, rd, RV_REG_T1), ctx);
+}
+
+/* Emit variable-length instructions for 32-bit and 64-bit imm */
 static void emit_imm(u8 rd, s64 val, struct rv_jit_context *ctx)
 {
 	/* Note that the immediate from the add is sign-extended,
@@ -1053,7 +1077,12 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
 		u64 imm64;
 
 		imm64 = (u64)insn1.imm << 32 | (u32)imm;
-		emit_imm(rd, imm64, ctx);
+		if (bpf_pseudo_func(insn))
+			/* fixed-length insns for extra jit pass */
+			emit_fixed_imm64(rd, imm64, ctx);
+		else
+			emit_imm(rd, imm64, ctx);
+
 		return 1;
 	}
 
-- 
2.25.1

