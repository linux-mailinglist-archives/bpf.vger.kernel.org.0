Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5B6346A26
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 21:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbhCWUkg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 16:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbhCWUj7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Mar 2021 16:39:59 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA79CC0613DD
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 13:39:58 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id g18so119803qki.15
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 13:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EKy6eSpRty5bSmZbwR30NkKAGzsTESRLoXrAS0NLKzs=;
        b=SHiuDwK39cZpUPhp4hdoHOuGGDuRvdgVruquA5OhzT20BoTxNAsr9v4IssAUSm++Wu
         Gdigd5fbbNiaLy/ry4ApwbLMVFLE/K8FS9T8hHmeF+HMjwCwC1pX53Mm0BNeat42pW6A
         vudqk7VvICGdH7ZzkH/77tQzcGfMs8BokGif9s1iaTr4/OXPToVBkScJWmDX17YliXvx
         qqE/rODtG05P0dv7CE4/9UcCl0G27AKyydISoJgw84bjphFaaOWXGCFldHhaDhA0vXjv
         6uLVLqt6EaTZd1uB/NSBl+SDtBiFuBudKFH8Sf5XHxGzWkbtxux1it75UPI4B3F4MoBR
         bzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EKy6eSpRty5bSmZbwR30NkKAGzsTESRLoXrAS0NLKzs=;
        b=MgxvhL/L4WJ1Cax081hVr9wqk5p2OZT+HrG7TPTlSNRt38fdzP/r6YUKyUNY0RPIKK
         LrI/tsGgnBVpuiDpoABYeJtcNpBByhhk6CY5rLEYGTAVFudincGJy3nT/LjFEG/RNw4r
         oaoyLDN1ebNlX4xaKEln2YKwckosoGlW0oTn8SmCtWCUtTbiyryzbybqt8dS2m7L7An1
         /tIPN7NyHYHf0J1r/OclaWoVaqfalVgKmtMmETEeDj8AjOCdvIGizg4E8hFvw9QC1Y/c
         Nu+bQ8o21YBV+if8f2LU61Zy24zKpafuMD/zAJODc6Kq/ytZjubDLHlL7tcvnmuHPLrE
         QcJg==
X-Gm-Message-State: AOAM53258+UcISVAmuYW+9GIHZJ5D2bMhVtTtM6/Rvjkl/+omVi4+lWE
        jYUvZOBm5sjZUouUVVyLmlTRpyUmIxfrw3tCWBw=
X-Google-Smtp-Source: ABdhPJzHeOXxkC8OlUHUZt0DqSgHN9t2rhpi+pE22x1dKho2TmMlfck6McMlcAxQskeb4L29PcbGG9gfenN7WPTbeOU=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e9a3:260d:763b:67dc])
 (user=samitolvanen job=sendgmr) by 2002:ad4:5887:: with SMTP id
 dz7mr198051qvb.12.1616531998043; Tue, 23 Mar 2021 13:39:58 -0700 (PDT)
Date:   Tue, 23 Mar 2021 13:39:34 -0700
In-Reply-To: <20210323203946.2159693-1-samitolvanen@google.com>
Message-Id: <20210323203946.2159693-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210323203946.2159693-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3 05/17] workqueue: use WARN_ON_FUNCTION_MISMATCH
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
__queue_delayed_work from a module points to a jump table entry
defined in the module instead of the one used in the core kernel,
which breaks function address equality in this check:

  WARN_ON_ONCE(timer->function != delayed_work_timer_fn);

Use WARN_ON_FUNCTION_MISMATCH() instead to disable the warning
when CFI and modules are both enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
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

