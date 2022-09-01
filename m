Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE505A8B6C
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 04:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiIAC1q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 22:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiIAC1p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 22:27:45 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD5DF12A5DD
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 19:27:43 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXWuSGBBjOGUOAA--.1806S4;
        Thu, 01 Sep 2022 10:27:34 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, loongarch@lists.linux.dev
Subject: [PATCH bpf-next v3 2/4] LoongArch: Add some instruction opcodes and formats
Date:   Thu,  1 Sep 2022 10:27:27 +0800
Message-Id: <1661999249-10258-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1661999249-10258-1-git-send-email-yangtiezhu@loongson.cn>
References: <1661999249-10258-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8BxXWuSGBBjOGUOAA--.1806S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWfXrW8uw1rGrW3ZrW7twb_yoW7Gr15pF
        srAwn8trWFgr1Syw4xXFs3Jr4ftr4rJr9rXFsxGry3Cw13JF98Xa43Kry8CF98Grn5GF1j
        vry3Xw17KF1DKaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280
        aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
        CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvj
        eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_Gr1l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUy5x6UUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

According to the "Table of Instruction Encoding" in LoongArch Reference
Manual [1], add some instruction opcodes and formats which are used in
the BPF JIT for LoongArch.

[1] https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#table-of-instruction-encoding

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/inst.h | 152 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 147 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index 7b37509..691170b 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -8,6 +8,8 @@
 #include <linux/types.h>
 #include <asm/asm.h>
 
+#define INSN_BREAK		0x002a0000
+
 #define ADDR_IMMMASK_LU52ID	0xFFF0000000000000
 #define ADDR_IMMMASK_LU32ID	0x000FFFFF00000000
 #define ADDR_IMMMASK_ADDU16ID	0x00000000FFFF0000
@@ -18,9 +20,14 @@
 
 #define ADDR_IMM(addr, INSN)	((addr & ADDR_IMMMASK_##INSN) >> ADDR_IMMSHIFT_##INSN)
 
