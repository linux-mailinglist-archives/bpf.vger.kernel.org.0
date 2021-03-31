Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3C8350944
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 23:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhCaV2P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 17:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhCaV1g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Mar 2021 17:27:36 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6583CC0613DF
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 14:27:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l83so3642032ybf.22
        for <bpf@vger.kernel.org>; Wed, 31 Mar 2021 14:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=83qC35j0sT8ux3EecZ4JSXTBbnC5lT5vvU8jPpy+oIo=;
        b=qW9htz+1Xajlr5ZlOCWPOGJSyd0/TSkn9e+fyiCr0KHqJua+AlwezhJkvGAUtb8Uus
         /S4mbwz/r+yDh70gtjVoZeS/Cd8Df/jmcs1PuDY46slrmp+4SqG+psUv2O+ksbCIJsku
         dIjxKPRi0/bBYhrdnimd0IFEXoBehXd1rxYwYKk6jnrMrv5BJOu5sLPElKsXeAOfL2IR
         FSzBya2A/E7j+p3qdkcoVeUbSlTHPrCr/FWByGn48UAf6x3/qZaErXzEP1jQigQ+9zTl
         SKBo2HTMUqAJmQOe4IT5KuTYEDd90h1ZV8EwZpReysv+MJnRxHy6JXArwTScE9I12WVL
         7/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=83qC35j0sT8ux3EecZ4JSXTBbnC5lT5vvU8jPpy+oIo=;
        b=SjDfa9QIDCedIqOXvCOv39ehH8ZWQRwprQu983yaWGBIfdQG+ncY3VTKIwHmNWM0OK
         +Lt5z4fjMQGbp5VVHXmFOogJAnsYAZBxIu495S4UyjOqrBxHW2PlVCfNcdgXr9g70SHH
         R6G9eA9zfAOIAm7HHrGuGMDr8gH7C+KThpIBPBS5ynP4EJAeKWA9wWCg+rfUtPFIucjD
         TbvMnht3WqISOluuj4uoYaFxNgQil+eAgnnega7NtBpRgco38Gn5qKPSu7kd9S0vVS5a
         Ny3WJB9j7EbcRMLI596lIOuXMRX0GAd/84TZsrgXSh4KuGb87Q32JdGsG/eHWQ5jVHeO
         o5Sw==
X-Gm-Message-State: AOAM533k72VQXUWOtV7jAH2qZQLVaS4W6MBXJAHsA7h1uVaLkH6AT8EE
        FBgMEcC+GjLYlcdwIJplj6JwPf3MsF22inUEGPc=
X-Google-Smtp-Source: ABdhPJyr002SQuA6HZqmBTDomHGBVa4bvwCOQ/KoKLmk8qBxdNaaMWAdSxUHR/bPNxVIO6iowtKoA+CrI/FQIGDGCn4=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:7933:7015:a5d5:3835])
 (user=samitolvanen job=sendgmr) by 2002:a25:3801:: with SMTP id
 f1mr7850920yba.353.1617226053546; Wed, 31 Mar 2021 14:27:33 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:27:09 -0700
In-Reply-To: <20210331212722.2746212-1-samitolvanen@google.com>
Message-Id: <20210331212722.2746212-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210331212722.2746212-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v4 05/17] workqueue: use WARN_ON_FUNCTION_MISMATCH
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

With CONFIG_CFI_CLANG, a callback function passed to
__queue_delayed_work from a module points to a jump table entry
defined in the module instead of the one used in the core kernel,
which breaks function address equality in this check:

  WARN_ON_ONCE(timer->function != delayed_work_timer_fn);

Use WARN_ON_FUNCTION_MISMATCH() instead to disable the warning
when CFI and modules are both enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0d150da252e8..03fe07d2f39f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1630,7 +1630,7 @@ static void __queue_delayed_work(int cpu, struct workqueue_struct *wq,
 	struct work_struct *work = &dwork->work;
 
 	WARN_ON_ONCE(!wq);
-	WARN_ON_ONCE(timer->function != delayed_work_timer_fn);
+	WARN_ON_FUNCTION_MISMATCH(timer->function, delayed_work_timer_fn);
 	WARN_ON_ONCE(timer_pending(timer));
 	WARN_ON_ONCE(!list_empty(&work->entry));
 
-- 
2.31.0.291.g576ba9dcdaf-goog

