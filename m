Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1CD3382CF
	for <lists+bpf@lfdr.de>; Fri, 12 Mar 2021 01:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhCLAuR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Mar 2021 19:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbhCLAtp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Mar 2021 19:49:45 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D779CC061574
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 16:49:44 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id y22so12196192qkb.23
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 16:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ECTrvoO9KldCfD8hhCsvcspErQHIUuuHBqQ2YK+RGVo=;
        b=wW+1hJj1hFqCk4rTpcwuBRw62x+A3vHis0Oz5tBAJYHzlXekVI5fCb4CRuFvioi1v8
         Mh7hYB9AcKeYBbYe1goSlW2jh4jRNczZ50/cIvHXEQ7ZvYFUlJ2UW0wkI493Qhde1FYO
         6pLN6ClfnYejsqp0oEwmGUo8DiPRFkt8XUU5nKtpWtewS9sJUGEekHLT4Tc4fNpo5Xjv
         mpKtrgupIsEYAT+X4F4UKvy4K/AyDXWX4jIYTycY5aYcneVJLoUhiOAcvCtUoWt2ePSz
         Q9zfzeGbLMmxYteDuFtsZTLdQWkZGVmJ6eMArA+j86MRORN5REegAy0i8e2HidZSQHB7
         s7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ECTrvoO9KldCfD8hhCsvcspErQHIUuuHBqQ2YK+RGVo=;
        b=riy6CJ5z2cOAB0MmjfQ/QMcxCjtioZ3HGtTWreXnr4KfSUEdrEni0LTtqQV6r/wgvD
         JIfVpKU4bh+vCAb38F64B09f0CGJwssMadjSgAPpEkDc3c9FSkLrgSe4cfuBq4s2xjv5
         Vl2QqXxRbFNVIzi3DZmkwOHbRO/H8xR0/6u9yUvakH9ltNEVIvtNQVoXDpSs3CtepMFa
         CfAHWdCor+zwYfsSLjiXeoeBP+5SdjjmZR9iKunrHgcNniH876xGkmwVZxQYqTxDsbp5
         jHOrnS3UBn9YD8MNEp+SwAuSYjyTI5WmsJtSSJ+sZdZbFqbGTinQvNfTEnsDKV9yKZaT
         7huA==
X-Gm-Message-State: AOAM531nKNAiRO1EagSb12DGemfjk/ERcbXeL7aAeYRA9IQrg0FShVVK
        QvvKnzIjuorIWK82gXev0q8Y+8ZeOCJ2b23TAEA=
X-Google-Smtp-Source: ABdhPJytXg5BTjwe45Q3r7eqpSZES0F+YXxX5W/l9U8XvamBe9sQnbAHhU6LdjW/F5/J+RERUpGWGLvVN/OI8YfDR1o=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c86b:8269:af92:55a])
 (user=samitolvanen job=sendgmr) by 2002:a0c:b89a:: with SMTP id
 y26mr10213572qvf.49.1615510184064; Thu, 11 Mar 2021 16:49:44 -0800 (PST)
Date:   Thu, 11 Mar 2021 16:49:14 -0800
In-Reply-To: <20210312004919.669614-1-samitolvanen@google.com>
Message-Id: <20210312004919.669614-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210312004919.669614-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 12/17] arm64: implement __va_function
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

With CONFIG_CFI_CLANG, the compiler replaces function addresses in
instrumented C code with jump table addresses. This change implements
the __va_function() macro, which returns the actual function address
instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/include/asm/memory.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index c759faf7a1ff..4defa9dc3cc5 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -321,6 +321,21 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define virt_to_pfn(x)		__phys_to_pfn(__virt_to_phys((unsigned long)(x)))
 #define sym_to_pfn(x)		__phys_to_pfn(__pa_symbol(x))
 
+#ifdef CONFIG_CFI_CLANG
+/*
+ * With CONFIG_CFI_CLANG, the compiler replaces function address
+ * references with the address of the function's CFI jump table
+ * entry. The __va_function macro always returns the address of the
+ * actual function instead.
+ */
+#define __va_function(x) ({						\
+	void *addr;							\
+	asm("adrp %0, " __stringify(x) "\n\t"				\
+	    "add  %0, %0, :lo12:" __stringify(x) : "=r" (addr));	\
+	addr;								\
+})
+#endif
+
 /*
  *  virt_to_page(x)	convert a _valid_ virtual address to struct page *
  *  virt_addr_valid(x)	indicates whether a virtual address is valid
-- 
2.31.0.rc2.261.g7f71774620-goog

