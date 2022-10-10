Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD145F9BF1
	for <lists+bpf@lfdr.de>; Mon, 10 Oct 2022 11:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiJJJcn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 05:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiJJJck (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 05:32:40 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6EFB01CFD6;
        Mon, 10 Oct 2022 02:32:38 -0700 (PDT)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxkOCl5kNjKPwpAA--.21250S5;
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
Subject: [PATCH 3/7] LoongArch: extable: Add `type` and `data` fields
Date:   Mon, 10 Oct 2022 17:32:16 +0800
Message-Id: <1665394340-13906-4-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1665394340-13906-1-git-send-email-tangyouling@loongson.cn>
References: <1665394340-13906-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8CxkOCl5kNjKPwpAA--.21250S5
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4xGFy5ZF1xKF18XFW8JFb_yoWrKFyUpF
        1qyF95KrW5Wrn3uwnxtr4qvr1UGr4vgw1a9FWS9ay0y3W29F1rKr10y3srXF1vva18JFy0
        gwnag3yUZa1rA37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPqb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280
        aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
        Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S
        6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mx
        kIecxEwVAFwVW8uwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
        6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
        0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvE
        c7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
        v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
        07jcYFXUUUUU=
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a LoongArch port of commit d6e2cc564775 ("arm64: extable: add
`type` and `data` fields").

Subsequent patches will add specialized handlers for fixups, in addition
to the simple PC fixup we have today. In preparation, this patch adds a
new `type` field to struct exception_table_entry, and uses this to
distinguish the fixup and other cases. A `data` field is also added so
that subsequent patches can associate data specific to each exception
site (e.g. register numbers).

Handlers are named ex_handler_*() for consistency, following the example
of x86. At the same time, get_ex_fixup() is split out into a helper so
that it can be used by other ex_handler_*() functions ins subsequent
patches.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/loongarch/include/asm/asm-extable.h | 15 +++++++++++----
 arch/loongarch/include/asm/extable.h     | 11 +++++++++++
 arch/loongarch/kernel/vmlinux.lds.S      |  3 +--
 arch/loongarch/mm/extable.c              |  7 ++++++-
 scripts/sorttable.c                      |  2 +-
 5 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/arch/loongarch/include/asm/asm-extable.h b/arch/loongarch/include/asm/asm-extable.h
index 74f8bc75472a..634bd770e3c4 100644
--- a/arch/loongarch/include/asm/asm-extable.h
+++ b/arch/loongarch/include/asm/asm-extable.h
@@ -2,17 +2,22 @@
 #ifndef __ASM_ASM_EXTABLE_H
 #define __ASM_ASM_EXTABLE_H
 
+#define EX_TYPE_NONE			0
+#define EX_TYPE_FIXUP			1
+
 #ifdef __ASSEMBLY__
 
-#define __ASM_EXTABLE_RAW(insn, fixup)			\
+#define __ASM_EXTABLE_RAW(insn, fixup, type, data)	\
 	.pushsection	__ex_table, "a";		\
 	.balign		4;				\
 	.long		((insn) - .);			\
 	.long		((fixup) - .);			\
+	.short		(type);				\
+	.short		(data);				\
 	.popsection;
 
 	.macro		_asm_extable, insn, fixup
-	__ASM_EXTABLE_RAW(\insn, \fixup)
+	__ASM_EXTABLE_RAW(\insn, \fixup, EX_TYPE_FIXUP, 0)
 	.endm
 
 #else /* __ASSEMBLY__ */
@@ -20,15 +25,17 @@
 #include <linux/bits.h>
 #include <linux/stringify.h>
 
-#define __ASM_EXTABLE_RAW(insn, fixup)			\
+#define __ASM_EXTABLE_RAW(insn, fixup, type, data)	\
 	".pushsection	__ex_table, \"a\"\n"		\
 	".balign	4\n"				\
 	".long		((" insn ") - .)\n"		\
 	".long		((" fixup ") - .)\n"		\
+	".short		(" type ")\n"			\
+	".short		(" data ")\n"			\
 	".popsection\n"
 
 #define _ASM_EXTABLE(insn, fixup)	\
-	__ASM_EXTABLE_RAW(#insn, #fixup)
+	__ASM_EXTABLE_RAW(#insn, #fixup, __stringify(EX_TYPE_FIXUP), "0")
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/loongarch/include/asm/extable.h b/arch/loongarch/include/asm/extable.h
index b571c89705d1..92612b4364a1 100644
--- a/arch/loongarch/include/asm/extable.h
+++ b/arch/loongarch/include/asm/extable.h
@@ -17,10 +17,21 @@
 
 struct exception_table_entry {
 	int insn, fixup;
+	short type, data;
 };
 
 #define ARCH_HAS_RELATIVE_EXTABLE
 
+#define swap_ex_entry_fixup(a, b, tmp, delta)		\
+do {							\
+	(a)->fixup = (b)->fixup + (delta);		\
+	(b)->fixup = (tmp).fixup - (delta);		\
+	(a)->type = (b)->type;				\
+	(b)->type = (tmp).type;				\
+	(a)->data = (b)->data;				\
+	(b)->data = (tmp).data;				\
+} while (0)
+
 bool fixup_exception(struct pt_regs *regs);
 
 #endif
diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
index b3309a5e695b..efecda0c2361 100644
--- a/arch/loongarch/kernel/vmlinux.lds.S
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -4,6 +4,7 @@
 #include <asm/thread_info.h>
 
 #define PAGE_SIZE _PAGE_SIZE
+#define RO_EXCEPTION_TABLE_ALIGN	4
 
 /*
  * Put .bss..swapper_pg_dir as the first thing in .bss. This will
@@ -53,8 +54,6 @@ SECTIONS
 	. = ALIGN(PECOFF_SEGMENT_ALIGN);
 	_etext = .;
 
-	EXCEPTION_TABLE(16)
-
 	.got : ALIGN(16) { *(.got) }
 	.plt : ALIGN(16) { *(.plt) }
 	.got.plt : ALIGN(16) { *(.got.plt) }
diff --git a/arch/loongarch/mm/extable.c b/arch/loongarch/mm/extable.c
index fb2b5a0268f0..56b7250fc65e 100644
--- a/arch/loongarch/mm/extable.c
+++ b/arch/loongarch/mm/extable.c
@@ -30,5 +30,10 @@ bool fixup_exception(struct pt_regs *regs)
 	if (!ex)
 		return false;
 
-	return ex_handler_fixup(ex, regs);
+	switch (ex->type) {
+	case EX_TYPE_FIXUP:
+		return ex_handler_fixup(ex, regs);
+	}
+
+	BUG();
 }
diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 0f2beda80478..83cdb843d92f 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -304,6 +304,7 @@ static int do_file(char const *const fname, void *addr)
 	switch (r2(&ehdr->e_machine)) {
 	case EM_386:
 	case EM_AARCH64:
+	case EM_LOONGARCH:
 	case EM_RISCV:
 	case EM_S390:
 	case EM_X86_64:
@@ -312,7 +313,6 @@ static int do_file(char const *const fname, void *addr)
 	case EM_PARISC:
 	case EM_PPC:
 	case EM_PPC64:
-	case EM_LOONGARCH:
 		custom_sort = sort_relative_table;
 		break;
 	case EM_ARCOMPACT:
-- 
2.36.1

