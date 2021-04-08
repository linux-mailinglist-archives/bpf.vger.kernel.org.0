Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8187358C40
	for <lists+bpf@lfdr.de>; Thu,  8 Apr 2021 20:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbhDHS3C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Apr 2021 14:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbhDHS3B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Apr 2021 14:29:01 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B3DC061762
        for <bpf@vger.kernel.org>; Thu,  8 Apr 2021 11:28:50 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id a7so1671884qvx.10
        for <bpf@vger.kernel.org>; Thu, 08 Apr 2021 11:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vvGV2K9qJKpfvq0cSok+JSuieXx8RQrlyRB1QstgZ+Y=;
        b=H4wKrT8MEFKBf/P2edPGw9amgAuMe+Wa7SuQcetjU/MH1OyYC0D87EcXzhCH7u+9k+
         dLm7T2GM3uGxWejiOnqYd0UuZsV3CIhEsckqiSPDJLynL8hOGtZa8Z25zq5DbloPimXr
         xQf1g9qsKFRpr6POE2nsMlXMb3d+MzFQoHp31yKnLZoDsKLCChNSKSz/jRaF+KdV+Rca
         OszaYH6ynnEONcP0EzWMUQrC9HpfKkB0kKZC5IPkk8rauOFLxgo7aoLtARzrNuLIgdWA
         eCUrDSVcG/3NVVhCrlO2TK5xgMk7n+le9zfFDwZzkjtkwDFDvni4bi0oOpmywrqd3aB0
         X/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vvGV2K9qJKpfvq0cSok+JSuieXx8RQrlyRB1QstgZ+Y=;
        b=A0Xrg5VD2sNP++0OI0rW+7FyQo0TzTDcGnxeOUF69X2NYJesKCfLYu12CPsBstLc9i
         jcBDCAF2d5VVDgPd2UrR8rECaN0GRlPrmIv6E31GqTxD53l3FZ7kkKWoPnUpceriP9RL
         vC52mjK9oazPo/QGpykHCbxUcrlcS2vqfZdl7YT0RdnZiKckfkEL1RoeKEOoCwwjCB9z
         yq/PP8fYd1JpBe04ciQtrh1uqrKrMFtPUsTF6t/v/sFTNCV0ce8RXC+9UHpAq97T/v4V
         FgWyRHCtqZqFfRkTtlAQQCYv0Ggwn0cDHhjSQpkQSqZKnUQGR5c05dFUC3ar/sQf2ZJK
         XmGg==
X-Gm-Message-State: AOAM530PE+dFacqQir5tHPXkxs6QiodK2e+1WBkpBNRy3ggUyQKV++BB
        JTTPU4ncBlbDt5NjCVDgRJTKydS9ccMNoSUNwqc=
X-Google-Smtp-Source: ABdhPJz0ehITxX9teec2gn0CPHcF57blIqcKaI1/CV63GE4M8xmJ3/25o/4dk/Km4yNV8f2TMjz9/jW33s2Uw/coxoc=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:3560:8505:40a2:e021])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:1081:: with SMTP id
 o1mr9867133qvr.11.1617906529278; Thu, 08 Apr 2021 11:28:49 -0700 (PDT)
Date:   Thu,  8 Apr 2021 11:28:27 -0700
In-Reply-To: <20210408182843.1754385-1-samitolvanen@google.com>
Message-Id: <20210408182843.1754385-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210408182843.1754385-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v6 02/18] cfi: add __cficanonical
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
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
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
Tested-by: Nathan Chancellor <nathan@kernel.org>
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
2.31.1.295.g9ea45b61b8-goog

