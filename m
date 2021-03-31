Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FB835095B
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 23:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhCaV2U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 17:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbhCaV1s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Mar 2021 17:27:48 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485CDC061574
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 14:27:48 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id l13so1941717qtu.6
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 14:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RWJ9aQhTl20nw/R5RXPJl7NDj1C/UnL5LrldsenTslw=;
        b=OI2BXN7KaQv0FSebUTwCneDYkgM3EAclc0LW8tfWF13e9tAHbT6S7IOhSWAvQZLEnM
         JINs3HBpLvp6Qvodp3XPXwpa2AY4B6TKaD777pUzRWtoTAYeD1ocUHZu2HycU4zx1Kmv
         TNPKwT23uSIbpB+4L8uGbr3k4clT4tWUBKmb6FlOF1Rr6P3NPk9yRjsBi/8/WqNqXQ91
         l8FNow8wvarKsgb5E8LUZNePMtfEnTyG4gLYP5Kv+xRbrPTbyVM2AH1BrU969hKl7202
         it/AECGlU/1SsjxKqzkPukkeE7jMpt1aJJc+o2/Ob3guLAV3RI2sN0Iy2pgsPxnRnjo4
         2KMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RWJ9aQhTl20nw/R5RXPJl7NDj1C/UnL5LrldsenTslw=;
        b=fWWdhGJYOpZESy3PeS1fCPLA5Tw+dc0FPprlBYYiT931Dv08e0qHuuXgPFMrx6k6KX
         vPEqFTEufWaVLtqL85n8G0At5O2uzwkOBRtJYumVYvjdEjP2XSYGoDx853nf/4GmakTI
         876sEgySE2AS9m0nCAERaflDoPkEE72nSuoDUpw4jIunVXJOj9x4oNXP6lvYIFsuTbv8
         2acceJ8P20rNt6L2i89mpSr/3+h3HHzh6rR4LQqX4eQuW6I4d8mxxrKNprzB8fHaTNUc
         lydIIcWzuFyWOtcHUCfPOYvtC/OGHeiRPtTQFDIJADs0ZL2jhhmSvIjAjqpqNIsRfQPj
         WTHw==
X-Gm-Message-State: AOAM531HB7IquUfEQOOxQSI8eriijBGvLyEi6EF8WTtpF5SpS5kNxj2m
        cOevVCmmVUYOo9K2+3yhfwRj205kzLlIrH84luo=
X-Google-Smtp-Source: ABdhPJwgeYfpiU4TaL+sNYk8JQhgUoPaRCwg5+9HCoLujfPlRhTT1jZ0jK2Sqbbps882JdAhQwjOAlmdak1l08CL8Lw=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:7933:7015:a5d5:3835])
 (user=samitolvanen job=sendgmr) by 2002:a0c:b410:: with SMTP id
 u16mr5255799qve.8.1617226067444; Wed, 31 Mar 2021 14:27:47 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:27:16 -0700
In-Reply-To: <20210331212722.2746212-1-samitolvanen@google.com>
Message-Id: <20210331212722.2746212-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210331212722.2746212-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v4 12/17] arm64: implement function_nocfi
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

With CONFIG_CFI_CLANG, the compiler replaces function addresses in
instrumented C code with jump table addresses. This change implements
the function_nocfi() macro, which returns the actual function address
instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/include/asm/memory.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 0aabc3be9a75..b55410afd3d1 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -321,6 +321,21 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define virt_to_pfn(x)		__phys_to_pfn(__virt_to_phys((unsigned long)(x)))
 #define sym_to_pfn(x)		__phys_to_pfn(__pa_symbol(x))
 
+#ifdef CONFIG_CFI_CLANG
+/*
+ * With CONFIG_CFI_CLANG, the compiler replaces function address
+ * references with the address of the function's CFI jump table
+ * entry. The function_nocfi macro always returns the address of the
+ * actual function instead.
+ */
+#define function_nocfi(x) ({						\
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
2.31.0.291.g576ba9dcdaf-goog

