Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B86B3382A9
	for <lists+bpf@lfdr.de>; Fri, 12 Mar 2021 01:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhCLAtt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Mar 2021 19:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbhCLAta (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Mar 2021 19:49:30 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BF3C061761
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 16:49:30 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id dz17so16439592qvb.14
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 16:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2z/Ob1KBSYIAdbfAk0R8ty/tB7fYk5G7Uqr3Tkugs0A=;
        b=HXPIDqa3ilGnJfXXoaPlqtVCFft699aj6X1ZgyB1edbMPQPGqWRvnSWZM4YgmX9SfS
         3ai3WwuU9qOd0PYVJS9vjneegm7E54NnFeGwEOCUHbNdHvUn2KYwFAWWD7Pxy3fIn3E/
         Xfc3wWCi1FV1pTsSPX5eZF1qhXdNrnpKo0UFrfSlSrezhbnHE7WrcLiWsJy6Z1imXMmE
         pl1XcbcWcj4yrpQwP/dZH8xKo9yLMRnz8bwEcH3ft5LkLXj253WTgB0wfiVs3cKNmE17
         K0+LGQopZnN8pk84JQhOYLnPPcleS7MhWgmP9inB9s0BQW9FAKFgH6iAODcOkHJeB8Ze
         fIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2z/Ob1KBSYIAdbfAk0R8ty/tB7fYk5G7Uqr3Tkugs0A=;
        b=JDXNl69hM2eoDM5t4Qkk3he7AROzr3/USPVx6e+ykN0Vk3lsEQ7NGq8DLsQXKBwMq9
         SFo63Qn33g22lIq+7lONGV881yyqfZCyZJJsQ50VMTTbEsveFwzkTV4FyVnieAnhSGle
         oN1cNNpeMNQURWEBtyyD6CwVof4V6dl+IWLbR4Y3PhAQOP2iwZ86ZHjYGksqYK5Vt0tr
         G/E3kc8p4Jd/g53Z/XDWDMcKPLFYVfAods4w6QhwdJS1/GUh0ymIffYbn6ovpmCRO5r0
         qc0KXzYroGw1CXH7BC+YNlpJcX1Tu/bCPfUzYPrK0tzGa7bQb8QVdMO4Hq1w6IrFBSeR
         V7sQ==
X-Gm-Message-State: AOAM530ZN/crLnL82HPwUTVCfM2sQmK+G/U4dya49IVPuR8HLyKM8NGj
        LH/sfQS3/sfV7HwqCToDy+yhWngoOLLjypwD3qg=
X-Google-Smtp-Source: ABdhPJxHDKETbYeoueGPafrW3BI4Uh5lPSvgOdjIw/MXWNb4TTLYLuJccKyo+tYRBmtObEJFt+syMJh09rwfHBLme60=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c86b:8269:af92:55a])
 (user=samitolvanen job=sendgmr) by 2002:ad4:5887:: with SMTP id
 dz7mr10214152qvb.12.1615510169805; Thu, 11 Mar 2021 16:49:29 -0800 (PST)
Date:   Thu, 11 Mar 2021 16:49:07 -0800
In-Reply-To: <20210312004919.669614-1-samitolvanen@google.com>
Message-Id: <20210312004919.669614-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210312004919.669614-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 05/17] workqueue: cfi: disable callback pointer check with modules
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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

Disable the warning when CFI and modules are enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 kernel/workqueue.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0d150da252e8..4db267e5ad2d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1630,7 +1630,14 @@ static void __queue_delayed_work(int cpu, struct workqueue_struct *wq,
 	struct work_struct *work = &dwork->work;
 
 	WARN_ON_ONCE(!wq);
-	WARN_ON_ONCE(timer->function != delayed_work_timer_fn);
+	/*
+	 * With CFI, timer->function can point to a jump table entry in a module,
+	 * which fails the comparison. Disable the warning if CFI and modules are
+	 * both enabled.
+	 */
+	if (!IS_ENABLED(CONFIG_CFI_CLANG) || !IS_ENABLED(CONFIG_MODULES))
+		WARN_ON_ONCE(timer->function != delayed_work_timer_fn);
+
 	WARN_ON_ONCE(timer_pending(timer));
 	WARN_ON_ONCE(!list_empty(&work->entry));
 
-- 
2.31.0.rc2.261.g7f71774620-goog

