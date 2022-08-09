Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E54258D229
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 04:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiHICxR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 22:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiHICxN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 22:53:13 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 157D11E3E6
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 19:53:11 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxvyMNzPFiwLAKAA--.4926S3;
        Tue, 09 Aug 2022 10:53:03 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, loongarch@lists.linux.dev
Subject: [RFC PATCH 1/5] LoongArch: Fix some instruction formats
Date:   Tue,  9 Aug 2022 10:52:56 +0800
Message-Id: <1660013580-19053-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1660013580-19053-1-git-send-email-yangtiezhu@loongson.cn>
References: <1660013580-19053-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9DxvyMNzPFiwLAKAA--.4926S3
X-Coremail-Antispam: 1UD129KBjvJXoW7urW8GFWUAw1DJr43uw48JFb_yoW8Cr1kpr
        4Iyw1DKrWDGr1IvF95Aw4rXF1fJw4fG3s7XFsxtryUGrn0qFn8X347G345AFW8Ka18uF1Y
        vry3Xw17GF4DJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB2b7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280
        aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
        CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvj
        eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_Gr1l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcE_MUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

struct reg2i12_format is used to generate the instruction lu52id
in larch_insn_gen_lu52id(), according to the instruction format
of lu52id in LoongArch Reference Manual [1], the type of field
"immediate" should be "signed int" rather than "unsigned int".

There are similar problems in the other structs reg0i26_format,
reg1i20_format, reg1i21_format and reg2i16_format, fix them.

[1] https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#_lu12i_w_lu32i_d_lu52i_d

Fixes: b738c106f735 ("LoongArch: Add other common headers")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/inst.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index 7b07cbb..ff51481 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -53,35 +53,35 @@ enum reg2i16_op {
 };
 
 struct reg0i26_format {
-	unsigned int immediate_h : 10;
-	unsigned int immediate_l : 16;
+	signed int immediate_h : 10;
+	signed int immediate_l : 16;
 	unsigned int opcode : 6;
 };
 
 struct reg1i20_format {
 	unsigned int rd : 5;
-	unsigned int immediate : 20;
+	signed int immediate : 20;
 	unsigned int opcode : 7;
 };
 
 struct reg1i21_format {
-	unsigned int immediate_h  : 5;
+	signed int immediate_h  : 5;
 	unsigned int rj : 5;
-	unsigned int immediate_l : 16;
+	signed int immediate_l : 16;
 	unsigned int opcode : 6;
 };
 
 struct reg2i12_format {
 	unsigned int rd : 5;
 	unsigned int rj : 5;
-	unsigned int immediate : 12;
+	signed int immediate : 12;
 	unsigned int opcode : 10;
 };
 
 struct reg2i16_format {
 	unsigned int rd : 5;
 	unsigned int rj : 5;
-	unsigned int immediate : 16;
+	signed int immediate : 16;
 	unsigned int opcode : 6;
 };
 
-- 
2.1.0

