Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909BE346A3E
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 21:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbhCWUkj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 16:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbhCWUkK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Mar 2021 16:40:10 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A3DC0613D8
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 13:40:09 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id o14so1724qvn.18
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 13:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bxVrKYuxs5XU9fnnKC3lGs6PXwAVYnFmVHHh5prD+bw=;
        b=tT+mhGxcn72LL+S/wxj6p6pgongKWrRuo4s35bHXpLA2dicqXg5urUYbPt3d9T/ByR
         IPHjRKTiXQnv2rbt1aRKlxrdR2rPLJ7tORytyy1drMdPlsn4xgMEb2VaXi9KnmRXw0b+
         1McGQM2Thg4csg/H4j9okV5jZZhUrLRSHuFW27uwZsHK3LpCc5+cy7/TMp0EDcRjnuha
         JF7+v1vVLu+/0lrJCTHtkCwIx8QFpif22GcIKNGwCbR4j/Je8b9blw7GwduI3m2NOHlM
         YfgJo/D20uuFbhQvjr6gzbOj6Nv05LUXHIHdnyfSlGGvEfwFsp60pVuwWb09eTm3iH6Q
         VSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bxVrKYuxs5XU9fnnKC3lGs6PXwAVYnFmVHHh5prD+bw=;
        b=O2NsgKkNtvtFKGpbmnUyo7h/PohhY4N/FoQT4O3QMpA6yoqmhcsfIFSMpChurSLeIl
         WOPxbD254g8l4FYmwdwWUX5Kv9J6wCXv+V3QntrrQYLdsqWOnfZsnbxmzwx4FeEG39um
         C0t2Rf2eop00PZ4FWunHo/hXSw11LDDkfHgHRORmMjFvi6eHQt9Uo+9/f075xQJBSEMF
         WljG04NPo3rsscI4Qk9KGLQWv+jnv1ur/tND8b29VJza0mTJCehrZs0khRmznuDqzu4W
         4KbHYOiMrAjqsgmIJNqal8yuVBl4oRjFpKSZPv7IV1xZgdKlDp6t9p6eqtSf0dpwSR5d
         r5xQ==
X-Gm-Message-State: AOAM5324CCusP1YfpYTX7cUCpaiq+mY6AaKnDxaWWH9+9BO3wcFL81Mf
        b2PyZC/mDQD8jzFIkWU04c2Rt1lOiZd+J4ydJtU=
X-Google-Smtp-Source: ABdhPJx9XxcfFaPwjV0eKcB1u5Is4MdpwwvMvMA5rF3C3ca6pKmdXd3MtbY+z05x6lmX/nx6Kd3vneHRgp5+amu1pQk=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e9a3:260d:763b:67dc])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:aae:: with SMTP id
 ew14mr188842qvb.24.1616532008942; Tue, 23 Mar 2021 13:40:08 -0700 (PDT)
Date:   Tue, 23 Mar 2021 13:39:40 -0700
In-Reply-To: <20210323203946.2159693-1-samitolvanen@google.com>
Message-Id: <20210323203946.2159693-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210323203946.2159693-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3 11/17] psci: use __pa_function for cpu_resume
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

With CONFIG_CFI_CLANG, the compiler replaces function pointers with
jump table addresses, which results in __pa_symbol returning the
physical address of the jump table entry. As the jump table contains
an immediate jump to an EL1 virtual address, this typically won't
work as intended. Use __pa_function instead to get the address to
cpu_resume.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 drivers/firmware/psci/psci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index f5fc429cae3f..facd3cce3244 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -326,7 +326,7 @@ static int psci_suspend_finisher(unsigned long state)
 {
 	u32 power_state = state;
 
-	return psci_ops.cpu_suspend(power_state, __pa_symbol(cpu_resume));
+	return psci_ops.cpu_suspend(power_state, __pa_function(cpu_resume));
 }
 
 int psci_cpu_suspend_enter(u32 state)
@@ -345,7 +345,7 @@ int psci_cpu_suspend_enter(u32 state)
 static int psci_system_suspend(unsigned long unused)
 {
 	return invoke_psci_fn(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND),
-			      __pa_symbol(cpu_resume), 0, 0);
+			      __pa_function(cpu_resume), 0, 0);
 }
 
 static int psci_system_suspend_enter(suspend_state_t state)
-- 
2.31.0.291.g576ba9dcdaf-goog

