Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB405F9BEE
	for <lists+bpf@lfdr.de>; Mon, 10 Oct 2022 11:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiJJJcl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 05:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiJJJcj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 05:32:39 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C1FC3AB1A;
        Mon, 10 Oct 2022 02:32:36 -0700 (PDT)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxkOCl5kNjKPwpAA--.21250S3;
        Mon, 10 Oct 2022 17:32:24 +0800 (CST)
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
Subject: [PATCH 1/7] LoongArch: Consolidate __ex_table construction
Date:   Mon, 10 Oct 2022 17:32:14 +0800
Message-Id: <1665394340-13906-2-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1665394340-13906-1-git-send-email-tangyouling@loongson.cn>
References: <1665394340-13906-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8CxkOCl5kNjKPwpAA--.21250S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GrWrKw1fJF4fGw4kKFykXwb_yoW7Aw4xpF
        1qkr4kKrZ8G3WrA3ZrtFnFvr4Dtw4DGr1ava4a9Fyvya12q3WFyr4vkryvgF1kJa9rZF48
        XryfKF45XF47Zw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPSb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv
        6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
        02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE
        4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2
        xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
        5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
        W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
        1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
        U0NBMtUUUUU==
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Consolidate all the __ex_table constuction code with a _ASM_EXTABLE
or _asm_extable helper.

There should be no functional change as a result of this patch.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/loongarch/include/asm/asm-extable.h | 35 ++++++++++++++++++++++++
 arch/loongarch/include/asm/futex.h       | 13 ++++-----
 arch/loongarch/include/asm/uaccess.h     |  9 ++----
 arch/loongarch/kernel/fpu.S              |  5 ++--
 arch/loongarch/lib/clear_user.S          |  5 ++--
 arch/loongarch/lib/copy_user.S           |  5 ++--
 6 files changed, 49 insertions(+), 23 deletions(-)
 create mode 100644 arch/loongarch/include/asm/asm-extable.h

diff --git a/arch/loongarch/include/asm/asm-extable.h b/arch/loongarch/include/asm/asm-extable.h
new file mode 100644
index 000000000000..5aef0c41bdad
--- /dev/null
+++ b/arch/loongarch/include/asm/asm-extable.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_ASM_EXTABLE_H
+#define __ASM_ASM_EXTABLE_H
+
+#ifdef __ASSEMBLY__
+
+#define __ASM_EXTABLE_RAW(insn, fixup)			\
+	.pushsection	__ex_table, "a";		\
+	.balign		8;				\
+	.long		(insn);				\
+	.long		(fixup);			\
+	.popsection;
+
+	.macro		_asm_extable, insn, fixup
+	__ASM_EXTABLE_RAW(\insn, \fixup)
+	.endm
+
+#else /* __ASSEMBLY__ */
+
+#include <linux/bits.h>
+#include <linux/stringify.h>
+
+#define __ASM_EXTABLE_RAW(insn, fixup)			\
+	".pushsection	__ex_table, \"a\"\n"		\
+	".balign	8\n"				\
+	".long		((" insn "))\n"			\
+	".long		((" fixup "))\n"		\
+	".popsection\n"
+
+#define _ASM_EXTABLE(insn, fixup)	\
+	__ASM_EXTABLE_RAW(#insn, #fixup)
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_ASM_EXTABLE_H */
diff --git a/arch/loongarch/include/asm/futex.h b/arch/loongarch/include/asm/futex.h
index feb6658c84ff..bdcd1c613299 100644
--- a/arch/loongarch/include/asm/futex.h
+++ b/arch/loongarch/include/asm/futex.h
@@ -7,6 +7,7 @@
 
 #include <linux/futex.h>
 #include <linux/uaccess.h>
+#include <asm/asm-extable.h>
 #include <asm/barrier.h>
 #include <asm/errno.h>
 
@@ -22,10 +23,8 @@
 	"4:	li.w	%0, %6				\n"	\
 	"	b	3b				\n"	\
 	"	.previous				\n"	\
-	"	.section __ex_table,\"a\"		\n"	\
-	"	"__UA_ADDR "\t1b, 4b			\n"	\
-	"	"__UA_ADDR "\t2b, 4b			\n"	\
-	"	.previous				\n"	\
+	_ASM_EXTABLE(1b, 4b)					\
+	_ASM_EXTABLE(2b, 4b)					\
 	: "=r" (ret), "=&r" (oldval),				\
 	  "=ZC" (*uaddr)					\
 	: "0" (0), "ZC" (*uaddr), "Jr" (oparg),			\
@@ -90,10 +89,8 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr, u32 oldval, u32 newv
 	"4:	li.d	%0, %6					\n"
 	"	b	3b					\n"
 	"	.previous					\n"
-	"	.section __ex_table,\"a\"			\n"
-	"	"__UA_ADDR "\t1b, 4b				\n"
-	"	"__UA_ADDR "\t2b, 4b				\n"
-	"	.previous					\n"
+	_ASM_EXTABLE(1b, 4b)
+	_ASM_EXTABLE(2b, 4b)
 	: "+r" (ret), "=&r" (val), "=ZC" (*uaddr)
 	: "ZC" (*uaddr), "Jr" (oldval), "Jr" (newval),
 	  "i" (-EFAULT)
diff --git a/arch/loongarch/include/asm/uaccess.h b/arch/loongarch/include/asm/uaccess.h
index a8ae2af4025a..bf9a4e218ac0 100644
--- a/arch/loongarch/include/asm/uaccess.h
+++ b/arch/loongarch/include/asm/uaccess.h
@@ -15,6 +15,7 @@
 #include <linux/string.h>
 #include <linux/extable.h>
 #include <asm/pgtable.h>
+#include <asm/asm-extable.h>
 #include <asm-generic/extable.h>
 #include <asm-generic/access_ok.h>
 
@@ -165,9 +166,7 @@ do {									\
 	"	move	%1, $zero				\n"	\
 	"	b	2b					\n"	\
 	"	.previous					\n"	\
-	"	.section __ex_table,\"a\"			\n"	\
-	"	"__UA_ADDR "\t1b, 3b				\n"	\
-	"	.previous					\n"	\
+	_ASM_EXTABLE(1b, 3b)						\
 	: "+r" (__gu_err), "=r" (__gu_tmp)				\
 	: "m" (__m(ptr)), "i" (-EFAULT));				\
 									\
@@ -196,9 +195,7 @@ do {									\
 	"3:	li.w	%0, %3					\n"	\
 	"	b	2b					\n"	\
 	"	.previous					\n"	\
-	"	.section	__ex_table,\"a\"		\n"	\
-	"	" __UA_ADDR "	1b, 3b				\n"	\
-	"	.previous					\n"	\
+	_ASM_EXTABLE(1b, 3b)						\
 	: "+r" (__pu_err), "=m" (__m(ptr))				\
 	: "Jr" (__pu_val), "i" (-EFAULT));				\
 }
diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu.S
index 576b3370a296..ccde94140c89 100644
--- a/arch/loongarch/kernel/fpu.S
+++ b/arch/loongarch/kernel/fpu.S
@@ -8,6 +8,7 @@
  */
 #include <asm/asm.h>
 #include <asm/asmmacro.h>
+#include <asm/asm-extable.h>
 #include <asm/asm-offsets.h>
 #include <asm/errno.h>
 #include <asm/export.h>
@@ -21,9 +22,7 @@
 
 	.macro	EX insn, reg, src, offs
 .ex\@:	\insn	\reg, \src, \offs
-	.section __ex_table,"a"
-	PTR	.ex\@, fault
-	.previous
+	_asm_extable .ex\@, fault
 	.endm
 
 	.macro sc_save_fp base
diff --git a/arch/loongarch/lib/clear_user.S b/arch/loongarch/lib/clear_user.S
index 16ba2b8dd68a..7a066d6a41b8 100644
--- a/arch/loongarch/lib/clear_user.S
+++ b/arch/loongarch/lib/clear_user.S
@@ -5,6 +5,7 @@
 
 #include <asm/asm.h>
 #include <asm/asmmacro.h>
+#include <asm/asm-extable.h>
 #include <asm/export.h>
 #include <asm/regdef.h>
 
@@ -15,9 +16,7 @@
 	jr	ra
 	.previous
 .endif
-	.section __ex_table, "a"
-	PTR	\from\()b, \to\()b
-	.previous
+	_asm_extable \from\()b, \to\()b
 .endm
 
 /*
diff --git a/arch/loongarch/lib/copy_user.S b/arch/loongarch/lib/copy_user.S
index 97d20327a69e..f8ace04586c2 100644
--- a/arch/loongarch/lib/copy_user.S
+++ b/arch/loongarch/lib/copy_user.S
@@ -5,6 +5,7 @@
 
 #include <asm/asm.h>
 #include <asm/asmmacro.h>
+#include <asm/asm-extable.h>
 #include <asm/export.h>
 #include <asm/regdef.h>
 
@@ -15,9 +16,7 @@
 	jr	ra
 	.previous
 .endif
-	.section __ex_table, "a"
-	PTR	\from\()b, \to\()b
-	.previous
+	_asm_extable \from\()b, \to\()b
 .endm
 
 /*
-- 
2.36.1

