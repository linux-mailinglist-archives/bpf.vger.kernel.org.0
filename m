Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D175A8B6D
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 04:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbiIAC1n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 22:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiIAC1l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 22:27:41 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9C8B136B05
        for <bpf@vger.kernel.org>; Wed, 31 Aug 2022 19:27:39 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXWuSGBBjOGUOAA--.1806S3;
        Thu, 01 Sep 2022 10:27:32 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, loongarch@lists.linux.dev
Subject: [PATCH bpf-next v3 1/4] LoongArch: Move {signed,unsigned}_imm_check() to inst.h
Date:   Thu,  1 Sep 2022 10:27:26 +0800
Message-Id: <1661999249-10258-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1661999249-10258-1-git-send-email-yangtiezhu@loongson.cn>
References: <1661999249-10258-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8BxXWuSGBBjOGUOAA--.1806S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar17Gry5KFy8tF4xZF43KFg_yoW8uF48pF
        ZxZr4kGrWjgrn5AFyDKwn8XF98Crs7GwnIqa9xKa4xAF47XF1UXryv9rn8XFWjqa95uFW0
        gayfJr13ua1DJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBFb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv
        6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
        Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
        6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8JwCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j07KxUUUUU=
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

