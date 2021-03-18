Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8DD340B37
	for <lists+bpf@lfdr.de>; Thu, 18 Mar 2021 18:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbhCRRLo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 13:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbhCRRL3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Mar 2021 13:11:29 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717DCC06174A
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 10:11:29 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id j26so9759500pgj.19
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 10:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kAxWBGQQ6gb1U0MwyH2aGrnOUTzFGjVGvgXGkxVH/cc=;
        b=liAOU1cNxrOdNR8Mq2wdteZcuX/4GGjEvmX6VRt8SJpT8g5c/zhTtCrqOcNoXot7R8
         p1HymEJCx3U3MjDN37R8LlebJ9vtc4QS37r5hp/DGkgrykkjdb6C0qRALyJRp89Eas+i
         1jen8r3xd9zt0zZr9UzvlAfpmAxoBZYbpK/OgNk6ZT++341DfmQovKhP11YgxnbvZlFr
         X2tspDFVyGouwBpmAV27otQ74JTSYb7fKQKADR7cZWYj2chJWJ1DBwJw5EPogGOtdPZa
         AwlGuQfVzacKapISpv2yS7Uq+JqnRv+I7YVKuASx+mIC9EZrru5DgEP2qNx7a2dWt6C4
         aL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kAxWBGQQ6gb1U0MwyH2aGrnOUTzFGjVGvgXGkxVH/cc=;
        b=UVrQ5HQIcnL+dH9ow/NI8wiM7uzbnf6wkwlrRGpP5meOVu4qJLtyPhCizY+TipuM7h
         BJ6PYJkYY6ZRsD+M+9CvQt1oroU7TBJmQBbVGAyv5OOxUVulfRrn+KfWj91pfm5JzbmD
         jqbPjqNYnVHE74oKVvrB6+Zzui6KmZhMef/gBSQmt8cBsVcOo9I2y0oHsg1Sdtd3q+3P
         9eWSi+qYMDfAR1jfAADxixVgKa42KbGeei1/7XMEwoYzWFsrM2Y99hL8qsncsyqWTrdA
         huNTxIVYaz5l558jkI1vHipUfAqLJn4yiFx1/Ob2W8jFNDoB65P3K8kBnHzTKC192G2O
         TduQ==
X-Gm-Message-State: AOAM530u99tRf+6gx7NoPpcAGuMYl7wlxit4kZMPHvPS65L4n3UGYAoK
        kvDwf4Osdms5Khi8LA7nr9GBL+WUpht+kq2jV2A=
X-Google-Smtp-Source: ABdhPJxKWbdiJmcD8GxmltL5n/GfUdjB9vzaW7o7vy1vsfJ4+SqraPewncqhBQztkA9cts228yKyAQm40viIg6HomOI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c0d7:a7ba:fb41:a35a])
 (user=samitolvanen job=sendgmr) by 2002:a17:90a:b311:: with SMTP id
 d17mr5522830pjr.228.1616087488845; Thu, 18 Mar 2021 10:11:28 -0700 (PDT)
Date:   Thu, 18 Mar 2021 10:11:00 -0700
In-Reply-To: <20210318171111.706303-1-samitolvanen@google.com>
Message-Id: <20210318171111.706303-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 06/17] kthread: use WARN_ON_FUNCTION_MISMATCH
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

With CONFIG_CFI_CLANG, a callback function passed to
__kthread_queue_delayed_work from a module points to a jump table
entry defined in the module instead of the one used in the core
kernel, which breaks function address equality in this check:

  WARN_ON_ONCE(timer->function != ktead_delayed_work_timer_fn);

Use WARN_ON_FUNCTION_MISMATCH() instead to disable the warning
when CFI and modules are both enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 kernel/kthread.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 1578973c5740..a1972eba2917 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -963,7 +963,8 @@ static void __kthread_queue_delayed_work(struct kthread_worker *worker,
 	struct timer_list *timer = &dwork->timer;
 	struct kthread_work *work = &dwork->work;
 
-	WARN_ON_ONCE(timer->function != kthread_delayed_work_timer_fn);
+	WARN_ON_FUNCTION_MISMATCH(timer->function,
+				  kthread_delayed_work_timer_fn);
 
 	/*
 	 * If @delay is 0, queue @dwork->work immediately.  This is for
-- 
2.31.0.291.g576ba9dcdaf-goog

