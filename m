Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D28340B30
	for <lists+bpf@lfdr.de>; Thu, 18 Mar 2021 18:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbhCRRLn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 13:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbhCRRLX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Mar 2021 13:11:23 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D681EC06174A
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 10:11:22 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id x7so22599211plg.18
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 10:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PeAEi4QdQeJS0R2WYWNNntX7QF/OnwnEUYEO8FB/zZI=;
        b=p+VrkP1bqZI10VP8EeeZrzzfoI1GjtWoEBRuBE726XK/gDRTExpkpo8vfdSH/r6qQ2
         fOHKt1juhQxrQX6cPPMTifNTZixG8rFVdvoGNuSuYPxjZVs2EkOF1lcit3KaS49mPZ8z
         IQOBi7STpHBUIWzQ5ZbW05JFEpfzqGDRrLWE4nIbfgbgwW0f2a/6+/NvWVZQIPm96o7N
         I++3MhM7OLsD8NpuK5qhBdlWedJp3H/fYNTk/el3qX4LG+Jk4NRA79tjSVy1YmmYUQk0
         1tj5qVOJAW3NP909IVQvUiiUoKjnZ8ZK9jEGED8pRZSAEUtB/GBEOGKsqXsDo/bIKAnn
         RFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PeAEi4QdQeJS0R2WYWNNntX7QF/OnwnEUYEO8FB/zZI=;
        b=k6SmEMxk8x0er4F6JlZTYGJbR83XPYoSZy32j3fSrqEJWH9cgna7gl/mloxXEP1Od6
         wD20komP4wXxMpSc6fkStLTxfnjODb8qwu9tTEFlGmln9MkOA6+ggKeztUnjv6N1jiQo
         ljdL4UpOzMAO8fia1HUrd1KgwSh1RWl0MufgIum+bIysizelo/WHBpiNDv4M2ctCwF+0
         0CmoV4nmgvpaKp/KeZEUeDdaRBbVMtbGpARP17qqx5+MuOkNJWY2fUnJlPeS8JfXBNcr
         x7Tf59ajVr66QXj7bj/pQZslh5iBmF3gVXhM5xsjjoOood09Uh5ZFXU0Xz7iQLWtVgcI
         Bv8g==
X-Gm-Message-State: AOAM532vPDpMt+3Y1PCWVP71/ENBKzEHs5bVHJ3p2fxCvwgPHeSKk6UN
        H1ef5nrbGZcWGndMcyAki09kDzp73wkuVJehxSE=
X-Google-Smtp-Source: ABdhPJx8cHucnyP+Aa+4tX9UaXIRGtXiznnlELJLcS5vzBI/KUq73zcAaMJL61KmuRuPI9myO+PJeQ6WezcQTaT+iSM=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c0d7:a7ba:fb41:a35a])
 (user=samitolvanen job=sendgmr) by 2002:a17:902:7401:b029:e4:5992:e64a with
 SMTP id g1-20020a1709027401b02900e45992e64amr10565108pll.75.1616087482135;
 Thu, 18 Mar 2021 10:11:22 -0700 (PDT)
Date:   Thu, 18 Mar 2021 10:10:57 -0700
In-Reply-To: <20210318171111.706303-1-samitolvanen@google.com>
Message-Id: <20210318171111.706303-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 03/17] mm: add generic __va_function and __pa_function macros
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With CONFIG_CFI_CLANG, the compiler replaces function addresses
in instrumented C code with jump table addresses. This means that
__pa_symbol(function) returns the physical address of the jump table
entry instead of the actual function, which may not work as the jump
table code will immediately jump to a virtual address that may not be
mapped.

To avoid this address space confusion, this change adds generic
definitions for __va_function and __pa_function, which architectures
that support CFI can override. The typical implementation of the
__va_function macro would use inline assembly to take the function
address, which avoids compiler instrumentation.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 include/linux/mm.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 64a71bf20536..a0d285cd59ce 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -116,6 +116,14 @@ extern int mmap_rnd_compat_bits __read_mostly;
 #define __pa_symbol(x)  __pa(RELOC_HIDE((unsigned long)(x), 0))
 #endif
 
+#ifndef __va_function
+#define __va_function(x) (x)
+#endif
+
+#ifndef __pa_function
+#define __pa_function(x) __pa_symbol(__va_function(x))
+#endif
+
 #ifndef page_to_virt
 #define page_to_virt(x)	__va(PFN_PHYS(page_to_pfn(x)))
 #endif
-- 
2.31.0.291.g576ba9dcdaf-goog

