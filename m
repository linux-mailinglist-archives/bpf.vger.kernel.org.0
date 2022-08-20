Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3FA59ADA8
	for <lists+bpf@lfdr.de>; Sat, 20 Aug 2022 13:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344838AbiHTLvL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Aug 2022 07:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345746AbiHTLvI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Aug 2022 07:51:08 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA17D248DA
        for <bpf@vger.kernel.org>; Sat, 20 Aug 2022 04:51:07 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxnmulygBjkwgGAA--.14449S4;
        Sat, 20 Aug 2022 19:51:02 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, loongarch@lists.linux.dev
Subject: [PATCH bpf-next v1 2/4] LoongArch: Add some instruction opcodes and formats
Date:   Sat, 20 Aug 2022 19:50:58 +0800
Message-Id: <1660996260-11337-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1660996260-11337-1-git-send-email-yangtiezhu@loongson.cn>
References: <1660996260-11337-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8BxnmulygBjkwgGAA--.14449S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWfXrW8uw1rGFW3Zr17GFg_yoWrZF15pa
        nrAwn0qrWrGr1Syr4xXFs3Gr43tr4rJr9rXFsxGr1akw13JF98Xa43Kr18CF98Grn5GF1j
        vrnxXw17KF1DWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBFb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv
        6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
        Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
        6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8KwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j4Hq7UUUUU=
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
 arch/loongarch/include/asm/inst.h | 122 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 117 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index 7b37509..de19a96 100644
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
@@ -40,6 +68,16 @@ enum reg2i12_op {
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
 };
 
 enum reg2i16_op {
@@ -52,6 +90,41 @@ enum reg2i16_op {
 	bgeu_op		= 0x1b,
 };
 
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
 struct reg0i26_format {
 	unsigned int immediate_h : 10;
 	unsigned int immediate_l : 16;
@@ -71,6 +144,26 @@ struct reg1i21_format {
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
@@ -78,6 +171,13 @@ struct reg2i12_format {
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
@@ -85,13 +185,25 @@ struct reg2i16_format {
 	unsigned int opcode : 6;
 };
 
+struct reg3_format {
+	unsigned int rd : 5;
+	unsigned int rj : 5;
+	unsigned int rk : 5;
+	unsigned int opcode : 17;
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
+	struct reg3_format	reg3_format;
 };
 
 #define LOONGARCH_INSN_SIZE	sizeof(union loongarch_instruction)
-- 
2.1.0

