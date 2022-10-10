Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33145F9BF0
	for <lists+bpf@lfdr.de>; Mon, 10 Oct 2022 11:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiJJJcm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 05:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiJJJck (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 05:32:40 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4813225C4C;
        Mon, 10 Oct 2022 02:32:37 -0700 (PDT)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxkOCl5kNjKPwpAA--.21250S4;
        Mon, 10 Oct 2022 17:32:25 +0800 (CST)
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
Subject: [PATCH 2/7] LoongArch: Switch to relative exception tables
Date:   Mon, 10 Oct 2022 17:32:15 +0800
Message-Id: <1665394340-13906-3-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1665394340-13906-1-git-send-email-tangyouling@loongson.cn>
References: <1665394340-13906-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8CxkOCl5kNjKPwpAA--.21250S4
X-Coremail-Antispam: 1UD129KBjvJXoW3WF1rXryDXw13JF43tFyxXwb_yoWxWF43pF
        nFkr95KFZ5Grn3ua17t3yqgr1rKw40k3WjgryS9ry0vw12vFy8tr4ktr9F9F1DAay8Ja48
        WrySgw1UKr4rA3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv
        6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
        02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE
        4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2
        xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
        6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU5KiiDUUUUU==
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similar as other architectures such as arm64, x86, riscv and so on, use
offsets relative to the exception table entry values rather than absolute
addresses for both the exception locationand the fixup.

However, LoongArch label difference will actually produce two relocations,
a pair of R_LARCH_ADD32 and R_LARCH_SUB32. Take below simple code for
example:

$ cat test_ex_table.S
.section .text
1:
        nop
.section __ex_table,"a"
        .balign 4
        .long (1b - .)
.previous

$ loongarch64-unknown-linux-gnu-gcc -c test_ex_table.S
$ loongarch64-unknown-linux-gnu-readelf -Wr test_ex_table.o

Relocation section '.rela__ex_table' at offset 0x100 contains 2 entries:
    Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
0000000000000000  0000000600000032 R_LARCH_ADD32          0000000000000000 .L1^B1 + 0
0000000000000000  0000000500000037 R_LARCH_SUB32          0000000000000000 L0^A + 0

The modpost will complain the R_LARCH_SUB32 relocation, so we need to
patch modpost.c to skip this relocation for .rela__ex_table section.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/loongarch/include/asm/asm-extable.h | 12 +++++-----
 arch/loongarch/include/asm/extable.h     | 26 ++++++++++++++++++++++
 arch/loongarch/include/asm/uaccess.h     |  2 +-
 arch/loongarch/mm/extable.c              | 28 +++++++++++++++++-------
 scripts/mod/modpost.c                    | 13 +++++++++++
 scripts/sorttable.c                      |  2 +-
 6 files changed, 67 insertions(+), 16 deletions(-)
 create mode 100644 arch/loongarch/include/asm/extable.h

diff --git a/arch/loongarch/include/asm/asm-extable.h b/arch/loongarch/include/asm/asm-extable.h
index 5aef0c41bdad..74f8bc75472a 100644
--- a/arch/loongarch/include/asm/asm-extable.h
+++ b/arch/loongarch/include/asm/asm-extable.h
@@ -6,9 +6,9 @@
 
 #define __ASM_EXTABLE_RAW(insn, fixup)			\
 	.pushsection	__ex_table, "a";		\
-	.balign		8;				\
-	.long		(insn);				\
-	.long		(fixup);			\
+	.balign		4;				\
+	.long		((insn) - .);			\
+	.long		((fixup) - .);			\
 	.popsection;
 
 	.macro		_asm_extable, insn, fixup
@@ -22,9 +22,9 @@
 
 #define __ASM_EXTABLE_RAW(insn, fixup)			\
 	".pushsection	__ex_table, \"a\"\n"		\
-	".balign	8\n"				\
-	".long		((" insn "))\n"			\
-	".long		((" fixup "))\n"		\
+	".balign	4\n"				\
+	".long		((" insn ") - .)\n"		\
+	".long		((" fixup ") - .)\n"		\
 	".popsection\n"
 
 #define _ASM_EXTABLE(insn, fixup)	\
diff --git a/arch/loongarch/include/asm/extable.h b/arch/loongarch/include/asm/extable.h
new file mode 100644
index 000000000000..b571c89705d1
--- /dev/null
+++ b/arch/loongarch/include/asm/extable.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LOONGARCH_EXTABLE_H
+#define _ASM_LOONGARCH_EXTABLE_H
+
+/*
+ * The exception table consists of pairs of relative offsets: the first
+ * is the relative offset to an instruction that is allowed to fault,
+ * and the second is the relative offset at which the program should
+ * continue. No registers are modified, so it is entirely up to the
+ * continuation code to figure out what to do.
+ *
+ * All the routines below use bits of fixup code that are out of line
+ * with the main instruction path.  This means when everything is well,
+ * we don't even have to jump over them.  Further, they do not intrude
+ * on our cache or tlb entries.
+ */
+
+struct exception_table_entry {
+	int insn, fixup;
+};
+
+#define ARCH_HAS_RELATIVE_EXTABLE
+
+bool fixup_exception(struct pt_regs *regs);
+
+#endif
diff --git a/arch/loongarch/include/asm/uaccess.h b/arch/loongarch/include/asm/uaccess.h
index bf9a4e218ac0..e33282e0bdef 100644
--- a/arch/loongarch/include/asm/uaccess.h
+++ b/arch/loongarch/include/asm/uaccess.h
@@ -15,8 +15,8 @@
 #include <linux/string.h>
 #include <linux/extable.h>
 #include <asm/pgtable.h>
+#include <asm/extable.h>
 #include <asm/asm-extable.h>
-#include <asm-generic/extable.h>
 #include <asm-generic/access_ok.h>
 
 extern u64 __ua_limit;
diff --git a/arch/loongarch/mm/extable.c b/arch/loongarch/mm/extable.c
index bc20988f2b87..fb2b5a0268f0 100644
--- a/arch/loongarch/mm/extable.c
+++ b/arch/loongarch/mm/extable.c
@@ -4,19 +4,31 @@
  */
 #include <linux/extable.h>
 #include <linux/spinlock.h>
+#include <asm/asm-extable.h>
 #include <asm/branch.h>
 #include <linux/uaccess.h>
 
-int fixup_exception(struct pt_regs *regs)
+static inline unsigned long
+get_ex_fixup(const struct exception_table_entry *ex)
 {
-	const struct exception_table_entry *fixup;
+	return ((unsigned long)&ex->fixup + ex->fixup);
+}
+
+static bool ex_handler_fixup(const struct exception_table_entry *ex,
+			     struct pt_regs *regs)
+{
+	regs->csr_era = get_ex_fixup(ex);
+	return true;
+}
+
 
-	fixup = search_exception_tables(exception_era(regs));
-	if (fixup) {
-		regs->csr_era = fixup->fixup;
+bool fixup_exception(struct pt_regs *regs)
+{
+	const struct exception_table_entry *ex;
 
-		return 1;
-	}
+	ex = search_exception_tables(exception_era(regs));
+	if (!ex)
+		return false;
 
-	return 0;
+	return ex_handler_fixup(ex, regs);
 }
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 2c80da0220c3..9321c0a05ffd 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1523,6 +1523,14 @@ static int addend_mips_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 #define R_RISCV_SUB32		39
 #endif
 
+#ifndef EM_LOONGARCH
+#define EM_LOONGARCH		258
+#endif
+
+#ifndef R_LARCH_SUB32
+#define R_LARCH_SUB32		55
+#endif
+
 static void section_rela(const char *modname, struct elf_info *elf,
 			 Elf_Shdr *sechdr)
 {
@@ -1564,6 +1572,11 @@ static void section_rela(const char *modname, struct elf_info *elf,
 			    ELF_R_TYPE(r.r_info) == R_RISCV_SUB32)
 				continue;
 			break;
+		case EM_LOONGARCH:
+			if (!strcmp("__ex_table", fromsec) &&
+			    ELF_R_TYPE(r.r_info) == R_LARCH_SUB32)
+				continue;
+			break;
 		}
 		sym = elf->symtab_start + r_sym;
 		/* Skip special sections */
diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index fba40e99f354..0f2beda80478 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -312,12 +312,12 @@ static int do_file(char const *const fname, void *addr)
 	case EM_PARISC:
 	case EM_PPC:
 	case EM_PPC64:
+	case EM_LOONGARCH:
 		custom_sort = sort_relative_table;
 		break;
 	case EM_ARCOMPACT:
 	case EM_ARCV2:
 	case EM_ARM:
-	case EM_LOONGARCH:
 	case EM_MICROBLAZE:
 	case EM_MIPS:
 	case EM_XTENSA:
-- 
2.36.1

