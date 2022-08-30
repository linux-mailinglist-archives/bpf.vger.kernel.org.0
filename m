Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1961A5A615B
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 13:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiH3LKY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 07:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiH3LKV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 07:10:21 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B71B4C613
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 04:10:19 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxrmsS8A1jYF8MAA--.41314S3;
        Tue, 30 Aug 2022 19:10:13 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, loongarch@lists.linux.dev
Subject: [PATCH bpf-next v2 1/4] LoongArch: Move {signed,unsigned}_imm_check() to inst.h
Date:   Tue, 30 Aug 2022 19:10:06 +0800
Message-Id: <1661857809-10828-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1661857809-10828-1-git-send-email-yangtiezhu@loongson.cn>
References: <1661857809-10828-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8CxrmsS8A1jYF8MAA--.41314S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar17Gry5KFy8tF4xZF43KFg_yoW8uF48pF
        ZxZr4kGrWjgrn5AFyDKwn8XF98Crs7GwnIqa9xKa4xAF47XF1UXryv9rn8XFWjqa95uFW0
        gayfJr13ua1DJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB0b7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIE
        c7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I
        8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCF
        s4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_Gw4l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIrbbDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

{signed,unsigned}_imm_check() will also be used in the bpf jit, so move
them from module.c to inst.h, this is preparation for later patch.

By the way, no need to explicitly include asm/inst.h in module.c, because
the header file has been included indirectly.

  arch/loongarch/kernel/module.c
    include/linux/moduleloader.h
      include/linux/module.h
        arch/loongarch/include/asm/module.h
          arch/loongarch/include/asm/inst.h

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/inst.h | 10 ++++++++++
 arch/loongarch/kernel/module.c    | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index 7b07cbb..7b37509 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -166,4 +166,14 @@ u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm);
 u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
 u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned long pc, unsigned long dest);
 
+static inline bool signed_imm_check(long val, unsigned int bit)
+{
+	return -(1L << (bit - 1)) <= val && val < (1L << (bit - 1));
+}
+
+static inline bool unsigned_imm_check(unsigned long val, unsigned int bit)
+{
+	return val < (1UL << bit);
+}
+
 #endif /* _ASM_INST_H */
diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
index 638427f..edaee67 100644
--- a/arch/loongarch/kernel/module.c
+++ b/arch/loongarch/kernel/module.c
@@ -18,16 +18,6 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 
-static inline bool signed_imm_check(long val, unsigned int bit)
-{
-	return -(1L << (bit - 1)) <= val && val < (1L << (bit - 1));
-}
-
-static inline bool unsigned_imm_check(unsigned long val, unsigned int bit)
-{
-	return val < (1UL << bit);
-}
-
 static int rela_stack_push(s64 stack_value, s64 *rela_stack, size_t *rela_stack_top)
 {
 	if (*rela_stack_top >= RELA_STACK_DEPTH)
-- 
2.1.0