+enum reg0i26_op {
+	b_op		= 0x14,
+};
+
 enum reg1i20_op {
 	lu12iw_op	= 0x0a,
 	lu32id_op	= 0x0b,
+	pcaddu18i_op	= 0x0f,
 };
 
 enum reg1i21_op {
@@ -28,10 +35,31 @@ enum reg1i21_op {
 	bnez_op		= 0x11,
 };
 
+enum reg2_op {
+	revb2h_op	= 0x0c,
+	revb2w_op	= 0x0e,
+	revbd_op	= 0x0f,
+};
+
+enum reg2i5_op {
+	slliw_op	= 0x81,
+	srliw_op	= 0x89,
+	sraiw_op	= 0x91,
+};
+
+enum reg2i6_op {
+	sllid_op	= 0x41,
+	srlid_op	= 0x45,
+	sraid_op	= 0x49,
+};
+
 enum reg2i12_op {
 	addiw_op	= 0x0a,
 	addid_op	= 0x0b,
 	lu52id_op	= 0x0c,
+	andi_op		= 0x0d,
+	ori_op		= 0x0e,
+	xori_op		= 0x0f,
 	ldb_op		= 0xa0,
 	ldh_op		= 0xa1,
 	ldw_op		= 0xa2,
@@ -40,6 +68,20 @@ enum reg2i12_op {
 	sth_op		= 0xa5,
 	stw_op		= 0xa6,
 	std_op		= 0xa7,
+	ldbu_op		= 0xa8,
+	ldhu_op		= 0xa9,
+	ldwu_op		= 0xaa,
+};
+
+enum reg2i14_op {
+	llw_op		= 0x20,
+	scw_op		= 0x21,
+	lld_op		= 0x22,
+	scd_op		= 0x23,
+	ldptrw_op	= 0x24,
+	stptrw_op	= 0x25,
+	ldptrd_op	= 0x26,
+	stptrd_op	= 0x27,
 };
 
 enum reg2i16_op {
@@ -52,6 +94,49 @@ enum reg2i16_op {
 	bgeu_op		= 0x1b,
 };
 
+enum reg2bstrd_op {
+	bstrpickd_op	= 0x3,
+};
+
+enum reg3_op {
+	addd_op		= 0x21,
+	subd_op		= 0x23,
+	and_op		= 0x29,
+	or_op		= 0x2a,
+	xor_op		= 0x2b,
+	sllw_op		= 0x2e,
+	srlw_op		= 0x2f,
+	sraw_op		= 0x30,
+	slld_op		= 0x31,
+	srld_op		= 0x32,
+	srad_op		= 0x33,
+	muld_op		= 0x3b,
+	divdu_op	= 0x46,
+	moddu_op	= 0x47,
+	ldxd_op		= 0x7018,
+	stxb_op		= 0x7020,
+	stxh_op		= 0x7028,
+	stxw_op		= 0x7030,
+	stxd_op		= 0x7038,
+	ldxbu_op	= 0x7040,
+	ldxhu_op	= 0x7048,
+	ldxwu_op	= 0x7050,
+	amswapw_op	= 0x70c0,
+	amswapd_op	= 0x70c1,
+	amaddw_op	= 0x70c2,
+	amaddd_op	= 0x70c3,
+	amandw_op	= 0x70c4,
+	amandd_op	= 0x70c5,
+	amorw_op	= 0x70c6,
+	amord_op	= 0x70c7,
+	amxorw_op	= 0x70c8,
+	amxord_op	= 0x70c9,
+};
+
+enum reg3sa2_op {
+	alsld_op	= 0x16,
+};
+
 struct reg0i26_format {
 	unsigned int immediate_h : 10;
 	unsigned int immediate_l : 16;
@@ -71,6 +156,26 @@ struct reg1i21_format {
 	unsigned int opcode : 6;
 };
 
+struct reg2_format {
+	unsigned int rd : 5;
+	unsigned int rj : 5;
+	unsigned int opcode : 22;
+};
+
+struct reg2i5_format {
+	unsigned int rd : 5;
+	unsigned int rj : 5;
+	unsigned int immediate : 5;
+	unsigned int opcode : 17;
+};
+
+struct reg2i6_format {
+	unsigned int rd : 5;
+	unsigned int rj : 5;
+	unsigned int immediate : 6;
+	unsigned int opcode : 16;
+};
+
 struct reg2i12_format {
 	unsigned int rd : 5;
 	unsigned int rj : 5;
@@ -78,6 +183,13 @@ struct reg2i12_format {
 	unsigned int opcode : 10;
 };
 
+struct reg2i14_format {
+	unsigned int rd : 5;
+	unsigned int rj : 5;
+	unsigned int immediate : 14;
+	unsigned int opcode : 8;
+};
+
 struct reg2i16_format {
 	unsigned int rd : 5;
 	unsigned int rj : 5;
@@ -85,13 +197,43 @@ struct reg2i16_format {
 	unsigned int opcode : 6;
 };
 
+struct reg2bstrd_format {
+	unsigned int rd : 5;
+	unsigned int rj : 5;
+	unsigned int lsbd : 6;
+	unsigned int msbd : 6;
+	unsigned int opcode : 10;
+};
+
+struct reg3_format {
+	unsigned int rd : 5;
+	unsigned int rj : 5;
+	unsigned int rk : 5;
+	unsigned int opcode : 17;
+};
+
+struct reg3sa2_format {
+	unsigned int rd : 5;
+	unsigned int rj : 5;
+	unsigned int rk : 5;
+	unsigned int immediate : 2;
+	unsigned int opcode : 15;
+};
+
 union loongarch_instruction {
 	unsigned int word;
-	struct reg0i26_format reg0i26_format;
-	struct reg1i20_format reg1i20_format;
-	struct reg1i21_format reg1i21_format;
-	struct reg2i12_format reg2i12_format;
-	struct reg2i16_format reg2i16_format;
+	struct reg0i26_format	reg0i26_format;
+	struct reg1i20_format	reg1i20_format;
+	struct reg1i21_format	reg1i21_format;
+	struct reg2_format	reg2_format;
+	struct reg2i5_format	reg2i5_format;
+	struct reg2i6_format	reg2i6_format;
+	struct reg2i12_format	reg2i12_format;
+	struct reg2i14_format	reg2i14_format;
+	struct reg2i16_format	reg2i16_format;
+	struct reg2bstrd_format	reg2bstrd_format;
+	struct reg3_format	reg3_format;
+	struct reg3sa2_format	reg3sa2_format;
 };
 
 #define LOONGARCH_INSN_SIZE	sizeof(union loongarch_instruction)
-- 
2.1.0

