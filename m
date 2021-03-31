Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36563350487
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 18:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbhCaQbT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 12:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbhCaQbE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Mar 2021 12:31:04 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F7BAC061574;
        Wed, 31 Mar 2021 09:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=UzLPat+zCVCHsOzci+jiquCA0flgNJrwkr
        nYFtrMHnY=; b=DfLjKNIt2rUwSGaVRRyxyv2noBzOsyRuvAv9cQgzAPkR36Q1rO
        PkgXDu3HrpF8dAC+iPmlv0zZyMgAnhNoRs8pUAiX2ObKMSxM5anOKK3kozdcmXZq
        9pENnZLbWIwQuZZKAozk2F8lFNl7giucDuhorE2UUcAP8SDgYrneVCJ20=
Received: from xhacker (unknown [101.86.19.180])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCXnaW3o2RgL7x6AA--.1430S2;
        Thu, 01 Apr 2021 00:30:48 +0800 (CST)
Date:   Thu, 1 Apr 2021 00:25:51 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        " =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=" <bjorn@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Xi Wang <xi.wang@gmail.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH v2 2/9] riscv: Mark some global variables __ro_after_init
Message-ID: <20210401002551.0ddbacf9@xhacker>
In-Reply-To: <20210401002442.2fe56b88@xhacker>
References: <20210401002442.2fe56b88@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygCXnaW3o2RgL7x6AA--.1430S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryfJFW7urW3urWftw4kCrg_yoW5Kw1rpF
        WUGF1DWrWrZanrKayayrykury7Jrn8Ww13ta12ka4rCa1UXry5X395Z3ZrZr1YqFWkWF1S
        ka45Gw1jka1UXa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkGb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY
        04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r4j6FyUMIIF0xvEx4A2jsIE14v26r1j6r4U
        MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jndbbUUU
        UU=
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jisheng Zhang <jszhang@kernel.org>

All of these are never modified after init, so they can be
__ro_after_init.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/sbi.c  | 8 ++++----
 arch/riscv/kernel/smp.c  | 4 ++--
 arch/riscv/kernel/time.c | 2 +-
 arch/riscv/kernel/vdso.c | 4 ++--
 arch/riscv/mm/init.c     | 6 +++---
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index d3bf756321a5..cbd94a72eaa7 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -11,14 +11,14 @@
 #include <asm/smp.h>
 
 /* default SBI version is 0.1 */
-unsigned long sbi_spec_version = SBI_SPEC_VERSION_DEFAULT;
+unsigned long sbi_spec_version __ro_after_init = SBI_SPEC_VERSION_DEFAULT;
 EXPORT_SYMBOL(sbi_spec_version);
 
-static void (*__sbi_set_timer)(uint64_t stime);
-static int (*__sbi_send_ipi)(const unsigned long *hart_mask);
+static void (*__sbi_set_timer)(uint64_t stime) __ro_after_init;
+static int (*__sbi_send_ipi)(const unsigned long *hart_mask) __ro_after_init;
 static int (*__sbi_rfence)(int fid, const unsigned long *hart_mask,
 			   unsigned long start, unsigned long size,
-			   unsigned long arg4, unsigned long arg5);
+			   unsigned long arg4, unsigned long arg5) __ro_after_init;
 
 struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
 			unsigned long arg1, unsigned long arg2,
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index ea028d9e0d24..504284d49135 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -30,7 +30,7 @@ enum ipi_message_type {
 	IPI_MAX
 };
 
-unsigned long __cpuid_to_hartid_map[NR_CPUS] = {
+unsigned long __cpuid_to_hartid_map[NR_CPUS] __ro_after_init = {
 	[0 ... NR_CPUS-1] = INVALID_HARTID
 };
 
@@ -85,7 +85,7 @@ static void ipi_stop(void)
 		wait_for_interrupt();
 }
 
-static struct riscv_ipi_ops *ipi_ops;
+static struct riscv_ipi_ops *ipi_ops __ro_after_init;
 
 void riscv_set_ipi_ops(struct riscv_ipi_ops *ops)
 {
diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
index 1b432264f7ef..8217b0f67c6c 100644
--- a/arch/riscv/kernel/time.c
+++ b/arch/riscv/kernel/time.c
@@ -11,7 +11,7 @@
 #include <asm/processor.h>
 #include <asm/timex.h>
 
-unsigned long riscv_timebase;
+unsigned long riscv_timebase __ro_after_init;
 EXPORT_SYMBOL_GPL(riscv_timebase);
 
 void __init time_init(void)
diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 3f1d35e7c98a..25a3b8849599 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -20,8 +20,8 @@
 
 extern char vdso_start[], vdso_end[];
 
-static unsigned int vdso_pages;
-static struct page **vdso_pagelist;
+static unsigned int vdso_pages __ro_after_init;
+static struct page **vdso_pagelist __ro_after_init;
 
 /*
  * The vDSO data page.
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 76bf2de8aa59..719ec72ef069 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -149,11 +149,11 @@ void __init setup_bootmem(void)
 }
 
 #ifdef CONFIG_MMU
-static struct pt_alloc_ops pt_ops;
+static struct pt_alloc_ops pt_ops __ro_after_init;
 
-unsigned long va_pa_offset;
+unsigned long va_pa_offset __ro_after_init;
 EXPORT_SYMBOL(va_pa_offset);
-unsigned long pfn_base;
+unsigned long pfn_base __ro_after_init;
 EXPORT_SYMBOL(pfn_base);
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
-- 
2.31.0


