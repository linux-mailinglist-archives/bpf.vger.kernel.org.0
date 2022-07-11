Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7131570665
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 16:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiGKO7U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 10:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiGKO7R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 10:59:17 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E105D52FFF;
        Mon, 11 Jul 2022 07:59:15 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LhRl74QgJzVfbj;
        Mon, 11 Jul 2022 22:55:31 +0800 (CST)
Received: from huawei.com (10.67.174.197) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Jul
 2022 22:59:10 +0800
From:   Xu Kuohai <xukuohai@huawei.com>
To:     <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Will Deacon <will@kernel.org>, KP Singh <kpsingh@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        James Morse <james.morse@arm.com>,
        Hou Tao <houtao1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH bpf-next v9 2/4] arm64: Add LDR (literal) instruction
Date:   Mon, 11 Jul 2022 11:08:21 -0400
Message-ID: <20220711150823.2128542-3-xukuohai@huawei.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220711150823.2128542-1-xukuohai@huawei.com>
References: <20220711150823.2128542-1-xukuohai@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.197]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add LDR (literal) instruction to load data from address relative to PC.
This instruction will be used to implement long jump from bpf prog to
bpf trampoline in the follow-up patch.

The instruction encoding:

    3       2   2     2                                     0        0
    0       7   6     4                                     5        0
+-----+-------+---+-----+-------------------------------------+--------+
| 0 x | 0 1 1 | 0 | 0 0 |                imm19                |   Rt   |
+-----+-------+---+-----+-------------------------------------+--------+

for 32-bit, variant x == 0; for 64-bit, x == 1.

branch_imm_common() is used to check the distance between pc and target
address, since it's reused by this patch and LDR (literal) is not a branch
instruction, rename it to label_imm_common().

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 arch/arm64/include/asm/insn.h |  3 +++
 arch/arm64/lib/insn.c         | 30 ++++++++++++++++++++++++++----
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 6aa2dc836db1..834bff720582 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -510,6 +510,9 @@ u32 aarch64_insn_gen_load_store_imm(enum aarch64_insn_register reg,
 				    unsigned int imm,
 				    enum aarch64_insn_size_type size,
 				    enum aarch64_insn_ldst_type type);
+u32 aarch64_insn_gen_load_literal(unsigned long pc, unsigned long addr,
+				  enum aarch64_insn_register reg,
+				  bool is64bit);
 u32 aarch64_insn_gen_load_store_pair(enum aarch64_insn_register reg1,
 				     enum aarch64_insn_register reg2,
 				     enum aarch64_insn_register base,
diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index 695d7368fadc..49e972beeac7 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -323,7 +323,7 @@ static u32 aarch64_insn_encode_ldst_size(enum aarch64_insn_size_type type,
 	return insn;
 }
 
-static inline long branch_imm_common(unsigned long pc, unsigned long addr,
+static inline long label_imm_common(unsigned long pc, unsigned long addr,
 				     long range)
 {
 	long offset;
@@ -354,7 +354,7 @@ u32 __kprobes aarch64_insn_gen_branch_imm(unsigned long pc, unsigned long addr,
 	 * ARM64 virtual address arrangement guarantees all kernel and module
 	 * texts are within +/-128M.
 	 */
-	offset = branch_imm_common(pc, addr, SZ_128M);
+	offset = label_imm_common(pc, addr, SZ_128M);
 	if (offset >= SZ_128M)
 		return AARCH64_BREAK_FAULT;
 
@@ -382,7 +382,7 @@ u32 aarch64_insn_gen_comp_branch_imm(unsigned long pc, unsigned long addr,
 	u32 insn;
 	long offset;
 
-	offset = branch_imm_common(pc, addr, SZ_1M);
+	offset = label_imm_common(pc, addr, SZ_1M);
 	if (offset >= SZ_1M)
 		return AARCH64_BREAK_FAULT;
 
@@ -421,7 +421,7 @@ u32 aarch64_insn_gen_cond_branch_imm(unsigned long pc, unsigned long addr,
 	u32 insn;
 	long offset;
 
-	offset = branch_imm_common(pc, addr, SZ_1M);
+	offset = label_imm_common(pc, addr, SZ_1M);
 
 	insn = aarch64_insn_get_bcond_value();
 
@@ -543,6 +543,28 @@ u32 aarch64_insn_gen_load_store_imm(enum aarch64_insn_register reg,
 	return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_12, insn, imm);
 }
 
+u32 aarch64_insn_gen_load_literal(unsigned long pc, unsigned long addr,
+				  enum aarch64_insn_register reg,
+				  bool is64bit)
+{
+	u32 insn;
+	long offset;
+
+	offset = label_imm_common(pc, addr, SZ_1M);
+	if (offset >= SZ_1M)
+		return AARCH64_BREAK_FAULT;
+
+	insn = aarch64_insn_get_ldr_lit_value();
+
+	if (is64bit)
+		insn |= BIT(30);
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT, insn, reg);
+
+	return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_19, insn,
+					     offset >> 2);
+}
+
 u32 aarch64_insn_gen_load_store_pair(enum aarch64_insn_register reg1,
 				     enum aarch64_insn_register reg2,
 				     enum aarch64_insn_register base,
-- 
2.30.2

