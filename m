Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A921F5F9BF5
	for <lists+bpf@lfdr.de>; Mon, 10 Oct 2022 11:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiJJJcn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 05:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiJJJck (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 05:32:40 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AFCA537EF;
        Mon, 10 Oct 2022 02:32:38 -0700 (PDT)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxkOCl5kNjKPwpAA--.21250S6;
        Mon, 10 Oct 2022 17:32:26 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH 4/7] LoongArch: Add gpr-num.h
Date:   Mon, 10 Oct 2022 17:32:17 +0800
Message-Id: <1665394340-13906-5-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1665394340-13906-1-git-send-email-tangyouling@loongson.cn>
References: <1665394340-13906-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8CxkOCl5kNjKPwpAA--.21250S6
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1xWrW8AFy3XFyDZr4rGrg_yoW8Ar18pF
        srArs5Gayv9a93Jw4rtF13urn8KFn5Xr1qqFZxA34jyr4qq3WkJr1vkF90kry3Aa1UXrWr
        Wa4fta1UWF1YkaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPGb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
        jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI
        8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04
        v7MxkIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
        0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
        0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv2
        0xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
        Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIF
        yTuYvjxUxpnmDUUUU
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In subsequent patches we'll need to map the same GPR names to integer
constants so that we can use this to build metadata for exception
fixups.

The compiler treats gpr 0 as zero, not $r0, so set it separately to
.L__gpr_num_zero, otherwise the following assembly error will occur,

{standard input}: Assembler messages:
{standard input}:1074: Error: invalid operands (*UND* and *ABS* sections) for `<<'
{standard input}:1160: Error: invalid operands (*UND* and *ABS* sections) for `<<'
make[1]: *** [scripts/Makefile.build:249: fs/fcntl.o] Error 1

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/loongarch/include/asm/gpr-num.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 arch/loongarch/include/asm/gpr-num.h

diff --git a/arch/loongarch/include/asm/gpr-num.h b/arch/loongarch/include/asm/gpr-num.h
new file mode 100644
index 000000000000..e0941af20c7e
--- /dev/null
+++ b/arch/loongarch/include/asm/gpr-num.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_GPR_NUM_H
+#define __ASM_GPR_NUM_H
+
+#ifdef __ASSEMBLY__
+
+	.equ	.L__gpr_num_zero, 0
+	.irp	num,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
+	.equ	.L__gpr_num_$r\num, \num
+	.endr
+
+#else /* __ASSEMBLY__ */
+
+#define __DEFINE_ASM_GPR_NUMS					\
+"	.equ	.L__gpr_num_zero, 0\n"				\
+"	.irp	num,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31\n" \
+"	.equ	.L__gpr_num_$r\\num, \\num\n"			\
+"	.endr\n"						\
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_GPR_NUM_H */
-- 
2.36.1

