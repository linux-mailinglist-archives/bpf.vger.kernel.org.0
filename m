Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8574E5F9C02
	for <lists+bpf@lfdr.de>; Mon, 10 Oct 2022 11:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiJJJep (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 05:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiJJJeo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 05:34:44 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29FA710576;
        Mon, 10 Oct 2022 02:34:41 -0700 (PDT)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxTWss50Nj6_wpAA--.24724S2;
        Mon, 10 Oct 2022 17:34:36 +0800 (CST)
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
Subject: [PATCH 6/7] LoongArch: vmlinux.lds.S: Remove `.fixup` section
Date:   Mon, 10 Oct 2022 17:34:36 +0800
Message-Id: <1665394476-14147-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8AxTWss50Nj6_wpAA--.24724S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4fWw4fGFy7Ww1fJw1fWFg_yoW5Xrykpr
        17ArnrKa1fGFn7ZasrXryvqryvqFZrGrW2qF47GFyrG3y29r1kZr95A39rJFy7W393Jr40
        qryfKF4rXF48GwUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kI
        c2xKxwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
        z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
        UI43ZEXa7IU8RyxtUUUUU==
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After using the `.L_xxx` lable instead of `.fixup`, we no longer place
anything into a `.fixup` section, so we no longer need to place those
sections into the `.text` section in the main kernel Image.

Remove the use of `.fixup`.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---

Using `irp` allows you to easily define multiple lables, provide
convenience for implementing __{copy, clear}_user_fast in the future.

 arch/loongarch/kernel/vmlinux.lds.S |  1 -
 arch/loongarch/lib/clear_user.S     | 14 +++++---------
 arch/loongarch/lib/copy_user.S      | 16 ++++++----------
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
index efecda0c2361..d382c88f47b2 100644
--- a/arch/loongarch/kernel/vmlinux.lds.S
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -48,7 +48,6 @@ SECTIONS
 		KPROBES_TEXT
 		IRQENTRY_TEXT
 		SOFTIRQENTRY_TEXT
-		*(.fixup)
 		*(.gnu.warning)
 	} :text = 0
 	. = ALIGN(PECOFF_SEGMENT_ALIGN);
diff --git a/arch/loongarch/lib/clear_user.S b/arch/loongarch/lib/clear_user.S
index 7a066d6a41b8..167823b21def 100644
--- a/arch/loongarch/lib/clear_user.S
+++ b/arch/loongarch/lib/clear_user.S
@@ -9,15 +9,11 @@
 #include <asm/export.h>
 #include <asm/regdef.h>
 
-.macro fixup_ex from, to, offset, fix
-.if \fix
-	.section .fixup, "ax"
-\to:	addi.d	a0, a1, \offset
+.irp to, 0
+.L_fixup_handle_\to\():
+	addi.d	a0, a1, (\to) * (-8)
 	jr	ra
-	.previous
-.endif
-	_asm_extable \from\()b, \to\()b
-.endm
+.endr
 
 /*
  * unsigned long __clear_user(void *addr, size_t size)
@@ -36,7 +32,7 @@ SYM_FUNC_START(__clear_user)
 2:	move	a0, a1
 	jr	ra
 
-	fixup_ex 1, 3, 0, 1
+	_asm_extable 1, .L_fixup_handle_0
 SYM_FUNC_END(__clear_user)
 
 EXPORT_SYMBOL(__clear_user)
diff --git a/arch/loongarch/lib/copy_user.S b/arch/loongarch/lib/copy_user.S
index f8ace04586c2..5d7bfa8d53d2 100644
--- a/arch/loongarch/lib/copy_user.S
+++ b/arch/loongarch/lib/copy_user.S
@@ -9,15 +9,11 @@
 #include <asm/export.h>
 #include <asm/regdef.h>
 
-.macro fixup_ex from, to, offset, fix
-.if \fix
-	.section .fixup, "ax"
-\to:	addi.d	a0, a2, \offset
+.irp to, 0
+.L_fixup_handle_\to\():
+	addi.d	a0, a2, (\to) * (-8)
 	jr	ra
-	.previous
-.endif
-	_asm_extable \from\()b, \to\()b
-.endm
+.endr
 
 /*
  * unsigned long __copy_user(void *to, const void *from, size_t n)
@@ -39,8 +35,8 @@ SYM_FUNC_START(__copy_user)
 3:	move	a0, a2
 	jr	ra
 
-	fixup_ex 1, 4, 0, 1
-	fixup_ex 2, 4, 0, 0
+	_asm_extable 1, .L_fixup_handle_0
+	_asm_extable 2, .L_fixup_handle_0
 SYM_FUNC_END(__copy_user)
 
 EXPORT_SYMBOL(__copy_user)
-- 
2.36.1

