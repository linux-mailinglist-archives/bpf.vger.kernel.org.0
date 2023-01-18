Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC73671307
	for <lists+bpf@lfdr.de>; Wed, 18 Jan 2023 06:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjARFPP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Jan 2023 00:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjARFPH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 Jan 2023 00:15:07 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6889539B9
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 21:14:52 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id z3so1007365pfb.2
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 21:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnCW5nYD+5s0iXhCs0JLcyyoyDbC/D8h2E9KWeXi/Ok=;
        b=A9LgbxAA5D24Kerrji8sWkkJhjvcw+hcYqPUKKe2YWY+LaYyXGDQ4/xbRFItNzxOjT
         CihrcNlM1UTS3zUkZqZ9F92/7lmIh4PveX0YAzZ0WAHCvPWoO3Ue/6G+i+dBhqiHbKiM
         lkHo3R/QXk+/kEqGMkeK9SsOd4xHoV7BeeddTSc/0MBjr7JZAcpDjADcA2c8XBCnGmEk
         AOVJ6Fwfgno48VVKLPeAkEoRcLcgo9DraGk4RCmyH0B9pTMgZiYyQp2QiD7A6KTnpcz3
         87xJAOGTsHNEo3P1LFAZ3qBodYFV8pfOt/GB/tkdaOmIbRfdYWD3doq0CemFooqyA8Ia
         SNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnCW5nYD+5s0iXhCs0JLcyyoyDbC/D8h2E9KWeXi/Ok=;
        b=HOJdLUqaezN4BpKsr2Sx+CRvbdKTyVq8aGOvKGzhAXzY23cBDkUH5kVvexYnzR/uvc
         rN9HYAMdyIOdGUmEaY5LDgzLP1OuyMjLcQZ66/Xh+yGYuwkwROa4q1C0mCG55j2+p9cg
         EVqNTpLhHUOHSSxqtG+LiJ34boBHX4wx6hAgJyzZL4+n/mG10a9ITIqBNtsquiDE0M8K
         +j3/B6ujC7pfMq20DwU/dRRbE/SD5TOaRuxTXf50NsHucH/1OgAv7Vk173vZbwRoxjjz
         +MoVYG7AR6v65eKyoCGsrs0gclurPJZVjlsiuCbYWv/kV5CLD8VZolsg7bhJ88Xhl0RO
         fz7g==
X-Gm-Message-State: AFqh2koO2fXp0ICobmLg6UULFKR+tGg/4td07R0QExOgBl4j7vPmvNGH
        sc8tSBNdjj0XTvUQgNYjBBC2SorOr+s=
X-Google-Smtp-Source: AMrXdXujesjhVFVcj684yxX7fsZ22dSnqR/SqkXkExBndu3dAiAzro4MiQOuMKWqoSUb9RW91Raehg==
X-Received: by 2002:a05:6a00:2354:b0:580:cf1a:f2b5 with SMTP id j20-20020a056a00235400b00580cf1af2b5mr8809640pfj.12.1674018892094;
        Tue, 17 Jan 2023 21:14:52 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:194d])
        by smtp.gmail.com with ESMTPSA id f127-20020a623885000000b00588cb819473sm16678469pfa.39.2023.01.17.21.14.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Jan 2023 21:14:51 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     torvalds@linuxfoundation.org
Cc:     x86@kernel.org, davem@davemloft.net, daniel@iogearbox.net,
        andrii@kernel.org, peterz@infradead.org, keescook@chromium.org,
        tglx@linutronix.de, hsinweih@uci.edu, rostedt@goodmis.org,
        vegard.nossum@oracle.com, gregkh@linuxfoundation.org,
        alan.maguire@oracle.com, dylany@meta.com, riel@surriel.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf 2/2] perf: Fix arch_perf_out_copy_user().
Date:   Tue, 17 Jan 2023 21:14:43 -0800
Message-Id: <20230118051443.78988-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230118051443.78988-1-alexei.starovoitov@gmail.com>
References: <20230118051443.78988-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

