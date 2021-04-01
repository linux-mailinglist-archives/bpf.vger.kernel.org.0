Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638093523BA
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 01:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236267AbhDAXcs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Apr 2021 19:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbhDAXc2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Apr 2021 19:32:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D647C061797
        for <bpf@vger.kernel.org>; Thu,  1 Apr 2021 16:32:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n13so7447683ybp.14
        for <bpf@vger.kernel.org>; Thu, 01 Apr 2021 16:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=X7pKNQoykGsVEBpcKZlriYQJ1U+ZvEkb/I/sJpCEmoM=;
        b=BjeqB6czPiyblykb6PBqbuo0xYMJRyLf/oeNx84DE4R1fttODxk2bFz8ZBL75Fuvgw
         6F/tOm2Du9GhJn2mmq+CkjLQeGoCDGcqzKXhnGnQJQtJAyZ0HZhS6MkmhStYDbWSofMA
         68PW7Ihe35F8GXNvpgR24UJGY5/BeWu5RHMSwgkH8ITuRBjDaoNZjNQSTirk5hAXUmTp
         ZPjj5XXJCkZx73K1M8xMs4EZ67o5T3/A9AenBMN46C4kl1tYZt3s49w2u2H03hLXhD7j
         BsR61PVQf5F2iEv11ANBBbHx3c7rBoBvCxGY1fhbGX98hjjeSXxMbBi79tgKpmDn/EHg
         EaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=X7pKNQoykGsVEBpcKZlriYQJ1U+ZvEkb/I/sJpCEmoM=;
        b=MTyhKneWoUS8tvorgSSMWG9j2GKmlYNwK9ZtWBEJt11U9qLoBkjuWUtjbSLQiaj4AY
         ku557rMQY7MF2DMA9yPQbq23Tx8DVUpfmTbFEEd+oVGGbymcST8MHACI2c6nYO0fRsFq
         oQ4tfXOzyvoTRsN3p8SfC8pp72f2iZ3BuNJew2cAKKKWNnX65a2oN80uh5p9Yl6QZExK
         kPpVPzjI9mhPnLQ80sCMGkwLMzqDV8LixgIP9jEdaG/fpKZa7Ei2YbQTo7HczUHNkTnu
         UZhSJRlh/i6BGQ67765HdrerfBKnnCENlYotSGOYa1sF9ePc7v0CNjWNOUunbIMOCN1M
         U/Hg==
X-Gm-Message-State: AOAM532NLQpMq/KZtPK3bKE5zHKwgyKANcvMKlRyjPkEHICi+B+u6vlT
        Lk8CE7Zv2np2MOR3nuqOP9PE3uJJvshUMEUqBs8=
X-Google-Smtp-Source: ABdhPJzdtiwlIR4zsNDFW5ioAx+wS4lt7L2o01q4Wrd2ySGr3BrZwRNBVOL+/rsGqUne1kRNRcwwzZrITvNNBaKI1jg=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:4cd1:da86:e91b:70b4])
 (user=samitolvanen job=sendgmr) by 2002:a25:25d7:: with SMTP id
 l206mr15429911ybl.43.1617319946420; Thu, 01 Apr 2021 16:32:26 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:32:02 -0700
In-Reply-To: <20210401233216.2540591-1-samitolvanen@google.com>
Message-Id: <20210401233216.2540591-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210401233216.2540591-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 04/18] module: ensure __cfi_check alignment
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

CONFIG_CFI_CLANG_SHADOW assumes the __cfi_check() function is page
aligned and at the beginning of the .text section. While Clang would
normally align the function correctly, it fails to do so for modules
with no executable code.

This change ensures the correct __cfi_check() location and
alignment. It also discards the .eh_frame section, which Clang can
generate with certain sanitizers, such as CFI.

Link: https://bugs.llvm.org/show_bug.cgi?id=46293
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Jessica Yu <jeyu@kernel.org>
---
 scripts/module.lds.S | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 168cd27e6122..f8022b34e388 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -3,10 +3,20 @@
  * Archs are free to supply their own linker scripts.  ld will
  * combine them automatically.
  */
+#ifdef CONFIG_CFI_CLANG
+# include <asm/page.h>
+# define ALIGN_CFI 		ALIGN(PAGE_SIZE)
+# define SANITIZER_DISCARDS	*(.eh_frame)
+#else
+# define ALIGN_CFI
+# define SANITIZER_DISCARDS
+#endif
+
 SECTIONS {
 	/DISCARD/ : {
 		*(.discard)
 		*(.discard.*)
+		SANITIZER_DISCARDS
 	}
 
 	__ksymtab		0 : { *(SORT(___ksymtab+*)) }
@@ -40,7 +50,14 @@ SECTIONS {
 		*(.rodata..L*)
 	}
 
-	.text : { *(.text .text.[0-9a-zA-Z_]*) }
+	/*
+	 * With CONFIG_CFI_CLANG, we assume __cfi_check is at the beginning
+	 * of the .text section, and is aligned to PAGE_SIZE.
+	 */
+	.text : ALIGN_CFI {
+		*(.text.__cfi_check)
+		*(.text .text.[0-9a-zA-Z_]* .text..L.cfi*)
+	}
 }
 
 /* bring in arch-specific sections */
-- 
2.31.0.208.g409f899ff0-goog

