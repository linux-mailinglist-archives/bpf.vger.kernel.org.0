Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D123523C6
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 01:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbhDAXc6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Apr 2021 19:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbhDAXcm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Apr 2021 19:32:42 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5783DC0613AD
        for <bpf@vger.kernel.org>; Thu,  1 Apr 2021 16:32:31 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id c7so4787200qka.6
        for <bpf@vger.kernel.org>; Thu, 01 Apr 2021 16:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tlln/25B+ozo47mKEKLuW/3k00WnDy4P1m684YdZ/Ow=;
        b=I9PJaQcst1AA2ETS6/590G4TfKg0Ep8bsQ2cbMyfjHS5xq8UhhRsmhWAK+tu2t2x55
         0NtFuIk8K5pDtXCwVcd37pl+s68//3mNQqN2p1cdWbYDiroGloc/+by+12HyjzYnOoSL
         RKvKQcFvcgGK+HR5tqE6m1kYEXNOSDOHCEX3fSDHf37zYWS3akmQhn26c+Htiuc0NuYi
         ou95Oe6lnhSX4vo2uj8bCtxivlv23dudi+7Kha/5EdrctbTy1D8VVWzskjNGCVJvfrMd
         vHnoHMDSyRM9d19iFayhiuQLcLIicahV73gGrmw1mAPFGWM7Xjh+e1FXoaKN18jptkUb
         pHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tlln/25B+ozo47mKEKLuW/3k00WnDy4P1m684YdZ/Ow=;
        b=Vc97QuLADjsy2seecPzRSPt2Cx/FrEn88QBfQbm61EzJ6EE18jH0MF/jGTKY9MaXvS
         5kZP5dPQ69Olg+G+1rSiOkiid72nzN2NBjpoRrXi/Ct9A/zI9u/6VHLbhYLcklWZ9ZDu
         CQz7f8xCx6sjm2oz2yEmGdrG1w4OV2PRbId/Xs+tpYJQFAXHqZmDcuslRkVCnnynidX5
         vI3pczCzkafi8LsBgba4HuXpGGSbogH+nygbPgurWh1x2ffv9G/dVZLzAaXm2REB6Szq
         xYK12gm4hTt8oVUyNgJEtURBprmjt+Ip9i6aHfqKAhequmcdXm/UNAmV+XCwdV86J3qz
         coeA==
X-Gm-Message-State: AOAM530dg0EfhEFNbvzEsDD1Zm7orptcnJ1QE2Ktlgtw0lStMoVDjlLV
        sYeP82D4xbdel5VycbhDJNjGmr7QvUnjd/1fuhA=
X-Google-Smtp-Source: ABdhPJz/X0PEVpr/ZwvbdQjB/6/K4fz2DLIK7q77l9s2bkAG68SaZ5M6cDCU7TSFkXXLkjmF7UE5IcmwZNcH7EfoOvo=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:4cd1:da86:e91b:70b4])
 (user=samitolvanen job=sendgmr) by 2002:a0c:c243:: with SMTP id
 w3mr82666qvh.34.1617319950529; Thu, 01 Apr 2021 16:32:30 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:32:04 -0700
In-Reply-To: <20210401233216.2540591-1-samitolvanen@google.com>
Message-Id: <20210401233216.2540591-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210401233216.2540591-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 06/18] kthread: use WARN_ON_FUNCTION_MISMATCH
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

With CONFIG_CFI_CLANG, a callback function passed to
__kthread_queue_delayed_work from a module points to a jump table
entry defined in the module instead of the one used in the core
kernel, which breaks function address equality in this check:

  WARN_ON_ONCE(timer->function != ktead_delayed_work_timer_fn);

Use WARN_ON_FUNCTION_MISMATCH() instead to disable the warning
when CFI and modules are both enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
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
2.31.0.208.g409f899ff0-goog

