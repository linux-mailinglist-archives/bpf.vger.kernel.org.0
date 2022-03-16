Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038734DB5BF
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 17:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243895AbiCPQQW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 12:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350101AbiCPQQV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 12:16:21 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7680DEB4
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 09:15:05 -0700 (PDT)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KJZx81Qyxz1GCV0;
        Thu, 17 Mar 2022 00:10:04 +0800 (CST)
Received: from huawei.com (10.67.174.197) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 00:15:01 +0800
From:   Xu Kuohai <xukuohai@huawei.com>
To:     <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Julien Thierry <jthierry@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Hou Tao <houtao1@huawei.com>, Fuad Tabba <tabba@google.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH -next v3 1/4] arm64: insn: add ldr/str with immediate offset
Date:   Wed, 16 Mar 2022 12:26:18 -0400
Message-ID: <20220316162621.3842604-2-xukuohai@huawei.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220316162621.3842604-1-xukuohai@huawei.com>
References: <20220316162621.3842604-1-xukuohai@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.197]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch introduces ldr/str with immediate offset support to simplify
the JIT implementation of BPF LDX/STX instructions on arm64. Although
arm64 ldr/str immediate is available in pre-index, post-index and
unsigned offset forms, the unsigned offset form is sufficient for BPF,
so this patch only adds this type.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arm64/include/asm/insn.h |  9 +++++
 arch/arm64/lib/insn.c         | 67 +++++++++++++++++++++++++++--------
 2 files changed, 62 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 0b6b31307e68..d507acfdf02d 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -200,6 +200,8 @@ enum aarch64_insn_size_type {
 enum aarch64_insn_ldst_type {
 	AARCH64_INSN_LDST_LOAD_REG_OFFSET,
 	AARCH64_INSN_LDST_STORE_REG_OFFSET,
+	AARCH64_INSN_LDST_LOAD_IMM_OFFSET,
+	AARCH64_INSN_LDST_STORE_IMM_OFFSET,
 	AARCH64_INSN_LDST_LOAD_PAIR_PRE_INDEX,
 	AARCH64_INSN_LDST_STORE_PAIR_PRE_INDEX,
 	AARCH64_INSN_LDST_LOAD_PAIR_POST_INDEX,
@@ -334,6 +336,7 @@ __AARCH64_INSN_FUNCS(load_pre,	0x3FE00C00, 0x38400C00)
 __AARCH64_INSN_FUNCS(store_post,	0x3FE00C00, 0x38000400)
 __AARCH64_INSN_FUNCS(load_post,	0x3FE00C00, 0x38400400)
 __AARCH64_INSN_FUNCS(str_reg,	0x3FE0EC00, 0x38206800)
+__AARCH64_INSN_FUNCS(str_imm,	0x3FC00000, 0x39000000)
 __AARCH64_INSN_FUNCS(ldadd,	0x3F20FC00, 0x38200000)
 __AARCH64_INSN_FUNCS(ldclr,	0x3F20FC00, 0x38201000)
 __AARCH64_INSN_FUNCS(ldeor,	0x3F20FC00, 0x38202000)
@@ -341,6 +344,7 @@ __AARCH64_INSN_FUNCS(ldset,	0x3F20FC00, 0x38203000)
 __AARCH64_INSN_FUNCS(swp,	0x3F20FC00, 0x38208000)
 __AARCH64_INSN_FUNCS(cas,	0x3FA07C00, 0x08A07C00)
 __AARCH64_INSN_FUNCS(ldr_reg,	0x3FE0EC00, 0x38606800)
+__AARCH64_INSN_FUNCS(ldr_imm,	0x3FC00000, 0x39400000)
 __AARCH64_INSN_FUNCS(ldr_lit,	0xBF000000, 0x18000000)
 __AARCH64_INSN_FUNCS(ldrsw_lit,	0xFF000000, 0x98000000)
 __AARCH64_INSN_FUNCS(exclusive,	0x3F800000, 0x08000000)
@@ -500,6 +504,11 @@ u32 aarch64_insn_gen_load_store_reg(enum aarch64_insn_register reg,
 				    enum aarch64_insn_register offset,
 				    enum aarch64_insn_size_type size,
 				    enum aarch64_insn_ldst_type type);
+u32 aarch64_insn_gen_load_store_imm(enum aarch64_insn_register reg,
+				    enum aarch64_insn_register base,
+				    unsigned int imm,
+				    enum aarch64_insn_size_type size,
+				    enum aarch64_insn_ldst_type type);
 u32 aarch64_insn_gen_load_store_pair(enum aarch64_insn_register reg1,
 				     enum aarch64_insn_register reg2,
 				     enum aarch64_insn_register base,
diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index 5e90887deec4..695d7368fadc 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -299,29 +299,24 @@ static u32 aarch64_insn_encode_register(enum aarch64_insn_register_type type,
 	return insn;
 }
 
+static const u32 aarch64_insn_ldst_size[] = {
+	[AARCH64_INSN_SIZE_8] = 0,
+	[AARCH64_INSN_SIZE_16] = 1,
+	[AARCH64_INSN_SIZE_32] = 2,
+	[AARCH64_INSN_SIZE_64] = 3,
+};
+
 static u32 aarch64_insn_encode_ldst_size(enum aarch64_insn_size_type type,
 					 u32 insn)
 {
 	u32 size;
 
-	switch (type) {
-	case AARCH64_INSN_SIZE_8:
-		size = 0;
-		break;
-	case AARCH64_INSN_SIZE_16:
-		size = 1;
-		break;
-	case AARCH64_INSN_SIZE_32:
-		size = 2;
-		break;
-	case AARCH64_INSN_SIZE_64:
-		size = 3;
-		break;
-	default:
+	if (type < AARCH64_INSN_SIZE_8 || type > AARCH64_INSN_SIZE_64) {
 		pr_err("%s: unknown size encoding %d\n", __func__, type);
 		return AARCH64_BREAK_FAULT;
 	}
 
+	size = aarch64_insn_ldst_size[type];
 	insn &= ~GENMASK(31, 30);
 	insn |= size << 30;
 
@@ -504,6 +499,50 @@ u32 aarch64_insn_gen_load_store_reg(enum aarch64_insn_register reg,
 					    offset);
 }
 
+u32 aarch64_insn_gen_load_store_imm(enum aarch64_insn_register reg,
+				    enum aarch64_insn_register base,
+				    unsigned int imm,
+				    enum aarch64_insn_size_type size,
+				    enum aarch64_insn_ldst_type type)
+{
+	u32 insn;
+	u32 shift;
+
+	if (size < AARCH64_INSN_SIZE_8 || size > AARCH64_INSN_SIZE_64) {
+		pr_err("%s: unknown size encoding %d\n", __func__, type);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	shift = aarch64_insn_ldst_size[size];
+	if (imm & ~(BIT(12 + shift) - BIT(shift))) {
+		pr_err("%s: invalid imm: %d\n", __func__, imm);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	imm >>= shift;
+
+	switch (type) {
+	case AARCH64_INSN_LDST_LOAD_IMM_OFFSET:
+		insn = aarch64_insn_get_ldr_imm_value();
+		break;
+	case AARCH64_INSN_LDST_STORE_IMM_OFFSET:
+		insn = aarch64_insn_get_str_imm_value();
+		break;
+	default:
+		pr_err("%s: unknown load/store encoding %d\n", __func__, type);
+		return AARCH64_BREAK_FAULT;
+	}
+
+	insn = aarch64_insn_encode_ldst_size(size, insn);
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RT, insn, reg);
+
+	insn = aarch64_insn_encode_register(AARCH64_INSN_REGTYPE_RN, insn,
+					    base);
+
+	return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_12, insn, imm);
+}
+
 u32 aarch64_insn_gen_load_store_pair(enum aarch64_insn_register reg1,
 				     enum aarch64_insn_register reg2,
 				     enum aarch64_insn_register base,
-- 
2.30.2

