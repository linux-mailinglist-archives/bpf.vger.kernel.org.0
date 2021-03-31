Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CDF35092F
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 23:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhCaV1e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 17:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbhCaV12 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Mar 2021 17:27:28 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BC9C06175F
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 14:27:28 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id v5so1607727pgj.7
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 14:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bTCEWvQMjkTW/eVBx3Fi28gIb6vhFXkJKuQZd7egWL4=;
        b=ZyWaDB66yEhpxGUfmbtxVGmU3IBzo+oXxVhHLfWs3XfFFGSmJPLHiE7AtUsL52u4em
         7r8+LPrjToiGPIKHfAyX+CYa64laXNc6rI1BGc3zm2kLmapiVVq57hrEGsA6RpFB5njc
         yJtaF9uxQMIwX5fVhtI6GFkCQjMND6xl8/9j4DypA/x676Betc17fx3372YWMv6uudg1
         Uq3pjBGR+txVa6+cTYQpzbIUUhvOP1NbLuj2g77f+DuZDQjxPV7+fKMGDYKtturZq9Sr
         ladv12DGpbIVZdpLI4mmgcR60wybqF/xda3o7z0Jpt/JICr6LzvTERx4Cld+Z/MhtGVD
         UuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bTCEWvQMjkTW/eVBx3Fi28gIb6vhFXkJKuQZd7egWL4=;
        b=P4FOkbH1feWxcJKmoC36Ie7JBwCyWqTX9gvoGl5IvmLye8VJh+5BXlx4ssxc6d2h2F
         rmyU9zCrfD7/ekp5JiqGw0t47MkcksL4L3JGLQ/7OoG23sY8wMx2CgAKnlyrQ0ePsVVQ
         +0CvWZxOyrYWvUiziEiR+hWRHn3kXPndFUJAnPZ4kd9EoPicJwU0xpZs/ikieDO2OA7m
         s/iIpw8e0iwheAXVpzqPdx8y2z0qHPjtacANx2c99YxwBRJjM6txQb/ru4+WfrYbVnKN
         /VT4gYAb1lArYRrpAxBhFGoaGnZcd+BHYyUGNXPCazYSV5B+nrjz9DSs1Smg6Y8vJGlG
         pGLg==
X-Gm-Message-State: AOAM530DsALLOhbn3FDRYcpYVzgff0GToYjGREjWzRZNyiGMmssOXDh9
        4sSnELKE2vnHS4ZSk9TR8InSSu24+/KNLBIBptw=
X-Google-Smtp-Source: ABdhPJyDPGqZCzSp3WV1/uBjjwnSkHTUJui8hm7KRQKratU0h86QMz9gC7gdr8DJf05TCYSKUV9OwgrvNAHV11IKgX8=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:7933:7015:a5d5:3835])
 (user=samitolvanen job=sendgmr) by 2002:a63:d550:: with SMTP id
 v16mr4986888pgi.164.1617226047699; Wed, 31 Mar 2021 14:27:27 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:27:06 -0700
In-Reply-To: <20210331212722.2746212-1-samitolvanen@google.com>
Message-Id: <20210331212722.2746212-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210331212722.2746212-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v4 02/17] cfi: add __cficanonical
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With CONFIG_CFI_CLANG, the compiler replaces a function address taken
in C code with the address of a local jump table entry, which passes
runtime indirect call checks. However, the compiler won't replace
addresses taken in assembly code, which will result in a CFI failure
if we later jump to such an address in instrumented C code. The code
generated for the non-canonical jump table looks this:

  <noncanonical.cfi_jt>: /* In C, &noncanonical points here */
	jmp noncanonical
  ...
  <noncanonical>:        /* function body */
	...

This change adds the __cficanonical attribute, which tells the
compiler to use a canonical jump table for the function instead. This
means the compiler will rename the actual function to <function>.cfi
and points the original symbol to the jump table entry instead:

  <canonical>:           /* jump table entry */
	jmp canonical.cfi
  ...
  <canonical.cfi>:       /* function body */
	...

As a result, the address taken in assembly, or other non-instrumented
code always points to the jump table and therefore, can be used for
indirect calls in instrumented code without tripping CFI checks.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>   # pci.h
---
 include/linux/compiler-clang.h | 1 +
 include/linux/compiler_types.h | 4 ++++
 include/linux/init.h           | 4 ++--
 include/linux/pci.h            | 4 ++--
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 6de9d0c9377e..adbe76b203e2 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -63,3 +63,4 @@
 #endif
 
 #define __nocfi		__attribute__((__no_sanitize__("cfi")))
+#define __cficanonical	__attribute__((__cfi_canonical_jump_table__))
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 796935a37e37..d29bda7f6ebd 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -246,6 +246,10 @@ struct ftrace_likely_data {
 # define __nocfi
 #endif
 
+#ifndef __cficanonical
+# define __cficanonical
+#endif
+
 #ifndef asm_volatile_goto
 #define asm_volatile_goto(x...) asm goto(x)
 #endif
diff --git a/include/linux/init.h b/include/linux/init.h
index b3ea15348fbd..045ad1650ed1 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -220,8 +220,8 @@ extern bool initcall_debug;
 	__initcall_name(initstub, __iid, id)
 
 #define __define_initcall_stub(__stub, fn)			\
-	int __init __stub(void);				\
-	int __init __stub(void)					\
+	int __init __cficanonical __stub(void);			\
+	int __init __cficanonical __stub(void)			\
 	{ 							\
 		return fn();					\
 	}							\
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 86c799c97b77..39684b72db91 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1944,8 +1944,8 @@ enum pci_fixup_pass {
 #ifdef CONFIG_LTO_CLANG
 #define __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
 				  class_shift, hook, stub)		\
-	void stub(struct pci_dev *dev);					\
-	void stub(struct pci_dev *dev)					\
+	void __cficanonical stub(struct pci_dev *dev);			\
+	void __cficanonical stub(struct pci_dev *dev)			\
 	{ 								\
 		hook(dev); 						\
 	}								\
-- 
2.31.0.291.g576ba9dcdaf-goog

