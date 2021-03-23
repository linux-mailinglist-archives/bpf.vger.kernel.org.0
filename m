Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5D9346A12
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 21:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbhCWUkb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 16:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbhCWUj6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Mar 2021 16:39:58 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A95C0613E1
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 13:39:57 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id s14so1958604qtw.20
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 13:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2eJKl2P+mphx8MXuY5eZ3j0r297zj+fSj+T5WKlAy0E=;
        b=F7DyYoTINGuplDxZdhovljaDSjsbsbsHDaccNJNpVFG1uHl0pH2Jb8ZGxI9pRViGzn
         P9bXGOaY4DL6wqzXTQkCjWG3FbAPFgW9yZwRM/QptFOt0nz84XtEbqR1NLBkEGidZJa3
         CrJkw9qpHdhwZrMFRZHgVsRqmb2+bUfA3erzvVzdp42rL0vgo1/PfyIuO8eBVtII3M96
         zF220AVy6U0HEFNIfOCZZan85P2t79rpIjJGqHqbbixIsFbkx3V9i1GVLeV4Nyw/Kyqe
         1GNwZ/VIvbro/fYpjQY24QiS/HC8Qnb62x6xeycl0QxRVHSbtfzTj1X67bnIdj4QhdeH
         nwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2eJKl2P+mphx8MXuY5eZ3j0r297zj+fSj+T5WKlAy0E=;
        b=eCE981i9w0nnIK2RUwqtkMKwFwZOmBiyi5Lit6k7wecwEdsW+MCZ+o9Py+b2CygQ1p
         jQhWWhBSt5lYCB9H51G207Q49ujC7pmXNqE7dpRCwhZJEmLlo8Wr/einzwRMIGmRxBsu
         ZotwqNvYX1WF28JqCUGh/HUKh3r9a4ADDFN4WGZvAi0XbYlwKKAO13IfdF0MOeoZIw/z
         pbp489AvI7kcRlXm2+0b5pIe1D/wss92oQUX9JyEIJXgurIARI8Y7Ai6cDrRnXyze0BT
         Fukro1zKBvoq7nj0q/886YOtRMLssvnfYUfZsjymAEG66zrpAgc4dItM9eAOUd4d/aAL
         +tWA==
X-Gm-Message-State: AOAM5317+GXPJMsQOGOrvKSLlNcpnApPAb9ymzLBJTxtWcJ4FUacAtng
        UVDzLcBbAAoJ5E6ORvT3kTgW8PPDtpo/ZXpHf2g=
X-Google-Smtp-Source: ABdhPJxkrzfmdWRBTsfApsBgU0/vtdyh9mzsMw1+qzCVhW8+YL7dn0iZkK/RRt+cwJ1LZa5E4YW9O+Nm9AJq6lZMkTQ=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e9a3:260d:763b:67dc])
 (user=samitolvanen job=sendgmr) by 2002:a0c:ea4b:: with SMTP id
 u11mr129682qvp.43.1616531996172; Tue, 23 Mar 2021 13:39:56 -0700 (PDT)
Date:   Tue, 23 Mar 2021 13:39:33 -0700
In-Reply-To: <20210323203946.2159693-1-samitolvanen@google.com>
Message-Id: <20210323203946.2159693-5-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210323203946.2159693-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3 04/17] module: ensure __cfi_check alignment
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

CONFIG_CFI_CLANG_SHADOW assumes the __cfi_check() function is page
aligned and at the beginning of the .text section. While Clang would
normally align the function correctly, it fails to do so for modules
with no executable code.

This change ensures the correct __cfi_check() location and
alignment. It also discards the .eh_frame section, which Clang can
generate with certain sanitizers, such as CFI.

Link: https://bugs.llvm.org/show_bug.cgi?id=46293
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/module.lds.S | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/scripts/module.lds.S b/scripts/module.lds.S
index 168cd27e6122..2ba9e5ce71df 100644
--- a/scripts/module.lds.S
+++ b/scripts/module.lds.S
@@ -3,10 +3,21 @@
  * Archs are free to supply their own linker scripts.  ld will
  * combine them automatically.
  */
+#include <asm/page.h>
+
+#ifdef CONFIG_CFI_CLANG
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
@@ -40,7 +51,14 @@ SECTIONS {
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
2.31.0.291.g576ba9dcdaf-goog

