Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7AD3346A17
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 21:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbhCWUkd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 16:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbhCWUkB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Mar 2021 16:40:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E84C0613DF
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 13:40:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u128so3794668ybf.12
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 13:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kAxWBGQQ6gb1U0MwyH2aGrnOUTzFGjVGvgXGkxVH/cc=;
        b=obb/St0ECVpiVYPjl0tFmSeAu+nwHW6a+FyVf5Y93kL0zciJ7OpXo5pz5/5qK+sMFf
         HVCB7lPNLLCcgrreAMPMIq89DUCTawBOwNPUPSIBya5VRwan8cbfXQx100+5xN/Qkd+t
         DrRy/pbSThpGxZ1QzI4eyYQAJqKt5nt14oxKeAqxjwjAb66eROjyJZpq+iXVKnIt1UeO
         qE3Het9/jgbk33l/79gSOA0M2UKmfHun8/qcQ5XwaA/WAB2nFQGlLlfTzyIcIhj7o/5V
         IAm35WHoPPYpvmYzDW1CTc/YgvwTLIfoZ+x6jtjFf4U8j7x1w0Jt0fXDFRfY/dN/7g6Y
         zgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kAxWBGQQ6gb1U0MwyH2aGrnOUTzFGjVGvgXGkxVH/cc=;
        b=hcRlyVR/yKi95OEN6qmH2+HnRrCySEOg1wIP47UZj2OtV67FaSLDdW/n9m8O2lVOLV
         m4czLbBcx8nfc0xkGeszPb9s3aDiGxqh3zlGZQdds86tSbuNQZ6ZprlZeyVqxRTUmYuU
         EObqjSms06hxWz/xgRCbvw15GYLzxWrFGjrHmBCLDTYy21cRGcQpz26mOv9BwrYVNySs
         sdEh/1T1zFPA90MWRgBxIGhbJvZ31qk5zSUQTJnHEw5owXr291UDctYUnIopSZ4gZX0t
         ZnCIGxU2oKleF9r3zWluHPV1orVDzWmKyzdipzrbGHAsUYDOPsg0VNMh79CIqQIHxI1Y
         vopQ==
X-Gm-Message-State: AOAM531aJpaHBHz8W0mjAJ4q1OzrraKg0tqZBuCI1gN2bicq2mB8Bf7i
        ORBNESGbrw1RlUAR6wZz17mw+2fKNTmZZOHvlWQ=
X-Google-Smtp-Source: ABdhPJy06lzastyLa7rjZrqrKe8Kw6vypE8VYVF9BzE0zOiJRLohmqAfcSnsVJk7XWpS4yGsr/w/V3cRXxwJCIzEtGs=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e9a3:260d:763b:67dc])
 (user=samitolvanen job=sendgmr) by 2002:a25:e008:: with SMTP id
 x8mr147121ybg.90.1616531999835; Tue, 23 Mar 2021 13:39:59 -0700 (PDT)
Date:   Tue, 23 Mar 2021 13:39:35 -0700
In-Reply-To: <20210323203946.2159693-1-samitolvanen@google.com>
Message-Id: <20210323203946.2159693-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210323203946.2159693-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3 06/17] kthread: use WARN_ON_FUNCTION_MISMATCH
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

