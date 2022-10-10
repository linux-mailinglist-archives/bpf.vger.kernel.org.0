Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572115F9BF7
	for <lists+bpf@lfdr.de>; Mon, 10 Oct 2022 11:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiJJJcp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 05:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiJJJcn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 05:32:43 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3893A32BAC;
        Mon, 10 Oct 2022 02:32:40 -0700 (PDT)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxkOCl5kNjKPwpAA--.21250S7;
        Mon, 10 Oct 2022 17:32:27 +0800 (CST)
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
Subject: [PATCH 5/7] LoongArch: extable: Add a dedicated uaccess handler
Date:   Mon, 10 Oct 2022 17:32:18 +0800
Message-Id: <1665394340-13906-6-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1665394340-13906-1-git-send-email-tangyouling@loongson.cn>
References: <1665394340-13906-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8CxkOCl5kNjKPwpAA--.21250S7
X-Coremail-Antispam: 1UD129KBjvJXoW3JF4rGF47tFyUCFWUWrWfXwb_yoWxJw45pF
        1qkF97KrW5Kr1fur9rK3ZrZr15Krs7Kw1qkas3Ka4vkF12v3WrCF109rykJFyDAa97Ja4I
        qw1fuw15Wr43Zw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv2
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

Inspired by commit 2e77a62cb3a6("arm64: extable: add a dedicated uaccess
handler"), do similar to LoongArch to add a dedicated uaccess exception
handler to update registers in exception context and subsequently return
back into the function which faulted, so we remove the need for fixups
specialized to each faulting instruction.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/loongarch/include/asm/asm-extable.h | 22 +++++++++++++++++++
 arch/loongarch/include/asm/futex.h       | 22 ++++++-------------
 arch/loongarch/include/asm/uaccess.h     | 17 ++++-----------
 arch/loongarch/mm/extable.c              | 27 +++++++++++++++++++++++-
 4 files changed, 58 insertions(+), 30 deletions(-)

diff --git a/arch/loongarch/include/asm/asm-extable.h b/arch/loongarch/include/asm/asm-extable.h
index 634bd770e3c4..f5502cb50c6e 100644
--- a/arch/loongarch/include/asm/asm-extable.h
+++ b/arch/loongarch/include/asm/asm-extable.h
@@ -4,6 +4,7 @@
 
 #define EX_TYPE_NONE			0
 #define EX_TYPE_FIXUP			1
+#define EX_TYPE_UACCESS_ERR_ZERO	2
 
 #ifdef __ASSEMBLY__
 
@@ -24,6 +25,7 @@
 
 #include <linux/bits.h>
 #include <linux/stringify.h>
+#include <asm/gpr-num.h>
 
 #define __ASM_EXTABLE_RAW(insn, fixup, type, data)	\
 	".pushsection	__ex_table, \"a\"\n"		\
@@ -37,6 +39,26 @@
 #define _ASM_EXTABLE(insn, fixup)	\
 	__ASM_EXTABLE_RAW(#insn, #fixup, __stringify(EX_TYPE_FIXUP), "0")
 
+#define EX_DATA_REG_ERR_SHIFT	0
+#define EX_DATA_REG_ERR		GENMASK(4, 0)
+#define EX_DATA_REG_ZERO_SHIFT	5
+#define EX_DATA_REG_ZERO	GENMASK(9, 5)
+
+#define EX_DATA_REG(reg, gpr)						\
+	"((.L__gpr_num_" #gpr ") << " __stringify(EX_DATA_REG_##reg##_SHIFT) ")"
+
+#define _ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, err, zero)		\
+	__DEFINE_ASM_GPR_NUMS						\
+	__ASM_EXTABLE_RAW(#insn, #fixup, 				\
+			  __stringify(EX_TYPE_UACCESS_ERR_ZERO),	\
+			  "("						\
+			    EX_DATA_REG(ERR, err) " | "			\
+			    EX_DATA_REG(ZERO, zero)			\
+			  ")")
+
+#define _ASM_EXTABLE_UACCESS_ERR(insn, fixup, err)			\
+	_ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, err, zero)
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __ASM_ASM_EXTABLE_H */
diff --git a/arch/loongarch/include/asm/futex.h b/arch/loongarch/include/asm/futex.h
index bdcd1c613299..042ca4448e4d 100644
--- a/arch/loongarch/include/asm/futex.h
+++ b/arch/loongarch/include/asm/futex.h
@@ -19,16 +19,11 @@
 	"2:	sc.w	$t0, %2				\n"	\
 	"	beqz	$t0, 1b				\n"	\
 	"3:						\n"	\
-	"	.section .fixup,\"ax\"			\n"	\
-	"4:	li.w	%0, %6				\n"	\
-	"	b	3b				\n"	\
-	"	.previous				\n"	\
-	_ASM_EXTABLE(1b, 4b)					\
-	_ASM_EXTABLE(2b, 4b)					\
+	_ASM_EXTABLE_UACCESS_ERR(1b, 3b, %0)			\
+	_ASM_EXTABLE_UACCESS_ERR(2b, 3b, %0)			\
 	: "=r" (ret), "=&r" (oldval),				\
 	  "=ZC" (*uaddr)					\
-	: "0" (0), "ZC" (*uaddr), "Jr" (oparg),			\
-	  "i" (-EFAULT)						\
+	: "0" (0), "ZC" (*uaddr), "Jr" (oparg)			\
 	: "memory", "t0");					\
 }
 
