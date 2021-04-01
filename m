Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864363523A2
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 01:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbhDAXc0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Apr 2021 19:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235912AbhDAXcZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Apr 2021 19:32:25 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1D7C0613A8
        for <bpf@vger.kernel.org>; Thu,  1 Apr 2021 16:32:22 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id p12so3659094plw.0
        for <bpf@vger.kernel.org>; Thu, 01 Apr 2021 16:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UueCb+prJKWXLp5VR3fqk5CXQc0Ab5GgzQzu/xo2P9E=;
        b=YgEJwWoldHoDIKiiF7PoeaO8mKT/D1SC1mTBCW9jcHft8TDOoFkoTFE/n/qTe4cHzS
         FztWbduBQ23TJLiO+mu///7uMJY+YT6crA5fpe7E11aMdWdQbvQKLPnIA/prLfkdJsoD
         /gLPPkiVdX1e5JHp1IfygeNMt+vsf5l6xHjyi+MeJ3Gd/zp9xSBVOqrBTkESVBrWVPi5
         p6zsc1zF1OPOrGKhTIeaqp1Bo0ntss5/i03JAhypbGIvFWF+QSdyx/QTUK0iJYg5og0v
         bBK53xcbRUcpRHI6NdfegG+ozN4YNkjRHX89w9/GRXhoQFxsv6cJ+xMRfKc66Ll3i4eY
         k2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UueCb+prJKWXLp5VR3fqk5CXQc0Ab5GgzQzu/xo2P9E=;
        b=AuZ8Y7bkf4jDr+4mieW3FdkMRD4dssAHSBTZ++bDO7nVwB6BpdvPOaoaGQHQDQnCeu
         /gaywzBDOA9fScHpxeBB5DYniCxX+U/eE2C+X24ptqpC28+nQwl0JnHoj8NMeD+OK3lU
         N7zqUFPOJntYZXSxCuNpjtjQCirybSdmPEgih80azfyaZHSj7S6HllznGYbK8S20omIe
         xR+qnCNSE/Or0xT+1Pk5ephnL6UlvC7RKyL4UgYIzlrjaHwUsD61/RjRzSR6KED8brsH
         3hY9AMiEXtkdwxU58soqk6TEJqqPEK8a46XbmifNNCM9ljAbPumJWq1XhFGx8Hwe9Z0w
         EkZg==
X-Gm-Message-State: AOAM533FHDi0UD0EZsCCJpv/jblBNXPKyEuQyvNaw99SkgB18oMRHO6o
        yABiUCaeNM4SEeQDqAYthRIqwwykXnsxrSsCTRc=
X-Google-Smtp-Source: ABdhPJwxduIri2IKJBaAY8ilTJfPwgodBRJfhWjsSvt8WBSIvP9IkLfHwtarDxMGAwPZXg2+pGsTEU0CI9ZmvdZhNMc=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:4cd1:da86:e91b:70b4])
 (user=samitolvanen job=sendgmr) by 2002:a17:90a:ba05:: with SMTP id
 s5mr11390928pjr.194.1617319942329; Thu, 01 Apr 2021 16:32:22 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:32:00 -0700
In-Reply-To: <20210401233216.2540591-1-samitolvanen@google.com>
Message-Id: <20210401233216.2540591-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210401233216.2540591-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 02/18] cfi: add __cficanonical
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
2.31.0.208.g409f899ff0-goog