There are several issues with arch_perf_out_copy_user().
On x86 it's the same as copy_from_user_nmi() and all is good,
but on other archs:

- __access_ok() is missing.
Only on m68k, s390, parisc, sparc64 archs this function returns 'true'.
Other archs must call it before user memory access.
- nmi_uaccess_okay() is missing.
- __copy_from_user_inatomic() issues under CONFIG_HARDENED_USERCOPY.

The latter two issues existed in copy_from_user_nofault() as well and
were fixed in the previous patch.

This patch copies comments from copy_from_user_nmi() into mm/maccess.c
and splits copy_from_user_nofault() into copy_from_user_nmi()
that returns number of not copied bytes and copy_from_user_nofault()
that returns -EFAULT or zero.
With that copy_from_user_nmi() becomes generic and is used
by perf on all architectures.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/include/asm/perf_event.h |  2 --
 arch/x86/lib/Makefile             |  2 +-
 arch/x86/lib/usercopy.c           | 55 -------------------------------
 kernel/events/internal.h          | 16 +--------
 mm/maccess.c                      | 48 ++++++++++++++++++++++-----
 5 files changed, 41 insertions(+), 82 deletions(-)
 delete mode 100644 arch/x86/lib/usercopy.c

diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 5d0f6891ae61..2e5cada5f74e 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -590,6 +590,4 @@ static inline void perf_lopwr_cb(bool lopwr_in)
  static inline void amd_pmu_disable_virt(void) { }
 #endif
 
-#define arch_perf_out_copy_user copy_from_user_nmi
-
 #endif /* _ASM_X86_PERF_EVENT_H */
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 4f1a40a86534..e85937696afd 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -42,7 +42,7 @@ clean-files := inat-tables.c
 obj-$(CONFIG_SMP) += msr-smp.o cache-smp.o
 
 lib-y := delay.o misc.o cmdline.o cpu.o
-lib-y += usercopy_$(BITS).o usercopy.o getuser.o putuser.o
+lib-y += usercopy_$(BITS).o getuser.o putuser.o
 lib-y += memcpy_$(BITS).o
 lib-y += pc-conf-reg.o
 lib-$(CONFIG_ARCH_HAS_COPY_MC) += copy_mc.o copy_mc_64.o
