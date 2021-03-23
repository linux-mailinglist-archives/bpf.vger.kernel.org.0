Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D9C346A34
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 21:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhCWUkk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 16:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbhCWUkM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Mar 2021 16:40:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62F7C0613DF
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 13:40:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 6so3848794ybq.7
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 13:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pXHCPErazdX/nDg2/nb6QksjLfEFTtrkU2uTHlahGRs=;
        b=jFt+TBSDKrmbmcTGUS3Zh3LQfQ9h6g78j1z40AyKg7NaLPpZHn37Ldl7vtccRAf8UV
         GppokLpY6wTAB+Sle9DrxlzNvmD7RLVB1LrLtLP+DoPSdOHThcUhWPgZsZMHr1AypqJp
         2ausF2iw7I06q65bPHkkK5uKHVdZZ+ckMEmm7IBf/pcXpGFOQXgKf2NyXu+UF4y2zTd2
         ycqljJ06Wbbus0bG5F1C0bgOjXenQJWv7VPFmvmSNViXRdLRYpO43wanLsM7EnyPPUa4
         y3y0OHiuMRejUijcBoHlT618Iy/tBMRleGTHHjCIOalK/zQVBqz//LPDgG2CS2s+wtjo
         u2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pXHCPErazdX/nDg2/nb6QksjLfEFTtrkU2uTHlahGRs=;
        b=VerKLfaR85MoVVb1FlicXditZU59mKiNrkL6wGJWXkHfHLGuPUMPmKgDiVusDkR5Gp
         iueKU7fq6xrVDHBNrt/X5JpLEvzFVrBq77/zdQnDuZgIj7aPQqcKXvdWzPBgGdeWzn1G
         IoNpR9wEEWci6jqPfSmuFN6SExL3hFk7Qh3OgJiDKB9gcsaEkrRvcSvfkGmrnaLLugBN
         6EJ+HpcbWht52U/m/BDjklTqUqvyyhmTeqHGmJUEcflQdfSsvw09uokH59G5O44uduqn
         b6dXGtmpX+G2VLa/toUj2/OXDWVtqb+y0G12N4yWsMbnv9K1f43X13J7qEQ/BzZ76XDh
         Z1zA==
X-Gm-Message-State: AOAM530yiFbNA96Qapxhxjz1H+PSksFgfdWgpdgj9gdytbYmJXy26de8
        yJ8wdPdZbxFC7GwclXnM1OwhpvoIug7bbwKs6fA=
X-Google-Smtp-Source: ABdhPJy23IA9Pmn2B2QQVPkwdw9dKjsA0O0LWinFUMBV4532ZUThiTX267nWH6v33xCXfAmR7YR5nPY/6Ir/NDlbC70=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e9a3:260d:763b:67dc])
 (user=samitolvanen job=sendgmr) by 2002:a25:d3d3:: with SMTP id
 e202mr58822ybf.283.1616532011040; Tue, 23 Mar 2021 13:40:11 -0700 (PDT)
Date:   Tue, 23 Mar 2021 13:39:41 -0700
In-Reply-To: <20210323203946.2159693-1-samitolvanen@google.com>
Message-Id: <20210323203946.2159693-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210323203946.2159693-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3 12/17] arm64: implement __va_function
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/include/asm/memory.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 0aabc3be9a75..9a4887808681 100644
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
2.31.0.291.g576ba9dcdaf-goog