@@ -85,15 +80,10 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr, u32 oldval, u32 newv
 	"	beqz	$t0, 1b					\n"
 	"3:							\n"
 	__WEAK_LLSC_MB
-	"	.section .fixup,\"ax\"				\n"
-	"4:	li.d	%0, %6					\n"
-	"	b	3b					\n"
-	"	.previous					\n"
-	_ASM_EXTABLE(1b, 4b)
-	_ASM_EXTABLE(2b, 4b)
+	_ASM_EXTABLE_UACCESS_ERR(1b, 3b, %0)
+	_ASM_EXTABLE_UACCESS_ERR(2b, 3b, %0)
 	: "+r" (ret), "=&r" (val), "=ZC" (*uaddr)
-	: "ZC" (*uaddr), "Jr" (oldval), "Jr" (newval),
-	  "i" (-EFAULT)
+	: "ZC" (*uaddr), "Jr" (oldval), "Jr" (newval)
 	: "memory", "t0");
 
 	*uval = val;
diff --git a/arch/loongarch/include/asm/uaccess.h b/arch/loongarch/include/asm/uaccess.h
index e33282e0bdef..255899d4a7c3 100644
--- a/arch/loongarch/include/asm/uaccess.h
+++ b/arch/loongarch/include/asm/uaccess.h
@@ -161,14 +161,9 @@ do {									\
 	__asm__ __volatile__(						\
 	"1:	" insn "	%1, %2				\n"	\
 	"2:							\n"	\
-	"	.section .fixup,\"ax\"				\n"	\
-	"3:	li.w	%0, %3					\n"	\
-	"	move	%1, $zero				\n"	\
-	"	b	2b					\n"	\
-	"	.previous					\n"	\
-	_ASM_EXTABLE(1b, 3b)						\
+	_ASM_EXTABLE_UACCESS_ERR_ZERO(1b, 2b, %0, %1)			\
 	: "+r" (__gu_err), "=r" (__gu_tmp)				\
-	: "m" (__m(ptr)), "i" (-EFAULT));				\
+	: "m" (__m(ptr)));						\
 									\
 	(val) = (__typeof__(*(ptr))) __gu_tmp;				\
 }
@@ -191,13 +186,9 @@ do {									\
 	__asm__ __volatile__(						\
 	"1:	" insn "	%z2, %1		# __put_user_asm\n"	\
 	"2:							\n"	\
-	"	.section	.fixup,\"ax\"			\n"	\
-	"3:	li.w	%0, %3					\n"	\
-	"	b	2b					\n"	\
-	"	.previous					\n"	\
-	_ASM_EXTABLE(1b, 3b)						\
+	_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %0)				\
 	: "+r" (__pu_err), "=m" (__m(ptr))				\
-	: "Jr" (__pu_val), "i" (-EFAULT));				\
+	: "Jr" (__pu_val));						\
 }
 
 #define __get_kernel_nofault(dst, src, type, err_label)			\
diff --git a/arch/loongarch/mm/extable.c b/arch/loongarch/mm/extable.c
index 56b7250fc65e..e6871edd0631 100644
--- a/arch/loongarch/mm/extable.c
+++ b/arch/loongarch/mm/extable.c
@@ -2,11 +2,12 @@
 /*
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
+#include <linux/bitfield.h>
 #include <linux/extable.h>
 #include <linux/spinlock.h>
+#include <linux/uaccess.h>
 #include <asm/asm-extable.h>
 #include <asm/branch.h>
-#include <linux/uaccess.h>
 
 static inline unsigned long
 get_ex_fixup(const struct exception_table_entry *ex)
@@ -21,6 +22,28 @@ static bool ex_handler_fixup(const struct exception_table_entry *ex,
 	return true;
 }
 
+static inline void regs_set_gpr(struct pt_regs *regs, unsigned int offset,
+				unsigned long val)
+{
+	if (unlikely(offset > MAX_REG_OFFSET))
+		return;
+
+	if (offset)
+		*(unsigned long *)((unsigned long)regs + offset) = val;
+}
+
+static bool ex_handler_uaccess_err_zero(const struct exception_table_entry *ex,
+					struct pt_regs *regs)
+{
+	int reg_err = FIELD_GET(EX_DATA_REG_ERR, ex->data);
+	int reg_zero = FIELD_GET(EX_DATA_REG_ZERO, ex->data);
+
+	regs_set_gpr(regs, reg_err * sizeof(unsigned long), -EFAULT);
+	regs_set_gpr(regs, reg_zero * sizeof(unsigned long), 0);
+
+	regs->csr_era = get_ex_fixup(ex);
+	return true;
+}
 
 bool fixup_exception(struct pt_regs *regs)
 {
@@ -33,6 +56,8 @@ bool fixup_exception(struct pt_regs *regs)
 	switch (ex->type) {
 	case EX_TYPE_FIXUP:
 		return ex_handler_fixup(ex, regs);
+	case EX_TYPE_UACCESS_ERR_ZERO:
+		return ex_handler_uaccess_err_zero(ex, regs);
 	}
 
 	BUG();
-- 
2.36.1

