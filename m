Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD123382AF
	for <lists+bpf@lfdr.de>; Fri, 12 Mar 2021 01:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhCLAtw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Mar 2021 19:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbhCLAtk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Mar 2021 19:49:40 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5AFC061762
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 16:49:39 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v6so27684306ybk.9
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 16:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hZWFZEGgf1oZzErhLvCwgFyCsdD04UtwuSm9OP/0yUI=;
        b=Myro43SMeYOTa+WlzxzudU7eRPbu2ZVl8J8nRnzEoOQCBBm3PCLLf2sU0IZZ/5wdgL
         6s09Ubalx38FLGVf/eCIGLb6Fxk2xPluM7RNfSrZrKf+QEf6uwB3e7Ls8xTHhADuegJ+
         VaUEyy4XM4BSfLzqZRkrTc113UMZizSYNcaTtog7go6NGMN7gQJLW3mihenOtsxEfPZ5
         aviGLWHZKCqpW+v9kwflw4luMiyATlEPkHjoQvPYiajbHGXL5cibGvRvQG4F/KjJisJK
         9I9zahguY2brjGuGSwZC71bTjTKJ24MgzucykCVAS+x/TR9IPmmraiKlc5G5TBTtt+pN
         eQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hZWFZEGgf1oZzErhLvCwgFyCsdD04UtwuSm9OP/0yUI=;
        b=Ib3+oP7vn6gyuJYlEfEH+FRxKVtQgyWFeZjPT/PIFMu6Q5EfrVa6z9akE2s0cChmHW
         PPPPjJvX/05g+F3dbrnrrMKoOJ+iQg51cXOn4LPqFdyoJP0rL4MBNfIyMDx/1Rw7Lq6L
         FzPvqc6TsPzicuSDwxAhDHrzRl20ugPr2QfAmOXxP5iXb/8371DMkihXpai+u26f+xyP
         HfXotj8mkpsmNQ00BCvR3HwUAaQUUUN5fvOVZmnGvccwkSwi6HUT2HDMajzM8kxbRaew
         GuLUKY/PK8fUQH+5gKyDf/kBh51ILEi+4TF7Rl91KbUqSo1yvwjuoEXjiNg+ZzHD7Rn5
         t+Gw==
X-Gm-Message-State: AOAM5303i0Hg1Dv33HEDKy+mjZf6AwVByzBxPGYBWgxr1H1E+8JdGR96
        TpkMeVlovxgLGs5JxF+VUUuLzyjTPbbzdlVDHrg=
X-Google-Smtp-Source: ABdhPJyUTzKzhlJJScc7b96k8P6UFF7tfvUlrsyiNN1iQd9CLMxgBI+ybk0/Hoqr01MMDE6QMpxcpK7+1qa3BIyQYDc=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c86b:8269:af92:55a])
 (user=samitolvanen job=sendgmr) by 2002:a25:880c:: with SMTP id
 c12mr15536827ybl.399.1615510179139; Thu, 11 Mar 2021 16:49:39 -0800 (PST)
Date:   Thu, 11 Mar 2021 16:49:12 -0800
In-Reply-To: <20210312004919.669614-1-samitolvanen@google.com>
Message-Id: <20210312004919.669614-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210312004919.669614-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 10/17] lkdtm: use __va_function
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

To ensure we take the actual address of a function in kernel text, use
__va_function. Otherwise, with CONFIG_CFI_CLANG, the compiler replaces
the address with a pointer to the CFI jump table, which is actually in
the module when compiled with CONFIG_LKDTM=m.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 drivers/misc/lkdtm/usercopy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
index 109e8d4302c1..d173d6175c87 100644
--- a/drivers/misc/lkdtm/usercopy.c
+++ b/drivers/misc/lkdtm/usercopy.c
@@ -314,7 +314,7 @@ void lkdtm_USERCOPY_KERNEL(void)
 
 	pr_info("attempting bad copy_to_user from kernel text: %px\n",
 		vm_mmap);
-	if (copy_to_user((void __user *)user_addr, vm_mmap,
+	if (copy_to_user((void __user *)user_addr, __va_function(vm_mmap),
 			 unconst + PAGE_SIZE)) {
 		pr_warn("copy_to_user failed, but lacked Oops\n");
 		goto free_user;
-- 
2.31.0.rc2.261.g7f71774620-goog