diff --git a/arch/x86/lib/usercopy.c b/arch/x86/lib/usercopy.c
deleted file mode 100644
index 24b48af27417..000000000000
--- a/arch/x86/lib/usercopy.c
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- * User address space access functions.
- *
- *  For licencing details see kernel-base/COPYING
- */
-
-#include <linux/uaccess.h>
-#include <linux/export.h>
-#include <linux/instrumented.h>
-
-#include <asm/tlbflush.h>
-
-/**
- * copy_from_user_nmi - NMI safe copy from user
- * @to:		Pointer to the destination buffer
- * @from:	Pointer to a user space address of the current task
- * @n:		Number of bytes to copy
- *
- * Returns: The number of not copied bytes. 0 is success, i.e. all bytes copied
- *
- * Contrary to other copy_from_user() variants this function can be called
- * from NMI context. Despite the name it is not restricted to be called
- * from NMI context. It is safe to be called from any other context as
- * well. It disables pagefaults across the copy which means a fault will
- * abort the copy.
- *
- * For NMI context invocations this relies on the nested NMI work to allow
- * atomic faults from the NMI path; the nested NMI paths are careful to
- * preserve CR2.
- */
-unsigned long
-copy_from_user_nmi(void *to, const void __user *from, unsigned long n)
-{
-	unsigned long ret;
-
-	if (!__access_ok(from, n))
-		return n;
-
-	if (!nmi_uaccess_okay())
-		return n;
-
-	/*
-	 * Even though this function is typically called from NMI/IRQ context
-	 * disable pagefaults so that its behaviour is consistent even when
-	 * called from other contexts.
-	 */
-	pagefault_disable();
-	instrument_copy_from_user_before(to, from, n);
-	ret = raw_copy_from_user(to, from, n);
-	instrument_copy_from_user_after(to, from, n, ret);
-	pagefault_enable();
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(copy_from_user_nmi);
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 5150d5f84c03..62fe2089a1f9 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -190,21 +190,7 @@ memcpy_skip(void *dst, const void *src, unsigned long n)
 
 DEFINE_OUTPUT_COPY(__output_skip, memcpy_skip)
 
-#ifndef arch_perf_out_copy_user
-#define arch_perf_out_copy_user arch_perf_out_copy_user
-
-static inline unsigned long
-arch_perf_out_copy_user(void *dst, const void *src, unsigned long n)
-{
-	unsigned long ret;
-
-	pagefault_disable();
-	ret = __copy_from_user_inatomic(dst, src, n);
-	pagefault_enable();
-
-	return ret;
-}
-#endif
+#define arch_perf_out_copy_user copy_from_user_nmi
 
 DEFINE_OUTPUT_COPY(__output_copy_user, arch_perf_out_copy_user)
 
diff --git a/mm/maccess.c b/mm/maccess.c
index 6ee9b337c501..aa7520bb64bf 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -103,17 +103,27 @@ long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, long count)
 }
 
 /**
- * copy_from_user_nofault(): safely attempt to read from a user-space location
- * @dst: pointer to the buffer that shall take the data
- * @src: address to read from. This must be a user address.
- * @size: size of the data chunk
+ * copy_from_user_nmi - NMI safe copy from user
+ * @dst:	Pointer to the destination buffer
+ * @src:	Pointer to a user space address of the current task
+ * @size:	Number of bytes to copy
  *
- * Safely read from user address @src to the buffer at @dst. If a kernel fault
- * happens, handle that and return -EFAULT.
+ * Returns: The number of not copied bytes. 0 is success, i.e. all bytes copied
+ *
+ * Contrary to other copy_from_user() variants this function can be called
+ * from NMI context. Despite the name it is not restricted to be called
+ * from NMI context. It is safe to be called from any other context as
+ * well. It disables pagefaults across the copy which means a fault will
+ * abort the copy.
+ *
+ * For NMI context invocations this relies on the nested NMI work to allow
+ * atomic faults from the NMI path; the nested NMI paths are careful to
+ * preserve CR2 on X86 architecture.
  */
-long copy_from_user_nofault(void *dst, const void __user *src, size_t size)
+unsigned long
+copy_from_user_nmi(void *dst, const void __user *src, unsigned long size)
 {
-	long ret = -EFAULT;
+	unsigned long ret = size;
 
 	if (!__access_ok(src, size))
 		return ret;
@@ -121,13 +131,33 @@ long copy_from_user_nofault(void *dst, const void __user *src, size_t size)
 	if (!nmi_uaccess_okay())
 		return ret;
 
+	/*
+	 * Even though this function is typically called from NMI/IRQ context
+	 * disable pagefaults so that its behaviour is consistent even when
+	 * called from other contexts.
+	 */
 	pagefault_disable();
 	instrument_copy_from_user_before(dst, src, size);
 	ret = raw_copy_from_user(dst, src, size);
 	instrument_copy_from_user_after(dst, src, size, ret);
 	pagefault_enable();
 
-	if (ret)
+	return ret;
+}
+EXPORT_SYMBOL_GPL(copy_from_user_nmi);
+
+/**
+ * copy_from_user_nofault(): safely attempt to read from a user-space location
+ * @dst: pointer to the buffer that shall take the data
+ * @src: address to read from. This must be a user address.
+ * @size: size of the data chunk
+ *
+ * Safely read from user address @src to the buffer at @dst. If a kernel fault
+ * happens, handle that and return -EFAULT.
+ */
+long copy_from_user_nofault(void *dst, const void __user *src, size_t size)
+{
+	if (copy_from_user_nmi(dst, src, size))
 		return -EFAULT;
 	return 0;
 }
-- 
2.30.2

