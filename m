Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E783350961
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 23:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhCaV2X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 17:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbhCaV1z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Mar 2021 17:27:55 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC60C06175F
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 14:27:54 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id w8so1950427qtk.3
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 14:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qAbADIQAzXUoq/ElYpa9rjjQHxphEP8wPywcql//gEU=;
        b=BIwBbz27li9nhzZOJpPItRxIEwjbJxKUY6UbYU5CqvzA6WV2OyusxpPuP2GbqEKsF4
         wPUN1Q4or2K+m1thBQd2qBYnnhno/+HEhUjZP6mN++bKuXujnCF7ElDczhg5KqD0DiHQ
         hAtx85mO6qIZNWn2hkAtwUeoT/7iOQYyLpsYMn5GkmPZR/+IClF4QAklOY48jwFmIUYr
         aQsEWMT4TYApAtAL/gjYcoyIEfUpYswWr1684dszxQxu7VwcvcTCnnc8GPEf+Ef5ZYIf
         aeqjPvWk/ub/50LBqjLxSVw1zYmdKi8DPaVfSVN+0mUmPWgG8aIRBCTvTk4SH2B+EppC
         /dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qAbADIQAzXUoq/ElYpa9rjjQHxphEP8wPywcql//gEU=;
        b=UbBQZZiJ0F9QqnqS7ifu5Y7xmTHEdZ4LE7q4xhAfT/KkMccrEUAK+IC7XKEnjtBLJX
         sj3za2LKO4jGfZhvpy3AItB8Pw1CgA2zKb1AmxXNSAIGdOcqjGE2dyzgHR+j3YxZxKAb
         VLjwsIz1q6S3VMaX098wwkF3lmRDBBFz3MDCzSX5CdB/9KQ3aYPM48ZzPFt7SfEMSqit
         6oCmHzzST7/uz7LWXS4fmR7yZodwB7anppV+JooBC+PPzTtX2HHSsQO5KIfj3mBCPP6I
         Gov8+1VC8KRzzTcdBVMHOsjMz3uDJdm8bEz4AmoY7Guc+3aJPNDbKP41wF6n0ek6jhtv
         8ysQ==
X-Gm-Message-State: AOAM531QxGbrPnRzIKEcBA3sQe2aDc2d0jr8IVuqvVD4a7z67/+2Xa00
        Smc+M8e8VYoPIQCuIVnkE3qspECQVYiIjx/wJLg=
X-Google-Smtp-Source: ABdhPJwBmNvm14+TDBMdxtVUmeFtuXceFyrO8XCaMzs+ImrOy+72TpNn3ja8CYb7Rf87hbMIOM4aIfmuWPGKh8vvqRQ=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:7933:7015:a5d5:3835])
 (user=samitolvanen job=sendgmr) by 2002:ad4:5614:: with SMTP id
 ca20mr4929242qvb.37.1617226074055; Wed, 31 Mar 2021 14:27:54 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:27:19 -0700
In-Reply-To: <20210331212722.2746212-1-samitolvanen@google.com>
Message-Id: <20210331212722.2746212-16-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210331212722.2746212-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v4 15/17] arm64: add __nocfi to __apply_alternatives
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

__apply_alternatives makes indirect calls to functions whose address
is taken in assembly code using the alternative_cb macro. With
non-canonical CFI, the compiler won't replace these function
references with the jump table addresses, which trips CFI. Disable CFI
checking in the function to work around the issue.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/alternative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 1184c44ea2c7..abc84636af07 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -133,8 +133,8 @@ static void clean_dcache_range_nopatch(u64 start, u64 end)
 	} while (cur += d_size, cur < end);
 }
 
-static void __apply_alternatives(void *alt_region,  bool is_module,
-				 unsigned long *feature_mask)
+static void __nocfi __apply_alternatives(void *alt_region,  bool is_module,
+					 unsigned long *feature_mask)
 {
 	struct alt_instr *alt;
 	struct alt_region *region = alt_region;
-- 
2.31.0.291.g576ba9dcdaf-goog

