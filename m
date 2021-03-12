Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC323382C0
	for <lists+bpf@lfdr.de>; Fri, 12 Mar 2021 01:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbhCLAtr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Mar 2021 19:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhCLAtZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Mar 2021 19:49:25 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487C7C061760
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 16:49:25 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 127so27573335ybc.19
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 16:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qBzD2jKlJCBSceSZkOW3qTz3O5z1Bv9x7KfP7hbZayM=;
        b=Eeipead3OTfdyQVNZR6+I9TFFiFKRPZZrf8vnUFQlgo6+oxt8h0bMJVQroY4XVzr88
         Xmv0bF9CGtd2mF8exHl4SSlNBXo0DpAmkhlH2IVxw9yUcbEoH4+5g0wTvB5LB5fKQH6W
         m3Q7E8EH6Ki8nZVAx0vyozNJyMUQlvD49FWE6zW1ytXmExwv9m0bWZTqeW5iJGLQtkcw
         XTD5uj2tMYGcL/m4lR1vYJhd9+eVYGGcQ4U98OQn2zQksuRHFvDFFAy33sjrvDfkClva
         PBfE3juVVgCPKihbF9tklibABTtTIHMyG/09dOJMcteM5eEssVbpGXFNZcJmCXdpqvy9
         9R7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qBzD2jKlJCBSceSZkOW3qTz3O5z1Bv9x7KfP7hbZayM=;
        b=XZHKTp3u99eyjaGq6XgDMyaZyhKIKuH3UwFc+fSXaSXli4bci7UcuyiiKCw8wH9nly
         EataukV1X4vIB9TJRatZS/T/BAYdBIzg5aHOJbDaoC6ZCg+w8YCjN7vb/pos11oxLZlR
         8sR0I+gCNFgqlEjbvBNYxSHlZ34qAqf3PiW4XRN6M6slXhA6ZtTVbVJ8O6q8NKRY542K
         7RaDtRmk8o3nYd/ZIclh4K6/zLv5gFOI2J897JqttJMzaTmcCYBW1C+WQx7YY34nNxzL
         g7aqZda5C/UE/RTdJ16Lwqy0AGEl8xLZYD3XyqQgjPf0NrNLDxlAFFxQOUmohDusfmSj
         sl4g==
X-Gm-Message-State: AOAM531XsPTBsJ67gr0X5noUi2yKb2BAISvLO+UWjh8oYmFRCQ1UvTtr
        EY/OVq39pmrA4sHdGWGQ/OYScBFp1NcBYFC6qPo=
X-Google-Smtp-Source: ABdhPJxT/RtO93f7gJpAKHqE1/yNm9hIqf4LkKtkGWnA/IVcDAjiGtDBLYlTbUdAeTbLxPSdUndH9TPTNvHjOSf7RVU=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c86b:8269:af92:55a])
 (user=samitolvanen job=sendgmr) by 2002:a25:1485:: with SMTP id
 127mr16070777ybu.243.1615510164574; Thu, 11 Mar 2021 16:49:24 -0800 (PST)
Date:   Thu, 11 Mar 2021 16:49:04 -0800
In-Reply-To: <20210312004919.669614-1-samitolvanen@google.com>
Message-Id: <20210312004919.669614-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210312004919.669614-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 02/17] cfi: add __cficanonical
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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
---
 include/linux/compiler-clang.h | 1 +
 include/linux/compiler_types.h | 4 ++++
 include/linux/init.h           | 4 ++--
 include/linux/pci.h            | 4 ++--
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 1ff22bdad992..c275f23ce023 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -57,3 +57,4 @@
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
2.31.0.rc2.261.g7f71774620-goog

